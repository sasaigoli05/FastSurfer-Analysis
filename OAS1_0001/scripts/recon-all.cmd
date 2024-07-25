\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 13:45:36 EDT 2024 
#--------------------------------------
#@# Merge ASeg Mon Jun 17 13:45:45 EDT 2024
\n cp aseg.auto.mgz aseg.presurf.mgz \n
#--------------------------------------------
#@# Intensity Normalization2 Mon Jun 17 13:45:45 EDT 2024
\n mri_normalize -seed 1234 -mprage -aseg aseg.presurf.mgz -mask brainmask.mgz norm.mgz brain.mgz \n
#--------------------------------------------
#@# Mask BFS Mon Jun 17 13:47:56 EDT 2024
\n mri_mask -T 5 brain.mgz brainmask.mgz brain.finalsurfs.mgz \n
#--------------------------------------------
#@# WM Segmentation Mon Jun 17 13:47:57 EDT 2024
\n AntsDenoiseImageFs -i brain.mgz -o antsdn.brain.mgz \n
\n mri_segment -wsizemm 13 -mprage antsdn.brain.mgz wm.seg.mgz \n
\n mri_edit_wm_with_aseg -keep-in wm.seg.mgz brain.mgz aseg.presurf.mgz wm.asegedit.mgz \n
\n mri_pretess wm.asegedit.mgz wm norm.mgz wm.mgz \n
#--------------------------------------------
#@# Fill Mon Jun 17 13:49:42 EDT 2024
\n mri_fill -a ../scripts/ponscc.cut.log -xform transforms/talairach.lta -segmentation aseg.presurf.mgz -ctab /Applications/freesurfer/7.4.1/SubCorticalMassLUT.txt wm.mgz filled.mgz \n
 cp filled.mgz filled.auto.mgz
\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 13:50:53 EDT 2024 
\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 13:50:53 EDT 2024 
#--------------------------------------------
#--------------------------------------------
#@# Inflation1 lh Mon Jun 17 13:50:56 EDT 2024
#@# Inflation1 rh Mon Jun 17 13:50:56 EDT 2024
\n mris_inflate -no-save-sulc ../surf/rh.smoothwm.nofix ../surf/rh.inflated.nofix \n
\n mris_inflate -no-save-sulc ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix \n
\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 13:51:28 EDT 2024 
\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 13:51:28 EDT 2024 
#@# Fix Topology lh Mon Jun 17 13:51:31 EDT 2024
#@# Fix Topology rh Mon Jun 17 13:51:31 EDT 2024
\n mris_fix_topology -mgz -sphere qsphere.nofix -inflated inflated.nofix -orig orig.nofix -out orig.premesh -ga -seed 1234 OAS1_0001 lh \n
\n mris_fix_topology -mgz -sphere qsphere.nofix -inflated inflated.nofix -orig orig.nofix -out orig.premesh -ga -seed 1234 OAS1_0001 rh \n
\n mris_euler_number ../surf/rh.orig.premesh \n
\n mris_remesh --remesh --iters 3 --input /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/surf/rh.orig.premesh --output /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/surf/rh.orig \n
\n mris_remove_intersection ../surf/rh.orig ../surf/rh.orig \n
\n rm -f ../surf/rh.inflated \n
#--------------------------------------------
#@# AutoDetGWStats rh Mon Jun 17 13:52:37 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.rh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/rh.orig.premesh
#--------------------------------------------
#@# WhitePreAparc rh Mon Jun 17 13:52:40 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.rh.dat --wm wm.mgz --threads 4 --invol brain.finalsurfs.mgz --rh --i ../surf/rh.orig --o ../surf/rh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
\n mris_euler_number ../surf/lh.orig.premesh \n
\n mris_remesh --remesh --iters 3 --input /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/surf/lh.orig.premesh --output /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/surf/lh.orig \n
\n mris_remove_intersection ../surf/lh.orig ../surf/lh.orig \n
\n rm -f ../surf/lh.inflated \n
#--------------------------------------------
#@# AutoDetGWStats lh Mon Jun 17 13:53:21 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.lh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/lh.orig.premesh
#--------------------------------------------
#@# WhitePreAparc lh Mon Jun 17 13:53:24 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --wm wm.mgz --threads 4 --invol brain.finalsurfs.mgz --lh --i ../surf/lh.orig --o ../surf/lh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
#--------------------------------------------
#@# CortexLabel rh Mon Jun 17 13:55:44 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 0 ../label/rh.cortex.label
#--------------------------------------------
#@# CortexLabel+HipAmyg rh Mon Jun 17 13:56:01 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 1 ../label/rh.cortex+hipamyg.label
\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 13:56:19 EDT 2024 
#--------------------------------------------
#@# Smooth2 rh Mon Jun 17 13:56:22 EDT 2024
\n mris_smooth -n 3 -nw -seed 1234 ../surf/rh.white.preaparc ../surf/rh.smoothwm \n
#--------------------------------------------
#@# Inflation2 rh Mon Jun 17 13:56:25 EDT 2024
\n mris_inflate ../surf/rh.smoothwm ../surf/rh.inflated \n
#--------------------------------------------
#@# CortexLabel lh Mon Jun 17 13:56:36 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 0 ../label/lh.cortex.label
#--------------------------------------------
#@# Curv .H and .K rh Mon Jun 17 13:56:42 EDT 2024
\n mris_curvature -w -seed 1234 rh.white.preaparc \n
\n mris_curvature -seed 1234 -thresh .999 -n -a 5 -w -distances 10 10 rh.inflated \n
#--------------------------------------------
#@# CortexLabel+HipAmyg lh Mon Jun 17 13:56:50 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 1 ../label/lh.cortex+hipamyg.label
\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 13:57:06 EDT 2024 
#--------------------------------------------
#@# Smooth2 lh Mon Jun 17 13:57:08 EDT 2024
\n mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm \n
#--------------------------------------------
#@# Inflation2 lh Mon Jun 17 13:57:11 EDT 2024
\n mris_inflate ../surf/lh.smoothwm ../surf/lh.inflated \n
#--------------------------------------------
#@# Curv .H and .K lh Mon Jun 17 13:57:27 EDT 2024
\n mris_curvature -w -seed 1234 lh.white.preaparc \n
\n mris_curvature -seed 1234 -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated \n
\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 13:57:34 EDT 2024 
#--------------------------------------------
#@# Sphere rh Mon Jun 17 13:57:36 EDT 2024
\n mris_sphere -seed 1234 ../surf/rh.inflated ../surf/rh.sphere \n
\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 13:58:19 EDT 2024 
#--------------------------------------------
#@# Sphere lh Mon Jun 17 13:58:22 EDT 2024
\n mris_sphere -seed 1234 ../surf/lh.inflated ../surf/lh.sphere \n
\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 14:29:21 EDT 2024 
#@# white curv rh Mon Jun 17 14:29:24 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/rh.white 2 10 ../surf/rh.curv
   Update not needed
