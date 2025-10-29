-- drop all procedures
IF OBJECT_ID ('dbo.RemoveStudent', 'P') IS NOT NULL
	DROP PROCEDURE dbo.RemoveStudent
GO

IF OBJECT_ID ('dbo.CompleteSession', 'P') IS NOT NULL
	DROP PROCEDURE dbo.CompleteSession
GO

IF OBJECT_ID ('dbo.UpdateStudentStatus', 'P') IS NOT NULL
	DROP PROCEDURE dbo.UpdateStudentStatus
GO

-- drop all views
IF OBJECT_ID ('dbo.TutorAndStudentSessions', 'V') IS NOT NULL
	DROP VIEW dbo.TutorAndStudentSessions
GO

IF OBJECT_ID ('dbo.TutoringDepartmentTutors', 'V') IS NOT NULL
	DROP VIEW dbo.TutoringDepartmentTutors
GO

IF OBJECT_ID ('dbo.TutorViewStudents', 'V') IS NOT NULL
	DROP VIEW dbo.TutorViewStudents
GO

-- drop all tables
IF OBJECT_ID ('dbo.StudentTutorSession', 'U') IS NOT NULL
	DROP TABLE dbo.StudentTutorSession
GO

IF OBJECT_ID ('dbo.TutorSession', 'U') IS NOT NULL
	DROP TABLE dbo.TutorSession
GO

IF OBJECT_ID ('dbo.StudentSubjectHelp', 'U') IS NOT NULL
	DROP TABLE dbo.StudentSubjectHelp
GO

IF OBJECT_ID ('dbo.SessionStatus', 'U') IS NOT NULL
	DROP TABLE dbo.SessionStatus
GO

IF OBJECT_ID ('dbo.SessionType', 'U') IS NOT NULL
	DROP TABLE dbo.SessionType
GO

IF OBJECT_ID ('dbo.Tutor', 'U') IS NOT NULL
	DROP TABLE dbo.Tutor
GO

IF OBJECT_ID ('dbo.TutoringDepartment', 'U') IS NOT NULL
	DROP TABLE dbo.TutoringDepartment
GO

IF OBJECT_ID ('dbo.Student', 'U') IS NOT NULL
	DROP TABLE dbo.Student
GO

IF OBJECT_ID ('dbo.Household', 'U') IS NOT NULL
	DROP TABLE dbo.Household
GO

IF OBJECT_ID ('dbo.StudentStatus', 'U') IS NOT NULL
	DROP TABLE dbo.StudentStatus
GO

IF OBJECT_ID ('dbo.SubjectList', 'U') IS NOT NULL
	DROP TABLE dbo.SubjectList
GO

/* 
	Creating the database tables.
*/

-- Begin creating the SubjectList table.
CREATE TABLE SubjectList (
	-- Columns for the SubjectList table
	SubjectListID int identity not null,
	SubjectName varchar(40) not null

	-- Constraints on the SubjectList table
	CONSTRAINT PK_SubjectList PRIMARY KEY (SubjectListID) 
	)
-- Completed the SubjectList table

-- Begin creating the StudentStatus
CREATE TABLE StudentStatus (
	-- Columns for the StudentStatus table
	StudentStatusID int identity not null,
	StatusName varchar(20) not null,
	StatusDescription varchar(100) not null

	-- Constraints on the StudentStatus table
	CONSTRAINT PK_StudentStatus PRIMARY KEY (StudentStatusID)
	)
-- Completed the StudentStatus table

-- Begin creating the Household table.
CREATE TABLE Household (
	-- Columns for the Household table
	HouseholdID int identity not null,
	HomeAddress varchar(50) not null,
	City varchar(20) not null,
	HouseholdState char(5) not null,
	ZipCode varchar(10) not null,
	TelephoneNumber varchar(20) not null

	-- Constraints on the Household table
	CONSTRAINT PK_Household PRIMARY KEY (HouseholdID)
	)
-- Completed the Household table.
-- Begin creating the Student table
CREATE TABLE Student (
	-- Columns for the Student table
	StudentID int identity not null,
	StudentLastName varchar(20) not null,
	StudentFirstName varchar(20) not null,
	StudentEmailAddress varchar(30) not null,
	HouseholdID int not null,
	SchoolName varchar(40),
	GradeLevel varchar(5),
	EnrollmentDate datetime not null,
	UpdateDate datetime not null,
	StudentStatusID int not null

	-- Constraints on the Student table
	CONSTRAINT PK_Student PRIMARY KEY (StudentID),
	CONSTRAINT U1_Student UNIQUE (StudentEmailAddress),
	CONSTRAINT FK1_Student FOREIGN KEY (HouseholdID) REFERENCES Household(HouseholdID),
	CONSTRAINT FK2_Student FOREIGN KEY (StudentStatusID) REFERENCES StudentStatus(StudentStatusID) 
	)
-- Completed the Student table 

-- Begin creating the TutoringDepartment table
CREATE TABLE TutoringDepartment (
	-- Columns for the tutoringDepartment table
	TutoringDepartmentID int identity not null,
	DepartmentName varchar(30) not null,
	CoreSubject varchar(20) not null

	-- Constraints on the TutoringDepartment table
	CONSTRAINT PK_TutoringDepartment PRIMARY KEY (TutoringDepartmentID)
	)
