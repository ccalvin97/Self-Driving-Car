# Transfuser in Imitation Learning based on Carla

<img src="transfuser/assets/teaser.svg" height="192" hspace=30> <img src="transfuser/assets/full_arch.svg" width="400">


## Research Content:  
[Transfuser Paper](https://arxiv.org/pdf/2104.09224.pdf)    
[Model-based RL Paper](https://arxiv.org/abs/2105.00636)    
[Model-free RL Paper](https://arxiv.org/abs/1911.10868)   

## Contribution  
Edited by kuancalvin2016@gmail.com  
Original Code from Transfuser Official Github  

## Setup
PS. Please make sure you install all of the things by the right order.  

```
1. Nvidia GPU(GeForce GTX 1080 Mobile)  
2. Ubuntu 18.04   
3. Nvidia GPU Driver(470.63.01)  
4. CUDA(10.1)  
5. CuDNN(8.0.4)
6. Python 3.7 (Do not install from Anaconda) 
7. pyGame
8. Carla 0.9.10.1   
9. Dowload the additional maps from Carla  
10. vulkan-utils  
11. torch(1.4.0)  
```

**Trouble Shooting:**  
1. Import carla not found
- Ensure you have py3.7 egg file in the dir : /opt/carla-simulator/PythonAPI/carla/dist   
2. 4.26.2-0+++UE4+Release-4.26 522 0 Disabling core dumps. Exiting abnormally (error code: 1)  
- Install the latest or recommended nvidia driver  
- Downloaded the supported map package from official website.  
- sudo apt install vulkan-utils  


```Shell

## Dataset
The data is generated with ```leaderboard/team_code/auto_pilot.py``` in 8 CARLA towns using the routes and scenarios files provided at ```leaderboard/data``` on CARLA 0.9.10.1
```Shell
chmod +x download_data.sh
./download_data.sh
```
## Dataset  
The dataset can be downloaded from official Transfuser github or generated from autopilot programme.  

The datasets from official Transfuser github include two part.  
1. Weather Dataset: clear_weather_data, 14_weathers_data.  
2. Minimal dataset (63G), Large scale dataset (406G). 


## Data Generation
In addition to the dataset, we have also provided all the scripts used for generating data and these can be modified as required for different CARLA versions.

### Running CARLA Server

#### With Display
```Shell
./CarlaUE4.sh --world-port=2000 -opengl
```

#### Without Display

Without Docker:
```
SDL_VIDEODRIVER=offscreen SDL_HINT_CUDA_DEVICE=0 ./CarlaUE4.sh --world-port=2000 -opengl
```

With Docker:

Instructions for setting up docker are available [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker). Pull the docker image of CARLA 0.9.10.1 ```docker pull carlasim/carla:0.9.10.1```.

Docker 18:
```
docker run -it --rm -p 2000-2002:2000-2002 --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=0 carlasim/carla:0.9.10.1 ./CarlaUE4.sh --world-port=2000 -opengl
```

Docker 19:
```Shell
docker run -it --rm --net=host --gpus '"device=0"' carlasim/carla:0.9.10.1 ./CarlaUE4.sh --world-port=2000 -opengl
```

If the docker container doesn't start properly then add another environment variable ```-e SDL_AUDIODRIVER=dsp```.

### Run the Autopilot

Once the CARLA server is running, rollout the autopilot to start data generation.
```Shell
./leaderboard/scripts/run_evaluation.sh
```
The expert agent used for data generation is defined in ```leaderboard/team_code/auto_pilot.py```. Different variables which need to be set are specified in ```leaderboard/scripts/run_evaluation.sh```. The expert agent is based on the autopilot from [this codebase](https://github.com/bradyz/2020_CARLA_challenge).

### Routes and Scenarios

Each route is defined by a sequence of waypoints (and optionally a weather condition) that the agent needs to follow. Each scenario is defined by a trigger transform (location and orientation) and other actors present in that scenario (optional). The [leaderboard repository](https://github.com/carla-simulator/leaderboard/tree/master/data) provides a set of routes and scenarios files. To generate additional routes, spin up a CARLA server and follow the procedure below.

#### Generating routes with intersections
The position of traffic lights is used to localize intersections and (start_wp, end_wp) pairs are sampled in a grid centered at these points.
```Shell
python3 tools/generate_intersection_routes.py --save_file <path_of_generated_routes_file> --town <town_to_be_used>
```

#### Sampling individual junctions from a route
Each route in the provided routes file is interpolated into a dense sequence of waypoints and individual junctions are sampled from these based on change in navigational commands.
```Shell
python3 tools/sample_junctions.py --routes_file <xml_file_containing_routes> --save_file <path_of_generated_file>
```

#### Generating Scenarios
Additional scenarios are densely sampled in a grid centered at the locations from the [reference scenarios file](https://github.com/carla-simulator/leaderboard/blob/master/data/all_towns_traffic_scenarios_public.json). More scenario files can be found [here](https://github.com/carla-simulator/scenario_runner/tree/master/srunner/data).
```Shell
python3 tools/generate_scenarios.py --scenarios_file <scenarios_file_to_be_used_as_reference> --save_file <path_of_generated_json_file> --towns <town_to_be_used>
```

## Training
The training code and pretrained models are provided below.
```Shell
mkdir model_ckpt
wget https://s3.eu-central-1.amazonaws.com/avg-projects/transfuser/models.zip -P model_ckpt
unzip model_ckpt/models.zip -d model_ckpt/
rm model_ckpt/models.zip
```

Note that we have updated the pretrained TransFuser model with the improved checkpoint submitted to the leaderboard. This model contains multiple bug fixes and is trained on a different dataset than the one provided in this repository. (We are currently unable to share the entire dataset due to some issues.) 

- [CILRS](cilrs)
- [LBC](https://github.com/bradyz/2020_CARLA_challenge)
- [AIM](aim)
- [Late Fusion](late_fusion)
- [Geometric Fusion](geometric_fusion)
- [TransFuser](transfuser)

## Evaluation
Spin up a CARLA server (described above) and run the required agent. The adequate routes and scenarios files are provided in ```leaderboard/data``` and the required variables need to be set in ```leaderboard/scripts/run_evaluation.sh```.
```Shell
CUDA_VISIBLE_DEVICES=0 ./leaderboard/scripts/run_evaluation.sh
```

## CARLA Leaderboard Submission
CARLA also has an official [Autonomous Driving Leaderboard](https://leaderboard.carla.org/) on which different models can be evaluated. Refer to the [leaderboard_submission](https://github.com/autonomousvision/transfuser/tree/leaderboard_submission) branch in this repository for building docker image and submitting to the leaderboard.

## Acknowledgements
This implementation is based on code from several repositories.
- [2020_CARLA_challenge](https://github.com/bradyz/2020_CARLA_challenge)
- [OATomobile](https://github.com/OATML/oatomobile)
- [CARLA Leaderboard](https://github.com/carla-simulator/leaderboard)
- [Scenario Runner](https://github.com/carla-simulator/scenario_runner)

Also, check out other works on autonomous driving from our group.
- [Behl et al. - Label efficient visual abstractions for autonomous driving (IROS'20)](https://arxiv.org/pdf/2005.10091.pdf)
- [Ohn-Bar et al. - Learning Situational Driving (CVPR'20)](https://openaccess.thecvf.com/content_CVPR_2020/papers/Ohn-Bar_Learning_Situational_Driving_CVPR_2020_paper.pdf)
- [Prakash et al. - Exploring Data Aggregation in Policy Learning for Vision-based Urban Autonomous Driving (CVPR'20)](https://openaccess.thecvf.com/content_CVPR_2020/papers/Prakash_Exploring_Data_Aggregation_in_Policy_Learning_for_Vision-Based_Urban_Autonomous_CVPR_2020_paper.pdf)
