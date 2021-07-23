<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manager Order</title>
    <jsp:include page="include/css.jsp" />
</head>
<body>
<jsp:include page="include/header.jsp" />

<div class="product-order-container">
    <div class="grid">
        <div class="grid__row">
            <div class="order-details ">

            </div>
            <div class="checkout-right">
                    <span class="checkout-heading__text">
                        Your order
                    </span>
                <div class="checkout-right__main">
                    <div class="checkout-main__heading">
                        <div class="row bbt-10">
                            <div class="col-sm-3">
                                <span class="checkout-text">Name</span>
                            </div>
                            <div class="col-sm-2">
                                <span class="checkout-text">Phone Number</span>
                            </div>
                            <div class="col-sm-2">
                                <span class="checkout-text">Status</span>
                            </div>
                            <div class="col-sm-1">
                                <span class="checkout-text pos-10">Quantity</span>
                            </div>
                            <div class="col-sm-2">
                                <span class="checkout-text">Date Order</span>
                            </div>
                            <div class="col-sm-1">
                                <span class="checkout-text pos-10">Total</span>
                            </div>
                            <div class="col-sm-1">
                                <span class="checkout-text"></span>
                            </div>
                        </div>
                        <c:forEach items="${orders}" var="order">
                        <div class="product-checkout-item">
                                <div class="row align-center">
                                    <div class="col-sm-3 ">
                                        <a href="/search-order-by-id/${order.id}"  class="checkout-product-text">${order.email}</a>
                                    </div>
                                    <div class="col-sm-2">
                                        <span class="checkout-product-text ">${order.phoneNumber}</span>
                                    </div>
                                    <div class="col-sm-2">
                                        <c:if test="${order.status == 'CANCEL'}" >
                                            <span class="checkout-product-text">Canceled</span>
                                        </c:if>
                                        <c:if test="${order.status != 'CANCEL'}" >
                                            <span class="checkout-product-text">${order.status}</span>
                                        </c:if>
                                    </div>
                                    <div class="col-sm-1">
                                        <span class="checkout-product-text pos-10">${order.quantity}</span>
                                    </div>
                                    <div class="col-sm-2">
                                        <span class="checkout-product-text">${order.orderDate}</span>
                                    </div>
                                    <div class="col-sm-1 pos-10">
                                        <span class="checkout-product-text ">${order.totalPrice}</span>
                                    </div>
                                    <c:if test="${order.status == 'CONFIRM' || order.status =='PENDING' }" >
                                        <div class="col-sm-1">
                                            <a href="/change-status-cancel/${order.id}" class=" btn-default_order btn--payment pos-10">
                                                Cancel</a>
                                        </div>
                                    </c:if>
                                </div>
                        </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>
