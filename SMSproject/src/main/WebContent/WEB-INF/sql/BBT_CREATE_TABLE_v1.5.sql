DROP TABLE employee CASCADE CONSTRAINT;
DROP TABLE dept CASCADE CONSTRAINT;
DROP TABLE leader CASCADE CONSTRAINT;
DROP TABLE session_key CASCADE CONSTRAINT;
DROP TABLE validation CASCADE CONSTRAINT;
DROP TABLE weekly_plan CASCADE CONSTRAINT;
DROP TABLE daily_plan CASCADE CONSTRAINT;
DROP TABLE plan CASCADE CONSTRAINT;
DROP TABLE daily_report CASCADE CONSTRAINT;
DROP TABLE consulting CASCADE CONSTRAINT;
DROP TABLE consulting_img CASCADE CONSTRAINT;
DROP TABLE client CASCADE CONSTRAINT;
DROP TABLE message CASCADE CONSTRAINT;
DROP TABLE events CASCADE CONSTRAINT;


-- �μ�
CREATE TABLE DEPT (
	dept_id   NUMBER(3)    NOT NULL, -- �μ�seq
	dept_name VARCHAR2(50) NOT NULL  -- �μ���
);

-- �μ� �⺻Ű
CREATE UNIQUE INDEX PK_DEPT
	ON DEPT ( -- �μ�
		dept_id ASC -- �μ�seq
	);

-- �μ�
ALTER TABLE DEPT
	ADD
		CONSTRAINT PK_DEPT -- �μ� �⺻Ű
		PRIMARY KEY (
			dept_id -- �μ�seq
		);

-- ���
CREATE TABLE EMPLOYEE (
	emp_id   NUMBER(6)    NOT NULL, -- ���seq
	emp_name VARCHAR2(50) NULL,     -- �����
	password VARCHAR(64)  NOT NULL, -- ��й�ȣ
	phone    VARCHAR2(30) NULL,     -- ����ó
	email    VARCHAR2(40) NOT NULL, -- �̸���
	position VARCHAR2(25) NULL,     -- ����
	dept_id  NUMBER(3)    NOT NULL, -- �μ�seq
	state    VARCHAR2(20) NULL,     -- ��ȿ��������
	img_name VARCHAR2(60) NULL      -- �����ʻ�����
);

-- ��� �⺻Ű
CREATE UNIQUE INDEX PK_EMPLOYEE
	ON EMPLOYEE ( -- ���
		emp_id ASC -- ���seq
	);

-- �̸��� ����ũ
CREATE UNIQUE INDEX UIX_EMAIL
	ON EMPLOYEE ( -- ���
		email ASC -- �̸���
	);

-- ���
ALTER TABLE EMPLOYEE
	ADD
		CONSTRAINT PK_EMPLOYEE -- ��� �⺻Ű
		PRIMARY KEY (
			emp_id -- ���seq
		);

-- ���
ALTER TABLE EMPLOYEE
	ADD
		CONSTRAINT UK_EMPLOYEE -- ��� ����ũ ����
		UNIQUE (
			email -- �̸���
		);

-- �ŷ�ó
CREATE TABLE CLIENT (
	client_id   NUMBER(6)     NOT NULL, -- �ŷ�óseq
	client_code VARCHAR2(64)  NOT NULL, -- ���ڵ�
	client_name VARCHAR2(50)  NOT NULL, -- �ŷ�ó�̸�
	second_name VARCHAR2(50)  NULL,     -- 2���ŷ���
	address     VARCHAR2(255) NULL,     -- �ּ�
	phone       VARCHAR2(30)  NULL,     -- ����ó
	CEO         VARCHAR2(50)  NULL,     -- ��ǥ
	is_delete   NUMBER(1)     NULL,     -- ��������
	reg_date    DATE          NULL      -- �������
);

-- �ŷ�ó �⺻Ű
CREATE UNIQUE INDEX PK_CLIENT
	ON CLIENT ( -- �ŷ�ó
		client_id ASC -- �ŷ�óseq
	);

-- �ŷ�ó ����ũ �ε���
CREATE UNIQUE INDEX UIX_CLIENT_CODE
	ON CLIENT ( -- �ŷ�ó
		client_code ASC -- ���ڵ�
	);

