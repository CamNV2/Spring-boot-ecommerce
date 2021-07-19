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
                <div class="main-title_heading">User List</div>
                <hr class="sidebar-divider my-0">
                <div class="main_heading">
                    <div class="title-pages">
                        Page ${page + 1} of ${numberPages}
                    </div>
                    <a href="<c:url value="/admin/user/add-user" /> " class="btn btn-primary"><i class="fas fa-plus-circle"></i></a>
                </div>
                <div class="list-item">
                    <table class="table table-hover border-primary">
                        <thead class="thead-inverse bg-primary tw-color">
                        <tr>
                            <th>Image</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:if test="${users != null}">
                        <c:forEach var="user" items="${users}">
                            <form:form action="/admin/user/update-user" method="get" modelAttribute="user">
                            <tr>
                                <td>
                                    <img src="/resources/images/user/${user.brandLogo}" width="100px" height="80px">
                                </td>
                                <td><b>${user.fullName}</b></td>
                                <td>${user.email}</td>
                                <td>
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
                                </td>
                                <td>
                                    <select name="status" class="form-control">
                                        <c:forEach items="${userStatus}" var="status">
                                            <c:if test="${status == user.status}" >
                                                <option selected value="${status}">${status}</option>
                                            </c:if>
                                            <c:if test="${status != user.status}" >
                                                <option value="${status}">${status}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td>
                                    <input type="hidden" value="${user.id}" name="id">
                                    <input type="hidden" value="${user.address}" name="address">
                                    <input type="hidden" value="${user.birthDate}" name="birthDate">
                                    <input type="hidden" value="${user.phoneNumber}" name="phoneNumber">
                                    <input type="hidden" value="${user.password}" name="password">
                                    <button type="submit" >
                                        <i class="far fa-edit"></i>
                                    </button>
                                </td>

                            </tr>
                            </form:form>
                        </c:forEach>
                        </tbody>
                    </table>
                    </c:if>
                    <ul class="paginations home-product__pagination">
                        <li class="paganation-item">
                            <c:if test="${page <=1 && start <=1}">
                                <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/user-list?page=${0}&start=${0}"/> '">
                                    <i class="paganation-item__icon fas fa-angle-left"></i>
                                </button>
                            </c:if>
                            <c:if test="${page > 1 && start > 1}" >
                                <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/user-list?page=${page -1}&start=${start -1}"/> '">
                                    <i class="paganation-item__icon fas fa-angle-left"></i>
                                </button>
                            </c:if>
                        </li>
                        <c:forEach var="i" begin="${start}" end="${start+1}">
                            <c:if test="${i < numberPages}" >
                                <c:if test="${page == i}">
                                    <li class="paganation-item paganation-item--active">
                                        <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/user-list?page=${i}&&start=${start}" />'">
                                                ${i + 1}
                                        </button>
                                    </li>
                                </c:if>
                                <c:if test="${page != i}">
                                    <li class="paganation-item">
                                        <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/user-list?page=${i}&&start=${start}"/>'">
                                                ${i + 1}
                                        </button>
                                    </li>
                                </c:if>
                            </c:if>
                        </c:forEach>

                        <c:if test="${page < numberPages - 1}">
                            <li class="paganation-item">
                                <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/user-list?page=${page + 1}&&start=${start}" />'">
                                    <i class="paganation-item__icon fas fa-angle-right"></i>
                                </button>
                            </li>
                        </c:if>
                        <c:if test="${page == numberPages - 1}">
                            <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/user-list?page=${page}&&start=${start}"/>'">
                                <i class="paganation-item__icon fas fa-angle-right"></i>
                            </button>
                        </c:if>

                    </ul>

                </div>

            </div>
        </div>
        <jsp:include page="include/footer.jsp" />
    </div>
</div>
</div>
<jsp:include page="include/logout-modal.jsp" />
<jsp:include page="include/js.jsp" />
</body>