-- Completed the TutoringDepartment table

-- Begin creating the Tutor table
CREATE TABLE Tutor (
	-- Columns for the Tutor table
	TutorID int identity not null,
	TutorLastName varchar(20) not null,
	TutorFirstName varchar(20) not null,
	WebsiteURL varchar(100),
	TutorEmailAddress varchar(30) not null,
	TelephoneNumber varchar(20) not null,
	TutoringDepartmentID int not null

	-- Constraints on the Tutor table 
	CONSTRAINT PK_Tutor PRIMARY KEY (TutorID),
	CONSTRAINT U1_Tutor UNIQUE (TutorEmailAddress),
	CONSTRAINT U2_Tutor UNIQUE (TelephoneNumber),
	CONSTRAINT FK1_Tutor FOREIGN KEY (TutoringDepartmentID) REFERENCES TutoringDepartment(TutoringDepartmentID)
	)
-- Completed the Tutor table

-- Begin creating the SessionType table
CREATE TABLE SessionType (
	-- Columns for the SessionType table
	SessionTypeID int identity not null,
	SessionMedium varchar(30) not null,
	MaxStudentCapacity int

	-- Constraints on the SessionType table
	CONSTRAINT PK_SessionType PRIMARY KEY (SessionTypeID)
	)
-- Completed the SessionType table

-- Begin creating the SessionStatus table
CREATE TABLE SessionStatus (
	-- Columns for the SessionStatus table
	SessionStatusID int identity not null,
	SessionStatusText varchar(20) not null

	-- Constraints for the SessionStatus table
	CONSTRAINT PK_SessionStatus PRIMARY KEY (SessionStatusID)
	)
-- Completed the SessionStatus table

-- Begin creating the StudentSubjectHelp table
CREATE TABLE StudentSubjectHelp (
	-- Columns for the StudentSubjectHelp table
	StudentSubjectHelpID int identity not null,
	StudentID int not null,
	TutorID int not null,
	SubjectListID int not null

	-- Constraints on the StudentSubjectHelp table
	CONSTRAINT PK_StudentSubjectHelp PRIMARY KEY (StudentSubjectHelpID),
	CONSTRAINT FK1_StudentSubjectHelp FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
	CONSTRAINT FK2_StudentSubjectHelp FOREIGN KEY (TutorID) REFERENCES Tutor(TutorID),
	CONSTRAINT FK3_StudentSubjectHelp FOREIGN KEY (SubjectListID) REFERENCES SubjectList(SubjectListID)
	)
-- Completed the StudentSubjectHelp table

-- Begin creating the TutorSession
CREATE TABLE TutorSession (
	-- Columns for the TutorSession
	TutorSessionID int identity not null,
	SessionName varchar(50) not null,
	SessionLocation varchar(50),
	SessionDay varchar(10) not null,
	SessionStartTime datetime not null,
	SessionTypeID int not null,
	TutorID int not null,
	SessionStatusID int not null

	-- Constraints on the TutorSession
	CONSTRAINT PK_TutorSession PRIMARY KEY (TutorSessionID),
	CONSTRAINT FK1_TutorSession FOREIGN KEY (SessionTypeID) REFERENCES SessionType(SessionTypeID),
	CONSTRAINT FK2_TutorSession FOREIGN KEY (TutorID) REFERENCES Tutor(TutorID),
	CONSTRAINT FK3_TutorSesion FOREIGN KEY (SessionStatusID) REFERENCES SessionStatus(SessionStatusID)
	)
-- Completed the StudentTutorSession

-- Begin creating the StudentTutorSession table
CREATE TABLE StudentTutorSession (
	-- Columns for the StudentTutorSession table
	StudentTutorSessionID int identity not null,
	TutorSessionID int not null,
	StudentID int not null

	-- Constraints on the StudentTutorSession table
	CONSTRAINT PK_StudentTutorSession PRIMARY KEY (StudentTutorSessionID),
	CONSTRAINT FK1_StudentTutorSession FOREIGN KEY (TutorSessionID) REFERENCES TutorSession(TutorSessionID),
	CONSTRAINT FK2_StudentTutorSession FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
)
-- Completed StudentTutorSession table

/* 
	Inserting information into all tables.
*/

-- Insert data into student status table.
INSERT INTO StudentStatus(StatusName, StatusDescription)
VALUES ('Enrolled', 'Student is currently enrolled in the tutoring program'),
	   ('Inactive', 'Student has not attended last few sessions and has not contacted respective tutor'),
	   ('Temporary Absence', 'Student is currently unable to attend sessions with tutor but still in contact'),
	   ('Completed', 'Student has attended all sessions with tutor and completed the program')

-- Check for any mistakes in the student status table
SELECT * FROM StudentStatus

-- Insert statuses into SessionStatus table
INSERT INTO SessionStatus(SessionStatusText)
VALUES ('Upcoming'),
	   ('Complete'),
	   ('Rescheduled'),
	   ('Never Attended'),
	   ('Cancelled') 

