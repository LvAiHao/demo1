<%--
  Created by IntelliJ IDEA.
  User: liliting
  Date: 2019/3/12
  Time: 上午10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>BookList</title>
    <link href="/static/css/bootstrap.css" rel="stylesheet" type="text/css">
    <script src="/static/js/jquery-1.11.0.js" type="text/javascript"></script>
    <script src="/static/js/bootstrap.js" type="text/javascript"></script>
</head>
<body>

    <form class="form-inline" action="/selectByPage" method="post" id="fenyeForm">
        <input type="hidden" name="nowPage" id="nowPage">

        <div class="form-group">
            <label for="username">书名</label>
            <input id="username" name="title" value="${book.title}" type="text" class="form-control" style="width: 300px;" />
        </div>
        <div class="form-group">
            <label for="password">作者</label>
            <input id="password" name="author" value="${book.author}" type="text" class="form-control" style="width: 300px;" />
        </div>
        <div class="form-group">
            <input type="submit" class="btn-info" style="width: 50px;"  value="查询"/>
        </div>
        <br>
        <br>
        <hr>

        <table border="1" class="table table-bordered table-striped table-responsive table-hover">
            <tr>
                <td>编号</td>
                <td>书名</td>
                <td>作者</td>
                <td>价格</td>
                <td>出版时间</td>
                <td>操作</td>
            </tr>
            <c:forEach items="${map.books}" var="b">
                <tr>
                    <td>${b.id}</td>
                    <td>${b.title}</td>
                    <td>${b.author}</td>
                    <td>${b.price}</td>
                    <td>${b.publishDate}</td>
                    <td>
                        <button class="btn btn-danger" onclick="delFun(${b.id})">删除</button>
                        <button class="btn btn-warning" href="update?id=#{b.id}">修改</button>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <div style="vertical-align: center;text-align: center;width: 500px">
            <button class="btn-info" onclick="fenyeFun(1)">首页</button>
            <c:if test="${nowPage>1}">
                <button class="btn-info" onclick="fenyeFun(${nowPage-1})">上一页</button>
            </c:if>
            <c:if test="${nowPage<map.totalPage}">
                <button class="btn-info" onclick="fenyeFun(${nowPage+1})">下一页</button>
            </c:if>
            <button class="btn-info" onclick="fenyeFun(${map.totalPage})">末页</button>
            <span>
                <strong>
                    当前是第${nowPage}页,总共${map.totalPage}页
                </strong>
            </span>
        </div>

        <script type="text/javascript">
            function fenyeFun(num){
                $("#nowPage").val(num);

                /*提交表单*/
                $("#fenyeForm").submit();
            }

            function delFun(id){
                var $btn = $(this);
                if(confirm("是否确认删除？")){
                    $.ajax({
                        url:"/del",
                        data:{id:id},
                        dataType:'json',
                        success:function(r){
                            if(r.code==0){
                                $btn.parent().parent().remote();
                            }
                        }
                    });
                }
            }
        </script>



    </form>
</body>
</html>
