#!/bin/bash

# Run linting with flake8
flake8 .

# Check import sorting with isort
isort . --check-only

# Format code with black (check only, no changes)
black . --check

# Run type checking with mypy
mypy .

# Run tests with pytest
pytest -svv tests/