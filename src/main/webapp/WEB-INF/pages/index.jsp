<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cp Computer</title>
    <jsp:include page="user/include/css.jsp" />
</head>
<body>
  <jsp:include page="user/include/header.jsp"/>
  <div class="main__container">
      <jsp:include page="user/include/menu.jsp" />
      <div class="product-container">
          <div class="grid">
              <div class="grid__row">
                  <div class="product-heading">
                      <h3 class="heading-title">
                          <i class="fab fa-vuejs "></i>
                          New Product
                      </h3>
                      <a href="/view-product" class="heading-menu">Xem tất cả
                          <i class="fas fa-angle-double-right"></i>
                      </a>
                  </div>
              </div>
              <div class="grid__row">
                  <c:forEach items="${products}" var="product" >
                      <c:if test="${product.status == 'ACTIVE'}">
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
                                          <td></td>
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
          <div class="grid mt-25">
              <div class="grid__row">
                  <div class="product-heading">
                      <h3 class="heading-title">
                          <i class="fab fa-vuejs "></i>
                          Hot Sale
                      </h3>
                      <a href="/view-product" class="heading-menu">Xem tất cả
                          <i class="fas fa-angle-double-right"></i>
                      </a>
                  </div>
              </div>
              <div class="grid__row">
                  <c:forEach items="${productSale}" var="product" >
                      <c:if test="${product.status == 'ACTIVE' && product.sales.salePercent != 0 && product.sales.salePercent != 10 }">
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
                                      <a href="<c:url value="/product-detail/${product.id}/${product.getCategory().id}"/>" class="product-item__link">
                                              ${product.productName}
                                                      ${product.getCategory().id}
                                      </a>
                                  </h4>
                                  <div class="home-product-item__price">
                                      <c:if test="${product.sales.salePercent != 0}" >
                                          <span id="price" class="item-price-old">${product.price}</span>
                                      </c:if>
                                      <span id="oldPrice"  class="item-price-current">${product.price - (product.price * (product.sales.salePercent/100))}</span>
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
          <div class="grid mt-25">
              <div class="grid__row">
                  <div class="product-heading">
                      <h3 class="heading-title">
                          <i class="fab fa-vuejs "></i>
                           Hot Product
                      </h3>
                      <a href="/view-product" class="heading-menu">Xem tất cả
                          <i class="fas fa-angle-double-right"></i>
                      </a>
                  </div>
              </div>
              <div class="grid__row">
                  <c:forEach items="${productHot}" var="product" >
                      <c:if test="${product.status == 'ACTIVE' }">
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
                                      <span id="oldPrice"  class="item-price-current">${product.price - (product.price * (product.sales.salePercent/100))}</span>
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
  </div>
  <jsp:include page="user/include/footer.jsp" />
  <jsp:include page="user/include/js.jsp" />
<script>
    jQuery(document).ready(function ($) {

        pos = $("#menuTop").position();

        $(window).scroll(function () {
            var posScroll = $(document).scrollTop();
            if (parseInt(posScroll) > parseInt(pos.top)) {
                $("#menuTop").addClass('fixed')
            } else {
                $("#menuTop").removeClass('fixed')
            }
        })
    })
</script>
</body>
</html>
