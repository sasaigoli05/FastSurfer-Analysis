import nibabel as nib
import numpy as np
import matplotlib.pyplot as plt

def visualize_and_measure_frontal_horns(segmentation_path, lv_labels=[4, 43], slice_axis=1, num_intervals=10):
    # Load the segmentation file
    seg_img = nib.load(segmentation_path)
    seg_data = seg_img.get_fdata()

    # Find the coordinates of the lateral ventricles
    lv_coords = np.argwhere(np.isin(seg_data, lv_labels))
    
    if lv_coords.size == 0:
        print("No lateral ventricles found.")
        return
    
    # Determine the total number of slices along the specified axis
    num_slices = seg_data.shape[slice_axis]
    print(f"Total number of slices along axis {slice_axis}: {num_slices}")

    # Generate a list of slices at equal intervals
    slice_range = np.linspace(0, num_slices - 1, num_intervals, dtype=int)
    print(f"Selected slice indices: {slice_range}")

    for slice_idx in slice_range:
        # Extract the slice
        if slice_axis == 0:
            slice_data = seg_data[slice_idx, :, :]
        elif slice_axis == 1:
            slice_data = seg_data[:, slice_idx, :]
        else:
            slice_data = seg_data[:, :, slice_idx]

        # Find the coordinates of the lateral ventricles in this slice
        if slice_axis == 0:
            slice_lv_coords = lv_coords[lv_coords[:, 0] == slice_idx][:, 1:]
        elif slice_axis == 1:
            slice_lv_coords = lv_coords[lv_coords[:, 1] == slice_idx][:, [0, 2]]
        else:
            slice_lv_coords = lv_coords[lv_coords[:, 2] == slice_idx][:, :2]

        # Check if there are enough points to consider this slice
        if slice_lv_coords.shape[0] < 2:
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
        max_distance = 0
        best_coords = None
        for y in y_unique:
            y_points = upper_lv_coords[upper_lv_coords[:, 1] == y]
            if y_points.shape[0] < 2:
                continue

            # Calculate the horizontal distance between points in this row
            x_coords = y_points[:, 0]
            dist = np.max(x_coords) - np.min(x_coords)
            
            if dist > max_distance:
                max_distance = dist
                best_coords = np.array([[np.min(x_coords), y], [np.max(x_coords), y]])

        if best_coords is not None:
            # Plot the slice
            plt.figure(figsize=(8, 8))
            plt.imshow(slice_data.T, cmap='gray', origin='lower')

            # Highlight the lateral ventricles
            plt.scatter(upper_lv_coords[:, 0], upper_lv_coords[:, 1], c='red', s=1, label='Lateral Ventricles')

            # Highlight the maximum width points
            plt.scatter(best_coords[:, 0], best_coords[:, 1], c='yellow', s=10, label='Max Width Points')
            plt.plot(best_coords[:, 0], best_coords[:, 1], c='yellow')

            plt.title(f'Lateral Ventricles in Slice {slice_idx}\nMax Width: {max_distance:.2f} mm')
            plt.legend()
            plt.show()

            print(f'Maximum width of frontal horns in slice {slice_idx}: {max_distance:.2f} mm')
        else:
            print(f"No suitable slice found with lateral ventricles in slice {slice_idx}.")

# Example usage
segmentation_path = '/Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/aparc.DKTatlas+aseg.deep.mgz'
visualize_and_measure_frontal_horns(segmentation_path, num_intervals=10)
