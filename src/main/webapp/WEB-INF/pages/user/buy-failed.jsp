
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Order</title>
    <jsp:include page="include/css.jsp" />
</head>
<body>
<jsp:include page="include/header.jsp" />
<div id="toasts">
    <c:if test="${message != null && message != ''}">
        <c:if test="${type != null && type != '' && type == 'success'}">
            <div class="toasts toast--success  ">
                <div class="toast__icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="toast__body">
                    <h3 class="toast__title">
                        Success
                    </h3>
                    <p class="toast__msg">
                        Order + ${message}
                    </p>
                </div>
            </div>
        </c:if>

    </c:if>
    <c:if test="${type != null && type != '' && type == 'fail'}" >
        <div class="toasts toast--error  ">
            <div class="toast__icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="toast__body">
                <h3 class="toast__title">
                    Error
                </h3>
                <p class="toast__msg">
                    Email or password is not correct , Please login again!
                </p>
            </div>
        </div>
    </c:if>
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>