SELECT * FROM SessionStatus


-- Insert session types into SessionType table
INSERT INTO SessionType(SessionMedium, MaxStudentCapacity)
VALUES ('GROUP ONLINE', '10'),
	   ('INDIVIDUAL ONLINE', '1'),
	   ('GROUP FACE-TO-FACE', '10'),
	   ('INDIVIDUAL FACE-TO-FACE', '1')

SELECT * FROM SessionType

-- Insert subjects into SubjectList table
INSERT INTO SubjectList(SubjectName)
VALUES ('Numbers and Operations'),
	   ('Pre-algebra'),
	   ('Algebra'),
	   ('Algebra 2'),
	   ('Linear Algebra'),
	   ('Geometry'),
	   ('Precalculus'),
	   ('Calculus'),
	   ('Statistics and Probability'),
	   ('Trigonometry'),
	   ('Differential Equations'),
	   ('Biology'),
	   ('Physical Science'),
	   ('Chemistry'),
	   ('Organic Chemistry'),
	   ('Physics'),
	   ('Health'),
	   ('Astronomy'),
	   ('US History'),
	   ('World History'),
	   ('Art History'),
	   ('Comparative Religions'),
	   ('US Government'),
	   ('Macroeconomics'),
	   ('Microeconomics'),
	   ('Geography'),
	   ('Phonics'),
	   ('Reading Comprehension'),
	   ('English'),
	   ('American Literature'),
	   ('British Literature'),
	   ('African Literature'),
	   ('Spanish'),
	   ('French'),
	   ('AP Calculus'),
	   ('AP US History'),
	   ('AP Spanish'),
	   ('AP Economics'),
	   ('AP Physics'),
	   ('AP Chemistry')

SELECT * FROM SubjectList
 

-- Insert department names into TutoringDepartment table
INSERT INTO TutoringDepartment(DepartmentName, CoreSubject)
VALUES ('Math Department', 'Mathematics'),
	   ('Science Department', 'Science'),
	   ('History Department', 'History'),
	   ('Economics Department', 'Economics'),
	   ('Language Arts Department', 'Language Arts'),
	   ('World Languages Department', 'World Languages')

SELECT * FROM TutoringDepartment

 

-- Insert home addresses into Household table
INSERT INTO Household (HomeAddress, City, HouseholdState, ZipCode, TelephoneNumber)
VALUES ('422 En Vogue St', 'Marietta', 'GA', '30157', '7702223456'),
	   ('304 Round the Way Dr', 'Dallas', 'GA', '30162', '6784849092'),
	   ('876 Quality Street', 'Cartersville', 'GA', '30828', '6785321678'),
	   ('202 Alantis Blvd', 'Atlanta', 'GA', '30133', '7078235641'),
	   ('522 Peachtree St', 'Atlanta', 'GA', '30166', '9732822604'),
	   ('277 Good Vibes Dr', 'Rome', 'GA', '30232', '6784932285'),
	   ('345 Lettuce St', 'Marietta','GA', '30956', '6785443022'),
	   ('311 Silver Bling St', 'Marietta', 'GA', '30154', '6787823091'),
	   ('285 Thomas Dr', 'Cumberland', 'GA', '30141', '7703435213'),
	   ('340 Frozen St', 'Cartersville', 'GA', '30898', '6789991111'),
	   ('689 Bloomingdale Blvd', 'Atlanta', 'GA', '30134', '7708889292'),
	   ('722 Glenndale Dr', 'Rome', 'GA', '302310', '6783030289'),
	   ('694 Alejandro Blvd', 'Dallas', 'GA', '30112', '7078986765'),
	   ('888 Hashibira Dr', 'Cartersville', 'GA', '30939', '9734445655'),
	   ('576 Blooregard St', 'Cumberland', 'GA', '30846', '6782135467')

SELECT * FROM Household

-- Insert Students into the Student table
INSERT INTO Student(StudentLastName, StudentFirstName, StudentEmailAddress, SchoolName,
					GradeLevel, EnrollmentDate, UpdateDate, HouseholdID, StudentStatusID)
