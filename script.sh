

list=('CM01' 'CM02' 'CM03' 'CM04' 'CM05' 'CM06' 'CM07' 'CM09' 'CM10' 'CM11' 
'CM12' 'CM14' 'CM15' 'CM16' 'CM17' 'CP02' 'CP04' 'CP06' 'CP07' 'CP08' 'CP09' 
'CP11' 'CP12' 'CP13' 'CP14' 'CP15' 'CP18' 'CP19' 'CP20' 'CP21' 'HC01' 'HC08' 
'HC11' 'HC12' 'HC13' 'HC14' 'HC19' 'HC20' 'HC25' 'HC26' 'HC27' 'HC33' 'HV03' 
'HV06' 'HV08')

list2=('Cm01' 'Cm02' 'Cm03' 'Cm04' 'Cm05' 'Cm06' 'Cm07' 'Cm09' 'Cm10' 'Cm11' 
'Cm12' 'Cm14' 'Cm15' 'Cm16' 'Cm17' 'Cp02' 'Cp04' 'Cp06' 'Cp07' 'Cp08' 'Cp09' 
'Cp11' 'Cp12' 'Cp13' 'Cp14' 'Cp15' 'Cp18' 'Cp19' 'Cp20' 'Cp21' 'HC01' 'HC08' 
'HC11' 'HC12' 'HC13' 'HC14' 'HC19' 'HC20' 'HC25' 'HC26' 'HC27' 'HC33' 'HV03' 
'HV06' 'HV08')

lesiondcm="/mnt/f/Gwen/CharlotteAnalyses/FLAIRxPETdata/icobrain/"
lesiondir="/mnt/f/Gwen/CharlotteAnalyses/FLAIRxPETdata/lesions/"
FLAIRdir="/mnt/f/Gwen/CharlotteAnalyses/FLAIRxPETdata/icometrix/icometrix/"
FLAIRdirout="/mnt/f/Gwen/CharlotteAnalyses/FLAIRxPETdata/FLAIR/"
T1folder="/mnt/f/Gwen/CharlotteAnalyses/FLAIRxPETdata/centered/"
PETfolder='/mnt/f/Gwen/CharlotteAnalyses/FLAIRxPETdata/PET_raw/' 

# Convert lesions dcms to nii
# n=${#list[@]}
# for ((i=0;i<$n;i++))
# do
# lesiondcm2=$lesiondcm${list[$i]}'*'/flair_wm_hyper_sag/
# ## NOT TO USE dcm2niix_afni -f ${list[$i]}'_lesionAFNI' -o $lesiondir $lesiondcm2 
# ## TO USE 
# mrconvert $lesiondcm2 $lesiondir${list[$i]}'_lesion.nii'
# # mrconvert -coord 3 0 $lesiondir${list[$i]}'_lesion4dims.nii' $lesiondir${list[$i]}'_lesion3dims.nii' 
# # mrconvert -axes 0,1,2 $lesiondir${list[$i]}'_lesion3dims.nii' $lesiondir${list[$i]}'_lesion.nii'
# done


# Convert FLAIRs to nii
# n=${#list2[@]}
# for ((i=0;i<$n;i++))
# do
## FLAIRdcm=$FLAIRdir${list2[$i]}'*'/*FLAIR*/
## dcm2niix_afni -f ${list[$i]}'_FLAIR' -o $FLAIRdirout $FLAIRdcm 
## mrconvert $FLAIRdcm $FLAIRdirout${list[$i]}'_FLAIR.nii'
# T1dcm=$FLAIRdir${list2[$i]}'*'/*BRAVO*/
# mrconvert $T1dcm $T1folder${list[$i]}'_T1.nii'
# done

#Bring FLAIRs, T1, lesions to standard view 
# n=${#list[@]}
# for ((i=0;i<$n;i++))
# do
# fslreorient2std $FLAIRdirout${list[$i]}'*.nii' $FLAIRdirout${list[$i]}'_FLAIR_std.nii' 
# fslreorient2std $lesiondir${list[$i]}'_lesion.nii' $lesiondir${list[$i]}'_lesion_std.nii'
# #fslreorient2std $T1folder${list[$i]}'_T1.nii' $T1folder${list[$i]}'_T1_std.nii.gz'
# done

# # Binarize the lesion maps
# n=${#list[@]}
# for ((i=0;i<$n;i++))
# do 
# mrthreshold $lesiondir${list[$i]}'_lesion_std.nii' -abs 193 $lesiondir${list[$i]}'_lesion_std_bin.nii'
# done

