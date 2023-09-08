USE FUH_COMPANY
--Phan 3: Truy van am co tong hop
-- Ham tong hop (count,min,max,avg,sum)
-- dan nhap: LIET KE TAT CA NHAN VIEN
select * 
from tblEmployee

-- 1. Dem so luong nhan vien
use FUH_COMPANY
select count(*)
from tblEmployee
-- 2. Dem tren so luong ma nhan vien
select count(empSSN)
from tblEmployee
-- 52. Hay cho biet co bao nhieu nhan vien luong > 30000
select count(empSSN)
from tblEmployee
where empSalary>30000
-- 53. Hay cho biet co bao nhieu ma nhan vien quan ly nhan vien khac
select count(empSSN)
from tblEmployee
where empSSN in (
select supervisorSSN 
from tblEmployee)
-- hoac la
select count(distinct supervisorSSN)
from tblEmployee
where supervisorSSN is not null
-- 54. tim luong nho nhat
select empName, empSalary
from tblEmployee
where empSalary = (select min(empsalary) from tblEmployee)
-- 55. hay in ra bang tong hop bao gom so luong nhan vien, luong nho nhat, luong lon nhat, luong trung , tong luong
select count(empSSN) as 'So luong',
min(emp.empSalary) as 'Luong nho nhat',
max(emp.empSalary) as 'Luong lon nhat',
avg(emp.empSalary) as 'Luong trung binh',
sum(emp.empSalary) as 'Tong luong'
from tblEmployee emp
-- 56. Hay cho biet co bao nhieu gioi tinh cua nhan vien trong cong ty
select count( distinct empSex)
from tblEmployee
-- 57. Hay tim luong lon nhat
select max(empSalary) as 'Luong lon nhat'
from tblEmployee
-- 58. Hay tinh luong binh quan cua cac nhan vien
select avg(empSalary)
from tblEmployee
-- 59. Hay tinh tong luong ma cong ty phai tra nhan vien hang thang
select sum(empSalary)
from tblEmployee
-- 60. Hay dem so luong nhan vien khong giam sat nhan vien khac
select count(empSSN)
from tblEmployee
where empSSN not in (
select supervisorSSN
from tblEmployee 
where supervisorSSN is not null)
-- 61. Hay tinh luong phai tra hang thang cho nhan vien giam sat
select sum(empSalary)
from tblEmployee
where empSSN in(
select distinct supervisorSSN
from tblEmployee
where supervisorSSN is not null)
-- 62. Hay tinh tuoi trung binh cua nhan vien lam quan ly phong ban
select avg(datediff(year,empBirthdate,getdate()))
from tblEmployee
where empSSN in(
select mgrSSN 
from tblDepartment 
where mgrSSN is not null)
-- PHAN 4: TRUY VAN GOM NHOM VA DIEU KIEN TREN NHOM
-- GROUP BY: GOM NHOM -> THUONG DUNG DE DAT TREN CAC COT CHUA DU LIEU PHAN LOAI
-- HAVING: 
-- 63. Hay cho biet co bao nhieu nhan vien trong moi phong ban
select count(emp.empSSN)
from tblEmployee emp 
group by emp.depNum
-- 64. Hien thi them thong tin cua ma phong ban
select emp.depNum as 'Ma phong ban',
count(emp.empSSN) as 'So nhan vien cua phong ban'
from tblEmployee emp
group by emp.depNum
-- 65. Hay cho biet bang thong ke so luong nhan vien, luong min, max, avg, sum trong moi phong ban
select emp.depNum as 'Ma phong ban',
count(emp.empSSN) as 'So luong nhan vien',
min(emp.empSalary) as 'Luong thap nhat',
max(emp.empSalary) as 'Luong cao nhat',
avg(emp.empSalary) as 'Luong trung binh'
from tblEMployee emp
group by emp.depNum
-- 66. Hay cho biet bang thong ke ve so luong min, max, avg,sum trong moi phong ban ma o do co so nhan vien >4
select emp.depNum as 'Ma phong ban',
count(emp.empSSN) as 'So luong nhan vien',
min(emp.empSalary) as 'Luong thap nhat',
max(emp.empSalary) as 'Luong cao nhat',
avg(emp.empSalary) as 'Luong trung binh',
sum(emp.empSalary) as 'Tong luong'
from tblEMployee emp
group by emp.depNum 
having count(emp.empSSN) >4

-- where: la dieu kien duoc tinh KO dua tren nhom
-- having la dieu kien duoc tinh dua tren nhom

