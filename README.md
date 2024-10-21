# directus-project

## Requirements

This project require the following to get started:

- Node.js v18, specifically version 18.17 or higher and less than 19
- Mariadb or mysql database

## Install

Clone [Directus project repository](https://github.com/marsender/directus-project)

```bash
git clone git@github.com:marsender/directus-project.git
cd directus-project
```

## Create .env password files (-n do not append a newline)

```bash
echo -n 'ChangeMe' > .env_secret
echo -n 'ChangeMe' > .env_db_password
echo -n 'ChangeMe' > .env_email_smtp_password
echo -n '/' > .env_public_url
```

## Run app

```bash
npx directus start
```

Open the app in your browser http://localhost:8055/admin/login
