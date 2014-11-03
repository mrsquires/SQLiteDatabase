-- Script to create Team8 database

-- SQLite set up commands
.echo ON

.mode list
.separator "  |  "

.output Team8DB_out.txt

PRAGMA foreign_keys = ON;

-- SQL to remove the tables if they exist so they can be newly created

DROP TABLE IF EXISTS BUILD_CONFIG;
DROP TABLE IF EXISTS REQUEST;
DROP TABLE IF EXISTS STATUS;
DROP TABLE IF EXISTS REQUEST_TYPE;
DROP TABLE IF EXISTS PRIORITY;
DROP TABLE IF EXISTS TEST_ENV;
DROP TABLE IF EXISTS STAKEHOLDER;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS DEPARTMENT;

-- SQL to create all the tables

CREATE TABLE DEPARTMENT
(dept_id INTEGER, 
dept_name VARCHAR(30),
CONSTRAINT DEPARTMENT_dept_id_pk PRIMARY KEY (dept_id));

CREATE TABLE EMPLOYEE
(emp_id INTEGER, 
emp_lastName VARCHAR(30),
emp_firstName VARCHAR(30),
emp_email VARCHAR(30),
dept_id INTEGER,
CONSTRAINT EMPLOYEE_emp_id_pk PRIMARY KEY (emp_id),
CONSTRAINT EMPLOYEE_dept_id_fk FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id));

CREATE TABLE STAKEHOLDER
(sh_id INTEGER,
sh_lname VARCHAR(30),
sh_fname VARCHAR(30),
sh_email VARCHAR(20),
sh_company VARCHAR(30),
CONSTRAINT STAKEHOLDER_sh_id_pk PRIMARY KEY (sh_id));

CREATE TABLE TEST_ENV
(env_id INTEGER,
test_sysName VARCHAR(30),
CONSTRAINT TEST_ENV_env_id_pk PRIMARY KEY (env_id));

CREATE TABLE PRIORITY
(pri_id INTEGER,
pri_level VARCHAR(20),
CONSTRAINT PRIORITY_pri_id_pk PRIMARY KEY (pri_id));

CREATE TABLE REQUEST_TYPE
(type_id INTEGER,
type_desc VARCHAR(30),
CONSTRAINT REQUEST_TYPE_type_id_pk PRIMARY KEY (type_id));

CREATE TABLE STATUS
(stat_id INTEGER, 
stat_name VARCHAR(20),
CONSTRAINT STATUS_stat_id_pk PRIMARY KEY (stat_id));

CREATE TABLE REQUEST
(req_id INTEGER,
req_desc VARCHAR(30),
req_dateRequest DATE,
req_dateUpdated DATE,
type_id INTEGER,
pri_id INTEGER,
dev_id INTEGER,
stat_id INTEGER,
reqemp_id INTEGER,
sh_id INTEGER,
CONSTRAINT REQUEST_req_id_pk PRIMARY KEY (req_id),
CONSTRAINT REQUEST_type_id_fk FOREIGN KEY (type_id) REFERENCES REQUEST_TYPE(type_id),
CONSTRAINT REQUEST_pri_id_fk FOREIGN KEY (pri_id) REFERENCES PRIORITY(pri_id),
CONSTRAINT REQUEST_dev_id_fk FOREIGN KEY (dev_id) REFERENCES EMPLOYEE(emp_id),
CONSTRAINT REQUEST_stat_id_fk FOREIGN KEY (stat_id) REFERENCES STATUS(stat_id),
CONSTRAINT REQUEST_reqemp_id_fk FOREIGN KEY (reqemp_id) REFERENCES EMPLOYEE(emp_id),
CONSTRAINT REQUEST_sh_id_fk FOREIGN KEY (sh_id) REFERENCES STAKEHOLDER(sh_id));

CREATE TABLE BUILD_CONFIG
(config_id INTEGER,
env_id INTEGER,
req_id INTEGER,
CONSTRAINT CONFIG_config_id_pk PRIMARY KEY (config_id),
CONSTRAINT CONFIG_env_id_fk FOREIGN KEY (env_id) REFERENCES TEST_ENV(env_id),
CONSTRAINT CONFIG_req_id_fk FOREIGN KEY (req_id) REFERENCES REQUEST(req_id));
 
--- SQL to put data in all the tables