-- �ŷ�ó
ALTER TABLE CLIENT
	ADD
		CONSTRAINT PK_CLIENT -- �ŷ�ó �⺻Ű
		PRIMARY KEY (
			client_id -- �ŷ�óseq
		);

-- �ŷ�ó
ALTER TABLE CLIENT
	ADD
		CONSTRAINT UK_CLIENT -- �ŷ�ó ����ũ ����
		UNIQUE (
			client_code -- ���ڵ�
		);

-- ���Ϻ���
CREATE TABLE DAILY_REPORT (
	daily_report_id NUMBER(7)      NOT NULL, -- ���Ϻ���seq
	title           VARCHAR2(255)  NULL,     -- ����
	emp_id          NUMBER(6)      NOT NULL, -- ���seq
	departure       NUMBER(7)      NULL,     -- ��ٽ� �����
	arrival         NUMBER(7)      NULL,     -- ��ٽ� �����
	profit          NUMBER(16)     NOT NULL, -- �����
	reg_date        DATE           NULL,     -- �������
	content         VARCHAR2(4000) NULL,     -- ���Ϻ�����
	feedback        VARCHAR2(2000) NULL      -- �����ǰ�
);

-- ���Ϻ��� �⺻Ű
CREATE UNIQUE INDEX PK_DAILY_REPORT
	ON DAILY_REPORT ( -- ���Ϻ���
		daily_report_id ASC -- ���Ϻ���seq
	);

-- ���Ϻ��� ����ũ �ε���
CREATE UNIQUE INDEX UIX_DAILY_REPORT
	ON DAILY_REPORT ( -- ���Ϻ���
		emp_id   ASC, -- ���seq
		reg_date ASC  -- �������
	);

-- ���Ϻ���
ALTER TABLE DAILY_REPORT
	ADD
		CONSTRAINT PK_DAILY_REPORT -- ���Ϻ��� �⺻Ű
		PRIMARY KEY (
			daily_report_id -- ���Ϻ���seq
		);

-- ���Ϻ���
ALTER TABLE DAILY_REPORT
	ADD
		CONSTRAINT UK_DAILY_REPORT -- ���Ϻ��� ����ũ ����
		UNIQUE (
			emp_id,   -- ���seq
			reg_date  -- �������
		);

-- �������
CREATE TABLE Consulting (
	consulting_id   NUMBER(7)      NOT NULL, -- �������seq
	title           VARCHAR2(255)  NULL,     -- ����
	reg_date        DATE           NULL,     -- ��㳯¥
	content         VARCHAR2(4000) NULL,     -- ��㳻��
	client_id       NUMBER(6)      NOT NULL, -- �ŷ�óseq
	daily_report_id NUMBER(7)      NULL      -- ���Ϻ���seq
);

-- ������� �⺻Ű
CREATE UNIQUE INDEX PK_Consulting
	ON Consulting ( -- �������
		consulting_id ASC -- �������seq
	);

-- �������
ALTER TABLE Consulting
	ADD
		CONSTRAINT PK_Consulting -- ������� �⺻Ű
		PRIMARY KEY (
			consulting_id -- �������seq
		);

-- �ְ���ȹ
CREATE TABLE WEEKLY_PLAN (
	weekly_plan_id NUMBER(7)     NOT NULL, -- �ְ���ȹseq
	emp_id         NUMBER(6)     NOT NULL, -- ���seq
	reg_date       DATE          NOT NULL, -- �������
	title          VARCHAR2(255) NOT NULL, -- ����
	monday         DATE          NULL,     -- ������
	checked        NUMBER(1)     NULL      -- ��������
);

-- �ְ���ȹ �⺻Ű
CREATE UNIQUE INDEX PK_WEEKLY_PLAN
	ON WEEKLY_PLAN ( -- �ְ���ȹ
		weekly_plan_id ASC -- �ְ���ȹseq
	);

-- �ְ���ȹ ����ũ �ε���
CREATE UNIQUE INDEX UIX_WEEKLY_PLAN
	ON WEEKLY_PLAN ( -- �ְ���ȹ
		emp_id ASC, -- ���seq
		monday ASC  -- ������
	);

