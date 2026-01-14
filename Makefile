.DEFAULT_GOAL := help
SHELL := /bin/bash

UV ?= uv
PYTHON ?= python3
PROJECT_DIR := $(CURDIR)
COMPOSE ?= docker compose
ENV_FILE ?= $(PROJECT_DIR)/.env

.PHONY: help deps run run-fallback test docker-up docker-down docker-logs clean check-env rust-build rust-run rust-test rust-docker-build rust-docker-up rust-docker-down rust-clean

help: ## Display available targets
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n\nTargets:\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

deps: ## Install project dependencies with uv
	@set -euo pipefail; \
	if [ -f uv.lock ]; then \
		echo "Syncing dependencies from uv.lock"; \
		$(UV) sync --frozen || $(UV) sync; \
	elif [ -f pyproject.toml ]; then \
		echo "Syncing dependencies from pyproject.toml"; \
		$(UV) sync; \
	elif [ -f requirements.txt ]; then \
		echo "Installing dependencies from requirements.txt"; \
		$(UV) pip sync requirements.txt || $(UV) pip install --requirements requirements.txt; \
	else \
		echo "No dependency manifest found. Skipping dependency installation."; \
	fi

check-env: ## Ensure the .env file exists before running the bot
	@[ -f "$(ENV_FILE)" ] || (echo "Missing .env at $(ENV_FILE). See README for setup instructions."; exit 1)

run: check-env ## Run the bot with uv (loads .env automatically)
	@$(UV) run src/bot.py

run-fallback: check-env ## Run the bot with python3 (requires manual env activation)
	@$(PYTHON) src/bot.py

test: ## Execute the pytest suite via uv
	@$(UV) run pytest

docker-up: check-env ## Build and start the bot via docker compose
	@$(COMPOSE) up --build

docker-down: ## Stop and remove docker compose services
	@$(COMPOSE) down

docker-logs: ## Tail docker compose logs
	@$(COMPOSE) logs -f

clean: ## Remove Python and pytest cache artifacts
	@find src -name "__pycache__" -type d -prune -exec rm -rf {} +
	@rm -rf .pytest_cache