-- SQL to insert rows into DEPARTMENT
INSERT INTO DEPARTMENT VALUES ('100', 'Business Office');
INSERT INTO DEPARTMENT VALUES ('200', 'Human Resources');
INSERT INTO DEPARTMENT VALUES ('300', 'Finance');
INSERT INTO DEPARTMENT VALUES ('400', 'Marketing');
INSERT INTO DEPARTMENT VALUES ('500', 'Compliance');
INSERT INTO DEPARTMENT VALUES ('600', 'Internal Audit');
INSERT INTO DEPARTMENT VALUES ('700', 'Sales');
INSERT INTO DEPARTMENT VALUES ('800', 'Information Technology');

-- SQL to insert rows into EMPLOYEE
INSERT INTO EMPLOYEE VALUES ('111', 'Smith', 'John', 'john.smith@abcco.com', '100');
INSERT INTO EMPLOYEE VALUES ('222', 'Jones', 'Mark', 'mark.jones@abcco.com', '100');
INSERT INTO EMPLOYEE VALUES ('333', 'Johnson', 'Kevin', 'kevin.johnson@abcco.com', '200');
INSERT INTO EMPLOYEE VALUES ('444', 'Monty', 'Sally', 'sally.monty@abcco.com', '300');
INSERT INTO EMPLOYEE VALUES ('555', 'Arlington', 'Maureen', 'maureen.arlington@abcco.com', '400');
INSERT INTO EMPLOYEE VALUES ('666', 'Ringley', 'Justin', 'justin.ringley@abcco.com', '500');
INSERT INTO EMPLOYEE VALUES ('777', 'Lantern', 'Michael', 'michael.lantern@abcco.com', '600');
INSERT INTO EMPLOYEE VALUES ('888', 'Gondola', 'Thomas', 'thomas.gondola@abcco.com', '700');
INSERT INTO EMPLOYEE VALUES ('999', 'Runaway', 'Ralph', 'ralph.runaway@abcco.com', '800');
INSERT INTO EMPLOYEE VALUES ('121', 'Brothers', 'Layla', 'layla.brothers@abcco.com', '800');
INSERT INTO EMPLOYEE VALUES ('131', 'Sutherly', 'James', 'james.sutherly@abcco.com', '800');
INSERT INTO EMPLOYEE VALUES ('141', 'Grommet', 'Alison', 'alison.grommet@abcco.com', '600');
INSERT INTO EMPLOYEE VALUES ('151', 'Zumba', 'Jennifer', 'jennifer.zumba@abcco.com', '300');
INSERT INTO EMPLOYEE VALUES ('161', 'Brinkley', 'Babu', 'babu.brinkley@abcco.com', '800');
INSERT INTO EMPLOYEE VALUES ('171', 'Glassberg', 'Karen', 'karen.glassberg@abcco.com', '700');
INSERT INTO EMPLOYEE VALUES ('181', 'Michaels', 'Rusty', 'rusty.michaels@abcco.com', '500');

-- SQL to insert rows into STAKEHOLDER
INSERT INTO STAKEHOLDER VALUES ('301', 'Crane', 'Sarah', 'sarah.crane@lswn.org', 'Long Shore');
INSERT INTO STAKEHOLDER VALUES ('302', 'Shire', 'Micheal', 'shirem@lswn.org', 'Long Shore');
INSERT INTO STAKEHOLDER VALUES ('303', 'Mundy', 'Morty', 'mmundy@mntv.edu', 'Mount View');
INSERT INTO STAKEHOLDER VALUES ('304', 'Lankran', 'Rishi', 'rishil@mmp.com', 'Maine Map');
INSERT INTO STAKEHOLDER VALUES ('305', 'Singer', 'Barbara', 'bsinger@arnold.com', 'Arnold');
INSERT INTO STAKEHOLDER VALUES ('306', 'Moose', 'Micheal', 'moosem@lswn.org', 'Long Shore');
INSERT INTO STAKEHOLDER VALUES ('307', 'Shaker', 'Salty', 'sshaker@mntv.edu', 'Mount View');
INSERT INTO STAKEHOLDER VALUES ('308', 'Silver', 'Lawrence', 'lsilver@arnold.com', 'Arnold');

-- SQL to insert rows into TEST_ENV
INSERT INTO TEST_ENV VALUES ('1', 'Production');
INSERT INTO TEST_ENV VALUES ('2', 'Test1');
INSERT INTO TEST_ENV VALUES ('3', 'Test2');
INSERT INTO TEST_ENV VALUES ('4', 'Train');

-- SQL to insert rows into PRIORITY
INSERT INTO PRIORITY VALUES ('1', 'Urgent');
INSERT INTO PRIORITY VALUES ('2', 'Routine');
INSERT INTO PRIORITY VALUES ('3', 'ASAP');

