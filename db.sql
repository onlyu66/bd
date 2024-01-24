create database qlbh;
use qlbh;
create table categories(
	id int primary key auto_increment,
    name varchar(100) unique,
    status bit(1) default 1
);
create table products(
	id int primary key auto_increment,
    name varchar(100) unique,
    price int not null,
    category_id int,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);
create table users(
	id int primary key auto_increment,
    name varchar(100) not null,
    password varchar(100) not null,
    username varchar(100) unique
);
create table orders(
	id int primary key auto_increment,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    status bit(1) default 1,
    ship_address varchar(255) not null,
    phone_number varchar(15) not null
);
create table order_details(
	order_id int,
    product_id int,
    price int not null,
    quantity int,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

insert into categories (name) values('ao');
insert into categories (name) values('quan');
insert into categories (name) values('mu');
insert into categories (name) values('giay');
insert into categories (name) values('dep');

insert into products (name, price, category_id) values('ao ba lo',100,1);
insert into products (name, price, category_id) values('quan ong suong',200,2);
insert into products (name, price, category_id) values('mu luoi trai',50,3);
insert into products (name, price, category_id) values('giay co cao',300,4);
insert into products (name, price, category_id) values('dep con cuu',50,5);

insert into users (name,password,username) values('thai linh','123456','linh66');
insert into users (name,password,username) values('dang manh','123456','manh163');
insert into users (name,password,username) values('dinh toan','123456','toan177');
insert into users (name,password,username) values('bui bao','123456','bao3110');
insert into users (name,password,username) values('nguyen hoa','123456','hoa201');

insert into orders (user_id,ship_address,phone_number) values('1','ha noi','0363353173');
insert into orders (user_id,ship_address,phone_number) values('2','sai gon','0864353373');
insert into orders (user_id,ship_address,phone_number) values('3','nhat ban','0365553973');
insert into orders (user_id,ship_address,phone_number) values('1','sai gon','0368353983');
insert into orders (user_id,ship_address,phone_number) values('4','ha noi','044355173');

insert into order_details (order_id, product_id, price, quantity) values(1,2,200,3);
insert into order_details (order_id, product_id, price, quantity) values(2,5,50,6);
insert into order_details (order_id, product_id, price, quantity) values(3,4,300,5);
insert into order_details (order_id, product_id, price, quantity) values(4,1,100,1);
insert into order_details (order_id, product_id, price, quantity) values(5,2,200,2);

select c.*, count(p.id)
from categories c
join products p 
on c.id = p.category_id
group by c.id;

select p.*, c.name as category_name
from products p
join categories c
on p.category_id = c.id;

select o.id as id, u.name as name_user, o.ship_address as ship_address,
o.phone_number as phone_number, o.status as status, sum(od.price*od.quantity) as total_price
from orders o
join users u 
on o.user_id = u.id
join order_details od 
on o.id = od.order_id
group by o.id;

select od.order_id as order_id, p.name as product_name , od.price as price, od.quantity as quantity, od.price*od.quantity as total_price
from order_details od
join products p
on od.product_id = p.id
where od.order_id=1;
