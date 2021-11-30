# DQN in Reinforcement Learning based on Carla

```
The Logic of this RL model: 
利用 DQN 進行基於 Camera 的決策, loss 為 collision, speed and time.
缺點: Loss function設計不當, 預測只會轉圈圈因為loss 只在乎速度, 不要撞到以及遊戲時間時長
```


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
12. requirements.txt  
13. Edit settings in settings.py
14. Run with train.py
15. You can just play using play.py.
16. Add your own models via sources/models.py
```