VALUES ('Kamado', 'Tanjiro', 'tankam@student.edu', 'Barrett Highschool', '9', '10-15-2019', '3-20-2020'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '9734445655')
	   , (SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled')),
	   ('Kamado', 'Nezuko', 'nezkam@student.edu', 'Altoona Middle School', '8', '1-15-2020', '3-20-2020'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '9734445655')
	   , (SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled')),
	   ('Kamado', 'Takeo', 'takkam@student.edu', 'Altoona Middle School', '6', '1-15-2020', '3-20-2020'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '9734445655')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled')),
	   ('Abuja', 'Nigeria', 'nigabu@student.edu', 'Abuja Highschool', '11', '11-1-2019', '12-20-2019'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '7078986765')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled')),
	   ('Hyuga', 'Hinata', 'hinhyu@student.edu', 'Konoha Highschool', '12', '5-10-2019', '12-1-2019'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '6782135467')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Completed')),
	   ('Abuja', 'Ghana', 'ghaabu@student.edu', 'Altoona Highschool', '8', '5-10-2019', '10-1-2019'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '7078986765')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled')),
	   	('Shinazugawa', 'Genya', 'genshi@student.edu', 'Barrett Highschool', '10', '9-14-2019', '1-15-2020'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '6785321678')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled')),
	   ('Takada', 'Naho', 'nahtak@student.edu', 'Cobb Elementary School', '4', '1-20-2020', '4-1-2020'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '6787823091')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled')),
	   ('Terauchi', 'Kiyo', 'kiyter@student.edu', 'Cobb Elementary School', '4', '7-10-2019', '1-5-2020'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '6787823091')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Completed')),
	   	('Lagos', 'Gambia', 'gamlag@student.edu', 'Abuja Highschool', '10', '1-20-2019', '3-1-2019'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '6784849092')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Inactive')),
	   	('Agatsuma', 'Zenitsu', 'zenaga@student.edu', 'Barrett Highschool', '9', '1-10-2020', '2-1-2020'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '7078235641')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled')),
	   	('Hashibira', 'Inosuke', 'inohas@student.edu', 'Park Highschool', '9', '12-10-2019', '4-1-2020'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '9732822604')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled')),
	   	('Nakahara', 'Sumi', 'sumnak@student.edu', 'Dallas Elementary School', '5', '11-1-2019', '2-1-2020'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '6785443022')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled')),
	   	('Jacobs', 'Lonni', 'lonjac@student.edu', 'Abuja Highschool', '12', '7-1-2019', '12-20-2019'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '7703435213')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled')),
	   	('Kanzaki', 'Aoi', 'aoikan@student.edu', 'Carter Highschool', '11', '11-10-2019', '5-10-2020'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '6783030289')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Completed')),
	   	('Water', 'Katara', 'katwat@student.edu', 'Eskimo Highschool', '9', '12-20-2019', '4-1-2020'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '6789991111')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled')),
	   	('Water', 'Sokka', 'sokwat@student.edu', 'Inuit Middle School', '8', '9-20-2019', '4-1-2020'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '6789991111')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Completed')),
	   	('Fire', 'Alita', 'alifir@student.edu', 'Cobb Elementary School', '3', '8-10-2019', '9-1-2019'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '6787823091')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Temporary Absence')),
	   	('Richmond', 'Celeste', 'celric@student.edu', 'Barrett Highschool', '10', '11-15-2019', '3-30-2020'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '6784932285')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled')),
	    ('Butter', 'Shea', 'shebut@student.edu', 'North Atlanta Highschool', '10', '3-30-2019', '9-5-2019'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '7702223456')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Completed')),
	    ('Garden', 'Panda', 'pangar@student.edu', 'Altoona Middle School', '6', '8-30-2019', '12-20-2019'
	   ,(SELECT HouseholdID FROM Household WHERE TelephoneNumber = '7708889292')
	   ,(SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Enrolled'))

SELECT * FROM Student

 
-- Insert tutor names to the tutor table
INSERT INTO Tutor(TutorLastName, TutorFirstName, TutorEmailAddress, TelephoneNumber, WebsiteURL, TutoringDepartmentID)
VALUES ('Kocho', 'Kanae', 'kankoc@tutor.edu', '6784561231', 'https://KanaeKocho.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Science Department')),
	   ('Shinazugawa', 'Sanemi', 'sanshi@tutor.edu', '6789517536', 'https://SanemiShinazugawa.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Math Department')),
	   ('Iguro', 'Obanai', 'obaigu@tutor.edu', '7707894891', 'https://ObanaiIguro.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Science Department')),
	   ('Tomioka', 'Giyuu', 'giytom@tutor.edu', '7701597536', 'NULL'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'World Languages Department')),
	   ('Kanroji', 'Mitsuri', 'mitkan@tutor.edu', '6784512357', 'https://MitsuriKanroji.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Language Arts Department')),
	   ('Rengoku', 'Kyojuro', 'kyoren@tutor.edu', '6782315648', 'https://KyojuroRengoku.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'History Department')),
	   ('Uzui', 'Tengen', 'tenuzu@tutor.edu', '4048559555', 'https://TengenUzui.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Language Arts Department')),
	   ('Himejima', 'Gyomei', 'gyohim@tutor.edu', '9735658989', 'NULL'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'History Department')),
	   ('Tokito', 'Muichiro', 'muitok@tutor.edu', '6784040505', 'https://MuichiroTokito.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Math Department')),
	   ('Kocho', 'Shinobu', 'shikoc@tutor.edu', '678282228', 'https://ShinobuKocho.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Science Department')),
	   ('Uchiha', 'Sasuke', 'sasuch@tutor.edu', '7702953624', 'NULL'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Math Department')),
	   ('Haruno', 'Sakura', 'sakhar@tutor.edu', '7705959898', 'https:/SakuraHaruno.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Science Department')),
	   ('Nara', 'Shikamaru', 'shinar@tutor.edu', '6783684152', 'https://ShikamaruNara.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Math Department')),
	   ('Ishigami', 'Senku', 'senish@tutor.edu', '6783026059', 'https://SenkuIshigami.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Science Department')),
	   ('Nanami', 'Ryusui', 'ryunan@tutor.edu', '7708523698', 'https://RyusuiNanami.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Economics Department')),
	   ('Shishio', 'Tsukasa', 'tsushi@tutor.edu', '4045612357', 'NULL'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Economics Department')),
	   ('Asagiri', 'Gen', 'genasa@tutor.edu', '6789876543', 'https://GenAsagiri.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'World Languages Department')),
	   ('Weinburg', 'Ruri', 'rurwei@tutor.edu', '7705148368', 'https://RuriWeinburg.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Math Department')),
	   ('Weinburg', 'Kohaku', 'kohwei@tutor.edu', '7708809990', 'https://KohakuWeinburg.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'History Department')),
	   ('Kumeno', 'Masachika', 'maskum@tutor.edu', '9736425103', 'https://MasachikaKumeno.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Math Department')),
	   ('Sato', 'Asami', 'asasat@tutor.edu', '6783540210', 'https://AsamiSato.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Math Department')),
	   ('Avatar', 'Aang', 'aanava@tutor.edu', '7705503330', 'NULL'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'History Department')),
	   ('Tokito', 'Yuichiro', 'yuitok@tutor.edu', '67800261547', 'https://YuichiroTokito.wixsite.com/mysite'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Math Department')),
	   ('Tamayo', 'Yushiro', 'yustam@tutor.edu', '7704418855', 'NULL'
	   ,(SELECT TutoringDepartmentID FROM TutoringDepartment WHERE DepartmentName = 'Science Department'))

SELECT * FROM Tutor
 

-- Time to pair students with tutors!!!
INSERT INTO StudentSubjectHelp(StudentID, TutorID, SubjectListID)
VALUES ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Tanjiro')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Kyojuro')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'US History')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Tanjiro')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Obanai')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Chemistry')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Nezuko')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Muichiro')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Pre-algebra')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Genya')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Sanemi')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Calculus')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Takeo')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Muichiro')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Pre-algebra')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Naho')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Kanae')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Physical Science')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Sumi')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Ruri')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Numbers and Operations')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Zenitsu')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Shinobu')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Biology')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Gambia')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Obanai')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Chemistry')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Inosuke')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Shinobu')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Biology')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Lonni')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Sanemi')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'AP Calculus')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Inosuke')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Mitsuri')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'American Literature')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Celeste')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Senku')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Chemistry')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Alita')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Kanae')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Physical Science')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Nigeria')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Gyomei')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'AP US History')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Nezuko')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Tengen')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'English')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Nigeria')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Sanemi')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'AP Calculus')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Ghana')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Giyuu')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Spanish')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Celeste')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Gen')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'French')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Katara')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Tsukasa')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Microeconomics')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Celeste')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Ryusui')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Macroeconomics')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Celeste')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Shikamaru')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Geometry')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Hinata')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Obanai')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'AP Physics')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Kiyo')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Asami')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Numbers and Operations')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Shea')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Sasuke')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Statistics and Probability')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Aoi')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Kyojuro')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'US Government')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Sokka')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Masachika')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Pre-algebra')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Alita')
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Sakura')
	   ,(SELECT SubjectListID FROM SubjectList WHERE SubjectName = 'Physical Science'))

