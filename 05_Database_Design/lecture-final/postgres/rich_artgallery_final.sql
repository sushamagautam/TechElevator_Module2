BEGIN TRANSACTION;

CREATE TABLE customer
(
        id serial,
        first_name varchar(30) NOT NULL,
        last_name varchar(45) NOT NULL,
        street_address1 varchar(100) NOT NULL,
        street_address2 varchar(100),
        city varchar(30) NOT NULL,
        state varchar(2) NOT NULL,
        zip varchar(10) NOT NULL,
        --ONE WAY OF DEFINING PKs
        CONSTRAINT pk_customer_id PRIMARY KEY (id)
);

CREATE TABLE artist
(
        id serial,
        first_name varchar(30) NOT NULL,
        last_name varchar(45) NOT NULL
);

-- ANOTHER WAY OF DEFINING PKs
ALTER TABLE artist
ADD CONSTRAINT pk_artist_id PRIMARY KEY (id);


CREATE TABLE art
(
        id serial,
        title varchar(128) NOT NULL,
        artist_id int NOT NULL,
        CONSTRAINT fk_art_artist FOREIGN KEY (artist_id) REFERENCES artist (id)
);


CREATE TABLE customer_purchase
(
        customer_id int NOT NULL,
        art_id int NOT NULL,
        purchase_date timestamp NOT NULL,
        price numeric(12,2) NOT NULL
);

-- CUSTOMER_PURCHASE NEEDS A PK AND FKs

ALTER TABLE customer_purchase
ADD CONSTRAINT pk_customer_purchase PRIMARY KEY (customer_id, art_id, purchase_date);



COMMIT;

BEGIN TRANSACTION;

-- A THIRD WAY OF DEFINING PKs
ALTER TABLE art
ADD CONSTRAINT pk_art_id PRIMARY KEY (id);

-- !! NOTICE THAT THE FK CONSTRAINTS ARE ADDED LAST. 
--    THIS ENSURES THAT ALL DEPENDENCIES HAVE BEEN CREATED 
--    ( OR ARE EXPECTED TO HAVE BEEN CREATED)

ALTER TABLE customer_purchase
ADD CONSTRAINT fk_customer_purchase_customer FOREIGN KEY (customer_id) REFERENCES customer (id);

ALTER TABLE customer_purchase
ADD CONSTRAINT fk_customer_purchase_art FOREIGN KEY (art_id) REFERENCES art (id);

COMMIT;

