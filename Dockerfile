FROM python:3.9-slim-buster as compile

RUN apt-get update \
    && apt-get -y upgrade \
    && rm -rf /var/lib/apt/lists/*

RUN python -m pip install --no-compile --upgrade pip wheel poetry

WORKDIR /usr/src/app

RUN python -m venv --copies /usr/src/app/.venv
ENV PATH=/usr/src/app/.venv/bin:$PATH \
    POETRY_VIRTUALENVS_CREATE=false

COPY pyproject.toml .
COPY poetry.lock .

RUN poetry install --no-dev --no-root -n && \
    find . -name "*.py[co]" -o -name __pycache__ -exec rm -rf {} +


FROM python:3.9-slim-buster

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install wget ttf-dejavu fonts-freefont-ttf fonts-liberation tini \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && mkdir -p /tmp/wk && \
    wget -O /tmp/wk/wk.deb https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb && \
    apt-get install -y /tmp/wk/wk.deb && \
    rm -rf /tmp/wk \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY --from=compile /usr/src/app/.venv .venv
COPY src/app.py app.py

ENV PATH=/usr/src/app/.venv/bin:$PATH

ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 8080

CMD ["uvicorn", "--host", "0.0.0.0", "--port", "8080", "app:app"]
