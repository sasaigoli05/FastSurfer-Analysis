\n\n#---------------------------------
# New invocation of recon-all Fri Jun 14 15:41:13 EDT 2024 
#--------------------------------------
#@# Merge ASeg Fri Jun 14 15:41:23 EDT 2024
\n cp aseg.auto.mgz aseg.presurf.mgz \n
#--------------------------------------------
#@# Intensity Normalization2 Fri Jun 14 15:41:23 EDT 2024
\n mri_normalize -seed 1234 -mprage -aseg aseg.presurf.mgz -mask brainmask.mgz norm.mgz brain.mgz \n
#--------------------------------------------
#@# Mask BFS Fri Jun 14 15:43:28 EDT 2024
\n mri_mask -T 5 brain.mgz brainmask.mgz brain.finalsurfs.mgz \n
#--------------------------------------------
#@# WM Segmentation Fri Jun 14 15:43:29 EDT 2024
\n AntsDenoiseImageFs -i brain.mgz -o antsdn.brain.mgz \n
\n mri_segment -wsizemm 13 -mprage antsdn.brain.mgz wm.seg.mgz \n
\n mri_edit_wm_with_aseg -keep-in wm.seg.mgz brain.mgz aseg.presurf.mgz wm.asegedit.mgz \n
\n mri_pretess wm.asegedit.mgz wm norm.mgz wm.mgz \n
#--------------------------------------------
#@# Fill Fri Jun 14 15:45:21 EDT 2024
\n mri_fill -a ../scripts/ponscc.cut.log -xform transforms/talairach.lta -segmentation aseg.presurf.mgz -ctab /Applications/freesurfer/7.4.1/SubCorticalMassLUT.txt wm.mgz filled.mgz \n
 cp filled.mgz filled.auto.mgz
