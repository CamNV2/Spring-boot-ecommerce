<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="footer">
    <div class="grid">
        <div class="grid__row">
            <div class="grid__column-2-5">
                <h3 class="footer__heading">Chăm sóc khách hàng</h3>
                <ul class="footer__list">
                    <li class="footer-item">
                        <a href="#" class="footer-item__link">Trung tâm trợ giúp</a>
                    </li>
                    <li>
                        <a href="#" class="footer-item__link">F8-shop Mall</a>
                    </li>
                    <li>
                        <a href="#" class="footer-item__link">Hướng dẫn mua hàng</a>
                    </li>
                </ul>
            </div>
            <div class="grid__column-2-5">
                <h3 class="footer__heading">Giới thiệu</h3>
                <ul class="footer__list">
                    <li class="footer-item">
                        <a href="#" class="footer-item__link">Giới thiệu về TickID Việt Nam</a>
                    </li>
                    <li>

                        <a href="#" class="footer-item__link">Tuyển dụng</a>
                    </li>
                    <li>
                        <a href="#" class="footer-item__link">Điều khoản sử dụng</a>
                    </li>
                </ul>
            </div>
            <div class="grid__column-2-5">
                <h3 class="footer__heading">Danh mục</h3>
                <ul class="footer__list">
                    <li class="footer-item">
                        <a href="#" class="footer-item__link">Laptop</a>
                    </li>
                    <li>
                        <a href="#" class="footer-item__link">Tin công nghệ</a>
                    </li>
                    <li>
                        <a href="#" class="footer-item__link">Thị trường Bitcoin</a>
                    </li>
                </ul>
            </div>
            <div class="grid__column-2-5">
                <h3 class="footer__heading">Theo dõi</h3>
                <ul class="footer__list">
                    <li class="footer-item">
                        <a href="#" class=" footer-item__link">
                            <i class="footer-item__icon fab fa-facebook"></i>
                            Facebook
                        </a>
                    </li>
                    <li>
                        <a href="#" class=" footer-item__link">
                            <i class="footer-item__icon fab fa-instagram"></i>
                            Instagram
                        </a>
                    </li>
                    <li>
                        <a href="#" class=" footer-item__link">
                            <i class="footer-item__icon fab fa-linkedin"></i>
                            Linkein
                        </a>
                    </li>
                </ul>
            </div>
            <div class="grid__column-2-5">
                <h3 class="footer__heading">Vào cửa hàng trên ứng dụng</h3>
                <div class="footer__download">
                    <img src="<c:url value="/resources/images/qr_code.png"/> " alt="" class="footer__download-qr">
                    <div class="footer__download-app">
                        <a href="#">
                            <img src="<c:url value="/resources/images/google-play.png"/> " alt="" class="footer__download-app-img">
                        </a>
                        <a href="#">
                            <img src="<c:url value="/resources/images/app-store.png"/> " alt="" class="footer__download-app-img">
                        </a>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="footer-bottom">
        <div class="grid">
            <p class="footer__text">© 2021 - Bản quyền thuộc về Spirit Nguyen</p>
        </div>
    </div>
</footer>
