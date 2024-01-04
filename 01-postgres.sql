/*

create database store;
SELECT session_user, current_database();

*/

/* lets create some tables */

drop table if exists notes;
drop table if exists books;
drop table if exists authors;
drop table if exists publishers;

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
    published_at date,
    author_id int references authors,
    publisher_code char(3) references publishers
);

create table notes (
    id int primary key,
    book_code int references books,
    note text not null
);

create index books_date on books (published_at);
create index books_author_2 on books using btree (author_id);
create index books_author_3 on books using hash (author_id);


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

INSERT INTO books (code, title, published_at, description, author_id, publisher_code) VALUES
(101, 'The Mythical Man-Month', '2021-01-01', 'Essays on software engineering and project management', 1, 'ADD'),
(102, 'The Art of Computer Programming', '2019-01-01', 'A comprehensive monograph written by Donald Knuth', 2, 'ADD'),
(103, 'Refactoring: Improving the Design of Existing Code', '2015-01-01', 'A book on software development and software engineering principles', 3, 'OXR'),
(104, 'Domain-Driven Design: Tackling Complexity in the Heart of Software', '2013-01-01', 'A book on software development and software engineering principles', 4, 'OXR');

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
select authors.name, books.title from books inner join authors on books.author_id = authors.id;
select * from books left outer join authors on books.author_id = authors.id;
select * from books right outer join authors on books.author_id = authors.id;


select * from pg_class where relname in ('books', 'authors', 'notes', 'publishers');

/* Day 2 */

INSERT INTO books (code, title, published_at, description, author_id, publisher_code) VALUES
(130, 'Another Evans` book', '2021-01-01', 'Testing...', (select id from authors where name = 'Eric Evans'), 'ADD');

select * from books;

select count(*) from books;

select author_id, a.name, count(*) from books inner join authors a on books.author_id = a.id group by author_id, a.name, author_id;

select
    author_id, a.name, count(*) as qtd
from books
    inner join authors a
        on books.author_id = a.id
group by
    author_id, a.name, author_id
having
    count(*) > 1;

select distinct author_id from books;

/* transactions */

begin transaction;
    delete from notes;
rollback;

select * from notes;

/* views */
select books.code as code, authors.id as author_id, authors.name, books.title from books inner join authors on books.author_id = authors.id;

create view summary as
    select books.code as code, authors.id as author_id, authors.name, books.title from books inner join authors on books.author_id = authors.id;

select * from summary where code = 101;

/* materialized views */
create materialized view overview as
    select books.code as code, authors.id as author_id, authors.name, books.title from books inner join authors on books.author_id = authors.id;

select * from overview;

refresh materialized view overview;

INSERT INTO books (code, title, published_at, description, author_id, publisher_code) VALUES
(105, 'Another great book', '2021-01-01', 'Great one', 1, 'ADD'),
(106, 'Amazing book!', '2019-01-01', 'Amazing one', 2, 'ADD');
