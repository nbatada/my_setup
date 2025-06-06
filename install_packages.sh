# Python
conda config --add channels conda-forge --add channels bioconda 

#conda create -y -n condaenv python=3.8.5 samtools=1.3.1 bowtie2=2.4.1 pysam=0.16.0.1 pandas=1.1.2 python-igraph=0.8.3 biopython=1.77 \
conda activate condaenv


# menubar apps
https://apps.apple.com/us/app/next-meeting/id1017470484?mt=12 # Next meeting

# R
install.packages("BiocManager")
install.packages("remotes")


# Define CRAN, Bioconductor, and GitHub packages
cran_packages <- c(
    "tidyverse", "patchwork", "ComplexHeatmap", "RColorBrewer"
)

bioc_packages <- c(
    "DESeq2", "edgeR", "limma", "tximport", "tximeta",
    "biomaRt",
    "Seurat", "SingleCellExperiment", "scuttle", "DropletUtils", "SingleR",
    "GenomicRanges", "SummarizedExperiment", "AnnotationDbi",
    "clusterProfiler", "ReactomePA", "DOSE", "ggtree"
)

github_packages <- c(
    "omnideconv/immunedeconv"
)

install.packages("limSolve", repos = c('https://karlines.r-universe.dev', 'https://cloud.r-project.org'))
BiocManager::install("quantiseqr", update = FALSE, ask = FALSE)

# Install Bioconductor packages
for (pkg in bioc_packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
        BiocManager::install(pkg, update = FALSE, ask = FALSE)
    }
}

# Install CRAN packages
for (pkg in cran_packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
        install.packages(pkg)
    }
}

# Install GitHub packages
for (pkg in github_packages) {
    pkg_name <- sub(".*/", "", pkg) # Extract package name from "user/repo"
    if (!requireNamespace(pkg_name, quietly = TRUE)) {
        remotes::install_github(pkg)
    }
}

# Install organism-specific annotation packages if not installed
if (!requireNamespace("org.Hs.eg.db", quietly = TRUE)) {
    BiocManager::install("org.Hs.eg.db", update = FALSE, ask = FALSE)
}
if (!requireNamespace("org.Mm.eg.db", quietly = TRUE)) {
    BiocManager::install("org.Mm.eg.db", update = FALSE, ask = FALSE)
}




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

# SingleR
BiocManager::install("SingleR", force = TRUE)
