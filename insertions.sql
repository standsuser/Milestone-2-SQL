insert into users (username,user_password,email,user_role,phone_number)
values 
('ahmedd','ahmed201','ahmedd@gmail.com','Students',4567890),
('sameh','sameh32','samehff@gmail.com','Teaching assistants',1234567),
('layla_','2laylaa2','laylamo@gmail.com','Lecturers',9876543),
('jameel','JameeLL','jameel.ayman@gmail.com','External supervisors',34567899876),
('salmaaa','s@lma31','wsallma@gmail.com','Coordinators',859420494),
('judyy','juuudeeeee','judyywell@gmail.com','External examiners',6576744709),
('PizzaFactor','pizzaaaa','PizzaFactor@gmail.com','Companies',564783920),
('dina_mohamed','dmohamedd','dina_mohamed@gmail.com','Lecturers',6578392309),
('mostafasalem','moss272','mostafa22@gmail.com','Lecturers',083787837348),
('hassanwael','hwaell','hasswael@gmail.com','Lecturers',0123664378),
('beautycosmetics','cosmeticsb','bcomsmetics@gmail.com','Companies',54637892874),
('travelagency','travel5','thetravelagency@gmail.com','Companies',587573692),
('pcatering','caterer','partycaterers@gmail.com','Companies',083293383),
('ahmedaly','alyyylol','ahmedaly@gmail.com','external_examiners',0120655262887),
('mohamedmohamed','mohaaa232','mohamed@gmail.com','external_examiners',60607080),
('samerghanem','sameeeeeer','sameerghanem@gmail.com','external_examiners',75478728359),
('amalhany','ama3llll','amalhany@gmail.com','teaching_assistant',98498273498),
('amrhelaly','amramr','helaly@gmail.com','teaching_assistant',483098294),
('eyaddd','eyy323','eyad22@gmail.com','teaching_assistant',743946390),
('malakmohamed','moka11','malak@gmail.com','Coordinators',12332828),
('haniahany','HhHany','haniaaa@gmail.com','Coordinators',859420494),
('raghadtarmoom','raghadjpg','tarmoom@gmail.com','Coordinators',38383883),
('haythamamro','haythooo','amroo@gmail.com','Students',57275092759),
('aymanshady','aymooon','shadyy@gmail.com','Students',84759075),
('habiba.magdy','aboelmagd','habiba123@gmail.com','Students',7395798);

insert into lecturer(lecturer_id,schedule)
values (3,'sunday to thursday'),
(8,'saturday to tuesday'),
(9,'monday to wednesday '),
(10,'saturday,sunday and wednesday');

insert into lecturer_fields( lecturer_id,fields)
values (3,'computer science'),
(8,'business'),
(9,'psychology'),
(10,'engineering');

insert into company(company_id,company_name,representative_name,representative_email,company_location)
values (7,'PizzaFactory','pizza factory','PizzaFactor@gmail.com','uk berimingham street'),
(11,'beautycosmetics','beauty cosmetics','bcomsmetics@gmail.com','paris Le Marais'),
(12,'travelagency','the travel agency','thetravelagency@gmail.com','uk london'),
(13,'partycatering','party catering','partycaterers@gmail.com','cairo egypt ,new cairo');

insert into employee(staff_id,company_id,username,employee_password,email,field,phone)
values(34,7,'maryamamr','maryam1881','maryamamr@gmail.com','CEO',56738742989),
(35,11,'anasahmed','wanas26','anasahmed@gmail.com','Accountant',8372780928),
(36,12,'gamalhany','gamalHH','gamalhany@gmail.com','HR',0880877700),
(37,13,'malaksamir','samirk2','malaksamir@gmail.com','Supervisor',26376238762);

insert into external_examiner (external_examiner_id,schedule)
values(6,'9AM till 3 PM'),
(14,'8AM till 2 PM'),
(15,'10AM till 5 PM'),
(16,'2PM till 6 PM');

insert into teaching_assistant(teaching_assistant_id,schedule)
values(2,'wednesday to monday'),
(17,'sunday and monday'),
(18,'monday to thursday'),
(19,'only tuesday');

insert into coordinator(coordinator_id)
values(5),
(20),
(21),
(22);

insert into faculty(faculty_code,faculty_name,dean)
values(70,'computer science',3),
(71,'business',8),
(72,'psychology',9),
(73,'engineering',10);

insert into major(major_code,major_name,faculty_code)
values(123,'software eng',70),
(124,'marketing',71),
(125,'Clinical psychology',72),
(126,'mechanical eng',73);

insert into student(student_id,first_name,last_name,major_code,date_of_birth,adress,semester,gpa)
values(1,'ahmed','mazen',123,'2003-12-12','cairo',4,2.3), 
(23,'haytham','amro',123,'2004-06-05','cairo',2,2.3),
(24,'ayman','shady',124,'2002-09-13','cairo',6,3),
(25,'habiba','magdy',126,'2000-01-01','cairo',8,4.2);