-- SQL to insert rows into REQUEST_TYPE
INSERT INTO REQUEST_TYPE VALUES ('401', 'Enhancement');
INSERT INTO REQUEST_TYPE VALUES ('402', 'Security');
INSERT INTO REQUEST_TYPE VALUES ('403', 'Bug Fix');
INSERT INTO REQUEST_TYPE VALUES ('404', 'Upgrade');
INSERT INTO REQUEST_TYPE VALUES ('405', 'Report');

-- SQL to insert rows into STATUS
INSERT INTO STATUS VALUES ('1', 'New-Unapproved');
INSERT INTO STATUS VALUES ('2', 'New-Assigned');
INSERT INTO STATUS VALUES ('3', 'Denied');
INSERT INTO STATUS VALUES ('4', 'In Progress');
INSERT INTO STATUS VALUES ('5', 'In Testing');
INSERT INTO STATUS VALUES ('6', 'Complete');

-- SQL to insert rows into REQUEST
INSERT INTO REQUEST VALUES ('100', 'Add Comment field to Demo screen', DATE('2014-09-15'), DATE('2014-09-30'), '401', '1', '999', '6', '888', '304');
INSERT INTO REQUEST VALUES ('101', 'Add field for audit review date', DATE('2014-10-15'), NULL, '401', '2', '161', '5', '141', '306');
INSERT INTO REQUEST VALUES ('102', 'Report for Yearly Auditing', DATE('2014-10-10'), NULL, '405', '2', '161', '4', '777', '307');
INSERT INTO REQUEST VALUES ('103', 'Request to update content file', DATE('2014-10-30'), DATE('2014-11-02'), '404', '1', '121', '6', '111', '306');
INSERT INTO REQUEST VALUES ('104', 'Report for Daily Usage', DATE('2014-09-28'), DATE('2014-10-14'), '405', '1', '131', '6', '222', '302');
INSERT INTO REQUEST VALUES ('105', 'Add entries to dictionary 14', DATE('2014-10-15'), DATE('2014-10-30'), '401', '3', '131', '6', '151', '308');
INSERT INTO REQUEST VALUES ('106', 'Add field for completion date', DATE('2014-10-28'), DATE('2014-11-02'), '401', '2', '999', '3', '333', '304');
INSERT INTO REQUEST VALUES ('107', 'Add date field to Demo screen', DATE('2014-10-29'), NULL, '401', '2', '121', '1', '555', '301');
INSERT INTO REQUEST VALUES ('108', 'Run update file for eligibility', DATE('2014-11-03'), NULL, '402', '1', '131', '4', '222', '304');
INSERT INTO REQUEST VALUES ('109', 'Upgrade to V4.1', DATE('2014-10-25'), NULL, '404', '2', '999', '4', '181', '301');
INSERT INTO REQUEST VALUES ('110', 'Add entries to dictionary 52', DATE('2014-11-04'), DATE('2014-11-10'), '402', '1', '121', '6', '111', '302');
INSERT INTO REQUEST VALUES ('111', 'Remove extra characters from CH.214 screen', DATE('2014-11-15'), NULL, '403', '2', '131', '1', '171', '304');
INSERT INTO REQUEST VALUES ('112', 'Update CHcontext file', DATE('2014-11-16'), NULL, '404', '3', '161', '2', '141', '308');

-- SQL to insert rows into BUILD_CONFIG
INSERT INTO BUILD_CONFIG VALUES ('10', '2', '100');
INSERT INTO BUILD_CONFIG VALUES ('11', '3', '101');
INSERT INTO BUILD_CONFIG VALUES ('12', '1', '102');
INSERT INTO BUILD_CONFIG VALUES ('13', '2', '103');
INSERT INTO BUILD_CONFIG VALUES ('14', '1', '104');
INSERT INTO BUILD_CONFIG VALUES ('15', '2', '105');
INSERT INTO BUILD_CONFIG VALUES ('16', '2', '106');
INSERT INTO BUILD_CONFIG VALUES ('17', '4', '107');
INSERT INTO BUILD_CONFIG VALUES ('18', '1', '108');
INSERT INTO BUILD_CONFIG VALUES ('19', '2', '109');
INSERT INTO BUILD_CONFIG VALUES ('20', '2', '110');
INSERT INTO BUILD_CONFIG VALUES ('21', '3', '111');
INSERT INTO BUILD_CONFIG VALUES ('22', '2', '112');


--Ending SQLite commands

.output stdout
.echo OFF
