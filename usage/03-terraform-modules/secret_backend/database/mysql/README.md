# Need a database to run this module

- [mariadb](https://hub.docker.com/_/mariadb)

```
docker run --name mariadb -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 -d mariadb:lts
```

Access database

```
mysql --sql -h localhost -u root -p
```

Create test database 

```
CREATE DATABASE mydb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
show databases; 
```

## Test module

```
vault server -dev

terraform test
```
