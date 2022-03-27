# CS 598 Deep Learning for Healthcare Final Project
## Authors

* Name: Shirley Li & Stanley Ho (Team 22)
* Emails: _{qiuyuli2, smho2}@illinois.edu_
## Introduction

This repository contains code for reproducing results and performing additional ablations for the publication:

_Barbieri, Sebastiano et al. “Benchmarking Deep Learning Architectures for Predicting Readmission to the ICU and Describing Patients-at-Risk.” Scientific reports vol. 10,1 1111. 24 Jan. 2020_, https://doi.org/10.1038/s41598-020-58053-z

Part of the code was originated from the [repo](https://github.com/sebbarb/time_aware_attention) from the original authors of the publication.

## Dataset

The dataset required is [MIMIC-III Clinical Database 1.4](https://physionet.org/content/mimiciii/1.4/), and it is available via [PhysioNet](https://physionet.org/) by request.

To download the dataet, you should create a `mimic-iii-clinical-database-1.4` directory at the root of this repo, and download the files from the [MIMIC-III Clinical Database 1.4](https://physionet.org/content/mimiciii/1.4/) into the directory as follows:

```
$ cd <repo>
$ mkdir mimic-iii-clinical-database-1.4
$ cd mimic-iii-clinical-database-1.4
$ wget -r -N -c -np --user <user> --ask-password https://physionet.org/files/mimiciii/1.4/
Password for user '<user>': *******
--2022-03-27 00:27:50--  https://physionet.org/files/mimiciii/1.4/
Resolving physionet.org (physionet.org)... 18.13.52.205
Connecting to physionet.org (physionet.org)|18.13.52.205|:443... connected.
HTTP request sent, awaiting response... 401 Unauthorized
Authentication selected: Basic realm="PhysioNet", charset="UTF-8"
Reusing existing connection to physionet.org:443.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [text/html]
Saving to: ‘physionet.org/files/mimiciii/1.4/index.html’
...
```