# Neuroinflammation_leuko_Schroyen-Sleurs_2022

Neuroinflammation as potential precursor of leukoencephalopathy in early-stage breast cancer patients: A cross-sectional PET-MRI study. 
Schroyen, G., Sleurs, C., Bartsoen, E., Smeets, D., van Weehaeghe, D., Van Laere, K., Smeets, A., Deprez, S., & Sunaert, S. (2022).

This repo contains the bash script that was used for PET-MRI preprocessing, to analyse [18F]DPA-714 PET tracer uptake in white matter lesions (FLAIR MR). 
In this script delineated white matter lesions, FLAIRS, T1s, and PET scans are co-registered. PET scans are smoothed with 8mm gaussian. 
These steps were performed using Advanced Normalization Tools. 
Next, lesions were subtracted from full white matter segmentations to create healthy white matter masks (as a reference area for tracer uptake). 
Once all lesion and healthy WM masks were in T1 space, mask-specific statistics were performed: 
for the total lesion, localized lesion and NAWM masks, mean [18F]DPA-714 were extracted (Mrtrix3). 

Publication of this work can be found here: 
Schroyen, G., Sleurs, C., Bartsoen, E., Smeets, D., van Weehaeghe, D., Van Laere, K., Smeets, A., Deprez, S., & Sunaert, S. (2022). 
Neuroinflammation as potential precursor of leukoencephalopathy in early-stage breast cancer patients: A cross-sectional PET-MRI study. Breast (Edinburgh, Scotland), 62, 61–68. 
https://doi.org/10.1016/j.breast.2022.02.001 
