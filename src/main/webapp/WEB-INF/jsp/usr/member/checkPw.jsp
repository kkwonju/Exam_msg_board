<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER CheckPw" />
<%@ include file="../common/head.jspf"%>

<script type="text/javascript">
	let CheckPw__submitFormDone = false;

	function CheckPw__submit(form) {
		if (CheckPw__submitFormDone) {
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();
		
		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력하세요');
			form.loginPw.focus();
			return;
		}

		CheckPw__submitFormDone = true;
		form.submit();
	}
</script>

<hr />
	<div class="container">
		<div class="checkPw">
			<form action="../member/doCheckPw" method="POST" onsubmit="CheckPw__submit(this); return false;")>
			<input type="hidden" name="replaceUri" value="${param.replaceUri }" />
				<table class="w-100p" border="1">
					<colgroup>
						<col width="40%" />
						<col width="60%" />
					</colgroup>
					<tbody>
						<tr>
							<th>비밀번호</th>
							<td><input required type="password" name="loginPw" placeholder="비밀번호를 입력해주세요"/></td>
						</tr>
						<tr>
							<th></th>
							<td class="flex-jc-c">
								<button class="btn" type="submit">확인</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<button class="btn" type="button" onclick="history.back()">뒤로가기</button>
		</div>
	</div>
<%@ include file="../common/foot.jspf"%>