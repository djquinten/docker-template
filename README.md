# Laravel Docker Template
This is a template for a simple laravel project with docker. The default configuration uses sqlite as database driver. If you want to use postgres as database driver, follow the instructions below.

## Installation
1. Clone the repository
```bash
git clone git@github.com:djquinten/docker-template.git
```

2. Copy the repository to your project folder
```bash
cp -r docker-template/* your-project-folder/
```

3. Start the docker containers
```bash
docker-compose up -d
```

4. If you dont use npm packages, you can remove the `node` service from the `docker-compose.yml` file.

## Commands

### Build assets (if you use npm packages)
```bash
docker-compose run --rm node npm run build
```

### Watch assets (if you use npm packages)
```bash
docker-compose run --rm --publish 5173:5173 node npm run dev
```

### Startup the containers
```bash
docker-compose up -d
```

### Stop the containers
```bash
docker-compose down --remove-orphans
```

### Destroy the containers
```bash
docker-compose down --volumes --remove-orphans
```

### Run composer commands
```bash
docker-compose exec php composer <command>
```

### Run artisan commands
```bash
docker-compose exec php php artisan <command>
```

## Extra configurations

### Add a stripe webhook listener

1. Add the `STRIPE_SECTRET` to the `.env` file
```env
STRIPE_SECRET=sk_test_51
```

2. Add the following code to the docker-compose.yml. If your stripe endpoint is not `/stripe/webhook` change it to your endpoint.
```yml
    stripe:
          image: stripe/stripe-cli
          command: listen --api-key ${STRIPE_SECRET} --forward-to http://app:80/stripe/webhook
          networks:
                - laravel
          depends_on:
                - app
          stdin_open: true
          tty: true
          restart: no
```

### Use postgres as database driver

1. Update the database settings in the `.env` file
```env
DB_CONNECTION=pgsql
DB_HOST=postgres
DB_PORT=5432
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel
```

2. Add the following code to the `docker-compose.yml`
```yml
    postgres:
          image: postgres:13
          restart: always
          environment:
                POSTGRES_DB: laravel
                POSTGRES_USER: laravel
                POSTGRES_PASSWORD: laravel
          ports:
                - "5432:5432"
          networks:
                - laravel
```