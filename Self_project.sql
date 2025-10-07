use self_project;
create table books(Book_ID serial primary key,Title varchar(100),Author varchar(100),Genre varchar(50),Published_Year int,Price decimal(10,2),Stock int);
create table customers(Customer_ID serial primary key ,Name varchar(50),Email varchar(100),Phone int,City varchar(50),Country varchar(50));
create table orders(Order_ID serial primary key,Customer_ID int references customers(Customer_ID),Book_ID int references Books(Book_ID),Order_Date date,Quantity int,Total_Amount decimal(10,2));


select * from books;
select * from customers;
select * from orders;


-- question for this project
/*Basic Queries */
-- question 1.) Retrieve all books in the "Fiction" genre 
select * from books;
select * from books where genre="Fiction";


-- question 2.) Find books published after the year 1950 
select * from books;
select * from books where published_year>1950 order by published_year,book_id;


-- question 3.) List all customers from the Canada 
select * from customers;
select * from customers where country="canada";


-- question 4.) Show orders placed in November 2023 
select * from orders;
select * from orders where order_date between'2023-11-01' and '2023-11-30' order by order_date;


-- question 5.) Retrieve the total stock of books available 
select * from books;
select * from orders;
select sum(stock) as total_stock from books;


-- question 6.) Find the details of the most expensive book 
select * from books;
select * from books where price =(select max(price) from books);
select * from books order  by price desc limit 1;


-- question 7.) Show all customers who ordered more than 1 quantity of a book 
select * from customers;
select * from orders;
select * from orders where quantity>1;


-- question 8.) Retrieve all orders where the total amount exceeds $20 
select * from orders;
select * from orders where Total_amount>20;


-- question 9.) List all genres available in the Books table 
select * from books;
select distinct genre from books;
select genre from books group by genre;
select genre,sum(price) as total from books group by genre;


-- question 10.) Find the book with the lowest stock 
select * from books;
select * from books order by stock asc limit 1;


-- question 11.) Calculate the total revenue generated from all orders
select * from orders;
select sum(total_amount) as revenue_generated from orders;






/* Advance Queries */
-- question 1.) Retrieve the total number of books sold for each genre 
select * from books;
select * from orders;
select b.genre,sum(o.quantity) from books as b inner join orders as o on b.book_id=o.book_id group by b.genre;



-- question 2.) Find the average price of books in the "Fantasy" genre 
select * from books;
select avg(price),genre as average_price from books where genre="fantasy";


-- question 3.) List customers who have placed at least 2 orders 
select * from orders;
select * from customers;
select customer_id,count(order_id) from orders group by customer_id having count(order_id) >=2;
select c.name,c.customer_id,count(o.order_id) as count from customers as c inner join orders as o
on c.customer_id=o.customer_id group by c.name,c.customer_id
having count(o.order_id)>=2 order by c.customer_id;




-- question 4.) Find the most frequently ordered book 
select * from orders;
select book_id,count(order_id)  as order_count from orders group by book_id order by order_count desc limit 1;
select * from books;
select * from orders;
select b.title,b.book_id,b.genre,count(o.order_id) as counting
from books as b
join orders as o
on b.book_id=o.book_id
group by b.title,b.book_id,b.genre
order by counting desc limit 1 ;


-- question 5.) Show the top 3 most expensive books of 'Fantasy' Genre 
select * from books;
select title,book_id from books where genre="fantasy" order by price desc limit 3;


-- question 6.) Retrieve the total quantity of books sold by each author 
select * from books;
select * from  orders;
select b.author,b.title,b.book_id,sum(o.quantity) as total_quantity
from books as b
join orders as o
on b.book_id=o.book_id
group by b.author,b.title,b.book_id;



-- question 7.) List the cities where customers who spent over $30 are located 
select * from customers;
select * from orders;
select distinct c.city,c.customer_id,c.name,o.order_id,o.total_amount
from customers as c
join orders as o
on c.customer_id=o.customer_id
where o.total_amount>30
order by o.total_amount;


-- question 8.) Find the customer who spent the most on orders 
select * from customers;
select * from orders;
select c.customer_id,c.name,sum(o.total_amount) as spent
from customers as c
join orders as o
on c.customer_id=o.customer_id
group by c.customer_id,c.name
order by  spent desc limit 1;



-- question 9.) Calculate the stock remaining after fulfilling all orders
select * from orders;
select * from books;
select b.book_id,b.title,b.author,b.stock,coalesce(sum(o.quantity),0) as ordered_qty,b.stock-coalesce(sum(o.quantity),0) as remainong_qty
from books as b
left join orders as o
on b.book_id=o.book_id
group by b.book_id,b.title,b.author;










