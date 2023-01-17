# Start from the rootproject/root base image with conda
FROM rootproject/root:6.22.06-conda

# Put the current repo (the one in which this Dockerfile resides) in the /analysis/skim directory
# Note that this directory is created on the fly and does not need to reside in the repo already
COPY . /analysis/skim

# Make /analysis/skim the default working directory (again, it will create the directory if it doesn't already exist)
WORKDIR /analysis/skim

# Compile an executable named 'skim' from the skim.cxx source file
RUN echo ">>> Compile skimming executable ..." &&  \
COMPILER=$(root-config --cxx) &&  \
FLAGS=$(root-config --cflags --libs) &&  \
$COMPILER -g -std=c++11 -O3 -Wall -Wextra -Wpedantic -o skim skim.cxx $FLAGS
