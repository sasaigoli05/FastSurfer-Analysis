\n\n#---------------------------------
# New invocation of recon-all Sat May 18 09:51:36 EDT 2024 
\n mri_convert /Applications/freesurfer/7.4.1/subjects/bert/mri/T1.mgz /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/orig/001.mgz \n
#--------------------------------------------
#@# MotionCor Sat May 18 09:51:51 EDT 2024
\n cp /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/orig/001.mgz /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/rawavg.mgz \n
\n mri_info /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/rawavg.mgz \n
\n mri_convert /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/rawavg.mgz /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/orig.mgz --conform \n
\n mri_add_xform_to_header -c /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/transforms/talairach.xfm /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/orig.mgz /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/orig.mgz \n
\n mri_info /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/orig.mgz \n
#--------------------------------------------
#@# Talairach Sat May 18 09:51:54 EDT 2024
\n mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --ants-n4 --n 1 --proto-iters 1000 --distance 50 \n
\n talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm \n
talairach_avi log file is transforms/talairach_avi.log...
\n cp transforms/talairach.auto.xfm transforms/talairach.xfm \n
lta_convert --src orig.mgz --trg /Applications/freesurfer/7.4.1/average/mni305.cor.mgz --inxfm transforms/talairach.xfm --outlta transforms/talairach.xfm.lta --subject fsaverage --ltavox2vox
#--------------------------------------------
#@# Talairach Failure Detection Sat May 18 09:55:50 EDT 2024
\n talairach_afd -T 0.005 -xfm transforms/talairach.xfm \n
\n awk -f /Applications/freesurfer/7.4.1/bin/extract_talairach_avi_QA.awk /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/transforms/talairach_avi.log \n
\n tal_QC_AZS /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/transforms/talairach_avi.log \n
#--------------------------------------------
#@# Nu Intensity Correction Sat May 18 09:55:51 EDT 2024
\n mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 --ants-n4 \n
\n mri_add_xform_to_header -c /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri/transforms/talairach.xfm nu.mgz nu.mgz \n
#--------------------------------------------
#@# Intensity Normalization Sat May 18 09:59:45 EDT 2024
\n mri_normalize -g 1 -seed 1234 -mprage nu.mgz T1.mgz \n
#--------------------------------------------
#@# Skull Stripping Sat May 18 10:01:55 EDT 2024
\n mri_em_register -skull nu.mgz /Applications/freesurfer/7.4.1/average/RB_all_withskull_2020_01_02.gca transforms/talairach_with_skull.lta \n
\n mri_watershed -T1 -brain_atlas /Applications/freesurfer/7.4.1/average/RB_all_withskull_2020_01_02.gca transforms/talairach_with_skull.lta T1.mgz brainmask.auto.mgz \n
\n cp brainmask.auto.mgz brainmask.mgz \n
\n\n#---------------------------------
# New invocation of recon-all Sat May 18 10:45:36 EDT 2024 
#--------------------------------------
#@# Merge ASeg Sat May 18 10:45:39 EDT 2024
\n cp aseg.auto.mgz aseg.presurf.mgz \n
#--------------------------------------------
#@# Intensity Normalization2 Sat May 18 10:45:39 EDT 2024
\n mri_normalize -seed 1234 -mprage -aseg aseg.presurf.mgz -mask brainmask.mgz norm.mgz brain.mgz \n
#--------------------------------------------
#@# Mask BFS Sat May 18 10:48:45 EDT 2024
\n mri_mask -T 5 brain.mgz brainmask.mgz brain.finalsurfs.mgz \n
#--------------------------------------------
#@# WM Segmentation Sat May 18 10:48:47 EDT 2024
\n AntsDenoiseImageFs -i brain.mgz -o antsdn.brain.mgz \n
\n mri_segment -wsizemm 13 -mprage antsdn.brain.mgz wm.seg.mgz \n
\n mri_edit_wm_with_aseg -keep-in wm.seg.mgz brain.mgz aseg.presurf.mgz wm.asegedit.mgz \n
\n mri_pretess wm.asegedit.mgz wm norm.mgz wm.mgz \n
#--------------------------------------------
#@# Fill Sat May 18 10:51:56 EDT 2024
\n mri_fill -a ../scripts/ponscc.cut.log -segmentation aseg.presurf.mgz -ctab /Applications/freesurfer/7.4.1/SubCorticalMassLUT.txt wm.mgz filled.mgz \n
 cp filled.mgz filled.auto.mgz
