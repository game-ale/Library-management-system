
 create database University_Library_Management;

use University_Library_Management;


/*Creating new table with name tbl_category consisting of category_id & category_name*/


CREATE TABLE tbl_category (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name VARCHAR(50)
);
/*Creating new table with name tbl_publisher consisting of publisher_id, pubisher_name, 
publication_language & publication_type*/

CREATE TABLE tbl_publisher (
    publisher_id INT IDENTITY(1,1) PRIMARY KEY,
    publisher_name VARCHAR(50),
    publication_language VARCHAR(15),
    publication_type VARCHAR(20)
);

/*Creating new table with name tbl_location consisting of location_id, shelf_no, 
shelf_name & floor_no*/

CREATE TABLE tbl_location (
    location_id INT IDENTITY(1,1) PRIMARY KEY,
    shelf_no VARCHAR(10),
    shelf_name VARCHAR(50),
    floor_no INT
);

/*Creating new table with name tbl_author consisting of author_id, first_name & last_name*/

CREATE TABLE tbl_author (
    author_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20)
);
/*Creating new table with name tbl_book consisting of book_id, isbn_code,book_title,category_id,publisher_id,
publication year, book edition, copies_total, copies_available & location_id*/

CREATE TABLE tbl_book (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    isbn_code VARCHAR(15),
    book_title VARCHAR(50),
    category_id INT,
    publisher_id INT,
    publication_year DATE,
    book_edition INT,
    copies_total INT,
    copies_available INT,
    location_id INT,
    CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES tbl_category(category_id),
    CONSTRAINT fk_publisher_id FOREIGN KEY (publisher_id) REFERENCES tbl_publisher(publisher_id),
    CONSTRAINT fk_location_id FOREIGN KEY (location_id) REFERENCES tbl_location(location_id)
);
/*Creating new table with name tbl_book_author consisting of book_id & author_id*/


CREATE TABLE tbl_book_author (
    book_id INT,
    author_id INT,
    CONSTRAINT fk_book_id FOREIGN KEY (book_id) REFERENCES tbl_book(book_id),
    CONSTRAINT fk_author_id FOREIGN KEY (author_id) REFERENCES tbl_author(author_id)
);
/*Creating new table with name tbl_member_status consisting of active_status_id, account_type,
account_status, membership_start_date & membership_end_date*/

CREATE TABLE tbl_member_status (
    active_status_id INT IDENTITY(1,1) PRIMARY KEY,
    account_type VARCHAR(20),
    account_status VARCHAR(10),
    membership_start_date DATE,
    membership_end_date DATE
);
/*Creating new table with name tbl_member consisting of member_id, first_name, last_name,
city, mobile_no, email_id, date_of_birth & active_status_id*/

CREATE TABLE tbl_member (
    member_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    city VARCHAR(20),
    mobile_no VARCHAR(10),
    email_id VARCHAR(50),
    date_of_birth DATE,
    active_status_id INT,
	sex VARCHAR(6)

    CONSTRAINT fk_active_status_id FOREIGN KEY (active_status_id) REFERENCES tbl_member_status(active_status_id)
);
/*Creating new table with name tbl_library_staff consisting of issue_by_id, staff_name & staff_designation*/


CREATE TABLE tbl_library_staff (
    issue_by_id INT IDENTITY(1,1) PRIMARY KEY,
    staff_name VARCHAR(50),
    staff_designation VARCHAR(20)
);
/*Creating new table with name tbl_book_issue consisting of issue_id, book_id, member_id,
issue_date, return_date, issue_status & issued_by_id*/

CREATE TABLE tbl_book_issue (
    issue_id INT IDENTITY(1,1) PRIMARY KEY,
    book_id INT,
    member_id INT,
    issue_date DATE,
    return_date DATE,
    issue_status VARCHAR(20),
    issued_by_id INT,
    CONSTRAINT fk_issue_book_id FOREIGN KEY (book_id) REFERENCES tbl_book(book_id),
    CONSTRAINT fk_issue_member_id FOREIGN KEY (member_id) REFERENCES tbl_member(member_id),
    CONSTRAINT fk_issue_issued_by_id FOREIGN KEY (issued_by_id) REFERENCES tbl_library_staff(issue_by_id)
);
/*Creating new table with name tbl_fine_due consisting of fine_id, member_id,
issue_id, fine_date & fine_total*/

