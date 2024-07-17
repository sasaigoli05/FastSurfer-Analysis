# import nibabel as nib
# import numpy as np
# import matplotlib.pyplot as plt
# from skimage.measure import label, regionprops
# from scipy.ndimage import rotate

# def calculate_callosal_angle(coronal_slice):
#     print("Calculating callosal angle...")
#     # Binarize the image to segment the lateral ventricles (simplified)
#     threshold = np.mean(coronal_slice) + np.std(coronal_slice)
#     binary_slice = coronal_slice > threshold

#     # Label connected components
#     labeled_slice = label(binary_slice)

#     # Display the binary slice for verification
#     plt.imshow(binary_slice.T, cmap='gray', origin='lower')
#     plt.title("Binary Slice")
#     plt.show()

#     # Find regions corresponding to lateral ventricles
#     regions = regionprops(labeled_slice)
#     print(f"Number of regions found: {len(regions)}")

#     # Print region information for diagnosis
#     for i, region in enumerate(regions):
#         print(f"Region {i}: Area = {region.area}")

#     lateral_ventricles = [region for region in regions if region.area > 100]  # Adjust area threshold as needed

#     if len(lateral_ventricles) != 2:
#         print("Unable to identify lateral ventricles. Check the segmentation.")
#         return None

#     # Get centroids of the lateral ventricles
#     centroids = np.array([region.centroid for region in lateral_ventricles])

#     # Fit lines to the medial borders of the lateral ventricles
#     x_coords = centroids[:, 1]
#     y_coords = centroids[:, 0]
#     slope, intercept = np.polyfit(x_coords, y_coords, 1)

#     # Calculate the angle between the lines
#     angle = np.arctan(slope) * (180 / np.pi)
#     callosal_angle = 180 - 2 * angle

#     return callosal_angle

# # Load the MRI data
# mri_path = '/Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/brain.mgz'  # Update with your file path
# print(f"Loading MRI data from {mri_path}...")
# mri_img = nib.load(mri_path)
# mri_data = mri_img.get_fdata()

# # Assuming the middle slice in the coronal plane is the one of interest
# coronal_slice = mri_data[:, mri_data.shape[1] // 2, :]

# # Show the coronal slice
# plt.imshow(coronal_slice.T, cmap='gray', origin='lower')
# plt.title("Coronal Slice")
# print("Displaying coronal slice...")
# plt.show()

# callosal_angle = calculate_callosal_angle(coronal_slice)
# if callosal_angle is not None:
#     print(f"Callosal Angle: {callosal_angle} degrees")
# else:
#     print("Callosal Angle could not be calculated.")

#############################################

import numpy as np
import nibabel as nib
import matplotlib.pyplot as plt

def load_mri_data(filepath):
    return nib.load(filepath).get_fdata()

def display_coronal_slice(image_data, slice_index, title='Coronal Slice'):
    plt.figure(figsize=(6, 6))
    plt.imshow(np.rot90(image_data[:, slice_index, :]), cmap='gray')
    plt.title(title)
    plt.show()

def identify_lateral_ventricles(labeled_data):
    # FreeSurfer labels for lateral ventricles are 43 (right) and 4 (left)
    left_lateral_ventricle_label = 4
    right_lateral_ventricle_label = 43
    
    left_coords = np.argwhere(labeled_data == left_lateral_ventricle_label)
    right_coords = np.argwhere(labeled_data == right_lateral_ventricle_label)
    
    if len(left_coords) == 0 or len(right_coords) == 0:
        print("Lateral ventricles not found in the labeled data.")
        return None, None
    
    left_centroid = np.mean(left_coords, axis=0)
    right_centroid = np.mean(right_coords, axis=0)
    
    return left_centroid, right_centroid

def calculate_callosal_angle(left_centroid, right_centroid):
    if left_centroid is None or right_centroid is None:
        return None

    # Calculating the angle between the two centroids
    x1, y1, z1 = left_centroid
    x2, y2, z2 = right_centroid
    angle = np.degrees(np.arctan2(abs(y2 - y1), abs(x2 - x1)))
    
    return angle

def main():
    mri_filepath = '/Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/brain.mgz'
    labeled_filepath = '/Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/aseg.auto.mgz'
    
    print("Loading MRI data from {}...".format(mri_filepath))
    mri_data = load_mri_data(mri_filepath)
    
    print("Loading labeled data from {}...".format(labeled_filepath))
    labeled_data = load_mri_data(labeled_filepath)
    
    coronal_slice_index = labeled_data.shape[1] // 2
    print("Displaying coronal slice...")
    display_coronal_slice(mri_data, coronal_slice_index, 'MRI Coronal Slice')
    display_coronal_slice(labeled_data, coronal_slice_index, 'Labeled Coronal Slice')
    
    print("Identifying lateral ventricles...")
    left_centroid, right_centroid = identify_lateral_ventricles(labeled_data)
    
    if left_centroid is not None and right_centroid is not None:
        print(f"Left Ventricle Centroid: {left_centroid}")
        print(f"Right Ventricle Centroid: {right_centroid}")
        
        print("Calculating callosal angle...")
        callosal_angle = calculate_callosal_angle(left_centroid, right_centroid)
        if callosal_angle is not None:
            print(f"Callosal Angle: {callosal_angle} degrees")
        else:
            print("Callosal Angle could not be calculated.")
    else:
        print("Unable to identify lateral ventricles. Check the segmentation.")

if __name__ == "__main__":
    main()
