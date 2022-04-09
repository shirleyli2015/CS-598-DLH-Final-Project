# CS 598 Deep Learning for Healthcare: Final Project
## Authors

* Name: Shirley Li & Stanley Ho (Team 22)
* Emails: _{qiuyuli2, smho2}@illinois.edu_
## Introduction

This repository contains code for reproducing results and performing additional ablations for the publication:

_Barbieri, Sebastiano et al. “Benchmarking Deep Learning Architectures for Predicting Readmission to the ICU and Describing Patients-at-Risk.” Scientific reports vol. 10,1 1111. 24 Jan. 2020_, https://doi.org/10.1038/s41598-020-58053-z

Part of the code was originated from the [repo](https://github.com/sebbarb/time_aware_attention) from the original authors of the publication.

## Requirements

Running the code requires Python 3. If you want to run the code directly on your local machine, install the requirements below:
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
$ cd <repo>/related_code
$ python3 train.py
```
## Evaluation

To evaluate the model(s) in the paper, run these commands:
```
# Evaluate a model.
#
$ cd <repo>/related_code
$ python3 test.py
```

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