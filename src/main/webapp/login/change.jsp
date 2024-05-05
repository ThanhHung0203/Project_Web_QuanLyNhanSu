<%@ page import="Model.taikhoan" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>

<head>
	<title>Đổi mật khẩu</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
		  integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
		  crossorigin="anonymous" referrerpolicy="no-referrer" />

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		  integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
		  crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/base.css" />
	<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/css/favicon.ico">
    <meta http-equiv="Content-Security-Policy" content="default-src 'none'; script-src 'self' https://cdnjs.cloudflare.com; style-src 'self' https://stackpath.bootstrapcdn.com https://fonts.googleapis.com https://cdnjs.cloudflare.com; font-src 'self' https://fonts.gstatic.com https://cdnjs.cloudflare.com; connect-src 'self'; img-src 'self' https://www.evn.com.vn/userfile/VH/User/huyent_tcdl/images/2021/6/hrmscuatapdoan24621(1).jpeg; form-action 'self';">
</head>
<body>
<%taikhoan username = (taikhoan) session.getAttribute("user"); %>
<%if (username != null) {%>
<jsp:forward page="/trangchu"></jsp:forward>
<%} else {%>
<div class="container">
	<div class="image">
		<img src="https://www.evn.com.vn/userfile/VH/User/huyent_tcdl/images/2021/6/hrmscuatapdoan24621(1).jpeg" style="width:700px;height:460px;">
	</div>
	<div class="form">
		<form action="<%=request.getContextPath()%>/change_post" method="POST">
			<h1>ĐỔI MẬT KHẨU</h1>
			<div class="input-box">
				<div class = "box_icon_login"><i class="fa-solid fa-user fa-2xl"></i></div>
				<input type="text" name="username" id="username" placeholder="Tài khoản" maxlength="30" required title="Tài khoản gồm ký tự thường, hoa, số và không quá 30 ký tự">
			</div>
			<div class="input-box">
				<div class = "box_icon_login"><i class="fa-solid fa-lock fa-2xl"></i></div>
				<input type="password" name="oldpassword" id="oldpassword" placeholder="Mật khẩu cũ" maxlength="30" required>
			</div>
			<div class="input-box">
				<div class = "box_icon_login"><i class="fa-solid fa-lock-open fa-2xl"></i></div>
				<input type="password" name="newpassword" id = "newpassword" placeholder="Mật khẩu mới" maxlength="30" required>
			</div>
			<div class="input-box">
				<div class = "box_icon_login"><i class="fa-solid fa-lock-open fa-2xl"></i></div>
				<input type="password" name="confirmnewpass" id="confirmnewpass" placeholder="Nhập lại mật khẩu" maxlength="30" required>
			</div>
			<input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") %>">
			<div class="error_mess" style="color:red;">
				<%String errorMsg = (String) request.getAttribute("error"); %>
				<%if (errorMsg != null) { %>
				<p><%=errorMsg %></p>
				<%} %>
			</div>
			<div class="box_show">
				<input type="checkbox" onclick="showpass()"><i>Show pass</i>
			</div>

			<div class = "box_button_login"><button type="submit" class="btn"><b>Xác nhận</b></button></div>

		</form>
	</div>
</div>
<script>
	function showpass() {
		var x = document.getElementById("oldpassword");
		var y = document.getElementById("newpassword");
		var z = document.getElementById("confirmnewpass");

		if (x.type === "password") {
			x.type = "text";
			y.type = "text";
			z.type = "text";
		} else {
			x.type = "password";
			y.type = "password";
			z.type = "password";
		}
	}
	window.onload = function() {
		// Lấy tất cả các input trừ input mật khẩu
		var inputs = document.querySelectorAll('input:not([type="password"])');

		// Duyệt qua từng input (trừ password) và thêm sự kiện 'input' để kiểm tra giá trị
		inputs.forEach(function(input) {
			input.addEventListener('input', function() {
				// Kiểm tra nếu giá trị chứa ký tự đặc biệt
				if (/[^a-zA-Z0-9\s]/.test(input.value)) {
					// Nếu có, loại bỏ ký tự đặc biệt đó
					input.value = input.value.replace(/[^a-zA-Z0-9\s]/g, '');
				}

				// Kiểm tra giới hạn độ dài tối đa của input
				var maxLength = input.getAttribute('maxlength');
				if (maxLength !== null && input.value.length > maxLength) {
					input.value = input.value.slice(0, maxLength);
				}
			});
		});

		// Lấy input password
		var passwordInput = document.querySelector('input[type="password"]');

		// Thêm sự kiện 'blur' để kiểm tra mật khẩu sau khi người dùng nhập xong
		passwordInput.addEventListener('blur', function() {
			var password = passwordInput.value;

			// Kiểm tra mật khẩu phải chứa ít nhất 8 ký tự, ít nhất 1 chữ hoa, 1 chữ thường, 1 số, và 1 ký tự đặc biệt
			var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

			if (!passwordPattern.test(password)) {
				// Nếu mật khẩu không đáp ứng yêu cầu
				// Báo cho người dùng và xóa tất cả ký tự trong ô input
				passwordInput.setCustomValidity("Mật khẩu phải chứa ít nhất 8 ký tự, 1 chữ hoa, 1 chữ thường, 1 số, và 1 ký tự đặc biệt");
			} else {
				// Nếu mật khẩu đáp ứng yêu cầu, xóa thông báo lỗi
				passwordInput.setCustomValidity('');
			}
		});
	};

</script>
<%}%>
</body>
</html>
