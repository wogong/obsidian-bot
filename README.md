# Obsidian Bot

This is a Telegram bot that allows you to add log to your daily log in Obsidian.

## Steps

1. Create a new bot with @BotFather and obtain its token.
2. Obtain your UserID with @userinfobot.
3. Copy the `.env.example` to `.env` and update the config file with your own values.
4. Install the required packages with `pip install -r requirements.txt`, then run the bot with `python bot.py`.
5. Or, if you use `uv`, just run `uv run src/bot.py`.

## Usage

Message the bot and it will reply with "Saved.", which means ok or error information.

## TODO
- [] Review today in history.