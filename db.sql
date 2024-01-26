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

CREATE VIEW products_view AS
SELECT p.id, p.name as product_name, p.price as product_price, c.name as category_name
FROM products p
JOIN categories c
ON p.category_id = c.id;

SELECT * FROM products_view;

CREATE INDEX index_user_name
ON users (name);


-- Thêm mới sản phẩm
DELIMITER //
CREATE PROCEDURE ADD_PRODUCT(IN name_ varchar(100), price_ int, category_id_ int )
BEGIN
    INSERT INTO products (name, price, category_id) VALUES (name_, price_, category_id_);
END //
DELIMITER ;

-- Sửa sản phẩm
DELIMITER //
CREATE PROCEDURE UPDATE_PRODUCT(IN id_ int, name_ varchar(100), price_ int, category_id_ int )
BEGIN
    UPDATE products SET name=name_, price=price_, category_id=category_id_ WHERE id=id_;
END //
DELIMITER ;

-- Xoá sản phẩm
DELIMITER //
CREATE PROCEDURE DELETE_PRODUCT(IN id_ int )
BEGIN
    DELETE FROM products WHERE id=id_;
END //
DELIMITER ;

-- Tìm kiếm sản phẩm theo id
DELIMITER //
CREATE PROCEDURE SEARCH_PRODUCT_BY_ID(IN id_ int )
BEGIN
    SELECT * FROM products WHERE id=id_;
END //
DELIMITER ;

-- Phân trang
DELIMITER //
CREATE PROCEDURE PAGINATE(IN limit_ INT, page_current INT)
BEGIN
    DECLARE offset_value INT;

    SET offset_value = (page_current - 1) * limit_;

    SELECT * FROM products LIMIT limit_ OFFSET offset_value;
END //
DELIMITER ;

-- Test
CALL PAGINATE(3,1);

CALL ADD_PRODUCT('ao so mi','130','1');
CALL ADD_PRODUCT('quan jean','330','2');
CALL ADD_PRODUCT('quan dui','130','2');
CALL ADD_PRODUCT('mu bong chuyen','230','3');
CALL ADD_PRODUCT('giay da bong','530','4');
CALL ADD_PRODUCT('dep con tho','130','5');

CALL UPDATE_PRODUCT(6, 'ao tay ngan', '120',1);
select * from categories;

select * from products_view;

