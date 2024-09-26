FROM python:3.12-slim-bookworm

COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv
ADD . /app
WORKDIR /app
RUN rm -rf /app/.venv
RUN uv sync --frozen

ARG UID
ARG GID
ARG UNAME
RUN groupadd -g ${GID} -o ${UNAME}
RUN useradd -m -u ${UID} -g ${GID} -o -s /bin/bash ${UNAME}
USER ${UNAME}

ENTRYPOINT ["uv", "run","src/bot.py"]
