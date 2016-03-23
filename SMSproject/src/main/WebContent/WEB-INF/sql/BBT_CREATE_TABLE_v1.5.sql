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


-- 부서
CREATE TABLE DEPT (
	dept_id   NUMBER(3)    NOT NULL, -- 부서seq
	dept_name VARCHAR2(50) NOT NULL  -- 부서명
);

-- 부서 기본키
CREATE UNIQUE INDEX PK_DEPT
	ON DEPT ( -- 부서
		dept_id ASC -- 부서seq
	);

-- 부서
ALTER TABLE DEPT
	ADD
		CONSTRAINT PK_DEPT -- 부서 기본키
		PRIMARY KEY (
			dept_id -- 부서seq
		);

-- 사원
CREATE TABLE EMPLOYEE (
	emp_id   NUMBER(6)    NOT NULL, -- 사원seq
	emp_name VARCHAR2(50) NULL,     -- 사원명
	password VARCHAR(64)  NOT NULL, -- 비밀번호
	phone    VARCHAR2(30) NULL,     -- 연락처
	email    VARCHAR2(40) NOT NULL, -- 이메일
	position VARCHAR2(25) NULL,     -- 직위
	dept_id  NUMBER(3)    NOT NULL, -- 부서seq
	state    VARCHAR2(20) NULL,     -- 유효계정유무
	img_name VARCHAR2(60) NULL      -- 프로필사진명
);

-- 사원 기본키
CREATE UNIQUE INDEX PK_EMPLOYEE
	ON EMPLOYEE ( -- 사원
		emp_id ASC -- 사원seq
	);

-- 이메일 유니크
CREATE UNIQUE INDEX UIX_EMAIL
	ON EMPLOYEE ( -- 사원
		email ASC -- 이메일
	);

-- 사원
ALTER TABLE EMPLOYEE
	ADD
		CONSTRAINT PK_EMPLOYEE -- 사원 기본키
		PRIMARY KEY (
			emp_id -- 사원seq
		);

-- 사원
ALTER TABLE EMPLOYEE
	ADD
		CONSTRAINT UK_EMPLOYEE -- 사원 유니크 제약
		UNIQUE (
			email -- 이메일
		);

-- 거래처
CREATE TABLE CLIENT (
	client_id   NUMBER(6)     NOT NULL, -- 거래처seq
	client_code VARCHAR2(64)  NOT NULL, -- 고객코드
	client_name VARCHAR2(50)  NOT NULL, -- 거래처이름
	second_name VARCHAR2(50)  NULL,     -- 2차거래선
	address     VARCHAR2(255) NULL,     -- 주소
	phone       VARCHAR2(30)  NULL,     -- 연락처
	CEO         VARCHAR2(50)  NULL,     -- 대표
	is_delete   NUMBER(1)     NULL,     -- 삭제여부
	reg_date    DATE          NULL      -- 등록일자
);

-- 거래처 기본키
CREATE UNIQUE INDEX PK_CLIENT
	ON CLIENT ( -- 거래처
		client_id ASC -- 거래처seq
	);

-- 거래처 유니크 인덱스
CREATE UNIQUE INDEX UIX_CLIENT_CODE
	ON CLIENT ( -- 거래처
		client_code ASC -- 고객코드
	);

-- 거래처
ALTER TABLE CLIENT
	ADD
		CONSTRAINT PK_CLIENT -- 거래처 기본키
		PRIMARY KEY (
			client_id -- 거래처seq
		);

-- 거래처
ALTER TABLE CLIENT
	ADD
		CONSTRAINT UK_CLIENT -- 거래처 유니크 제약
		UNIQUE (
			client_code -- 고객코드
		);

-- 일일보고
CREATE TABLE DAILY_REPORT (
	daily_report_id NUMBER(7)      NOT NULL, -- 일일보고seq
	title           VARCHAR2(255)  NULL,     -- 제목
	emp_id          NUMBER(6)      NOT NULL, -- 사원seq
	departure       NUMBER(7)      NULL,     -- 출근시 계기판
	arrival         NUMBER(7)      NULL,     -- 퇴근시 계기판
	profit          NUMBER(16)     NOT NULL, -- 매출액
	reg_date        DATE           NULL,     -- 등록일자
	content         VARCHAR2(4000) NULL,     -- 일일보고내용
	feedback        VARCHAR2(2000) NULL      -- 팀장의견
);

-- 일일보고 기본키
CREATE UNIQUE INDEX PK_DAILY_REPORT
	ON DAILY_REPORT ( -- 일일보고
		daily_report_id ASC -- 일일보고seq
	);

