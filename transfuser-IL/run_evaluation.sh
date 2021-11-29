#!/bin/bash

export CARLA_ROOT=/opt/carla-simulator
export CARLA_SERVER=${CARLA_ROOT}/CarlaUE4.sh
export PYTHONPATH=$PYTHONPATH:${CARLA_ROOT}/PythonAPI
export PYTHONPATH=$PYTHONPATH:${CARLA_ROOT}/PythonAPI/carla

#### Changed
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.10-py3.7-linux-x86_64.egg


export PYTHONPATH=$PYTHONPATH:leaderboard_1
export PYTHONPATH=$PYTHONPATH:leaderboard_1/team_code
export PYTHONPATH=$PYTHONPATH:scenario_runner_out

export LEADERBOARD_ROOT=/home/calvin/Documents/transfuser-retest3-demo
export CHALLENGE_TRACK_CODEAME=SENSORS
export PORT=2000 # same as the carla server port
export TM_PORT=14000 # port for traffic manager, required when spawning multiple servers/clients
export DEBUG_CHALLENGE=0
export REPETITIONS=1 # multiple evaluation runs
export SAVE_PATH=data/expert # path for saving episodes while evaluating
# export RESUME=True

### Default Evaluation
# export ROUTES=${LEADERBOARD_ROOT}/leaderboard_1/data/validation_routes/routes_town05_short.xml
# export TEAM_AGENT=leaderboard/team_code/auto_pilot.py # agent
# export TEAM_CONFIG=aim/log/aim_ckpt # model checkpoint, not required for expert
# export CHECKPOINT_ENDPOINT=results/sample_result.json # results file
export SCENARIOS=${LEADERBOARD_ROOT}/leaderboard_1/data/scenarios/no_scenarios.json
### Transfuser Evaluation
export ROUTES=${LEADERBOARD_ROOT}/leaderboard_1/data/evaluation_routes/routes_town05_long.xml
export TEAM_AGENT=${LEADERBOARD_ROOT}/team_code/transfuser_agent.py # agent
export TEAM_CONFIG=/home/calvin/Documents/models/transfuser  # model checkpoint, not required for expert
export CHECKPOINT_ENDPOINT=/home/calvin/Documents/transfuser-retest3-demo/results/transfuser_result_1.json # results file
# export SCENARIOS=${LEADERBOARD_ROOT}/leaderboard_1/data/scenarios/town05_all_scenarios.json
export RESUME=False
export RECORD_PATH=${LEADERBOARD_ROOT}/data/expert


python ${LEADERBOARD_ROOT}/leaderboard_evaluator.py \
--scenarios=${SCENARIOS}  \
--routes=${ROUTES} \
--repetitions=${REPETITIONS} \
--track=${CHALLENGE_TRACK_CODENAME} \
--checkpoint=${CHECKPOINT_ENDPOINT} \
--agent=${TEAM_AGENT} \
--agent-config=${TEAM_CONFIG} \
--debug=${DEBUG_CHALLENGE} \
--record=${RECORD_PATH} \
--resume=${RESUME} \
--port=${PORT} \
--trafficManagerPort=${TM_PORT}
