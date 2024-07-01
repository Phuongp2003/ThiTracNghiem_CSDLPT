<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<form class="d-inline" action="department-class/undo.htm" method="post"><button type="button" class="btn btn-outline-primary" onclick="if (confirm('Bạn có chắc muốn hoàn tác hành động?')) submitClosestForm(this, () => refreshData())" ${!canUndo ? 'disabled' : '' }>Undo</button></form>
<form class="d-inline" action="department-class/redo.htm" method="post" ><button type="button" class="btn btn-outline-primary"onclick="if (confirm('Bạn có chắc muốn hủy hoàn tác hành động?')) submitClosestForm(this, () => refreshData())" ${!canRedo ? 'disabled' : '' }>Redo</button></form>
