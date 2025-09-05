# directus-project

![CI](https://github.com/marsender/directus-project/workflows/CI/badge.svg)

This project is a self-hosted instance of Directus, an open-source data platform that provides a real-time GraphQL+REST API for your SQL database.

## Requirements

This project require the following to get started:

- Node.js v22.19 (lts/jod)
- Mariadb or mysql database

## Install

Clone [Directus project repository](https://github.com/marsender/directus-project)

```bash
git clone https://github.com/marsender/directus-project.git
cd directus-project
```

## Create .env password files (-n do not append a newline)

```bash
echo -n 'ChangeMe' > .env_secret
echo -n 'directus@your-domain.com' > .env_email_from
echo -n 'directus-db' > .env_db_database
echo -n 'directus-user' > .env_db_user
echo -n 'ChangeMe' > .env_db_password
echo -n 'your-domain.com' > .env_email_smtp_host
echo -n 'ChangeMe' > .env_email_smtp_user
echo -n 'ChangeMe' > .env_email_smtp_password
echo -n 'https://directus.your-domain.com/' > .env_public_url
echo -n 'https://your-domain.com/reset-password' > .env_password_reset_url_allow_list
echo -n 'https://your-domain.com/confirm-registration' > .env_user_invite_url_allow_list
```

## Run app

```bash
npx directus start
```

Open the app in your browser http://localhost:8055/admin/login

## Backup database

```bash
./cmd/backup_db.sh
```

## Upgrade Directus

Get the latest version number from https://github.com/directus/directus and update it in package.json, e.g.: "directus": "^11.9.2"

```bash
npm update
npx directus database migrate:latest
```
