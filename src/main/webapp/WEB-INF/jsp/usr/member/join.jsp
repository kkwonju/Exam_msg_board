<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER SIGN UP" />
<%@ include file="../common/head.jspf"%>

<script type="text/javascript">
	let submitJoinFormDone = false;

	function submitJoinForm(form) {
		if (submitJoinFormDone) {
			alert('처리중입니다');
			return;
		}

		form.email.value = form.email.value.trim();
		if (form.email.value == 0) {
			alert('이메일을 입력해주세요');
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value == 0) {
			alert('이름을 입력해주세요');
			return;
		}
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value == 0) {
			alert('비밀번호를 입력해주세요222');
			return;
		}
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value == 0) {
			alert('비밀번호 확인을 입력해주세요');
			return;
		}
		if (form.loginPwConfirm.value != form.loginPw.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.focus();
			return;
		}

		submitJoinFormDone = true;
		form.submit();
	}
</script>
<div class="container">
	<div class="join">
		<form action="/usr/member/doJoin" onsubmit="submitJoinForm(this); return false;" method="POST">
			<h1>회원가입</h1>
			<table class="w-100p" border="1">
				<colgroup>
					<col width="20%" />
					<col width="80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>이름</th>
						<td><input required type="text" name="name" placeholder="이름을 입력하세요" /></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input required type="email" name="email"
							placeholder="이메일을 입력하세요" /></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input required type="password" name="loginPw"
							placeholder="비밀번호를 입력하세요" /></td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td><input required type="password" name="loginPwConfirm"
							placeholder="비밀번호를 입력하세요" /></td>
					</tr>
					<tr>
						<th></th>
						<td><button class="btn" type="submit">가입</button></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<div class="detail_btn">
		<button class="btn" type="button" onclick="history.back();">뒤로가기</button>
	</div>
</div>
<%@ include file="../common/foot.jspf"%>