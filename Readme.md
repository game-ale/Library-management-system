Library Management System
Overview
The Library Management System is designed to manage the operations of a library, including member management, book inventory, book borrowing, and fine management. 
This system provides various SQL queries to handle different aspects of library operations.

Features
•	Member Management: Track member details, membership status, and account types.
•	Book Inventory: Manage book details, categories, availability, and locations.
•	Book Borrowing: Handle book borrowing and returning processes.
•	Fine Management: Track fines due and payments made by members.
•	Reporting: Generate various reports related to members, books, and transactions.

SQL Queries

Member Management

1.	Fetch Member Details:
SELECT m.member_id, m.first_name, m.last_name, m.city, m.sex, ms.account_type, ms.account_status, 
ms.membership_start_date, ms.membership_end_date
FROM tbl_member m
JOIN tbl_member_status ms ON m.active_status_id = ms.active_status_id;

2.	Fetch Inactive Members:
 SELECT m.member_id, m.first_name, m.last_name, m.city, ms.account_type, ms.account_status, 
ms.membership_start_date, ms.membership_end_date
FROM tbl_member m
JOIN tbl_member_status ms ON m.active_status_id = ms.active_status_id
WHERE account_status = 'inactive';

3.	Fetch Student Members:
SELECT m.member_id, m.first_name, m.last_name, m.city, ms.account_type, ms.account_status, 
ms.membership_start_date, ms.membership_end_date
FROM tbl_member m
JOIN tbl_member_status ms ON m.active_status_id = ms.active_status_id
WHERE account_type = 'student';

4.	Fetch Inactive Student Members:
SELECT m.member_id, m.first_name, m.last_name, m.city, ms.account_type, ms.account_status, 
ms.membership_start_date, ms.membership_end_date
FROM tbl_member m
JOIN tbl_member_status ms ON m.active_status_id = ms.active_status_id
WHERE account_type = 'student' AND account_status = 'inactive';

5.	Fetch Members with Fines:
SELECT m.member_id, m.first_name, m.last_name, m.city, f.fine_date, f.fine_total,
ms.account_type, ms.account_status, 
ms.membership_start_date, ms.membership_end_date
FROM tbl_member m
JOIN tbl_fine_due f ON m.member_id = f.member_id
JOIN tbl_member_status ms ON m.active_status_id = ms.active_status_id;

Membership Statistics

1.	Total Active Members:
SELECT COUNT(*) AS total_active_members
FROM tbl_member m
JOIN tbl_member_status ms ON m.active_status_id = ms.active_status_id
WHERE account_status = 'active';

2.	Total Inactive Members:
SELECT COUNT(*) AS total_inactive_members
FROM tbl_member m
JOIN tbl_member_status ms ON m.active_status_id = ms.active_status_id
WHERE account_status = 'inactive';

Book Inventory

1.	Total Books in Library:
SELECT SUM(copies_total) AS total_books FROM tbl_book;

2.	Books Available for Borrowing:
SELECT SUM(copies_available) AS books_available_for_borrowing FROM tbl_book;

3.	Category-wise Book Count:
SELECT c.category_name, b.copies_total
FROM tbl_category c
JOIN tbl_book b ON b.category_id = c.category_id
ORDER BY b.copies_total DESC;

4.	Books in CSE Category:
SELECT SUM(copies_total) AS CSE
FROM tbl_category c
JOIN tbl_book b ON b.category_id = c.category_id
WHERE category_name = 'Computer Science';

Book Borrowing

1.	Return Book:
UPDATE tbl_book_issue SET issue_status = 'returned'
WHERE book_id = 2 AND member_id = 4;

UPDATE tbl_book SET copies_available = copies_available + 1
WHERE book_id = 2;

Reporting

1.	Count Total Books in Each Category:
SELECT c.category_name, COUNT(b.book_id) AS total_books
FROM tbl_category c
LEFT JOIN tbl_book b ON c.category_id = b.category_id
GROUP BY c.category_name;

2.	Members Who Have Issued Books:
SELECT m.first_name, m.last_name, COUNT(bi.issue_id) AS books_issued
FROM tbl_member m
JOIN tbl_book_issue bi ON m.member_id = bi.member_id
GROUP BY m.first_name, m.last_name
HAVING COUNT(bi.issue_id) > 0;

3.	Books Not Issued:
SELECT b.book_title
FROM tbl_book b
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_book_issue bi WHERE bi.book_id = b.book_id
);

4.	Book Availability Status:
SELECT b.book_title,
       CASE 
           WHEN b.copies_available > 0 THEN 'Available'
           ELSE 'Not Available'
       END AS availability_status
FROM tbl_book b;

5.	Total Members by Account Type:
SELECT ms.account_type, COUNT(m.member_id) AS total_members
FROM tbl_member_status ms
JOIN tbl_member m ON ms.active_status_id = m.active_status_id
GROUP BY ms.account_type;

6.	Book Request Details:
SELECT br.request_id, m.first_name, m.last_name, b.book_title
FROM tbl_book_request br
JOIN tbl_member m ON br.member_id = m.member_id
JOIN tbl_book b ON br.book_id = b.book_id;

7.	Highest Fine Paid:
SELECT MAX(fp.payment_amount) AS highest_fine FROM tbl_fine_payment fp;

8.	Books by Publication Year:
SELECT YEAR(b.publication_year) AS publication_year, COUNT(b.book_id) AS total_books
FROM tbl_book b
GROUP BY YEAR(b.publication_year)
HAVING COUNT(b.book_id) > 5;

9.	Latest Book Requests:
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

10.	Unique Languages of Publications:
SELECT DISTINCT p.publication_language FROM tbl_publisher p;

11.	Members with Multiple Book Requests:
SELECT m.first_name, m.last_name, COUNT(br.request_id) AS requests_count 
FROM tbl_member m 
JOIN tbl_book_request br ON m.member_id = br.member_id 
GROUP BY m.first_name, m.last_name 
HAVING COUNT(br.request_id) > 1;

12.	Books and Publisher Information:
SELECT b.book_title, p.publisher_name 
FROM tbl_book b 
JOIN tbl_publisher p ON b.publisher_id = p.publisher_id;

13.	Total Copies Available for Each Book:
SELECT b.book_title, SUM(b.copies_available) AS total_available_copies 
FROM tbl_book b 
GROUP BY b.book_title;

14.	Members Who Have Never Issued a Book:
SELECT m.first_name, m.last_name 
FROM tbl_member m 
WHERE NOT EXISTS (SELECT 1 FROM tbl_book_issue bi WHERE bi.member_id = m.member_id);

15.	Book Request Count by Title:
SELECT b.book_title, COUNT(br.request_id) AS request_count 
FROM tbl_book b 
LEFT JOIN tbl_book_request br ON b.book_id = br.book_id 
GROUP BY b.book_title;

16.	Total Fines Collected Each Month:
SELECT MONTH(fp.fine_date) AS month_collected, SUM(fp.fine_total) AS total_fines_collected 
FROM tbl_fine_due fp 
GROUP BY MONTH(fp.fine_date);

17.	Latest Book Added to the Library:
SELECT TOP 1 * FROM tbl_book ORDER BY publication_year DESC;

18.	Books and Their Locations:
SELECT b.book_title, l.shelf_no, l.shelf_name 
FROM tbl_book b 
JOIN tbl_location l ON b.location_id = l.location_id;



"# Library-management-system" 