-- 67. Hay cho biet nhung phong ban co nhan vien o thanh pho va co so luong toi thieu la 2
-- va sap xem giam dan theo so luong nhan vien
select depNum, count(empSSN) as 'So nhan vien'
from tblEmployee
where empAddress like '%TP.%'
group by depNum
having count(empSSN)> 2
order by count(empSSN) desc

-- 68. Hay cho biet moi ma nhan vien co bao nhieu than nhan
select count(depName)
from tblDependent
group by empSSN
-- 69. Hay cho biet moi nhan vien lam tren bao nhieu du an
select empSSN,count(proNum) as 'So du an'
from tblWorksOn
group by empSSN
-- 70. Hay cho biet moi phong ban duoc dat tai bao nhieu dia diem
select depNum, count(locNum) as 'so dia diem'
from tblDepLocation
group by depNum
-- 71. Hay cho biet moi dia diem co bao nhieu phong ban
select locNum, count(depNum) as 'So phong ban'
from tblDeplocation
group by locNum
-- 72. Hay cho biet moi dia diem co bao nhieu du an, lay nhung dia diem
-- co so luong toi thieu la 2 va sap xep giam dan theo so du an
select locNum, count(proNum) as 'So phong ban'
from tblProject
group by locNum
having count(proNum)>=2
order by count(proNum) desc
-- 73. Hay cho biet moi nhan vien lam bao nhieu gio, trung binh so gio lam,
-- so gio it nhat, so gio lam nhieu nhat
-- biet rang trung binh gio lam lon hon 2
select empSSN,
sum(workHours),
avg(workHours),
min(workHours)
from tblWorksOn
group by empSSN
having avg(workHours)>2
-- 74. Hay cho biet moi nhan vien giam sat thi giam sat bao nhieu nhan vien
select supervisorSSN,
count(empSSN)
from tblEmployee
group by supervisorSSN
having supervisorSSN is not null
-- 75. Hay cho biet luong trung binh cua nhan vien giam sat
select empSSN,
avg(empSalary) 
from tblEmployee
group by empSSN
having empSSN in (
select supervisorSSN 
from tblEmployee)
-- 76. Lay ra cac ma nhan vien, ten nhan vien co luong nho nhat
select empSSN, empName
from tblEmployee
where empSalary = (select min(empsalary) from tblEmployee)
-- 77. Hay cho biet co bao nhieu nhan vien co luong lon hon muc trung binh ma o tp
-- va sap xep tang dan theo ma phong ban
select count(*) as 'So luong'
from tblEmployee
where empSalary > (select avg(empSalary) from tblEmployee) and empAddress like 'TP%'
-- 78. Hay liet ke ma phong ban, luong trung binh cua phong ban cua nhung phong ban
-- ma co luong trung binh cua no lon hon trunng binh luong cua cong ty
-- sap xep theo trung binh phong ban tang dan
select depNum, avg(empsalary) N'Lương trung bình phòng ban'
from tblEmployee
group by depNum
having avg(empsalary) > (select AVG(empsalary) from tblEmployee)
order by avg(empsalary) asc
-- 79. Hay liet ke ma phong ban, luong tb cua pb lon hon trung binh cong ty,
-- luu y chi tinh toan tren nhung nhan vien lam o tpho, sap xep giam dan theo ma phong ban
select depNum, avg(empSalary)
from tblemployee
where empAddress like 'TP%'
group by depNum
having avg(empsalary) >(select avg(empsalary) from tblEmployee where empAddress like 'TP%')
order by depnum desc
-- 80. Liet ke nhung ma nhan vien, ten nhan vien co h lam trung binh tren du an lon hon 5 va o thanh pho
select empSSN, empName
from tblEmployee
WHERE empSSN in (
select empSSN 
from tblWorksOn
group by empSSN
having avg(workhours) > 5
)
and empAddress like 'TP%'
order by empSSN desc
--C2:
select wo.empSSN, emp.empName, avg(workhours) as N'Trung bình giờ làm'
from tblWorksOn wo  join tblEmployee emp on wo.empssn = emp.empssn
where empAddress like 'TP%'
group by wo.empSSN, emp.empName
having avg(workhours) > 5
order by wo.empssn desc
-- Phan 5: Join
-- 81. Hay hien thị ten nhan vien va ten phong ban
select *
from tblEmployee emp, tblDepartment dept
where emp.depNum = dept.depNum
-- 82. Hien thi ten nhan vien va ten phong ban cua anh ta dang lam viec
select emp.empName, dep.depName
from tblEmployee emp, tblDepartment dep
where emp.depNum = dep.depNum
-- 83. Hay liet ke ten nhan vien va ten nhan than nhan va moi quan he
select emp.empName, dp.depName, dp.depRelationship
from tblEmployee emp , tblDependent dp 
where emp.empSSN = dp.empSSN
-- Inner Join
select emp.empName, dp.depName, depRelationship
from tblEmployee emp full outer join tblDependent dp on emp.empSSN = dp.empSSN
-- 84. Hay cho biet ten du an, ten dia diem dien ra du an, uu tien hien thi dia diem
select locName, proName
from tblLocation lc left join tblProject pj on pj.locNum = lc.locNum
-- 85. Hay cho biet ma nhan vien, ten nhan vien, ten phong ban va ten than nha
select emp.empSSN, emp.empName, dp.depName, dep.depName
from tblEmployee emp 
inner join tblDepartment dp on emp.depNum = dp.depNum
inner join tblDependent dep on  emp.empSSN = dep.empSSN
-- 86. Hay cho biet ten phong ban, dia diem dat phong ban
select dp.depName, lc.locName
from tblDepLocation dl 
left join tblDepartment dp on dl.depNum = dp.depNum
left join tblLocation lc on dl.locNum = lc.locNum
-- 87. Hay cho biet ten phong ban va cac du an do phong ban quan ly va dia diem dien ra du an
select  depName, proName, locName
from tblDepartment dpm 
inner join tblProject pj on dpm.depNum = pj.depNum
inner join tblLocation lc on pj.locNum = lc.locNum
-- 88. Hay cho biet ten du an va ten nhan vien tham gia du an
select proName, empName
from tblProject pj inner join tblWorksOn wo on pj.proNum = wo.proNum
inner join tblEmployee emp on wo.empSSN = emp.empSSN
-- 89. Hay cho biet ten du an, ten nhan vien tham gia va phong ban nhan vien do lam
select proName, empName, depName
from tblProject pj 
inner join tblWorksOn wo on pj.proNum = wo.proNum
inner join tblEmployee emp on wo.empSSN = emp.empSSN
inner join tblDepartment dp on emp.depNum = dp.depNum
-- 90. Hay cho biet ten du an, dia diem dien ra du an, ten nhan vien tham gia du an va phong ban nhan vien do lam
select proName, locName, empName, depName
from tblProject pj
inner join tblLocation lc on pj.locNum = lc.locNum
inner join tblWorksOn wo on pj.proNum = wo.proNum
inner join tblEmployee emp on wo.empSSN = emp.empssn
inner join tblDepartment dp on emp.depNum = dp.depNum
-- 91. Hay cho biet ten than nhan, ten nhan vien, ten phong ban va dia diem cua phong ban
select dpt.depName, empName, dp.depName, locName
from tblDependent dpt 
inner join tblEmployee emp on dpt.empSSN = emp.empSSN
inner join tblDepartment dp on emp.depNum = dp.depNum
inner join tblDepLocation dpl on dp.depNum = dpl.depNum
inner join tblLocation lc on dpl.locNum = lc.locNum
-- 92. Hay cho biet ten nhan vien va quan ly cua nhan vien do
SELECT e.empName AS EmployeeName,
	ISNULL(s.empName,'No supervisor') as 'Supervisor Name'
