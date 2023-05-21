<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER MODIFY" />
<%@ include file="../common/head.jspf"%>

<script type="text/javascript">
	let MemberModify__submitFormDone = false;

	function MemberModify__submit(form) {
		if (MemberModify__submitFormDone) {
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length > 0) {
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();

			if (form.loginPwConfirm.value.length == 0) {
				alert('비밀번호 확인을 입력해주세요');
				form.loginPwConfirm.focus();
				return;
			}

			if (form.loginPw.value != form.loginPwConfirm.value) {
				alert('비밀번호가 일치하지 않습니다');
				form.loginPw.value = "";
				form.loginPwConfirm.value = "";
				form.loginPw.focus();
				return;
			}
		}

		form.name.value = form.name.value.trim();
		form.nickname.value = form.nickname.value.trim();
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		form.email.value = form.email.value.trim();

		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요');
			form.name.focus();
		}

		if (form.email.value.length == 0) {
			alert('email을 입력해주세요');
			form.email.focus();
		}

		MemberModify__submitFormDone = true;
		form.submit();

	}
</script>
<hr />
<div class="container">
	<div class="modifyMember">
		<h1>회원정보 수정</h1>
		<form action="../member/doModify" method="POST"
			onsubmit="MemberModify__submit(this); return false;">
			<table class="w-100p" border="1">
				<colgroup>
					<col width="40%" />
					<col width="60%" />
				</colgroup>
				<tbody>
					<tr>
						<th>새 비밀번호</th>
						<td><input name="loginPw" type="text" placeholder="새 비밀번호를 입력하세요" />
						</td>
					</tr>
					<tr>
						<th>새 비밀번호 확인</th>
						<td><input name="loginPwConfirm" type="text"
							placeholder="새 비밀번호를 입력하세요" /></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input required type="text" name="name"
							value="${rq.getLoginedMember().name }" /></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input required type="text" name="email"
							value="${rq.getLoginedMember().email }" /></td>
					</tr>
					<tr>
						<th></th>
						<td class="flex-jc-c"><button class="btn" type="submit">수정</button></td>
					</tr>
				</tbody>
			</table>
		</form>
		<button class="btn" type="button" onclick="history.back()">뒤로가기</button>
	</div>
</div>
<%@ include file="../common/foot.jspf"%>