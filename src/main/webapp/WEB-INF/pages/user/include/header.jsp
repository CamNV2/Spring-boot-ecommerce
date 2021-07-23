<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="set" uri="http://www.springframework.org/security/tags" %>
<header class="header">
    <div class="grid">
        <nav class="header__navbar">
            <ul class="header__navbar-list">
                <li class="header__navbar-item header__navbar-item--has-qr header__navbar-item--separate">
                    Vào cửa hàng trên ứng dụng
                    <div class="header__qr">
                        <img src="./assest/img/qr_code.png" alt="qr_code" class="header__qr-img">
                        <div class="header_qr-apps">
                            <a href="#" class="header__qr-link">
                                <img src="./assest/img/app-store.png" alt="" class="qr__download-img">
                            </a>
                            <a href="" class="header__qr-link">
                                <img src="./assest/img/google-play.png" alt="" class="qr__download-img">
                            </a>
                        </div>
                    </div>
                </li>
                <li class="header__navbar-item">
                    <span class="no-pointer">Kết nối</span>
                    <a href="" class="header__navbar-icon-link">
                        <i class="header__navbar-icon fab fa-facebook"></i>
                    </a>
                    <a href="" class="header__navbar-icon-link">
                        <i class="header__navbar-icon fab fa-instagram"></i>
                    </a>


                </li>
            </ul>
            <ul class="header__navbar-list">
                <li class="header__navbar-item header__navbar-item--has-notify">
                    <a href="" class="header__navbar-icon-link">
                        <i class="header__navbar-icon far fa-bell"></i>
                    </a>
                    <a href="#" class="header__navbar-item-link  ">Thông báo</a>
                    <div class="header__notify">
                        <header class="header__notify-header">
                            <h3>Thông báo mới nhận</h3>
                        </header>
                        <ul class="header__notify-list">
                            <li class="header__notify-item header__notify-item--view ">
                                <a href="" class="header__notify-link">
                                    <img src="./assest/img/notify.jpg" alt="" class="header__notify-img">
                                    <div class="header__notify-info">
                                            <span class="header__notify-name">Đơn hàng của bạn đã được xác DareU
                                                EH469 là chiếc tai nghe gaming mà chúng tôi cho rằng, ở phân khúc
                                                giá 500k không có đối thủ về thiết kế. Phần chụp tai với kích thước
                                                lớn hình Oval chụp kín tai, phần ệm đầu có thể co dãn cho cảm giác
                                                đeo rất thoải má
                                                nhận</span>
                                        <p class="header__notify-description">Sản phẩm sẽ được giao đến bạn vào
                                            ngày mai</p>
                                    </div>
                                </a>
                            </li>
                            <li class="header__notify-item">
                                <a href="" class="header__notify-link">
                                    <img src="./assest/img/notify.jpg" alt="" class="header__notify-img">
                                    <div class="header__notify-info">
                                            <span class="header__notify-name">Đơn hàng của bạn đã được xác
                                                nhận</span>
                                        <p class="header__notify-description">Sản phẩm sẽ được giao đến bạn vào
                                            ngày mai</p>
                                    </div>
                                </a>
                            </li>
                            <li class="header__notify-item header__notify-item--view">
                                <a href="" class="header__notify-link">
                                    <img src="./assest/img/notify.jpg" alt="" class="header__notify-img">
                                    <div class="header__notify-info">
                                            <span class="header__notify-name">Đơn hàng của bạn đã được xác
                                                nhận</span>
                                        <p class="header__notify-description">Sản phẩm sẽ được giao đến bạn vào
                                            ngày mai</p>
                                    </div>
                                </a>
                            </li>
                            <li class="header__notify-item header__notify-item--view">
                                <a href="" class="header__notify-link">
                                    <img src="./assest/img/notify.jpg" alt="" class="header__notify-img">
                                    <div class="header__notify-info">
                                            <span class="header__notify-name">Đơn hàng của bạn đã được
                                                xácFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                                                nhận</span>
                                        <p class="header__notify-description">Sản phẩm sẽ được giao đến bạn vào
                                            ngày mai</p>
                                    </div>
                                </a>
                            </li>
                        </ul>
                        <footer class="header__notify-footer">
                            <a href="#" class="header__notify-footer-link">Xem tất cả</a>
                        </footer>
                    </div>
                </li>
                <li class="header__navbar-item">
                    <a href="" class="header__navbar-icon-link">
                        <i class="header__navbar-icon far fa-question-circle"></i>
                    </a>
                    <a href="#" class="header__navbar-item-link">Trợ giúp</a>
                </li>
                <set:authorize access="!isAuthenticated()">
                    <li class="header__navbar-item header__navbar-item-strong header__navbar-item--separate">
                        <a class="nav__link" href="/signup">Đăng ký</a>
                    </li>
                    <li class="header__navbar-item header__navbar-item-strong">
                        <a class="nav__link" href="/login">Đăng Nhập</a>
                    </li>
                </set:authorize>
               <set:authorize access="isAuthenticated()">
                   <li class="header__navbar-item header__navbar-user">
                       <img src="/resources/images/user/${customer.getBrandLogo()}" alt=""
                            class="header__navbar-user-img">
                       <span class="header__navbar-user-name">${customer.getFullName()}</span>
                       <ul class="header__navbar-user-menu">
                           <li class="header__navbar-user-item">
                               <a href="/changeAccount/${customer.getEmail()}">Tài khoản của tôi</a>
                           </li>
                           <li class="header__navbar-user-item">
                               <a href="/manage-order">Đơn hàng</a>
                           </li>
                           <li class="header__navbar-user-item header__navbar-user--separate">
                               <a href="/logout">Đăng xuất</a>
                           </li>
                       </ul>
                   </li>
               </set:authorize>

            </ul>
        </nav>
        <div class="header-with-search">
            <a href="/home" class="header__logo">
                <img src="<c:url value="/resources/images/logo-index.svg"/>" class="header__logo-img" alt="">
            </a>
            <!-- Search history -->
            <div class="header__search">
                <div class="header__search-input-wrap">
                    <input type="text" class="header__search-input" placeholder="Nhập để tìm kiếm sản phẩm">
                    <div class="header__search-history">
                        <h3 class="header__search-history-heading">Lịch sử tìm kiếm</h3>
                        <ul class="header__search-history-list">
                            <li class="header__search-history-item">
                                <a href="">hello</a>
                            </li>
                            <li class="header__search-history-item">
                                <a href="">check, please</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <button class="header__search-btn">
                    <i class="header__search-btn-icon fas fa-search"></i>
                </button>
            </div>
            <!-- Cart layout -->
            <div class="header__cart">
                <div class="header__cart-wrap">
                    <i class="header__cart-icon fas fa-shopping-cart"></i>
                    <span class="header__cart-notice">
                    <c:if test="${sizeCart == null}">0</c:if>
                    <c:if test="${sizeCart != null}">${sizeCart}</c:if>
                    </span>
                    <!-- No cart : header__cart-list--no-cart -->
                    <div class="header__cart-list ">
                        <c:if test="${cartItems == null}">
                            <img src="/resources/images/no-cart.png" alt="" class="header__cart-list-img">
                            <span class="header__cart-list-msg">
                                Chưa có sản phẩm
                            </span>
                        </c:if>
                        <c:if test="${cartItems != null}" >
                            <h4 class="header__cart-heading">
                                Sản phẩm đã thêm
                            </h4>
                        </c:if>
                        <ul class="header__cart-list-item">
                            <!-- Header cart list product -->
                            <c:forEach items="${cartItems}" var="cart" >
                                <li class="header__cart-item">
                                    <img src="/resources/images/product/${cart.value.getProducts().getImage()}" class="header__cart-img" alt="">
                                    <div class="header__cart-item-info">
                                        <div class="header__cart-item-head">
                                            <h5 class="header_cart-item-name">${cart.value.getProducts().getProductName()}</h5>
                                            <div class="header__cart-item-price-wrap">
                                                <span class="header__cart-item-price">${cart.value.getProducts().getPrice() - (cart.value.getProducts().getPrice() * cart.value.getProducts().getSales().getSalePercent())/100}</span>
                                                <span class="header__cart-item-multiply">x</span>
                                                <span class="header__cart-item-qnt">${cart.value.getQuantity()}</span>
                                            </div>
                                        </div>
                                        <div class="header__cart-item-body">
                                            <span class="header__cart-item-desc">
                                                Category: ${cart.value.getProducts().getCategory().getCategoryName()}
                                            </span>
                                            <a href="/cart/delete/${cart.value.getProducts().getId()}" class="header__cart-item-remove">Xóa</a>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        <div class="cart-btn_view">
                            <a href="/view-cart" class="header__cart-view btn-default btn--primary">Xem giỏ hàng</a>
                            <a href="/checkout" class="header__cart-view btn-default btn--primary">Thanh Toán</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
