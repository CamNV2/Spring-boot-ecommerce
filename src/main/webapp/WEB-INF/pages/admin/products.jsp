<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
                        <a href="/home" class="home-link">
                            <i class=" fas fa-home"></i>
                        </a>
                        <div class="title-heading">Manager Product</div>
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
                    <form:form action="${pageContext.request.contextPath}/admin/result" modelAttribute="product" enctype="multipart/form-data" method="post">
                        <div class="form-custom">
                            <div class="form__item">
                                <div class="form_group">
                                    <div class="form_input">
                                        <input type="text" name="productName" value="${product.productName}" class="input-control__form" placeholder=" " required>
                                        <label class="form__label">Product Name</label>
                                        <i class="fas fa-file-signature input-icon"></i>
                                    </div>
                                    <div class="form_input">
                                        <input type="text" name="price" value="${product.price}" class="input-control__form" placeholder=" ">
                                        <label class="form__label">Price</label>
                                        <i class="fas fa-file-signature input-icon"></i>
                                    </div>
                                    <div class="form_input">
                                        <input type="number" name="quantity" value="${product.quantity}" class="input-control__form" placeholder=" " min="0" required>
                                        <label class="form__label">Quantity</label>
                                        <i class="fas fa-file-signature input-icon"></i>
                                    </div>
                                    <div class="form_input">
                                        <input type="text" name="warranty" value="${product.warranty}" class="input-control__form" placeholder=" ">
                                        <label class="form__label">Warranty</label>
                                        <i class="fas fa-file-signature input-icon"></i>
                                    </div>
                                    <input type="hidden" name="image" value="${product.image}" class="input-control__form" >
                                    <div class="form_input">
                                        <select name="sales.saleId" class="input-control__form" placeholder=" ">
                                            <c:forEach var="sale" items="${sales}" >
                                                <c:if test="${sale.salePercent == product.sales.salePercent}">
                                                    <option selected="selected" value="${sale.saleId}">${sale.saleId}</option>
                                                </c:if>
                                                <c:if test="${sale.salePercent != product.sales.salePercent}">
                                                    <option value="${sale.saleId}">${sale.saleId}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                        <label class="form__label">Sale</label>
                                        <i class="fas fa-file-signature input-icon"></i>
                                    </div>
                                    <div class="form_input">
                                        <select name="category.id" class="input-control__form" placeholder=" ">
                                            <c:forEach var="c" items="${categories}" >
                                                <c:if test="${c.categoryName == product.category.categoryName}">
                                                    <option selected="selected" value="${c.id}">${c.categoryName}</option>
                                                </c:if>
                                                <c:if test="${c.categoryName != product.category.categoryName}">
                                                    <option  value="${c.id}">${c.categoryName}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                        <label class="form__label">Category</label>
                                        <i class="fas fa-file-signature input-icon"></i>
                                    </div>
                                    <div class="form_input">
                                            <textarea type="text" name="description"  class="input-control__form" rows="3"
                                                      placeholder=" ">${product.description}</textarea>
                                        <label class="form__label">Description</label>
                                        <i class="fas fa-file-signature input-icon__des"></i>
                                    </div>
                                </div>
                                <c:if test="${action =='add'}">
                                    <button type="submit" class="form-btn btn btn-primary ">
                                        <span class="action-text">
                                            Create Product
                                        </span>
                                    </button>
                                </c:if>
                                <c:if test="${action =='update'}">
                                    <input type="hidden" value="${product.id}" name="id">
                                    <button type="submit" class="form-btn btn btn-warning ">
                                        <span class="action-text">
                                            Update Product
                                        </span>
                                    </button>
                                </c:if>
                            </div>

                            <div class="img_item">
                                <img src="/resources/images/product/${product.image}" class="img-custom" id="thumbnail"/>
                                <input type="file" class="file-img" id="fileImage" name="file"
                                       accept="image/png , image/jpg, image/jpeg"/>
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
<script type="text/javascript">
    $(document).ready(function () {
        $('#fileImage').change(function () {
            showThumbnailImage(this);
        })
    });

    function showThumbnailImage(fileInput) {
        file = fileInput.files[0];
        reader = new FileReader();

        reader.onload = function (e) {
            $('#thumbnail').attr('src', e.target.result);
        };
        reader.readAsDataURL(file);
    }
</script>
</body>
</html>
