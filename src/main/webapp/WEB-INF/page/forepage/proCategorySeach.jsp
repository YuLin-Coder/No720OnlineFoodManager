<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../foreinclude/foreHander1.jsp"%>

<div class="breadcrumb-area pt-15 pb-15">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <!--=======  breadcrumb container  =======-->

                <div class="breadcrumb-container">
                    <nav>
                        <ul>
                            <li class="parent-page"><a href="/fore/foreIndex">Home</a></li>
                            <li>${category.name}</li>
                        </ul>
                    </nav>
                </div>

                <!--=======  End of breadcrumb container  =======-->
            </div>
        </div>
    </div>
</div>

<!--=====  End of breadcrumb area  ======-->

<!--=============================================
=            shop page content         =
=============================================-->

<div class="shop-page-content mb-50">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 order-1 order-lg-2">


                <!--=======  Shop header  =======-->

                <div class="shop-header mb-30">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-12 d-flex align-items-center">
                            <!--=======  view mode  =======-->
                            <div class="view-mode-icons mb-xs-10">
                                <a href="#" data-target="grid"><i class="icon ion-md-apps"></i></a>
                                <a class="active"  href="#" data-target="list"><i class="icon ion-ios-list"></i></a>
                            </div>

                        </div>
                        <div class="col-lg-8 col-md-8 col-sm-12 d-flex flex-column flex-sm-row justify-content-between align-items-left align-items-sm-center">
                            <!--=======  Sort by dropdown  =======-->

                            <div class="sort-by-dropdown d-flex align-items-center mb-xs-10">

                            </div>

                            <!--=======  End of Sort by dropdown  =======-->

                            <p class="result-show-message">搜索结果${proSize}条</p>
                        </div>
                    </div>
                </div>

                <!--=======  End of Shop header  =======-->

                <!--=======  shop product display area  =======-->
                <div class="shop-product-wrap list row mb-30 no-gutters">
                    <c:forEach items="${products}" var="p">
                        <div class="col-lg-3 col-md-6 col-sm-6 col-12">
                            <div class="fl-product shop-grid-view-product">
                                <div class="image">
                                    <a href="foreDetailUI?id=${p.id}">
                                        <c:choose>
                                            <c:when test="${fn:contains(p.imageurl, ',')}">
                                                <c:set value="${fn:split(p.imageurl,',')}" var="imgurls" />
                                                <c:forEach items="${imgurls}" var="imgBO" varStatus="imgStatus">
                                                    <c:if test="${imgStatus.index==0}">
                                                        <img src="${pageContext.request.contextPath}${imgBO}" class="img-fluid img2" alt=""style="width: 283px;height: 188px;">
                                                        <img src="${pageContext.request.contextPath}${imgBO}" class="img-fluid img2" alt="" style="width: 283px;height: 188px;">
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}${p.imageurl}" class="img-fluid img" alt="" style="width: 283px;height: 188px;">
                                                <img src="${pageContext.request.contextPath}${p.imageurl}" class="img-fluid img" alt="" style="width: 283px;height: 188px;">
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                    <!-- wishlist icon -->
                                    <span class="wishlist-icon">
                                            <a href="#" ><i class="icon ion-md-heart-empty"></i></a>
                                    </span>
                                </div>
                                <div class="content">
                                    <h2 class="product-title"> <a href="foreDetailUI?id=${p.id}">${p.name}</a></h2>
                                    <p class="product-price">
                                        <span class="main-price discounted">$${p.price+10}</span>
                                        <span class="discounted-price">$${p.price}</span>
                                    </p>

                                </div>
                            </div>


                            <div class="fl-product shop-list-view-product">
                                <div class="image">
                                    <a href="foreDetailUI?id=${p.id}">
                                        <c:choose>
                                            <c:when test="${fn:contains(p.imageurl, ',')}">
                                                <c:set value="${fn:split(p.imageurl,',')}" var="imgurls" />
                                                <c:forEach items="${imgurls}" var="imgBO" varStatus="imgStatus">
                                                    <c:if test="${imgStatus.index==0}">
                                                        <img src="${pageContext.request.contextPath}${imgBO}" class="img-fluid img2" alt="" style="width: 283px;height: 188px;">
                                                        <img src="${pageContext.request.contextPath}${imgBO}" class="img-fluid img2" alt="" style="width: 283px;height: 188px;">
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}${p.imageurl}" class="img-fluid img" alt="" style="width: 283px;height: 188px;">
                                                <img src="${pageContext.request.contextPath}${p.imageurl}" class="img-fluid img" alt=""  style="width: 283px;height: 188px;">
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </div>
                                <div class="content" style="padding-top: 55px">
                                    <h2 class="product-title"> <a href="foreDetailUI?id=${p.id}">${p.name}</a></h2>
                                    <br/>
                                    <p>${p.miaoshu}</p>
                                    <p class="product-price">
                                        <span class="main-price discounted">$${p.price+15}</span>
                                        <span class="discounted-price">$${p.price}</span>
                                    </p>
                                </div>
                            </div>

                            <!--=======  End of list view product  =======-->
                        </div>
                    </c:forEach>


                </div>

                <!--=======  End of shop product display area  =======-->
            </div>
        </div>
    </div>
</div>

<!--=====  End of shop page content  ======-->
<%@ include file="../../foreinclude/foreFooter.jsp"%>