insert into bachelor_project(code,project_name,submitted_materials,pdescription)
values(3425,'Cybersecurity','part one','project for security'),
(6272,'Product Management','last part','business bachelor project'),
(9289,'Data Science','part three','informatics and computer science '),
(2323,'Design Projects','design two','illusions designs');

insert into bachelor_submitted_materials(code,material)
values(3425,'java code'),
(6272,'managment file'),
(9289,'SQL code'),
(2323,'markers and paints');

insert into academic(academic_code,lecturer_id,teaching_assistant_id,external_examiner_id)
values (3222,3,2,6),
(3883,8,17,14),
(3729,9,18,15),
(3628,10,19,16);

insert into industrial(industrial_code,company_id,lecturer_id,staff_id)
values (90,7,3,34),
(91,11,8,35),
(92,12,9,36),
(93,13,10,37);
/*-----------------------------*/
insert into meeting(meeting_point,lecturer_id,meeting_date,start_time,end_time)
values ('point B',3,'2021-1-2','13:30','15:40'),
('point B',8,'2021-1-2','13:30','15:40'),
('point B',9,'2021-2-1','13:30','15:40'),
('point B',10,'2021-3-10','13:30','15:40');

insert into meeting_to_do_list (meeting_id,to_do_list)
values (1,'discuss project'),
(2,'troubleshoot code'),
(3,'plan outline'),
(4,'discuss grading scheme');

insert into meeting_attendents(meeting_id ,attendant_id )
values (1,1),
(1,3),
(2,8),
(2,23),
(3,24),
(3,9),
(4,25),
(4,10);

insert into thesis (student_id,title,deadline,pdf_doc,total_grade)
values (1,'student 1 thesis','2022-6-26','pdf 1',100),
(23,'student 2 thesis','2022-6-26','pdf 1',80),
(24,'student 3 thesis','2022-7-4','pdf 1',80),
(25,'student 4 thesis','2022-3-29','pdf 1',75);

insert into defense(student_id,defense_location,defense_time,defense_date,total_grade)
values (1,'s334','12:00','2022-3-12',65),
(23,'m201','13:00','2022-6-12',72),
(24,'m333','13:00','2023-1-5',89),
(25,'s112','15:00','2022-4-23',92);

insert into progress_report(student_id,content,updating_user_id,progress_report_date,grade)
values (1,'math quiz 2',3,'2022-9-7',72),
(23,'company report',7,'2023-4-7',23),
(24,'os midterm',9,'2022-12-14',55),
(25,'caterers report',13,'2022-12-17',80);

insert into grade_industrial_progress_report(lecturer_id,content,company_id,student_id,lecturer_grade,progress_report_date,company_grade)
values (3,'cs 2 report',7,1,89,'2022-9-7',100),
(8,'math  report',11,23,65,'2023-9-23',90),
(9,'databases report',12,24,70,'2022-12-4',65),
(10,'physics 2 report',13,25,89,'2022-12-17',75);

insert into grade_industrial_thesis(company_id, staff_id, student_id, title, company_grade, staff_grade)
values
(7

   company_id INTEGER,
    staff_id INTEGER,
    student_id INTEGER,
    title varchar(20),
    company_grade INTEGER,
    staff_grade INTEGER,
    PRIMARY KEY (student_id, title),
    FOREIGN KEY (company_id) REFERENCES company(company_id) ,
    FOREIGN KEY (staff_id, company_id) REFERENCES employee(staff_id, company_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id, title) REFERENCES thesis(student_id, title)

insert into grade_academic_progress_report(lecturer_id,student_id,lecturer_grade,progress_report_date)
values (3,1,89,'2022-9-8'),
(8,23,18,'2023-8-30'),
(9,24,100,'2022-12-4'),
(10,25,89,'2022-12-17');

insert into grade_academic_thesis(lecturer_id,external_examiner_id,student_id,title,lecturer_grade,external_examiner_grade)
values (3,6,1,'The effects of Tech on Industries',89,76),
(8,14,23,'Numerical Integration Applications',18,93),
(9,15,24,'Operating Systems: A Simpler Outlook',100,97),
(10,16,25,'Numerical Differentiation Using Java',89,90);

insert into grade_academic_defense(lecturer_id,external_examiner_id,student_id,defense_location,lecturer_grade,external_examiner_grade)
values (3,6,1,'s334',89,76),
(8,14,23,'m201',18,93),
(9,15,24,'m333',100,97),
(10,16,25,'s112',89,90);


insert into grade_industrial_defense(company_id,staff_id,student_id,defense_location,company_grade,employee_grade)
values (7,34,1,'s334',100,32),
(11,35,23,'m201',90,89),
(12,36,24,'m333',65,90),
(13,37,25,'s112',75);

insert into lecturer_recommend_external_examiner(lecturer_id,external_examiner_id,project_code)
values (3,6,3222),
(8,14,3883),
(9,15,3729),
(10,16,3628);

insert into student_preferences(student_id,preference_number,project_code)
values (1,78,3425),
(23,69,6272),
(24,88,9289),
(25,67,2323);

insert into major_has_bachelor_project(major_code,project_code)
values(123,3425),
(124,6272),
(125,9289),
(126,2323);