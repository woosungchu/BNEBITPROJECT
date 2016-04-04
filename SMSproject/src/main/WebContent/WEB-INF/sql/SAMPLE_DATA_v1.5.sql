-- 시퀀스 삭제 --
drop sequence seq_dept_id;
drop sequence seq_emp_id;
drop sequence seq_valid_id;
drop sequence seq_msg_id;
drop sequence seq_session_key_id;
drop sequence seq_leader_id;
drop sequence seq_weekly_plan_id;
drop sequence seq_client_id;
drop sequence seq_daily_plan_id;
drop sequence seq_plan_id;
drop sequence seq_daily_report_id;
drop sequence seq_consulting_id;
drop sequence seq_consulting_img_id;
drop sequence seq_event_id;

-- 시퀀스 생성 --
create sequence seq_dept_id start with 1 increment by 1 maxvalue 999999 cycle ;
create sequence seq_emp_id start with 1 increment by 1 maxvalue 999999 cycle ;
create sequence seq_valid_id start with 1 increment by 1 maxvalue 999999 cycle ;
create sequence seq_msg_id start with 1 increment by 1 maxvalue 999999 cycle ;
create sequence seq_session_key_id start with 1 increment by 1 maxvalue 999999 cycle ;
create sequence seq_leader_id start with 1 increment by 1 maxvalue 999999 cycle ;
create sequence seq_weekly_plan_id start with 1 increment by 1 maxvalue 999999 cycle ;
create sequence seq_client_id start with 1 increment by 1 maxvalue 999999 cycle ;
create sequence seq_daily_plan_id start with 1 increment by 1 maxvalue 999999 cycle ;
create sequence seq_plan_id start with 1 increment by 1 maxvalue 999999 cycle ;
create sequence seq_daily_report_id start with 1 increment by 1 maxvalue 999999 cycle ;
create sequence seq_consulting_id start with 1 increment by 1 maxvalue 999999 cycle ;
create sequence seq_consulting_img_id start with 1 increment by 1 maxvalue 999999 cycle ;
create sequence seq_event_id start with 1 increment by 1 maxvalue 999999 cycle ;


delete from consulting_img;
delete from consulting;
delete from daily_report;
delete from plan;
delete from daily_plan;
delete from client;
delete from weekly_plan;
delete from leader;
delete from session_key;
delete from message;
delete from validation;
delete from employee;
delete from dept;
commit;
-- 부서 데이터 입력 --
insert into dept values (seq_dept_id.nextval, '동부지점');
insert into dept values (seq_dept_id.nextval, '서부지점');
insert into dept values (seq_dept_id.nextval, '중부지점');
insert into dept values (seq_dept_id.nextval, '남부지점');
insert into dept values (seq_dept_id.nextval, '북부지점');
insert into dept values (seq_dept_id.nextval, '관리자');

-- 사원 데이터 입력 -- 
insert into employee values (seq_emp_id.nextval, '엘사', '1111', '010-1111-1111', 'elsa@gmail.com', 'Salesman', 1, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '백설', '1111', '010-1111-1112', 'elsa1@gmail.com', 'Salesman', 2, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '데렐라', '1111', '010-1111-1113', 'elsa2@gmail.com', 'Salesman', 3, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '라푼젤', '1111', '010-1111-1114', 'elsa3@gmail.com', 'Salesman', 4, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '오데뜨', '1111', '010-1111-1115', 'elsa4@gmail.com', 'Salesman', 4, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '엄지', '1111', '010-1111-1116', 'elsa5@gmail.com', 'Salesman', 1, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '아리엘', '1111', '010-1111-1117', 'elsa6@gmail.com', 'Salesman', 2, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '차차', '1111', '010-1111-1118', 'elsa7@gmail.com', 'Salesman', 3, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '관리자', '1111', '010-1111-1111', 'admin@gmail.com', 'Admin', 6, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '김팀장', '1111', '010-1111-1111', 'manager1@gmail.com', 'Manager', 1, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '이팀장', '1111', '010-1111-1111', 'manager2@gmail.com', 'Manager', 1, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '유팀장', '1111', '010-1111-1111', 'manager3@gmail.com', 'Manager', 1, 'ACTIVE', 'noname.png');

