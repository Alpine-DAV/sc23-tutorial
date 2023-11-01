#!/bin/bash
# Copyright (c) Lawrence Livermore National Security, LLC and other Ascent
# Project developers. See top-level LICENSE AND COPYRIGHT files for dates and
# other details. No copyright assignment is required to contribute to Ascent.

export TAG_BASE=alpinedav/ascent:sc23_jupyter

date

python3 build_and_tag.py ${TAG_BASE} --squash

date

