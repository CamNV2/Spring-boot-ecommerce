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
                        <a href="/admin/category-list" class="home-link">
                            <i class=" fas fa-home"></i>
                        </a>
                        <div class="title-heading">Manager Category</div>
                    </div>
                </div>
                <div class="main_container">
                    <div class="main-title_heading">Category List</div>
                    <hr class="sidebar-divider my-0">
                    <div class="main_heading">
                        <div class="title-pages">
                            Page ${page + 1} of ${numberPages}
                        </div>
                        <a href="<c:url value="/admin/category/add-category" /> " class="btn btn-primary"><i class="fas fa-plus-circle"></i></a>
                    </div>
                    <div class="list-item">
                        <table class="table table-hover border-primary">
                            <thead class="thead-inverse bg-primary tw-color">
                            <tr>
                                <th>Product Name</th>
                                <th>Description</th>
                                <th>Quantity Product</th>
                                <th>Status</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${categories != null}">
                            <c:forEach begin="0" end="${categories.size() - 1}" var="i" >
                                <tr>
                                    <td class="pl-10"><b>${categories[i].getCategoryName()}</b></td>
                                    <td>${categories[i].description}</td>
                                    <td class="pl-5">${countProduct[i]}</td>
                                    <td>
                                        <div class="btn-table">
                                            <c:if test="${categories[i].getStatus() == 'ACTIVE'}">
                                                <button class="btn bg-gradient-success tw-color" onclick="location.href ='<c:url value="/admin/category/change-status/${categories[i].getId()}" />' " >
                                                    <span class="status-btn">${categories[i].getStatus()}</span></button>
                                            </c:if>
                                            <c:if test="${categories[i].getStatus() == 'DISABLED' }" >
                                                <button class="btn bg-gradient-info tw-color" onclick="location.href ='<c:url value="/admin/category/change-status/${categories[i].getId()}" /> ' " >
                                                    <span class="status-btn">${categories[i].getStatus()}</span></button>
                                            </c:if>
                                        </div>
                                    </td>
                                    <td>
                                        <a class="edit-icon" href="/admin/category/update-category/${categories[i].getId()}">
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
                                    <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/category-list?page=${0}&start=${0}"/> '">
                                        <i class="paganation-item__icon fas fa-angle-left"></i>
                                    </button>
                                </c:if>
                                <c:if test="${page > 1 && start >= 1}" >
                                    <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/category-list?page=${page -1}&start=${start -1}"/> '">
                                        <i class="paganation-item__icon fas fa-angle-left"></i>
                                    </button>
                                </c:if>
                            </li>
                            <c:forEach var="i" begin="${start}" end="${numberPages}">
                                <c:if test="${i < numberPages}" >
                                    <c:if test="${page == i}">
                                        <li class="paganation-item paganation-item--active">
                                            <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/category-list?page=${i}&&start=${start}" />'">
                                                    ${i + 1}
                                            </button>
                                        </li>
                                    </c:if>
                                    <c:if test="${page != i}">
                                        <li class="paganation-item">
                                            <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/category-list?page=${i}&&start=${start}"/>'">
                                                    ${i + 1}
                                            </button>
                                        </li>
                                    </c:if>
                                </c:if>
                            </c:forEach>

                            <c:if test="${page < numberPages - 1}">
                                <li class="paganation-item">
                                    <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/category-list?page=${page + 1}&&start=${start + 1}" />'">
                                        <i class="paganation-item__icon fas fa-angle-right"></i>
                                    </button>
                                </li>
                            </c:if>
                            <c:if test="${page == numberPages - 1}">
                                <button class="paganation-item__link" onclick="location.href = '<c:url value="/admin/category-list?page=${page}&&start=${start}"/>'">
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
