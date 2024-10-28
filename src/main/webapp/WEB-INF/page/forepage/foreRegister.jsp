
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="../../foreinclude/foreHander.jsp"%>

<div class="breadcrumb-area pt-15 pb-15">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <!--=======  breadcrumb container  =======-->

                <div class="breadcrumb-container">
                    <nav>
                        <ul>
                            <li class="parent-page"><a href="/fore/foreIndex">Home</a></li>
                            <li>注册页面</li>
                        </ul>
                    </nav>
                </div>

                <!--=======  End of breadcrumb container  =======-->
            </div>
        </div>
    </div>
</div>


<div class="page-section mb-50">
    <div class="container">

        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-3 col-xs-12"></div>
            <div class="col-sm-12 col-md-12 col-lg-6 col-xs-12">
                <form  method="post" class="loginForm" id="register-form">

                    <div class="login-form">
                        <h4 class="login-title">注册</h4>

                        <div class="row">
                            <div class="col-md-6 col-12 mb-20">
                                <label>姓名</label>
                                <input class="mb-0" type="text" name="name" id="name" placeholder="请填写姓名">
                            </div>
                            <div class="col-md-6 col-12 mb-20">
                                <label>密码</label>
                                <input class="mb-0" type="password" name="password" id="password" placeholder="请填写密码">
                            </div>
                            <div class="col-md-12 mb-20">
                                <label>地址:</label>
                                <input class="mb-0" type="text" name="address" id="address" placeholder="请填写地址">
                            </div>
                            <div class="col-md-6 mb-20">
                                <label>手机号:</label>
                                <input class="mb-0" type="text"  name="phone" id="phone" placeholder="请填写手机号">
                            </div>

                            <div class="col-12">
                                <button type="button" id="register-btn" class="register-button mt-0">注册</button>
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
      $("#register-btn").click(function(){
          var name=$("#name").val();
          var phone=$("#phone").val();
          var password=$("#password").val();
          var address=$("#address").val();
          if(name==""){
              alert("请填写姓名");
              return;
          }
          if(phone==""){
              alert("请填写手机号");
              return;
          }
          if(password==""){
              alert("请填写密码");
              return ;
          }
          if(address==""){
              alert("请填写地址");
              return ;
          }
          var data=$("#register-form").serialize();
            $.post('../../fore/foreRegister',data,function(result){
                if(result.type=="success"){
                   var br= confirm("注册成功");
                   if(br){
                       window.location.href="foreLoginUI";
                   }
                }else{
                    alert(result.message);
                }
            });
      })
    })
</script>

<%@ include file="../../foreinclude/foreFooter.jsp"%>
