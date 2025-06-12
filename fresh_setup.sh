chsh -s /bin/bash

https://www.xquartz.org/
https://github.com/XQuartz/XQuartz/releases/download/XQuartz-2.8.5/XQuartz-2.8.5.pkg

move dotfiles (.bashrc, .bash_profile, .emacs, .inputrc) to ~

ssh ssh-keygen 
scp ~/.ssh/id_ed25519.pub rbiodev.gilead.com:~/.ssh/
ssh $cluster
cd ~/.ssh
cat id_ed25519.pub >> authorized_key

bash ~/Miniconda3-latest-MacOSX-x86_64.sh -b -p $HOME/miniconda

#conda init bash ?

conda config --set ssl_verify false
conda install emacs -c conda-forge # alias emacs=/Users/nbatada/miniconda/bin/emacs

conda create -y --name python3.11 python=3.11
conda activate python3.11

conda install -c conda-forge r-base=4.3


conda install -c conda-forge -c bioconda jupyterlab scanpy scirpy pybedtools samtools

conda install bioconda::igv

# Setup so that you can use R in jupyter notebook
conda install -c conda-forge r-irkernel
conda install -c conda-forge r-essentials
jupyter lab

conda install -c conda-forge firefox
