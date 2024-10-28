
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
                            <li>orders</li>
                        </ul>
                    </nav>
                </div>

                <!--=======  End of breadcrumb container  =======-->
            </div>
        </div>
    </div>
</div>

<style>
    .order_goods_list li{float:left; height:80px;line-height:80px;}
    .order_goods_list .col01{width:20%}
    .order_goods_list .col01 img{width:60px;height:60px;border:1px solid #ddd;margin:10px auto;}
    .order_goods_list .col02{width:24%;text-align:center;}
    .order_goods_list .col02 em{color:#999;margin-left:10px}
    .order_goods_list .col03{width:10%}
    .order_goods_list .col04{width:20%}

    .order_list_th{width:1107.2px;border:1px solid #ddd;background-color:#f7f7f7;margin:20px auto 0;}
    .order_list_th li{float:left;height:30px;line-height:30px}
    .order_list_th .col01{width:35%;margin-left:20px}
    .order_list_th .col02{width:20%}
</style>
<!--=== My Account page content ===-->

<div class="page-section mb-50">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="row">
                    <!-- My Account Tab Content Start -->
                    <div class="col-lg-12 col-12">
                        <div class="tab-content" id="myaccountContent">
                            <!-- Single Tab Content Start -->
                            <div class="tab-pane fade show active"  role="tabpanel">
                                <div class="myaccount-content">
                                    <h3>Orders</h3>
                                    <c:forEach items="${os}" var="order" varStatus="vs">
                                    <ul style="float:left" class="order_list_th">
                                        <li class="col01">${vs.count}&nbsp;&nbsp;&nbsp;&nbsp;订单号：${order.code},已支付</li>
                                    </ul>
                                    <div class="myaccount-table table-responsive text-center">
                                        <table class="table table-bordered" width='100%' border='0' cellspacing='0' cellpadding='0'  style='table-layout: fixed'>
                                            <tbody>
                                            <tr>
                                                <td width="55%">
                                                    <c:forEach items="${order.orderItems}" var="oi">

                                                        <ul class="order_goods_list">
                                                        <li class="col01">
                                                            <c:choose>
                                                                <c:when test="${fn:contains(oi.product.imageurl, ',')}">
                                                                    <c:set value="${fn:split(oi.product.imageurl,',')}" var="imgurls" />
                                                                    <c:forEach items="${imgurls}" var="imgBO" varStatus="imgStatus">
                                                                        <c:if test="${imgStatus.index==0}">
                                                                            <img src="../../${imgBO}" class="img-fluid" alt="" style="width: 50px;height: 50px;">
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="../../${oi.product.imageurl}" class="img-fluid" alt="" style="width: 50px;height: 50px;">
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </li>
                                                        <li class="col02"><a href="foreDetailUI?id=${oi.product.id}">${oi.product.name}</a></li>
                                                        <li class="col03">
                                                            <c:if test="${cst.status==0}">
                                                                ${oi.product.price}
                                                            </c:if>
                                                            <c:if test="${cst.status==1}">
                                                                ${oi.product.price*0.8}
                                                            </c:if>

                                                        </li>
                                                        <li class="col03">${oi.number}</li>
                                                        <li class="col04">
                                                            <c:if test="${cst.status==0}">
                                                                $${oi.product.price*oi.number}
                                                            </c:if>
                                                            <c:if test="${cst.status==1}">
                                                                $${oi.product.price*oi.number*0.8}
                                                            </c:if>

                                                        </li>
                                                        <li ><a href="javascript:;" onclick="pingjia(${oi.product.id});">评价</a></li>
                                                        <br>
                                                    </ul>

                                                    </c:forEach>
                                                </td>
                                                <td width="15%">${order.total}元</td>
                                                <td width="15%" >
                                                    <a href="javascript:void(0);" id="view-address" data-content="${order.address}">
                                                        查看收货地址
                                                    </a>

                                                </td>
                                                <td width="15%">
                                                    <c:if test="${order.status==1}">未发货</c:if>
                                                    <c:if test="${order.status==2}">已发货</c:if>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    </c:forEach>
                                 </div>
                             </div>
                    <!-- Single Tab Content End -->
                    </div>
            </div>
        <!-- My Account Tab Content End -->
        </div>

                </div>
                </div>
        </div>
        </div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"  id="myModal" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <!--登录框头部-->
            <div class="modal-header">
                <button type="button" style="margin: 0px;" class="close" data-dismiss="modal" aria-hidden="true">
                    ×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    商品评价
                </h4>
            </div>
            <!--登录框中间部分(from表单)-->
            <div class="modal-body">
                <!--评价-->
                <div class="form-group">
                    <label for="contents" class="col-sm-4 control-label">商品评价</label>
                    <div class="col-sm-12">
                        <textarea class="form-control" style="height: 167px;" name="content" id="contents" placeholder="请填写商品评价" required="required"></textarea>
                    </div>
                </div>
                <!--登录按钮-->
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-default"  id="evaluate">评价</button>
                    </div>
                </div>
                <%--</form>--%>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/jquery/2.0.0/jquery.min.js"></script>
<script>
   var pid;
   $(function () {

       $("#view-address").click(function(){
           var that=$(this);
           var address=that.attr("data-content");
           alert(address);
       })
       //模态窗口登录
       $("#evaluate").click(function () {
           var  content = $("#contents").val();
           //评论
           $.post(
               "evaluate_product",
               {"pid":pid,"content":content},
               function(result) {
                   if(result.type="success"){
                       alert("评论成功")
                       $("#contents").val("");
                       $('#myModal').modal('hide');
                   }else{
                       alert(result.message);
                   }
               }
           );
           //get结束
       });

   });
   //点击评价 模态窗口显示
   function pingjia(productid) {
       pid=productid;
       $('#myModal').modal('show');
       //评价功能
   }

</script>
<!--====  End of My Account page content  ====-->
<%@ include file="../../foreinclude/foreFooter.jsp"%>