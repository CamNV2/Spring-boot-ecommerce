<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Order</title>
    <jsp:include page="include/css.jsp" />

</head>
<body>
<jsp:include page="include/header.jsp" />

<div class="product-order-container">
    <div class="grid">
        <div class="grid__row">
            <div class="category-details">
                <a href="" class="home-detail">
                    <i class="fas fa-home"></i>
                    Home
                </a>
                <i class="fas fa-angle-right color-primary"></i>
                <a href="/manage-order" class="home-detail">
                    Order
                </a>
                <i class="fas fa-angle-right color-primary"></i>
                <a href="" class="home-detail">
                    Order-detail
                </a>
            </div>
            <div class="checkout-right mt-50">
                    <span class="checkout-heading__text">
                        Your order
                    </span>
                <div class="checkout-right__main">
                    <div class="checkout-main__heading">
                        <div class="row bbt-10">
                            <div class="col-sm-3">
                                <span class="checkout-text">Mail</span>
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
                            <div class="col-sm-2 ">
                                <span class="checkout-text">Total</span>
                            </div>

                        </div>
                        <div class="product-checkout-item">
                            <div class="row align-center">
                                <div class="col-sm-3">
                                    <span class="checkout-product-text">${order.email}</span>
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
                                    <span class="checkout-product-text pos-10 pd-20">${order.quantity}</span>
                                </div>
                                <div class="col-sm-2">
                                    <span class="checkout-product-text">${order.orderDate}</span>
                                </div>
                                <div class="col-sm-2">
                                    <span class="checkout-product-text ">$${order.totalPrice}</span>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="product-order_detail">
                        <span class="checkout-heading__text">
                            Product-detail
                        </span>
                    <div class="checkout-right__main">
                        <div class="checkout-main__heading">
                            <div class="row bbt-10">
                                <div class="col-sm-4">
                                    <span class="checkout-text">Product</span>
                                </div>
                                <div class="col-sm-2">
                                    <span class="checkout-text">Discount</span>
                                </div>
                                <div class="col-sm-2">
                                    <span class="checkout-text">Price</span>
                                </div>
                                <div class="col-sm-2">
                                    <span class="checkout-text">Quantity</span>
                                </div>
                                <div class="col-sm-2">
                                    <span class="checkout-text">Total</span>
                                </div>

                            </div>
                            <c:forEach items="${order.orderDetails}" var="cart" >
                                <div class="product-checkout-item">
                                    <div class="row align-center">
                                        <div class="col-sm-4 ">
                                            <span class="checkout-product-text">${cart.products.productName}</span>
                                        </div>
                                        <div class="col-sm-2">
                                            <span class="checkout-product-text ">${cart.products.sales.salePercent}</span>
                                        </div>
                                        <div class="col-sm-2 pos-r25">
                                            <div class="order-item__price">
                                                <div class="order-price__current">$${cart.products.price - cart.products.price*cart.products.sales.salePercent/100}</div>
                                                <c:if test="${cart.products.sales.salePercent != 0}">
                                                    <div class="item-price__old">$${cart.products.price}</div>
                                                </c:if>


                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <span class="checkout-product-text pd-20">${cart.quantity}</span>
                                        </div>
                                        <div class="col-sm-2">
                                            <span class="order-price__currrent">$${(cart.products.price - cart.products.price*cart.products.sales.salePercent/100) * cart.quantity}</span>
                                        </div>

                                    </div>
                                </div>
                            </c:forEach>


                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>
