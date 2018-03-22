#!/bin/bash

# Copyright (c) 2016 John McKenzie
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

CONF_DIR=${CUBERITE_CONF_DIR:-/etc/cuberite}
SERVER_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
SERVER_EXE=Cuberite

echo Configuration Directory: ${CONF_DIR}
echo Server Directory: ${SERVER_DIR}

# Remove existing symbolic links
for FILE in $(find ${SERVER_DIR} -type l); do
  echo Removing existing link for ${FILE}
  rm -f ${FILE}
done

# Create new symbolic links for files in CONF_DIR
for FILE in $(ls ${CONF_DIR}); do
  echo Linking ${CONF_DIR}/${FILE} to ${SERVER_DIR}/${FILE}
  ln -fs ${CONF_DIR}/${FILE} ${SERVER_DIR}/${FILE}
done

echo Starting Cuberite...
${SERVER_DIR}/${SERVER_EXE}
