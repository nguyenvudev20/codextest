<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html><html><head><title>Tạo task</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css"></head><body>
<div class="container"><h3>Tạo task mới</h3>
<form method="post" action="/task/create" enctype="multipart/form-data" id="frmTask">
<div class="form-group"><label>Tên task</label><input name="ten_task" class="form-control" required></div>
<div class="form-group"><label>Mô tả</label><textarea name="mo_ta" class="form-control"></textarea></div>
<div class="form-group"><label>Hình thức giao</label><br>
<label><input type="radio" name="hinh_thuc_giao" value="DEPARTMENT" checked> Đề xuất bộ phận</label>
<label><input type="radio" name="hinh_thuc_giao" value="EMPLOYEE"> Chỉ định nhân viên</label></div>
<div id="block-pb" class="form-group"><label>Phòng ban</label><select class="form-control" name="id_pb_de_xuat"></select></div>
<div id="block-nv" class="form-group" style="display:none"><label>Nhân viên</label><select class="form-control" name="nguoi_nhan"></select></div>
<div class="form-group"><label>File đính kèm</label><input type="file" name="files" multiple class="form-control"></div>
<button class="btn btn-primary" type="submit">Gửi task</button>
</form></div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>$(function(){ $('input[name=hinh_thuc_giao]').change(function(){var v=$(this).val(); $('#block-pb').toggle(v==='DEPARTMENT'); $('#block-nv').toggle(v==='EMPLOYEE');});});</script>
</body></html>
