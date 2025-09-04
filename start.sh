
#!/usr/bin/env bash
set -e

# Render sets $PORT; pgAdmin will use PGADMIN_LISTEN_PORT
export PGADMIN_LISTEN_PORT="${PORT:-80}"

# servers.json will be used if you pass DB variables via Render env settings
if [[ -n "$DB_HOST" && -n "$DB_NAME" && -n "$DB_USER" && -n "$DB_PASSWORD" ]]; then
  mkdir -p /pgadmin4
  cat > /pgadmin4/servers.json <<EOF
{
  "Servers": {
    "Render-Postgres": {
      "Name": "Render-Postgres",
      "Group": "Render",
      "Host": "${DB_HOST}",
      "Port": ${DB_PORT:-5432},
      "MaintenanceDB": "${DB_NAME}",
      "Username": "${DB_USER}",
      "SSLMode": "${DB_SSLMODE:-require}"
    }
  }
}
EOF
  echo "servers.json generato per ${DB_HOST}"
fi

# Make sure that the data dir exists (this will mount a persistent disk)
mkdir -p /var/lib/pgadmin

# Start the official docker image entrypoint
exec /entrypoint.sh