-- �ְ���ȹ
ALTER TABLE WEEKLY_PLAN
	ADD
		CONSTRAINT PK_WEEKLY_PLAN -- �ְ���ȹ �⺻Ű
		PRIMARY KEY (
			weekly_plan_id -- �ְ���ȹseq
		);

-- �ְ���ȹ
ALTER TABLE WEEKLY_PLAN
	ADD
		CONSTRAINT UK_WEEKLY_PLAN -- �ְ���ȹ ����ũ ����
		UNIQUE (
			emp_id, -- ���seq
			monday  -- ������
		);

-- ����
CREATE TABLE DAILY_PLAN (
	daily_plan_id  NUMBER(7)  NOT NULL, -- ����seq
	weekly_plan_id NUMBER(7)  NOT NULL, -- �ְ���ȹseq
	plan_date      DATE       NULL,     -- ������¥
	sales_goal     NUMBER(16) NULL      -- �����ǥ
);

-- ���� �⺻Ű
CREATE UNIQUE INDEX PK_DAILY_PLAN
	ON DAILY_PLAN ( -- ����
		daily_plan_id ASC -- ����seq
	);

-- ����
ALTER TABLE DAILY_PLAN
	ADD
		CONSTRAINT PK_DAILY_PLAN -- ���� �⺻Ű
		PRIMARY KEY (
			daily_plan_id -- ����seq
		);

-- ���������̺�
CREATE TABLE VALIDATION (
	valid_id   NUMBER(6)    NOT NULL, -- ����seq
	emp_id     NUMBER(6)    NOT NULL, -- ���seq
	code       VARCHAR2(64) NOT NULL, -- ������ȣ
	valid_date DATE         NOT NULL  -- ������û�ð�
);

-- ���������̺� �⺻Ű
CREATE UNIQUE INDEX PK_VALIDATION
	ON VALIDATION ( -- ���������̺�
		valid_id ASC -- ����seq
	);

-- ���������̺�
ALTER TABLE VALIDATION
	ADD
		CONSTRAINT PK_VALIDATION -- ���������̺� �⺻Ű
		PRIMARY KEY (
			valid_id -- ����seq
		);

-- �޼���
CREATE TABLE MESSAGE (
	msg_id   NUMBER(8)      NOT NULL, -- �޼���seq
	emp_id   NUMBER(6)      NOT NULL, -- ���seq
	sender   NUMBER(6)      NULL,     -- �������
	content  VARCHAR2(2000) NULL,     -- �޼���
	checked  NUMBER(1)      NULL,     -- ��������
	msg_date DATE           NULL      -- �����ð�
);

-- �޼��� �⺻Ű
CREATE UNIQUE INDEX PK_MESSAGE
	ON MESSAGE ( -- �޼���
		msg_id ASC -- �޼���seq
	);

-- �޼���
ALTER TABLE MESSAGE
	ADD
		CONSTRAINT PK_MESSAGE -- �޼��� �⺻Ű
		PRIMARY KEY (
			msg_id -- �޼���seq
		);

-- �μ���
CREATE TABLE LEADER (
	leader_id NUMBER(7) NOT NULL, -- �μ���seq
	dept_id   NUMBER(3) NOT NULL, -- �μ�seq
	emp_id    NUMBER(6) NOT NULL  -- ���seq
);

-- �μ��� �⺻Ű
CREATE UNIQUE INDEX PK_LEADER
	ON LEADER ( -- �μ���
		leader_id ASC -- �μ���seq
	);

-- �μ���
ALTER TABLE LEADER
	ADD
		CONSTRAINT PK_LEADER -- �μ��� �⺻Ű
		PRIMARY KEY (
			leader_id -- �μ���seq
		);

-- ��������������̺�
CREATE TABLE CONSULTING_IMG (
	consulting_img_id NUMBER(7)    NOT NULL, -- �����������seq
	consulting_id     NUMBER(7)    NOT NULL, -- �������seq
	img_name          VARCHAR2(60) NOT NULL, -- �������ϸ�
	origin_name       VARCHAR2(60) NULL      -- ����(origin)�������ϸ�
);

