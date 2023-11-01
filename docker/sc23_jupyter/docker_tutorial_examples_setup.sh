#!/bin/bash
# Copyright (c) Lawrence Livermore National Security, LLC and other Ascent
# Project developers. See top-level LICENSE AND COPYRIGHT files for dates and
# other details. No copyright assignment is required to contribute to Ascent.
set -ev

# base dir for combined tutorial materials
mkdir /tutorial

# copy ascent tutorial content
cp -r /ascent/install/examples/ascent/tutorial/ascent_intro /tutorial/

# copy heat diffusion examples 
git clone https://github.com/jfavre/InSitu-Vis-Tutorial2022/
cp -r InSitu-Vis-Tutorial2022/Examples/HeatDiffusion /tutorial/
# cleanup
rm -rf InSitu-Vis-Tutorial2022


