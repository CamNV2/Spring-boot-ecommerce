
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
                        Buy Fail ! Transaction failed number greater than balance, Please check your account again
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
