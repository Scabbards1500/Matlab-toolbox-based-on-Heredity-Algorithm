# Matlab Toolbox Based on Heredity Algorithm

This repository contains an AI algorithm for path planning of autonomous pollination using robotic micro air vehicle pollinators (MPrs). The algorithm is based on the Heredity Algorithm and is designed specifically for future farming scenarios. By addressing the need for artificial pollination in the face of declining natural pollinators, this work aims to improve production efficiency in agricultural systems.

### Abstract

Food security is a pressing issue, particularly considering that approximately one-third of human food consumption depends on animal pollination. However, the decline in natural pollinators threatens the food supply. To address this problem, using micro air vehicle pollinators (MPrs) offers a potential solution by enabling efficient artificial pollination. This study aims to develop an AI algorithm based on the Heredity algorithm for the path planning of autonomous pollination, tailored explicitly for future farming scenarios where robotic MPrs are employed. By doing so, valuable insights can be gained into the autonomous design and manufacturing processes, ultimately leading to increased production efficiency. This research endeavours to bridge the gap between laboratory advancements and market implementation, facilitating a quicker transition and adoption of these technologies.

### Simulation Environment Modeling

The simulation environment models the movement and decision-making process of micro air vehicle pollinators in agricultural scenarios. The path planning algorithm leverages genetic principles to optimize the flight path for efficient pollination. Below are the results of the code:

![Simulation environment 1](https://user-images.githubusercontent.com/98506252/224027328-30da346d-33a0-446b-9f8e-4ab3cea9dbe3.png)<br>
*Simulation environment modeling 1*

![Simulation environment 2](https://user-images.githubusercontent.com/98506252/224027359-56a212aa-ea9f-406c-9563-4e499a8f138f.png)<br>
*Simulation environment modeling 2*

### Results

Below is the result of the path planning simulation:

![Path planning result](https://user-images.githubusercontent.com/98506252/224027540-2f0c62ef-969b-47d7-ab18-d87d8b58ebf6.png)<br>
*Path planning result of the algorithm*

### Function List

The following functions are included in the toolbox:

- **HA_Distance**: Calculate the distance between flowers
- **HA_DrawPath**: Draw path function
- **HA_Fitness**: Adaptation function
- **HA_InitPop**: Initial population
- **HA_Mutate**: Mutation operation
- **HA_OutputPath**: Output path function
- **HA_PathLength**: Calculate the path length of each individual
- **HA_Recombin**: Cross operation
- **HA_Reins**: Reinsert a new population of progeny
- **HA_Reverse**: Evolutionary reversal function
- **HA_Select**: Selective operation
- **HA_Sus**: The index number of the best individual
- **HA_Tabu**: Tabu algorithm function

### Running File

The main running file for the simulation is `HA_Main.m`.

### Paper

The full paper is available at [Springer Link](https://link.springer.com/chapter/10.1007/978-981-99-8498-5_30).