CREATE TABLE tbl_fine_due (
    fine_id INT IDENTITY(1,1) PRIMARY KEY,
    member_id INT,
    issue_id INT,
    fine_date DATE,
    fine_total INT,
    CONSTRAINT fk_member_id FOREIGN KEY (member_id) REFERENCES tbl_member(member_id),
    CONSTRAINT fk_issue_id FOREIGN KEY (issue_id) REFERENCES tbl_book_issue(issue_id)
);
/*Creating new table with name tbl_fine_payment consisting of fine_payment_id, member_id,
payment_date & payment_amount*/

CREATE TABLE tbl_fine_payment (
    fine_payment_id INT IDENTITY(1,1) PRIMARY KEY,
    member_id INT,
    payment_date DATE,
    payment_amount INT,
    CONSTRAINT fk_payment_member_id FOREIGN KEY (member_id) REFERENCES tbl_member(member_id)
);
/*Creating new table with name tbl_book_request_status consisting of available_status_id, available_status
& nearest_available_date*/

CREATE TABLE tbl_book_request_status (
    available_status_id INT IDENTITY(1,1) PRIMARY KEY,
    available_status VARCHAR(10),
    nearest_available_date DATE
);
/*Creating new table with name tbl_book_request consisting of request_id, book_id, member_id,
request_date & available_status_id*/

CREATE TABLE tbl_book_request (
    request_id INT IDENTITY(1,1) PRIMARY KEY,
    book_id INT,
    member_id INT,
    request_date DATE,
    available_status_id INT,
    CONSTRAINT fk_request_book_id FOREIGN KEY (book_id) REFERENCES tbl_book(book_id),
    CONSTRAINT fk_request_member_id FOREIGN KEY (member_id) REFERENCES tbl_member(member_id),
    CONSTRAINT fk_request_available_status_id FOREIGN KEY (available_status_id) REFERENCES tbl_book_request_status(available_status_id)
);
GO

/*Insert data into table tbl_author */
select * from tbl_author
insert into tbl_author
values ('Frederik','Pow'),
('Larry','Niven'),
('Anne','McCattrecy'),
('Ray','Bradbury'),
('Wells','Hans'),
('Frank','Herbert'),
('Philip','K.Dick'),
('Arthur','C.Clarke'),
('Robert','Heinvein'),
('Isaac','Asimow'),
('William','Shakespeare');


/*Insert data into table tbl_category */

select * from tbl_category
insert into tbl_category
values('Computer Secience'), 
('Communication Tecnology'), 
('Software Develover'),
('Pharmacy'),
('applied Maths'),
('civil eng'),
('mechanical eng'),
('Romantic'), 
('aero space'), 
('Fiction'), 
('power and control'), 
('material eng'), 
('language')

/*Insert data into table tbl_location */

select *from tbl_location
insert into tbl_location 
values ('2','A',2),
('2','B',1),
('3','C',2),
('12','D',1),
('1','E',2),
('2','F',1),
('3','G',2),
('12','H',1),
('2','I',2),
('2','J',1),
('3','K',2),
('12','L',1)

/*Insert data into table tbl_publisher */

select * from tbl_publisher
insert into tbl_publisher
values('Elsevier','English','Technolog'), 
('MDPIAG','English','Research_Reports'), 
('Oxford University','English','Text Book'), 
('Wiley','English','Handbooks'),
('EthioPublish','Amharic','Fiction'),
('OroPublish','Afan Oromo','Fiction'),
('XYZ','English','Text Books'),
('XYZ','English','Text Books'),
('ZAB','English','Text Books'),
('ZAB','English','Magzines')



/*Insert data into table tbl_member_status */

select * from tbl_member_status

insert into tbl_member_status
values('student','active','2024','2025'),
('student','inactive','2023','2024'),
('professional','active','2024','2025'),
('professional','inactive','2023','2024'),
('staff','active','2024','2025'),
('staff','inactive','2023','2024')

/*Insert data into table tbl_member */


select * from tbl_member

insert into tbl_member
values('Ayana','Samuel','Shager','095644836','a@xyz.com','1996',1,'male'),
('Gemechu','Alemu','Robe','0946484736','gemeb@xyz.com','1990',2,'male'),
('Firaol','Gelana','Robe','0947487474','firoc@xyz.com','2000',3,'male'),
('Fatuma','kedir','Jimma','0937494643','faxe34@gmail.com','2000',4,'Female'),
('Megersa','Tekalign','Ambo','0953634635','mage34@gmail.com','2000',6,'Male'),
('Ayub','Nasir','Addis','0976575666','ayub354@gmail.com','2001',4,'Male'),
('Meklit','Hilemichael','Addis','0956363575','mek34@gmail.com','2004',5,'Female');



/*Insert data into table tbl_library_staff */

select * from tbl_library_staff

