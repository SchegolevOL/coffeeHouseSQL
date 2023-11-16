create table "types _of_desserts"
(
    id        integer generated always as identity
        constraint "table_types _of_desserts_pk"
            primary key,
    price     integer            not null,
    is_delete smallint default 0 not null
);

alter table "types _of_desserts"
    owner to postgres;

create table types_of_drinks
(
    id        integer generated always as identity
        constraint table_types_of_drinks_pk
            primary key,
    price     integer            not null,
    is_delete smallint default 0 not null
);

alter table types_of_drinks
    owner to postgres;

create table languages
(
    id       integer generated always as identity
        constraint languages_pk
            primary key,
    language varchar(10) not null
);

alter table languages
    owner to postgres;

create table types_of_desserts_lang
(
    id_types_of_desserts integer      not null
        constraint "table_types_of_desserts_language_table_types _of_desserts_id_fk"
            references "types _of_desserts",
    type_name            varchar(254) not null,
    language             integer      not null
        constraint table_types_of_desserts_language_languages_id_fk
            references languages
);

alter table types_of_desserts_lang
    owner to postgres;

create table types_of_drinks_lang
(
    id_types_of_drinks integer      not null
        constraint table_types_of_drinks_language_table_types_of_drinks_id_fk
            references types_of_drinks,
    type_name          varchar(254) not null,
    language           integer      not null
        constraint table_types_of_drinks_language_languages_id_fk
            references languages
);

alter table types_of_drinks_lang
    owner to postgres;

create table posts
(
    id   integer generated always as identity
        constraint posts_pk
            primary key,
    post varchar(100) not null
);

alter table posts
    owner to postgres;

create table persons
(
    id         integer generated always as identity
        constraint persons_pk
            primary key,
    last_name  varchar(50) not null,
    first_name varchar(50) not null,
    patronymic varchar(50),
    email      varchar(100),
    phone      varchar(15) not null,
    post_id    integer
        constraint persons_posts_id_fk
            references posts
);

alter table persons
    owner to postgres;

create table clients
(
    last_name     varchar(254)       not null,
    " first_name" varchar(50)        not null,
    "patronymic " varchar(50),
    phone         varchar(15),
    date_of_birth date,
    discount      smallint default 0 not null,
    id            integer generated always as identity,
    is_delete     smallint default 0 not null,
    address       varchar(254)
);

alter table clients
    owner to postgres;

create table work_schedule
(
    id        integer generated always as identity
        constraint work_schedule_pk
            primary key,
    date      date    not null,
    person_id integer not null
        constraint work_schedule_persons_id_fk
            references persons
);

alter table work_schedule
    owner to postgres;

create table orders
(
    id        integer generated always as identity
        constraint orders_pk
            primary key,
    client_id integer not null
);

alter table orders
    owner to postgres;

create table order_composition
(
    order_id   integer not null
        constraint order_composition_orders_id_fk
            references orders,
    dessert_id integer
        constraint "order_composition_types _of_desserts_id_fk"
            references "types _of_desserts",
    drink_id   integer
        constraint order_composition_types_of_drinks_id_fk
            references types_of_drinks,
    person_id  integer not null
        constraint order_composition_persons_id_fk
            references persons
);

alter table order_composition
    owner to postgres;
------------------------------------------------------------------------------------------------------------------------
--INSERT table clients
INSERT INTO public.clients (last_name, " first_name", "patronymic ", phone, date_of_birth, discount, is_delete,
                            address)
VALUES ('Щеголев'::varchar(254), 'Олег'::varchar(50), 'Леонидович'::varchar(50), '+79090103500'::varchar(15),
        '1977-02-13'::date, 20::smallint,  0::smallint, 'Советская 23 -8'::varchar(254));

INSERT INTO public.clients (last_name, " first_name", "patronymic ", phone, date_of_birth, discount, is_delete,
                            address)
VALUES ('Иванов'::varchar(254), 'Иван'::varchar(50), 'Иванович'::varchar(50), '+795545603500'::varchar(15),
        '1999-06-14'::date, 5::smallint, 0::smallint, 'Советская 26 -23'::varchar(254));
------------------------------------------------------------------------------------------------------------------------


--добавление информация о новом заказе кофе
--adding information about a new coffee order
INSERT INTO public.orders (client_id)
VALUES (1);
INSERT INTO public.order_composition (order_id, dessert_id, drink_id, person_id)
VALUES (1, 1, null, 1);


