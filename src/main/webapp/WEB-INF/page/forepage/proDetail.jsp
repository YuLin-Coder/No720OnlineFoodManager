
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
                            <li class="parent-page"><a href="#">商品</a></li>
                            <li>详细信息</li>
                        </ul>
                    </nav>
                </div>

            </div>
        </div>
    </div>
</div>


<div class="single-product-content-area mb-50">
    <div class="container">
        <div class="row">
            <div class="col-lg-5 col-md-6 col-xs-12 mb-xxs-25 mb-xs-25 mb-sm-25">
                <!-- single product tabstyle one image gallery -->
                <div class="product-image-slider fl-product-image-slider fl3-product-image-slider">
                    <!--product large image start -->
                    <div class="tab-content product-large-image-list fl-product-large-image-list fl3-product-large-image-list" id="myTabContent">
                        <div class="tab-pane fade show active" id="single-slide-1" role="tabpanel" aria-labelledby="single-slide-tab-1">
                            <!--Single Product Image Start-->
                            <div class="single-product-img img-full">
                                <c:choose>
                                    <c:when test="${fn:contains(product.imageurl, ',')}">
                                        <c:set value="${fn:split(product.imageurl,',')}" var="imgurls" />
                                        <c:forEach items="${imgurls}" var="imgBO" varStatus="imgStatus">
                                            <c:if test="${imgStatus.index==0}">
                                                <img src="../../${imgBO}" class="img-fluid" alt="">
                                                <a href="../../${imgBO}" class="big-image-popup"><i class="fa fa-search-plus"></i></a>
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="../../${product.imageurl}" class="img-fluid" alt="">
                                        <a href="../../${product.imageurl}" class="big-image-popup"><i class="fa fa-search-plus"></i></a>

                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!--Single Product Image End-->
                        </div>
                    </div>
                    <!--product large image End-->

                    <!--product small image slider Start-->
                    <div class="product-small-image-list fl-product-small-image-list fl3-product-small-image-list">
                        <div class="nav small-image-slider fl3-small-image-slider" role="tablist">
                            <c:choose>
                                <c:when test="${fn:contains(product.imageurl, ',')}">
                                    <c:set value="${fn:split(product.imageurl,',')}" var="imgurls" />
                                    <c:forEach items="${imgurls}" var="imgBO" varStatus="imgs">
                                        <div class="single-small-image img-full">
                                            <a  href="javascript:;">
                                                <img src="../../${imgBO}" class="img-fluid" alt="" style="height: 101px;width: 98px;">
                                            </a>
                                        </div>
                                      </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="single-small-image img-full">
                                        <a  href="javascript:;">
                                            <img  src="../../${product.imageurl}" class="img-fluid ces" alt=""   style="height: 101px;width: 98px;">
                                        </a>

                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <!--product small image slider End-->
                </div>
                <!-- end of single product tabstyle one image gallery -->
            </div>

            <div class="col-lg-6 col-md-6 col-xs-12">
                <!-- product view description -->
                <div class="product-feature-details">
                    <h2 class="product-title mb-15">${product.name}</h2>

                    <div class="rating d-inline-block mb-15">
                        <i class="fa fa-star active"></i>
                        <i class="fa fa-star active"></i>
                        <i class="fa fa-star active"></i>
                        <i class="fa fa-star active"></i>
                        <i class="fa fa-star"></i>
                    </div>

                    <p class="d-inline-block ml-10 review-link">
                        <a href="#">
                            <c:if test="${rs==null}">(0 customer review)</c:if>
                            <c:if test="${rs!=null}">(${rs} customer review)</c:if>
                        </a>
                    </p>

                    <h2 class="product-price mb-0">
                        <span class="main-price discounted">$${product.price+15}</span>
                        <span class="discounted-price"> $${product.price}</span>
                    </h2>

                    <p class="product-description mb-20">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;所有食品已严格把关，无任何食品安全问题，价格公道，食品美味，
                        值得拥有，你还在等什么，感觉给自己点上一份香喷喷的美食犒劳自己吧！
                        <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;卖家承诺，如果有任何食品安全问题，无条件全额退款
                    </p>

                    <div class="cart-buttons mb-20">
                        <span class="quantity-title mr-10">数量: </span>
                        <div class="pro-qty mb-20">
                            <input type="text" value="1" id="num">
                        </div>
                        <div class="add-to-cart-btn d-block">
                            <a href="#" class="fl-btn" id="add_cart"><i class="fa fa-shopping-cart"></i> 加入购物车</a>
                        </div>
                    </div>

                    <p class="wishlist-link mb-20 pb-15">
                        <a href="javascript:void(0);" id="nowPayment"> <i class="icon ion-md-options"></i> 立即购买</a>
                    </p>

                    <div class="category-list-container mb-20">
                        <span>商家: </span>
                        <ul>
                            <li>${product.user.name}</li>
                        </ul>
                    </div>
                </div>
                <!-- end of product quick view description -->
            </div>
        </div>
    </div>
