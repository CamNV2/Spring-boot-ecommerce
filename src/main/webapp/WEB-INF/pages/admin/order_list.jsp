<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Product_list</title>
    <jsp:include page="include/css.jsp"/>
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
</div>
<div id="wrapper">
    <jsp:include page="include/menu-left.jsp"/>
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <jsp:include page="include/header.jsp"/>
            <div class="container-fluid">
                <div class="heading-container">
                    <div class="heading-title">
                        <a href="/admin/order-list" class="home-link">
                            <i class=" fas fa-home"></i>
                        </a>
                        <div class="title-heading">Manager Order</div>
                    </div>
                    <form action="/admin/order/search-order" method="post">
                        <div class="form-search">
                            <input type="text" name="key" class="input_control" placeholder="search..." value="${key}">
                            <button class="btn_primary btn__default"><i class="fas fa-search"></i></button>
                        </div>
                    </form>
                </div>
                <div class="main_container">
                    <div class="main-title_heading">Product List</div>
                    <hr class="sidebar-divider my-0">
                    <div class="main_heading">
                        <form:form action="/admin/order/search-order-date" method="post">
                            <div class="form-group form-search-date">
                                <input class="form-control" type="date" name="fromDate" required/>
                                <input class="form-control mt-20" type="date" name="toDate" required>
                                <button type="submit" class="btn_primary btn__default mt-20"><i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form:form>

                    </div>
                    <div class="list-item">
                        <form:form action="/admin/order/change-status" method="post">
                            <table class="table table-hover border-primary">
                            <thead class="thead-inverse bg-primary tw-color">
                            <tr>
                                <th>Number</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone Number</th>
                                <th>Order Date</th>
                                <th>Total Price</th>
                                <th>Status</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${orders != null}">
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>
                                            <a href="/admin/order/order-detail/${order.id}">CP000${order.id}</a>
                                        </td>
                                        <td><b>${order.fullName}</b></td>
                                        <td>${order.email}</td>
                                        <td>${order.phoneNumber}</td>
                                        <td>${order.orderDate}</td>
                                        <td>$${order.totalPrice}</td>
                                        <c:if test="${order.status == 'CANCEL' || order.status == 'COMPLETED'}">
                                            <td class="flex-table">
                                                <select disabled="true" name="status">
                                                    <c:forEach items="${orderStatus}" var="oStatus">
                                                        <c:if test="${oStatus == order.status}">
                                                            <option selected="selected"
                                                                    value="${oStatus}">${oStatus}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                                <button type="submit" disabled="true"><i class="far fa-edit"></i>
                                                </button>
                                            </td>
                                        </c:if>
                                        <c:if test="${order.status != 'CANCEL' && order.status != 'COMPLETED'}">
                                            <td class="flex-table">
                                                <select name="status">
                                                    <c:forEach items="${orderStatus}" var="oStatus">
                                                        <c:if test="${oStatus == order.status}">
                                                            <option selected="selected"
                                                                    value="${oStatus}">${oStatus}</option>
                                                        </c:if>
                                                        <c:if test="${oStatus != order.status}">
                                                            <option value="${oStatus}">${oStatus}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                                <input type="hidden" name="id" value="${order.id} ">
                                                <button type="submit"><i class="far fa-edit"></i></button>
                                            </td>
                                        </c:if>

                                    </tr>

                                </c:forEach>
                                </tbody>
                                </table>
                            </c:if>
                        </form:form>
                        <ul class="paginations home-product__pagination">
                            <li class="paganation-item">
                                <c:if test="${page <=1 && start <=1}">
                                    <button class="paganation-item__link" onclick="location.href = '
                                        <c:url value="/admin/order-list?page=${0}&start=${0}"/> '">
                                        <i class="paganation-item__icon fas fa-angle-left"></i>
                                    </button>
                                </c:if>
                                <c:if test="${page > 1 && start >= 1}">
                                    <button class="paganation-item__link" onclick="location.href = '
                                        <c:url value="/admin/order-list?page=${page -1}&start=${start -1}"/> '">
                                        <i class="paganation-item__icon fas fa-angle-left"></i>
                                    </button>
                                </c:if>
                            </li>
                            <c:forEach var="i" begin="${start}" end="${numberPages}">
                                <c:if test="${i < numberPages}">
                                    <c:if test="${page == i}">
                                        <li class="paganation-item paganation-item--active">
                                            <button class="paganation-item__link" onclick="location.href = '<c:url
                                                    value="/admin/order-list?page=${i}&&start=${start}"/>'">
                                                    ${i + 1}
                                            </button>
                                        </li>
                                    </c:if>
                                    <c:if test="${page != i}">
                                        <li class="paganation-item">
                                            <button class="paganation-item__link" onclick="location.href = '<c:url
                                                    value="/admin/order-list?page=${i}&&start=${start}"/>'">
                                                    ${i + 1}
                                            </button>
                                        </li>
                                    </c:if>
                                </c:if>
                            </c:forEach>

                            <c:if test="${page < numberPages - 1}">
                                <li class="paganation-item">
                                    <button class="paganation-item__link" onclick="location.href = '<c:url
                                            value="/admin/order-list?page=${page + 1}&&start=${start + 1}"/>'">
                                        <i class="paganation-item__icon fas fa-angle-right"></i>
                                    </button>
                                </li>
                            </c:if>
                            <c:if test="${page == numberPages - 1}">
                                <button class="paganation-item__link" onclick="location.href = '<c:url
                                        value="/admin/order-list?page=${page}&&start=${start}"/>'">
                                    <i class="paganation-item__icon fas fa-angle-right"></i>
                                </button>
                            </c:if>

                        </ul>

                    </div>

                </div>

            </div>
        </div>
        <jsp:include page="include/footer.jsp"/>
    </div>
</div>
<jsp:include page="include/logout-modal.jsp"/>
<jsp:include page="include/js.jsp"/>
</body>
</html>
