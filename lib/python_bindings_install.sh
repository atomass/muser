#!/bin/bash
#
# Copyright (c) 2019 Nutanix Inc. All rights reserved.
#
# Authors: Thanos Makatos <thanos@nutanix.com>
#          Swapnil Ingle <swapnil.ingle@nutanix.com>
#          Felipe Franciosi <felipe@nutanix.com>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of Nutanix nor the names of its contributors may be
#       used to endorse or promote products derived from this software without
#       specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# 'python setup.py install' expects to find a directory named 'build' with
# subdirectories 'lib.linux-x86_64-2.7' and 'temp.linux-x86_64-2.7'. If not,
# then it tries to build, however there's no way to tell it where to put the
# binary files -- it puts them in the sources directory. These two directories
# are created during the build phase (by 'python setup.py build') and the
# binary files are explicitly stored under build/dbg.

# current directory is build/dbg/, move back to build/
cd ../

# now sylmink dbg to build (parent dir is also build)
ln -s dbg build

# now symlink'ed dir build contains lib.linux-x86_64-2.7 and
# temp.linux-x86_64-2.7

# --skip-build seems necessary otherwise 'python setup.py install' to tries to
# build because source files aren't found (we're under the build directory).
# We can't simply cd into the source directory and run the install command there
# because it expects to find the build/ directory there.
python ${1}/lib/setup.py install --skip-build
