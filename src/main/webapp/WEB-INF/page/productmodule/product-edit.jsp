
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../../include/publicMeta.jsp"%>

<article class="cl pd-20">
    <form  class="form form-horizontal" id="edit-product-form"  target="_parent">
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">分类：</label>
            <div class="formControls col-xs-8 col-sm-9"> <span class="select-box" style="width:150px;">
				<select class="select" name="cid" size="1">
                    <c:forEach items="${categoryList}" var="category">
                    <option value="${category.id}" <c:if test="${category.id==crrentCategory.id}">selected</c:if>>${category.name}</option>
                    </c:forEach>
				</select>
				</span>
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>商品名称：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="${product.name}" placeholder="请填写商品名称" id="edit-name" name="name">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>商品单价：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="number" class="input-text" autocomplete="off" value="${product.price}" placeholder="请填写商品价格" id="edit-price" name="price" min="0" max="1000" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>人气：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="number" class="input-text" autocomplete="off" value="${product.zan}" placeholder="请填写人气" id="edit-zan" name="zan">
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span> 上传图片：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <ul class="travel-pic cl" id="image-ul">
                    <c:choose>
                        <c:when  test="${fn:contains(product.imageurl,',')}">
                            <c:set value="${fn:split(product.imageurl, ',') }" var="arr" />
                            <c:forEach items="${arr}" var="imgBO">
                                <li><a href='#'><img src="./../${imgBO}" class=\"thumbnail\"></a></li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li><a href='#'><img src="../../${product.imageurl}" class=\"thumbnail\"></a></li>
                        </c:otherwise>
                    </c:choose>

                </ul>
                <input  type="hidden" name="imageurl" id="edit-imageurl" value="${product.imageurl}"/>
                <input class="btn radius btn-secondary"  onclick="uploadPhoto()" type="button" value="上传图片">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>描述：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <textarea name="miaoshu" class="textarea" id="edit-info" cols="80" rows="10" placeholder="请填写描述">${product.miaoshu}</textarea>
            </div>
        </div>
            <input type="hidden" name="id" value="${product.id}" />
        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                <input class="btn btn-primary radius" type="button" id="edit-form-btn" value="提交">
            </div>
        </div>
    </form>
</article>
<input type="file" style="display:none;" name="image" id="file-image" accept="image/*"  onchange="upload()"/>

<%@include file="../../include/publicFooter.jsp"%>

<script type="text/javascript">
    $(function(){
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

    });

    function upload(){
        if($("#file-image").val() == '')return;
        var formData = new FormData();
        formData.append('photo',document.getElementById('file-image').files[0]);
        $.ajax({
            url:'${pageContext.request.contextPath}/upload/upload_photo',
            type:'post',
            data:formData,
            contentType:false,
            processData:false,
            success:function(data){
                if(data.type == 'success'){
                    alert("上传成功");
                    var html="<li><a href='#'><img src="+data.filepath+" class=\"thumbnail\"></a></li>\n";
                    $("#image-ul").append(html);
                    var images=$("#edit-imageurl").val();
                    if(images!=""){
                        images+=","+data.filepath+",";
                        $("#edit-imageurl").val(images);
                    }else{
                        $("#edit-imageurl").val(data.filepath);
                    }
                }else{
                    alert(data.msg);
                }
            },
            error:function(data){
                alert("上传失败!");
            }
        });
    }
    function uploadPhoto(){
        $("#file-image").click();
    }

    $("#edit-form-btn").click(function(){
        var name=$("#edit-name").val();
        var price=$("#edit-price").val();
        var image=$("#edit-imageurl").val();
        var zan=$("#edit-zan").val();
        var info=$("#edit-info").val();
        if(name==""){
            alert("请填写商品名称");
            return;
        }
        if(price==""){
            alert("请填写价格");
            return;
        }
        if(image==""){
            alert("请上传图片");
            return;
        }
        if(zan==""){
            alert("请填写人气");
            return;
        }
        if(info==""){
            alert("请填写描述");
            return;
        }
        var data=$("#edit-product-form").serialize();
        $.ajax({
            url:'${pageContext.request.contextPath}/product/updateProduct',
            type:'POST',
            data:data,
            dataType:'json',
            success:function(result){
                if(result.type=="success"){
                    var br=confirm("商品编辑成功");
                    if(br){
                        window.location.reload();
                    }
                }else{
                    alert(result.message);
                }
            },
            error:function(){
                alert("网络错误");
            }
        })
    });
</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>