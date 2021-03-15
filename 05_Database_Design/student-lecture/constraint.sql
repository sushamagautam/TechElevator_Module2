BEGIN TRANSACTION;

CREATE TABLE customer
(
        id serial,
        first_name varchar(64) NOT NULL,
        last_name varchar(45) NOT NULL,
        street_address1 varchar(100) NOT NULL,
        STREET_ADDRESS2 VARCHAR(100),
        city varchar(30) NOT NULL,
        state varchar(2) NOT NULL,
        zip varchar(10) NOT NULL
        --one way of creating PKs
        
);

ALTER TABLE customer
ADD CONSTRAINT pk_customer_id PRIMARY KEY (id);

CREATE TABLE artist
(
        id serial,
        first_name varchar(30) NOT NULL,
        last_name varchar(45) NOT NULL

);
--another way of defining PKs
ALTER TABLE artist
ADD cONSTRAINT pk_artist_id PRIMARY KEY (id);


CREATE TABLE art
(
        id serial,
        title varchar(128) NOT NULL,
        artist_id int NOT NULL

);

CREATE TABLE customer_purchase
(
        id SERIAL,
        customer_id int NOT NULL,
        art_id int NOT NULL,
        purchase_date timestamp NOT NULL,
        price money NOT NULL
);
--customer_purchase needs a PK and FKs

ALTER TABLE customer_purchase
ADD CONSTRAINT pk_customer_purchase PRIMARY KEY (customer_id, art_id, purchase_date);

ALTER TABLE customer_purchase
ADD CONSTRAINT fk_customer_purchase_customer FOREIGN KEY (customer_id) REFERENCES customer (id);

ALTER TABLE customer_purchase
ADD CONSTRAINT fk_customer_purchase_art FOREIGN KEY (art_id) REFERENCES art (id);

COMMIT;

BEGIN TRANSACTION;

--a third way of defining PKs
ALTER TABLE art
ADD CONSTRAINT pk_art_id PRIMARY KEY (id);

COMMIT;

--To drop the constraint:
--ALTER TABLE customer_purchase
--DROP CONSTRAINT fk_customer_purchase_art;



