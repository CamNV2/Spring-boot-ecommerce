<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="home-filter">
    <span class="home-filter__label">Sắp xếp theo</span>
    <button class="home-filter__btn btn-default">Phổ biến</button>
    <a href="/view-product3131" class="home-filter__btn btn-default btn--primary">Mới nhất</a>
    <button class="home-filter__btn btn-default">Bán chạy</button>

    <div class="select-input">
        <span class="select-input__label">Giá</span>
        <i class=" select-input__icon fas fa-angle-down"></i>
        <!-- List option -->
        <ul class="select-input__list">
            <li class="select-input__item">
                <a href="/price-sort-asc" class="select-input-link">Giá: Thấp đến Cao</a>
            </li>
            <li class="select-input__item">
                <a href="/price-sort-desc" class="select-input-link">Giá: Cao đến thấp</a>
            </li>
        </ul>
    </div>

    <div class="home-filter__page">
                                <span class="page-number">
                                    <span class="page-current">${page + 1}</span>/${numberPage}
                                </span>
        <div class="page-control">
            <a href="#" class="page-control-btn page-control-btn--disabled">
                <i class="page-control-btn-icon fas fa-angle-left"></i>
            </a>
            <a href="" class="page-control-btn">
                <i class="page-control-btn-icon fas fa-angle-right"></i>
            </a>
        </div>
    </div>

</div>