-- 일일보고 유니크 인덱스
CREATE UNIQUE INDEX UIX_DAILY_REPORT
	ON DAILY_REPORT ( -- 일일보고
		emp_id   ASC, -- 사원seq
		reg_date ASC  -- 등록일자
	);

-- 일일보고
ALTER TABLE DAILY_REPORT
	ADD
		CONSTRAINT PK_DAILY_REPORT -- 일일보고 기본키
		PRIMARY KEY (
			daily_report_id -- 일일보고seq
		);

-- 일일보고
ALTER TABLE DAILY_REPORT
	ADD
		CONSTRAINT UK_DAILY_REPORT -- 일일보고 유니크 제약
		UNIQUE (
			emp_id,   -- 사원seq
			reg_date  -- 등록일자
		);

-- 상담일지
CREATE TABLE Consulting (
	consulting_id   NUMBER(7)      NOT NULL, -- 상담일지seq
	title           VARCHAR2(255)  NULL,     -- 제목
	reg_date        DATE           NULL,     -- 상담날짜
	content         VARCHAR2(4000) NULL,     -- 상담내용
	client_id       NUMBER(6)      NOT NULL, -- 거래처seq
	daily_report_id NUMBER(7)      NULL      -- 일일보고seq
);

-- 상담일지 기본키
CREATE UNIQUE INDEX PK_Consulting
	ON Consulting ( -- 상담일지
		consulting_id ASC -- 상담일지seq
	);

-- 상담일지
ALTER TABLE Consulting
	ADD
		CONSTRAINT PK_Consulting -- 상담일지 기본키
		PRIMARY KEY (
			consulting_id -- 상담일지seq
		);

-- 주간계획
CREATE TABLE WEEKLY_PLAN (
	weekly_plan_id NUMBER(7)     NOT NULL, -- 주간계획seq
	emp_id         NUMBER(6)     NOT NULL, -- 사원seq
	reg_date       DATE          NOT NULL, -- 등록일자
	title          VARCHAR2(255) NOT NULL, -- 제목
	monday         DATE          NULL,     -- 월요일
	checked        NUMBER(1)     NULL      -- 열람유무
);

-- 주간계획 기본키
CREATE UNIQUE INDEX PK_WEEKLY_PLAN
	ON WEEKLY_PLAN ( -- 주간계획
		weekly_plan_id ASC -- 주간계획seq
	);

-- 주간계획 유니크 인덱스
CREATE UNIQUE INDEX UIX_WEEKLY_PLAN
	ON WEEKLY_PLAN ( -- 주간계획
		emp_id ASC, -- 사원seq
		monday ASC  -- 월요일
	);

-- 주간계획
ALTER TABLE WEEKLY_PLAN
	ADD
		CONSTRAINT PK_WEEKLY_PLAN -- 주간계획 기본키
		PRIMARY KEY (
			weekly_plan_id -- 주간계획seq
		);

-- 주간계획
ALTER TABLE WEEKLY_PLAN
	ADD
		CONSTRAINT UK_WEEKLY_PLAN -- 주간계획 유니크 제약
		UNIQUE (
			emp_id, -- 사원seq
			monday  -- 월요일
		);

-- 일정
CREATE TABLE DAILY_PLAN (
	daily_plan_id  NUMBER(7)  NOT NULL, -- 일정seq
	weekly_plan_id NUMBER(7)  NOT NULL, -- 주간계획seq
	plan_date      DATE       NULL,     -- 일정날짜
	sales_goal     NUMBER(16) NULL      -- 매출목표
);

-- 일정 기본키
CREATE UNIQUE INDEX PK_DAILY_PLAN
	ON DAILY_PLAN ( -- 일정
		daily_plan_id ASC -- 일정seq
	);

-- 일정
ALTER TABLE DAILY_PLAN
	ADD
		CONSTRAINT PK_DAILY_PLAN -- 일정 기본키
		PRIMARY KEY (
			daily_plan_id -- 일정seq
		);

-- 인증용테이블
CREATE TABLE VALIDATION (
	valid_id   NUMBER(6)    NOT NULL, -- 인증seq
	emp_id     NUMBER(6)    NOT NULL, -- 사원seq
	code       VARCHAR2(64) NOT NULL, -- 인증번호
	valid_date DATE         NOT NULL  -- 인증요청시간
);

-- 인증용테이블 기본키
CREATE UNIQUE INDEX PK_VALIDATION
	ON VALIDATION ( -- 인증용테이블
		valid_id ASC -- 인증seq
	);

-- 인증용테이블
ALTER TABLE VALIDATION
	ADD
		CONSTRAINT PK_VALIDATION -- 인증용테이블 기본키
		PRIMARY KEY (
			valid_id -- 인증seq
		);

