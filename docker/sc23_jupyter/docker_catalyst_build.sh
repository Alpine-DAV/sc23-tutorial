#!/bin/bash
# Copyright (c) Lawrence Livermore National Security, LLC and other Ascent
# Project developers. See top-level LICENSE AND COPYRIGHT files for dates and
# other details. No copyright assignment is required to contribute to Ascent.
set -ev
# use ascent's python build
source /ascent_docker_setup_env.sh

# catalyst needs newer cmake
curl -L https://github.com/Kitware/CMake/releases/download/v3.27.7/cmake-3.27.7-linux-x86_64.tar.gz -o cmake-3.27.7-linux-x86_64.tar.gz
tar -xzf cmake-3.27.7-linux-x86_64.tar.gz
export PATH=/cmake-3.27.7-linux-x86_64/bin/:$PATH

# catalyst source, build, and install
curl -L https://gitlab.kitware.com/api/v4/projects/5912/packages/generic/catalyst/v2.0.0-rc4/catalyst-v2.0.0-rc4.tar.gz -o catalyst-v2.0.0-rc4.tar.gz
tar -xvf catalyst-v2.0.0-rc4.tar.gz
rm -rf catalyst-v2.0.0-rc4.tar.gz
cmake -DCMAKE_INSTALL_PREFIX=/catalyst-v2.0.0-rc4-install -DCATALYST_USE_MPI=ON -DCATALYST_WRAP_PYTHON=ON -B catalyst-v2.0.0-rc4-build -S catalyst-v2.0.0-rc4
cmake --build catalyst-v2.0.0-rc4-build -j
cmake --install catalyst-v2.0.0-rc4-build

# install osmesa
apt-get update && apt-get -y install libosmesa6 libosmesa6-dev
# cleanup
apt-get clean

# download and build paraview
curl -L "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.11&type=source&os=Sources&downloadFile=ParaView-v5.11.2.tar.gz" -o ParaView-v5.11.2.tar.gz
tar -xzf ParaView-v5.11.2.tar.gz
rm -rf ParaView-v5.11.2.tar.gz

cmake -DVTK_OPENGL_HAS_OSMESA=ON \
      -DVTK_USE_X=OFF \
      -DVTK_MODULE_ENABLE_ParaView_InSitu=YES \
      -DPARAVIEW_ENABLE_CATALYST=YES \
      -DPARAVIEW_ENABLE_EXAMPLES=YES \
      -DPARAVIEW_USE_PYTHON=ON \
      -DPARAVIEW_USE_MPI=ON \
      -DPARAVIEW_USE_QT=OFF \
      -DPARAVIEW_USE_VTKM=OFF \
      -DCMAKE_PREFIX_PATH=/catalyst-v2.0.0-rc4-install/ \
      -Dcatalyst_DIR=/catalyst-v2.0.0-rc4-install/ \
      -S ParaView-v5.11.2 \
      -B ParaView-v5.11.2-build \
      -DCMAKE_INSTALL_PREFIX=/ParaView-v5.11.2-install
cmake --build ParaView-v5.11.2-build -j 6
cmake --install ParaView-v5.11.2-build

# create script we can use for env setup to use catalyst via python
echo "export PYTHONPATH=$PYTHONPATH:/catalyst-v2.0.0-rc4-install/lib/python3.9/site-packages/" >> catalyst_docker_setup_env.sh
echo "export CATALYST_IMPLEMENTATION_PATHS=/ParaView-v5.11.2-install/lib/catalyst/" >> catalyst_docker_setup_env.sh

# clean up build dirs
rm -rf /ascent/build
rm -rf /catalyst-v2.0.0-rc4-build
rm -rf /ParaView-v5.11.2-build
