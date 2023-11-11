#!/bin/bash
# Copyright (c) Lawrence Livermore National Security, LLC and other Ascent
# Project developers. See top-level LICENSE AND COPYRIGHT files for dates and
# other details. No copyright assignment is required to contribute to Ascent.
set -ev

export REPO_NAME="sc23_tutorial"
export TAG_ARCH=`uname -m`
export TAG_BASE=alpinedav/sc23_jupyter:ubuntu-22.04-${TAG_ARCH}

date

python3 docker_build_and_tag.py ${REPO_NAME} ${TAG_ARCH} ${TAG_BASE}

date

