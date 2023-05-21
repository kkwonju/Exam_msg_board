<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE WRITE" />
<%@ include file="../common/head.jspf"%>
<div class="container">
	<div class="write">
		<h1>게시글 작성</h1>
		<form class="w-100p" action="../article/doWrite" method="POST">
			<table class="w-100p" border="1">
				<colgroup>
					<col width="20%" />
					<col width="80%" />
				</colgroup>
				<tbody>
					<input type="hidden" name="memberId" value="${rq.loginedMemberId }" />
					<tr>
						<th>제목</th>
						<td><input style="width: 99%; height: 30px; font-size: 1.2rem;"
							type="text" name="title" /></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea style="resize: none; width: 99%; height: 100px;"
								name="body"></textarea></td>
					</tr>
				</tbody>
			</table>
			<div class="flex-jc-b mt-30">
				<button class="btn" type="button" onclick="history.back();">뒤로가기</button>
				<button class="btn" type="submit">등록</button>
			</div>
		</form>
	</div>
</div>
<%@ include file="../common/foot.jspf"%>