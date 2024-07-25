\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 17:42:40 EDT 2024 
#--------------------------------------
#@# Merge ASeg Sat Jun 29 17:42:44 EDT 2024
\n cp aseg.auto.mgz aseg.presurf.mgz \n
#--------------------------------------------
#@# Intensity Normalization2 Sat Jun 29 17:42:44 EDT 2024
\n mri_normalize -seed 1234 -mprage -aseg aseg.presurf.mgz -mask brainmask.mgz norm.mgz brain.mgz \n
#--------------------------------------------
#@# Mask BFS Sat Jun 29 17:45:04 EDT 2024
\n mri_mask -T 5 brain.mgz brainmask.mgz brain.finalsurfs.mgz \n
#--------------------------------------------
#@# WM Segmentation Sat Jun 29 17:45:05 EDT 2024
\n AntsDenoiseImageFs -i brain.mgz -o antsdn.brain.mgz \n
\n mri_segment -wsizemm 13 -mprage antsdn.brain.mgz wm.seg.mgz \n
\n mri_edit_wm_with_aseg -keep-in wm.seg.mgz brain.mgz aseg.presurf.mgz wm.asegedit.mgz \n
\n mri_pretess wm.asegedit.mgz wm norm.mgz wm.mgz \n
#--------------------------------------------
#@# Fill Sat Jun 29 17:46:57 EDT 2024
\n mri_fill -a ../scripts/ponscc.cut.log -xform transforms/talairach.lta -segmentation aseg.presurf.mgz -ctab /Applications/freesurfer/7.4.1/SubCorticalMassLUT.txt wm.mgz filled.mgz \n
 cp filled.mgz filled.auto.mgz
\n\n#---------------------------------
\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 17:48:12 EDT 2024 
# New invocation of recon-all Sat Jun 29 17:48:12 EDT 2024 
#--------------------------------------------
#--------------------------------------------
#@# Inflation1 lh Sat Jun 29 17:48:15 EDT 2024
#@# Inflation1 rh Sat Jun 29 17:48:15 EDT 2024
\n mris_inflate -no-save-sulc ../surf/rh.smoothwm.nofix ../surf/rh.inflated.nofix \n
\n mris_inflate -no-save-sulc ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix \n
\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 17:48:48 EDT 2024 
\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 17:48:49 EDT 2024 
#@# Fix Topology lh Sat Jun 29 17:48:51 EDT 2024
\n mris_fix_topology -mgz -sphere qsphere.nofix -inflated inflated.nofix -orig orig.nofix -out orig.premesh -ga -seed 1234 OAS1_0001-3 lh \n
#--------------------------------------------
#@# QSphere rh Sat Jun 29 17:48:51 EDT 2024
\n mris_sphere -q -p 6 -a 128 -seed 1234 ../surf/rh.inflated.nofix ../surf/rh.qsphere.nofix \n
\n mris_euler_number ../surf/lh.orig.premesh \n
\n mris_remesh --remesh --iters 3 --input /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/surf/lh.orig.premesh --output /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/surf/lh.orig \n
\n mris_remove_intersection ../surf/lh.orig ../surf/lh.orig \n
\n rm -f ../surf/lh.inflated \n
#--------------------------------------------
#@# AutoDetGWStats lh Sat Jun 29 17:50:22 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.lh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/lh.orig.premesh
#--------------------------------------------
#@# WhitePreAparc lh Sat Jun 29 17:50:25 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --wm wm.mgz --threads 4 --invol brain.finalsurfs.mgz --lh --i ../surf/lh.orig --o ../surf/lh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 17:50:42 EDT 2024 
#@# Fix Topology rh Sat Jun 29 17:50:45 EDT 2024
\n mris_fix_topology -mgz -sphere qsphere.nofix -inflated inflated.nofix -orig orig.nofix -out orig.premesh -ga -seed 1234 OAS1_0001-3 rh \n
\n mris_euler_number ../surf/rh.orig.premesh \n
\n mris_remesh --remesh --iters 3 --input /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/surf/rh.orig.premesh --output /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/surf/rh.orig \n
\n mris_remove_intersection ../surf/rh.orig ../surf/rh.orig \n
\n rm -f ../surf/rh.inflated \n
#--------------------------------------------
#@# AutoDetGWStats rh Sat Jun 29 17:52:23 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.rh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/rh.orig.premesh
#--------------------------------------------
#@# WhitePreAparc rh Sat Jun 29 17:52:26 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.rh.dat --wm wm.mgz --threads 4 --invol brain.finalsurfs.mgz --rh --i ../surf/rh.orig --o ../surf/rh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
#--------------------------------------------
#@# CortexLabel lh Sat Jun 29 17:53:20 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 0 ../label/lh.cortex.label
#--------------------------------------------
#@# CortexLabel+HipAmyg lh Sat Jun 29 17:53:42 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 1 ../label/lh.cortex+hipamyg.label
\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 17:53:59 EDT 2024 
#--------------------------------------------
#@# Smooth2 lh Sat Jun 29 17:54:02 EDT 2024
\n mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm \n
#--------------------------------------------
#@# Inflation2 lh Sat Jun 29 17:54:05 EDT 2024
\n mris_inflate ../surf/lh.smoothwm ../surf/lh.inflated \n
#--------------------------------------------
#@# Curv .H and .K lh Sat Jun 29 17:54:24 EDT 2024
\n mris_curvature -w -seed 1234 lh.white.preaparc \n
\n mris_curvature -seed 1234 -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated \n
\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 17:55:20 EDT 2024 
#--------------------------------------------
#@# Sphere lh Sat Jun 29 17:55:23 EDT 2024
\n mris_sphere -seed 1234 ../surf/lh.inflated ../surf/lh.sphere \n
#--------------------------------------------
#@# CortexLabel rh Sat Jun 29 17:55:47 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 0 ../label/rh.cortex.label
#--------------------------------------------
#@# CortexLabel+HipAmyg rh Sat Jun 29 17:56:04 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 1 ../label/rh.cortex+hipamyg.label
\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 17:56:21 EDT 2024 
#--------------------------------------------
#@# Smooth2 rh Sat Jun 29 17:56:24 EDT 2024
\n mris_smooth -n 3 -nw -seed 1234 ../surf/rh.white.preaparc ../surf/rh.smoothwm \n
#--------------------------------------------
#@# Inflation2 rh Sat Jun 29 17:56:27 EDT 2024
\n mris_inflate ../surf/rh.smoothwm ../surf/rh.inflated \n
#--------------------------------------------
#@# Curv .H and .K rh Sat Jun 29 17:56:47 EDT 2024
\n mris_curvature -w -seed 1234 rh.white.preaparc \n
\n mris_curvature -seed 1234 -thresh .999 -n -a 5 -w -distances 10 10 rh.inflated \n
\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 17:57:47 EDT 2024 
#--------------------------------------------
#@# Sphere rh Sat Jun 29 17:57:50 EDT 2024
\n mris_sphere -seed 1234 ../surf/rh.inflated ../surf/rh.sphere \n
\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 18:31:47 EDT 2024 
#@# white curv rh Sat Jun 29 18:31:51 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/rh.white 2 10 ../surf/rh.curv
   Update not needed