insert into tbl_library_staff
values('Hirut kassaa', 'Librarian'),
('Ahmed Adem', 'Librarian'),
('Tola Bariso', 'Head Librarian')


/*Insert data into table tbl_book */

select * from tbl_book

insert into tbl_book
values('9876543210001', 'sql', 1, 3, '2016',3,15,10,1),
('9876543210002', 'Concurrency', 2, 1, '2022',6,5,2,2),
('9876543210003', 'Database Recovery tips', 1, 2, '2004',1,10,5,3),
('9876543210001', 'Computer Networks: A Systems Approach', 1, 7, '2016',3,15,10,1),
('9876543210002', 'Artificial Intelligence: A Modern Approach', 1, 1, '2022',6,5,2,1),
('9876543210003', 'Software Engineering: A Practitioner Approach', 1, 1, '2004',1,10,5,1),
('9876543210001', 'Fundamentals of Wireless Communication', 2, 3, '2016',3,15,10,1),
('9876543210002', 'Data Communication and Networking', 2, 3, '2022',6,5,2,2),
('9876543210003', 'Satellite Communications', 2, 2, '2004',1,10,5,3),
('9876543210001', 'Head First Design Patterns', 3, 1, '2016',3,15,10,1),
('9876543210002', 'A Handbook of Agile Software Craftsmanship', 3, 7, '2022',6,5,2,2),
('9876543210003', 'JavaScript: The Good Parts', 3, 3, '2004',1,10,5,3),
('9876543210001', 'Pharmacology for Pharmacy Students', 4, 2, '2016',3,15,10,1),
('9876543210002', 'Pharmaceutical Calculations', 4, 1, '2022',6,5,2,2),
('9876543210003', 'Pharmaceutical Dispensing' ,4, 3, '2004',1,10,5,3),
('9876543210001', 'Applied Calculus', 5, 2, '2016',3,15,10,1),
('9876543210002', 'Differential Equations for Engineers', 5, 1, '2022',6,5,2,2),
('9876543210003', 'Linear Algebra and Its Applications', 5, 2, '2004',1,10,5,3),
('9876543210001', 'Fundamentals of Civil Engineering', 6, 3, '2016',3,15,10,1),
('9876543210002', 'Structural Analysis', 6, 1, '2022',6,5,2,2),
('9876543210003', 'Construction Engineering and Management', 6, 2, '2004',1,10,5,3),
('9876543210001', 'Engineering Mechanics: Statics', 7, 3, '2016',3,15,10,1),
('9876543210002', 'Introduction to Thermodynamics', 7, 2, '2022',6,5,2,2),
('9876543210003', 'Fluid Mechanics', 7, 7, '2004',1,10,5,3),
('9876543210001', 'Introduction to Aerospace Engineering', 9, 7, '2016',3,15,10,1),
('9876543210002', 'Aircraft Performance and Design', 9, 7, '2022',6,5,2,2),
('9876543210003', 'Spacecraft Systems Engineering', 9, 7, '2004',1,10,5,3),
('9876543210001', 'Modern Control Systems', 11, 7, '2016',3,15,10,1),
('9876543210002', 'Power Electronics Converters', 11, 7, '2022',6,5,2,2),
('9876543210003', 'Electric Power Systems', 11, 7, '2004',1,10,5,3),
('9876543210001', 'Materials Science and Engineering', 12, 7, '2016',3,15,10,1),
('9876543210002', 'Mechanical Behavior of Materials', 12, 7, '2022',6,5,2,2),
('9876543210003', 'Introduction to Materials Science for Engineers', 12, 7, '2004',1,10,5,3)


insert into tbl_book_author
values(1,1),(2,2),(3,3),(4,5),
(5,6),(6,6),(7,6),(8,7),(9,8),(10,8),
(11,8),(12,9),(1,9),(14,10),(15,11),
(16,8),(17,6),
(18,9),(19,10),(15,10)

/*Insert data into table tbl_book_issue*/

select * from tbl_book_issue

insert into tbl_book_issue
values(1 ,4, '2024', '2024-11-15', 'overdue', 1),
(1, 2, '2024-10-01', '2024-11-15', 'underdue', 1),
(2, 5, '2024-11-10', '2024-11-25', 'underdue', 1),
(2, 2, '2024-11-12', '2024-11-27', 'underdue', 2),
(2, 4, '2024-11-12', '2024-11-27', 'underdue', 2),
(1, 3, '2024-10-10', '2024-10-25', 'overrdue', 1),
(1, 2, '2024-10-10', '2024-10-25', 'overdue', 2)

