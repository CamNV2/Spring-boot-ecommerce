<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Login Pages</title>
    <jsp:include page="user/include/css.jsp" />
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
                <span class="form-tile__register">Sign In</span>
            </div>
            <form action="/j_spring_security_check" method="post">
                <div class="form-group">
                    <div class="form-input">
                        <input type="text" name="email" class="input-control__login" placeholder=" " required>
                        <label  class="form__label">Email</label>
                        <i class="far fa-envelope input-icon-email"></i>
                    </div>
                    <div class="form-input">
                        <input type="password" name="password" class="input-control__login " placeholder=" " required>
                        <label  class="form__label">Password</label>
                        <i class="input-icon__password fas fa-unlock-alt "></i>

                    </div>
                </div>
                <button type="submit" class="form-btn btn-default btn--primary ">Login</button>
            </form>
            <div class="form__text">
                <a href="/forgot-password" class="form-text__link">Forgot password?</a>
                <a href="/signup" class="form-text__link">Sign Up</a>
            </div>
            <div class="form-separation ">
                <p class="separation-text">hoặc</p>
                <span class="separation-border"></span>
            </div>
            <div class="form-social">
                <a href="#" class="form__social--facebook btn-social ">
                    <i class="form__social-icon fab fa-facebook-square"></i>
                    <div class="form__social-title">
                        Facebook
                    </div>
                </a>
                <a href="#" class="form__social--google btn-social ">
                    <img src="<c:url value="/resources/images/google.png"/> " alt="" class="form__social-google">
                    <div class="social-title">
                        Google
                    </div>
                </a>
                <a href="#" class="form__social--apple btn-social ">
                    <i class="form__social-icon fab fa-apple"></i>

                    <div class="social-title">
                        Apple
                    </div>
                </a>
            </div>
        </div>
    </div>

</div>
<jsp:include page="user/include/footer.jsp" />
<jsp:include page="user/include/js.jsp" />
</body>
</html>