\n\n#---------------------------------
\n\n#---------------------------------
# New invocation of recon-all Fri Jun 14 15:46:31 EDT 2024 
# New invocation of recon-all Fri Jun 14 15:46:31 EDT 2024 
#--------------------------------------------
#--------------------------------------------
#@# Inflation1 rh Fri Jun 14 15:46:34 EDT 2024
#@# Inflation1 lh Fri Jun 14 15:46:34 EDT 2024
\n mris_inflate -no-save-sulc ../surf/rh.smoothwm.nofix ../surf/rh.inflated.nofix \n
\n mris_inflate -no-save-sulc ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix \n
\n\n#---------------------------------
\n\n#---------------------------------
# New invocation of recon-all Fri Jun 14 15:46:57 EDT 2024 
# New invocation of recon-all Fri Jun 14 15:46:57 EDT 2024 
#--------------------------------------------
#@# QSphere lh Fri Jun 14 15:46:59 EDT 2024
\n mris_sphere -q -p 6 -a 128 -seed 1234 ../surf/lh.inflated.nofix ../surf/lh.qsphere.nofix \n
#--------------------------------------------
#@# QSphere rh Fri Jun 14 15:46:59 EDT 2024
\n mris_sphere -q -p 6 -a 128 -seed 1234 ../surf/rh.inflated.nofix ../surf/rh.qsphere.nofix \n
\n\n#---------------------------------
# New invocation of recon-all Fri Jun 14 15:49:54 EDT 2024 
#@# Fix Topology lh Fri Jun 14 15:49:56 EDT 2024
\n mris_fix_topology -mgz -sphere qsphere.nofix -inflated inflated.nofix -orig orig.nofix -out orig.premesh -ga -seed 1234 subjectx_3 lh \n
\n\n#---------------------------------
# New invocation of recon-all Fri Jun 14 15:49:58 EDT 2024 
#@# Fix Topology rh Fri Jun 14 15:50:00 EDT 2024
\n mris_fix_topology -mgz -sphere qsphere.nofix -inflated inflated.nofix -orig orig.nofix -out orig.premesh -ga -seed 1234 subjectx_3 rh \n
\n mris_euler_number ../surf/rh.orig.premesh \n
\n mris_remesh --remesh --iters 3 --input /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/subjectx_3/surf/rh.orig.premesh --output /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/subjectx_3/surf/rh.orig \n
\n mris_remove_intersection ../surf/rh.orig ../surf/rh.orig \n
\n rm -f ../surf/rh.inflated \n
#--------------------------------------------
#@# AutoDetGWStats rh Fri Jun 14 15:51:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/subjectx_3/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.rh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/rh.orig.premesh
#--------------------------------------------
#@# WhitePreAparc rh Fri Jun 14 15:51:30 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/subjectx_3/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.rh.dat --wm wm.mgz --threads 4 --invol brain.finalsurfs.mgz --rh --i ../surf/rh.orig --o ../surf/rh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
\n mris_euler_number ../surf/lh.orig.premesh \n
\n mris_remesh --remesh --iters 3 --input /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/subjectx_3/surf/lh.orig.premesh --output /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/subjectx_3/surf/lh.orig \n
\n mris_remove_intersection ../surf/lh.orig ../surf/lh.orig \n
\n rm -f ../surf/lh.inflated \n
#--------------------------------------------
#@# AutoDetGWStats lh Fri Jun 14 15:52:39 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/subjectx_3/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.lh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/lh.orig.premesh
#--------------------------------------------
#@# WhitePreAparc lh Fri Jun 14 15:52:43 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/subjectx_3/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --wm wm.mgz --threads 4 --invol brain.finalsurfs.mgz --lh --i ../surf/lh.orig --o ../surf/lh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
#--------------------------------------------
#@# CortexLabel rh Fri Jun 14 15:55:15 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/subjectx_3/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 0 ../label/rh.cortex.label
#--------------------------------------------
#@# CortexLabel+HipAmyg rh Fri Jun 14 15:55:33 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/subjectx_3/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 1 ../label/rh.cortex+hipamyg.label
\n\n#---------------------------------
# New invocation of recon-all Fri Jun 14 15:55:52 EDT 2024 
#--------------------------------------------
#@# Smooth2 rh Fri Jun 14 15:55:54 EDT 2024
\n mris_smooth -n 3 -nw -seed 1234 ../surf/rh.white.preaparc ../surf/rh.smoothwm \n
#--------------------------------------------
#@# Inflation2 rh Fri Jun 14 15:55:57 EDT 2024
\n mris_inflate ../surf/rh.smoothwm ../surf/rh.inflated \n
#--------------------------------------------
#@# Curv .H and .K rh Fri Jun 14 15:56:24 EDT 2024
\n mris_curvature -w -seed 1234 rh.white.preaparc \n
#--------------------------------------------
#@# CortexLabel lh Fri Jun 14 15:56:24 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/subjectx_3/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 0 ../label/lh.cortex.label
\n mris_curvature -seed 1234 -thresh .999 -n -a 5 -w -distances 10 10 rh.inflated \n
#--------------------------------------------
#@# CortexLabel+HipAmyg lh Fri Jun 14 15:56:44 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/subjectx_3/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 1 ../label/lh.cortex+hipamyg.label
\n\n#---------------------------------
# New invocation of recon-all Fri Jun 14 15:57:03 EDT 2024 
#--------------------------------------------
#@# Smooth2 lh Fri Jun 14 15:57:05 EDT 2024
\n mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm \n
#--------------------------------------------
#@# Inflation2 lh Fri Jun 14 15:57:08 EDT 2024
\n mris_inflate ../surf/lh.smoothwm ../surf/lh.inflated \n
#--------------------------------------------
#@# Curv .H and .K lh Fri Jun 14 15:57:32 EDT 2024
\n mris_curvature -w -seed 1234 lh.white.preaparc \n
\n mris_curvature -seed 1234 -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated \n