FROM tblEmployee  e
LEFT JOIN tblEmployee s ON e.supervisorSSN = s.empSSN
Order by [Supervisor Name] ASC
-- 93. Hay cho biet ten phong ban va ten nhan vien quan ly
select dp.depName, emp.empName
from tblDepartment dp inner join tblEmployee emp on dp.mgrSSN = emp.empSSN
-- 94. Hay cho biet thong tin ma phong, ten phong va ma nhan vien quan ly, ten nhan vien quan ly va luong nguoi quan ly > 50000
select dp.depNum, depName, dp.mgrSSN, empName
from tblDepartment dp inner join tblEmployee emp on dp.mgrSSN = emp.empSSN
where emp.empSalary > 50000
-- 95. Truy van de hien thi danh sach ma nhan vien khong quan ly phong ban nao het va ten than nhan
select emp.empSSN, dpt.depName
from tblEmployee emp inner join tblDependent dpt on emp.empSSN = dpt.empSSN
where emp.empSSN not in (select mgrssn from tblDepartment)
-- 96. Hay cho biet ten nhan vien, ten phong ban ma khong co nguoi than
select empName, dpm.depName
from tblEmployee emp 
left join tblDependent dp on emp.empSSN = dp.empSSN
left join tblDepartment dpm on emp.depNum = dpm.depNum
where dp.empSSN is Null
-- 97. Hay cho biet ten nhan vien, ten phong ban cua nhung nguoi lam giam sat va khong co nguoi than
select empName, dpm.depName
from tblEmployee emp 
left join tblDepartment dpm on emp.depNum = dpm.depNum
left join tblDependent dp on emp.empSSN = dp.empSSN
where emp.empSSN in (select supervisorSSN from tblEmployee where supervisorSSN is not Null)
and dp.empSSN is null
-- C2: CTE
with tb1 as (
	select distinct supervisorSSN
	from tblEmployee
	where supervisorSSN is not null
)
select tb1.supervisorSSN, emp.empName, dp.depName
from tblEmployee emp 
inner join tb1 on emp.empSSN = tb1.supervisorSSN
left join tblDependent dp on tb1.supervisorSSN = dp.empSSN
where depName is Null
-- 98. Hay cho biet ten nhan vien, ten phong ban ma nhan vien do khong tham gia du an nao 
select empName, depName
from tblEmployee emp 
left join tblWorksOn wo on emp.empSSN = wo.empSSN
inner join tblDepartment dpm on emp.depNum = dpm.depNum
where wo.empSSN is null
-- 100. Hay cho biet ma phong ban, ten phong ban, va so luong du an ma phong ban quan ly > 1
select dpt.depNum, depName, COUNT(*) as 'So luong quan ly'
from tblDepartment dpt inner join tblProject pj on dpt.depNum = pj.depNum
group by dpt.depNum, depName
having COUNT(*) > 1
-- 101. Hay cho biet ma phong ban, ten phong ban va so luong du an ma phong ban quan l co so luong lon
-- hon 1 ma la lam ben phan mem, sau do sap giam dan the so du an
select dpt.depNum, depName, COUNT(*) as 'So luong quan ly'
from tblDepartment dpt inner join tblProject pj on dpt.depNum = pj.depNum
where dpt.depName like N'%Phần mềm%'
group by dpt.depNum, depName
having COUNT(*) > 1
order by [So luong quan ly] DESC
-- 102. Hay cho biet moi nhan vien co bao nhieu nguoi than va ten phong ban
select emp.empSSN, empName, dpt.depName, COUNT(dp.depName) as 'So luong nguoi than'
from tblEmployee emp
left join tblDependent dp on emp.empSSN = dp.empSSN
left join tblDepartment dpt on emp.depNum = dpt.depNum
group by emp.empSSN, empName, dpt.depName
-- 103. Hay cho biet co bao nhieu du an o moi dia diem, hien thi ten dia diem
select lc.locName, COUNT(proNum) as 'So luong du an'
from tblLocation lc inner join tblProject pj on lc.locNum = pj.locNum
group by lc.locName
-- 104. Hay cho biet ten moi phong ban duoc dat tai bao nhieu dia diem
select dpt.depName, COUNT(locnum) as 'So luong dia diem'
from tblDepartment dpt inner join tblDepLocation dptl on dpt.depNum = dptl.depNum
group by dpt.depName
-- 105. Hay cho biet ten moi dia diem va so luong  phong ban o do
select lc.locName, COUNT(depNum)
from tblLocation lc inner join tblDepLocation dptl on lc.locNum = dptl.locNum
group by lc.locName
-- 106. Hay cho biet ten nhan vien va so luong du an nhan vien tham gia
select emp.empName, COUNT(proNum) as 'So luong du an'
from tblEmployee emp left join tblWorksOn wo on emp.empSSN = wo.empSSN
group by emp.empName
-- 107. Hay cho biet ten du an va so luong nhan vien tham gia
select  proName, COUNT(empSSN) as 'So luong nhan vien'
from tblProject pj left join tblWorksOn wo on pj.proNum = wo.proNum
group by proName
use FUH_COMPANY



