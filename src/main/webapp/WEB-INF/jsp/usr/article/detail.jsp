<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Article Detail" />
<%@ include file="../common/head.jspf"%>

<script>
	let ReplyWrite__submitFormDone = false;

	function ReplyWrite__submitForm(form) {
		if (ReplyWrite__submitFormDone) {
			return;
		}
		form.body.value = form.body.value.trim();

		if (form.body.value.length < 2) {
			alert('2글자 이상 입력');
			form.body.focus();
			return;
		}

		ReplyWrite__submitFormDone = true;
		form.submit();
	}
</script>

<div class="container">
	<div class="detail">
		<h1>상세보기</h1>
		<table class="w-100p" border="1">
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
			<tbody>
				<tr>
					<th>번호</th>
					<td>${article.id}</td>
				</tr>
				<tr>
					<th>작성 날짜</th>
					<td>${article.regDate}</td>
				</tr>
				<tr>
					<th>수정 날짜</th>
					<td>${article.updateDate}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${article.extra__writer}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${article.title }</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${article.body }</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="detail_btn">
		<c:if test="${article.actorCanModify}">
			<a class="btn" href="../article/modify?id=${article.id }">수정</a>
		</c:if>
		<c:if test="${article.actorCanDelete}">
			<a class="btn" href="../article/doDelete?id=${article.id }"
				onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a>
		</c:if>
		<button class="btn" type="button" onclick="history.back();">뒤로가기</button>
	</div>
</div>

<div class="container">
	<div class="reply_write">
		<c:if test="${rq.logined}">
			<form action="../reply/doWrite" method="POST"
				onsubmit="ReplyWrite__submitForm(this); return false;">
				<table class="w-100p" border="1">
					<input type="hidden" name="relTypeCode" value="article" />
					<input type="hidden" name="relId" value="${article.id}" />
					<input type="hidden" name="relId" value="${rq.currentUri}" />
					<colgroup>
						<col width="20%" />
						<col width="75%" />
						<col width="5%" />
					</colgroup>
					<tbody>
						<tr>
							<th>댓글</th>
							<td><textarea name="body"
									style="width: 99%; resize: none; text-align: left; font-size: 1rem;"></textarea></td>
							<td>
								<button class="btn" type="submit">등록</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</c:if>
		<c:if test="${!rq.logined}">
			<a href="../member/login" class="my_btn">로그인</a> 후 이용
		</c:if>
	</div>
	<div class="reply_list">
		<h2 class="">Reply(${repliesCount })</h2>
		<table class="w-100p">
			<colgroup>
				<col width="5%" />
				<col width="15%" />
				<col width="10%" />
				<col width="60%" />
				<col width="5%" />
				<col width="5%" />
			</colgroup>
			<thead>
				<tr style="font-size: 1.2rem;">
					<th>번호</th>
					<th>날짜</th>
					<th>작성자</th>
					<th>내용</th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="reply" items="${replies}" varStatus="loop">
					<tr class="">
						<td>
							<div class="">${reply.id}</div>
						</td>
						<td>${reply.regDate.substring(2, 16) }</td>
						<td>${reply.extra__writer}</td>
						<td class="">${reply.body}</td>
						<td class=""><c:if test="${reply.actorCanModify}">
								<a class="" href="../reply/modify?id=${reply.id}&replaceUri=${rq.encodedCurrentUri}">
									<i class="fa-solid fa-pen-to-square" style="color: #000000;"></i>
								</a>
							</c:if></td>
						<td class="reply_"><c:if test="${reply.actorCanDelete}">
								<a class="" href="../reply/delete?id=${reply.id}"
									onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;">
									<i class="fa-solid fa-trash-can" style="color: #000000;"></i>
								</a>
							</c:if></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<%@ include file="../common/foot.jspf"%>