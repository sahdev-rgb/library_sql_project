select * from books;
select* from branch;
select * from employee;
select * from issued_status;
select * from members;
select * from return_status;


-- Project task

-- #1 CRUD operation


-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
select * from books;
insert into books(isbn, book_title, category, rental_price, status, author, publisher)
values
('987-1-60129-456-2', 'To_Kill a Mockingbird', 'Classic', 6.00, 'yes','Harper Lee', 'J.B.Lippincott & Co.');

-- Task 2. Update an Existing Member's Address

update members
set member_address = '125 Main St'
where member_id = 'C101';

select * from members;

-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS104' from the issued_status table.

select * from issued_status
where issued_id = 'IS121';
delete from issued_status
where issued_id = 'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

select * from issued_status
where issued_emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.

select
issued_emp_id,
count(*)
from issued_status
group by 1
having count(*) >1;

-- #2 CTAS (Create Table As select)

-- Task 6: Create Summary Tables**: Used CTAS to generate 
-- new tables based on query results - each book and total book_issued_cnt
create table book_cnts
as
select  
	b.isbn,
    b.book_title,
    count(ist.issued_id) as no_issued
from books as b
join 
issued_status as ist
on ist.issued_book_isbn = b.isbn
group by 1, 2;

select * from
book_cnts;


-- # 3. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:

select * from books
where category ='Classic';

-- Task 8: Find Total Rental Income by Category:
select 
b.category,
sum(b.rental_price),
count(*)
from books as b
join 
issued_status as ist
on ist.issued_book_isbn = b.isbn
group by 1;

-- Task 9. **List Members Who Registered in the Last 180 Days**:
select * from members;


SELECT 
    member_id,
    member_name,
    reg_date
FROM 
    Members
WHERE 
    reg_date >= CURDATE() - INTERVAL 180 DAY;
    
-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:

select 
el.*,
b.branch_id,
e2.emp_name as manager
from employee  as el
join
branch as b
on b.branch_id = el.branch_id
join employee as e2
on b.manager_id = e2.emp_id;

 -- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold
 create table book_price_greater_then_seven
 as
 select * from books
 where rental_price > 7;
 
 -- Task 12: Retrieve the List of Books Not Yet Returned
 select * from books;
 select 
 distinct ist.issued_book_name
 from issued_status as ist
 left join
 return_status as rs
 on ist.issued_id = rs.issued_id
 where rs.return_id is null;
 
 
 
 -- #4 Advanced SQL Operations

-- Task 13: Identify Members with Overdue Books
-- Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's name, book title, issue date, and days overdue.
select * from issued_date;
select 
ist.issued_member_id,
m.member_name,
bk.book_title,
ist.issued_date,
-- rs.return_date,
current_date = ist.issued_date as over_dues_days

from issued_status as ist
join
members as m
on m.member_id = ist.issued_member_id
join
books as bk
on bk.isbn = ist.issued_book_isbn
left join
return_status as rs
on rs.issued_id = ist.issued_id
where 
rs.return_date is null
and
(current_date - ist.issued_date) >30

order by 1;

-- Task 14: Update Book Status on Return
-- Write a query to update the status of books in the books table to "available" when they are returned (based on entries in the return_status table).

SELECT * FROM issued_status 
WHERE issued_book_isbn = '978-0-451-52994-2';

UPDATE books SET status = 'no' 
WHERE isbn = '978-0-451-52994-2';

SELECT * FROM return_status 
WHERE issued_id = 'IS130';

INSERT INTO return_status(return_id, issued_id, return_date)
VALUES ('RS125', 'IS130', CURDATE());

SELECT * FROM return_status
 WHERE issued_id = 'IS130';


SELECT * FROM issued_status 
WHERE issued_book_isbn = '978-0-451-52994-2';
 
DELIMITER //

