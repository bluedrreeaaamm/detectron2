#!/bin/bash
# using pip-tools
cd "$(dirname "$0")" || exit
rm -f ./requirements.txt
pip-compile --allow-unsafe requirements.in