#@# white area rh Sat Jun 29 18:31:51 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/rh.white ../surf/rh.area
   Update not needed
#@# pial curv rh Sat Jun 29 18:31:51 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/rh.pial 2 10 ../surf/rh.curv.pial
   Update not needed
#@# pial area rh Sat Jun 29 18:31:51 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/rh.pial ../surf/rh.area.pial
   Update not needed
#@# thickness rh Sat Jun 29 18:31:51 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#@# area and vertex vol rh Sat Jun 29 18:31:51 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
\n#-----------------------------------------
#@# Curvature Stats rh Sat Jun 29 18:31:54 EDT 2024
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/rh.curv.stats -F smoothwm OAS1_0001-3 rh curv sulc \n
\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 18:32:25 EDT 2024 
#@# white curv lh Sat Jun 29 18:32:29 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
   Update not needed
#@# white area lh Sat Jun 29 18:32:29 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
   Update not needed
#@# pial curv lh Sat Jun 29 18:32:29 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
   Update not needed
#@# pial area lh Sat Jun 29 18:32:29 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
   Update not needed
#@# thickness lh Sat Jun 29 18:32:29 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# area and vertex vol lh Sat Jun 29 18:32:29 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
\n#-----------------------------------------
#@# Curvature Stats lh Sat Jun 29 18:32:32 EDT 2024
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/lh.curv.stats -F smoothwm OAS1_0001-3 lh curv sulc \n
\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 18:32:37 EDT 2024 
#@# white curv lh Sat Jun 29 18:32:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
   Update not needed
#@# white area lh Sat Jun 29 18:32:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
   Update not needed
#@# pial curv lh Sat Jun 29 18:32:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
   Update not needed
#@# pial area lh Sat Jun 29 18:32:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
   Update not needed
#@# thickness lh Sat Jun 29 18:32:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# area and vertex vol lh Sat Jun 29 18:32:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# white curv rh Sat Jun 29 18:32:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/rh.white 2 10 ../surf/rh.curv
   Update not needed
