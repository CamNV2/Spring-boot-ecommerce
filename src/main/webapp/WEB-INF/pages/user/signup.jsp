<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SignUp</title>
    <jsp:include page="include/css.jsp" />
</head>
<body>
<header class="header-login">
    <div class="header-login-item">
        <div class="header__logo">
            <a href="/home">
                <img src="<c:url value="/resources/images/logo.svg"/>" class="header-logo" alt="">
            </a>
        </div>
        <div class="header__text">
            <a href="#" class="header__text-link">Cần trợ giúp ?</a>
        </div>
    </div>
</header>
<div class="login-container">
    <div id="toasts">
        <c:if test="${message != null && message != ''}">
            <c:if test="${type != null && type != '' && type == 'success'}">
                <div class="toasts toast--success  ">
                    <div class="toast__icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="toast__body">
                        <h3 class="toast__title ">
                            Success
                        </h3>
                        <p class="toast__msg">
                            ${message}
                        </p>
                    </div>
                </div>
            </c:if>
            <c:if test="${type != null && type != '' && type == 'fail'}" >
                <div class="toasts toast--error  ">
                    <div class="toast__icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="toast__body">
                        <h3 class="toast__title">
                            Error
                        </h3>
                        <p class="toast__msg">
                           ${message}
                        </p>
                    </div>
                </div>
            </c:if>
            <c:if test="${error == 'true'}" >
                <div class="toasts toast--error  ">
                    <div class="toast__icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="toast__body">
                        <h3 class="toast__title">
                            Error
                        </h3>
                        <p class="toast__msg">
                            Mật khẩu hoặc email không đúng, vui lòng thử lại
                        </p>
                    </div>
                </div>
            </c:if>
        </c:if>
    </div>
    <div class="register-container__form">
        <form:form action="/signup"  modelAttribute="signup"  method="post" enctype="multipart/form-data" >
            <div class="register-form">
                <div class="form-item">
                    <div class="form-heading__register">
                        <span class="form-tile__register">Sign Up</span>
                    </div>
                    <div class="form-group">
                        <div class="form-input">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="fullName" class="input-control" placeholder="Enter FullName">
                        </div>
                        <div class="form-input">
                            <label class="form-label">Email</label>
                            <input type="text" name="email" class="input-control" placeholder="Enter email">
                        </div>
                        <div class="form-input">
                            <label class="form-label">Password</label>
                            <input type="password"  name="password"  id="password" class="input-control" placeholder="Enter password" minlength="8" required>
                        </div>
                        <div class="form-input">
                            <label class="form-label">Confirm Password</label>
                            <input type="password"   id="confirm_password" class="input-control" placeholder="Enter Confirm password" minlength="8" required>
                            <span id='messagePass'></span>
                        </div>
                        <div class="form-input">
                            <label class="form-label">Address</label>
                            <input type="text" name=address class="input-control" placeholder="Enter Address">
                        </div>
                        <div class="form-input">
                            <label class="form-label">Birthday</label>
                            <input type="date" name="birthDate" class="input-control" placeholder="Enter Birthday">
                        </div>
                        <div class="form-input">
                            <label class="form-label">Phone Number</label>
                            <input type="text" name="phoneNumber" class="input-control" placeholder="Enter Phone Number" maxlength="13">
                        </div>
                        <c:forEach var="role" items="${roles}">
                            <div class="col-lg-6">
                                <c:if test="${role.getRole() == 'ROLE_USER'}">
                                    <div class="checkbox">
                                        <label hidden="">
                                            <input type="checkbox" checked="true" name="role" value="${role.id}" hidden="true">
                                                ${role.getRole()}
                                        </label>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                        <button type="submit" class="form-btn btn-default btn--primary ">Sign Up</button>
                    </div>
                </div>
                <div class="form-logo">
                    <div class="heading-logo">Avatar</div>
                    <div class="img-thumb">
                        <img id="thumbnail"  class="review-img" >
                    </div>
                    <div class="img-file">
                        <input type="file" class="input-img" name="brand_Logo" id="fileImage"
                               accept="image/png , image/jpg"/>
                    </div>
                </div>

        </di>
    </div>

        </form:form>

</div>
</div>
<jsp:include page="include/footer.jsp" />
<jsp:include page="include/js.jsp" />
    <script type="text/javascript">
        $('#password, #confirm_password').on('keyup', function () {
            if ($('#password').val() == $('#confirm_password').val()) {
                $('#messagePass').html('(*) Matching').css('color', 'green');
            } else
                $('#messagePass').html('(*) Not Matching').css('color', 'red');
        });
        $(document).ready(function () {
            $('#fileImage').change(function () {
                showThumbnailImage(this);
            })
        });

        function showThumbnailImage(fileInput) {
            file = fileInput.files[0];
            reader = new FileReader();

            reader.onload = function (e) {
                $('#thumbnail').attr('src', e.target.result);
            };
            reader.readAsDataURL(file);
        }
    </script>
</body>
</html>
