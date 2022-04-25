CREATE SCHEMA casestudy_1;
CREATE TABLE casestudy_1.operations(
DS DATE NOT NULL,
JOB_ID int NOT NULL,
ACTOR_ID int NOT NULL,
EVENT_ varchar(8) NOT NULL,
LANGUAGE_ varchar(8) NOT NULL,
TIME_SPENT int NOT NULL,
ORG varchar(8) NOT NULL
) ;
INSERT INTO casestudy_1.operations VALUES('2020-11-30','21','1001','skip','English','15','A');
INSERT INTO casestudy_1.operations VALUES('2020-11-30','22','1006','transfer','Arabic','25','B');
INSERT INTO casestudy_1.operations VALUES('2020-11-29','23','1003','decision','Persian','20','C');
INSERT INTO casestudy_1.operations VALUES('2020-11-28','23','1005','transfer','Persian','22','D');
INSERT INTO casestudy_1.operations VALUES('2020-11-28','25','1002','decision','Hindi','11','B');
INSERT INTO casestudy_1.operations VALUES('2020-11-27','11','1007','decision','French','104','D');
INSERT INTO casestudy_1.operations VALUES('2020-11-26','23','1004','skip','Persian','56','A');
INSERT INTO casestudy_1.operations VALUES('2020-11-25','20','1003','transfer','Italian','45','C');