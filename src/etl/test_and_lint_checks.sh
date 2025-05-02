#!/bin/bash

# Exit on error
set -e

echo "Running lint and test checks..."

# Store the exit status
status=0

# Run linting with flake8
echo "Running flake8..."
flake8 src/etl tests/ || status=$?

# Check import sorting with isort
echo "Checking imports with isort..."
isort src/etl tests/ --check-only || status=$?

# Format code with black (check only, no changes)
echo "Checking code formatting with black..."
black src/etl tests/ --check || status=$?

# Run type checking with mypy
echo "Running type checking with mypy..."
mypy src/etl tests/ || status=$?

# Run tests with pytest
echo "Running tests with pytest..."
pytest tests/ -v || status=$?

# Print final status
if [ $status -eq 0 ]; then
    echo "All checks passed successfully! ✅"
else
    echo "Some checks failed! ❌"
fi

exit $status