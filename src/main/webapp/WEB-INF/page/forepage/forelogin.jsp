<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../foreinclude/foreHander.jsp"%>


<div class="breadcrumb-area pt-15 pb-15">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="breadcrumb-container">
                    <nav>
                        <ul>
                            <li class="parent-page"><a href="/fore/foreIndex">Home</a></li>
                            <li>登录</li>
                        </ul>
                    </nav>
                </div>

            </div>
        </div>
    </div>
</div>


<div class="page-section mb-50">
    <div class="container">

        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-3 col-xs-12">


            </div>
            <div class="col-sm-12 col-md-12 col-xs-12 col-lg-6 mb-30">
                <!-- Login Form s-->
                <form method="post" class="loginForm">

                    <div class="login-form">

                        <h4 class="login-title">登录</h4>

                        <div class="row">
                            <div class="col-md-12 col-12 mb-20">
                                <label>用户名</label>
                                <input name="name" id="name" class="mb-0" type="text" placeholder="请输入用户名">
                            </div>
                            <div class="col-12 mb-20">
                                <label>密码</label>
                                <input name="password" id="password" class="mb-0" type="password" placeholder="请输入密码">
                            </div>

                            <div class="col-md-12">
                                <button type="button" id="login-btn" class="register-button mt-0">登录</button>
                            </div>

                        </div>
                    </div>

                </form>
            </div>

        </div>
    </div>
</div>

<!--=====  End of Login Register page content  ======-->
<script src="${pageContext.request.contextPath}/js/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript">
    $(function () {

        $("#login-btn").click(function(){
            var name=$("#name").val();
            var password=$("#password").val();
            if(name==""){
                alert("请填写用户名");
                return;
            }
            if(password==""){
                alert("请填写密码");
                return;
            }
            $.post('foreLogin',{name:name,password:password},function(result){
                if(result.type=="success"){
                    var br=confirm("登录成功");
                    if(br){
                        window.location.href="foreIndex";
                    }
                }else{
                    alert(result.message);
                }
            });
        })
    })
</script>

<%@ include file="../../foreinclude/foreFooter.jsp"%>
