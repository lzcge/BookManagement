<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>图书管理员-借阅查询</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	<link rel="stylesheet" type="text/css" href="../font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="../style/adMain.css">
   <link rel="stylesheet" type="text/css" href="../style/adCheckBook.css">
	<script type="text/javascript" src="../script/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">

        //时间格式化
        Date.prototype.format = function(fmt) {
            var o = {
                "M+" : this.getMonth()+1,                 //月份
                "d+" : this.getDate(),                    //日
                "h+" : this.getHours(),                   //小时
                "m+" : this.getMinutes(),                 //分
                "s+" : this.getSeconds(),                 //秒
                "q+" : Math.floor((this.getMonth()+3)/3), //季度
                "S"  : this.getMilliseconds()             //毫秒
            };
            if(/(y+)/.test(fmt)) {
                fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
            }
            for(var k in o) {
                if(new RegExp("("+ k +")").test(fmt)){
                    fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
                }
            }
            return fmt;
        };


	   $(document).ready(function() {
         var left_li= $(".left ul li:eq(5)");
	   	    left_li.css("color","#FFF");
          left_li.css("background-color","#BBCAF1");
          $(".left ul").find('li:eq(5)').children(".trig").css('display', 'block');
          $(".table tbody tr:odd").css("backgroundColor","#E3F2F5");


           //搜索
           $(".btn").click(function () {
               $(".table tbody").empty();
               //传送json数据
               $.ajax({
                   url: "/Manager/adCheckBook",
                   type: "POST",
                   dataType: "json",
                   contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                   <!-- 向后端传输的数据 表单数据-->
                   data : {"bookName":$(".bookName").val()},
                   success: function (mes) {
                       console.log(mes);
                       if(mes.length>0){
                           $.each(mes,function(index, item){
                               $(".table tbody").append("<tr>"+
                                   "<td>"+item.bookInfo.bookId+"</td>"+
                                   "<td>"+item.bookInfo.bookName+"</td>"+
                                   "<td>"+item.bookInfo.author+"</td>"+
                                   "<td>"+item.bookInfo.translator+"</td>"+
                                   "<td>"+item.bookInfo.price+"</td>"+
                                   "<td>"+item.bookInfo.publishCompany+"</td>"+
                                   "<td>"+new Date(item.bookInfo.comeUpTime).format("yyyy-MM-dd")+"</td>"+
                                   "<td>"+item.bookInfo.isbncode+"</td>"+
                                   "<td>"+item.bookInfo.enteringMen+"</td>"+
                                   "<td>"+item.borrowRecord.userId+"</td>"+
                                   "<td>"+new Date(item.borrowRecord.shouldTime).format("yyyy-MM-dd")+"</td>"+
                                   "<td>"+new Date(item.borrowRecord.returnTime).format("yyyy-MM-dd")+"</td>"+
                                   "</tr>");
                           });
                       }

                   },
                   error: function () {
                       alert("请求失败请重试")
                   }
               });

           });


	   });
	</script>
</head>
<body>
   <div class="ad_page">
   	<div class="header">
   		<img src="../images/logo.png">
   		<div class="state">
            <div class="ad_name"><div class="fa_i"><i class="fa fa-user"></i></div><a href="/Manager/adPersonal?id=${manager.adId}">${manager.adName}</a></div>
            <div class="out"><a href="/Main/logout">退出</a></div>
   		</div>
   		<div class="clear"></div>
   	</div>
   	<div class="content">
   		<div class="left">
   			<ul>
                <a href="/Manager/adBorrowBook"><li>读者借书<div class="trig"></div></li></a>
                <a href="/Manager/adReturnBook"><li>读者还书<div class="trig"></div></li></a>
                <a href="/Manager/adAddBook"><li>新书入库<div class="trig"></div></li></a>
                <a href="/Manager/adOutBook"><li>图书出库<div class="trig"></div></li></a>
                <a href="/Manager/adAlterBook"><li>修改图书信息<div class="trig"></div></li></a>
                <a href="/Manager/adCheckBook"><li>查阅借阅记录<div class="trig"></div></li></a>
                <a href="/Manager/adSearchBook"><li>查阅图书信息<div class="trig"></div></li></a>
                <a href="/Manager/adPersonal?id=${manager.adId}"><li>管理员中心<div class="trig"></div></li></a>
   			</ul>
   		</div>
   		<div class="right">
      <!-- class="ad_data"的div中是图书管理员系统的切换部分 -->
   			<div class="ad_data">
   				 <div class="search">
                    <input type="text" name="bookName" class="bookName" value="图书编号/图书名/借阅号" onfocus="if(value=='图书编号/图书名/借阅号') {value=''}" onblur="if (value=='') {value='图书编号/图书名/借阅号'}" />
                    <div class="btn">搜索</div>
                </div>
                      <div class="table_div">
                     <table class="table">
                     <thead>
                        <tr>
                           <th class="tdOne">图书编号</th>
                           <th>图书名称</th>
                           <th class="tdTwo">作者</th>
                           <th class="tdTwo">译者</th>
                           <th class="tdTwo">价格</th>
                           <th>出版社</th>
                           <th class="tdOne">出版日期</th>
                           <th>ISBN编码</th>
                           <th class="tdTwo">入库者</th>
                           <th class="tdOne">借阅号</th>
                           <th class="tdOne">应还日期</th>
                           <th class="tdOne">实还日期</th>
                        </tr>
                     </thead>
                     <tbody>
                         <tr>
                           <td>20151111</td>
                           <td>测试数据</td>
                           <td>张三</td>
                           <td>王五</td>
                           <td>23</td>
                           <td>人民教育出版社</td>
                           <td>2015-1-1</td>
                           <td>isbn</td>
                           <td>李斯</td>
                           <td>1122334455</td>
                           <td>2015-1-1</td>
                           <td>2015-2-1</td>
                        </tr>

                        </tbody>
                     </table>
                     <%--<table class="table">--%>
                        <%--<thead>--%>
                          <%--<th>借阅号</th>--%>
                          <%--<th>图书名</th>--%>
                          <%--<th>应还日期</th>--%>
                          <%--<th>实还日期</th>--%>
                        <%--</thead>--%>
                        <%--<tbody>--%>
                          <%--<tr>--%>
                            <%--<td>11223344</td>--%>
                            <%--<td>小王子</td>--%>
                            <%--<td>2015-11-11</td>--%>
                            <%--<td>2015-12-11</td>--%>
                          <%--</tr>--%>
                          <%--<tr>--%>
                            <%--<td>11223344</td>--%>
                            <%--<td>小王子</td>--%>
                            <%--<td>2015-11-11</td>--%>
                            <%--<td>2015-12-11</td>--%>
                          <%--</tr>--%>
                          <%--<tr>--%>
                            <%--<td>11223344</td>--%>
                            <%--<td>小王子</td>--%>
                            <%--<td>2015-11-11</td>--%>
                            <%--<td>2015-12-11</td>--%>
                          <%--</tr>--%>
                          <%--<tr>--%>
                            <%--<td>11223344</td>--%>
                            <%--<td>小王子</td>--%>
                            <%--<td>2015-11-11</td>--%>
                            <%--<td>2015-12-11</td>--%>
                          <%--</tr>--%>
                        <%--</tbody>--%>
                     <%--</table>--%>
                  </div>
                 
   			</div>
   		</div>
   		<div class="clear"></div>
   	</div>
   </div>
</body>
</html>