-- ������ ���� --
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

-- ������ ���� --
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
-- �μ� ������ �Է� --
insert into dept values (seq_dept_id.nextval, '��������');
insert into dept values (seq_dept_id.nextval, '��������');
insert into dept values (seq_dept_id.nextval, '�ߺ�����');
insert into dept values (seq_dept_id.nextval, '��������');
insert into dept values (seq_dept_id.nextval, '�Ϻ�����');
insert into dept values (seq_dept_id.nextval, '������');

-- ��� ������ �Է� -- 
insert into employee values (seq_emp_id.nextval, '����', '1111', '010-1111-1111', 'elsa@gmail.com', 'Salesman', 1, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '�鼳', '1111', '010-1111-1112', 'elsa1@gmail.com', 'Salesman', 2, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '������', '1111', '010-1111-1113', 'elsa2@gmail.com', 'Salesman', 3, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '��Ǭ��', '1111', '010-1111-1114', 'elsa3@gmail.com', 'Salesman', 4, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '������', '1111', '010-1111-1115', 'elsa4@gmail.com', 'Salesman', 4, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '����', '1111', '010-1111-1116', 'elsa5@gmail.com', 'Salesman', 1, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '�Ƹ���', '1111', '010-1111-1117', 'elsa6@gmail.com', 'Salesman', 2, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '����', '1111', '010-1111-1118', 'elsa7@gmail.com', 'Salesman', 3, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '������', '1111', '010-1111-1111', 'admin@gmail.com', 'Admin', 6, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '������', '1111', '010-1111-1111', 'manager1@gmail.com', 'Manager', 1, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '������', '1111', '010-1111-1111', 'manager2@gmail.com', 'Manager', 1, 'ACTIVE', 'noname.png');
insert into employee values (seq_emp_id.nextval, '������', '1111', '010-1111-1111', 'manager3@gmail.com', 'Manager', 1, 'ACTIVE', 'noname.png');

-- �ְ���ȹ ������ �Է� --
insert into weekly_plan values (seq_weekly_plan_id.nextval, 1, sysdate, '2�� 4���� �ְ���ȹ', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 1, '2016/02/26', '2�� 5���� �ְ���ȹ', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 1, '2016/03/05', '3�� 1���� �ְ���ȹ', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 1, '2016/03/12', '3�� 2���� �ְ���ȹ', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 2, sysdate, '2�� 4���� �ְ���ȹ', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 2, '2016/02/26', '2�� 5���� �ְ���ȹ', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 2, '2016/03/05', '3�� 1���� �ְ���ȹ', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 2, '2016/03/12', '3�� 2���� �ְ���ȹ', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 3, sysdate, '2�� 4���� �ְ���ȹ', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 3, '2016/02/26', '2�� 5���� �ְ���ȹ', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 3, '2016/03/05', '3�� 1���� �ְ���ȹ', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 3, '2016/03/12', '3�� 2���� �ְ���ȹ', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 4, sysdate, '2�� 4���� �ְ���ȹ', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 4, '2016/02/26', '2�� 5���� �ְ���ȹ', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 4, '2016/03/05', '3�� 1���� �ְ���ȹ', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 4, '2016/03/12', '3�� 2���� �ְ���ȹ', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 5, sysdate, '2�� 4���� �ְ���ȹ', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 5, '2016/02/26', '2�� 5���� �ְ���ȹ', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 5, '2016/03/05', '3�� 1���� �ְ���ȹ', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 5, '2016/03/12', '3�� 2���� �ְ���ȹ', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 6, sysdate, '2�� 4���� �ְ���ȹ', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 6, '2016/02/26', '2�� 5���� �ְ���ȹ', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 6, '2016/03/05', '3�� 1���� �ְ���ȹ', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 6, '2016/03/12', '3�� 2���� �ְ���ȹ', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 7, sysdate, '2�� 4���� �ְ���ȹ', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 7, '2016/02/26', '2�� 5���� �ְ���ȹ', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 7, '2016/03/05', '3�� 1���� �ְ���ȹ', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 7, '2016/03/12', '3�� 2���� �ְ���ȹ', '2016/03/14', 0);