SELECT * FROM StudentSubjectHelp
-- Time to set up some tutoring sessions
INSERT INTO TutorSession (SessionName, SessionTypeID, SessionLocation, SessionDay, SessionStartTime, TutorID, SessionStatusID)
VALUES ('Individual History Session', (SELECT SessionTypeID FROM SessionType WHERE SessionMedium = 'INDIVIDUAL FACE-TO-FACE')
	   , 'TBD', 'Saturday', '12:30'
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Kyojuro')
	   ,(SELECT SessionStatusID FROM SessionStatus WHERE SessionStatusText = 'Upcoming')),
	   ('Group Chemistry Session', (SELECT SessionTypeID FROM SessionType WHERE SessionMedium = 'GROUP FACE-TO-FACE')
	   , 'Tutoring Center: Room 101', 'Wednesday', '17:00'
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Obanai')
	   ,(SELECT SessionStatusID FROM SessionStatus WHERE SessionStatusText = 'Upcoming')),
	   ('Individual Calculus Session', (SELECT SessionTypeID FROM SessionType WHERE SessionMedium = 'INDIVIDUAL FACE-TO-FACE')
	   , 'Student Home', 'Friday', '16:30'
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Sanemi')
	   ,(SELECT SessionStatusID FROM SessionStatus WHERE SessionStatusText = 'Complete')),
	   ('Group Biology Session', (SELECT SessionTypeID FROM SessionType WHERE SessionMedium = 'GROUP ONLINE')
	   , 'TBD', 'Saturday', '14:30'
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Shinobu')
	   ,(SELECT SessionStatusID FROM SessionStatus WHERE SessionStatusText = 'Upcoming')),
	   ('Group Physical Science Session', (SELECT SessionTypeID FROM SessionType WHERE SessionMedium = 'GROUP FACE-TO-FACE')
	   , 'Tutoring Center: Room 104', 'Tuesday', '16:30'
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Kanae')
	   ,(SELECT SessionStatusID FROM SessionStatus WHERE SessionStatusText = 'Rescheduled')),
	   ('Group AP Calculus Session', (SELECT SessionTypeID FROM SessionType WHERE SessionMedium = 'GROUP FACE-TO-FACE')
	   , 'Tutoring Center: Room 110', 'Sunday', '10:45'
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Sanemi')
	   ,(SELECT SessionStatusID FROM SessionStatus WHERE SessionStatusText = 'Complete')),
	   ('Individual Spanish Session', (SELECT SessionTypeID FROM SessionType WHERE SessionMedium = 'INDIVIDUAL FACE-TO-FACE')
	   , 'Tutoring Center: Room 102', 'Thursday', '16:00'
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Giyuu')
	   ,(SELECT SessionStatusID FROM SessionStatus WHERE SessionStatusText = 'Upcoming')),
	   ('Individual Chemistry Session', (SELECT SessionTypeID FROM SessionType WHERE SessionMedium = 'INDIVIDUAL FACE-TO-FACE')
	   , 'Student Home', 'Tuesday', '12:30'
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Obanai')
	   ,(SELECT SessionStatusID FROM SessionStatus WHERE SessionStatusText = 'Never Attended')),
	   ('Individual Pre-algebra Session', (SELECT SessionTypeID FROM SessionType WHERE SessionMedium = 'INDIVIDUAL FACE-TO-FACE')
	   , 'Student Home', 'Saturday', '12:30'
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Masachika')
	   ,(SELECT SessionStatusID FROM SessionStatus WHERE SessionStatusText = 'Complete')),
	   ('Individual Numbers and Operations Session', (SELECT SessionTypeID FROM SessionType WHERE SessionMedium = 'INDIVIDUAL FACE-TO-FACE')
	   , 'Student Home', 'Sunday', '13:00'
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Asami')
	   ,(SELECT SessionStatusID FROM SessionStatus WHERE SessionStatusText = 'Cancelled')),
	   ('Individual Physical Science Session', (SELECT SessionTypeID FROM SessionType WHERE SessionMedium = 'INDIVIDUAL FACE-TO-FACE')
	   , 'Student Home', 'Monday', '15:00'
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Sakura')
	   ,(SELECT SessionStatusID FROM SessionStatus WHERE SessionStatusText = 'Rescheduled')),
	   ('Group Pre-algebra Session', (SELECT SessionTypeID FROM SessionType WHERE SessionMedium = 'GROUP FACE-TO-FACE')
	   , 'Student Home', 'Saturday', '11:30'
	   ,(SELECT TutorID FROM Tutor WHERE TutorFirstName = 'Muichiro')
	   ,(SELECT SessionStatusID FROM SessionStatus WHERE SessionStatusText = 'Upcoming'))