-- 주간계획 데이터 입력 --
insert into weekly_plan values (seq_weekly_plan_id.nextval, 1, sysdate, '2월 4주차 주간계획', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 1, '2016/02/26', '2월 5주차 주간계획', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 1, '2016/03/05', '3월 1주차 주간계획', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 1, '2016/03/12', '3월 2주차 주간계획', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 2, sysdate, '2월 4주차 주간계획', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 2, '2016/02/26', '2월 5주차 주간계획', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 2, '2016/03/05', '3월 1주차 주간계획', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 2, '2016/03/12', '3월 2주차 주간계획', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 3, sysdate, '2월 4주차 주간계획', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 3, '2016/02/26', '2월 5주차 주간계획', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 3, '2016/03/05', '3월 1주차 주간계획', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 3, '2016/03/12', '3월 2주차 주간계획', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 4, sysdate, '2월 4주차 주간계획', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 4, '2016/02/26', '2월 5주차 주간계획', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 4, '2016/03/05', '3월 1주차 주간계획', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 4, '2016/03/12', '3월 2주차 주간계획', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 5, sysdate, '2월 4주차 주간계획', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 5, '2016/02/26', '2월 5주차 주간계획', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 5, '2016/03/05', '3월 1주차 주간계획', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 5, '2016/03/12', '3월 2주차 주간계획', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 6, sysdate, '2월 4주차 주간계획', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 6, '2016/02/26', '2월 5주차 주간계획', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 6, '2016/03/05', '3월 1주차 주간계획', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 6, '2016/03/12', '3월 2주차 주간계획', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 7, sysdate, '2월 4주차 주간계획', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 7, '2016/02/26', '2월 5주차 주간계획', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 7, '2016/03/05', '3월 1주차 주간계획', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 7, '2016/03/12', '3월 2주차 주간계획', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 8, sysdate, '2월 4주차 주간계획', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 8, '2016/02/26', '2월 5주차 주간계획', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 8, '2016/03/05', '3월 1주차 주간계획', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 8, '2016/03/12', '3월 2주차 주간계획', '2016/03/14', 0);

-- 일정 데이터 입력 --
insert into daily_plan values (seq_daily_plan_id.nextval, 1, '2016/02/22', 2000000);
insert into daily_plan values (seq_daily_plan_id.nextval, 1, '2016/02/23', 2400000);
insert into daily_plan values (seq_daily_plan_id.nextval, 1, '2016/02/24', 1800000);
insert into daily_plan values (seq_daily_plan_id.nextval, 1, '2016/02/25', 2000000);
insert into daily_plan values (seq_daily_plan_id.nextval, 1, '2016/02/26', 2500000);

insert into daily_plan values (seq_daily_plan_id.nextval, 2, '2016/02/29', 2100000);
insert into daily_plan values (seq_daily_plan_id.nextval, 2, '2016/03/01', 1200000);
insert into daily_plan values (seq_daily_plan_id.nextval, 2, '2016/03/02', 1700000);
insert into daily_plan values (seq_daily_plan_id.nextval, 2, '2016/03/03', 2300000);
insert into daily_plan values (seq_daily_plan_id.nextval, 2, '2016/03/04', 1800000);

insert into daily_plan values (seq_daily_plan_id.nextval, 5, '2016/02/22', 2000000);--
insert into daily_plan values (seq_daily_plan_id.nextval, 5, '2016/02/23', 2400000);--
insert into daily_plan values (seq_daily_plan_id.nextval, 5, '2016/02/24', 1800000);--
insert into daily_plan values (seq_daily_plan_id.nextval, 5, '2016/02/25', 2000000);
insert into daily_plan values (seq_daily_plan_id.nextval, 5, '2016/02/26', 2500000);

insert into daily_plan values (seq_daily_plan_id.nextval, 6, '2016/02/29', 2100000);
insert into daily_plan values (seq_daily_plan_id.nextval, 6, '2016/03/01', 3400000);
insert into daily_plan values (seq_daily_plan_id.nextval, 6, '2016/03/02', 1700000);
insert into daily_plan values (seq_daily_plan_id.nextval, 6, '2016/03/03', 2300000);
insert into daily_plan values (seq_daily_plan_id.nextval, 6, '2016/03/04', 1800000);--