# #Coregister original FLAIRS and T1 to lesionmaps (as they moved)
## ANTS CANNOT WORK WITH ICOBRAIN-lesions to register....
## (too long) antsRegistrationSyN.sh -d 3 -f $lesiondir${list[$i]}'_lesion.nii' -m $T1folder'sub-'${list2[$i]}'_desc-preproc_T1w.nii.gz' -o $T1folder${list[$i]}_T1_lesionspace.nii
# n=${#list[@]}
# for ((i=0;i<$n;i++))
# do 
# # antsRegistrationSyNQuick.sh -d 3 -t a -f $lesiondir${list[$i]}'_lesion_std.nii.gz' -m $T1folder${list[$i]}'_T1_std.nii' -o $T1folder${list[$i]}'_'
# flirt -dof 6 -in $T1folder${list[$i]}'_T1_std.nii' -ref $lesiondir${list[$i]}'_lesion_std.nii.gz' -out $T1folder${list[$i]}'_T1_lesionSP.nii' 
# flirt -dof 6 -in $FLAIRdirout${list[$i]}'_FLAIR_std.nii' -ref $lesiondir${list[$i]}'_lesion_std.nii.gz' -out $FLAIRdirout${list[$i]}'_FLAIR_lesionSP.nii' 
# done

# #Coregister PETs to T1 & smooth 8mm
# n=${#list[@]}
# for ((i=0;i<$n;i++))
# do 
# flirt -dof 6 -in $PETfolder${list2[$i]}'_rbv.nii.gz' -ref $T1folder${list[$i]}'_T1_lesionSP.nii' -out $PETfolder${list2[$i]}'_RBV2T1.nii'
# flirt -dof 6 -in $PETfolder${list2[$i]}'_Vt.nii.gz' -ref $T1folder${list[$i]}'_T1_lesionSP.nii' -out $PETfolder${list2[$i]}'_VT2T1.nii'
# fslmaths $PETfolder${list2[$i]}'_RBV2T1.nii' -s 8 $PETfolder${list2[$i]}'_RBV2T1_sm8.nii'
# fslmaths $PETfolder${list2[$i]}'_VT2T1.nii' -s 8 $PETfolder${list2[$i]}'_VT2T1_sm8.nii'
# done

# SPM:
# Segment T1s (lesionFLAIRspace, created in previous line) in SPM; 
# $T1folder${list[$i]}'_T1_lesionSP.nii' to c1(GM),c2(WM),c3(CSF)

# # Create healthy WM mask (CATsegmentation - lesion_bin) (if the lesion is part of WM in CAT)
# n=${#list[@]}
# for ((i=0;i<$n;i++))
# do 
# mrthreshold $T1folder'c2'${list[$i]}'_T1_lesionSP.nii' -abs 0 -comparison "gt" $T1folder${list[$i]}'_WM_bin.nii'
# fslmaths $T1folder${list[$i]}'_WM_bin.nii' -sub $lesiondir${list[$i]}'_lesion_std_bin.nii' $T1folder${list[$i]}'_WM_healthy.nii'
# mrthreshold $T1folder${list[$i]}'_WM_healthy.nii.gz' -abs 1 $T1folder${list[$i]}'_WM_healthy_bin.nii'
# done 