#@# white area rh Mon Jun 17 14:29:24 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/rh.white ../surf/rh.area
   Update not needed
#@# pial curv rh Mon Jun 17 14:29:24 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/rh.pial 2 10 ../surf/rh.curv.pial
   Update not needed
#@# pial area rh Mon Jun 17 14:29:24 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/rh.pial ../surf/rh.area.pial
   Update not needed
#@# thickness rh Mon Jun 17 14:29:24 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#@# area and vertex vol rh Mon Jun 17 14:29:25 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
\n#-----------------------------------------
#@# Curvature Stats rh Mon Jun 17 14:29:26 EDT 2024
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/rh.curv.stats -F smoothwm OAS1_0001 rh curv sulc \n
\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 14:31:17 EDT 2024 
#@# white curv lh Mon Jun 17 14:31:19 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
   Update not needed
#@# white area lh Mon Jun 17 14:31:19 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
   Update not needed
#@# pial curv lh Mon Jun 17 14:31:19 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
   Update not needed
#@# pial area lh Mon Jun 17 14:31:19 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
   Update not needed
#@# thickness lh Mon Jun 17 14:31:19 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# area and vertex vol lh Mon Jun 17 14:31:19 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
\n#-----------------------------------------
#@# Curvature Stats lh Mon Jun 17 14:31:21 EDT 2024
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/lh.curv.stats -F smoothwm OAS1_0001 lh curv sulc \n
\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 14:31:24 EDT 2024 
#@# white curv lh Mon Jun 17 14:31:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
   Update not needed
#@# white area lh Mon Jun 17 14:31:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
   Update not needed
#@# pial curv lh Mon Jun 17 14:31:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
   Update not needed
#@# pial area lh Mon Jun 17 14:31:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
   Update not needed
#@# thickness lh Mon Jun 17 14:31:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# area and vertex vol lh Mon Jun 17 14:31:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# white curv rh Mon Jun 17 14:31:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/rh.white 2 10 ../surf/rh.curv
   Update not needed
#@# white area rh Mon Jun 17 14:31:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/rh.white ../surf/rh.area
   Update not needed