</div>

<!--=====  End of single product content  ======-->

<!--=======  product description review   =======-->

<div class="product-description-review-area mb-50">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <!--=======  product description review container  =======-->

                <div class="tab-slider-wrapper product-description-review-container">
                    <nav>
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                            <a class="nav-item nav-link active" id="description-tab" data-toggle="tab" href="#product-description" role="tab"
                               aria-selected="true">描述</a>
                            <a class="nav-item nav-link" id="review-tab" data-toggle="tab" href="#review" role="tab"
                               aria-selected="false">评价</a>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="product-description" role="tabpanel" aria-labelledby="description-tab">
                            <!--=======  product description  =======-->
                            <div class="product-description">
                                <p>商家所在地：${product.user.address}</p>
                                <p>人气：${product.zan}</p>
                                <p>销量：${product.number}</p>
                                <p>商品描述：${product.miaoshu}</p>
                            </div>

                            <!--=======  End of product description  =======-->
                        </div>
                        <div class="tab-pane fade" id="review" role="tabpanel" aria-labelledby="review-tab">
                            <!--=======  review content  =======-->
                        <c:if test="${reviews.size()==0}">
                            <div class="product-ratting-wrap">

                                <div class="rattings-wrapper">

                                        <div class="sin-rattings">
                                            <div class="ratting-author">
                                                <h3>该商品暂无评论！</h3>
                                            </div>

                                        </div>


                                </div>
                            </div>
                        </c:if>
                        <c:if test="${reviews.size()>0}">
                            <div class="product-ratting-wrap">

                                <c:forEach items="${reviews}" var="review">
                                <div class="rattings-wrapper">

                                    <div class="sin-rattings">
                                        <div class="ratting-author">
                                            <h3>${review.customer.name}</h3>
                                            <div class="ratting-star">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <span>(5)</span>
                                            </div>
                                        </div>
                                        <p>${review.content}</p>
                                    </div>


                                </div>
                                </c:forEach>
                            </div>
                        </c:if>
                            <!--=======  End of review content  =======-->
                        </div>
                    </div>
                </div>

                <!--=======  End of product description review container  =======-->
            </div>
        </div>
    </div>
</div>

<!--=======  End of product description review   =======-->

<!--=============================================
=            related product slider         =
=============================================-->

