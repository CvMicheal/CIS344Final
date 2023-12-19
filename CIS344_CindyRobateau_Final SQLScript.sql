create database hospital_portal;
use hospital_portal;

create table doctors (
	id int not null unique auto_increment primary key,
    patient_id int not null,
    doctor_firstname varchar(25) not null,
    doctor_lastname varchar(25) not null,
    foreign key (patient_id) references patients (patient_id)

);
create table patients (
	patient_id int not null unique auto_increment primary key,
    patient_name varchar(45) not null,
    age int not null,
    admission_date date,
    discharge_date date

);
create table Appointments (
	appointment_id int not null unique auto_increment primary key,
    patient_id int not null,
    doctor_id int not null,
    appointment_date date not null,
    appointment_time decimal not null,
    foreign key (patient_id) references patients (patient_id),
    foreign key (doctor_id) references doctors(id)    

);

insert into patients (patient_name, age, admission_date, discharge_date)
	values
		("Maria Jozef", 67,"20231001","20231007"),
        ("John Doe", 27, "20231002","20231008"),
        ("Jane Doe", 37, "20231003","20231009"),
        ("Adam Anderson", 47, "20231005","20231012");
        
select * from patients;

delimiter //
create procedure addpatient
	(	in patient_name varchar (45),
		age int,
        admission_date date,
        discharge_date date
	)
	begin
		insert into patients (patient_name, age, admission_date, discharge_date)
        values (patient_name, age, admission_date, discharge_date);
	end //
delimiter ;
call addpatient ('der',187, 20231120,20231126);

delimiter //
create procedure scheduleAppointment
	(	in patient_id int,
		doctor_id int,
		appointment_date date,
        appointment_time decimal
	)
	begin
		insert into appointments (patient_id, doctor_id, appointment_date, appointment_time)
        values (patient_id, doctor_id, appointment_date, appointment_time);
	end //
delimiter ;
call scheduleAppointment (21,2, 20231120,930);

create procedure viewAppointments()
		select * from appointments;
call viewAppointments;

create procedure dischargePatient()
		select * from patients where discharge_date < now();
select * from patients;
call dischargePatient();


insert into doctors (patient_id, doctor_firstname, doctor_lastname)
	values
		(1, "Michel", "Anders"),
        (2, "Joyce", "Ming"),
        (3, "Janice", "Hellman"),
        (23, "Chris", "Charles"),
        (21, "Sid", "TheScienceKid");
select * from doctors;

create view joinedTables
as
select * from doctors
 join (appointments JOIN patients USING(patient_id)) USING(id);

