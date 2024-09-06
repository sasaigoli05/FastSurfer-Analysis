# Research Journal - Segmentation/Registration metric derivation, analysis

## Perfusion

Niethammer:

> I also recommend trying both lncc2 and mind as similarity measures for instance optimization for multiGradICON. Mind is more focused on structural alignment so might work better.

> Here are two issues that you may or may not encounter:
If the data you are looking at contains massive strokes then aligning to an atlas might be challenging if the images look too different. In this case one might want to have transformations that are less flexible. Not sure how multiGradICON might fare in such a scenario but reducing the number of instance optimization steps might help in such a case.
I recall that Peirong also faced some challenges with MRP/CTP acquisitions that only covered a part of the brain (whereas the atlas covered everything). MultiGradICON might just work fine in this case but if not this might require some form of cost function masking. Cost function masking is currently not supported in uniGradICON/multiGradICON but likely will be in its next version. 

Lee:
> Our conversion process goes from DICOM thin slice to an intermediate nifti format to a registered 4D file (the multi GB file in the zip file).
All of the other files are intermediate files that are stored and calculated along the way. Off the top of my head, my assumption is that some of the brain stripped files will be the “best” for registration. Anything that has the 15x15x5 is a downsampled version of things, so probably not where you want to start.
The repeated files that have _reg extensions are the individual time points, typically 42. But, since they are registered to each other, you should only need one of them, and the output maps (CBF, CBV, MTT, etc.) Now the output maps are downsampled, so they will not be as high resolution as the anatomical maps. But, I think they are the same resolution as the 15x15x5 maps, which are downsampled from the anatomics. Again, everything should be registered, just scaled differently.

> How to start – use FIJI (the advanced version of ImageJ), and just drag and drop into the viewer to see what the image looks like.
I would probably start with taking an MRI with the atlas, and register one of the *_6_reg.nii (the CT anatomy, no contrast) and see how it registers to the brain MRI. If you need the brain masked out, apply the brain mask that is already calculated for you.  this acquisition doesn’t have the entire brain, and many won’t. If those two register, then it should be easy to bring everything else into the same coordinate system.
