#!/bin/bash


export recorder_filename=/home/calvin/Documents/transfuser-retest3-demo/data/expert/RouteScenario_17_rep0.log
export id_number=1132

python start_recording.py \
--recorder_filename=${recorder_filename}  \
--id=${id_number}