SELECT * FROM TutorSession

 

-- We must place students in their respective tutoring sessions
INSERT INTO StudentTutorSession(StudentID, TutorSessionID)
VALUES ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Tanjiro')
       ,(SELECT TutorSessionID FROM TutorSession WHERE SessionName = 'Individual History Session' 
	   AND SessionLocation = 'TBD')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Nezuko')
       ,(SELECT TutorSessionID FROM TutorSession WHERE SessionName = 'Group Pre-algebra Session' 
	   AND SessionLocation = 'Student Home')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Takeo')
       ,(SELECT TutorSessionID FROM TutorSession WHERE SessionName = 'Group Pre-algebra Session' 
	   AND SessionLocation = 'Student Home')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Alita')
       ,(SELECT TutorSessionID FROM TutorSession WHERE SessionName = 'Individual Physical Science Session' 
	   AND SessionLocation = 'Student Home')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Lonni')
       ,(SELECT TutorSessionID FROM TutorSession WHERE SessionName = 'Group AP Calculus Session' 
	   AND SessionLocation = 'Tutoring Center: Room 110')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Nigeria')
       ,(SELECT TutorSessionID FROM TutorSession WHERE SessionName = 'Group AP Calculus Session' 
	   AND SessionLocation = 'Tutoring Center: Room 110')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Ghana')
       ,(SELECT TutorSessionID FROM TutorSession WHERE SessionName = 'Individual Spanish Session' 
	   AND SessionLocation = 'Tutoring Center: Room 102')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Zenitsu')
       ,(SELECT TutorSessionID FROM TutorSession WHERE SessionName = 'Group Biology Session' 
	   AND SessionLocation = 'TBD')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Inosuke')
       ,(SELECT TutorSessionID FROM TutorSession WHERE SessionName = 'Group Biology Session' 
	   AND SessionLocation = 'TBD')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Tanjiro')
       ,(SELECT TutorSessionID FROM TutorSession WHERE SessionName = 'Group Chemistry Session' 
	   AND SessionLocation = 'Tutoring Center: Room 101')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Naho')
       ,(SELECT TutorSessionID FROM TutorSession WHERE SessionName = 'Group Physical Science Session' 
	   AND SessionLocation = 'Tutoring Center: Room 104')),
	   ((SELECT StudentID FROM Student WHERE StudentFirstName = 'Genya')
       ,(SELECT TutorSessionID FROM TutorSession WHERE SessionName = 'Individual Calculus Session' 
	   AND SessionLocation = 'Student Home'))

