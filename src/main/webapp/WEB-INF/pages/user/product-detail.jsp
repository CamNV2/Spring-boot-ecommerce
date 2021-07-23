<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product Detail</title>
    <jsp:include page="include/css.jsp" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</head>
<body>
<jsp:include page="include/header.jsp"/>
  <div class="product-detail-container">
    <div class="grid">
        <div class="grid__row">
            <div class="category-details">
                <a href="/home" class="home-detail">
                    <i class="fas fa-home"></i>
                    Home
                </a>
                <a href="/view-product/${product.category.id}" class="home-detail">
                    <i class="fas fa-long-arrow-alt-right"></i>
                    ${product.category.categoryName}
                </a>

            </div>
            <c:if test="${product.status == 'ACTIVE'}" >
                <div class="product-content">
                    <div class="product-left">
                        <img src="/resources/images/product/${product.image}" class="img_product">
                    </div>

                    <div class="product-right">
                        <div class="product-detail_heading">
                            <div class="label-favourite">
                                <i class="fas fa-check"></i>
                                <span>Yêu thích</span>
                            </div>
                            <div class="title-name">${product.productName}</div>
                        </div>
                        <div class="product-right_main">
                            <c:if test="${product.sales.salePercent != 0}">
                                <div class="price-current">
                                    <span class="price-text">Giá Niêm Yết</span>
                                    <span class="price-old">${product.price}</span>
                                </div>
                                <div class="price-current">
                                    <span class="price-text">Giá Khuyến Mãi</span>
                                    <div class="price-format">
                                        <b>${product.price - (product.price * product.sales.salePercent /100 )}</b>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${product.sales.salePercent == 0}">
                                <div class="price-current">
                                    <span class="price-text">Giá Niêm yết</span>
                                    <div class="price-format">
                                        <b>${product.price - (product.price * product.sales.salePercent /100 )}</b>
                                    </div>
                                </div>
                            </c:if>

                            <div class="product-status">
                                <div class="product-text">Tình trạng</div>
                                <c:if test="${product.quantity > 1}">
                                    <span class="status-text">Còn hàng</span>
                                </c:if>
                                <c:if test="${product.quantity < 1}">
                                    <span class="status-text">Hết Hàng</span>
                                </c:if>
                            </div>
                            <div class="product-warranty">
                                <div class="product-text">Bảo hành</div>
                                <span class="warranty-text">${product.warranty}</span>
                            </div>
                        </div>
                        <div class="product-quantity">
                            <div class="product-qty">Chọn số lượng</div>
                            <div class="buttons_added">
                                <input class="minus is-form" type="button" value="-">

                                    <input aria-label="quantity" class="input-qty" max="${product.quantity}" min="1" name="quantity" type="number"
                                           value="1">

                                <input class="plus is-form" type="button" value="+">
                            </div>
                            <div class="product-qty-des">${product.quantity} sản phẩm có sẵn</div>
                        </div>

                        <div class="product-btn">
                            <a href="/cart/${product.id}" class=" btn-default_detail btn--cart ">
                                <i class="fas fa-cart-plus detail-cart_icon"></i>
                                Thêm vào giỏ hàng</a>
                            <a href="" class="btn-default_detail btn--primary ml-10">Mua ngay</a>
                        </div>
                        <hr class="mt-30 mr-10">
                        <div class="product-commit">
                            <a href="" class="commit-link">
                                <img src="/resources/images/icon/commit.png" class="commit-img" />
                                <span class="commit-text">Cp Đảm Bảo </span>
                            </a>
                            <span class="commit-title"> 3 Ngày trả hàng / Hoàn tiền</span>
                        </div>

                    </div>
                </div>
                <div class="product-description">
                    <hr class="hr-title">
                    <div class="des-heading">
                        Chi tiết sản phẩm
                    </div>
                    <div class="des-main">

                        <div class="product-status">
                            <div class="product-des_text">Bảo hành</div>
                            <span class="status-text">${product.warranty}</span>
                        </div>
                        <div class="product-status">
                            <div class="product-des_text">Số lượng Kho</div>
                            <c:if test="${product.quantity != 0}">
                                <span class="status-text">${product.quantity}</span>
                            </c:if>
                            <c:if test="${product.quantity == 0}">
                                <span class="status-text">Hết hàng</span>
                            </c:if>
                        </div>
                        <div class="product-status">
                            <div class="product-des_text">Cấu hình</div>
                            <span class="status-text">${product.description}</span>
                        </div>
                    </div>
                </div>
            </c:if>

        </div>
    </div>
  </div>
  <div class="product-container">
    <div class="grid">
        <div class="grid__row">
            <div class="product-heading">
                <h3 class="heading-title">
                    <i class="fab fa-vuejs "></i>
                    Sản Phẩm tương tự
                </h3>
                <a href="/view-product" class="heading-menu">Xem tất cả
                    <i class="fas fa-angle-double-right"></i>
                </a>
            </div>
        </div>
        <div class="grid__row">
            <c:forEach items="${productCate}" var="product" >
                <c:if test="${product.status == 'ACTIVE' && product.category.status == 'ACTIVE'}">
                    <div class="grid__column-2-5">
                        <div class="home-product-item">
                            <div class="home-product-item__img">
                                <img class="img-product" src="/resources/images/product/${product.image}">
                                <div class="cart-modal">
                                    <div class="cart-item animate__animated animate__fadeInUp ">
                                        <a href="/cart/${product.id}" class="add-cart__link">
                                            <i class=" cart-icon fas fa-cart-plus"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <h4 class="home-product-item__name">
                                <a href="/product-detail/${product.id}/${product.category.id}" class="product-item__link">
                                        ${product.productName}
                                </a>
                            </h4>
                            <div class="home-product-item__price">
                                <c:if test="${product.sales.salePercent != 0}" >
                                    <span id="price" class="item-price-old">${product.price}</span>
                                </c:if>
                                <span id="oldPrice"  class="item-price-current">$${product.price - (product.price * (product.sales.salePercent/100))}</span>
                                <span class="item-car">
                                    <i class=" item-car-icon fas fa-truck">
                                    </i>
                                    <span class="icon-car-title">free</span>
                                </span>
                            </div>
                            <div class="home-product-item__action">
                                <span class="home-product-item__like home-product-item--liked">
                                    <i class="home-product-item__empty-icon far fa-heart"></i>
                                    <i class="home-product-item__liked-icon fas fa-heart"></i>
                                </span>
                                <div class="home-product-item__rating">
                                    <i class="home-product-item__rating-gold fas fa-star"></i>
                                    <i class="home-product-item__rating-gold fas fa-star"></i>
                                    <i class="home-product-item__rating-gold fas fa-star"></i>
                                    <i class="home-product-item__rating-gold fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                            </div>
                            <div class="home-product-item__favourite">
                                <i class="fas fa-check"></i>
                                <span>Yêu thích</span>
                            </div>
                            <c:if test="${product.sales.salePercent != 0}" >
                                <div class="home-product-item__sale-off">
                                    <span class="sale-off__percent">${product.sales.salePercent}%</span>
                                    <span class="sale-off__label">GIẢM</span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </c:forEach>

        </div>
    </div>

  </div>

<jsp:include page="include/footer.jsp" />
<script>
    $('input.input-qty').each(function () {
        var $this = $(this),
            qty = $this.parent().find('.is-form'),
            min = Number($this.attr('min')),
            max = Number($this.attr('max'))
        if (min == 0) {
            var d = 0
        } else d = min
        $(qty).on('click', function () {
            if ($(this).hasClass('minus')) {
                if (d > min) d += -1
            } else if ($(this).hasClass('plus')) {
                var x = Number($this.val()) + 1
                if (x <= max) d += 1
            }
            $this.attr('value', d).val(d)
        })
    })
</script>
</body>
</html>
