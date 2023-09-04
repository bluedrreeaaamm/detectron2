#!/bin/bash

# Exit the script if any command fails
set -e

# Specific Python version you want to use
PYTHON_VERSION="3.11.3"  # Change this to your desired version

# Initialize pyenv
eval "$(pyenv init -)"

# Set Python version using pyenv
pyenv local $PYTHON_VERSION

# Confirm the Python version
CURRENT_PYTHON_VERSION=$(python --version)
if [[ $CURRENT_PYTHON_VERSION != *"$PYTHON_VERSION"* ]]; then
    echo "Failed to set the Python version to $PYTHON_VERSION. Current version: $CURRENT_PYTHON_VERSION"
    exit 1
fi

# Set up the virtual environment at the root of the repo
VENV_DIR="venv"
if [ ! -d "$VENV_DIR" ]; then
    python -m venv $VENV_DIR
fi

# Activate the virtual environment
source $VENV_DIR/bin/activate

bash ./deps/update_deps.sh
# Install build dependencies from requirements.txt
if [ -f "./deps/requirements.txt" ]; then
    pip install -r ./deps/requirements.txt
else
    echo "./deps/requirements.txt not found!"
    exit 1
fi

# Build the wheel file
python setup.py bdist_wheel

# Deactivate virtual environment
deactivate

echo "Wheel file built successfully!"