insert into daily_plan values (seq_daily_plan_id.nextval, 21, '2016/02/22', 2100000);
insert into daily_plan values (seq_daily_plan_id.nextval, 21, '2016/02/23', 2200000);
insert into daily_plan values (seq_daily_plan_id.nextval, 21, '2016/02/24', 1700000);
insert into daily_plan values (seq_daily_plan_id.nextval, 21, '2016/02/25', 2600000);
insert into daily_plan values (seq_daily_plan_id.nextval, 21, '2016/02/26', 2200000);

insert into daily_plan values (seq_daily_plan_id.nextval, 22, '2016/02/29', 2000000);
insert into daily_plan values (seq_daily_plan_id.nextval, 22, '2016/03/01', 2300000);
insert into daily_plan values (seq_daily_plan_id.nextval, 22, '2016/03/02', 1500000);
insert into daily_plan values (seq_daily_plan_id.nextval, 22, '2016/03/03', 1600000);
insert into daily_plan values (seq_daily_plan_id.nextval, 22, '2016/03/04', 1800000);

-- 일정 11~20
-- 상담일지 8~17
-- 계획 데이터 입력 --
insert into plan values(seq_plan_id.nextval, 1, '동작슈퍼', 'normal');
insert into plan values(seq_plan_id.nextval, 1, '사당슈퍼', 'normal');
insert into plan values(seq_plan_id.nextval, 1, '역삼슈퍼', 'normal');

insert into plan values(seq_plan_id.nextval, 2, '사당슈퍼', 'normal');
insert into plan values(seq_plan_id.nextval, 2, '강남슈퍼', 'normal');
insert into plan values(seq_plan_id.nextval, 2, '역삼슈퍼', 'normal');

insert into plan values(seq_plan_id.nextval, 3, '역삼슈퍼', 'normal');
insert into plan values(seq_plan_id.nextval, 3, '동작슈퍼', 'normal');

insert into plan values(seq_plan_id.nextval, 11, '동작슈퍼', 'normal');
insert into plan values(seq_plan_id.nextval, 11, '사당슈퍼', 'normal');
insert into plan values(seq_plan_id.nextval, 11, '강남슈퍼', 'normal');

insert into plan values(seq_plan_id.nextval, 12, '사당슈퍼', 'normal');
insert into plan values(seq_plan_id.nextval, 12, '강남슈퍼', 'normal');
insert into plan values(seq_plan_id.nextval, 12, '역삼슈퍼', 'normal');

insert into plan values(seq_plan_id.nextval, 13, '역삼슈퍼', '업무일');
insert into plan values(seq_plan_id.nextval, 13, '동작슈퍼', '업무일');

--woosungchu
insert into plan values(seq_plan_id.nextval, 14, '회사휴일', 'holiday');
insert into plan values(seq_plan_id.nextval, 15, '본사소집', 'notice');
insert into plan values(seq_plan_id.nextval, 15, '역삼슈퍼', 'normal');

insert into plan values(seq_plan_id.nextval, 20, '역삼슈퍼', 'normal');
insert into plan values(seq_plan_id.nextval, 20, '동작슈퍼', 'normal');

-- 일일보고 데이터 입력 --
insert into daily_report values (seq_daily_report_id.nextval, '2월 22일 일일보고', 1, 25, 75, 1500000, '2016/02/22', '2월 22일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '2월 23일 일일보고', 1, 20, 55, 1700000, '2016/02/23', '2월 23일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '2월 24일 일일보고', 1, 35, 85, 1800000, '2016/02/24', '2월 24일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '2월 25일 일일보고', 1, 25, 85, 2000000, '2016/02/25', '2월 25일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '2월 26일 일일보고', 1, 20, 95, 2100000, '2016/02/26', '2월 26일 일일보고입니다.', null);

