<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<form class="d-inline" id="undo-form" action="student/undo.htm" method="post"><button type="button" onclick="if(confirm('Bạn có chắc muốn hoàn tác hành động?')) submitClosestForm(this, () => refreshData())" class="btn btn-outline-primary" ${!canUndo ? 'disabled' : '' }>Undo</button></form>
<form class="d-inline" id="redo-form" action="student/redo.htm" method="post"><button type="button" onclick="if(confirm('Bạn có chắc muốn hủy hoàn tác hành động?')) submitClosestForm(this, () => refreshData())" class="btn btn-outline-primary" ${!canRedo ? 'disabled' : '' }>Redo</button></form>
