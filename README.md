# CS 598 Deep Learning for Healthcare Final Project
## Authors

* Name: Shirley Li & Stanley Ho (Team 22)
* Emails: _{qiuyuli2, smho2}@illinois.edu_
## Introduction

This repository contains code for reproducing results and performing additional ablations for the publication:

_Barbieri, Sebastiano et al. “Benchmarking Deep Learning Architectures for Predicting Readmission to the ICU and Describing Patients-at-Risk.” Scientific reports vol. 10,1 1111. 24 Jan. 2020_, https://doi.org/10.1038/s41598-020-58053-z

Part of the code was originated from the [repo](https://github.com/sebbarb/time_aware_attention) from the original authors of the publication.

## Dataset

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
## Preprocessing Data

Preprocessing data from the dataset is required before we can train and test the models. To do so,
```
# Build the container image for our environment.
#
$ docker build . -f Dockerfile -t cs598-dlh-project-env

# Run the container image and mount this repo into /workspace directory into container.
#
$ docker run -v <repo>:/workspace -it cs598-dlh-project-env
root@...#

# Run various pre-processing scripts under related_code directory.
#
root@...# cd workspace/related_code
root@...# python3 1_preprocessing_ICU_PAT_ADMIT.py
root@...# python3 2_preprocessing_reduce_charts.py
...
root@...# python3 7_preprocessing_create_arrays.py
```