#!/bin/bash
export CARLA_ROOT=/opt/carla-simulator
export CARLA_SERVER=${CARLA_ROOT}/CarlaUE4.sh

export WorldOnRails_root=/home/calvin/Documents/WorldOnRails-release_2/scenario_runner/srunner
export LEADERBOARD_ROOT=/home/calvin/Documents/WorldOnRails-release_2/leaderboard
export SCENARIO_RUNNER_ROOT=/home/calvin/Documents/WorldOnRails-release_2/scenario_runner
export PYTHONPATH=$PYTHONPATH:${SCENARIO_RUNNER_ROOT}:${LEADERBOARD_ROOT}:${WorldOnRails_root}:\
"/opt/carla-simulator/PythonAPI/carla":$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.12-py3.7-linux-x86_64.egg:\
"/home/calvin/Documents/WorldOnRails-release_2":"/opt/carla-simulator/PythonAPI/carla":"/opt/carla-simulator/PythonAPI"


export host=localhost
export trafficManagerSeed=0
export timeout=60
export port=2000
export repetitions=1 
export track=SENSORS
export checkpoint=./simulation_results.json
export resume=False
export RECORD=/home/calvin/Documents/WorldOnRails-release_2/record

python evaluate.py \
--host=${host}  \
--trafficManagerSeed=${trafficManagerSeed} \
--timeout=${timeout} \
--port=${port} \
--repetitions=${repetitions} \
--track=${track} \
--checkpoint=${checkpoint} \
--resume=${RESUME} \
--record=${RECORD} \

<<comment
    parser = argparse.ArgumentParser()

    parser.add_argument('--host', default='localhost',
                        help='IP of the host server (default: localhost)')
    parser.add_argument('--trafficManagerSeed', default='0',
                        help='Seed used by the TrafficManager (default: 0)')
    parser.add_argument('--timeout', default="60.0",
                        help='Set the CARLA client timeout value in seconds')

    parser.add_argument('--port', type=int, default=2000)

    parser.add_argument('--repetitions',
                        type=int,
                        default=1,
                        help='Number of repetitions per route.')
    parser.add_argument("--track", type=str, default='SENSORS', help="Participation track: SENSORS, MAP")
    parser.add_argument('--resume', type=bool, default=False, help='Resume execution from last checkpoint?')
    parser.add_argument("--checkpoint", type=str,
                        default='./simulation_results.json',
                        help="Path to checkpoint used for saving statistics and resuming")

    args = parser.parse_args()

comment