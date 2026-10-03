FROM python:3.12-slim

RUN groupadd --system app && \
    useradd --system \
      --gid app \
      --home-dir /app \
      --shell /usr/sbin/nologin \
      app

WORKDIR /app

COPY --chown=app:app requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=app:app app.py .

EXPOSE 8080

USER app

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/health')" || exit 1

CMD ["python", "app.py"]