SELECT * FROM StudentTutorSession
-- Create a view of tutors and their students
GO
CREATE VIEW TutorViewStudents
AS
SELECT
	Tutor.TutorFirstName + ' ' + Tutor.TutorLastName AS Tutor,
	Student.StudentFirstName + ' ' + Student.StudentLastName AS Student,
	Household.HomeAddress AS StudentHome,
	Household.TelephoneNumber AS StudentNumber,
	Student.StudentEmailAddress AS StudentEmail
FROM StudentSubjectHelp
JOIN Tutor ON Tutor.TutorID = StudentSubjectHelp.TutorID
JOIN Student ON Student.StudentID = StudentSubjectHelp.StudentID
CROSS JOIN Household WHERE Household.HouseholdID = Student.HouseholdID
GO

SELECT * FROM TutorViewStudents
ORDER BY Tutor
GO

 

-- Create view of tutors in their respective departments
CREATE VIEW TutoringDepartmentTutors
AS
SELECT
	TutoringDepartment.DepartmentName AS Department,
	Tutor.TutorFirstName + ' ' + Tutor.TutorLastName AS Tutor,
	Tutor.TutorEmailAddress AS EmailAddress,
	Tutor.TelephoneNumber AS TelephoneNumber
FROM Tutor
JOIN TutoringDepartment ON TutoringDepartment.TutoringDepartmentID = Tutor.TutoringDepartmentID
GO

SELECT * FROM TutoringDepartmentTutors
ORDER BY Department
GO

 

-- Create a view where tutors can view their sessions
CREATE VIEW TutorAndStudentSessions
AS
SELECT 
	Tutor.TutorFirstName + ' ' + Tutor.TutorLastName AS Tutor,
	Student.StudentFirstName + ' ' + Student.StudentLastName AS Student,
	TutorSession.SessionName AS Session,
	TutorSession.SessionDay AS DAY,
	TutorSession.SessionStartTime AS StartTime,
	SessionStatus.SessionStatusText AS Status
FROM StudentTutorSession
JOIN Student ON Student.StudentID = StudentTutorSession.StudentID
JOIN TutorSession ON TutorSession.TutorSessionID = StudentTutorSession.TutorSessionID 
CROSS JOIN Tutor, SessionStatus WHERE Tutor.TutorID = TutorSession.TutorID 
AND SessionStatus.SessionStatusID = TutorSession.SessionStatusID
GO

SELECT * FROM TutorAndStudentSessions 
ORDER BY Tutor, Status
GO

 

--Create a procedure that updates a student’s status to complete a new student to the database
CREATE PROCEDURE UpdateStudentStatus (@studentID int)
AS
BEGIN
	Update Student
			SET UpdateDate = GETDATE(),
				StudentStatusID = (SELECT StudentStatusID FROM StudentStatus 
				WHERE StatusName = 'Completed')
			WHERE StudentID = @studentID
END
GO

/*	The students Tanjiro Kamado, Nigeria Abuja, and Genya Shinazugawa 
	have all completed the tutoring program. We will now update their 
	student status to complete.
	Completed has a studentstatusID of 4.
*/

DECLARE @firststudentID int
SET @firststudentID = (SELECT StudentID FROM Student WHERE StudentFirstName = 'Tanjiro' AND StudentLastName = 'Kamado')
EXEC UpdateStudentStatus @firststudentID
GO

DECLARE @secondstudentID int
SET @secondstudentID = (SELECT StudentID FROM Student WHERE StudentFirstName = 'Nigeria' AND StudentLastName = 'Abuja')
EXEC UpdateStudentStatus @secondstudentID
GO

DECLARE @thirdstudentID int
SET @thirdstudentID = (SELECT StudentID FROM Student WHERE StudentFirstName = 'Genya' AND StudentLastName = 'Shinazugawa')
EXEC UpdateStudentStatus @thirdstudentID
GO

-- Now we want to see if the three students' statuses have updated successfully
SELECT * FROM Student
GO
 


-- All three students' status were successfully updated

-- Create a procedure that updates a session status to complete. 
CREATE PROCEDURE CompleteSession (@sessionID int)
AS
BEGIN
	Update TutorSession
			SET SessionStatusID = (SELECT SessionStatusID FROM SessionStatus WHERE SessionStatusText = 'Complete')
			WHERE TutorSessionID = @sessionID
END
GO

-- Some sessions have complete over the passage of time
DECLARE @sessionID int
SET @sessionID = (SELECT TutorSessionID FROM TutorSession
				  WHERE SessionName = 'Group Pre-algebra Session' 
				  AND SessionLocation = 'Student Home')
EXEC CompleteSession @sessionID
GO

SELECT * FROM TutorAndStudentSessions 
ORDER BY Tutor, Status
GO

DECLARE @secondsessionID int
SET @secondsessionID = (SELECT TutorSessionID FROM TutorSession
				  WHERE SessionName = 'Individual Spanish Session' 
				  AND SessionLocation = 'Tutoring Center: Room 102')
