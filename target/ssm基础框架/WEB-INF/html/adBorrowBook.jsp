<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>图书管理员-读者借书</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	<link rel="stylesheet" type="text/css" href="../font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="../style/adMain.css">
    <link rel="stylesheet" type="text/css" href="../style/alertStyle.css">
   <link rel="stylesheet" type="text/css" href="../style/adBorrowBook.css">
	<script type="text/javascript" src="../script/jquery-2.1.4.min.js"></script>
   <script type="text/javascript" src="../layer-v2.0/layer/layer.js"></script>
	<script type="text/javascript">

        // 自定义弹窗
        window.alert =alert;
        function alert(e){
            $("body").append('<div id="msg"><div id="msg_top">信息<span class="msg_close">×</span></div><div id="msg_cont">'+e+'</div><div class="msg_close" id="msg_clear">确定</div></div>');
            $(".msg_close").click(function (){
                $("#msg").remove();
            });
        }

	   $(document).ready(function() {
	   	 $(".left ul li:eq(0)").css("color","#FFF");
          $(".left ul li:eq(0)").css("background-color","#BBCAF1");
          $(".left ul").find('li:eq(0)').children(".trig").css('display', 'block');
          $(".A_btn").click(function() {
              var userId = $(".userId").val();
              var bookId = $(".bookId").val();
               if(userId=="" || bookId=="") alert("输入信息不能为空!");
               else{
                  //借阅验证
                  $.ajax({
                      url : "/Manager/borrowCheck",
                      type : "POST",
                      dataType:"json",
                      contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                      <!-- 向后端传输的数据 表单数据-->
                      data : {"userId":userId,"bookId":bookId},
                      success:function(mes) {
                          $.each(mes,function (key,value) {
                                if(key==400)alert(value);  //验证错误显示错误信息
                                else if(key==200){   //验证正确
                                    alert("验证成功!");
                                    $(".sure").append("<div class='add_btn'>确认借阅</div>");
                                    $(".add_btn").click(function () {
                                        //确认借阅向后台传送信息开始借阅
                                        $.ajax({
                                            url : "/Manager/sureBorrow",
                                            type : "POST",
                                            dataType:"json",
                                            contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                                            <!-- 向后端传输要插入数据 -->
                                            data : {"userId":userId,"bookId":value.bookId,"bookName":value.bookName},
                                            success:function (result) {
                                                $.each(result,function (key2,value2) {
                                                    if(key2==400)alert("操作失败");
                                                    else if(key2==200){
                                                        console.log(value2);
                                                        alert("借阅成功");
                                                        //拼接出借阅成功的书籍
                                                        $(".table").append("<tbody> " +
                                                            "<tr>"+
                                                            "<td>"+value2.userId+"</td>" +
                                                            "<td>"+value2.bookName+"</td>" +
                                                            "<td>"+value2.shouldTime.toLocaleString()+"</td>" +
                                                            "<tr>"+
                                                            "</tbody>"
                                                        );
                                                        //将确认借阅按钮取消
                                                        $(".sure").empty();
                                                    }
                                                })
                                            }
                                        });
                                    })
                                }else{
                                    alert("未知错误！")
                                }
                          });
                      },
                      error:function(){
                          alert("请求失败请重试")
                      }
                  });
               }

          });
          $(".B_btn").click(function() {
            $(".data input").val("");
              //将确认借阅按钮取消
              $(".sure").empty();
          });
          $('input[type=text]:first').focus();//默认光标位置在input
          $(".table tbody tr:odd").css("backgroundColor","#FCF8E3");//表格奇数行背景
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
                <div class="data data_1"><label>借阅号</label><input class="userId" type="text" value=""/></div>
               <div class="data"><label>图书编号</label><input class="bookId" type="text" value=""/></div>
               <div class="btn A_btn">验证</div>
               <div class="btn B_btn">清空</div>
               <div class="table_div">
                  <table class="table">
                        <thead>
                          <th>借阅号</th>
                          <th>图书名</th>
                          <th>应还日期</th>
                        </thead>
                        <tbody>
                          <%--<tr>--%>
                            <%--<td>11223344</td>--%>
                            <%--<td>小王子</td>--%>
                            <%--<td>2015-11-11</td>--%>
                          <%--</tr>--%>
                        </tbody>
                     </table>
                   <div class="sure"></div>
                   <div class="clear"></div>
               </div>
   			</div>
   		</div>
   		<div class="clear"></div>
   	</div>
   </div>
</body>
</html>