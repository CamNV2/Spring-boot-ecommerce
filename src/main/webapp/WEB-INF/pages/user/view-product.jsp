<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Shop List</title>
    <jsp:include page="include/css.jsp" />
</head>
<body>
<div class="app">
    <jsp:include page="include/header.jsp" />
    <div class="app__container">
        <div class="grid">
            <div class="grid__row app__content">
                <div class="grid__column-2">
                    <nav class="category">
                        <h3 class="category__heading">
                            Danh mục
                        </h3>
                        <ul class="category-list ">
                            <c:forEach begin="0" end="${categories.size() -1 }" var="i" >
                                <c:if test="${categories[i].status == 'ACTIVE' }">
                                    <c:if test="${categories[i].id == idCate}">
                                        <li class="category-item category-item--active">
                                    </c:if>
                                    <c:if test="${categories[i].id != idCate}">
                                        <li class="category-item ">
                                    </c:if>
                                    <a href="/view-product/${categories[i].id}" class="category-item__link">${categories[i].categoryName}
                                        <span class="count-price">(${countProduct[i]})</span>
                                    </a>

                                    </li>

                                </c:if>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
                <div class="grid__column-10">
                    <jsp:include page="include/home-filter.jsp" />
                    <div class="home-product ">
                        <div class="grid">
                            <div class="grid-row__product">
                                <c:forEach items="${products}" var="product">
                                    <c:if test="${product.status == 'ACTIVE'}" >
                                        <div class="grid__column-2-4">
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
                        <ul class="pagination home-product__pagination">
                            <c:if test="${page <= 1 && start <= 1}" >
                                <li class="paganation-item">
                                    <c:if test="${status == 'sort-asc'}">
                                        <a href="/price-sort-asc?page=${0}&start=${0}" class="paganation-item__link">
                                            <i class="paganation-item__icon fas fa-angle-left"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${status == 'sort-desc'}">
                                        <a href="/price-sort-desc?page=${0}&start=${0}" class="paganation-item__link">
                                            <i class="paganation-item__icon fas fa-angle-left"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${status != 'sort-asc' && status!= 'sort-desc'}">
                                        <a href="/view-product?page=${0}&start=${0}" class="paganation-item__link">
                                           <i class="paganation-item__icon fas fa-angle-left"></i>
                                        </a>
                                    </c:if>
                                </li>
                            </c:if>
                            <c:if test="${page >= 1 && start >= 1}" >
                                <li class="paganation-item">
                                    <a href="/view-product?page=${page -1 }&start=${start-1}" class="paganation-item__link">
                                        <i class="paganation-item__icon fas fa-angle-left"></i>
                                    </a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="${start}" end="${start + 2}" >
                                <c:if test="${i < numberPage}" >
                                    <c:if test="${page == i}" >
                                        <li class="paganation-item paganation-item--active">
                                            <c:if test="${status == 'sort-asc'}">
                                                <a href="/price-sort-asc?page=${i}&start=${start}" class="paganation-item__link">${i + 1}
                                                </a>
                                            </c:if>
                                            <c:if test="${status == 'sort-desc'}">
                                                <a href="/price-sort-desc?page=${i}&start=${start}" class="paganation-item__link">${i + 1}
                                                </a>
                                            </c:if>
                                            <c:if test="${status != 'sort-asc' && status!= 'sort-desc'}">
                                            <a href="/view-product?page=${i}&start=${start}" class="paganation-item__link">${i + 1}
                                            </a>
                                            </c:if>
                                        </li>
                                    </c:if>
                                    <c:if test="${page != i}" >
                                        <li class="paganation-item ">
                                            <c:if test="${status == 'sort-asc'}">
                                                <a href="/price-sort-asc?page=${i}&start=${start}" class="paganation-item__link">${i + 1}
                                                </a>
                                            </c:if>
                                            <c:if test="${status == 'sort-desc'}">
                                                <a href="/price-sort-desc?page=${i}&start=${start}" class="paganation-item__link">${i + 1}
                                                </a>
                                            </c:if>
                                            <c:if test="${status != 'sort-asc' && status!= 'sort-desc'}">
                                                <a href="/view-product?page=${i}&start=${start}" class="paganation-item__link">${i + 1}
                                                </a>
                                            </c:if>
                                        </li>
                                    </c:if>
                                </c:if>
                            </c:forEach>

                           <c:if test="${page < numberPage -1}" >
                               <li class="paganation-item">
                                   <c:if test="${status == 'sort-asc'}">
                                       <a href="/price-sort-asc?page=${page + 1 }&start=${start+1}" class="paganation-item__link">
                                           <i class="paganation-item__icon fas fa-angle-right"></i>
                                       </a>
                                   </c:if>
                                   <c:if test="${status == 'sort-desc'}">
                                       <a href="/price-sort-desc?page=${page + 1 }&start=${start+1}" class="paganation-item__link">
                                           <i class="paganation-item__icon fas fa-angle-right"></i>
                                       </a>
                                   </c:if>
                                   <c:if test="${status != 'sort-asc' && status!= 'sort-desc'}">
                                       <a href="/view-product?page=${page + 1 }&start=${start+1}" class="paganation-item__link">
                                       <i class="paganation-item__icon fas fa-angle-right"></i>
                                       </a>
                                   </c:if>
                               </li>
                           </c:if>
                            <c:if test="${page == numberPage -1}" >
                                <li class="paganation-item">
                                    <c:if test="${status == 'sort-asc'}">
                                        <a href="/price-sort-asc?page=${page }&start=${start}" class="paganation-item__link">
                                            <i class="paganation-item__icon fas fa-angle-right"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${status == 'sort-desc'}">
                                        <a href="/price-sort-desc?page=${page }&start=${start}" class="paganation-item__link">
                                            <i class="paganation-item__icon fas fa-angle-right"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${status != 'sort-asc' && status!= 'sort-desc'}">
                                         <a href="/view-product?page=${page }&start=${start}" class="paganation-item__link">
                                           <i class="paganation-item__icon fas fa-angle-right"></i>
                                          </a>
                                    </c:if>
                                </li>
                            </c:if>

                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="include/footer.jsp" />
</div>

</body>
</html>
