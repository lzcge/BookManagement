<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>图书管理员-读者还书</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	<link rel="stylesheet" type="text/css" href="../font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="../style/adMain.css">
    <link rel="stylesheet" type="text/css" href="../style/alertStyle.css">
   <link rel="stylesheet" type="text/css" href="../style/adReturnBook.css">
	<script type="text/javascript" src="../script/jquery-2.1.4.min.js"></script>
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


	       $(".add_btn").click(function () {
	           if($(".bookId").val()=="")alert("输入不能为空");
	           else{
                   //传送json数据
                   $.ajax({
                       url: "/Manager/adReturnBook",
                       type: "POST",
                       dataType: "json",
                       contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                       <!-- 向后端传输的数据 表单数据-->
                       data : {"bookId":$(".bookId").val()},
                       success: function (mes) {
                           console.log(mes);
                           $.each(mes,function(key, value){
                               if(key==400 ) alert(value);
                               else if(key==200){
                                   alert(value);
                                   $(".bookId").val("");
                               }
                           });
                       },
                       error: function () {
                           alert("请求失败请重试")
                       }
                   });
               }

           });


	   	 $(".left ul li:eq(1)").css("color","#FFF");
          $(".left ul li:eq(1)").css("background-color","#BBCAF1");
          $(".left ul").find('li:eq(1)').children(".trig").css('display', 'block');
          $('input[type=text]:first').focus();//默认光标位置在input
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
               <div class="data"><label>图书编号</label><input class="bookId" value="" type="text"/></div>
               <div class="add_btn">确认归还</div>
   			</div>
   		</div>
   		<div class="clear"></div>
   	</div>
   </div>
</body>
</html>