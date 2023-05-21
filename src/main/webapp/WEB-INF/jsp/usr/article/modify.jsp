<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE MODIFY" />
<%@ include file="../common/head.jspf"%>

<script type="text/javascript">
	let ArticleModify__submitFormDone = false;

	function ArticleModify__submit(form) {
		if (ArticleModify__submitFormDone) {
			return;
		}
		form.title.value = form.title.value.trim();
		form.body.value = form.body.value.trim();
		
		if (form.title.value.length < 1) {
			alert('제목 1글자 이상 입력');
			form.title.focus();
			return;
		}
		
		if (form.body.value.length < 1) {
			alert('내용 1글자 이상 입력');
			form.body.focus();
			return;
		}

		ArticleModify__submitFormDone = true;
		form.submit();
	}
</script>

<div class="container">
	<div class="modifyArticle">
		<h1>게시글 수정</h1>
		<form action="../article/doModify" method="POST"
			onsubmit="ArticleModify__submit(form); return false;'">
			<table class="w-100p" border="1">
				<colgroup>
					<col width="200" />
				</colgroup>
				<tbody>

					<input type="hidden" name="id" value="${article.id }" />
					<tr>
						<th>번호</th>
						<td>${article.id }</td>
					</tr>
					<tr>
						<th>작성 날짜</th>
						<td>${article.regDate }</td>
					</tr>
					<tr>
						<th>수정 날짜</th>
						<td>${article.updateDate }</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${article.extra__writer }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input autofocus autocomplete="off" type="text" name="title"
							value="${article.title}" /></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea style="resize: none;" name="body">${article.body}</textarea></td>
					</tr>
					<tr>
						<th></th>
						<td class="flex-jc-c">
							<button class="btn" type="submit">수정</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<button class="btn" type="button" onclick="history.back()">뒤로가기</button>
	</div>
</div>
<%@ include file="../common/foot.jspf"%>