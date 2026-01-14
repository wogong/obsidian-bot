# Obsidian Bot

This is a Telegram bot that allows you to add log to your daily log in Obsidian.

## Steps

1. Create a new bot with @BotFather and obtain its token.
2. Obtain your UserID with @userinfobot.
3. Copy the `.env.example` to `.env` and update the config file with your own values.
4. Install the required packages with `pip install -r requirements.txt`, then run the bot with `python bot.py`.
5. Or, if you use `uv`, just run `uv run src/bot.py`.

## Configuration

| Variable | Required | Description |
|----------|----------|-------------|
| `OBPATH` | Yes | Path to your Obsidian vault directory |
| `BOT` | Yes | Telegram Bot token from @BotFather |
| `CHAT_ID` | Yes | Your Telegram user ID from @userinfobot |
| `UPTIME_URL` | No | Uptime Kuma push monitor URL for heartbeat |
| `INTERVAL` | No | Heartbeat interval in seconds (default: 60) |

## Usage

Message the bot and it will reply with "Saved.", which means ok or error information.

## Uptime Monitoring

The bot supports [Uptime Kuma](https://github.com/louislam/uptime-kuma) push monitors. To enable, set `UPTIME_URL` to your push monitor URL. The bot will send a heartbeat every `INTERVAL` seconds (default: 60).

## TODO
- [] Review today in history.