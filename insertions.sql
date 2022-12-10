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
('ahmedaly','alyyylol','ahmedaly@gmail.com','External examiners',0120655262887),
('mohamedmohamed','mohaaa232','mohamed@gmail.com','External examiners',60607080),
('samerghanem','sameeeeeer','sameerghanem@gmail.com','External examiners',75478728359),
('amalhany','ama3llll','amalhany@gmail.com','Teaching assistants',98498273498),
('amrhelaly','amramr','helaly@gmail.com','Teaching assistants',483098294),
('eyaddd','eyy323','eyad22@gmail.com','Teaching assistants',743946390),
('malakmohamed','moka11','malak@gmail.com','Coordinators',12332828),
('haniahany','HhHany','haniaaa@gmail.com','Coordinators',859420494),
('raghadtarmoom','raghadjpg','tarmoom@gmail.com','Coordinators',38383883),
('haythamamro','haythooo','amroo@gmail.com','Students',57275092759),
('aymanshady','aymooon','shadyy@gmail.com','Students',84759075),
('habiba.magdy','aboelmagd','habiba123@gmail.com','Students',7395798),
('mariammohamed','marioma','marioma@gmail.com','Students',0192783683),
('mohamedmohamed','elmohamed','mohamed23@gmail.com','Students',52652833),
('hanaahmed','hanaa','hana65@gmail.com','Students',383738739),
('marwanmohamed','yuyumarwan','marwan45@gmail.com','Students',39373897);

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

insert into bachelor_project(project_name,submitted_materials,pdescription)
values('Cybersecurity','part one','project for security'),
('Product Management','last part','business bachelor project'),
('Data Science','part three','informatics and computer science '),
('Design Projects','design two','illusions designs'),
('Business','part one','project for business'),
('Management','fifth part','business bachelor project'),
('Databases ','part three','informatics and computer science '),
('Design Project 1','design three','illusions designs');

insert into student(student_id,first_name,last_name,major_code,date_of_birth,adress,semester,gpa, TotalBachelorGrade, Assigned_Project_Code )
values(1,'ahmed','mazen',123,'2003-12-12','cairo',4,2.3,74,1), 
(23,'haytham','amro',123,'2004-06-05','cairo',2,2.3,89,2),
(24,'ayman','shady',124,'2002-09-13','cairo',6,3,78,3),
(25,'habiba','magdy',126,'2000-01-01','cairo',8,4.2,68,4),
(26,'mariam','mohamed',123,'2003-09-14','cairo',3,0.7,93,5),
(27,'mohamed','mohamed',124,'2002-03-03','cairo',4,4,89,6),
(28,'hana','ahmed',125,'2002-03-04','cairo',6,3,92,7),
(29,'marwan','mohamed',126,'2003-11-30','cairo',2,1.2,93,8);


insert into bachelor_submitted_materials(code,material)
values(1,'java code'),
(2,'managment file'),
(3,'SQL code'),
(4,'markers and paints');

insert into academic(academic_code,lecturer_id,teaching_assistant_id,external_examiner_id)
values (5,3,2,6),
(6,8,17,14),
(7,9,18,15),
(8,10,19,16);

insert into industrial(industrial_code,company_id,lecturer_id,staff_id)
values (1,7,3,34),
(2,11,8,35),
(3,12,9,36),
(4,13,10,37);


insert into meeting(meeting_point,lecturer_id,meeting_date,start_time,end_time)
values ('B',3,'2021-1-2','20210102 13:30','20210102 15:40'),
('A',8,'2021-1-2','20210102 13:30','20210102 15:40'),
('C',9,'2021-2-1','20210102 13:30','20210102 15:40'),
('B',10,'2021-3-10','20210102 13:30','20210102 15:40');

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
values (1,'Mechanical Uses','2022-6-26','pdf 1',95.8),
(23,'Mechanical Uses','2022-6-26','pdf 1',80),
(24,'Mechanical Uses','2022-7-4','pdf 1',80),
(25,'Mechanical Uses','2022-3-29','pdf 1',75),
(26, 'Study on X' , '2022-4-7', 'pdf 3', 78),
(27, 'Study on X' , '2022-6-9', 'pdf 3', 90),
(28, 'Study on X' , '2022-9-4', 'pdf 2', 67),
(29, 'Study on X' , '2022-2-5', 'pdf 4', 90);


