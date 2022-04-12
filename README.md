# CS 598 DLH Final Project - Reproduction Study
## Authors

* Name: Shirley Li & Stanley Ho (Team 22)
* Emails: _{qiuyuli2, smho2}@illinois.edu_
## Introduction

This repository contains code for the reproduction study and additional ablations for the publication:

_Barbieri, Sebastiano et al. “Benchmarking Deep Learning Architectures for Predicting Readmission to the ICU and Describing Patients-at-Risk.” Scientific reports vol. 10,1 1111. 24 Jan. 2020_, https://doi.org/10.1038/s41598-020-58053-z

Part of the code was originated from the [repo](https://github.com/sebbarb/time_aware_attention) from the original authors of the publication.

## Requirements and Dependencies

Running the code requires Python 3. If you want to run the code directly on your local machine, install the required dependencies below:
```
$ pip3 install -r related_code/requirements.txt
```

If you want to run the code in an isolated environment, you might leverage the _Dockerfile_ to setup such environment:
```
# Build the container image for our environment.
#
$ docker build . -f Dockerfile -t cs598-dlh-project-env

# Run the container image and mount this repo into /workspace directory into container.
#
$ docker run -v <repo>:/workspace -it cs598-dlh-project-env
root@...# cd /workspace
root@...#
```

## Data

The dataset required is [MIMIC-III Clinical Database 1.4](https://physionet.org/content/mimiciii/1.4/) which is available via [PhysioNet](https://physionet.org/) by request To download the dataet, you should create a `mimic-iii-clinical-database-1.4` directory at the root of this repo, and download the files in the dataset as follows:

```
# Download dataset from PhysioNet.
#
$ wget -r -N -c -np --user <user> --ask-password https://physionet.org/files/mimiciii/1.4/ /tmp
Password for user '<user>': *******
--2022-03-27 00:27:50--  https://physionet.org/files/mimiciii/1.4/
Resolving physionet.org (physionet.org)... 18.13.52.205
Connecting to physionet.org (physionet.org)|18.13.52.205|:443... connected.
...

# Unzip downloaded dataset.
#
$ gunzip /tmp/physionet.org/files/mimiciii/1.4/*.gz

# Copy dataset into <repo>/mimic-iii-clinical-database-1.4.
#
$ mkdir <repo>/mimic-iii-clinical-database-1.4
$ mv /tmp/physionet.org/files/mimiciii/1.4/*.csv <repo>/mimic-iii-clinical-database-1.4
```
## Preprocessing

To preprocess the data for training the model(s) in the paper, run these commands:
```
# Run various pre-processing scripts under related_code directory.
#
$ cd <repo>/related_code
$ python3 1_preprocessing_ICU_PAT_ADMIT.py
$ python3 2_preprocessing_reduce_charts.py
$ python3 3_preprocessing_reduce_outputs.py
$ python3 4_preprocessing_merge_charts_outputs.py
$ python3 5_preprocessing_CHARTS_PRESCRIPTIONS.py
$ python3 6_preprocessing_DIAGNOSES_PROCEDURES.py
$ python3 7_preprocessing_create_arrays.py
```
## Training

To train the model(s) in the paper, run these commands:
```
# Train a model.
#
$ ./train_model.sh
 1) ODE + RNN + Attention
 2) ODE + RNN
 3) RNN (ODE time delay) + Attention
 4) RNN (ODE time delay)
 5) RNN (exp time delay) + Attention
 6) RNN (exp time delay)
 7) RNN (concatenated time delta) + Attention
 8) RNN (concatenated time delta)
 9) ODE + Attention
10) Attention (concatenated time)
11) MCE + RNN + Attention
12) MCE + RNN
13) MCE + Attention
14) Logistic Regression
15) *ABLATION* RNN only
16) QUIT
Which model do you want to train? 2
====================================
Training ODE + RNN (ode_birnn) ...
====================================
...
```
Depending on the model, the training time ranges between 1.5 hour to 20 hours.

## Evaluation

To evaluate the model(s) in the paper, run these commands:
```
# Evaluate a model.
#
$ ./eval_model.sh
 1) ODE + RNN + Attention
 2) ODE + RNN
 3) RNN (ODE time delay) + Attention
 4) RNN (ODE time delay)
 5) RNN (exp time delay) + Attention
 6) RNN (exp time delay)
 7) RNN (concatenated time delta) + Attention
 8) RNN (concatenated time delta)
 9) ODE + Attention
10) Attention (concatenated time)
11) MCE + RNN + Attention
12) MCE + RNN
13) MCE + Attention
14) Logistic Regression
15) *ABLATION* RNN only
16) QUIT
Which model do you want to evaluate? 14
====================================
Evaluating Logistic Regression (logistic_regression) ...
====================================
...
```
The evaluation time of one model is usually under an hour.
## Bayesian Interpretation

To obtain odds ratios and risk-scores with credible intervals from the last fully connected layer of the “Attention (concatenated time)” model, run:

```
python3 bayesian_interpretation.py
```
## Pretrained Embedding Weights

There are 14 models in the paper, and 3 of them require using pretrained embedding weights:
1. MCE + RNN + Attention
2. MCE + RNN
3. MCE + Attention

We obtained the pretrained embedding weights from the original authors, and they are located in the [data](https://github.com/shirleyli2015/CS-598-DLH-Final-Project/blob/master/data/) directory.
## Results

We have reproduced the model(s) in the paper with the following results:

| Model | Average Precision | AUROC | F1 Score | Sensitivity | Specificity |
|:----:|:----:|:----:|:----:|:----:|:----:|
|ODE + RNN + Attention|0.325 [0.317,0.334]|0.744 [0.741,0.747]|0.373 [0.368,0.377]|0.695 [0.684,0.706]|0.682 [0.669,0.694]|
|ODE + RNN|0.319 [0.311,0.328]|0.742 [0.739,0.745]|0.379 [0.374,0.384]|0.697 [0.684,0.711]|0.679 [0.665,0.692]|
|RNN (ODE time decay) + Attention|0.321 [0.312,0.33]|0.741 [0.738,0.743]|0.375 [0.37,0.38]|0.673 [0.658,0.687]|0.699 [0.685,0.714]|
|RNN (ODE time decay)|0.308 [0.301,0.315]|0.735 [0.732,0.738]|0.37 [0.365,0.375]|0.752 [0.745,0.759]|0.625 [0.619,0.632]|
|RNN (exp time decay) + Attention|0.309 [0.302,0.317]|0.74 [0.737,0.743]|0.362 [0.357,0.367]|0.699 [0.687,0.712]|0.673 [0.66,0.686]|
|RNN (exp time decay)|0.311 [0.304,0.319]|0.737 [0.735,0.74]|0.367 [0.362,0.371]|0.706 [0.696,0.715]|0.672 [0.663,0.682]|
|RNN (concat time delta) + Attention|0.307 [0.299,0.316]|0.742 [0.739,0.745]|0.363 [0.358,0.367]|0.716 [0.709,0.723]|0.667 [0.661,0.673]|
|RNN (concat time delta)|0.314 [0.306,0.323]|0.737 [0.734,0.739]|0.368 [0.363,0.373]|0.685 [0.673,0.696]|0.686 [0.674,0.697]|
|ODE + Attention|0.292 [0.284,0.3]|0.724 [0.722,0.727]|0.339 [0.335,0.344]|0.729 [0.716,0.742]|0.617 [0.605,0.629]|
|Attention (concat time)|0.287 [0.278,0.295]|0.716 [0.714,0.719]|0.337 [0.332,0.342]|0.655 [0.643,0.668]|0.667 [0.655,0.679]|
|MCE + RNN + Attention|0.304 [0.296,0.313]|0.729 [0.727,0.732]|0.36 [0.355,0.365]|0.692 [0.684,0.7]|0.666 [0.659,0.673]|
|MCE + RNN|0.297 [0.29,0.305]|0.726 [0.723,0.729]|0.359 [0.354,0.363]|0.667 [0.658,0.675]|0.692 [0.685,0.699]|
|MCE + Attention|0.282 [0.273,0.291]|0.693 [0.69,0.696]|0.322 [0.318,0.327]|0.675 [0.661,0.689]|0.624 [0.609,0.638]|
|Logistic Regression|0.257 [0.248,0.266]|0.663 [0.66,0.667]|0.300 [0.296,0.304]|0.596 [0.586,0.607]|0.667 [0.656,0.678]|

We have also ablated additional model(s) with the following results:

| Model | Average Precision | AUROC | F1 Score | Sensitivity | Specificity |
|:----:|:----:|:----:|:----:|:----:|:----:|
|RNN only|0.302 [0.294,0.31]|0.733 [0.731,0.736]|0.365 [0.36,0.37]|0.701 [0.688,0.713]|00.665 [0.651,0.678]|

---

Below are the odds ratios for experiencing an adverse outcome following discharge from the intensive care unit, based on the "Attenion (concatenated time)" model from our reproduction study:

| Covariate                                                  | OR [95% CI]          |
|------------------------------------------------------------|----------------------|
| ICU Length of Stay (days)                                  | 0.998 [0.996, 1]     |
| Gender: Male                                               | 1.078 [1.054, 1.103] |
| Number of Recent Admissions                                | 1.123 [1.106, 1.141] |
| Age (years)                                                | 1.005 [1.005, 1.005] |
| Pre-ICU Length of Stay (days)                              | 1.006 [1.003, 1.009] |
| Elective Surgery                                           | 0.892 [0.852, 0.934] |
| Admission Location: Clinic Referral/Premature Delivery     | 0.943 [0.904, 0.983] |
| Admission Location: Other/Unknown                          | 1 [0.995, 1.005]     |
| Admission Location: Physician Referral/Normal Delivery     | 0.927 [0.893, 0.962] |
| Admission Location: Transfer from Hospital/Extramural      | 1.154 [1.111, 1.198] |
| Admission Location: Transfer from Skilled Nursing Facility | 1.216 [0.962, 1.537] |
| Insurance: Government                                      | 0.761 [0.692, 0.837] |
| Insurance: Medicaid                                        | 1.002 [0.996, 1.009] |
| Insurance: Private                                         | 0.854 [0.825, 0.883] |
| Insurance: Self Pay                                        | 0.464 [0.384, 0.561] |
| Marital Status: Other/Unknown                              | 0.921 [0.855, 0.993] |
| Marital Status: Single                                     | 1 [0.995, 1.006]     |
| Marital Status: Widowed/Divorced/Separated                 | 0.974 [0.938, 1.012] |
| Ethnicity: Asian                                           | 0.875 [0.783, 0.978] |
| Ethnicity: Black/African American                          | 1 [0.995, 1.005]     |
| Ethnicity: Hispanic/Latino                                 | 1.001 [0.996, 1.007] |
| Ethnicity: Other/Unknown                                   | 0.913 [0.873, 0.955] |
| Ethnicity: Unable to Obtain                                | 0.852 [0.742, 0.978] |
| Score: Diagnoses and Procedures                            | 1.73 [1.715, 1.745]  |
| Score: Medications and Vital Signs                         | 1.8 [1.744, 1.858]   |

---

Below are the ICD-9 diagnosis and procedure codes and medications assigned scores by the "Attention (concatenated time)" model from our reproduction study:

| DESCRIPTION                                                                 | Score [95% CI]  |
|-----------------------------------------------------------------------------|-----------------|
| ICD-9 Diagnoses                                                             |                 |
| Goiter, unspecified                                                         | 5 [4, 5.9]      |
| Foreign body in larynx                                                      | 4.2 [2.8, 5.7]  |
| Acute and subacute bacterial endocarditis                                   | 4.1 [3.6, 4.5]  |
| Disruption of internal operation (surgical) wound                           | 3.9 [3.3, 4.5]  |
| Acquired coagulation factor deficiency                                      | 3.8 [2.9, 4.8]  |
| Other specified disorders of biliary tract                                  | 3.7 [3, 4.4]    |
| Acute and chronic respiratory failure                                       | 3.7 [3.1, 4.3]  |
| Subdural hemorrhage                                                         | 3.5 [2.9, 4.1]  |
| Hemorrhage, unspecified                                                     | 3.1 [2.2, 4.1]  |
| Other pulmonary insufficiency, not elsewhere classified                     | 3 [2.5, 3.5]    |
| ICD-9 Procedures                                                            |                 |
| Percutaneous abdominal drainage                                             | 4.3 [4, 4.5]    |
| Pericardiotomy                                                              | 4.1 [3.3, 5]    |
| Temporary tracheostomy                                                      | 4 [3.8, 4.3]    |
| Cardiopulmonary resuscitation, not otherwise specified                      | 3.9 [3.2, 4.6]  |
| Thoracentesis                                                               | 3.5 [3.2, 3.9]  |
| Ventricular shunt to abdominal cavity and organs                            | 3.4 [1.6, 5]    |
| Therapeutic plasmapheresis                                                  | 3.2 [2.3, 4.2]  |
| Enteral infusion of concentrated nutritional substances                     | 3.1 [2.9, 3.3]  |
| Extraction of other tooth                                                   | 3.1 [2.1, 4.1]  |
| Continuous invasive mechanical ventilation for 96 consecutive hours or more | 3 [2.7, 3.3]    |
| Medications                                                                 |                 |
| heparinsodium                                                               | 4.5 [2.9, 6.3]  |
| d5w                                                                         | 4.1 [3, 5.2]    |
| bag                                                                         | 3 [1.4, 4.6]    |
| albuterol0.083%nebsoln                                                      | 2.1 [0.8, 3.6]  |
| ondansetron                                                                 | 1.9 [-0.2, 4]   |
| furosemide                                                                  | 1.8 [1.2, 2.6]  |
| acetylcysteine20%                                                           | 1.6 [0.1, 3.2]  |
| vial                                                                        | 1.5 [0.3, 2.7]  |
| lorazepam                                                                   | 1.4 [0.7, 2.2]  |
| magnesiumoxide                                                              | 1.4 [-0.6, 3.2] |
