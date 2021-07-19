<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Checkout Page</title>
    <jsp:include page="include/css.jsp" />
</head>
<body>
<jsp:include page="include/header.jsp" />
<div class="product-detail-container">
    <div class="grid">
        <div class="grid__row">
            <div class="category-details">

            </div>
            <form:form action="/checkout" modelAttribute="checkout" method="post" >
            <div class="checkout-content">

                  <div class="checkout-left">
                    <div class="checkout-form">
                        <span class="checkout-heading__text pt-10">Customer Info</span>

                        <div class="form-checkout">
                            <div class="form-input">
                                <input type="text" name="fullName" value="${customer.fullName}" class="input-control__login" placeholder=" ">
                                <label class="form__label">Full Name</label>
                                <i class="far fa-user input-icon-email"></i>
                            </div>
                            <div class="form-input">
                                <input type="text" name="email" value="${customer.email}" class="input-control__login " placeholder=" ">
                                <label class="form__label">Email</label>
                                <i class="far fa-envelope input-icon-email"></i>
                            </div>
                            <div class="form-input">
                                <input type="text" name="address" value="${customer.address}" class="input-control__login" placeholder=" ">
                                <label class="form__label">Adress</label>
                                <i class="fas fa-map-marker-alt input-icon-email"></i>
                            </div>
                            <div class="form-input">
                                <input type="text" name="phoneNumber" value="${customer.phoneNumber}" class="input-control__login " placeholder=" " maxlength="12">
                                <label class="form__label">Telephone</label>
                                <i class="fas fa-phone-alt  input-icon-email"></i>
                            </div>
                        </div>

                    </div>
                </div>
                  <div class="checkout-right">
                        <span class="checkout-heading__text">
                            Your order
                        </span>
                    <div class="checkout-right__main">
                        <div class="checkout-main__heading">
                            <div class="row bbt-10">
                                <div class="col-sm-6">
                                    <span class="checkout-text">Product</span>
                                </div>
                                <div class="col-sm-3">
                                    <span class="checkout-text">Quantity</span>
                                </div>
                                <div class="col-sm-2">
                                    <span class="checkout-text">Total</span>
                                </div>
                            </div>
                            <c:forEach var="cart" items="${cartItems}">
                                <div class="product-checkout-item">
                                    <div class="row">
                                        <div class="col-sm-6 ">
                                            <a href="<c:url value="/product-detail/${cart.value.getProducts().getId()}/${cart.value.getProducts().getCategory().getId()}" />" class="checkout-product-text">
                                               ${cart.value.getProducts().getProductName()}</a>
                                        </div>
                                        <div class="col-sm-3">
                                            <span class="checkout-product-text pl-10">${cart.value.getQuantity()}</span>
                                        </div>
                                        <div class="col-sm-3">
                                            <span class="checkout-product-text">$${(cart.value.getProducts().getPrice() -
                                                    (cart.value.getProducts().getPrice() * cart.value.getProducts().getSales().getSalePercent())/100)* cart.value.getQuantity()}</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <div class="checkout-status">
                                <div class="checkout-status_left grey-color">Shipping</div>
                                <div class="checkout-status_right black-color">Free</div>
                            </div>
                            <div class="checkout-status">
                                <div class="checkout-status_total">Total</div>
                                <div class="checkout-status_price">$${totalPrice}</div>
                            </div>
                            <div class="checkout-btn-payment">
                                <div class="input-checkbox">
                                    <input name="paymentMethod" value="CASH_ON_DELIVERY" type="checkbox" id="delivery" >
                                    <label for="delivery">
                                        <span></span>
                                        Payment on delivery
                                    </label>
                                    <div class="caption">
                                        <input  name="delivery" type="submit"  style="width: 100%" class="primary-btn order-submit"  value="Payment on delivery" />
                                    </div>
                                </div>
                                <div class="input-checkbox">
                                    <input name="paymentMethod" value="CREDIT_CARD" type="checkbox" id="cash" >
                                    <label for="cash">
                                        <span></span>
                                        Payment on cash
                                    </label>
                                    <div class="caption">
                                        <input  name="cash" type="submit"  style="width: 100%" class="primary-btn order-submit"  value="Payment on cash" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            </form:form>
        </div>
    </div>
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>
