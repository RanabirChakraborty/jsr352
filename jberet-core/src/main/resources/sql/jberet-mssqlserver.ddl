CREATE TABLE JOB_INSTANCE (
  JOBINSTANCEID   BIGINT NOT NULL PRIMARY KEY IDENTITY,
  VERSION         INTEGER,
  JOBNAME         VARCHAR(512),
  APPLICATIONNAME VARCHAR(512)
)!!
CREATE TABLE JOB_EXECUTION (
  JOBEXECUTIONID  BIGINT NOT NULL PRIMARY KEY IDENTITY,
  JOBINSTANCEID   BIGINT NOT NULL,
  VERSION         INTEGER,
  CREATETIME      DATETIME,
  STARTTIME       DATETIME,
  ENDTIME         DATETIME,
  LASTUPDATEDTIME DATETIME,
  BATCHSTATUS     VARCHAR(30),
  EXITSTATUS      VARCHAR(512),
  JOBPARAMETERS   VARCHAR(3000),
  RESTARTPOSITION VARCHAR(255),
  CONSTRAINT FK_JOB_EXECUTION_JOB_INSTANCE FOREIGN KEY (JOBINSTANCEID) REFERENCES JOB_INSTANCE (JOBINSTANCEID) ON DELETE CASCADE
)!!
CREATE TABLE STEP_EXECUTION (
  STEPEXECUTIONID    BIGINT NOT NULL PRIMARY KEY IDENTITY,
  JOBEXECUTIONID     BIGINT NOT NULL,
  VERSION            INTEGER,
  STEPNAME           VARCHAR(255),
  STARTTIME          DATETIME,
  ENDTIME            DATETIME,
  BATCHSTATUS        VARCHAR(30),
  EXITSTATUS         VARCHAR(512),
  EXECUTIONEXCEPTION VARCHAR(2048),
  PERSISTENTUSERDATA VARBINARY(8000),
  READCOUNT          INTEGER,
  WRITECOUNT         INTEGER,
  COMMITCOUNT        INTEGER,
  ROLLBACKCOUNT      INTEGER,
  READSKIPCOUNT      INTEGER,
  PROCESSSKIPCOUNT   INTEGER,
  FILTERCOUNT        INTEGER,
  WRITESKIPCOUNT     INTEGER,
  READERCHECKPOINTINFO  VARBINARY(8000),
  WRITERCHECKPOINTINFO  VARBINARY(8000),
  CONSTRAINT FK_STEP_EXE_JOB_EXE FOREIGN KEY (JOBEXECUTIONID) REFERENCES JOB_EXECUTION (JOBEXECUTIONID) ON DELETE CASCADE
)!!
CREATE TABLE PARTITION_EXECUTION (
  PARTITIONEXECUTIONID  INTEGER NOT NULL,
  STEPEXECUTIONID       BIGINT  NOT NULL,
  VERSION               INTEGER,
  BATCHSTATUS           VARCHAR(30),
  EXITSTATUS            VARCHAR(512),
  EXECUTIONEXCEPTION    VARCHAR(2048),
  PERSISTENTUSERDATA    VARBINARY(8000),
  READERCHECKPOINTINFO  VARBINARY(8000),
  WRITERCHECKPOINTINFO  VARBINARY(8000),
  PRIMARY KEY (PARTITIONEXECUTIONID, STEPEXECUTIONID),
  CONSTRAINT FK_PARTITION_EXE_STEP_EXE FOREIGN KEY (STEPEXECUTIONID) REFERENCES STEP_EXECUTION (STEPEXECUTIONID) ON DELETE CASCADE
)!!

