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

