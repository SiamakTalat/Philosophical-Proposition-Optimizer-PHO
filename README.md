# Philosophical-Proposition-Optimizer-PHO:
This reposity provide the main codes for the Philosophical Proposition Optimizer (ΦPO), which models knowledge acquisition based on philosophical propositions in epistemology.

## Requirements
- MATLAB R2018b or newer
- No toolboxes required

## Usage
```matlab
% Example: run PhO on 30D Sphere problem
nDim = 30; 
MaxIter = 500; 
nPop = 30;
out = PHO(nDim, MaxIter, nPop);
