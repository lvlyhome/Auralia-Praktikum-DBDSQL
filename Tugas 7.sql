create database akademik2;
use akademik2;

create table fakultas(
	id_fakultas smallint not null primary key,
	fakultas varchar(45)
);
create table jurusan(
	id_jurusan smallint not null primary key,
	id_fakultas smallint,
	jurusan varchar(45),
	foreign key(id_fakultas) references fakultas(id_fakultas)
);
create table strata(
	id_strata smallint not null primary key,
	singkat varchar(10),
	strata varchar(45)
);
create table program_studi(
	id_program_studi smallint not null primary key,
	id_strata smallint,
	id_jurusan smallint,
	program_studi varchar(60),
	foreign key(id_strata) references strata(id_strata),
	foreign key(id_jurusan) references jurusan(id_jurusan)
);
create table seleksi_masuk(
	id_seleksi_masuk smallint not null primary key,
	singkat varchar(12),
	seleksi_masuk varchar(45)
);
create table mahasiswa(
	NIM varchar(15) not null primary key,
	id_seleksi_masuk smallint,
	id_program_studi smallint,
	nama varchar(45),
	angkatan smallint,
	tgl_lahir date,
	kota_lahir varchar(60),
	jenis_kelamin char(1),
	foreign key(id_seleksi_masuk) references seleksi_masuk(id_seleksi_masuk),
	foreign key(id_program_studi) references program_studi(id_program_studi)	
);
create view LATIHAN_1 as
select concat(NIM, id_seleksi_masuk, id_program_studi) as NIM_GABUNGAN, 
		nama as NAMA,
		year (curdate())-year (tgl_lahir) as UMUR
from mahasiswa;
create view LATIHAN_2 as
select 
	id_program_studi as ID_PROGRAM_STUDI,
	angkatan as ANGKATAN,
	count(NIM) as JUMLAH_MAHASISWA
from mahasiswa
group by id_program_studi, angkatan;
select 
	coalesce(ps.program_studi, 'Null') as Program_Studi,
	j.jurusan as Jurusan 
from jurusan j 
	left join program_studi ps on j.id_jurusan = ps.id_jurusan;
select 
	m.NIM,
	m.nama,
	m.angkatan,
	ps.program_studi,
	sm.seleksi_masuk
from mahasiswa m 
join program_studi ps on m.id_program_studi = ps.id_program_studi 
join seleksi_masuk sm on m.id_seleksi_masuk = sm.id_seleksi_masuk;
insert into fakultas(id_fakultas, fakultas) values
	(1, 'Ekonomi & Bisnis'),
	(2, 'Ilmu Komputer');
insert into jurusan(id_jurusan, id_fakultas, jurusan) values
	(21, 2, 'Informatika'),
	(22, 2, 'Sistem Informasi'),
	(23, 2, 'Teknik Komputer');

insert into strata(id_strata, singkat, strata) values
	(1, 'D1', 'Diploma'),
	(2, 'S1', 'Sarjana'),
	(3, 'S2', 'Magister');
insert into program_studi(id_program_studi, id_strata, id_jurusan, program_studi) values
	(211, 2, 21, 'Teknik Informatika'),
	(212, 2, 21, 'Teknik Komputer'),
	(219, 3, 21, 'Magister Ilmu Komputer');
insert into seleksi_masuk (id_seleksi_masuk, singkat, seleksi_masuk) values
	(1, 'SNMPTN', 'SELEKSI NASIONAL MAHASISWA PTN'),
	(2, 'SBMPTN', 'SELEKSI BERSAMA MAHASISWA PTN');
insert into mahasiswa(NIM, id_seleksi_masuk, id_program_studi, nama, angkatan, tgl_lahir, kota_lahir, jenis_kelamin) values
	('155150400', 1, 211, 'JONI', 2015, '1997-1-1', 'Malang','L'),
	('155150401', 2, 212, 'JONO', 2015, '1997-10-2', 'Situbondo', 'P');
insert into mahasiswa values
	('155150402', 2, 211, 'JOKO', 2015, '1998-2-10', 'SURABAYA', 'M'),
	('155150403', 2, 211, 'JUJUN', 2015, '1997-9-27', 'BANYUWANGI', 'M');
show tables;
select*from latihan_1;
use akademik;