insert into weekly_plan values (seq_weekly_plan_id.nextval, 8, sysdate, '2�� 4���� �ְ���ȹ', '2016/02/22', 1);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 8, '2016/02/26', '2�� 5���� �ְ���ȹ', '2016/02/29', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 8, '2016/03/05', '3�� 1���� �ְ���ȹ', '2016/03/07', 0);
insert into weekly_plan values (seq_weekly_plan_id.nextval, 8, '2016/03/12', '3�� 2���� �ְ���ȹ', '2016/03/14', 0);

-- ���� ������ �Է� --
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

-- ���� 11~20
-- ������� 8~17
-- ��ȹ ������ �Է� --
insert into plan values(seq_plan_id.nextval, 1, '���۽���', 'normal');
insert into plan values(seq_plan_id.nextval, 1, '��罴��', 'normal');
insert into plan values(seq_plan_id.nextval, 1, '���ｴ��', 'normal');

insert into plan values(seq_plan_id.nextval, 2, '��罴��', 'normal');
insert into plan values(seq_plan_id.nextval, 2, '��������', 'normal');
insert into plan values(seq_plan_id.nextval, 2, '���ｴ��', 'normal');

insert into plan values(seq_plan_id.nextval, 3, '���ｴ��', 'normal');
insert into plan values(seq_plan_id.nextval, 3, '���۽���', 'normal');

insert into plan values(seq_plan_id.nextval, 11, '���۽���', 'normal');
insert into plan values(seq_plan_id.nextval, 11, '��罴��', 'normal');
insert into plan values(seq_plan_id.nextval, 11, '��������', 'normal');

insert into plan values(seq_plan_id.nextval, 12, '��罴��', 'normal');
insert into plan values(seq_plan_id.nextval, 12, '��������', 'normal');
insert into plan values(seq_plan_id.nextval, 12, '���ｴ��', 'normal');

insert into plan values(seq_plan_id.nextval, 13, '���ｴ��', '������');
insert into plan values(seq_plan_id.nextval, 13, '���۽���', '������');

--woosungchu
insert into plan values(seq_plan_id.nextval, 14, 'ȸ������', 'holiday');
insert into plan values(seq_plan_id.nextval, 15, '�������', 'notice');
insert into plan values(seq_plan_id.nextval, 15, '���ｴ��', 'normal');

insert into plan values(seq_plan_id.nextval, 20, '���ｴ��', 'normal');
insert into plan values(seq_plan_id.nextval, 20, '���۽���', 'normal');

-- ���Ϻ��� ������ �Է� --
insert into daily_report values (seq_daily_report_id.nextval, '2�� 22�� ���Ϻ���', 1, 25, 75, 1500000, '2016/02/22', '2�� 22�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '2�� 23�� ���Ϻ���', 1, 20, 55, 1700000, '2016/02/23', '2�� 23�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '2�� 24�� ���Ϻ���', 1, 35, 85, 1800000, '2016/02/24', '2�� 24�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '2�� 25�� ���Ϻ���', 1, 25, 85, 2000000, '2016/02/25', '2�� 25�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '2�� 26�� ���Ϻ���', 1, 20, 95, 2100000, '2016/02/26', '2�� 26�� ���Ϻ����Դϴ�.', null);

