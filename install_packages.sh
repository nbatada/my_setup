# install CNVkit (linux cluster)
git clone https://github.com/etal/cnvkit
cd cnvkit/
pip install biopython reportlab matplotlib numpy scipy pandas pyfaidx pysam
pip install -e .
python setup.py build
python setup.py install
#if (!require("BiocManager", quietly=TRUE))
#    install.packages("BiocManager")
BiocManager::install("DNAcopy")

# after 
echo 'export PYTHONPATH="/home/nbatada/git/cnvkit:$PYTHONPATH"' >> ~/.bashrc
echo 'alias cnvkit="python -m cnvlib.cnvkit"' >> ~/.bashrc
source ~/.bashrc

# now you can use cnvkit from command line




# R packages
# Immunedeconv
BiocManager::install(version = "3.17") # for R 4.3
install.packages("limSolve", repos = c('https://karlines.r-universe.dev', 'https://cloud.r-project.org'))
BiocManager::install("quantiseqr")
install.packages("remotes")
remotes::install_github("omnideconv/immunedeconv")
