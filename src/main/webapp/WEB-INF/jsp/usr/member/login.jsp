<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER LOGIN" />
<%@ include file="../common/head.jspf"%>

<div class="container">
	<div class="login">
		<h1>로그인</h1>
		<form action="../member/doLogin" method="POST">
			<table class="w-100p" border="1">
				<colgroup>
					<col width="20%" />
					<col width="80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>이메일</th>
						<td><input autocomplete="off" autofocus type="email" name="email" />
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="loginPw" /></td>
					</tr>
					<tr>
						<th></th>
						<td class="flex-jc-c">
							<button class="btn" type="submit">로그인</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="flex-jc-e">
			<button class="btn" type="button" onclick="history.back()">뒤로가기</button>
		</div>
	</div>
</div>
<%@ include file="../common/foot.jspf"%>