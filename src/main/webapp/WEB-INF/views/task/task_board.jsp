<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html><html><head><title>Kanban Task</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/assets/css/task.css"></head><body>
<div class="container-fluid"><h3>Bảng Kanban công việc</h3>
<div class="row kpi-box"><div class="col-sm-2">Tổng task: <span id="kpi-total">0</span></div><div class="col-sm-2">Đang xử lý: <span id="kpi-progress">0</span></div></div>
<div class="row"><div class="col-md-3"><div class="kanban-column" data-status="NEW"><h4>Mới giao</h4><div class="task-list"></div></div></div>
<div class="col-md-3"><div class="kanban-column" data-status="WAITING_DEPARTMENT_ACCEPT"><h4>Chờ bộ phận</h4><div class="task-list"></div></div></div>
<div class="col-md-3"><div class="kanban-column" data-status="IN_PROGRESS"><h4>Đang xử lý</h4><div class="task-list"></div></div></div>
<div class="col-md-3"><div class="kanban-column" data-status="WAITING_REVIEW"><h4>Chờ duyệt</h4><div class="task-list"></div></div></div></div>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script><script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.2/Sortable.min.js"></script>
<script src="/assets/js/task-board.js"></script></body></html>
