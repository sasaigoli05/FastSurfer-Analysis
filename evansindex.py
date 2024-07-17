import nibabel as nib
import numpy as np
from scipy.spatial.distance import pdist, squareform

# Load the segmentation file
segmentation_path = '/Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/aparc.DKTatlas+aseg.deep.mgz'
seg_img = nib.load(segmentation_path)
seg_data = seg_img.get_fdata()

# Debugging output
print("Segmentation data shape:", seg_data.shape)

# Labels for the structures of interest
lateral_ventricles_labels = [4, 43]  # lateral ventricles labels: left, right
skull_label = 121  # skull label

# Get the voxel coordinates for the lateral ventricles and skull
lateral_ventricles_coords = np.argwhere(np.isin(seg_data, lateral_ventricles_labels))
skull_coords = np.argwhere(seg_data == skull_label)

# Debugging output
print("Lateral ventricles coordinates shape:", lateral_ventricles_coords.shape)
print("Skull coordinates shape:", skull_coords.shape)

# Calculate pairwise distances between all points in the lateral ventricles
dist_matrix = pdist(lateral_ventricles_coords)
dist_matrix_square = squareform(dist_matrix)

# Find the maximum distance in the lateral ventricles
max_width_frontal_horns = np.max(dist_matrix_square)

# Calculate pairwise distances between all points in the skull
dist_matrix_skull = pdist(skull_coords)
dist_matrix_skull_square = squareform(dist_matrix_skull)

# Find the maximum distance in the skull
max_internal_diameter_skull = np.max(dist_matrix_skull_square)

# Calculate Evan's Index
evans_index = max_width_frontal_horns / max_internal_diameter_skull
print(f"Evan's Index: {evans_index}")
