<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html><html><head><title>Chi tiết task</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css"></head><body>
<div class="container"><h3>Chi tiết task</h3>
<ul class="nav nav-tabs"><li class="active"><a data-toggle="tab" href="#info">Thông tin</a></li><li><a data-toggle="tab" href="#progress">Tiến độ</a></li><li><a data-toggle="tab" href="#comment">Bình luận</a></li><li><a data-toggle="tab" href="#file">File đính kèm</a></li><li><a data-toggle="tab" href="#kpi">KPI</a></li></ul>
<div class="tab-content"><div id="info" class="tab-pane fade in active">...</div><div id="progress" class="tab-pane fade">...</div><div id="comment" class="tab-pane fade">...</div><div id="file" class="tab-pane fade"><form method="post" action="/task/file/upload" enctype="multipart/form-data"><input type="file" name="files" multiple><button class="btn btn-sm btn-primary">Upload</button></form></div><div id="kpi" class="tab-pane fade">...</div></div>
</div><script src="https://code.jquery.com/jquery-3.7.1.min.js"></script><script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script></body></html>
