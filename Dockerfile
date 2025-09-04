
# pgAdmin image
FROM dpage/pgadmin4:latest

# - PORT mapping -> PGADMIN_LISTEN_PORT (required on Render)
COPY start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

# Use fake credentials only and pass the real ones via env on Render.
ENV PGADMIN_DEFAULT_EMAIL=admin@example.com \
    PGADMIN_DEFAULT_PASSWORD=changeme \
    PGADMIN_LISTEN_ADDRESS=0.0.0.0

# temporary PORT. Render will $PORT or we can pass it to pgAdmin by using start.sh command line args
EXPOSE 8080

ENTRYPOINT ["/opt/start.sh"]