--	VIEW: tạo bagr ảo dựa trên bảng thật
--109
go
create view vw_employeeFemale as
select empssn, empname, empsex, empsalary
from tblEmployee
where empSex = 'F'
go
select *
from vw_employeeFemale
where empSalary > 50000

-- với VIEW sinh ra từ một bảng ( truy vân cơ bản ) thì ta có thể 
-- thực hiện các thao tác INSERT, UPDATE, DELETE

insert vw_employeeFemale(empSSN, empName, empSex, empSalary) 
values ('123123123', N'nguyễn thị béo', 'F', 5000 )

update vw_employeeFemale
set empSalary = 9000
where empSSN = '30121050418'

delete vw_employeeFemale
where empSSN = '123123123'

--xóa VIEWs
drop view vw_employeeFemale

--110. Tạo view lấy nhân viên và tên phòng ban của nhân viên đó
go
create view vw_employeedepartment 
as
select empSSN, empName, empSex, empSalary, dep.depName
from tblEmployee emp
inner join tblDepartment dep
on emp.depNum = dep.depNum
go

select * 
from vw_employeedepartment

select *
from vw_employeedepartment dep

--PHẦN 7: LẬP TRÌNH T-SQL
--SCRIPT
--KHAI BÁO BIẾN
--SYSTEM HỆ THỐNG --> @@<NAME> --> LẤY (XEM) GIÁ TRỊ 
--USER DEFINED: do người dùng định nghĩa -> @<name> -> get (xem), set (gán)
--THAM KHẢO: SQL- w3school
--111.
declare @luong float
--gán giá trị cho biến
set @luong = 3000
-- hiện thị giá trị của biến
select @luong 
-- or print @soluong
--4 T-sql: đưa biến vào query
select *
from tblEmployee
where empSalary > @luong

