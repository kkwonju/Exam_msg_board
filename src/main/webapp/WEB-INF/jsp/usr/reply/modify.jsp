<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE MODIFY" />
<%@ include file="../common/head.jspf"%>

<script type="text/javascript">
	let ReplyModify__submitFormDone = false;

	function ReplyModify__submit(form) {
		if (ReplyModify__submitFormDone) {
			return;
		}

		form.body.value = form.body.value.trim();

		if (form.body.value.length < 2) {
			alert('내용 2글자 이상 입력');
			form.body.focus();
			return;
		}

		ReplyModify__submitFormDone = true;
		form.submit();
	}
</script>

<div class="container">
	<div class="reply_modify">
		<form action="../reply/doModify" method="POST"
			onsubmit="ReplyModify__submit(this); return false;">
			<input type="hidden" name="id" value="${reply.id }" />
			<table class="w-100p" border="1">
				<colgroup>
					<col width="200" />
				</colgroup>

				<tbody>
					<tr>
						<th>게시물 번호</th>
						<td>
							<div class="badge">${article.id}</div>
						</td>
					</tr>
					<tr>
						<th>게시물 제목</th>
						<td>
							<div class="badge">${article.title}</div>
						</td>
					</tr>
					<tr>
						<th>게시물 내용</th>
						<td>
							<div class="badge">${article.body}</div>
						</td>
					</tr>
					<tr>
						<th>댓글 번호</th>
						<td>
							<div class="badge">${reply.id}</div>
						</td>
					</tr>
					<tr>
						<th>댓글 작성날짜</th>
						<td>${reply.regDate }</td>
					</tr>
					<tr>
						<th>댓글 작성자</th>
						<td>${reply.extra__writer }</td>
					</tr>
					<tr>
						<th>댓글 내용</th>
						<td><textarea style="resize: none; width: 100%; font-size: 1.1rem;"
								type="text" name="body" placeholder="내용을 입력해주세요" />${reply.body }</textarea></td>
					</tr>
					<tr>
						<th></th>
						<td class="flex-jc-c">
							<button class="btn" type="submit"/> 수정
							</button>
						</td>
					</tr>
				</tbody>

			</table>
		</form>
	</div>
	<div class="btns">
		<button class="btn" type="button"
			onclick="history.back();">뒤로가기</button>
	</div>
</div>

<%@ include file="../common/foot.jspf"%>