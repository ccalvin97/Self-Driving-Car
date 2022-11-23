#!/bin/bash
export CARLA_ROOT=/opt/carla-simulator
export CARLA_SERVER=${CARLA_ROOT}/CarlaUE4.sh

export WorldOnRails_root=/home/calvin/Documents/WorldOnRails-release_2/scenario_runner/srunner
export LEADERBOARD_ROOT=/home/calvin/Documents/WorldOnRails-release_2/leaderboard
export SCENARIO_RUNNER_ROOT=/home/calvin/Documents/WorldOnRails-release_2/scenario_runner
export PYTHONPATH=$PYTHONPATH:${SCENARIO_RUNNER_ROOT}:${LEADERBOARD_ROOT}:${WorldOnRails_root}:\
"/opt/carla-simulator/PythonAPI/carla":$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.12-py3.7-linux-x86_64.egg:\
"/home/calvin/Documents/WorldOnRails-release_2":"/opt/carla-simulator/PythonAPI/carla":"/opt/carla-simulator/PythonAPI"



export recorder_filename=/home/calvin/Documents/WorldOnRails-release_2/record/RouteScenario_10_rep0.log
export id_number=563

python start_recording.py \
--recorder_filename=${recorder_filename}  \
--id=${id_number}