-- IF ... ELSE
-- PART 1. Cơ bản 
declare @x int
set @x = 10
if (@x % 2) = 0
begin 
	select N'số chẵn'
end
else 
begin
	print N'số lẻ'
end

-- part 2: Nâng cao (liên quan truy vấn)
-- 112. Hãy tính  tổng lương phải trả hàng háng cho nhân viên,
-- nếu tổng lương < 250000 thì xuất ra 'Chưa cần tính giảm biên chế'
-- nguouowjv lại thì in ra 'cần giảm biên chế'

declare @tongluong real
select @tongluong = sum(empsalary)
from tblEmployee

--print @tongluong
if @tongluong < 250000
begin 
	print N'chưa cần giảm biên chế'
end
else
begin 
	print N'Giảm biên chế'
end

--	PHẦN 8: VIẾT THỦ TỤC STORE PROCEDURE
-- DẪN NHẬP: Tránh lộ thông tin
select *
from tblEmployee
--tạo thủ tục để giới hạn qyên truy xuất thông tin nhạy cảm 
--thủ tục tham số

--113 viết thủ tục sempinfo
--để liệt kê mã nhân viên , tên và lương
go 
create procedure sempinfo as
select empSSN, empName, empSalary
from tblEmployee
go
exec sempinfo
go 
drop procedure sempinfo
-- thủ tục tham số 
--114 viết thủ tục spempsalary
--để liệt kê mã nhân viên, tên và lương
-- biết rằng lương lớn hơn mọt giá trị nào đó
go
create procedure sempsalary
@luong float as
select empSSN, empName, empSalary
from tblEmployee
where empSalary >= @luong
go
exec sempsalary 5000
drop procedure sempsalary
--115 viết thủ tục epempSalaryaddress
--để liệt kê mã, tên, lương và tên phòng ban
-- biết rằng lương lớn hơn giá trị nào đó
-- nhân viên ở một nơi nào đó
go
create procedure empSalaryAddress
@luong float, @Address NVARCHAR(50)
as
select emp.empSSN, emp.empName, empSalary, depName
from tblEmployee emp 
inner join tblDepartment dp on emp.depNum = dp.depNum
where empSalary >= @luong and empAddress like '%'+@Address+'%'
go 
exec empSalaryAddress 10000,N'Hồ Chí Minh'
go
drop procedure empSalaryAddress
--FUNCTION: có hai loại 
--trả về Scalar (một giá trị cụ thể), Table(bảng dữ liệu)
-- prefix cỉa hàm là fn
-- Loại 1: trr về scarlar
--116 viết hàm fnCountEmployee nhằm đếm số lượng nv Công ty
go
create function fnCountEmployee()
returns int
as
begin
	declare @soluongemp int
	select @soluongemp = count(*)
	from tblEmployee
	return @soluongemp
end
go 
declare @kq int
exec @kq = fnCountEmployee
print @kq
drop function fnCountEmployee
--117 viết hàm fnSalaryEmployeeSex nhằm để tính tổng lương phải trả cho nv
-- hàng tháng trong công ty
-- theo giới tính <-- tham số đầu vào
go 
create function fnSalaryEmpSex
(
	@sex char(1)
)
returns float
as
begin 
	declare @tongluong float
	select @tongluong = sum(empSalary)
	from tblEmployee
	where empSex = @sex
	return @tongluong
end
go
declare @kq float
exec @kq = fnSalaryEmpSex 'F'
print @kq
drop function fnSalaryEmpSex
--118 viết hàm fnCountEmployeeSex nhằm để đếm số lượng  nhân viên (@soluongemp) có trong công ty
-- theo giới tính (@tmpSex) và lương lớn hơn một mức cụ thể(empSalary > ....(@tmpSalary))
go
create function fnCountEmployeeSex
(
	@tmpSex char(1),
	@tmpSalary decimal
)
returns int
as
begin 
	declare @soluong int
	select @soluong = count(*)
	from tblEmployee
	where empSex = @tmpSex and empSalary >= @tmpSalary
	return @soluong
