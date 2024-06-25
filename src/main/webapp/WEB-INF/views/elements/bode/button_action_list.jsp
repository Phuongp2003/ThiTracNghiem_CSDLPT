<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<form class="d-inline" action="bode/undo.htm" method="post" onsubmit="return confirm('Bạn có chắc muốn hoàn tác hành động?')" target="formSubmitFrame"><button type="submit" class="btn btn-outline-primary" ${!canUndo ? 'disabled' : '' }>Undo</button></form>
<form class="d-inline" action="bode/redo.htm" method="post" onsubmit="return confirm('Bạn có chắc muốn hủy hoàn tác hành động?')" target="formSubmitFrame"><button type="submit" class="btn btn-outline-primary" ${!canRedo ? 'disabled' : '' }>Redo</button></form>