/*Insert data into table tbl_fine_due*/
select * from tbl_fine_due
insert into tbl_fine_due
values(1,4,'2024-11-20',25),
(2,5,'2024-11-20',25),
(4,6,'2024-11-20',150)
/*Insert data into table tbl_fine_payment*/

select * from tbl_fine_payment

insert into tbl_fine_payment
values(2,'2024-11-20',25),
(4,'2024-11-20',25),
(5,'2024-11-20',150)
/*Insert data into table tbl_book_request_status*/

select * from tbl_book_request_status

insert into tbl_book_request_status
values('not_avail','2024-12-22'),
('not_avail','2024-12-30'),
('not_avail','2024-12-25'),
('available','2024-12-16')
/*Insert data into table tbl_book_request*/

select * from tbl_book_request

insert into tbl_book_request
values(1,3,'2024-10-15',3),
(1,3,'2024-10-15',4),
(2,2,'2024-10-15',4),
(3,4,'2024-10-15',1),
(3,4,'2024-10-15',2)

/*
Write a query to display all the member id, member name, city, account_type, 
account_status, membership start and end date.*/

select m.member_id, m.first_name, m.last_name, m.city,m.sex, ms.account_type, ms.account_status, 
ms.membership_start_date, ms.membership_end_date
from tbl_member m
join tbl_member_status ms on m.active_status_id=ms.active_status_id

/*
Write a query to display the member details whose account is inactive.*/

select m.member_id, m.first_name, m.last_name, m.city, ms.account_type, ms.account_status, 
ms.membership_start_date, ms.membership_end_date
from tbl_member m
join tbl_member_status ms on m.active_status_id=ms.active_status_id
where account_status='inactive'

/*
Write a query to display the member details whose account type is student.*/

select m.member_id, m.first_name, m.last_name, m.city, ms.account_type, ms.account_status, 
ms.membership_start_date, ms.membership_end_date
from tbl_member m
join tbl_member_status ms on m.active_status_id=ms.active_status_id
where account_type='student'
/*
Write a query to display the member details whose account type is student and account is  inactive.*/

select m.member_id, m.first_name, m.last_name, m.city, ms.account_type, ms.account_status, 
ms.membership_start_date, ms.membership_end_date
from tbl_member m
join tbl_member_status ms on m.active_status_id=ms.active_status_id
where account_type='student' and account_status='inactive'

/* 
Write a query to display the member details who have fine due.*/

select m.member_id, m.first_name, m.last_name, m.city, f.fine_date, f.fine_total,
ms.account_type, ms.account_status, 
ms.membership_start_date, ms.membership_end_date
from tbl_member m
join tbl_fine_due f on m.member_id=f.member_id
join tbl_member_status ms on m.active_status_id=ms.active_status_id
/* 
Write a query to display total number of active membership and inactive membership.*/
select count(*) as total_active_members
from tbl_member m
join tbl_member_status ms on m.active_status_id=ms.active_status_id
where account_status='active'
go
select count(*) as total_inactive_members
from tbl_member m
join tbl_member_status ms on m.active_status_id=ms.active_status_id
where account_status='inactive'

/* 
Write a query to display how many books this library owns.*/

select sum(copies_total) as total_books from tbl_book

/* 
Write a query to display how many books are available for borrowing.*/

select sum(copies_available) as books_available_for_borrowing from tbl_book

/* 
Write a query to display categorywise book count*/

select  c.category_name, b.copies_total
from tbl_category c
join tbl_book b on b.category_id=c.category_id
order by b.copies_total desc

/*
number of Under CSE category*/

select sum(copies_total) as CSE
from tbl_category c
join tbl_book b on b.category_id=c.category_id
where category_name='Computer Secience'

/*
Write a query to return book with book_id=2 to a member  with member_id=4*/

update tbl_book_issue set issue_status='returned'
where book_id=10 and  member_id=4
go
update tbl_book set copies_available=copies_available+1
where book_id=2

/*
Write a query to show fine details of member with member name='Fatuma' */

select m.member_id, m.first_name, m.last_name, m.city, f.fine_date, f.fine_total,
ms.account_type, ms.account_status, 
ms.membership_start_date, ms.membership_end_date
from tbl_member m
join tbl_fine_due f on m.member_id=f.member_id
join tbl_member_status ms on m.active_status_id=ms.active_status_id
where m.first_name='Fatuma' and m.last_name='Kedir'

-- Count total books in each category
SELECT c.category_name, COUNT(b.book_id) AS total_books
FROM tbl_category c
LEFT JOIN tbl_book b ON c.category_id = b.category_id
GROUP BY c.category_name;