end
go
declare @kq int
exec @kq = fnCountEmployeeSex 'M',50000
print @kq
drop function fnCountEmployeeSex
--LOẠI 2: TRẢ VỀ TABLE
--119.  viet ham fnTblEmployeeSalarySex tra ve bang khach hang
--bao gom: ma nhan vien, ten nhan vien, gioi tinh, dia chi, luong, biet rang luong lon hon mot muc nao do <--tham so truyen vao
--va nhan vien la gioi tinh nao do <-- tham so truyen vao
go
create function fnTblEmployeeSalarySex
(
	@tmpSalary float,
	@tmpSex char(1)
)
returns table
as
return (
	select empSSN, empName, empSex, empAddress, empSalary
	from tblEmployee
	where empSalary >= @tmpSalary and empSex = @tmpSex
	)
go 
--thuc thi
select * from fnTblEmployeeSalarySex(50000,'F')

select emp.empName, emp.empSalary
from fnTblEmployeeSalarySex(50000,'F') emp
where emp.empAddress like '%TP%'

--xoa
drop function fnTblEmployeeSalarySex
--120. viet ham fnTblEmployeeDepartment hien thi danh sach thong ttin ma nhan vien, ten nhan vien, luong va ten phong ban nhan vien lam viec
--biet rang tham so truyen vao la dia chi
go
create function fnTblEmployeeDepartment
(
	@tmpAddress NVARCHAR(50)
)
returns table
as
return (
	select empSSN,empName,empSalary,depName
	from tblEmployee emp 
	inner join tblDepartment dp on emp.depNum = dp.depNum
	where empAddress like '%'+@tmpAddress+'%'
	)
go
select * from fnTblEmployeeDepartment(N'Hồ Chí Minh')
drop function fnTblEmployeeDepartment
--121. viet thu tuc spProjectLocation de liet ke ma du an, ten du an duoc to chuc o dia diem nao do 
go
create procedure spProjectLocation @vLocation nvarchar(50)
as 
select pro.proNum, pro.proName, loc.locName
from tblProject pro 
inner join tblLocation loc on pro.locNum=loc.locNum
where loc.locName like '%'+@vLocation+'%'
go
exec spProjectLocation N'Hồ Chí Minh'
--122. viet thu tuc spDepartmentLocation de liet ke danh sach dia diem ma mot phong ban nao do duoc dat
go
create procedure spDepartmentLocation 
@location NVARCHAR(50)
as
select dpm.depNum, depName, lc.locName
from tblDepartment dpm 
inner join tblDepLocation dpl on dpm.depNum = dpl.depNum
inner join tblLocation lc on dpl.locNum = lc.locNum
where locName like '%'+@location+'%'
go
exec spDepartmentLocation N'Hồ Chí Minh'
drop procedure spDepartmentLocation
--123. viet ham fnEmployeeDepend tra  ve so luong than nhan cua mot nhan vien khi biet ma nhan vien
go
create function fnEmployeeDepend
(
	@tmpSSN varchar(20)
)
returns int
as
begin
	declare @sldepend int
	select @sldepend = count(*)
	from tblEmployee emp 
	inner join tblDependent dp on emp.empSSN = dp.empSSN
	where emp.empSSN = @tmpSSN
	return @sldepend
end
go
declare @kq int
exec @kq = fnEmployeeDepend '30121050004'
print @kq
drop function fnEmployeeDepend
--124. viet ham fnEmployeeInfo liet ke thong tin ma nhan vien, ten nhan vien, luong, so gio lam, ten phong ban cua cac nhan vien
go
create function fnEmployeeInfo(
@tmpSSN varchar(20) 
)
returns table
as
return 
(
	select emp.empSSN, empName, empSalary, sum(workHours) as total_work_hours, depName
	from tblEmployee emp 
	inner join tblWorksOn wo on emp.empSSN = wo.empSSN
	inner join tblDepartment dpm on emp.depNum = dpm.depNum
	where emp.empSSN = @tmpSSN
	group by  emp.empSSN,emp.empName,emp.empSalary,dpm.depName
)
go
select * from fnEmployeeInfo('30121050142')
drop function fnEmployeeInfo
--125. viet ham fnEmployeePerformance tra ve bang thong tin bao gom ten nhan vien, luong, so gio lam, ten phong ban cua nhung 
-- nhan vien co so tuoi be hon mot muc tuoi nao do va gioi tinh nao do
go
create function fnEmployeePerformance
(
	@vAge int,
	@vSex char(1)
)
returns table
as 
return (select emp.empName, emp.empSalary, sum(wrk.workHours) as TotalWorkHours, dept.depName
		from tblEmployee emp 
		inner join tblWorksOn wrk on emp.empSSN=wrk.empSSN
		inner join tblDepartment dept on emp.depNum=dept.depNum
		where datediff(year,emp.empBirthdate,getdate()) < @vAge and emp.empSex = @vSex
		group by emp.empName, emp.empSalary, dept.depName)