# # Calculate means and SDs (and medians) of PET-tracer in lesions (lesion_bin)
n=${#list[@]}
for ((i=0;i<$n;i++))
do 
mrstats -output mean -mask $lesiondir${list[$i]}'_lesion_std_bin.nii' $PETfolder${list2[$i]}'_RBV2T1_sm8.nii.gz'  >> $PETfolder'meansRBVinlesion.txt'
mrstats -output std -mask $lesiondir${list[$i]}'_lesion_std_bin.nii' $PETfolder${list2[$i]}'_RBV2T1_sm8.nii.gz' >> $PETfolder'stdsRBVinlesion.txt'
mrstats -output median -mask $lesiondir${list[$i]}'_lesion_std_bin.nii' $PETfolder${list2[$i]}'_RBV2T1_sm8.nii.gz' >> $PETfolder'mediansRBVinlesion.txt'
mrstats -output mean -mask $lesiondir${list[$i]}'_lesion_std_bin.nii' $PETfolder${list2[$i]}'_VT2T1_sm8.nii.gz'  >> $PETfolder'meansVTinlesion.txt'
mrstats -output std -mask $lesiondir${list[$i]}'_lesion_std_bin.nii' $PETfolder${list2[$i]}'_VT2T1_sm8.nii.gz' >> $PETfolder'stdsVTinlesion.txt'
mrstats -output median -mask $lesiondir${list[$i]}'_lesion_std_bin.nii' $PETfolder${list2[$i]}'_VT2T1_sm8.nii.gz' >> $PETfolder'mediansVTinlesion.txt'
done

# Calculate means and SDs (and medians) of PET-tracer in healthy WM (CATsegmentation)
n=${#list[@]}
for ((i=0;i<$n;i++))
do 
mrstats -output mean -mask $T1folder${list[$i]}'_WM_healthy_bin.nii' $PETfolder${list2[$i]}'_RBV2T1_sm8.nii.gz'  >> $PETfolder'meansRBVinWM.txt'
mrstats -output std -mask $T1folder${list[$i]}'_WM_healthy_bin.nii' $PETfolder${list2[$i]}'_RBV2T1_sm8.nii.gz' >> $PETfolder'stdsRBVinWM.txt'
mrstats -output median -mask $T1folder${list[$i]}'_WM_healthy_bin.nii' $PETfolder${list2[$i]}'_RBV2T1_sm8.nii.gz' >> $PETfolder'mediansRBVinWM.txt'
mrstats -output mean -mask $T1folder${list[$i]}'_WM_healthy_bin.nii' $PETfolder${list2[$i]}'_VT2T1_sm8.nii.gz'  >> $PETfolder'meansVTinWM.txt'
mrstats -output std -mask $T1folder${list[$i]}'_WM_healthy_bin.nii' $PETfolder${list2[$i]}'_VT2T1_sm8.nii.gz' >> $PETfolder'stdsVTinWM.txt'
mrstats -output median -mask $T1folder${list[$i]}'_WM_healthy_bin.nii' $PETfolder${list2[$i]}'_VT2T1_sm8.nii.gz' >> $PETfolder'mediansVTinWM.txt'
done


## commands that were not used... 

# Skullstripping; NOT REQUIRED, if WM mask and lesion mask look good without skull
# Sum op WM, GM, CSF from T1segments in CAT, to have a brain mask,
# to register the PET data to
# mrmath $T1folder${list[$i]}'_segm/mri/p1' $T1folder${list[$i]}'_segm/mri/p2' $T1folder${list[$i]}'_segm/mri/p3' sum $T1folder${list[$i]}'_brainmask.nii'
# mrmath $T1folder${list[$i]}'_brainmask.nii' $T1folder${list[$i]}'_T1_std.nii.gz' product $T1folder${list[$i]}'_T1_brain.nii'

## ONLY FOR CAT, BUT I USED SPM, cause CAT DID NOT WORK
# Create subfolders & paste T1s there for individual SPM-segmentations 
# n=${#list[@]}
# for ((i=0;i<$n;i++))
# do 
# mkdir $T1folder${list[$i]}'_segm'
# gunzip $T1folder${list[$i]}'_T1_lesionSP.nii.gz'
# cp $T1folder${list[$i]}'_T1_lesionSP.nii' $T1folder${list[$i]}'_segm/'
# done

## DID NOT WORK for mango (to be able to view all images in all viewers, maybe try to set nan-values to 0) 
# n=${#list[@]}
# for ((i=0;i<$n;i++))
# do 
# fslmaths $PETfolder${list2[$i]}'_RBV2T1_sm8.nii' -nan $PETfolder${list2[$i]}'_RBV2T1_sm8_allviewers.nii'
# fslmaths $PETfolder${list2[$i]}'_VT2T1_sm8.nii' -nan $PETfolder${list2[$i]}'_VT2T1_sm8_allviewers.nii'
# fslmaths $PETfolder${list2[$i]}'_RBV2T1.nii' -nan $PETfolder${list2[$i]}'_RBV2T1_allviewers.nii'
# fslmaths $PETfolder${list2[$i]}'_VT2T1.nii' -nan $PETfolder${list2[$i]}'_VT2T1_allviewers.nii'
# fslmaths $T1folder${list[$i]}'_T1_lesionSP.nii' -nan $T1folder${list[$i]}'_T1_lesionSP_allviewers.nii' 
# fslmaths $FLAIRdirout${list[$i]}'_FLAIR_lesionSP.nii' -nan $FLAIRdirout${list[$i]}'_FLAIR_lesionSP_allviewers.nii' 
# fslmaths $lesiondir${list[$i]}'_lesion_std_bin.nii' -nan $lesiondir${list[$i]}'_lesion_std_bin_allviewers.nii'
# done
