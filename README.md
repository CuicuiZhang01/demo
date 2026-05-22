1. ssh cuicuizhang7879@vista.tacc.utexas.edu
2. 
    2.1 scp -r Demo cuicuizhang7879@vista.tacc.utexas.edu:~
    OR
    2.2 git clone from github


完整过程是这样：

1. 本地创建项目文件夹

mkdir Demo
cd Demo

2. 创建测试文件 test.py

import torch
print("PyTorch version:", torch.__version__)
print("CUDA available:", torch.cuda.is_available())
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
x = torch.randn(3, 3).to(device)
print("Tensor device:", x.device)
print(x)

3. 创建 Slurm 脚本 run.slurm

#!/bin/bash
#SBATCH -J test
#SBATCH -o test.out
#SBATCH -e test.err
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 00:10:00
#SBATCH -A IRI25015
#SBATCH -p gh
cd ~/Demo
module purge
module load gcc
module load cuda
module load python3
source ~/Demo/venv/bin/activate
python3 test.py

4. 从本地上传整个文件夹到 Vista

scp -r Demo cuicuizhang7879@vista.tacc.utexas.edu:~

5. SSH 登录 Vista

ssh cuicuizhang7879@vista.tacc.utexas.edu

6. 进入 Demo 目录

cd ~/Demo

7. 创建 Python 虚拟环境

module purge
module load gcc
module load cuda
module load python3
python3 -m venv venv
source venv/bin/activate

8. 安装 PyTorch CUDA 版

pip install --upgrade pip
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu129

9. 提交 Slurm 作业

sbatch run.slurm

10. 查看作业状态

squeue -u $USER

状态含义：

PD = 排队
R  = 正在运行
CG = 正在结束/清理

11. 等作业结束后查看输出

cat test.out
cat test.err

12. 成功标志

如果看到：

CUDA available: True
Tensor device: cuda:0

说明 PyTorch 已经成功跑在 Vista GPU 节点上。

核心记住：

本地写代码
scp 上传
ssh 登录
sbatch 提交
squeue 查看
cat test.out 看结果

login node 不跑训练，compute node/GPU node 才跑训练。