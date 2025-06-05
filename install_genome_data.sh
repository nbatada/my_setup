# genome sequence

# Create a directory for your reference genome
mkdir -p ~/references/hg19
cd ~/references/hg19

# Download the gzipped chromosome FASTA files
# Using wget with --timestamping helps avoid re-downloading if you run it again
wget --timestamping 'ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/*.fa.gz'

# Uncompress all gzipped FASTA files
gunzip *.fa.gz

# Concatenate all chromosome FASTA files into a single hg19.fasta
cat chr*.fa > hg19.fasta

# (Optional) Clean up individual chromosome files if you only need the combined one
rm chr*.fa
