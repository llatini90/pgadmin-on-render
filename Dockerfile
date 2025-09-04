
# pgAdmin image
FROM dpage/pgadmin4:latest

#USER root

# - PORT mapping -> PGADMIN_LISTEN_PORT (required on Render)
#COPY start.sh /start.sh
#RUN chmod +x /start.sh

#COPY server.json /pgadmin4/server.json

#USER pgadmin

# Use fake credentials only and pass the real ones via env on Render.
ENV PGADMIN_DEFAULT_EMAIL=admin@example.com \
    PGADMIN_DEFAULT_PASSWORD=changeme \
    PGADMIN_LISTEN_ADDRESS=0.0.0.0

# temporary PORT. Render will $PORT or we can pass it to pgAdmin by using start.sh command line args
EXPOSE 80

#ENTRYPOINT ["/start.sh"]