-- ��������������̺� �⺻Ű
CREATE UNIQUE INDEX PK_CONSULTING_IMG
	ON CONSULTING_IMG ( -- ��������������̺�
		consulting_img_id ASC -- �����������seq
	);

-- ��������������̺�
ALTER TABLE CONSULTING_IMG
	ADD
		CONSTRAINT PK_CONSULTING_IMG -- ��������������̺� �⺻Ű
		PRIMARY KEY (
			consulting_img_id -- �����������seq
		);

-- ����
CREATE TABLE SESSION_KEY (
	session_key_id NUMBER(9)     NOT NULL, -- ����seq
	session_id     VARCHAR2(100) NULL,     -- ����ID
	emp_id         NUMBER(6)     NULL,     -- ���seq
	ip             VARCHAR2(25)  NULL,     -- ������
	expiration     date          NULL,     -- ����Ⱓ
	mac_addr       VARCHAR2(17)  NULL      -- ����ּ�
);

-- ���� �⺻Ű
CREATE UNIQUE INDEX PK_SESSION_KEY
	ON SESSION_KEY ( -- ����
		session_key_id ASC -- ����seq
	);

-- ����
ALTER TABLE SESSION_KEY
	ADD
		CONSTRAINT PK_SESSION_KEY -- ���� �⺻Ű
		PRIMARY KEY (
			session_key_id -- ����seq
		);

-- �÷�
CREATE TABLE PLAN (
	plan_id       NUMBER(8)    NOT NULL, -- �÷�seq
	daily_plan_id NUMBER(7)    NULL,     -- ����seq
	content       VARCHAR2(20) NULL,     -- �÷�����
	type          VARCHAR2(25) NULL      -- �÷�����
);

-- �÷� �⺻Ű
CREATE UNIQUE INDEX PK_PLAN
	ON PLAN ( -- �÷�
		plan_id ASC -- �÷�seq
	);

-- �÷�
ALTER TABLE PLAN
	ADD
		CONSTRAINT PK_PLAN -- �÷� �⺻Ű
		PRIMARY KEY (
			plan_id -- �÷�seq
		);

-- Ư��
CREATE TABLE EVENTS (
	event_id   NUMBER(7)    NOT NULL, -- Ư��seq
	event_date DATE         NOT NULL, -- ��¥
	holiday    NUMBER(1)    NULL,     -- ���Ͽ���
	title      VARCHAR2(20) NULL      -- ����
);

-- Ư�� �⺻Ű
CREATE UNIQUE INDEX PK_EVENTS
	ON EVENTS ( -- Ư��
		event_id ASC -- Ư��seq
	);

-- Ư��
ALTER TABLE EVENTS
	ADD
		CONSTRAINT PK_EVENTS -- Ư�� �⺻Ű
		PRIMARY KEY (
			event_id -- Ư��seq
		);

-- ���
ALTER TABLE EMPLOYEE
	ADD
		CONSTRAINT FK_DEPT_TO_EMPLOYEE -- �μ� -> ���
		FOREIGN KEY (
			dept_id -- �μ�seq
		)
		REFERENCES DEPT ( -- �μ�
			dept_id -- �μ�seq
		);

-- ���Ϻ���
ALTER TABLE DAILY_REPORT
	ADD
		CONSTRAINT FK_EMPLOYEE_TO_DAILY_REPORT -- ��� -> ���Ϻ���
		FOREIGN KEY (
			emp_id -- ���seq
		)
		REFERENCES EMPLOYEE ( -- ���
			emp_id -- ���seq
		);

-- �������
ALTER TABLE Consulting
	ADD
		CONSTRAINT FK_CLIENT_TO_Consulting -- �ŷ�ó -> �������
		FOREIGN KEY (
			client_id -- �ŷ�óseq
		)
		REFERENCES CLIENT ( -- �ŷ�ó
			client_id -- �ŷ�óseq
		);

-- �������
ALTER TABLE Consulting
	ADD
		CONSTRAINT FK_DAILY_REPORT_TO_Consulting -- ���Ϻ��� -> �������
		FOREIGN KEY (
			daily_report_id -- ���Ϻ���seq
		)
		REFERENCES DAILY_REPORT ( -- ���Ϻ���
			daily_report_id -- ���Ϻ���seq
		) ON DELETE CASCADE;

