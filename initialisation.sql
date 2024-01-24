CREATE TABLE roles
(
    role_id   serial PRIMARY KEY,
    role_name VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO roles (role_name)
VALUES ('admin'),
       ('employee');

CREATE TABLE accounts
(
    user_id  serial PRIMARY KEY,
    role_id  INT                 NOT NULL,
    FOREIGN KEY (role_id) REFERENCES roles (role_id),
    name     VARCHAR(50)         NOT NULL,
    password VARCHAR(50)         NOT NULL,
    email    VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE times
(
    time_id serial PRIMARY KEY,
    minutes INT NOT NULL
);

INSERT INTO times (minutes)
VALUES (15),
       (30),
       (60),
       (120),
       (180),
       (600);

CREATE TABLE types
(
    type_id serial PRIMARY KEY,
    name    VARCHAR(50) NOT NULL
);

INSERT INTO types (name)
VALUES ('child'),
       ('adult'),
       ('adult + child');

CREATE TABLE tickets
(
    ticket_id serial PRIMARY KEY,
    name      VARCHAR(50) UNIQUE NOT NULL,
    price     INT                NOT NULL,
    time_id   INT                NOT NULL,
    FOREIGN KEY (time_id) REFERENCES times (time_id),
    type_id   INT                NOT NULL,
    FOREIGN KEY (type_id) REFERENCES types (type_id)
);

INSERT INTO tickets (name, price, time_id, type_id)
VALUES ('Взрослый 1 час', 950, 3, 2),
       ('Детский 1 час', 850, 3, 1);

CREATE TABLE statuses
(
    status_id serial PRIMARY KEY,
    name      varchar(50) UNIQUE NOT NULL
);

INSERT INTO statuses (name)
VALUES ('paid'),
       ('using'),
       ('used');

CREATE TABLE orders
(
    order_id     serial PRIMARY KEY,
    full_name    VARCHAR(100) NOT NULL,
    price        INT          NOT NULL,
    status_id    INT          NOT NULL,
    FOREIGN KEY (status_id) REFERENCES statuses (status_id),
    date_paid    TIMESTAMP    NOT NULL,
    date_changed TIMESTAMP
);

CREATE TABLE order_items
(
    order_item_id serial PRIMARY KEY,
    order_id      INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    ticket_id     INT NOT NULL,
    FOREIGN KEY (ticket_id) REFERENCES tickets (ticket_id),
    count         INT NOT NULL
);