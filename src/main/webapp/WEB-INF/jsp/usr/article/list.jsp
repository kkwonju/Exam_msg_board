<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../common/head.jspf"%>


<div class="container">
	<div class="list">
		<h1>리스트</h1>
		<table class="w-100p" border="1px">
			<thead>
			<colgroup>
				<col width="5%">
				<col width="15%">
				<col width="60%">
				<col width="20%">
			</colgroup>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>제목</th>
				<th>작성자</th>
			</tr>
			</thead>
			<tbody>
				<c:forEach var="article" items="${articles}">
					<tr>
						<td>${article.id }</td>
						<td>${article.regDate.substring(2, 16) }</td>
						<td><a class="hover:underline" href="detail?id=${article.id }">${article.title }</a>
						</td>
						<td>${article.extra__writer }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${empty articles}">
			<div style="margin-top: 20px; text-align: center;">게시물이 없습니다</div>
		</c:if>
	</div>
</div>
<div class="pagination container">

	<c:set var="paginationLen" value="4" />
	<c:set var="startPage"
		value="${page - paginationLen >= 1 ? page - paginationLen : 1}" />
	<c:set var="endPage"
		value="${page + paginationLen <= totalPage ? page + paginationLen : totalPage}" />

	<c:if test="${page > 1}">
		<a href="list?page=1"> << </a>
	</c:if>
	<c:forEach begin="${startPage}" end="${endPage}" var="i">
			&nbsp;
			<a class="${page == i ? 'red' : ''}" href="list?page=${i}">${i}</a>
			&nbsp;
		</c:forEach>
	<c:if test="${page < totalPage}">
		<a href="list?page=${totalPage}"> >> </a>
	</c:if>
</div>
<%@ include file="../common/foot.jspf"%>