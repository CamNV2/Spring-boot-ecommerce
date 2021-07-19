<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Account</title>
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
        </c:if>
    </div>
    <div class="register-container__form">
        <form:form action="${pageContext.request.contextPath}/result"  modelAttribute="userEntity"  method="post" enctype="multipart/form-data" >
            <div class="register-form">
                <div class="form-item">
                    <div class="form-heading__register">
                        <span class="form-tile__register">Your Info</span>
                    </div>
                    <div class="form-group">
                        <div class="form-input">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="fullName" class="input-control" value="${userEntity.fullName}">
                        </div>
                        <div class="form-input">
                            <label class="form-label">Email</label>
                            <input type="text" name="email" class="input-control" type="hidden" value="${userEntity.email}">
                        </div>

                        <div class="form-input">
                            <label class="form-label">Address</label>
                            <input type="text" name=address class="input-control" value="${userEntity.address}">
                        </div>
                        <div class="form-input">
                            <label class="form-label">Birthday</label>
                            <input type="date" name="birthDate" class="input-control" value="${userEntity.birthDate}">
                        </div>
                        <div class="form-input">
                            <label class="form-label">Phone Number</label>
                            <input  name="phoneNumber" class="input-control"  maxlength="13" value="${userEntity.phoneNumber}">
                        </div>

                        <div class="form-input">
                            <input   name="status"  type="hidden" class="input-control" value="${userEntity.status}">
                        </div>
                        <div class="form-input">
                            <input type="hidden"  name="password"   id="password" class="input-control" value="${userEntity.password}">
                        </div>
                        <div class="form-input">
                            <input type="hidden"  name="brandLogo"    class="input-control" value="${userEntity.brandLogo}">
                        </div>
                        <c:forEach var="role" items="${roles}">
                            <% String check = ""; %>
                            <c:forEach items="${userEntity.getUserRoles()}" var="roleUser">
                                <c:if test="${roleUser.id == role.id}">
                                    <% check = "checked";%>
                                </c:if>
                            </c:forEach>
                            <div>
                                <c:if test="${role.id == 1}">
                                    <div class="checkbox">
                                        <label hidden="">
                                            <input type="checkbox" checked="true" name="" value="" disabled="">
                                            <input type="checkbox" <%=check%> name="role" value="${role.id}" hidden="true">
                                                ${role.getRole()}
                                        </label>
                                    </div>
                                </c:if>
                                <c:if test="${role.id != 1}">
                                    <div class="checkbox">
                                        <label hidden="">
                                            <input type="checkbox" <%=check%> name="role" value="${role.id}">
                                                ${role.getRole()}
                                        </label>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>

                        <c:if test="${action == 'update'}">
                            <input type="hidden" value="update" name="action">
                            <input type="hidden" value="${userEntity.id}" name="id">
                            <button type="submit" class="form-btn btn-default btn--primary ">Update</button>
                        </c:if>

                    </div>
                </div>
                <div class="form-logo">
                    <div class="heading-logo">Avatar</div>
                    <div class="img-thumb">
                        <img id="thumbnail"  class="review-img" src="/resources/images/user/${userEntity.brandLogo}">
                    </div>
                    <div class="img-file">
                        <input type="file"   class="input-img" name="file" id="fileImage" value="${userEntity.brandLogo}"
                               accept="image/png , image/jpg"/>
                    </div>
                </div>

                </di>
            </div>

        </form:form>

    </div>
</div>
<jsp:include page="include/footer.jsp" />
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