\n\n#---------------------------------
\n\n#---------------------------------
# New invocation of recon-all Sat May 18 10:53:42 EDT 2024 
# New invocation of recon-all Sat May 18 10:53:42 EDT 2024 
#--------------------------------------------
#--------------------------------------------
#@# Inflation1 lh Sat May 18 10:53:46 EDT 2024
#@# Inflation1 rh Sat May 18 10:53:46 EDT 2024
\n mris_inflate -no-save-sulc ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix \n
\n mris_inflate -no-save-sulc ../surf/rh.smoothwm.nofix ../surf/rh.inflated.nofix \n
\n\n#---------------------------------
\n\n#---------------------------------
# New invocation of recon-all Sat May 18 10:54:14 EDT 2024 
# New invocation of recon-all Sat May 18 10:54:14 EDT 2024 
#--------------------------------------------
#@# QSphere lh Sat May 18 10:54:18 EDT 2024
\n mris_sphere -q -p 6 -a 128 -seed 1234 ../surf/lh.inflated.nofix ../surf/lh.qsphere.nofix \n
#--------------------------------------------
#@# QSphere rh Sat May 18 10:54:18 EDT 2024
\n mris_sphere -q -p 6 -a 128 -seed 1234 ../surf/rh.inflated.nofix ../surf/rh.qsphere.nofix \n
\n\n#---------------------------------
# New invocation of recon-all Sat May 18 10:58:14 EDT 2024 
#@# Fix Topology lh Sat May 18 10:58:17 EDT 2024
\n mris_fix_topology -mgz -sphere qsphere.nofix -inflated inflated.nofix -orig orig.nofix -out orig.premesh -ga -seed 1234 subjectX lh \n
\n\n#---------------------------------
# New invocation of recon-all Sat May 18 10:58:26 EDT 2024 
#@# Fix Topology rh Sat May 18 10:58:29 EDT 2024
\n mris_fix_topology -mgz -sphere qsphere.nofix -inflated inflated.nofix -orig orig.nofix -out orig.premesh -ga -seed 1234 subjectX rh \n
\n mris_euler_number ../surf/lh.orig.premesh \n
\n mris_euler_number ../surf/rh.orig.premesh \n
\n mris_remesh --remesh --iters 3 --input /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/surf/lh.orig.premesh --output /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/surf/lh.orig \n
\n mris_remesh --remesh --iters 3 --input /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/surf/rh.orig.premesh --output /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/surf/rh.orig \n
\n mris_remove_intersection ../surf/lh.orig ../surf/lh.orig \n
\n mris_remove_intersection ../surf/rh.orig ../surf/rh.orig \n
\n rm -f ../surf/lh.inflated \n
#--------------------------------------------
#@# AutoDetGWStats lh Sat May 18 11:00:50 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.lh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/lh.orig.premesh
\n rm -f ../surf/rh.inflated \n
#--------------------------------------------
#@# AutoDetGWStats rh Sat May 18 11:00:55 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.rh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/rh.orig.premesh
#--------------------------------------------
#@# WhitePreAparc lh Sat May 18 11:00:56 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --wm wm.mgz --threads 4 --invol brain.finalsurfs.mgz --lh --i ../surf/lh.orig --o ../surf/lh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
#--------------------------------------------
#@# WhitePreAparc rh Sat May 18 11:01:01 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.rh.dat --wm wm.mgz --threads 4 --invol brain.finalsurfs.mgz --rh --i ../surf/rh.orig --o ../surf/rh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
#--------------------------------------------
#@# CortexLabel lh Sat May 18 11:06:25 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 0 ../label/lh.cortex.label
#--------------------------------------------
#@# CortexLabel rh Sat May 18 11:06:55 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 0 ../label/rh.cortex.label
#--------------------------------------------
#@# CortexLabel+HipAmyg lh Sat May 18 11:07:03 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 1 ../label/lh.cortex+hipamyg.label
#--------------------------------------------
#@# CortexLabel+HipAmyg rh Sat May 18 11:07:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/subjectX/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 1 ../label/rh.cortex+hipamyg.label
\n\n#---------------------------------
# New invocation of recon-all Sat May 18 11:07:36 EDT 2024 
#--------------------------------------------
#@# Smooth2 lh Sat May 18 11:07:39 EDT 2024
\n mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm \n
#--------------------------------------------
#@# Inflation2 lh Sat May 18 11:07:46 EDT 2024
\n mris_inflate ../surf/lh.smoothwm ../surf/lh.inflated \n
\n\n#---------------------------------
# New invocation of recon-all Sat May 18 11:08:02 EDT 2024 
#--------------------------------------------
#@# Smooth2 rh Sat May 18 11:08:06 EDT 2024
\n mris_smooth -n 3 -nw -seed 1234 ../surf/rh.white.preaparc ../surf/rh.smoothwm \n
#--------------------------------------------
#@# Inflation2 rh Sat May 18 11:08:11 EDT 2024
\n mris_inflate ../surf/rh.smoothwm ../surf/rh.inflated \n
#--------------------------------------------
#@# Curv .H and .K lh Sat May 18 11:08:22 EDT 2024
\n mris_curvature -w -seed 1234 lh.white.preaparc \n
\n mris_curvature -seed 1234 -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated \n
#--------------------------------------------
#@# Curv .H and .K rh Sat May 18 11:08:48 EDT 2024
\n mris_curvature -w -seed 1234 rh.white.preaparc \n
\n mris_curvature -seed 1234 -thresh .999 -n -a 5 -w -distances 10 10 rh.inflated \n