#@# pial curv rh Mon Jun 17 14:31:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/rh.pial 2 10 ../surf/rh.curv.pial
   Update not needed
#@# pial area rh Mon Jun 17 14:31:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/rh.pial ../surf/rh.area.pial
   Update not needed
#@# thickness rh Mon Jun 17 14:31:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#@# area and vertex vol rh Mon Jun 17 14:31:27 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#--------------------------------------------
#@# Cortical ribbon mask Mon Jun 17 14:31:27 EDT 2024
\n mris_volmask --aseg_name aseg.presurf --label_left_white 2 --label_left_ribbon 3 --label_right_white 41 --label_right_ribbon 42 --save_ribbon OAS1_0001 \n
\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 14:37:35 EDT 2024 
#@# white curv lh Mon Jun 17 14:37:38 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
   Update not needed
#@# white area lh Mon Jun 17 14:37:38 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
   Update not needed
#@# pial curv lh Mon Jun 17 14:37:38 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
   Update not needed
#@# pial area lh Mon Jun 17 14:37:38 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
   Update not needed
#@# thickness lh Mon Jun 17 14:37:38 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# area and vertex vol lh Mon Jun 17 14:37:38 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# white curv rh Mon Jun 17 14:37:38 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/rh.white 2 10 ../surf/rh.curv
   Update not needed
#@# white area rh Mon Jun 17 14:37:38 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/rh.white ../surf/rh.area
   Update not needed
#@# pial curv rh Mon Jun 17 14:37:38 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/rh.pial 2 10 ../surf/rh.curv.pial
   Update not needed
#@# pial area rh Mon Jun 17 14:37:38 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/rh.pial ../surf/rh.area.pial
   Update not needed
#@# thickness rh Mon Jun 17 14:37:38 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#@# area and vertex vol rh Mon Jun 17 14:37:38 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#-----------------------------------------
#@# Relabel Hypointensities Mon Jun 17 14:37:38 EDT 2024
\n mri_relabel_hypointensities aseg.presurf.mgz ../surf aseg.presurf.hypos.mgz \n
#-----------------------------------------
#@# APas-to-ASeg Mon Jun 17 14:37:52 EDT 2024
\n mri_surf2volseg --o aseg.mgz --i aseg.presurf.hypos.mgz --fix-presurf-with-ribbon /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri/ribbon.mgz --threads 4 --lh-cortex-mask /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/label/lh.cortex.label --lh-white /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/surf/lh.white --lh-pial /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/surf/lh.pial --rh-cortex-mask /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/label/rh.cortex.label --rh-white /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/surf/rh.white --rh-pial /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/surf/rh.pial \n
\n\n#---------------------------------
# New invocation of recon-all Mon Jun 17 14:39:15 EDT 2024 
#@# white curv lh Mon Jun 17 14:39:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
   Update not needed
#@# white area lh Mon Jun 17 14:39:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
   Update not needed
#@# pial curv lh Mon Jun 17 14:39:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
   Update not needed
#@# pial area lh Mon Jun 17 14:39:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
   Update not needed
#@# thickness lh Mon Jun 17 14:39:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# area and vertex vol lh Mon Jun 17 14:39:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# white curv rh Mon Jun 17 14:39:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/rh.white 2 10 ../surf/rh.curv
   Update not needed
#@# white area rh Mon Jun 17 14:39:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/rh.white ../surf/rh.area
   Update not needed
#@# pial curv rh Mon Jun 17 14:39:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --curv-map ../surf/rh.pial 2 10 ../surf/rh.curv.pial
   Update not needed
#@# pial area rh Mon Jun 17 14:39:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --area-map ../surf/rh.pial ../surf/rh.area.pial
   Update not needed
#@# thickness rh Mon Jun 17 14:39:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
#@# area and vertex vol rh Mon Jun 17 14:39:18 EDT 2024
cd /Users/suhanasaigoli/Desktop/Projects/SURF/iNPH/FastSurfer/OAS1_0001/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
   Update not needed
\n mri_brainvol_stats --subject OAS1_0001 \n
#--------------------------------------------
#@# ASeg Stats Mon Jun 17 14:39:22 EDT 2024
\n mri_segstats --seed 1234 --seg mri/aseg.mgz --sum stats/aseg.stats --pv mri/norm.mgz --empty --brainmask mri/brainmask.mgz --brain-vol-from-seg --excludeid 0 --excl-ctxgmwm --supratent --subcortgray --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --etiv --surf-wm-vol --surf-ctx-vol --totalgray --euler --ctab /Applications/freesurfer/7.4.1/ASegStatsLUT.txt --subject OAS1_0001 \n
