
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html >
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>校园点餐后台登录</title>

    <style type="text/css">
        *{padding:0px;margin:0px;}
        body{font-family:Arial, Helvetica, sans-serif;background:url(../../images/background.jpg);font-size:12px;}
        img{border:0;}
        .lg{width:468px;height:468px;margin:100px auto;}
        .lg_top{ height:200px;width:468px;}
        .lg_main{width:400px;height:180px;margin:0 25px;}
        .lg_m_1{width:290px;height:100px;padding:60px 55px 20px 55px;}
        .ur{height:37px;line-height:37px;border:0;color:#666;width:236px;margin:4px 28px;padding-left:10px;font-size:12px;font-family:Arial, Helvetica, sans-serif;}
        .pw{height:37px;line-height:37px;border:0;color:#666;width:236px;margin:4px 28px;padding-left:10px;font-size:12px;font-family:Arial, Helvetica, sans-serif;}
        .bn{width:330px;height:72px;background:url(../../images/enter.png) no-repeat;border:0;display:block;font-size:18px;color:#FFF;font-family:Arial, Helvetica, sans-serif;font-weight:bolder;cursor:pointer;}
        .lg_foot{height:80px;width:330px;padding: 6px 68px 0 68px;}
    </style>
</head>

<body>

<div class="lg">
    <form >
        <div class="lg_top"></div>
        <div class="lg_main">
            <div class="lg_m_1">
                ${error}
                <input name="name" id="name" placeholder="用户名" value="" class="ur" />
                <input name="password" id="password" placeholder="密码" type="password" value="" class="pw" />

            </div>
        </div>
        <div class="lg_foot">
            <input type="button" value="登录" class="bn" id="login-btn" /></div>
    </form>
</div>
<script src="${pageContext.request.contextPath}/js/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript">
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
            $.ajax({
                url:'${pageContext.request.contextPath}/admin/login/login',
                type:'POST',
                data:{name:name,password:password},
                dataType:'json',
                success:function(result){
                    if(result.type=="success"){
                        var truthBeTold = window.confirm("登录成功!");
                        if (truthBeTold) {
                            location.href = "/index";
                        }
                    }else{
                        alert(result.message);
                    }
                },
                error:function(){
                    alert("网络错误");
                }
            });
        });
</script>
</body>
</html>

