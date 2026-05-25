-- SQL Server 2012 - Task KPI Module
-- NOTE: Do NOT recreate tbl_phong_ban, tbl_nhan_vien
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.tbl_task (
    id_task INT IDENTITY(1,1) PRIMARY KEY,
    ma_task VARCHAR(50) NOT NULL,
    ten_task NVARCHAR(500) NOT NULL,
    mo_ta NVARCHAR(MAX) NULL,
    loai_task NVARCHAR(100) NULL,
    muc_do_uu_tien INT DEFAULT 2,
    hinh_thuc_giao VARCHAR(30) NOT NULL,
    nguoi_tao VARCHAR(10) NOT NULL,
    ten_nguoi_tao NVARCHAR(100) NULL,
    id_pb_de_xuat INT NULL,
    ten_pb_de_xuat NVARCHAR(100) NULL,
    nguoi_nhan VARCHAR(10) NULL,
    ten_nguoi_nhan NVARCHAR(100) NULL,
    nguoi_tiep_nhan_pb VARCHAR(10) NULL,
    ten_nguoi_tiep_nhan_pb NVARCHAR(100) NULL,
    ngay_tiep_nhan_pb DATETIME NULL,
    ngay_giao DATETIME DEFAULT GETDATE(),
    ngay_bat_dau DATETIME NULL,
    han_hoan_thanh DATETIME NULL,
    ngay_hoan_thanh DATETIME NULL,
    trang_thai VARCHAR(50) DEFAULT 'NEW',
    tien_do INT DEFAULT 0,
    diem_kpi_goc DECIMAL(18,2) DEFAULT 0,
    he_so_thoi_gian DECIMAL(18,2) DEFAULT 1,
    he_so_chat_luong DECIMAL(18,2) DEFAULT 1,
    diem_kpi_thuc_te DECIMAL(18,2) DEFAULT 0,
    danh_gia_chat_luong VARCHAR(50) NULL,
    nhan_xet_quan_ly NVARCHAR(MAX) NULL,
    so_lan_tra_lai INT DEFAULT 0,
    is_qua_han BIT DEFAULT 0,
    ngay_tao DATETIME DEFAULT GETDATE(),
    ngay_cap_nhat DATETIME NULL
);
GO
CREATE TABLE dbo.tbl_task_phong_ban_de_xuat (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_task INT NOT NULL,
    id_pb INT NOT NULL,
    ten_pb NVARCHAR(100) NULL,
    trang_thai VARCHAR(50) DEFAULT 'WAITING',
    nguoi_phan_hoi VARCHAR(10) NULL,
    ten_nguoi_phan_hoi NVARCHAR(100) NULL,
    ghi_chu_phan_hoi NVARCHAR(MAX) NULL,
    ngay_phan_hoi DATETIME NULL,
    ngay_tao DATETIME DEFAULT GETDATE()
);
GO
CREATE TABLE dbo.tbl_task_thanh_vien (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_task INT NOT NULL,
    manv VARCHAR(10) NOT NULL,
    tennv NVARCHAR(100) NULL,
    vai_tro VARCHAR(50) DEFAULT 'SUPPORTER',
    ngay_tao DATETIME DEFAULT GETDATE()
);
GO
CREATE TABLE dbo.tbl_task_tien_do (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_task INT NOT NULL,
    tien_do INT NOT NULL,
    noi_dung_cap_nhat NVARCHAR(MAX) NULL,
    nguoi_cap_nhat VARCHAR(10) NOT NULL,
    ten_nguoi_cap_nhat NVARCHAR(100) NULL,
    ngay_cap_nhat DATETIME DEFAULT GETDATE()
);
GO
CREATE TABLE dbo.tbl_task_binh_luan (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_task INT NOT NULL,
    nguoi_binh_luan VARCHAR(10) NOT NULL,
    ten_nguoi_binh_luan NVARCHAR(100) NULL,
    noi_dung NVARCHAR(MAX) NOT NULL,
    ngay_tao DATETIME DEFAULT GETDATE()
);
GO
CREATE TABLE dbo.tbl_task_file (
    id_file INT IDENTITY(1,1) PRIMARY KEY,
    id_task INT NOT NULL,
    ten_file_goc NVARCHAR(255) NOT NULL,
    ten_file_luu NVARCHAR(255) NOT NULL,
    duong_dan_file NVARCHAR(500) NOT NULL,
    dung_luong BIGINT NULL,
    loai_file VARCHAR(100) NULL,
    nguoi_upload VARCHAR(10) NOT NULL,
    ten_nguoi_upload NVARCHAR(100) NULL,
    ngay_upload DATETIME DEFAULT GETDATE(),
    is_deleted BIT DEFAULT 0
);
GO
CREATE TABLE dbo.tbl_task_log (
    id_log INT IDENTITY(1,1) PRIMARY KEY,
    id_task INT NOT NULL,
    hanh_dong VARCHAR(50) NOT NULL,
    trang_thai_cu VARCHAR(50) NULL,
    trang_thai_moi VARCHAR(50) NULL,
    nguoi_thuc_hien VARCHAR(10) NOT NULL,
    ten_nguoi_thuc_hien NVARCHAR(100) NULL,
    ghi_chu NVARCHAR(MAX) NULL,
    tien_do INT NULL,
    ngay_tao DATETIME DEFAULT GETDATE()
);
GO
CREATE TABLE dbo.tbl_task_kpi_config (
    id INT IDENTITY(1,1) PRIMARY KEY,
    config_code VARCHAR(50),
    config_name NVARCHAR(255),
    config_value DECIMAL(18,2),
    note NVARCHAR(500),
    is_active BIT DEFAULT 1
);
GO
CREATE TABLE dbo.tbl_task_notification (
    id INT IDENTITY(1,1) PRIMARY KEY,
    manv VARCHAR(10),
    title NVARCHAR(255),
    message NVARCHAR(MAX),
    link_url NVARCHAR(500),
    is_read BIT DEFAULT 0,
    ngay_tao DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO dbo.tbl_task_kpi_config(config_code, config_name, config_value, note) VALUES
('TIME_EARLY', N'Hoàn thành sớm', 1.10, N'Task hoàn thành trước deadline'),
('TIME_ON_TIME', N'Hoàn thành đúng hạn', 1.00, N'Task hoàn thành đúng hạn'),
('TIME_LATE_LIGHT', N'Trễ nhẹ', 0.80, N'Trễ từ 1 đến 2 ngày'),
('TIME_LATE_HEAVY', N'Trễ nhiều', 0.50, N'Trễ trên 2 ngày'),
('TIME_NOT_DONE', N'Không hoàn thành', 0.00, N'Không hoàn thành task'),
('QUALITY_EXCELLENT', N'Xuất sắc', 1.20, N'Kết quả vượt yêu cầu'),
('QUALITY_GOOD', N'Tốt', 1.00, N'Kết quả tốt'),
('QUALITY_NORMAL', N'Đạt yêu cầu', 0.80, N'Kết quả đạt yêu cầu'),
('QUALITY_BAD', N'Chưa đạt', 0.50, N'Cần cải thiện'),
('QUALITY_FAILED', N'Không đạt', 0.00, N'Không đạt yêu cầu');
GO

CREATE PROC sp_task_create
    @ten_task NVARCHAR(500), @mo_ta NVARCHAR(MAX)=NULL, @loai_task NVARCHAR(100)=NULL,
    @muc_do_uu_tien INT=2, @hinh_thuc_giao VARCHAR(30), @nguoi_tao VARCHAR(10), @ten_nguoi_tao NVARCHAR(100)=NULL,
    @id_pb_de_xuat INT=NULL, @nguoi_nhan VARCHAR(10)=NULL, @diem_kpi_goc DECIMAL(18,2)=0,
    @han_hoan_thanh DATETIME=NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @id_task INT, @ma_task VARCHAR(50), @seq INT, @today CHAR(8)=CONVERT(CHAR(8),GETDATE(),112), @status VARCHAR(50);
    SELECT @seq = ISNULL(MAX(CAST(RIGHT(ma_task,4) AS INT)),0)+1 FROM tbl_task WHERE ma_task LIKE 'TASK-'+@today+'-%';
    SET @ma_task = 'TASK-'+@today+'-'+RIGHT('0000'+CAST(@seq AS VARCHAR(4)),4);
    SET @status = CASE WHEN @hinh_thuc_giao='DEPARTMENT' THEN 'WAITING_DEPARTMENT_ACCEPT' ELSE 'ASSIGNED' END;

    INSERT INTO tbl_task(ma_task,ten_task,mo_ta,loai_task,muc_do_uu_tien,hinh_thuc_giao,nguoi_tao,ten_nguoi_tao,id_pb_de_xuat,ten_pb_de_xuat,
        nguoi_nhan,ten_nguoi_nhan,trang_thai,diem_kpi_goc,han_hoan_thanh)
    SELECT @ma_task,@ten_task,@mo_ta,@loai_task,@muc_do_uu_tien,@hinh_thuc_giao,@nguoi_tao,@ten_nguoi_tao,@id_pb_de_xuat,pb.ten_pb,
        @nguoi_nhan,nv.tennv,@status,@diem_kpi_goc,@han_hoan_thanh
    FROM (SELECT 1 x) a
    LEFT JOIN tbl_phong_ban pb ON pb.id_pb=@id_pb_de_xuat
    LEFT JOIN tbl_nhan_vien nv ON nv.manv=@nguoi_nhan;

    SET @id_task = SCOPE_IDENTITY();

    IF @hinh_thuc_giao='DEPARTMENT'
    INSERT INTO tbl_task_phong_ban_de_xuat(id_task,id_pb,ten_pb,trang_thai)
    SELECT @id_task,pb.id_pb,pb.ten_pb,'WAITING' FROM tbl_phong_ban pb WHERE pb.id_pb=@id_pb_de_xuat;

    INSERT INTO tbl_task_log(id_task,hanh_dong,trang_thai_moi,nguoi_thuc_hien,ten_nguoi_thuc_hien,ghi_chu)
    VALUES(@id_task,'CREATE_TASK',@status,@nguoi_tao,@ten_nguoi_tao,N'Tạo task mới');

    SELECT @id_task id_task, @ma_task ma_task;
END
GO

-- Other SPs are included as compact versions
CREATE PROC sp_task_department_accept @id_task INT,@manv VARCHAR(10),@tennv NVARCHAR(100),@ghi_chu NVARCHAR(MAX)=NULL AS
BEGIN
 UPDATE tbl_task_phong_ban_de_xuat SET trang_thai='ACCEPTED',nguoi_phan_hoi=@manv,ten_nguoi_phan_hoi=@tennv,ghi_chu_phan_hoi=@ghi_chu,ngay_phan_hoi=GETDATE() WHERE id_task=@id_task;
 UPDATE tbl_task SET trang_thai='WAITING_ASSIGN_EMPLOYEE',nguoi_tiep_nhan_pb=@manv,ten_nguoi_tiep_nhan_pb=@tennv,ngay_tiep_nhan_pb=GETDATE() WHERE id_task=@id_task;
 INSERT INTO tbl_task_log(id_task,hanh_dong,trang_thai_moi,nguoi_thuc_hien,ten_nguoi_thuc_hien,ghi_chu) VALUES(@id_task,'DEPARTMENT_ACCEPT','WAITING_ASSIGN_EMPLOYEE',@manv,@tennv,@ghi_chu);
END
GO
CREATE PROC sp_task_department_reject @id_task INT,@manv VARCHAR(10),@tennv NVARCHAR(100),@ly_do NVARCHAR(MAX) AS
BEGIN
 UPDATE tbl_task_phong_ban_de_xuat SET trang_thai='REJECTED',nguoi_phan_hoi=@manv,ten_nguoi_phan_hoi=@tennv,ghi_chu_phan_hoi=@ly_do,ngay_phan_hoi=GETDATE() WHERE id_task=@id_task;
 UPDATE tbl_task SET trang_thai='DEPARTMENT_REJECTED' WHERE id_task=@id_task;
 INSERT INTO tbl_task_log(id_task,hanh_dong,trang_thai_moi,nguoi_thuc_hien,ten_nguoi_thuc_hien,ghi_chu) VALUES(@id_task,'DEPARTMENT_REJECT','DEPARTMENT_REJECTED',@manv,@tennv,@ly_do);
END
GO
CREATE PROC sp_task_assign_employee @id_task INT,@manv_nhan VARCHAR(10),@manv_th VARCHAR(10),@tennv_th NVARCHAR(100) AS
BEGIN
 IF NOT EXISTS (SELECT 1 FROM tbl_task t JOIN tbl_nhan_vien nv ON nv.manv=@manv_nhan WHERE t.id_task=@id_task AND t.id_pb_de_xuat=nv.nhomquyen)
   AND EXISTS (SELECT 1 FROM tbl_task WHERE id_task=@id_task AND hinh_thuc_giao='DEPARTMENT') RAISERROR(N'Nhân viên không thuộc phòng ban đề xuất',16,1);
 UPDATE t SET nguoi_nhan=nv.manv,ten_nguoi_nhan=nv.tennv,trang_thai='ASSIGNED' FROM tbl_task t JOIN tbl_nhan_vien nv ON nv.manv=@manv_nhan WHERE t.id_task=@id_task;
 MERGE tbl_task_thanh_vien AS tg USING (SELECT @id_task id_task,@manv_nhan manv) s ON tg.id_task=s.id_task AND tg.manv=s.manv AND tg.vai_tro='OWNER'
 WHEN MATCHED THEN UPDATE SET tg.ngay_tao=GETDATE()
 WHEN NOT MATCHED THEN INSERT(id_task,manv,tennv,vai_tro) SELECT @id_task,nv.manv,nv.tennv,'OWNER' FROM tbl_nhan_vien nv WHERE nv.manv=@manv_nhan;
 INSERT INTO tbl_task_log(id_task,hanh_dong,trang_thai_moi,nguoi_thuc_hien,ten_nguoi_thuc_hien) VALUES(@id_task,'ASSIGN_EMPLOYEE','ASSIGNED',@manv_th,@tennv_th);
END
GO
CREATE PROC sp_task_employee_accept @id_task INT,@manv VARCHAR(10),@tennv NVARCHAR(100) AS BEGIN UPDATE tbl_task SET trang_thai='IN_PROGRESS',ngay_bat_dau=ISNULL(ngay_bat_dau,GETDATE()) WHERE id_task=@id_task; INSERT INTO tbl_task_log(id_task,hanh_dong,trang_thai_moi,nguoi_thuc_hien,ten_nguoi_thuc_hien) VALUES(@id_task,'EMPLOYEE_ACCEPT','IN_PROGRESS',@manv,@tennv); END
GO
CREATE PROC sp_task_update_progress @id_task INT,@tien_do INT,@noi_dung NVARCHAR(MAX),@manv VARCHAR(10),@tennv NVARCHAR(100) AS BEGIN INSERT INTO tbl_task_tien_do(id_task,tien_do,noi_dung_cap_nhat,nguoi_cap_nhat,ten_nguoi_cap_nhat) VALUES(@id_task,@tien_do,@noi_dung,@manv,@tennv); UPDATE tbl_task SET tien_do=@tien_do,trang_thai=CASE WHEN @tien_do>0 THEN 'IN_PROGRESS' ELSE trang_thai END WHERE id_task=@id_task; INSERT INTO tbl_task_log(id_task,hanh_dong,trang_thai_moi,nguoi_thuc_hien,ten_nguoi_thuc_hien,tien_do,ghi_chu) VALUES(@id_task,'UPDATE_PROGRESS','IN_PROGRESS',@manv,@tennv,@tien_do,@noi_dung); END
GO
CREATE PROC sp_task_submit_review @id_task INT,@manv VARCHAR(10),@tennv NVARCHAR(100),@ghi_chu NVARCHAR(MAX)=NULL AS BEGIN UPDATE tbl_task SET tien_do=100,trang_thai='WAITING_REVIEW' WHERE id_task=@id_task; INSERT INTO tbl_task_log(id_task,hanh_dong,trang_thai_moi,nguoi_thuc_hien,ten_nguoi_thuc_hien,ghi_chu,tien_do) VALUES(@id_task,'SUBMIT_REVIEW','WAITING_REVIEW',@manv,@tennv,@ghi_chu,100); END
GO
CREATE PROC sp_task_approve_complete @id_task INT,@danh_gia_chat_luong VARCHAR(50),@nhan_xet_quan_ly NVARCHAR(MAX),@manv VARCHAR(10),@tennv NVARCHAR(100) AS
BEGIN
 DECLARE @han DATETIME,@kpi DECIMAL(18,2),@hs_tg DECIMAL(18,2),@hs_cl DECIMAL(18,2),@now DATETIME=GETDATE();
 SELECT @han=han_hoan_thanh,@kpi=diem_kpi_goc FROM tbl_task WHERE id_task=@id_task;
 SET @hs_tg=CASE WHEN @now<@han THEN 1.10 WHEN @now<=@han THEN 1.00 WHEN DATEDIFF(DAY,@han,@now) BETWEEN 1 AND 2 THEN 0.80 ELSE 0.50 END;
 SET @hs_cl=CASE UPPER(@danh_gia_chat_luong) WHEN 'EXCELLENT' THEN 1.20 WHEN 'GOOD' THEN 1.00 WHEN 'NORMAL' THEN 0.80 WHEN 'BAD' THEN 0.50 ELSE 0.00 END;
 UPDATE tbl_task SET danh_gia_chat_luong=@danh_gia_chat_luong,nhan_xet_quan_ly=@nhan_xet_quan_ly,ngay_hoan_thanh=@now,he_so_thoi_gian=@hs_tg,he_so_chat_luong=@hs_cl,diem_kpi_thuc_te=@kpi*@hs_tg*@hs_cl,trang_thai='COMPLETED' WHERE id_task=@id_task;
 INSERT INTO tbl_task_log(id_task,hanh_dong,trang_thai_moi,nguoi_thuc_hien,ten_nguoi_thuc_hien,ghi_chu) VALUES(@id_task,'APPROVE_COMPLETE','COMPLETED',@manv,@tennv,@nhan_xet_quan_ly);
END
GO
CREATE PROC sp_task_return @id_task INT,@ly_do NVARCHAR(MAX),@manv VARCHAR(10),@tennv NVARCHAR(100) AS BEGIN UPDATE tbl_task SET so_lan_tra_lai=so_lan_tra_lai+1,trang_thai='RETURNED' WHERE id_task=@id_task; INSERT INTO tbl_task_log(id_task,hanh_dong,trang_thai_moi,nguoi_thuc_hien,ten_nguoi_thuc_hien,ghi_chu) VALUES(@id_task,'RETURN_TASK','RETURNED',@manv,@tennv,@ly_do); END
GO
CREATE PROC sp_task_cancel @id_task INT,@ly_do NVARCHAR(MAX),@manv VARCHAR(10),@tennv NVARCHAR(100) AS BEGIN UPDATE tbl_task SET trang_thai='CANCELLED' WHERE id_task=@id_task; INSERT INTO tbl_task_log(id_task,hanh_dong,trang_thai_moi,nguoi_thuc_hien,ten_nguoi_thuc_hien,ghi_chu) VALUES(@id_task,'CANCEL_TASK','CANCELLED',@manv,@tennv,@ly_do); END
GO
CREATE PROC sp_task_insert_file @id_task INT,@ten_file_goc NVARCHAR(255),@ten_file_luu NVARCHAR(255),@duong_dan_file NVARCHAR(500),@dung_luong BIGINT,@loai_file VARCHAR(100),@nguoi_upload VARCHAR(10),@ten_nguoi_upload NVARCHAR(100) AS BEGIN INSERT INTO tbl_task_file(id_task,ten_file_goc,ten_file_luu,duong_dan_file,dung_luong,loai_file,nguoi_upload,ten_nguoi_upload) VALUES(@id_task,@ten_file_goc,@ten_file_luu,@duong_dan_file,@dung_luong,@loai_file,@nguoi_upload,@ten_nguoi_upload); INSERT INTO tbl_task_log(id_task,hanh_dong,nguoi_thuc_hien,ten_nguoi_thuc_hien,ghi_chu) VALUES(@id_task,'UPLOAD_FILE',@nguoi_upload,@ten_nguoi_upload,@ten_file_goc); END
GO
CREATE PROC sp_task_delete_file @id_file INT,@manv VARCHAR(10),@tennv NVARCHAR(100) AS BEGIN DECLARE @id_task INT,@ten NVARCHAR(255); SELECT @id_task=id_task,@ten=ten_file_goc FROM tbl_task_file WHERE id_file=@id_file; UPDATE tbl_task_file SET is_deleted=1 WHERE id_file=@id_file; INSERT INTO tbl_task_log(id_task,hanh_dong,nguoi_thuc_hien,ten_nguoi_thuc_hien,ghi_chu) VALUES(@id_task,'DELETE_FILE',@manv,@tennv,@ten); END
GO
CREATE PROC sp_task_dashboard_summary @thang INT,@nam INT AS BEGIN SELECT COUNT(*) tong_task,SUM(CASE WHEN trang_thai='IN_PROGRESS' THEN 1 ELSE 0 END) dang_xu_ly,SUM(CASE WHEN trang_thai='WAITING_REVIEW' THEN 1 ELSE 0 END) cho_duyet,SUM(CASE WHEN trang_thai='COMPLETED' THEN 1 ELSE 0 END) hoan_thanh,SUM(CASE WHEN han_hoan_thanh<GETDATE() AND trang_thai NOT IN ('COMPLETED','CANCELLED') THEN 1 ELSE 0 END) tre_han,SUM(CASE WHEN MONTH(ngay_hoan_thanh)=@thang AND YEAR(ngay_hoan_thanh)=@nam THEN diem_kpi_thuc_te ELSE 0 END) tong_kpi_thang FROM tbl_task; END
GO
CREATE PROC sp_task_kpi_monthly_report @thang INT,@nam INT AS BEGIN SELECT nv.manv,nv.tennv,pb.ten_pb,COUNT(t.id_task) tong_task,SUM(CASE WHEN t.trang_thai='COMPLETED' THEN 1 ELSE 0 END) task_hoan_thanh,SUM(CASE WHEN t.trang_thai='COMPLETED' AND t.ngay_hoan_thanh<=t.han_hoan_thanh THEN 1 ELSE 0 END) dung_han,SUM(CASE WHEN t.trang_thai='COMPLETED' AND t.ngay_hoan_thanh>t.han_hoan_thanh THEN 1 ELSE 0 END) tre_han,SUM(ISNULL(t.diem_kpi_thuc_te,0)) tong_kpi FROM tbl_nhan_vien nv LEFT JOIN tbl_phong_ban pb ON nv.nhomquyen=pb.id_pb LEFT JOIN tbl_task t ON nv.manv=t.nguoi_nhan AND MONTH(t.ngay_giao)=@thang AND YEAR(t.ngay_giao)=@nam GROUP BY nv.manv,nv.tennv,pb.ten_pb ORDER BY pb.ten_pb,nv.tennv; END
GO