-- Get members who have issued books
SELECT m.first_name, m.last_name, COUNT(bi.issue_id) AS books_issued
FROM tbl_member m
JOIN tbl_book_issue bi ON m.member_id = bi.member_id
GROUP BY m.first_name, m.last_name
HAVING COUNT(bi.issue_id) > 0;

-- List of books that have not been issued
SELECT b.book_title
FROM tbl_book b
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_book_issue bi WHERE bi.book_id = b.book_id
);

-- Fetch books and their availability status using CASE expression
SELECT b.book_title,
       CASE 
           WHEN b.copies_available > 0 THEN 'Available'
           ELSE 'Not Available'
       END AS availability_status
FROM tbl_book b;


-- Get the total number of members by account type
SELECT ms.account_type, COUNT(m.member_id) AS total_members
FROM tbl_member_status ms
JOIN tbl_member m ON ms.active_status_id = m.active_status_id
GROUP BY ms.account_type;

-- Fetch book request details along with member information      
SELECT br.request_id, m.first_name, m.last_name, b.book_title
FROM tbl_book_request br
JOIN tbl_member m ON br.member_id = m.member_id
JOIN tbl_book b ON br.book_id = b.book_id;

-- Get the highest fine paid by any member
SELECT MAX(fp.payment_amount) AS highest_fine FROM tbl_fine_payment fp;

-- Count of books by publication year using GROUP BY and HAVING clause to filter recent publications
SELECT YEAR(b.publication_year) AS publication_year, COUNT(b.book_id) AS total_books
FROM tbl_book b
GROUP BY YEAR(b.publication_year)
HAVING COUNT(b.book_id) > 5;

-- Fetch the latest book requests along with their status using JOINs and CASE expression for status display.   
SELECT br.request_id,
       m.first_name,
       m.last_name,
       b.book_title,
       CASE 
           WHEN br.available_status_id IS NOT NULL THEN 'Pending'
           ELSE 'Completed'
       END AS request_status
FROM tbl_book_request br
JOIN tbl_member m ON br.member_id = m.member_id
JOIN tbl_book b ON br.book_id = b.book_id;

-- Fetch all unique languages of publications in the library.     
SELECT DISTINCT p.publication_language FROM tbl_publisher p;

-- Get the member details who have requested more than one book.
SELECT m.first_name, m.last_name, COUNT(br.request_id) AS requests_count 
FROM tbl_member m 
JOIN tbl_book_request br ON m.member_id = br.member_id 
GROUP BY m.first_name, m.last_name 
HAVING COUNT(br.request_id) > 1;

-- Fetch all books and their corresponding publisher information.    
SELECT b.book_title, p.publisher_name 
FROM tbl_book b 
JOIN tbl_publisher p ON b.publisher_id = p.publisher_id;

-- Get the total number of copies available for each book.
SELECT b.book_title, SUM(b.copies_available) AS total_available_copies 
FROM tbl_book b 
GROUP BY b.book_title;

-- Fetch members who have never issued a book. 
SELECT m.first_name, m.last_name 
FROM tbl_member m 
WHERE NOT EXISTS (SELECT 1 FROM tbl_book_issue bi WHERE bi.member_id = m.member_id);

-- Count the number of requests made per book title.
SELECT b.book_title, COUNT(br.request_id) AS request_count 
FROM tbl_book b 
LEFT JOIN tbl_book_request br ON b.book_id = br.book_id 
GROUP BY b.book_title;

-- Get the total number of fines collected each month.
SELECT MONTH(fp.fine_date) AS month_collected, SUM(fp.fine_total) AS total_fines_collected 
FROM tbl_fine_due fp 
GROUP BY MONTH(fp.fine_date);

-- Fetch the details of the latest book added to the library. 
SELECT TOP 1 * FROM tbl_book ORDER BY publication_year DESC;

-- Fetch details of all books along with their location.
SELECT b.book_title, l.shelf_no, l.shelf_name 
FROM tbl_book b 
JOIN tbl_location l ON b.location_id = l.location_id;

-- Get the count of books requested by each member.                
SELECT m.first_name, m.last_name, COUNT(br.request_id) AS requests_count 
FROM tbl_member m 
LEFT JOIN tbl_book_request br ON m.member_id = br.member_id 
GROUP BY m.first_name, m.last_name;

-- Get total fines paid by each member using GROUP BY.
SELECT m.first_name, m.last_name, SUM(fp.payment_amount) AS total_paid_fines 
FROM tbl_member m 
LEFT JOIN tbl_fine_payment fp ON m.member_id = fp.member_id 
GROUP BY m.first_name, m.last_name;