-- �ְ���ȹ
ALTER TABLE WEEKLY_PLAN
	ADD
		CONSTRAINT FK_EMPLOYEE_TO_WEEKLY_PLAN -- ��� -> �ְ���ȹ
		FOREIGN KEY (
			emp_id -- ���seq
		)
		REFERENCES EMPLOYEE ( -- ���
			emp_id -- ���seq
		);

-- ����
ALTER TABLE DAILY_PLAN
	ADD
		CONSTRAINT FK_WEEKLY_PLAN_TO_DAILY_PLAN -- �ְ���ȹ -> ����
		FOREIGN KEY (
			weekly_plan_id -- �ְ���ȹseq
		)
		REFERENCES WEEKLY_PLAN ( -- �ְ���ȹ
			weekly_plan_id -- �ְ���ȹseq
		) ON DELETE CASCADE;

-- ���������̺�
ALTER TABLE VALIDATION
	ADD
		CONSTRAINT FK_EMPLOYEE_TO_VALIDATION -- ��� -> ���������̺�
		FOREIGN KEY (
			emp_id -- ���seq
		)
		REFERENCES EMPLOYEE ( -- ���
			emp_id -- ���seq
		);

-- �޼���
ALTER TABLE MESSAGE
	ADD
		CONSTRAINT FK_EMPLOYEE_TO_MESSAGE -- ��� -> �޼���
		FOREIGN KEY (
			emp_id -- ���seq
		)
		REFERENCES EMPLOYEE ( -- ���
			emp_id -- ���seq
		);

-- �μ���
ALTER TABLE LEADER
	ADD
		CONSTRAINT FK_DEPT_TO_LEADER -- �μ� -> �μ���
		FOREIGN KEY (
			dept_id -- �μ�seq
		)
		REFERENCES DEPT ( -- �μ�
			dept_id -- �μ�seq
		);

-- �μ���
ALTER TABLE LEADER
	ADD
		CONSTRAINT FK_EMPLOYEE_TO_LEADER -- ��� -> �μ���
		FOREIGN KEY (
			emp_id -- ���seq
		)
		REFERENCES EMPLOYEE ( -- ���
			emp_id -- ���seq
		);

-- ��������������̺�
ALTER TABLE CONSULTING_IMG
	ADD
		CONSTRAINT FK_Consulting_TO_IMG -- ������� -> ��������������̺�
		FOREIGN KEY (
			consulting_id -- �������seq
		)
		REFERENCES Consulting ( -- �������
			consulting_id -- �������seq
		) ON DELETE CASCADE;

-- ����
ALTER TABLE SESSION_KEY
	ADD
		CONSTRAINT FK_EMPLOYEE_TO_SESSION_KEY -- ��� -> ����
		FOREIGN KEY (
			emp_id -- ���seq
		)
		REFERENCES EMPLOYEE ( -- ���
			emp_id -- ���seq
		);

-- �÷�
ALTER TABLE PLAN
	ADD
		CONSTRAINT FK_DAILY_PLAN_TO_PLAN -- ���� -> �÷�
		FOREIGN KEY (
			daily_plan_id -- ����seq
		)
		REFERENCES DAILY_PLAN ( -- ����
			daily_plan_id -- ����seq
		) ON DELETE CASCADE;


ALTER TABLE employee
MODIFY (state DEFAULT 'ACTIVE');

ALTER TABLE employee
MODIFY (IMG_NAME DEFAULT 'NONAME');

ALTER TABLE WEEKLY_PLAN
MODIFY (checked DEFAULT 0);

ALTER TABLE client
MODIFY (reg_date DEFAULT SYSDATE);

ALTER TABLE message
MODIFY (msg_date DEFAULT SYSDATE);

ALTER TABLE daily_report
MODIFY (reg_date DEFAULT trunc(SYSDATE));

ALTER TABLE message
MODIFY (checked DEFAULT 0);

ALTER TABLE EVENTS
MODIFY (holiday DEFAULT 0);

ALTER TABLE client
MODIFY (is_delete DEFAULT 0);