go
select * from fnEmployeePerformance(100,'F')
drop function fnEmployeePerformance
--Ràng buộc dữ liệu (Constraint)
-- Áp dụng trên các thao tác INSERT, UPDATE và DELETE
--1. Primary Key (demo) --> Prefix là pk
--2. Foreign Key (demo) --> prefix là fk
--3. Check (logical, expression) --> kiểm tra các ràng buộc giá trị của dòng dữ liệu cơ bản, ràng buộc này sẽ áp dụng cho tất cả các prefix là ck
--126. Thêm ràng buộc về lương(salary) của nhân viên (tblEmployee) lớn hơn 10000
alter table tblEmployee add check (empSalary > 10000)
alter table tblEmployee drop constraint CK__tblEmploy__empSa__2645B050
--127 Tạo ràng buộc kiểm tra các ck_sex là F,M,L,G,B,T
alter table tblEmployee add constraint ck_sex
check (empSex in ('F','M','L','G','B','T'))
--------------Transaction----------------------------------
--128 Cập nhật lương nhân viên tăng thêm 10.000 mỗi lần tăng lương
--tuy nhiên nếu tổng lương cty phải trả quá 2.000.000 phải trả hàng tháng
--thì không được tăng lương nữa
Begin tran
--task 1
Update tblEmployee
set empSalary = empSalary + 50000
--task 2
declare @tongluong float
select @tongluong = sum(empSalary)
from tblEmployee

if @tongluong < 2000000
begin
print N'tăng lương thành công'
commit tran
end
else
begin
print N'tổng lương vượt ngưỡng 2.000.000'
rollback tran
end

select empSalary
from tblEmployee
--129. Cập nhật lương nhân viên tăng thêm 5000 mỗi lần tăng lương tuy nhiên nếu có bất kì một
-- phòng ban mà có tổng lương hàng tháng phải trả > 250.000 thì ko được tăng lương nữa
begin tran
--task 1
update tblEmployee
set empSalary = empSalary + 5000
--task 2
declare @max_tongluong float

with PHU as(
select sum(empSalary) as Luong
from tblEmployee
group by depNum)

select @max_tongluong = max(Luong)
from PHU

print @max_tongluong

if @max_tongluong <= 250000
begin
	print N'Tăng lương thành công'
	commit tran
end
else
begin
	print N'Tổng lương phòng ban vượt ngưỡng 250000'
	print @max_tongluong
	rollback tran
end
---------TRIGGERS-----------
-- Sử dụng để kiểm tra các ràng buộc dữ liệu mang tính nghiệp vụ nâng cao
-- Trigger tác động lên 3 thao tác INSERT, UPDATE và DELETE cho bảng dữ liệu
-- Prefix: tg

--130. Hãy tạo Trigger tg_CheckInsertLocation trong bảng tblLocation
--để ràng buộc số lượng địa điểm không được vượt quá 10
--khi thêm mới dữ liệu INSERT
go 
create trigger tg_CheckInsertLocation on tblLocation after insert
as
	declare @soluong int

	select @soluong = count(*)
	from tblLocation

	if @soluong > 10
	begin 
		print('Vi pham vi so luong dia diem lon hon 10')
		rollback -- Khôi phục lại trạng thái trước khi thực hiện Insert thất bại
	end
	else
	begin
		print 'Ghi du lieu thanh cong'
		--comit--Ghi dữ liệu chính thức xuất CSDL
		--tuy nhiên, mặc định là comit nên không cần ghi gì nữa
	end
go
--Tắt Trigger
go 
disable trigger tg_CheckInsertLocation on tblLocation
--Mở lại Trigger
go
enable trigger tg_CheckInsertLocation on tblLocation
--Xóa Trigger
go 
drop trigger tg_CheckInsertLocation
--131.Hãy tạo trigger tg_CheckDeleteLocation trong bảng tblLocation
--để ràng buộc số lượng địa điểm tối thiếu là 6 khi xóa dữ liệu (DELETE)
go
create trigger tg_CheckDeleteLocation on tblLocation after delete
as
declare @soluong int
	select @soluong = count(*)
	from tblLocation

	if @soluong < 6
	begin 
		print 'Vi pham so luong dia diem toi thieu la 6'
		rollback
	end
	else
	begin
		print 'Xoa du lieu thanh cong'
	end
