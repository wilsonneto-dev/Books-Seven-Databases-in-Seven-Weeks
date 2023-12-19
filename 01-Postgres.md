# Introduction

- To run Postgres:
```bash
docker run --name my-local-postgres -p 5432:5432 -e POSTGRES_PASSWORD=tops3cr3tpass -d postgres
```

![Alt text](./.assets/image.png)

## Day 1

Playground:
```sql
create database store;

SELECT session_user, current_database();

create table books (
    code int primary key,
    title varchar(256) unique,
    description text
);

insert into books
    (code, title, description)
values
    (1, 'Learning Domain Driven Design', 'Great DDD Book'),
    (2, 'Seven Databases in Seven Days', 'Great to learn more about databases');

select * from books;

create table notes (
    id int primary key,
    book_code int references books,
    note text not null
);


```