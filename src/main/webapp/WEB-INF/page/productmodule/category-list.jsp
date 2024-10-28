
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../../include/publicMeta.jsp"%>
<%@include file="../../include/publicHeader.jsp"%>
<%@include file="../../include/publicMenu.jsp"%>

<section class="Hui-article-box">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 商品管理 <span class="c-gray en">&gt;</span> 商品分类管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="Hui-article">
        <article class="cl pd-20">

            <div class="cl pd-5 bg-1 bk-gray mt-20">
                <button class="btn btn-secondary radius" onclick="admin_category_add()">添加分类</button>
                如果分类无法删除的话，是因为该分类下有商品
                <span class="r">共有数据：<strong>${size}</strong> 条</span> </div>
            <table class="table table-border table-bordered table-bg">
                <thead>
                <tr>
                    <th scope="col" colspan="7">分类列表</th>
                </tr>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="" value=""></th>
                    <th width="40">ID</th>
                    <th width="100">分类名称</th>
                    <th width="100">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="category">
                    <tr class="text-c">
                        <td><input type="checkbox" value="1" name=""></td>
                        <td>${category.id}</td>
                        <td>${category.name}</td>
                        <td><a title="编辑" href="javascript:;" onclick="admin_category_edit('分类编辑','editCategory?id=${category.id}','1','','310')" class="ml-5" style="text-decoration:none">
                            <i class="Hui-iconfont">&#xe6df;</i></a> <a  deleteLink="true" title="删除" href="/category/delCategory?id=${category.id}" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </article>
    </div>
</section>
<div id="category-add-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="category-add-modal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content radius">
            <div class="modal-header">
                <h3 class="modal-title">添加商品分类</h3>
                <a class="close" data-dismiss="modal" aria-hidden="true" href="javascript:void(0);">×</a>
            </div>
            <div class="modal-body">
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3">分类名称：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input type="text" class="input-text" style="width:150px" placeholder="输入分类名称" id="name" name="name">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" id="category-save-btn">确定</button>
                <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
            </div>
        </div>
    </div>
</div>
<%@include file="../../include/publicFooter.jsp"%>
<script type="text/javascript">
    $(function(){
        $("a").click(function(){
            var deleteLink = $(this).attr("deleteLink");
            console.log(deleteLink);
            if("true"==deleteLink){
                var confirmDelete = confirm("确认要删除");
                if(confirmDelete)
                    return true;
                return false;

            }
        });
    })
    /*管理员-权限-添加*/
    function admin_category_add(){
        $("#category-add-modal").modal('show');
      /* var name = $("#newCateName").val();
       $.get(
           "addCategory",
           {"name":name},
           function (result) {
               location.reload();
           }
       );*/
    }
    //保存
    $("#category-save-btn").click(function(){
            var name=$("#name").val();
            $.ajax({
                url:'addCategory',
                type:'POST',
                data:{name:name},
                dataType:'json',
                success:function(result){
                if(result.type=="success"){
                 var br =window.confirm("添加成功");
                 if(br){
                     window.location.href='list';
                 }
                }else{
                    alert(result.message);
                }
                },error:function(){
                  alert("网络错误");
                }
            })
    });
    /*管理员-权限-编辑*/
    function admin_category_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }

</script>

</body>
</html>