insert into defense(student_id,defense_location,defense_time,content,defense_date,total_grade)
values (1,'s334','12:00','content of the first defense', '2022-3-12',65),
(23,'m201','13:00','content of the second defense','2022-6-12',72),
(24,'m333','13:00','content of the third defense','2023-1-5',89),
(25,'s112','15:00','content of the fourth defense','2022-4-23',92),
(26, 's334','15:00','content of the fifth defense', '2022-4-7', 78),
(27, 's432' ,'14:00','content of the sixth defense', '2022-6-9', 94.3),
(28, 'm503' ,'8:00','content of the seventh defense', '2022-9-4', 67),
(29, 'm205' ,'9:30', 'content of the eighth defense','2022-2-5', 90);

insert into progress_report(student_id,content,updating_user_id,progress_report_date,grade)
values (1,'math quiz 2',3,'2022-9-7',72),
(23,'company report',7,'2023-4-7',23),
(24,'os midterm',9,'2022-12-14',55),
(25,'caterers report',13,'2022-12-17',80),
(26, 'java code' ,3, '2022-4-7', 78),
(27, 'revision' ,7, '2022-6-9', 90),
(28, 'A+ addition' ,9, '2022-9-4', 67),
(29, 'grade evaluation' ,13, '2022-2-5', 90);

insert into grade_industrial_progress_report(lecturer_id,company_id,student_id,lecturer_grade,progress_report_date,company_grade)
values (3,7,1,89,'2022-9-7',70), 
(8,11,23,65,'2023-4-7',90), 
(9,12,24,70,'2022-12-14',65),
(10,13,25,89,'2022-12-17',75);

insert into grade_industrial_thesis(company_id, staff_id, student_id, title, company_grade, staff_grade)
values
(7,34,1,'Mechanical Uses', 85, 90),
(11,35,23,'Mechanical Uses', 80, 86),
(12,36,24,'Mechanical Uses', 78, 75),
(13,37,25,'Mechanical Uses', 97, 90);


insert into grade_academic_progress_report(lecturer_id,student_id,lecturer_grade,progress_report_date)
values (3,26,89,'2022-4-7'),
(8,27,18,'2022-6-9'),
(9,28,90,'2022-9-4'),
(10,29,89,'2022-2-5');




insert into grade_academic_thesis(lecturer_id,external_examiner_id,student_id,title,lecturer_grade,external_examiner_grade)
values (3,6,26,'Study on X',89,76),
(8,14,27,'Study on X',18,93),
(9,15,28,'Study on X',99,97),
(10,16,29,'Study on X',89,90);



insert into grade_academic_defense(lecturer_id,external_examiner_id,student_id,defense_location,lecturer_grade,external_examiner_grade)
values (3,6,26,'s334',89,76),
(8,14,27,'s432',18,93),
(9,15,28,'m503',98,97),
(10,16,29,'m205',89,90);


insert into grade_industrial_defense(company_id,staff_id,student_id,defense_location,company_grade,employee_grade)
values (7,34,1,'s334',98,32),
(11,35,23,'m201',90,89),
(12,36,24,'m333',65,90),
(13,37,25,'s112',75,87);



insert into lecturer_recommend_external_examiner(lecturer_id,external_examiner_id,project_code)
values (3,6,8),
(8,14,5);

insert into student_preferences(student_id,preference_number,project_code)
values (1,78,5),
(23,69,4),
(24,88,7),
(25,67,8),
(26,33,2);

insert into major_has_bachelor_project(major_code,project_code)
values(123,1),
(124,2),
(125,3),
(126,4),
(123, 5),
(124,6),
(125, 7),
(126,8);
