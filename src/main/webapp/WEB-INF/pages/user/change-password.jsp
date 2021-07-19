<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Change Password</title>
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
                        <h3 class="toast__title">
                            Success
                        </h3>
                        <p class="toast__msg">
                                ${message}
                        </p>
                    </div>
                </div>
            </c:if>

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
                        Email or password is not correct , Please login again!
                    </p>
                </div>
            </div>
        </c:if>
    </div>
    <div class="login-container__form">
        <div class="banner-form">
            <div class="slide-banner">
                <div id="demo" class="carousel slide" data-ride="carousel">

                    <!-- Indicators -->
                    <ul class="carousel-indicators">
                        <li data-target="#demo" data-slide-to="0" class="active"></li>
                        <li data-target="#demo" data-slide-to="1"></li>
                        <li data-target="#demo" data-slide-to="2"></li>
                    </ul>

                    <!-- The slideshow -->
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img class="slide-img_banner"src="<c:url value="/resources/images/slides/slideshow_5.png"/>" alt="">
                        </div>
                        <div class="carousel-item">
                            <img class="slide-img_banner" src="<c:url value="/resources/images/slides/slideshow_15.png"/>" alt="">
                        </div>
                        <div class="carousel-item">
                            <img class="slide-img_banner" src="<c:url value="/resources/images/slides/slideshow_6.png"/>" alt="">
                        </div>
                    </div>

                    <!-- Left and right controls -->
                    <a class="carousel-control-prev" data-slide="prev" href="#demo">
                        <span class="carousel-control-prev-icon"></span>
                    </a>
                    <a class="carousel-control-next" data-slide="next" href="#demo">
                        <span class="carousel-control-next-icon"></span>
                    </a>
                </div>
            </div>
        </div>
        <div class="auth-form">
            <div class="form-heading">
                <span class="form-tile__register">Confirm Password</span>
            </div>
            <form:form action="${pageContext.request.contextPath}/change-password" method="post" modelAttribute="user">
                <div class="form-group">
                    <div class="form-input">
                        <input type="text" name="email" value="${user.email}" class="input-control__login" placeholder=" " required>
                        <label  class="form__label">Email</label>
                        <i class="far fa-envelope input-icon-email"></i>
                    </div>
                    <div class="form-input">
                        <input type="password" name="password" class="input-control__login " id="password" placeholder=" " required>
                        <label  class="form__label">Password</label>
                        <i class="input-icon__password fas fa-unlock-alt "></i>
                    </div>
                    <div class="form-input">
                        <input type="password"  class="input-control__login " id="confirm_password" placeholder=" " required>
                        <label  class="form__label">Confirm Password</label>
                        <i class="input-icon__password fas fa-unlock-alt "></i>
                        <span id='messagePass'></span>
                    </div>
                    <input type="hidden" value="${user.id}" name="id" >
                    <input type="hidden" value="${user.fullName}" name="fullName">
                    <input type="hidden" value="${user.phoneNumber}" name="phoneNumber">
                    <input type="hidden" value="${user.address}"name="address" >
                    <input type="hidden" value="${user.birthDate}" name="birthDate">
                    <input type="hidden" value="${user.brandLogo}" name="brandLogo">
                </div>
                <c:forEach items="${roles}" var="role">
                    <%String check = "" ;%>
                    <c:forEach items="${user.getUserRoles()}" var="roleUser" >
                        <c:if test="${roleUser.id == role.id}" >
                            <% check = "checked" ;%>
                        </c:if>

                    </c:forEach>
                    <c:if test="${role.id == 1}">
                       <label hidden="" >
                           <input type="checkbox" checked="true" name=" " disabled="">
                           <input type="checkbox" <%=check%> name="role" value="${role.id}" hidden="true">
                               ${role.getRole()}
                       </label>
                    </c:if>
                    <c:if test="${role.id != 1}">
                       <label hidden="">
                           <input type="checkbox" <%=check%> name="role" value="${role.id}" >
                               ${role.getRole()}
                       </label>
                    </c:if>
                </c:forEach>
                <button type="submit" class="form-btn btn-default btn--primary ">Submit</button>
            </form:form>
        </div>
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

</script>
</body>
</html>