EXEC CompleteSession @secondsessionID
GO

-- Let's check if each session was successully completed
SELECT * FROM TutorAndStudentSessions 
ORDER BY Tutor, Status
GO

-- Both sessions are now fully completed

-- Create a procedure that removes an inactive student from the database
CREATE PROCEDURE RemoveStudent (@studentID int)
AS
BEGIN
	DELETE FROM StudentSubjectHelp 
	FROM StudentSubjectHelp
	INNER JOIN Student ON Student.StudentID = StudentSubjectHelp.StudentID
	WHERE Student.StudentID = @studentID
	AND StudentStatusID = (SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Inactive') 
END
GO

/*  We want to remove the student Gambia Lagos from the database.
	She was last active on March 1, 2019.
*/
DECLARE @studentID int
SET @studentID = (SELECT StudentID FROM Student WHERE StudentFirstName = 'Gambia')
EXEC RemoveStudent @studentID 
GO

-- Let's see if Gambia has been removed from the list of student shas been removed from our list of students.
SELECT * FROM Student
GO






-- Data Question 1: Which subject receives the most tutoring request among students?
SELECT
	SubjectList.SubjectName AS Subject,
	Count(SubjectList.SubjectName) AS NumberOfRequests
FROM StudentSubjectHelp
INNER JOIN SubjectList ON SubjectList.SubjectListID = StudentSubjectHelp.SubjectListID
GROUP BY SubjectList.SubjectName
ORDER BY NumberOfRequests DESC
GO

 

/*
	Pre-algebra and Physical Science are the tutoring subjects that the most sought after by students. 
	Both subjects have three requests each. The second most requested subjects amongs students are Numbers and Operations,
	Chemistry, Biology, and AP Calculus, all of which have been requested by two students each. It seems that students mainly 
	seek help on math or science-based subjects.
*/



-- Data Question 2: Is there an uneven allocation of tutors in different subject areas? 
SELECT 
	Department,
	COUNT(TutoringDepartmentTutors.Department) AS NumberOfTutors
FROM TutoringDepartmentTutors
GROUP BY Department
ORDER BY NumberOfTutors DESC
GO
 

/* The Math Department has 8 out of 24 tutors working in it, whereas, the Language Arts,
   World Languages, and Economics Departments have the least number of tutors with two tutors in each 
   department. Thus, the Math Department has 1/3 (or 33%) of the center's tutors, the Science Department has 
   25% of the tutors, the History Department has about 16.7% of the tutors, and the other three departments have
   8.3% of the tutors in each department. 
   The is an uneven allocation of tutors spread throughout the departments within the tutoring center. However, as 
   we discovered before, most students request tutoring in the math and science subject areas. Therefore, the distribution
   of tutors may be uneven within the departments but practical.
*/


-- Data Question 3: Which tutor has the most students on their schedule? 
SELECT TOP 10
	Tutor,
	COUNT(Tutor) AS NumberOfStudents
FROM TutorViewStudents
GROUP BY Tutor
ORDER BY NumberOfStudents DESC
GO

 

 
/* Tutor, Sanemi Shinazugawa, has the most students on his schedule, with three students. Shinobu Kocho,
   Muichiro Tokito, Obanai Iguro, Kanae Kocho, and Kyojuro Rengoku come in second place and each have
   two students on their schedule.
*/
 

 

-- Data Question 4: What is the average length of time a student stays in the program?
SELECT 
	Student.StudentFirstName + ' ' + Student.StudentLastName AS Student,
	DATEDIFF(mm, Student.EnrollmentDate, Student.UpdateDate) AS MonthsSpent
FROM Student
WHERE StudentStatusID = (SELECT StudentStatusID FROM StudentStatus WHERE StatusName = 'Completed')
ORDER BY MonthsSpent DESC
GO

 

/* Out of eight students who have completed the program,
   1 student completed it in 9 months, 1 student finished in 8 months,
   3 finished in 7 months, and another 3 finished in 6 months.
*/
-- In most cases, students generally finish the program in 6-7 months to complete the program.
-- Create a histogram to show this

 

-- Data Question 5: Which tutoring medium is requested the most amongst students?
SELECT
	TutorSession.SessionName AS Session,
	SessionType.SessionMedium AS Medium
FROM TutorSession
JOIN SessionType ON SessionType.SessionTypeID = TutorSession.SessionTypeID
ORDER BY Session

SELECT
	SessionType.SessionMedium AS Medium,
	COUNT(TutorSession.SessionTypeID) AS NumberOfRequests
FROM TutorSession
RIGHT JOIN SessionType ON SessionType.SessionTypeID = TutorSession.SessionTypeID
GROUP BY SessionType.SessionMedium
ORDER BY NumberOfRequests DESC

GO


/* Students frequently ask to have to have individual, in-person, sessions with their tutors.
   However, there are not requests from students to have individual sessions online. In fact,
   students seem to prefer face-to-face sessions with their tutors rather than online session. 
   There are four requests for group sessions face-to-face and only one request for an online 
   group session.
*/
