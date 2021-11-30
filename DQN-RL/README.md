# DQN in Reinforcement Learning based on Carla

```
The Logic of Transfuser: 


Scenario Manager:    控制狀況的發生, 我們會設定當agent走到某點時會發生人車過馬路等等    
Autopilot:           IL 訓練時的target, 所有參數ex:加速度, 角速度都是規則寫的, 他在某點會收到紅綠燈state, 當觸發Scenario時, 也會收到state更新. 
Training:            車子在不同環境不同scenario進行訓練, Label為Autopilot的位置, Transfuser NN 不會收到state更新, 會開著 Lidar + Camera 開在跟Label相同的Scenario之下, 所以 NN 可以理解出例如:Lidar前方有人時就要停止, 紅綠燈為紅燈時該停止等等, Loss Function 為 |Wt' - Wt|, t為時間, Wt表示NN在時間t時的gps位置, Wt'表示Autopilot在時間t時的gps位置    
Prediction:          Transfuser NN 開著 Lidar + Camera 進行預測Control   
Transfuser Drawback: IL 太侷限在模擬 Autopilot 的行為, 導致generalism不好, 無法適應新環境, 且若 Autopilot 行為本身就有缺失的情況下, NN更難做出好的決策, ex:Autopilot 在撞到人後會停止, 或是在某些紅綠燈scenario下會停止, 這會導致 NN 預測時會常常中途停下來。 
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
