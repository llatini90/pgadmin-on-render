#!/usr/bin/env bash
set -e

export PGADMIN_LISTEN_PORT="${PORT:-80}"
SSL_MODE="${DB_SSLMODE:-require}"

if [[ -n "$DB_HOST" && -n "$DB_NAME" && -n "$DB_USER" ]]; then
  mkdir -p /var/lib/pgadmin4
  cat > /var/lib/pgadmin4/servers.json <<EOF
{
  "Servers": {
    "Render-Postgres": {
      "Name": "Render-Postgres",
      "Group": "Render",
      "Host": "${DB_HOST}",
      "Port": ${DB_PORT:-5432},
      "MaintenanceDB": "${DB_NAME}",
      "Username": "${DB_USER}",
      "SSLMode": "${SSL_MODE}"
    }
  }
}
EOF
fi

mkdir -p /var/lib/pgadmin

if [ -f /entrypoint.sh ]; then
  exec /entrypoint.sh
elif [ -f /usr/local/bin/docker-entrypoint.sh ]; then
  exec /usr/local/bin/docker-entrypoint.sh
else
  echo "File /entrypoint.sh not found!" >&2
  exit 1
fi