<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cart</title>
    <jsp:include page="include/css.jsp" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</head>
<body>
<jsp:include page="include/header.jsp" />
<div class="product-deatail-container">
    <div class="grid">
        <div class="grid__row">
            <div class="category-details">
                <a href="" class="home-detail">
                    <i class="fas fa-home"></i>
                    Home
                </a>
                <a href="" class="home-detail">
                    <i class="fas fa-long-arrow-alt-right"></i>
                    Cart
                </a>
            </div>
            <div class="cart-content">
                <div class="cart-heading">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="cart-heading__title">
                                Product
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="cart-heading__title">
                                Price
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="cart-heading__title">
                                Quantity
                            </div>
                        </div>
                        <div class="col-sm-1">
                            <div class="cart-heading__title">
                                Total
                            </div>
                        </div>
                        <div class="col-sm-1 ">
                            <div class="cart-heading__title pr-30">
                                Action
                            </div>
                        </div>
                    </div>
                </div>
                <div class="cart-main">
                    <c:forEach var="cart" items="${cartItems}">
                        <div class="cart-product__item">
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="cart-item__name">
                                        <img src="/resources/images/product/${cart.value.getProducts().image}" alt="" class="cart-img__product">
                                        <a href="<c:url value="/product-detail/${cart.value.getProducts().getId()}/${cart.value.getProducts().getCategory().getId()}" />" class="item-product__name">
                                            ${cart.value.getProducts().getProductName()}
                                        </a>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="cart-item__price">
                                        <div class="item-price__old">$${cart.value.getProducts().getPrice()}</div>
                                        <div class="item-price__currrent">$${cart.value.getProducts().getPrice() - (cart.value.getProducts().getPrice() * cart.value.getProducts().getSales().getSalePercent())/100}</div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="cart-item__quantity pd-70">
                                        <div class="buttons_added">
                                                <input class="minus is-form" type="button" value="-" name="minus" min="1"  onclick="location.href = '<c:url value="/cart/update-minus/${cart.value.getProducts().getId()}"/> '">
                                            <input aria-label="quantity" class="input-qty" max="${cart.value.getProducts().getQuantity()}" min="1" name="quantity"
                                                   type="number" value="${cart.value.getQuantity()}">
                                            <input class="plus is-form" type="submit" value="+" onclick="location.href = '<c:url value="/cart/update-plus/${cart.value.getProducts().getId()}"/> '">
                                            <input type="hidden"  name="id" value="${cart.value.getProducts().id}"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="cart-item__total">
                                        <div class="item-price__total">${(cart.value.getProducts().getPrice() -
                                        (cart.value.getProducts().getPrice() * cart.value.getProducts().getSales().getSalePercent())/100)* cart.value.getQuantity()}</div>
                                    </div>
                                </div>
                                <div class="col-sm-1">
                                    <a href="/cart/delete/${cart.value.getProducts().getId()}" class="cart-item_action">
                                        <i class="far fa-trash-alt"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="btn-footer">
                        <a href="/view-product" class=" btn-default_detail btn--cart ">
                            <i class="fas fa-cart-plus detail-cart_icon"></i>
                            Continute Shopping</a>
                        <a href="/cart/clear" class="btn-default_detail btn--clear">Clear Cart</a>
                    </div>
                </div>
                <div class="cart-total">
                    <div class="cart-total__heading">Cart Total</div>
                    <div class="cart-total__main">
                        <div class="cart-total__text">
                            <span class="cart-total__left">Shipping</span>
                            <span class="cart-total__right">Free</span>
                        </div>
                        <div class="cart-total__text">
                            <span class="cart-total__left">Total</span>
                            <span class="cart-total__right">$${totalPrice}</span>
                        </div>
                        <sec:authorize access="!isAuthenticated()" >
                            <a href="/login" class="w100 btn-default_detail btn--check ">
                                <i class="fas fa-money-check-alt detail-cart_icon "></i>
                                Proceed to checkout</a>
                        </sec:authorize>
                        <sec:authorize access="isAuthenticated()" >
                            <a href="/checkout" class="w100 btn-default_detail btn--check ">
                                <i class="fas fa-money-check-alt detail-cart_icon "></i>
                                Proceed to checkout</a>
                        </sec:authorize>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<jsp:include page="include/footer.jsp" />
<script>

</script>
</body>
</html>
