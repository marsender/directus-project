# directus-project

## Requirements

This project require the following to get started:

- Node.js v22.14 (lts/jod)
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
echo -n 'directus-db' > .env_db_database
echo -n 'directus-user' > .env_db_user
echo -n 'ChangeMe' > .env_db_password
echo -n 'ChangeMe' > .env_email_smtp_user
echo -n 'ChangeMe' > .env_email_smtp_password
echo -n '/' > .env_public_url
```

## Run app

```bash
npx directus start
```

Open the app in your browser http://localhost:8055/admin/login