go
--132.Hãy tạo trigger tg_CheckInsertUpdatEmployee
--trong bảng tblEmployee để ràng buộc tổng lương
--phải trả hằng tháng không vượt quá 1500000
--khi thêm mới, cập nhật dữ liệu (inser,update)
go
create trigger tg_CheckInsertUpdatEmployee on tblEmployee after insert,update
as
	declare @tongluong decimal
	select @tongluong = sum(empSalary)
	from tblEmployee

	if (@tongluong > 1500000)
	begin 
		print 'Vi pham tong luong qua 1500000'
		rollback
	end
	else
	begin 
		print 'Cap nhat du lieu thanh cong'
	end
go
select sum(empSalary)
from tblEmployee
drop trigger tg_CheckInsertUpdatEmployee
--Nâng cao Trigger
--Khi thực hiện Trigger trên thao tác Insert cho bảng dữ liệu
--thì dữ liệu mới sẽ được insert tạm thời trong bảng có tên Inserted,
--ta có thể dùng bản này để hỗ trợ xử lý các thao tác logic cho trigger nâng cao
-- và trong đó chỉ chứa dòng dữ liệu mới vừa được thêm bào bảng đang được chỉ 

--133.Viết trigger tg_InsertProjectLocation để kiểm tra rằng một địa điểm chỉ có 
--tối đa 4 project được tổ chức khi thêm mới (insert) một project vào bảng tblProject
go 
create trigger tg_InsertProjectLocationon on tblProject after insert 
as
--Kỹ thuật quan trọng: Muốn lấy thông tin của dòng mới thêm vào ta dùng bảng Inserted
	declare @maloc int
	select @maloc = locNum
	from inserted

	declare @soluong int
	select @soluong = count(*)
	from tblProject
	where locnum = @maloc

	if (@soluong > 4)
	begin 
		print 'Vi pham vi so luong project trong dia diem lon hon 4'
		rollback -- Khôi phục lại trạng thái trước khi thực hiện insert thất bại
	end
	else
	begin
		print 'Them vao thanh cong'
	end
go
drop trigger tg_InsertProjectLocation
--134. Hãy viết trigger tg_CheckEmployeeWorkOn
--để kiểm tra rằng khi INSERT, UPDATE thì nhân viên không được làm quá 100 giờ
go
create trigger tg_CheckEmployeeWorkOn on tblWorksOn after update,insert
as
	declare @maemp decimal
	select @maemp = empSSn
	from inserted

	declare @totalhour int
	select @totalhour = sum(workHours)
	from tblWorksOn
	where empSSN = @maemp

	if (@totalhour >= 100)
	begin 
		print 'Vi pham vi so gio lam viec tren 100 gio'
		rollback
	end
	else
	begin
		print 'Them thanh cong'
	end
go
drop trigger tg_CheckEmployeeWorkOn
--Khi thực hiện trigger trên thao tác Delete cho bảng dữ liệu
--thì dữ liệu mới sẽ được deleted tạm thời trong bảng có tên DELETED,
--ta có thể dùng bảng này để hỗ trợ xử lý các thao tác logic cho Trigger tác động lên
--và trong đó chỉ chứa dòng dữ liệu mới vừa được xóa ra khỏi bảng ban đầu.

--135.Viết trigger tg_DeleteProjectLocation để kiểm tra bằng một địa điểm chỉ có tối thiểu 2 project
--được tổ chức khi xóa (DELETE) một project ra khỏi bảng 
--Gợi ý: lấy mã Location của dòng vừa xóa trong bảng DELETE
go
create trigger tg_DeleteProjectLocation on tblProject after delete
as
	declare @maloc int
	select @maloc = locnum
	from deleted

	declare @soluong int
	select @soluong = count(*)
	from tblProject
	where locNum = @maloc

	if (@soluong < 2)
	begin 
		print 'Vi pham vi so luong project toi thieu 2'
		rollback
	end
	else
	begin 
		print 'Xoa thanh cong'
	end
go
--136.Viết trigger tg_CheckDeleteEmployeeDepartment để kiểm tra rằng, khi xóa một nhân viên thì
--phải đảm bảo phòng ban còn ít nhất 2 nhân viên
go
create trigger tg_CheckDeleteEmployeeDepartment on tblEmployee after delete
as
	declare @madep decimal
	select @madep = depNum
	from deleted

	declare @soluongemp int
	select @soluongemp = count(*)
	from tblEmployee
	where depNum = @madep

	if @soluongemp < 2
	begin 
		print('Vi pham so luong nhan vien be hon 2 nhan vien')
		rollback
	end
	else
	begin 
		print('Xoa thanh cong')
	end
go 
drop trigger tg_CheckDeleteEmployeeDepartment