CREATE PROCEDURE add_return_records(
    IN p_return_id VARCHAR(50), 
    IN p_issued_id VARCHAR(50)
)
BEGIN
    DECLARE v_isbn VARCHAR(50);
    DECLARE v_book_name VARCHAR(255);

    INSERT INTO return_status(return_id, issued_id, return_date)
    VALUES (p_return_id, p_issued_id, CURDATE());

    SELECT issued_book_isbn, book_name 
    INTO v_isbn, v_book_name
    FROM issued_status
    WHERE issued_id = p_issued_id;

	UPDATE books
    SET status = 'yes'
    WHERE isbn = v_isbn;

    SELECT CONCAT('Thank you for returning the book: ', v_book_name) AS Message;

END //
 
 DELIMITER ;
 
 
-- Task 15: Branch Performance Report
-- Create a query that generates a performance report for each branch, showing the number
--  of books issued, the number of books returned, and the total revenue generated
--  from book rentals.

select * from branch;
select * from issued_status;
select * from employees;
select * from books;
select * from return_status;

create table branch_report
as
select
b.branch_id,
b.manager_id,
count(ist.issued_id) as number_book_issued,
count(rs.return_id) as number_of_book,
sum(bk.rental_price) as total_revenue

from issued_status as ist
join
employee as e
on e.emp_id = ist.issued_emp_id
join
branch as b
on e.branch_id = b.branch_id
left join 
return_status as rs
on rs.issued_id = ist.issued_id
join
books as bk
on ist.issued_book_isbn = bk.isbn

group by 1, 2;

select * from branch_report;

-- Task 16: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members 
-- containing members who have issued at least one book in the last 6 months.
create table active_members
select * from members 
where member_id in (
select 
distinct
issued_member_id
from issued_status
where
issued_date >= now() - interval 6 month);

select * from active_members;

-- Task 17: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues.
-- Display the employee name, number of books processed, and their branch.

select 
e.emp_name,
b.*,
count(ist.issued_id) as no_book_issued 
from issued_status as ist
join 
employee as e
on e.emp_id = ist.issued_emp_id
join
branch as b
on e.branch_id = b.branch_id
group by 1, 2;

-- 19

select * from books;

select *from issued_status;
 
/*Task 18: Stored Procedure
Objective: Create a stored procedure to manage the status of books in a library system.
    Description: Write a stored procedure that updates the status of a book based on its issuance or return. Specifically:
    If a book is issued, the status should change to 'no'.
    If a book is returned, the status should change to 'yes'.*/
 
 
 DELIMITER //

CREATE PROCEDURE issued_book (
    IN p_issued_id VARCHAR(50), 
    IN p_issued_member_id VARCHAR(50), 
    IN p_issued_book_name VARCHAR(50), -- नोट: यह पैरामीटर क्वेरी में कहीं इस्तेमाल नहीं हो रहा है
    IN p_issued_book_isbn VARCHAR(50), 
    IN p_issued_emp_id VARCHAR(50)
)
BEGIN
    DECLARE v_status VARCHAR(10);

    SELECT status
    INTO v_status
    FROM books
    WHERE isbn = p_issued_book_isbn;

    IF v_status = 'yes' THEN
        -- issued_status 
        INSERT INTO issued_status(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
        VALUES (p_issued_id, p_issued_member_id, NOW(), p_issued_book_isbn, p_issued_emp_id);
        
        UPDATE books
        SET status = 'no'
        WHERE isbn = p_issued_book_isbn;
        
	
        SELECT CONCAT('Book record is successfully added: ', p_issued_book_isbn) AS message;
        
    ELSE
        SELECT CONCAT('Sorry to inform you, the book you have requested is not available: ', p_issued_book_isbn) AS message;
        
    END IF;

END //

DELIMITER ;

select * from issued_status
where issued_book_isbn = '978-0-330-25864-8';


CALL issued_book('IS101', 'C101', 'The Great Gatsby', '978-0-330-25864-8', 'E101');

select * from books
where isbn = '978-0-330-25864-8';
