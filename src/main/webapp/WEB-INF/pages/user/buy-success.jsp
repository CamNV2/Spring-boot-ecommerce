<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Order</title>
    <jsp:include page="include/css.jsp" />
</head>
<body>
<jsp:include page="include/header.jsp" />
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
                           Order  ${message} , Please check your mail to confirm !
                    </p>
                </div>
            </div>
        </c:if>
    </c:if>
</div>
<div class="product-order-container">
    <div class="grid">
        <div class="grid__row">
            <div class="category-details">
                <a href="" class="home-detail">
                    <i class="fas fa-home"></i>
                    Home
                </a>
                <i class="fas fa-angle-right color-primary"></i>
                <a href="" class="home-detail">
                    Buy Success
                </a>

            </div>
            <div class="checkout-right mt-50">
                    <span class="checkout-heading__text">
                        Buy Success ! Thank you for your purchase. You can check email
                        <a target="buy-success"
                           href="https://mail.google.com/mail/u/0/#inbox">${orderEntity.email}</a> </b>
                        for order details, and track your order
                    </span>
                <div class="btn-footer">
                    <a href="/view-product" class=" btn-default_detail btn--cart ">
                        <i class="fas fa-cart-plus detail-cart_icon"></i>
                        Continute Shopping</a>

                </div>
            </div>

        </div>
    </div>
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>
