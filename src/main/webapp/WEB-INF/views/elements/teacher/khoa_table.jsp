<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<table class="table khoa-table">
	<thead>
		<tr>
			<th scope="col">Mã khoa</th>
			<th scope="col">Tên khoa</th>
			<th scope="col">Cơ sở</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="k" items="${khoas}">
			<tr class="is-action sl-${k.MAKH} ${(k.MAKH == current ? 'selected' : '')}" onclick="toggleAndLoad('${k.MAKH}')">
				<td>${k.MAKH}</td>
				<td>${k.TENKH}</td>
				<td>${k.MACS}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
 