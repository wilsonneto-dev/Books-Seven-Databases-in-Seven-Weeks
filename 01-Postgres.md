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

/* lets create some tables */

drop table if exists authors;
drop table if exists publishers;
drop table if exists books;
drop table if exists notes;

create table authors (
    id int primary key,
    name varchar(256) unique not null,
    bio text
);

create table publishers (
    code char(3) primary key,
    name varchar(256) not null,
    description text
);

create table books (
    code int primary key,
    title varchar(256) unique,
    description text,
    author_id int references authors,
    publisher_code char(3) references publishers
);

create table notes (
    id int primary key,
    book_code int references books,
    note text not null
);

/* lets insert some data */
INSERT INTO authors (id, name, bio) VALUES
(1, 'Frederick P. Brooks Jr.', 'Author of "The Mythical Man-Month", known for insights into software project management.'),
(2, 'Donald E. Knuth', 'Author of "The Art of Computer Programming", an influential work in computer science.'),
(3, 'Martin Fowler', 'Author of "Refactoring: Improving the Design of Existing Code", renowned for his work on software design patterns and agile software development.'),
(4, 'Eric Evans', 'Author of "Domain-Driven Design: Tackling Complexity in the Heart of Software", known for his work on domain-driven design.');

INSERT INTO publishers (code, name, description) VALUES
('ADD', 'Addison-Wesley', 'A publisher known for its high-quality computer science and engineering texts.'),
('MIT', 'MIT Press', 'An academic publisher known for publishing cutting-edge research in computer science and technology.'),
('OXR', 'Oxford University Press', 'A renowned publisher with a wide range of academic and educational publications.');

INSERT INTO books (code, title, description, author_id, publisher_code) VALUES
(101, 'The Mythical Man-Month', 'Essays on software engineering and project management', 1, 'ADD'),
(102, 'The Art of Computer Programming', 'A comprehensive monograph written by Donald Knuth', 2, 'ADD'),
(103, 'Refactoring: Improving the Design of Existing Code', 'A book on software development and software engineering principles', 3, 'OXR');

INSERT INTO notes (id, book_code, note) VALUES
(1, 101, 'Highlights the importance of time estimation in software projects.'),
(2, 102, 'Considered one of the most comprehensive works in the field of algorithmic programming.'),
(3, 103, 'Introduces the concept of code smells and provides practical techniques for refactoring.');

insert into books
    (code, title, description)
values
    (1, 'Learning Domain Driven Design', 'Great DDD Book'),
    (2, 'Seven Databases in Seven Days', 'Great to learn more about databases');

/* lets get some data */

select * from books;
select * from authors;
select * from books inner join authors on books.author_id = authors.id;
select * from books left outer join authors on books.author_id = authors.id;
select * from books right outer join authors on books.author_id = authors.id;


```

![Alt text](image.png)

### B-tree index

A good standard index; values are stored as a balanced tree data structure; very flexible; B-tree indexes are the default in Postgres

### Hash index

Another good standard index in which each index value is unique; hash indexes tend to offer better performance for comparison operations than B-tree indexes but are less flexible and don’t allow for things like range queries

# Day 1 Home Work:

### Find

- Find the PostgreSQL documentation online and bookmark it.
- Acquaint yourself with the command-line \? and \h output.
- We briefly mentioned the MATCH FULL constraint. Find some information on the other available types of MATCH constraints.

### Do

- Select all the tables we created (and only those) from pg_class and examine the table to get a sense of what kinds of metadata Postgres stores about tables.
- Write a query that finds the country name of the Fight Club event.
- Alter the venues table such that it contains a Boolean column called active with a default value of TRUE.
- Understand better about the types of indexes for RDBMS
- Understand the B-tree and its function well
- Understand the Hash index and its function well

