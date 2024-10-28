
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../foreinclude/foreHander1.jsp"%>

<!--=============================================
=            breadcrumb area         =
=============================================-->

<div class="breadcrumb-area pt-15 pb-15">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <!--=======  breadcrumb container  =======-->

                <div class="breadcrumb-container">
                    <nav>
                        <ul>
                            <li class="parent-page"><a href="/fore/foreIndex">Home</a></li>
                            <li>information</li>
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
=            blog page content         =
=============================================-->

<div class="blog-page-content mb-50">
    <div class="container">
        <div class="row">


            <div class="col-lg-12 order-1">
                <!--=======  blog post container  =======-->

                <div class="blog-single-post-container mb-30">

                    <!--=======  post title  =======-->


                    <h3 class="post-title">校园资讯</h3>

                    <!--=======  End of post title  =======-->

                    <div class="post-content mb-40">


                        <blockquote>
                            <p>
                               发布趣味资讯或美食资讯,让更多人学习到美食制作哦！
                                <button style="float:right" class="btn btn-default"><a href="javascript:;" onclick="AddInfo();">发布</a></button>
                            </p>

                        </blockquote>

                    </div>
                    <!--=======  End of Post content  =======-->
                </div>

                <!--=======  End of blog post container  =======-->

                <!--=============================================
                =            Comment section         =
                =============================================-->

                <div class="comment-section mb-md-30 mb-sm-30">


                    <!--=======  comment container  =======-->

                    <div class="comment-container mb-40">
                        <!--=======  single comment  =======-->
                        <c:forEach items="${list}" var="z">
                        <div class="single-comment">
                            <!--
                                <span class="reply-btn"><a href="#">Reply</a></span>
                            -->
                            <div class="image">
                                <img src="assets/images/blog-image/comment-icon.png" alt="">
                            </div>
                            <div class="content">
                                <h3 class="user">${z.customer.name} <span class="comment-time"><fmt:formatDate value="${z.fabudate}" pattern="yyyy年MM月dd日HH点mm分" /></span></h3>
                                <p class="comment-text">${z.content}.</p>
                            </div>

                        </div>
                        </c:forEach>

                        <!--=======  End of single comment  =======-->
                    </div>
                    <!--=======  End of comment container  =======-->
                 <!--=======  End of comment form container  =======-->
                </div>
                <!--=====  End of Comment section  ======-->
            </div>
        </div>
    </div>
</div>

<!--=====  End of blog page content  ======-->
<!-- 模态框（Modal） -->
<div class="modal fade"  tabindex="-1" role="dialog"  id="InfoModal" aria-labelledby="InfoModalLabel" aria-hidden="true" data-backdrop="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <!--登录框头部-->
            <div class="modal-header">
                <button type="button" style="margin: 0px;" class="close" data-dismiss="modal" aria-hidden="true">
                    ×
                </button>
                <h4 class="modal-title" id="InfoModalLabel">
                    发布资讯
                </h4>
            </div>
            <!--登录框中间部分(from表单)-->
            <div class="modal-body">
                <!--评价-->
                <div class="form-group">
                    <label for="contents" class="col-sm-4 control-label">资讯信息</label>
                    <div class="col-sm-12">
                        <textarea class="form-control" rows="10" cols="10" name="content" id="contents" placeholder="请输入资讯信息" required="required"></textarea>
                    </div>
                </div>
                <input type="hidden" id="account-id" name="cstid" value="${cst.id}"/>
                <!--登录按钮-->
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-default"  id="releaseModal">发布</button>
                    </div>
                </div>
                <%--</form>--%>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/jquery/2.0.0/jquery.min.js"></script>
<script>
    function AddInfo(){
        var account=$("#account-id").val();
        if(account==""){
            alert("请先登录");
            return;
        }else{
            $('#InfoModal').modal('show');
        }

    }
    $(function () {
        $("#releaseModal").click(function () {
            var content = $("#contents").val();
            $.post(
                "infoAdd",
                {"content":content},
                function (result) {
                    if(result.type=="success"){
                        alert("已提交，请等待管理员审核！");
                        $('#InfoModal').modal('hide');
                    }else{
                        alert(result.message);
                    }
                }
            );
            //get结束
        });
    })
</script>
<!--====  End of My Account page content  ====-->
<%@ include file="../../foreinclude/foreFooter.jsp"%>