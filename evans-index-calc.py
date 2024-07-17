import nibabel as nib
import numpy as np
import matplotlib.pyplot as plt
from skimage.measure import find_contours

def visualize_and_measure_frontal_horns_and_brain_contours(segmentation_path, lv_labels=[4, 43], brain_labels=[2, 41], slice_axis=1, num_intervals=10):
    # Load the segmentation file
    seg_img = nib.load(segmentation_path)
    seg_data = seg_img.get_fdata()

    # Find the coordinates of the lateral ventricles
    lv_coords = np.argwhere(np.isin(seg_data, lv_labels))
    
    if lv_coords.size == 0:
        print("No lateral ventricles found.")
        return
    
    # Find the coordinates of the brain regions
    brain_coords = np.argwhere(np.isin(seg_data, brain_labels))
    
    if brain_coords.size == 0:
        print("No brain regions found.")
        return
    
    # Determine the total number of slices along the specified axis
    num_slices = seg_data.shape[slice_axis]
    print(f"Total number of slices along axis {slice_axis}: {num_slices}")

    # Generate a list of slices at equal intervals
    slice_range = np.linspace(0, num_slices - 1, num_intervals, dtype=int)
    print(f"Selected slice indices: {slice_range}")

    max_lv_distance = 0
    max_brain_distance = 0
    best_slice_idx = None
    best_lv_coords = None
    best_brain_coords = None

    for slice_idx in slice_range:
        # Extract the slice
        if slice_axis == 0:
            slice_data = seg_data[slice_idx, :, :]
        elif slice_axis == 1:
            slice_data = seg_data[:, slice_idx, :]
        else:
            slice_data = seg_data[:, :, slice_idx]

        # Find the coordinates of the lateral ventricles and brain regions in this slice
        if slice_axis == 0:
            slice_lv_coords = lv_coords[lv_coords[:, 0] == slice_idx][:, 1:]
            slice_brain_coords = brain_coords[brain_coords[:, 0] == slice_idx][:, 1:]
        elif slice_axis == 1:
            slice_lv_coords = lv_coords[lv_coords[:, 1] == slice_idx][:, [0, 2]]
            slice_brain_coords = brain_coords[brain_coords[:, 1] == slice_idx][:, [0, 2]]
        else:
            slice_lv_coords = lv_coords[lv_coords[:, 2] == slice_idx][:, :2]
            slice_brain_coords = brain_coords[brain_coords[:, 2] == slice_idx][:, :2]

        # Check if there are enough points to consider this slice
        if slice_lv_coords.shape[0] < 2 or slice_brain_coords.shape[0] < 2:
            continue

        # Find upper and lower extremities to determine the midpoint
        max_y = slice_lv_coords[:, 1].max()
        min_y = slice_lv_coords[:, 1].min()
        midpoint_y = (max_y + min_y) / 2

        # Filter points above the midpoint
        upper_lv_coords = slice_lv_coords[slice_lv_coords[:, 1] > midpoint_y]

        # Check if there are enough points above the midpoint
        if upper_lv_coords.shape[0] < 2:
            continue

        # Group points by their y-coordinate to ensure horizontal distance measurement
        y_unique = np.unique(upper_lv_coords[:, 1])
        for y in y_unique:
            y_points = upper_lv_coords[upper_lv_coords[:, 1] == y]
            if y_points.shape[0] < 2:
                continue

            # Calculate the horizontal distance between points in this row
            x_coords = y_points[:, 0]
            dist = np.max(x_coords) - np.min(x_coords)
            
            if dist > max_lv_distance:
                max_lv_distance = dist
                y_value = y  # Y-value for horizontal measurement
                best_lv_coords = np.array([[np.min(x_coords), y_value], [np.max(x_coords), y_value]])
                best_slice_idx = slice_idx

        # Find the maximum left-right distance of the brain contours
        contours = find_contours(slice_data.T, level=0.5)
        for contour in contours:
            max_x = contour[:, 1].max()
            min_x = contour[:, 1].min()
            brain_dist = max_x - min_x
            if brain_dist > max_brain_distance:
                max_brain_distance = brain_dist
                y_value = contour[contour[:, 1] == min_x, 0][0]  # Y-value for horizontal measurement
                best_brain_coords = np.array([[min_x, y_value], [max_x, y_value]])

    # Calculate the Evans Index
    if max_brain_distance > 0:
        evans_index = max_lv_distance / max_brain_distance
    else:
        evans_index = None

    # Plot the best slice with both measurements
    if best_slice_idx is not None:
        if slice_axis == 0:
            slice_data = seg_data[best_slice_idx, :, :]
        elif slice_axis == 1:
            slice_data = seg_data[:, best_slice_idx, :]
        else:
            slice_data = seg_data[:, :, best_slice_idx]

        plt.figure(figsize=(8, 8))
        plt.imshow(slice_data.T, cmap='gray', origin='lower')

        # Highlight the lateral ventricles
        plt.scatter(upper_lv_coords[:, 0], upper_lv_coords[:, 1], c='red', s=1, label='Lateral Ventricles')

        # Highlight the maximum width points for the ventricles
        if best_lv_coords is not None:
            plt.scatter(best_lv_coords[:, 0], best_lv_coords[:, 1], c='yellow', s=10, label='Max Ventricular Width Points')
            plt.plot(best_lv_coords[:, 0], best_lv_coords[:, 1], c='yellow')

        # Highlight the maximum width points for the brain
        if best_brain_coords is not None:
            plt.scatter(best_brain_coords[:, 0], best_brain_coords[:, 1], c='blue', s=10, label='Max Brain Width Points')
            plt.plot(best_brain_coords[:, 0], best_brain_coords[:, 1], c='blue')

        title = f'Lateral Ventricles in Slice {best_slice_idx}\nMax Ventricular Width: {max_lv_distance:.2f} mm, Max Brain Width: {max_brain_distance:.2f} mm'
        if evans_index is not None:
            title += f'\nEvans Index: {evans_index:.2f}'

        plt.title(title)
        plt.legend()
        plt.show()

        print(f'Maximum width of frontal horns in slice {best_slice_idx}: {max_lv_distance:.2f} mm')
        print(f'Maximum left-to-right distance of the brain in slice {best_slice_idx}: {max_brain_distance:.2f} mm')
        if evans_index is not None:
            print(f'Evans Index: {evans_index:.2f}')
    else:
        print("No suitable slice found with both lateral ventricles and brain regions.")

# Example usage
segmentation_path = '/Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS_0001-2/OAS_0001-2/mri/aparc.DKTatlas+aseg.deep.mgz'
visualize_and_measure_frontal_horns_and_brain_contours(segmentation_path, num_intervals=10)
