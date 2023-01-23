SRC_DIR		= src
TEST_DIR	= tests
CHECK_DIRS 	= $(SRC_DIR) $(TEST_DIR)

check: format-check lint type-check test coverage ## Launch all check to approve the code

format: ## Format repository code
	poetry run black $(CHECK_DIRS)
	poetry run isort $(CHECK_DIRS)

format-check: ## Check the code format
	poetry run black --check $(CHECK_DIRS)
	poetry run isort --check $(CHECK_DIRS)


lint: ## Launch the linting tool
	poetry run pylint -j 0 -d duplicate-code $(SRC_DIR)
	poetry run pylint -j 0 -d duplicate-code -d missing-function-docstring -d missing-class-docstring -d redefined-outer-name $(TEST_DIR)

type-check: ## Launch the type checking tool
	poetry run mypy --ignore-missing-imports $(CHECK_DIRS)

test: ## Launch the tests
	poetry run pytest tests

update: ## Update python dependencies
	poetry update -vvv

help: ## Show the available commands
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'