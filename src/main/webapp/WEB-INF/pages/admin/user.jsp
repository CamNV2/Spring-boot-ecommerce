<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manager User</title>
    <jsp:include page="include/css.jsp" />
</head>
<body>
<div id="toasts">
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
    <c:if test="${type != null && type != '' && type == 'error'}">
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
</div>
<div id="wrapper">
    <jsp:include page="include/menu-left.jsp" />
    <div id="content-wrapper" class="d-flex flex-column">
    <div id="content">
        <jsp:include page="include/header.jsp" />
        <div class="container-fluid">
            <div class="heading-container">
                <div class="heading-title">
                    <a href="/admin/user-list" class="home-link">
                        <i class=" fas fa-home"></i>
                    </a>
                    <div class="title-heading">Manager User</div>
                </div>
                <form action="/admin/search-user" method="post">
                    <div class="form-search">
                        <input type="text" name="key" class="input_control" placeholder="search..." value="${key}">
                        <button class="btn_primary btn__default"><i class="fas fa-search"></i></button>
                    </div>
                </form>
            </div>
            <div class="main_container">
                    <div class="title_action add-action">
                        Create User
                    </div>
                <hr class="sidebar-divider my-0">
                <form:form action="/admin/user/add-user" modelAttribute="user"  method="post">
                    <div class="form-custom">
                        <div class="form__item">
                            <div class="form_group">
                                <div class="form_input">
                                    <input type="text" name="fullName"  class="input-control__form" placeholder=" " required>
                                    <label class="form__label">Full Name</label>
                                    <i class="fas fa-file-signature input-icon"></i>
                                </div>
                                <div class="form_input pd-10">
                                    <input type="text" name="email"  class="input-control__form" placeholder=" ">
                                    <label class="form__label">Email</label>
                                    <i class="fas fa-file-signature input-icon"></i>
                                </div>
                                <div class="role-checkbox">
                                    <c:forEach var="role" items="${roles}">
                                        <%String check = "" ;%>
                                        <c:forEach items="${user.getUserRoles()}" var="roleUser" >
                                            <c:if test="${roleUser.id == role.id}" >
                                                <% check = "checked";%>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${role.id == 1}">
                                            <div class="check-box">
                                                <input type="checkbox" checked="true" name=" " disabled="">
                                                <input type="checkbox" <%=check%> name="role" value="${role.id}" hidden="true">
                                                    ${role.getRole()}
                                            </div>
                                        </c:if>
                                        <c:if test="${role.id != 1}">
                                            <div class="check-box">
                                                <input type="checkbox" <%=check%> name="role" value="${role.id}" >
                                                    ${role.getRole()}
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                                <button type="submit" class="form-btn btn btn-primary ">
                                        <span class="action-text">
                                            Create User
                                        </span>
                                </button>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        <jsp:include page="include/footer.jsp" />
    </div>
</div>
<jsp:include page="include/logout-modal.jsp" />
<jsp:include page="include/js.jsp" />

</body>
</html>