#@# white area rh Sat Jun 29 18:32:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/rh.white ../surf/rh.area
   Update not needed
#@# pial curv rh Sat Jun 29 18:32:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/rh.pial 2 10 ../surf/rh.curv.pial
   Update not needed
#@# pial area rh Sat Jun 29 18:32:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/rh.pial ../surf/rh.area.pial
   Update not needed
#@# thickness rh Sat Jun 29 18:32:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#@# area and vertex vol rh Sat Jun 29 18:32:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#--------------------------------------------
#@# Cortical ribbon mask Sat Jun 29 18:32:40 EDT 2024
\n mris_volmask --aseg_name aseg.presurf --label_left_white 2 --label_left_ribbon 3 --label_right_white 41 --label_right_ribbon 42 --save_ribbon OAS1_0001-3 \n
\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 18:42:37 EDT 2024 
#@# white curv lh Sat Jun 29 18:42:39 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
   Update not needed
#@# white area lh Sat Jun 29 18:42:39 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
   Update not needed
#@# pial curv lh Sat Jun 29 18:42:39 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
   Update not needed
#@# pial area lh Sat Jun 29 18:42:39 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
   Update not needed
#@# thickness lh Sat Jun 29 18:42:39 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# area and vertex vol lh Sat Jun 29 18:42:39 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# white curv rh Sat Jun 29 18:42:39 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/rh.white 2 10 ../surf/rh.curv
   Update not needed
#@# white area rh Sat Jun 29 18:42:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/rh.white ../surf/rh.area
   Update not needed
#@# pial curv rh Sat Jun 29 18:42:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/rh.pial 2 10 ../surf/rh.curv.pial
   Update not needed
#@# pial area rh Sat Jun 29 18:42:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/rh.pial ../surf/rh.area.pial
   Update not needed
#@# thickness rh Sat Jun 29 18:42:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#@# area and vertex vol rh Sat Jun 29 18:42:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#-----------------------------------------
#@# Relabel Hypointensities Sat Jun 29 18:42:40 EDT 2024
\n mri_relabel_hypointensities aseg.presurf.mgz ../surf aseg.presurf.hypos.mgz \n
#-----------------------------------------
#@# APas-to-ASeg Sat Jun 29 18:42:52 EDT 2024
\n mri_surf2volseg --o aseg.mgz --i aseg.presurf.hypos.mgz --fix-presurf-with-ribbon /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri/ribbon.mgz --threads 4 --lh-cortex-mask /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/label/lh.cortex.label --lh-white /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/surf/lh.white --lh-pial /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/surf/lh.pial --rh-cortex-mask /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/label/rh.cortex.label --rh-white /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/surf/rh.white --rh-pial /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/surf/rh.pial \n
\n\n#---------------------------------
# New invocation of recon-all Sat Jun 29 18:44:16 EDT 2024 
#@# white curv lh Sat Jun 29 18:44:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
   Update not needed
#@# white area lh Sat Jun 29 18:44:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
   Update not needed
#@# pial curv lh Sat Jun 29 18:44:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
   Update not needed
#@# pial area lh Sat Jun 29 18:44:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
   Update not needed
#@# thickness lh Sat Jun 29 18:44:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# area and vertex vol lh Sat Jun 29 18:44:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# white curv rh Sat Jun 29 18:44:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/rh.white 2 10 ../surf/rh.curv
   Update not needed
#@# white area rh Sat Jun 29 18:44:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/rh.white ../surf/rh.area
   Update not needed
#@# pial curv rh Sat Jun 29 18:44:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --curv-map ../surf/rh.pial 2 10 ../surf/rh.curv.pial
   Update not needed
#@# pial area rh Sat Jun 29 18:44:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --area-map ../surf/rh.pial ../surf/rh.area.pial
   Update not needed
#@# thickness rh Sat Jun 29 18:44:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#@# area and vertex vol rh Sat Jun 29 18:44:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001-3/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
\n mri_brainvol_stats --subject OAS1_0001-3 \n
#--------------------------------------------
#@# ASeg Stats Sat Jun 29 18:44:22 EDT 2024
\n mri_segstats --seed 1234 --seg mri/aseg.mgz --sum stats/aseg.stats --pv mri/norm.mgz --empty --brainmask mri/brainmask.mgz --brain-vol-from-seg --excludeid 0 --excl-ctxgmwm --supratent --subcortgray --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --etiv --surf-wm-vol --surf-ctx-vol --totalgray --euler --ctab /Applications/freesurfer/7.4.1/ASegStatsLUT.txt --subject OAS1_0001-3 \n
