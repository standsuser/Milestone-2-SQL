--
CREATE PROC UserRegister /*figure out how to return password and user_id and also what to insert in the tables down below (also external supervisor doesnt exist??))*/
@usertype varchar(20),
@username varchar(20), 
@email varchar(50) , /*should i specify unique here or just in the first sql file*/
@first_name varchar(20),
@last_name varchar(20), 
@birth_date datetime, 
@GPA decimal(3,2), 
@semester int, 
@address varchar(100), 
@faculty_code varchar(10), 
@major_code varchar(10), 
@company_name varchar(20),
@representative_name varchar(20), 
@representative_email varchar(50), 
@phone_number varchar(20),
@country_of_residence varchar(20),
@users_id int output,
@password varchar(10) output
/* is this correct? should anything be not null should it be specific with nested ifs? or general?*/
AS
IF @usertype IS NULL or @username IS NULL or @email IS NULL 
print 'One of the main inputs is null'


IF @usertype = 'student' AND
 (@first_name IS NULL or 
    @last_name IS NULL or 
    @major_code IS NULL or 
    @birth_date IS NULL or 
    @address IS NULL or 
    @semester IS NULL or
    @gpa IS NULL)

print 'One of the student values is null'
ELSE IF @usertype = 'student'
BEGIN 
INSERT INTO users(user_role, username, email)
    VALUES (@usertype , @username , @email)
INSERT INTO student(first_name, last_name, major_code, date_of_birth,adress, semester, gpa)
    VALUES(@first_name, @last_name,@major_code, @birth_date,@address, @semester, @gpa )
   set @users_id = (select max(users_id) from users)
   set @password = (select max(users_id) from users)
    insert into users(user_password)
    values (@password)
END
IF @usertype = 'company' AND
 (@company_name IS NULL or 
@representative_name IS NULL or 
@representative_email IS NULL or 
@address IS NULL)  /*is location of company the address?*/

print 'One of the company values is null' 

ELSE IF @usertype = 'company'

BEGIN
INSERT INTO users(user_role, username, email)
    VALUES (@usertype ,  @username , @email)
INSERT INTO company(company_name, representative_name, representative_email, company_location )
    VALUES (@company_name, @representative_name, @representative_email, @address)

   set @users_id = (select max(users_id) from users)
   set @password = (select max(users_id) from users)
    insert into users(user_password)
    values (@password)
END
IF @usertype = 'teaching_assistant' 
BEGIN
 INSERT INTO users(username,email, user_role, phone_number)
    VALUES (@username, @email, @usertype, @phone_number)

END
IF @usertype = 'external_examiner'
   BEGIN 
   INSERT INTO users(username,email, user_role, phone_number)
     VALUES (@username, @email, @usertype, @phone_number)
END
IF @usertype = 'coordinator'
    BEGIN 
    INSERT INTO users(username,email, user_role, phone_number)
    VALUES (@username, @email, @usertype, @phone_number)
END
GO

CREATE PROC AddEmployee @company_id int, @email VARCHAR(50), @name VARCHAR(20), @phone_number VARCHAR(20), @field VARCHAR(25)
AS


