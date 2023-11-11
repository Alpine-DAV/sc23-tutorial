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
cp -r /heat_diffusion /tutorial/

# build catalyst demo examples
source /ascent_docker_setup_env.sh
source /catalyst_docker_setup_env.sh
cd tutorial
git clone https://github.com/Alpine-DAV/catalyst-demo.git
cmake -B catalyst-demo/build -S catalyst-demo
cmake --build catalyst-demo/build
