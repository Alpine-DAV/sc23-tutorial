#!/bin/bash
set -ev
# use ascent's python build
source /ascent_docker_setup_env.sh

# catalyst needs newer cmake
curl -L https://github.com/Kitware/CMake/releases/download/v3.27.7/cmake-3.27.7-linux-x86_64.tar.gz -o cmake-3.27.7-linux-x86_64.tar.gz
tar -xzf cmake-3.27.7-linux-x86_64.tar.gz
export PATH=`pwd`/cmake-3.27.7-linux-x86_64/bin/:$PATH

# catalyst source, build, and install
curl -L https://gitlab.kitware.com/api/v4/projects/5912/packages/generic/catalyst/v2.0.0-rc4/catalyst-v2.0.0-rc4.tar.gz -o catalyst-v2.0.0-rc4.tar.gz
tar -xvf catalyst-v2.0.0-rc4.tar.gz
cmake -DCMAKE_INSTALL_PREFIX=`pwd`/catalyst-v2.0.0-rc4-install -DCATALYST_USE_MPI=ON -DCATALYST_WRAP_PYTHON=ON -B catalyst-v2.0.0-rc4-build -S catalyst-v2.0.0-rc4
cmake --build catalyst-v2.0.0-rc4-build
cmake --install catalyst-v2.0.0-rc4-build

# create script we can use for env setup to use catalyst via python
echo "export PYTHONPATH=$PYTHONPATH:`pwd`/catalyst-v2.0.0-rc4-install/lib/python3.9/site-packages/" >> catalyst_python_setup.sh
