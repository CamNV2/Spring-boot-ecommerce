
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Product_list</title>
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
</div>
<div id="wrapper">
    <jsp:include page="include/menu-left.jsp" />
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <jsp:include page="include/header.jsp" />
            <div class="container-fluid">
                <div class="heading-container">
                    <div class="heading-title">
                        <a href="/admin/order-list" class="home-link">
                            <i class=" fas fa-home"></i>
                        </a>
                        <div class="title-heading">Manager Order</div>
                    </div>
                    <form action="/admin/search" method="post">
                        <div class="form-search">
                            <input type="text" name="key" class="input_control" placeholder="search..." value="${key}">
                            <button class="btn_primary btn__default"><i class="fas fa-search"></i></button>
                        </div>
                    </form>
                </div>
                <div class="main_container">
                    <div class="main-title_heading">Order detail List</div>
                    <hr class="sidebar-divider my-0">
                    <div class="main_heading">

                    </div>
                    <div class="list-item">

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

                                    <tr >
                                        <td>
                                            CP000${order.id}
                                        </td>
                                        <td><b>${order.fullName}</b></td>
                                        <td>${order.email}</td>
                                        <td>${order.phoneNumber}</td>
                                        <td>${order.orderDate}</td>
                                        <td>$${order.totalPrice}</td>
                                        <c:if test="${order.status == 'CANCEL' || order.status == 'COMPLETED'}">
                                            <td class="flex-table">
                                                <select disabled="true" name="status">
                                                    <c:forEach items="${orderStatus}" var="oStatus" >
                                                        <c:if test="${oStatus == order.status}">
                                                            <option selected="selected" value="${oStatus}">${oStatus}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                                <button type="submit" disabled="true" ><i class="far fa-edit"></i></button>
                                            </td>
                                        </c:if>
                                        <c:if test="${order.status != 'CANCEL' && order.status != 'COMPLETED'}">
                                            <td class="flex-table">
                                                <select name="status">
                                                    <c:forEach items="${orderStatus}" var="oStatus" >
                                                        <c:if test="${oStatus == order.status}">
                                                            <option selected="selected" value="${oStatus}">${oStatus}</option>
                                                        </c:if>
                                                        <c:if test="${oStatus != order.status}" >
                                                            <option value="${oStatus}">${oStatus}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                                <input type="hidden" name="id" value="${order.id} ">
                                                <button type="submit" ><i class="far fa-edit"></i></button>
                                            </td>
                                        </c:if>
                                    </tr>
                                </tbody>
                                </table>



                    </div>
                    <div class="list-item">
                            <table class="table table-hover border-primary">
                            <thead class="thead-inverse bg-primary tw-color">
                            <tr>
                                <th>Image</th>
                                <th>Name</th>
                                <th>Discount</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                            </tr>
                            </thead>
                            <tbody >
                                <c:forEach items="${order.orderDetails }" var="item" >
                                    <tr >
                                        <td><img src="/resources/images/product/${item.products.image}" class="product-image" /></td>
                                        <td>${item.products.productName}</td>
                                        <td>${item.products.sales.salePercent}%</td>
                                        <td>
                                            <div class="order-item__price">
                                                <div class="order-price__current">$${item.products.price - item.products.price*item.products.sales.salePercent/100}</div>
                                                <c:if test="${item.products.sales.salePercent != 0}">
                                                    <div class="item-price__old">$${item.products.price}</div>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td class="pd-30">${item.quantity}</td>
                                        <td class="price-total">$${(item.products.price - item.products.price*item.products.sales.salePercent/100) * item.quantity}</td>
                                    </tr>

                                </c:forEach>
                                </tbody>
                                </table>

                    </div>

                </div>

            </div>
        </div>
        <jsp:include page="include/footer.jsp" />
    </div>
</div>
<jsp:include page="include/logout-modal.jsp" />
<jsp:include page="include/js.jsp" />
</body>
</html>
