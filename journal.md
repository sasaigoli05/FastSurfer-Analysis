# Research Journal - Segmentation/Registration metric derivation, analysis

## Perfusion

'''
I also recommend trying both lncc2 and mind as similarity measures for instance optimization for multiGradICON. Mind is more focused on structural alignment so might work better.

Here are two issues that you may or may not encounter:
If the data you are looking at contains massive strokes then aligning to an atlas might be challenging if the images look too different. In this case one might want to have transformations that are less flexible. Not sure how multiGradICON might fare in such a scenario but reducing the number of instance optimization steps might help in such a case.
I recall that Peirong also faced some challenges with MRP/CTP acquisitions that only covered a part of the brain (whereas the atlas covered everything). MultiGradICON might just work fine in this case but if not this might require some form of cost function masking. Cost function masking is currently not supported in uniGradICON/multiGradICON but likely will be in its next version. 

'''