<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Product_list</title>
    <jsp:include page="include/css.jsp" />
</head>
<body>
<div id="wrapper">
    <jsp:include page="include/menu-left.jsp" />
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <jsp:include page="include/header.jsp" />
            <div class="container-fluid">
                <div class="heading-container">
                    <div class="heading-title">
                        <a href="/admin/product-list" class="home-link">
                            <i class=" fas fa-home"></i>
                        </a>
                        <div class="title-heading">Manager Product</div>
                    </div>
                    <form action="/admin/search" method="post">
                    <div class="form-search">
                            <input type="text" name="key" class="input_control" placeholder="search..." value="${key}">
                            <button class="btn_primary btn__default"><i class="fas fa-search"></i></button>
                    </div>
                    </form>
                </div>
                <div class="main_container">
                    <div class="main-title_heading">Product List</div>
                    <hr class="sidebar-divider my-0">
                    <div class="main_heading">
                        <div class="title-pages">
<%--                            <c:if test="${(page + 1) < numberPages}">--%>
<%--                                Showing ${page*size + 1} - ${page*size + products.size() } of ${n} result--%>
<%--                            </c:if>--%>
<%--                            <c:if test="${(page + 1) >= numberPages}">--%>
<%--                                Showing ${page*size + 1} - ${n}  of ${n} result--%>
<%--                            </c:if>--%>
                             Page ${page + 1} of ${numberPages}
                        </div>
                        <a href="<c:url value="/admin/add-product" /> " class="btn btn-primary"><i class="fas fa-plus-circle"></i></a>
                    </div>
                    <div class="list-item">
                        <table class="table table-hover border-primary">
                            <thead class="thead-inverse bg-primary tw-color">
                            <tr>
                                <th>Image</th>
                                <th>Product Name</th>
                                <th>
                                    <a class="dropdown-toggle tw-color p-10" href="#" id="categoryDropdown"
                                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        Category
                                    </a>
                                    <div class="dropdown-menu menu-customer "
                                         aria-labelledby="categoryDropdown">
                                        <c:forEach var="category" items="${categories}">
                                            <c:if test="${category.status == 'ACTIVE'}" >
                                                <a class="cus-item_link" href="/admin/search-cate/${category.id}">
                                                     <c:out value="${category.categoryName}" />
                                                </a>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </th>
                                <th>Sales</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Stock</th>
                                <th>Warranty</th>
                                <th>Status</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${products != null}">
                                <c:forEach var="product" items="${products}">
                                        <tr>
                                            <td>
                                                <img src="/resources/images/product/${product.image}" width="100px" height="80px">
                                            </td>
                                            <td><b>${product.productName}</b></td>
                                            <td>${product.category.categoryName}</td>
                                            <td>${product.sales.saleId}</td>
                                            <td>${product.price}</td>
                                            <td>${product.quantity}</td>
                                            <c:if test="${product.quantity <= 0}">
                                                <td class="stock-text-dange  ">
                                                    Out Of Stock
                                                </td>
                                            </c:if>
                                            <c:if test="${product.quantity >= 10}">
                                                <td class="stock-text-success ">
                                                    In Stock
                                                </td>
                                            </c:if>
                                            <c:if test="${product.quantity > 0 && product.quantity < 10}">
                                                <td class="stock-text-warning ">
                                                    Low Stock
                                                </td>
                                            </c:if>

                                            <td>${product.warranty}</td>
                                            <td>
                                                <div class="btn-table">
                                                    <c:if test="${product.status == 'ACTIVE'}">
                                                        <button class="btn bg-gradient-success tw-color" onclick="location.href ='<c:url value="/admin/product/change-status/${product.id}" />' " >
                                                            <span class="status-btn">${product.status}</span></button>
                                                    </c:if>
                                                    <c:if test="${product.status == 'DISABLED' }" >
                                                        <button class="btn bg-gradient-info tw-color" onclick="location.href ='<c:url value="/admin/product/change-status/${product.id}" /> ' " >
                                                            <span class="status-btn">${product.status}</span></button>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td>
                                                <a class="edit-icon" href="/admin/update/${product.id}">
                                                    <i class="far fa-edit"></i>
                                                </a>
                                            </td>

                                        </tr>

                                </c:forEach>


                            </tbody>
                        </table>
                        </c:if>
                        <ul class="paginations home-product__pagination">
                            <li class="paganation-item">
                                <c:if test="${page <=1 && start <=1}">
                                    <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/product-list?page=${0}&start=${0}"/> '">
                                        <i class="paganation-item__icon fas fa-angle-left"></i>
                                    </button>
                                </c:if>
                                <c:if test="${page > 1 && start >= 1}" >
                                    <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/product-list?page=${page -1}&start=${start -1}"/> '">
                                        <i class="paganation-item__icon fas fa-angle-left"></i>
                                    </button>
                                </c:if>
                            </li>
                            <c:forEach var="i" begin="${start}" end="${numberPages}">
                                <c:if test="${i < numberPages}" >
                                    <c:if test="${page == i}">
                                        <li class="paganation-item paganation-item--active">
                                            <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/product-list?page=${i}&&start=${start}" />'">
                                                    ${i + 1}
                                            </button>
                                        </li>
                                    </c:if>
                                    <c:if test="${page != i}">
                                        <li class="paganation-item">
                                            <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/product-list?page=${i}&&start=${start}"/>'">
                                                    ${i + 1}
                                            </button>
                                        </li>
                                    </c:if>
                                </c:if>
                            </c:forEach>

                            <c:if test="${page < numberPages - 1}">
                                 <li class="paganation-item">
                                    <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/product-list?page=${page + 1}&&start=${start + 1}" />'">
                                        <i class="paganation-item__icon fas fa-angle-right"></i>
                                    </button>
                                 </li>
                            </c:if>
                                <c:if test="${page == numberPages - 1}">
                                    <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/product-list?page=${page}&&start=${start}"/>'">
                                        <i class="paganation-item__icon fas fa-angle-right"></i>
                                    </button>
                                </c:if>

                        </ul>

                    </div>

                </div>

            </div>
        </div>
        <jsp:include page="include/footer.jsp" />
    </div>
</div>
<jsp:include page="include/logout-modal.jsp" />
<jsp:include page="include/js.jsp" />
</body>
</html>