-- 메세지
CREATE TABLE MESSAGE (
	msg_id   NUMBER(8)      NOT NULL, -- 메세지seq
	emp_id   NUMBER(6)      NOT NULL, -- 사원seq
	sender   NUMBER(6)      NULL,     -- 보낸사람
	content  VARCHAR2(2000) NULL,     -- 메세지
	checked  NUMBER(1)      NULL,     -- 열람유무
	msg_date DATE           NULL      -- 보낸시간
);

-- 메세지 기본키
CREATE UNIQUE INDEX PK_MESSAGE
	ON MESSAGE ( -- 메세지
		msg_id ASC -- 메세지seq
	);

-- 메세지
ALTER TABLE MESSAGE
	ADD
		CONSTRAINT PK_MESSAGE -- 메세지 기본키
		PRIMARY KEY (
			msg_id -- 메세지seq
		);

-- 부서장
CREATE TABLE LEADER (
	leader_id NUMBER(7) NOT NULL, -- 부서장seq
	dept_id   NUMBER(3) NOT NULL, -- 부서seq
	emp_id    NUMBER(6) NOT NULL  -- 사원seq
);

-- 부서장 기본키
CREATE UNIQUE INDEX PK_LEADER
	ON LEADER ( -- 부서장
		leader_id ASC -- 부서장seq
	);

-- 부서장
ALTER TABLE LEADER
	ADD
		CONSTRAINT PK_LEADER -- 부서장 기본키
		PRIMARY KEY (
			leader_id -- 부서장seq
		);

-- 상담일지파일테이블
CREATE TABLE CONSULTING_IMG (
	consulting_img_id NUMBER(7)    NOT NULL, -- 상담일지사진seq
	consulting_id     NUMBER(7)    NOT NULL, -- 상담일지seq
	img_name          VARCHAR2(60) NOT NULL, -- 사진파일명
	origin_name       VARCHAR2(60) NULL      -- 원래(origin)사진파일명
);

-- 상담일지파일테이블 기본키
CREATE UNIQUE INDEX PK_CONSULTING_IMG
	ON CONSULTING_IMG ( -- 상담일지파일테이블
		consulting_img_id ASC -- 상담일지사진seq
	);

-- 상담일지파일테이블
ALTER TABLE CONSULTING_IMG
	ADD
		CONSTRAINT PK_CONSULTING_IMG -- 상담일지파일테이블 기본키
		PRIMARY KEY (
			consulting_img_id -- 상담일지사진seq
		);

-- 세션
CREATE TABLE SESSION_KEY (
	session_key_id NUMBER(9)     NOT NULL, -- 세션seq
	session_id     VARCHAR2(100) NULL,     -- 세션ID
	emp_id         NUMBER(6)     NULL,     -- 사원seq
	ip             VARCHAR2(25)  NULL,     -- 아이피
	expiration     date          NULL,     -- 만료기간
	mac_addr       VARCHAR2(17)  NULL      -- 기계주소
);

-- 세션 기본키
CREATE UNIQUE INDEX PK_SESSION_KEY
	ON SESSION_KEY ( -- 세션
		session_key_id ASC -- 세션seq
	);

-- 세션
ALTER TABLE SESSION_KEY
	ADD
		CONSTRAINT PK_SESSION_KEY -- 세션 기본키
		PRIMARY KEY (
			session_key_id -- 세션seq
		);

-- 플랜
CREATE TABLE PLAN (
	plan_id       NUMBER(8)    NOT NULL, -- 플랜seq
	daily_plan_id NUMBER(7)    NULL,     -- 일정seq
	content       VARCHAR2(20) NULL,     -- 플랜내용
	type          VARCHAR2(25) NULL      -- 플랜유형
);

-- 플랜 기본키
CREATE UNIQUE INDEX PK_PLAN
	ON PLAN ( -- 플랜
		plan_id ASC -- 플랜seq
	);

-- 플랜
ALTER TABLE PLAN
	ADD
		CONSTRAINT PK_PLAN -- 플랜 기본키
		PRIMARY KEY (
			plan_id -- 플랜seq
		);

-- 특일
CREATE TABLE EVENTS (
	event_id   NUMBER(7)    NOT NULL, -- 특일seq
	event_date DATE         NOT NULL, -- 날짜
	holiday    NUMBER(1)    NULL,     -- 휴일여부
	title      VARCHAR2(20) NULL      -- 제목
);

-- 특일 기본키
CREATE UNIQUE INDEX PK_EVENTS
	ON EVENTS ( -- 특일
		event_id ASC -- 특일seq
	);

-- 특일
ALTER TABLE EVENTS
	ADD
		CONSTRAINT PK_EVENTS -- 특일 기본키
		PRIMARY KEY (
			event_id -- 특일seq
		);