insert into daily_report values (seq_daily_report_id.nextval, '2�� 29�� ���Ϻ���', 1, 25, 75, 1500000, '2016/02/29', '2�� 29�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '3�� 1�� ���Ϻ���', 1, 20, 55, 1700000, '2016/03/01', '����', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '3�� 2�� ���Ϻ���', 1, 35, 85, 1800000, '2016/03/02', '3�� 2�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '3�� 3�� ���Ϻ���', 1, 25, 85, 2000000, '2016/03/03', '3�� 3�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '3�� 4�� ���Ϻ���', 1, 20, 95, 2100000, '2016/03/04', '3�� 4�� ���Ϻ����Դϴ�.', null);

insert into daily_report values (seq_daily_report_id.nextval, '2�� 22�� ���Ϻ���', 2, 25, 75, 2000000, '2016/02/22', '2�� 22�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '2�� 23�� ���Ϻ���', 2, 20, 55, 1700000, '2016/02/23', '2�� 23�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '2�� 24�� ���Ϻ���', 2, 35, 85, 1800000, '2016/02/24', '2�� 24�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '2�� 25�� ���Ϻ���', 2, 25, 85, 2000000, '2016/02/25', '2�� 25�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '2�� 26�� ���Ϻ���', 2, 20, 95, 2100000, '2016/02/26', '2�� 26�� ���Ϻ����Դϴ�.', null);

insert into daily_report values (seq_daily_report_id.nextval, '2�� 22�� ���Ϻ���', 6, 25, 75, 1500000, '2016/02/22', '2�� 22�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '2�� 23�� ���Ϻ���', 6, 20, 55, 1700000, '2016/02/23', '2�� 23�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '2�� 24�� ���Ϻ���', 6, 35, 85, 1800000, '2016/02/24', '2�� 24�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '2�� 25�� ���Ϻ���', 6, 25, 85, 2000000, '2016/02/25', '2�� 25�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '2�� 26�� ���Ϻ���', 6, 20, 95, 2100000, '2016/02/26', '2�� 26�� ���Ϻ����Դϴ�.', null);

insert into daily_report values (seq_daily_report_id.nextval, '2�� 29�� ���Ϻ���', 6, 25, 75, 1500000, '2016/02/29', '2�� 29�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '3�� 1�� ���Ϻ���', 6, 20, 55, 1700000, '2016/03/01', '����', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '3�� 2�� ���Ϻ���', 6, 35, 85, 1800000, '2016/03/02', '3�� 2�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '3�� 3�� ���Ϻ���', 6, 25, 85, 2000000, '2016/03/03', '3�� 3�� ���Ϻ����Դϴ�.', '����Ϸ�');
insert into daily_report values (seq_daily_report_id.nextval, '3�� 4�� ���Ϻ���', 6, 20, 95, 2100000, '2016/03/04', '3�� 4�� ���Ϻ����Դϴ�.', null);

-- �ŷ�ó ������ �Է� --
insert into client(client_id, client_code, CLIENT_NAME, SECOND_NAME, ADDRESS, PHONE, CEO) values (seq_client_id.nextval, '100000', '���۴븮��', '���۽���', '����� ���۱� ���۵�', '010-0000-0000', '�谩��');
insert into client(client_id, client_code, CLIENT_NAME, SECOND_NAME, ADDRESS, PHONE, CEO) values (seq_client_id.nextval, '100001', '���븮��', '��罴��', '����� ���۱� ��絿', '010-0000-0001', '�̰���');
insert into client(client_id, client_code, CLIENT_NAME, SECOND_NAME, ADDRESS, PHONE, CEO) values (seq_client_id.nextval, '100002', '�����븮��', '��������', '����� ���ʱ� ���ʵ�', '010-0000-0002', '�ְ���');
insert into client(client_id, client_code, CLIENT_NAME, SECOND_NAME, ADDRESS, PHONE, CEO) values (seq_client_id.nextval, '100003', '����븮��', '���ｴ��', '����� ������ ���ﵿ', '010-0000-0003', '�ڰ���');

-- ������� ������ �Է� --
insert into consulting values (seq_consulting_id.nextval, '2�� 22�� �������(1)', '2016/02/22', '2�� 22�� �������(1)', 1, 1);
insert into consulting values (seq_consulting_id.nextval, '2�� 22�� �������(2)', '2016/02/22', '2�� 22�� �������(2)', 2, 1);
insert into consulting values (seq_consulting_id.nextval, '2�� 22�� �������(3)', '2016/02/22', '2�� 22�� �������(3)', 3, 1);

insert into consulting values (seq_consulting_id.nextval, '2�� 23�� �������(1)', '2016/02/23', '2�� 23�� �������(1)', 2, 2);
insert into consulting values (seq_consulting_id.nextval, '2�� 23�� �������(2)', '2016/02/23', '2�� 23�� �������(2)', 3, 2);
insert into consulting values (seq_consulting_id.nextval, '2�� 23�� �������(3)', '2016/02/23', '2�� 23�� �������(3)', 4, 2);

insert into consulting values (seq_consulting_id.nextval, '2�� 24�� �������(1)', '2016/02/24', '2�� 24�� �������(1)', 4, 3);
insert into consulting values (seq_consulting_id.nextval, '2�� 24�� �������(2)', '2016/02/24', '2�� 24�� �������(2)', 1, 3);
--
insert into consulting values (seq_consulting_id.nextval, '2�� 22�� �������(1)', '2016/02/22', '2�� 22�� �������(1)', 1, 6);
insert into consulting values (seq_consulting_id.nextval, '2�� 22�� �������(2)', '2016/02/22', '2�� 22�� �������(2)', 2, 6);
insert into consulting values (seq_consulting_id.nextval, '2�� 22�� �������(3)', '2016/02/22', '2�� 22�� �������(3)', 3, 6);

insert into consulting values (seq_consulting_id.nextval, '2�� 23�� �������(1)', '2016/02/23', '2�� 23�� �������(1)', 2, 7);
insert into consulting values (seq_consulting_id.nextval, '2�� 23�� �������(2)', '2016/02/23', '2�� 23�� �������(2)', 3, 7);
insert into consulting values (seq_consulting_id.nextval, '2�� 23�� �������(3)', '2016/02/23', '2�� 23�� �������(3)', 4, 7);

insert into consulting values (seq_consulting_id.nextval, '2�� 24�� �������(1)', '2016/02/24', '2�� 24�� �������(1)', 4, 8);
insert into consulting values (seq_consulting_id.nextval, '2�� 24�� �������(2)', '2016/02/24', '2�� 24�� �������(2)', 1, 8);

insert into consulting values (seq_consulting_id.nextval, '3�� 4�� �������(1)', '2016/03/04', '3�� 4�� �������(1)', 4, 10);
insert into consulting values (seq_consulting_id.nextval, '3�� 4�� �������(2)', '2016/03/04', '3�� 4�� �������(2)', 1, 10);

-- ������� ���� ������ �Է� --
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

--������ȣ ���̺� �� �Է�
insert into validation values(seq_valid_id.nextval, 1 , 12345 , sysdate);
insert into validation values(seq_valid_id.nextval, 2 , 14234 , sysdate);
--�޼���
insert into MESSAGE VALUES(seq_msg_id.nextval, 1, 2 , '�޼���1!', 0, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 1, 3 , '�޼���2!', 0, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 2, 3 , '�޼���3!', 0, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 2, 1 , '�޼���4!', 0, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 3, 4 , '�޼���1!', 0, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 3, 5 , '�޼���2!', 1, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 3, 6 , '�޼���3!', 0, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 3, 7 , '�޼���4!', 1, sysdate);
insert into MESSAGE VALUES(seq_msg_id.nextval, 5, 6 , '�޼���!', 0, sysdate);
--����Ű
insert INTO SESSION_KEY VALUES (seq_session_Key_id.nextVal, 'C2A985D701FC416937A0B54A7B9FBF64', 1 , '192.168.1.14',sysdate+1,'24-F5-AA-E2-2F-66');
insert INTO SESSION_KEY VALUES (seq_session_Key_id.nextVal, 'C2A985D701A7B9FBF64', 1 , '0:0:0:0:0:0:0:1',sysdate + 1,'24-F5-AA-E2-2F-66');
--�μ��� ���̺�
insert into leader values(seq_leader_id.nextVal, 1 , 1);
insert into leader values(seq_leader_id.nextVal, 2 , 2);
insert into leader values(seq_leader_id.nextVal, 3 , 3);
insert into leader values(seq_leader_id.nextVal, 4 , 4);

--Hashing
update employee e
      set e.password = '6818fbcd9ed7619e30d9bdc58e21dbb8e36905b7abc51ac874636fcf002ce5e3'
      where password = '1111';


commit;