# Repository Guidelines

## Project Structure & Module Organization
- Source lives in `src/`; `src/bot.py` exposes async Telegram handlers and the `main()` entrypoint.
- Environment settings load from `.env` (`OBPATH`, `BOT`, `CHAT_ID`); keep personal vault paths out of git.
- Deployment assets sit alongside the root: `Dockerfile`, `docker-compose.yaml`, plus dependency manifests (`pyproject.toml`, `requirements.txt`, `uv.lock`).

## Build, Test, and Development Commands
- `uv run src/bot.py` — run the bot with uv-managed virtualenv, loading `.env` automatically.
- `pip install -r requirements.txt` then `python src/bot.py` — fallback workflow when not using uv.
- `docker compose up --build` — build and start the container; ensure a `.env` file exists in the project root.

## Coding Style & Naming Conventions
- Target Python 3.12 and PEP 8: 4-space indentation, snake_case for functions, Upper_Snake for constants.
- Prefer async-friendly patterns already in `src/bot.py`; reuse `logging` for diagnostics instead of `print`.
- Add docstrings for new handlers and clarify side effects such as filesystem writes.

## Testing Guidelines
- Establish `tests/` with `pytest` + `pytest-asyncio`; structure modules to import callable handlers directly.
- Use fixtures to supply temp Obsidian paths and fake Telegram updates; avoid touching real vault files.
- Run `pytest` (or `uv run pytest`) locally before each PR and document coverage gaps in the PR description.

## Commit & Pull Request Guidelines
- History favors short, imperative commit subjects (e.g., `Dockerfile using uv`); follow the same tone.
- Keep commits scoped; include body details when changing configs or introducing new env vars.
- PRs should outline behavior changes, reference issues, and attach logs or screenshots of bot runs when relevant.

## Security & Configuration
- Never check in secrets or Obsidian content. Rotate the Telegram token immediately if exposed.
- Document new `.env` keys in README and provide safe defaults; update deployment notes when Docker args change.