<div class="related-product-slider-area mb-50">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <!--=======  section title  =======-->

                <div class="section-title">
                    <h2>为您推荐</h2>
                </div>

                <!--=======  End of section title  =======-->
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <!--=======  tab product slider  =======-->
                <div class="fl-slider tab-product-slider">
                    <!--=======  single product  =======-->
                    <c:forEach items="${fivePro}" var="pf">
                    <div class="fl-product">
                        <div class="image">
                            <a href="foreDetailUI?id=${pf.id}">
                                <c:choose>
                                    <c:when test="${fn:contains(pf.imageurl, ',')}">
                                        <c:set value="${fn:split(pf.imageurl,',')}" var="imgurls" />
                                        <c:forEach items="${imgurls}" var="imgBO">
                                            <img src="../../${imgBO}" class="img-fluid" alt="" style="width: 224px;height: 179px;">                                                    </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <img  src="../../${pf.imageurl}" class="img-fluid ces" alt=""  style="width: 224px;height: 179px;">
                                        <img  src="../../${pf.imageurl}" class="img-fluid ces" alt=""  style="width: 224px;height: 179px;">
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <!-- wishlist icon -->
                            <span class="wishlist-icon">
                                        <a href="#" ><i class="icon ion-md-heart-empty"></i></a>
                                </span>
                        </div>
                        <div class="content">
                            <h2 class="product-title"> <a href="foreDetailUI?id=${pf.id}">${pf.name}</a></h2>
                            <div class="rating">
                                <i class="fa fa-star active"></i>
                                <i class="fa fa-star active"></i>
                                <i class="fa fa-star active"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                            <p class="product-price">
                                <span class="main-price discounted">$${pf.price+15.1}</span>
                                <span class="discounted-price">$${pf.price}</span>
                            </p>
                        </div>
                    </div>
                    </c:forEach>
                    <!--=======  End of single product  =======-->
                </div>
                <!--=======  End of tab product slider  =======-->
            </div>
        </div>
    </div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <!--登录框头部-->
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin: 0px;">
                    ×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    欢迎登录！
                </h4>
            </div>
            <!--登录框中间部分(from表单)-->
            <div class="modal-body">
               <%-- <form class="form-horizontal">--%>
                   <div class="loginErrorMessageDiv">
                       <div class="alert alert-danger" >
                           <span class="errorMessage"></span>
                       </div>
                   </div>
                    <!--用户框-->
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="name" id="name" placeholder="请填写用户名" required="required">
                        </div>
                    </div>
                    <!--密码框-->
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label" >密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="password" name="password" placeholder="请填写密码" required="required">
                        </div>
                    </div>
                    <!--登录按钮-->
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="button" class="btn btn-default" id="modalLogin">登录</button>
                        </div>
                    </div>
                <%--</form>--%>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript">
    $(function () {
        $("div.loginErrorMessageDiv").hide();
        var number;
        //立即购买按钮
        $("#nowPayment").click(function(){
            //ajax判断是否登录
            $.get(
                "foreIsLogin",
                function(result) {
                    if (result=="true"){ //
                        number = $("#num").val();
                        var totalPrice = number*${product.price};
                        location.href= "forebuyone?pid=${product.id}&number="+number+"&totalPrice="+totalPrice;
                    }else {  //未登录
                        $('#myModal').modal('show')
                    }
                }
            );//登录结束
        });
        //添加到购物车
        $("#add_cart").click(function () {
            $.get(
                "foreIsLogin",
                function(result) {
                    if (result=="true"){ //已登录则加入购物车
                        //ajax添加到购物车
                        number = $("#num").val();
                        var totalPrice = number*${product.price};
                        $.get(
                            "foreAddCart",
                            {pid:${product.id},number:number,totalPrice:totalPrice},
                            function(data){
                                if(data=="success"){
                                    alert("添加购物车成功");
                                }else{
                                    alert("添加购物车失败");
                                }
                            }
                        );//添加购物车结束
                    }else {  //未登录
                        $('#myModal').modal('show')
                    }
                }
            );//登录结束
        });
        //模态窗口登录
        $("#modalLogin").click(function () {
            var name = $("#name").val();
            var password = $("#password").val();
            if(0==name.length||0==password.length){
                $("span.errorMessage").html("请输入账号密码");
                $("div.loginErrorMessageDiv").show();
                return false;
            }
            $.post(
                "foreLogin",
                {name:name,password:password},
                function (result) {
                    if("success"==result.type){
                        location.reload();
                    }else{
                        $("span.errorMessage").html("账号或密码错误");
                        $("div.loginErrorMessageDiv").show();
                    }
                }
            );
        });

    });
</script>
<!--=====  End of related product slider  ======-->
<%@ include file="../../foreinclude/foreFooter.jsp"%>