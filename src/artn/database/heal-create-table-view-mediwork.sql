/* 건강검진 테이블 - 2013.12.21 by jhson [시작] */

create table if not exists heal_medi_check_field (
id 				int not null auto_increment,
field_name 		char(10) not null default '',
field_type		tinyint not null default 0,
field_label		varchar(100) not null default '',
field_unit		char(10) not null default '',
field_relation	char(10) not null default '',
date_upload		datetime not null,
date_update		datetime not null,

primary key (id)
);

create table if not exists heal_medi_check_conf (
id					int not null auto_increment,
id_medi				int not null default 0,
id_medi_check_field	int not null default 0,
medi_name			char(50) not null default 0,
position_group		tinyint not null default 0,
position_seq		tinyint not null default 0,
date_upload			datetime not null,
date_update			datetime not null,

primary key (id)
);

create index heal_medi_check_conf_index1
on heal_medi_check_conf (id_medi);

create index heal_medi_check_conf_index2
on heal_medi_check_conf (id_medi, id_medi_check_field);

create table if not exists heal_medi_check_data (
id					int not null auto_increment,
id_complete			int,
id_pres				int,
id_medi				int not null default 0,
id_medi_check_field	int not null default 0,
id_user				varchar(16) not null default '',
id_writer			varchar(16) not null default '',
id_writer_last		varchar(16) not null default '',
medi_name			varchar(50) not null default '',
user_name			varchar(50) not null default '',
writer_name			varchar(50) not null default '',
writer_last_name	varchar(50) not null default '',
field_name			char(10) not null default '',
field_value			float not null default 0,
field_result		char(10) not null default '',
field_type			tinyint not null default 0,
field_unit			char(10) not null default '',
position_group		tinyint not null default 0,
position_seq		tinyint not null default 0,
date_upload			datetime not null,
date_update			datetime not null,
date_complete		datetime,

primary key (id)
);

create index heal_medi_check_data_index1
on heal_medi_check_data (id_complete);

create index heal_medi_check_data_index2
on heal_medi_check_data (id_medi);

create index heal_medi_check_data_index3
on heal_medi_check_data (id_user);

create index heal_medi_check_data_index4
on heal_medi_check_data (user_name);


create table if not exists heal_medi_check_complete (
id_complete			int not null auto_increment,
id_medi				int not null default 0,
id_user				varchar(16) not null default '',
id_writer             varchar(16) not null default '',
medi_name			varchar(50) not null default '',
user_name			varchar(50) not null default '',
writer_name         varchar(50) not null default '',
date_complete		datetime not null,
field1_value		float,
field1_result		char(10),
field2_value		float,
field2_result		char(10),
field3_value		float,
field3_result		char(10),
field4_value		float,
field4_result		char(10),
field5_value		float,
field5_result		char(10),
field6_value		float,
field6_result		char(10),
field7_value		float,
field7_result		char(10),
field8_value		float,
field8_result		char(10),
field9_value		float,
field9_result		char(10),
field10_value        float,
field10_result       char(10),
field11_value        float,
field11_result       char(10),
field12_value        float,
field12_result       char(10),
field13_value        float,
field13_result       char(10),
field14_value        float,
field14_result       char(10),
primary key (id_complete)
);

create index heal_medi_check_complete_index1
on heal_medi_check_complete (id_medi);

create index heal_medi_check_complete_index2
on heal_medi_check_complete (id_user);


create table if not exists heal_medi_check_complete_conf (
id_medi			int not null default 0,
seq				tinyint not null default 1,
field_id		int not null default 0,
field_name		char(10) not null default '',
field_unit		char(10) not null default '',
field_column	char(15) not null default '',
use_type		tinyint not null default 0,
date_upload		datetime not null,

primary key (id_medi, seq)
);
/* 건강검진 테이블 - 2013.12.21 by jhson [종료] */