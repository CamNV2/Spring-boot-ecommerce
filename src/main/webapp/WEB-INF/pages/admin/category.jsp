<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="include/css.jsp" />

</head>
<body>
<div id="toasts">
    <c:if test="${type != null && type != '' && type == 'fail'}">
        <div class="toasts toast--error  ">
            <div class="toast__icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="toast__body">
                <h3 class="toast__title">
                    Error
                </h3>
                <p class="toast__msg">
                        ${message}
                </p>
            </div>
        </div>
    </c:if>
</div>
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
                    <form action="#" method="post">
                        <div class="form-search">
                            <input type="text" name="key" class="input_control" placeholder="search..." value="${key}">
                            <button class="btn_primary btn__default"><i class="fas fa-search"></i></button>
                        </div>
                    </form>
                </div>
                <div class="main_container">
                    <c:if test="${action == 'add'}">
                        <div class="title_action add-action">
                            Add Product
                        </div>
                    </c:if>
                    <c:if test="${action == 'update'}">
                        <div class="title_action update-action">
                            Update Product
                        </div>
                    </c:if>
                    <hr class="sidebar-divider my-0">
                    <form:form action="/admin/category/result" modelAttribute="category" method="post">
                        <div class="form-custom">
                            <div class="form__item">
                                <div class="form_group">
                                    <div class="form_input">
                                        <input type="text" name="categoryName" value="${category.categoryName}" class="input-control__form" placeholder=" " required>
                                        <label class="form__label">Category Name</label>
                                        <i class="fas fa-file-signature input-icon"></i>
                                    </div>
                                    <div class="form_input">
                                        <input type="text" name="description" value="${category.description}" class="input-control__form" placeholder=" " required>
                                        <label class="form__label">Description</label>
                                        <i class="fas fa-file-signature input-icon"></i>
                                    </div>
                                <c:if test="${action =='add'}">
                                    <button type="submit" class="form-btn btn btn-primary ">
                                        <span class="action-text">
                                            Create Category
                                        </span>
                                    </button>
                                </c:if>
                                <c:if test="${action =='update'}">
                                    <input type="hidden" value="${category.id}" name="id">
                                    <button type="submit" class="form-btn btn btn-warning ">
                                        <span class="action-text">
                                            Update Category
                                        </span>
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </form:form>
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