insert into daily_report values (seq_daily_report_id.nextval, '2월 29일 일일보고', 1, 25, 75, 1500000, '2016/02/29', '2월 29일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '3월 1일 일일보고', 1, 20, 55, 1700000, '2016/03/01', '휴일', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '3월 2일 일일보고', 1, 35, 85, 1800000, '2016/03/02', '3월 2일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '3월 3일 일일보고', 1, 25, 85, 2000000, '2016/03/03', '3월 3일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '3월 4일 일일보고', 1, 20, 95, 2100000, '2016/03/04', '3월 4일 일일보고입니다.', null);

insert into daily_report values (seq_daily_report_id.nextval, '2월 22일 일일보고', 2, 25, 75, 2000000, '2016/02/22', '2월 22일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '2월 23일 일일보고', 2, 20, 55, 1700000, '2016/02/23', '2월 23일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '2월 24일 일일보고', 2, 35, 85, 1800000, '2016/02/24', '2월 24일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '2월 25일 일일보고', 2, 25, 85, 2000000, '2016/02/25', '2월 25일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '2월 26일 일일보고', 2, 20, 95, 2100000, '2016/02/26', '2월 26일 일일보고입니다.', null);

insert into daily_report values (seq_daily_report_id.nextval, '2월 22일 일일보고', 6, 25, 75, 1500000, '2016/02/22', '2월 22일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '2월 23일 일일보고', 6, 20, 55, 1700000, '2016/02/23', '2월 23일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '2월 24일 일일보고', 6, 35, 85, 1800000, '2016/02/24', '2월 24일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '2월 25일 일일보고', 6, 25, 85, 2000000, '2016/02/25', '2월 25일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '2월 26일 일일보고', 6, 20, 95, 2100000, '2016/02/26', '2월 26일 일일보고입니다.', null);

insert into daily_report values (seq_daily_report_id.nextval, '2월 29일 일일보고', 6, 25, 75, 1500000, '2016/02/29', '2월 29일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '3월 1일 일일보고', 6, 20, 55, 1700000, '2016/03/01', '휴일', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '3월 2일 일일보고', 6, 35, 85, 1800000, '2016/03/02', '3월 2일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '3월 3일 일일보고', 6, 25, 85, 2000000, '2016/03/03', '3월 3일 일일보고입니다.', '결재완료');
insert into daily_report values (seq_daily_report_id.nextval, '3월 4일 일일보고', 6, 20, 95, 2100000, '2016/03/04', '3월 4일 일일보고입니다.', null);

-- 거래처 데이터 입력 --
insert into client(client_id, client_code, CLIENT_NAME, SECOND_NAME, ADDRESS, PHONE, CEO) values (seq_client_id.nextval, '100000', '동작대리점', '동작슈퍼', '서울시 동작구 동작동', '010-0000-0000', '김갑부');
insert into client(client_id, client_code, CLIENT_NAME, SECOND_NAME, ADDRESS, PHONE, CEO) values (seq_client_id.nextval, '100001', '사당대리점', '사당슈퍼', '서울시 동작구 사당동', '010-0000-0001', '이갑부');
insert into client(client_id, client_code, CLIENT_NAME, SECOND_NAME, ADDRESS, PHONE, CEO) values (seq_client_id.nextval, '100002', '강남대리점', '강남슈퍼', '서울시 서초구 서초동', '010-0000-0002', '최갑부');
insert into client(client_id, client_code, CLIENT_NAME, SECOND_NAME, ADDRESS, PHONE, CEO) values (seq_client_id.nextval, '100003', '역삼대리점', '역삼슈퍼', '서울시 강남구 역삼동', '010-0000-0003', '박갑부');

-- 상담일지 데이터 입력 --
insert into consulting values (seq_consulting_id.nextval, '2월 22일 상담일지(1)', '2016/02/22', '2월 22일 상담일지(1)', 1, 1);
insert into consulting values (seq_consulting_id.nextval, '2월 22일 상담일지(2)', '2016/02/22', '2월 22일 상담일지(2)', 2, 1);
insert into consulting values (seq_consulting_id.nextval, '2월 22일 상담일지(3)', '2016/02/22', '2월 22일 상담일지(3)', 3, 1);

insert into consulting values (seq_consulting_id.nextval, '2월 23일 상담일지(1)', '2016/02/23', '2월 23일 상담일지(1)', 2, 2);
insert into consulting values (seq_consulting_id.nextval, '2월 23일 상담일지(2)', '2016/02/23', '2월 23일 상담일지(2)', 3, 2);
insert into consulting values (seq_consulting_id.nextval, '2월 23일 상담일지(3)', '2016/02/23', '2월 23일 상담일지(3)', 4, 2);

insert into consulting values (seq_consulting_id.nextval, '2월 24일 상담일지(1)', '2016/02/24', '2월 24일 상담일지(1)', 4, 3);
insert into consulting values (seq_consulting_id.nextval, '2월 24일 상담일지(2)', '2016/02/24', '2월 24일 상담일지(2)', 1, 3);
--
insert into consulting values (seq_consulting_id.nextval, '2월 22일 상담일지(1)', '2016/02/22', '2월 22일 상담일지(1)', 1, 6);
insert into consulting values (seq_consulting_id.nextval, '2월 22일 상담일지(2)', '2016/02/22', '2월 22일 상담일지(2)', 2, 6);
insert into consulting values (seq_consulting_id.nextval, '2월 22일 상담일지(3)', '2016/02/22', '2월 22일 상담일지(3)', 3, 6);

insert into consulting values (seq_consulting_id.nextval, '2월 23일 상담일지(1)', '2016/02/23', '2월 23일 상담일지(1)', 2, 7);
insert into consulting values (seq_consulting_id.nextval, '2월 23일 상담일지(2)', '2016/02/23', '2월 23일 상담일지(2)', 3, 7);
insert into consulting values (seq_consulting_id.nextval, '2월 23일 상담일지(3)', '2016/02/23', '2월 23일 상담일지(3)', 4, 7);

insert into consulting values (seq_consulting_id.nextval, '2월 24일 상담일지(1)', '2016/02/24', '2월 24일 상담일지(1)', 4, 8);
insert into consulting values (seq_consulting_id.nextval, '2월 24일 상담일지(2)', '2016/02/24', '2월 24일 상담일지(2)', 1, 8);

insert into consulting values (seq_consulting_id.nextval, '3월 4일 상담일지(1)', '2016/03/04', '3월 4일 상담일지(1)', 4, 10);
insert into consulting values (seq_consulting_id.nextval, '3월 4일 상담일지(2)', '2016/03/04', '3월 4일 상담일지(2)', 1, 10);

-- 상담일지 파일 데이터 입력 --
insert into consulting_img values (seq_consulting_img_id.nextval, 2, '2.jpg', '2.jpg');
insert into consulting_img values (seq_consulting_img_id.nextval, 3, '3.jpg', '3.jpg');
insert into consulting_img values (seq_consulting_img_id.nextval, 4, '1.jpg', '1.jpg');
insert into consulting_img values (seq_consulting_img_id.nextval, 5, '2.jpg', '2.jpg');
insert into consulting_img values (seq_consulting_img_id.nextval, 7, '1.jpg', '1.jpg');

insert into consulting_img values (seq_consulting_img_id.nextval, 9, '1.jpg', '1.jpg');
insert into consulting_img values (seq_consulting_img_id.nextval, 11, '2.jpg', '2.jpg');
insert into consulting_img values (seq_consulting_img_id.nextval, 12, '3.jpg', '3.jpg');
insert into consulting_img values (seq_consulting_img_id.nextval, 13, '1.jpg', '1.jpg');
insert into consulting_img values (seq_consulting_img_id.nextval, 15, '2.jpg', '2.jpg');

--인증번호 테이블 값 입력
insert into validation values(seq_valid_id.nextval, 1 , 12345 , sysdate);
insert into validation values(seq_valid_id.nextval, 2 , 14234 , sysdate);
--메세지
insert into MESSAGE VALUES(seq_msg_id.nextval, 1, 2 , '메세지1!', 0, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 1, 3 , '메세지2!', 0, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 2, 3 , '메세지3!', 0, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 2, 1 , '메세지4!', 0, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 3, 4 , '메세지1!', 0, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 3, 5 , '메세지2!', 1, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 3, 6 , '메세지3!', 0, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 3, 7 , '메세지4!', 1, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 5, 6 , '메세지!', 0, sysdate);
--세션키
insert INTO SESSION_KEY VALUES (seq_session_Key_id.nextVal, 'C2A985D701FC416937A0B54A7B9FBF64', 1 , '192.168.1.14',sysdate+1,'24-F5-AA-E2-2F-66');
insert INTO SESSION_KEY VALUES (seq_session_Key_id.nextVal, 'C2A985D701A7B9FBF64', 1 , '0:0:0:0:0:0:0:1',sysdate + 1,'24-F5-AA-E2-2F-66');
--부서장 테이블
insert into leader values(seq_leader_id.nextVal, 1 , 1);
insert into leader values(seq_leader_id.nextVal, 2 , 2);
insert into leader values(seq_leader_id.nextVal, 3 , 3);
insert into leader values(seq_leader_id.nextVal, 4 , 4);

--Hashing
update employee e
      set e.password = '6818fbcd9ed7619e30d9bdc58e21dbb8e36905b7abc51ac874636fcf002ce5e3'
      where password = '1111';


commit;