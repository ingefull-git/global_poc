#!/bin/bash

# Directories to check
PYTHON_DIRS="$@"

# Run linting with flake8
flake8 $PYTHON_DIRS

# Check import sorting with isort
isort $PYTHON_DIRS --check-only

# Format code with black (check only, no changes)
black $PYTHON_DIRS --check

# Run type checking with mypy
mypy $PYTHON_DIRS

# Run tests with pytest
pytest $PYTHON_DIRS