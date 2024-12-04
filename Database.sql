create database savorly default charset utf8mb4;
use savorly;

-- 1. Users
CREATE TABLE users (
    userid INT AUTO_INCREMENT PRIMARY KEY,
    userrole INT DEFAULT 1, -- 1 Customer; 2 Staff;
    username VARCHAR(255) NOT NULL,
    userbirthday DATE NOT NULL,
    userphone VARCHAR(10) UNIQUE NOT NULL,
    useremail VARCHAR(255) UNIQUE NOT NULL,
    useraddress VARCHAR(255),
    useravatar VARCHAR(255) default '/images/blank-profile-picture.png',
    userpwd VARCHAR(255) NOT NULL
);

-- 2. Menu Items
CREATE TABLE menu_items (
    item_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(255) unique NOT NULL,
    item_type ENUM(
        'Course', 
        'Salad', 
        'Soup', 
        'Side Dish', -- món phụ 
        'Dessert',
        'Beverage', 
        'Snack', 
        'Breakfast', 
        'Lunch', 
        'Dinner'
    ) NOT NULL,
    item_description VARCHAR(255) DEFAULT NULL,
    item_price DECIMAL(10, 2) NOT NULL,
    item_status TINYINT(1) unsigned DEFAULT 1, -- 1 for available, 0 for unavailable
    img_url varchar(255) default '/public/images/logo.png'
);
-- Insert into menu_items table
INSERT INTO menu_items (item_name, item_type, item_description, item_price, item_status, img_url) VALUES
('Caesar Salad', 'Salad', 'Romaine lettuce, croutons, and Caesar dressing', 7.99, 1, '/public/images/CaesarSalad.jpg'),
('Tomato Soup', 'Soup', 'Classic tomato soup with basil', 5.99, 1, '/public/images/TomatoSoup.jpg'),
('Cheeseburger', 'Course', 'Beef burger with cheese, lettuce, and tomato', 9.99, 1, '/public/images/Cheeseburger.jpg'),
('Chocolate Cake', 'Dessert', 'Rich chocolate cake with ganache', 4.99, 1, '/public/images/ChocolateCake.jpg'),
('French Fries', 'Side Dish', 'Crispy golden fries', 2.49, 1, '/public/images/FrenchFries.jpg'),
('Iced Tea', 'Beverage', 'Refreshing iced tea with lemon', 2.99, 1, '/public/images/IcedTea.jpg'),
('Fruit Salad', 'Salad', 'Seasonal fruit mix', 3.99, 1, '/public/images/FruitSalad.jpg'),
('Pancakes', 'Breakfast', 'Fluffy pancakes with maple syrup', 5.49, 1, '/public/images/Pancakes.jpg'),
('Grilled Chicken Salad', 'Salad', 'Mixed greens topped with grilled chicken', 8.99, 1, '/public/images/GrilledChickenSalad.jpg'),
('Spaghetti Carbonara', 'Course', 'Pasta with pancetta, eggs, and parmesan', 11.99, 1, '/public/images/SpaghettiCarbonara.jpg'),
('Minestrone', 'Soup', 'Hearty vegetable soup with pasta', 6.49, 1, '/public/images/Minestrone.jpg'),
('Tiramisu', 'Dessert', 'Classic Italian coffee-flavored dessert', 5.99, 1, '/public/images/Tiramisu.jpg'),
('Garlic Bread', 'Side Dish', 'Toasted bread with garlic and herbs', 3.49, 1, '/public/images/GarlicBread.jpg'),
('Coca-Cola', 'Beverage', 'Refreshing cola drink', 1.99, 1, '/public/images/Coca-Cola.jpg'),
('Potato Chips', 'Snack', 'Crispy potato chips', 1.49, 1, '/public/images/PotatoChips.jpg');
SELECT * FROM menu_items;

-- 3. Table
create table restaurant_table(
 table_id int primary key auto_increment,
 table_number varchar(10) unique not null,
 seating_capacity int not null
);

-- 4. Reservation
create table reservation(
	reservation_id int primary key auto_increment,
    userid int,
    foreign key (userid) references users(userid) ON DELETE CASCADE ON UPDATE CASCADE,
    table_id int,
    foreign key (table_id) references restaurant_table(table_id) ON DELETE CASCADE ON UPDATE CASCADE,
    reservation_date date not null,
    special_request text default null,
    create_at timestamp default current_timestamp,
    status ENUM('booked','confirmed', 'completed', 'canceled') DEFAULT 'booked'
);

-- 5. Receipt 
CREATE TABLE receipt (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    userid INT,
    FOREIGN KEY (userid) REFERENCES users(userid) ON DELETE CASCADE ON UPDATE CASCADE,
    staff_id int,
    reservation_id INT DEFAULT NULL, -- Can be null if the order is not linked to a reservation
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10, 2) DEFAULT NULL,
    status ENUM ('Pending','Ordered' ,'Completed', 'Canceled') DEFAULT 'Pending' -- status can be pending, completed, canceled, etc.
);

-- 6. Order Item table ( Detail items in each receipt) chi tiết đơn hàng
CREATE TABLE Order_Item (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    item_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES receipt(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO restaurant_table (table_number, seating_capacity)
VALUES
    ('T01', 4),
    ('T02', 2),
    ('T03', 6),
    ('T04', 4),
    ('T05', 8),
    ('T06', 4),
    ('T07', 2),
    ('T08', 6),
    ('T09', 4),
    ('T10', 8),
    ('T11', 10),
    ('T12', 2),
    ('T13', 4),
    ('T14', 6),
    ('T15', 8),
    ('T16', 2),
    ('T17', 4),
    ('T18', 10),
    ('T19', 6),
    ('T20', 4);


select * from menu_items;		
select * from order_item;
select * from receipt;	
select * from reservation;
select * from restaurant_table;
select * from users;
SHOW CREATE TABLE reservation;