-- 사원
ALTER TABLE EMPLOYEE
	ADD
		CONSTRAINT FK_DEPT_TO_EMPLOYEE -- 부서 -> 사원
		FOREIGN KEY (
			dept_id -- 부서seq
		)
		REFERENCES DEPT ( -- 부서
			dept_id -- 부서seq
		);

-- 일일보고
ALTER TABLE DAILY_REPORT
	ADD
		CONSTRAINT FK_EMPLOYEE_TO_DAILY_REPORT -- 사원 -> 일일보고
		FOREIGN KEY (
			emp_id -- 사원seq
		)
		REFERENCES EMPLOYEE ( -- 사원
			emp_id -- 사원seq
		);

-- 상담일지
ALTER TABLE Consulting
	ADD
		CONSTRAINT FK_CLIENT_TO_Consulting -- 거래처 -> 상담일지
		FOREIGN KEY (
			client_id -- 거래처seq
		)
		REFERENCES CLIENT ( -- 거래처
			client_id -- 거래처seq
		);

-- 상담일지
ALTER TABLE Consulting
	ADD
		CONSTRAINT FK_DAILY_REPORT_TO_Consulting -- 일일보고 -> 상담일지
		FOREIGN KEY (
			daily_report_id -- 일일보고seq
		)
		REFERENCES DAILY_REPORT ( -- 일일보고
			daily_report_id -- 일일보고seq
		) ON DELETE CASCADE;

-- 주간계획
ALTER TABLE WEEKLY_PLAN
	ADD
		CONSTRAINT FK_EMPLOYEE_TO_WEEKLY_PLAN -- 사원 -> 주간계획
		FOREIGN KEY (
			emp_id -- 사원seq
		)
		REFERENCES EMPLOYEE ( -- 사원
			emp_id -- 사원seq
		);

-- 일정
ALTER TABLE DAILY_PLAN
	ADD
		CONSTRAINT FK_WEEKLY_PLAN_TO_DAILY_PLAN -- 주간계획 -> 일정
		FOREIGN KEY (
			weekly_plan_id -- 주간계획seq
		)
		REFERENCES WEEKLY_PLAN ( -- 주간계획
			weekly_plan_id -- 주간계획seq
		) ON DELETE CASCADE;

-- 인증용테이블
ALTER TABLE VALIDATION
	ADD
		CONSTRAINT FK_EMPLOYEE_TO_VALIDATION -- 사원 -> 인증용테이블
		FOREIGN KEY (
			emp_id -- 사원seq
		)
		REFERENCES EMPLOYEE ( -- 사원
			emp_id -- 사원seq
		);

-- 메세지
ALTER TABLE MESSAGE
	ADD
		CONSTRAINT FK_EMPLOYEE_TO_MESSAGE -- 사원 -> 메세지
		FOREIGN KEY (
			emp_id -- 사원seq
		)
		REFERENCES EMPLOYEE ( -- 사원
			emp_id -- 사원seq
		);

-- 부서장
ALTER TABLE LEADER
	ADD
		CONSTRAINT FK_DEPT_TO_LEADER -- 부서 -> 부서장
		FOREIGN KEY (
			dept_id -- 부서seq
		)
		REFERENCES DEPT ( -- 부서
			dept_id -- 부서seq
		);

-- 부서장
ALTER TABLE LEADER
	ADD
		CONSTRAINT FK_EMPLOYEE_TO_LEADER -- 사원 -> 부서장
		FOREIGN KEY (
			emp_id -- 사원seq
		)
		REFERENCES EMPLOYEE ( -- 사원
			emp_id -- 사원seq
		);

-- 상담일지파일테이블
ALTER TABLE CONSULTING_IMG
	ADD
		CONSTRAINT FK_Consulting_TO_IMG -- 상담일지 -> 상담일지파일테이블
		FOREIGN KEY (
			consulting_id -- 상담일지seq
		)
		REFERENCES Consulting ( -- 상담일지
			consulting_id -- 상담일지seq
		) ON DELETE CASCADE;

-- 세션
ALTER TABLE SESSION_KEY
	ADD
		CONSTRAINT FK_EMPLOYEE_TO_SESSION_KEY -- 사원 -> 세션
		FOREIGN KEY (
			emp_id -- 사원seq
		)
		REFERENCES EMPLOYEE ( -- 사원
			emp_id -- 사원seq
		);

-- 플랜
ALTER TABLE PLAN
	ADD
		CONSTRAINT FK_DAILY_PLAN_TO_PLAN -- 일정 -> 플랜
		FOREIGN KEY (
			daily_plan_id -- 일정seq
		)
		REFERENCES DAILY_PLAN ( -- 일정
			daily_plan_id -- 일정seq
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