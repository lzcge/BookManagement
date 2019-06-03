<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>图书管理员-图书出库</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	<link rel="stylesheet" type="text/css" href="../font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="../style/adMain.css">
    <link rel="stylesheet" type="text/css" href="../style/alertStyle.css">
  <link rel="stylesheet" type="text/css" href="../style/adBook.css">
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
	   	 $(".left ul li:eq(3)").css("color","#FFF");
          $(".left ul li:eq(3)").css("background-color","#BBCAF1");
          $(".left ul").find('li:eq(3)').children(".trig").css('display', 'block');
          $(".data input").attr('disabled', 'true');
          $(".data input").eq(0).removeAttr('disabled');
           $(".add_btn").html("验证");


           //验证及删除管理员
           $(".add_btn").click(function () {
               var btn_value = document.getElementById("add_btn").innerHTML;
               if(btn_value=="验证"){
                   if($(".BookId").val()=="")alert("图书编号不能为空!");
                   else{
                       $.ajax({
                           url: "/Manager/adOutBookDisplay",
                           type: "POST",
                           dataType: "json",
                           contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                           data: {"BookId":$(".BookId").val() },
                           success: function (mes) {
                               console.log(mes);
                               $.each(mes,function (key,value) {
                                   if(key==200){
                                       var date = new Date(value.comeUpTime);
                                       $(".BookId").val(value.bookId);
                                       $(".BookName").val(value.bookName);
                                       $(".Author").val(value.author);
                                       $(".Translator").val(value.translator);
                                       $(".Price").val(value.price);
                                       $(".ISBNCode").val(value.isbncode);
                                       $(".PublishCompany").val(value.publishCompany);
                                       $(".ComeUpTime").val(date);
                                       $(".EnteringMen").val(value.enteringMen);
                                       $(".add_btn").html("确认删除");
                                   }else{
                                       alert(value)
                                   }
                               })
                           },
                           error: function () {
                               alert("失败")
                           }
                       });
                   }
               }else if(btn_value=="确认删除"){
                   //验证输入内容得合法性
                   if($(".BookId").val()=="")alert("图书编号不能为空");
                   else{
                       $.ajax({
                           url: "/Manager/adOutBook",
                           type: "POST",
                           dataType: "json",
                           contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                           data: {"BookId":$(".BookId").val() },
                           success: function (mes) {
                               console.log(mes);
                               $.each(mes,function (key,value) {
                                   if(key==200){
                                       alert("删除成功!");
                                       $(".data input").val("");
                                       $(".add_btn").html("验证");
                                   }else{
                                       alert(value)
                                   }
                               });

                           },
                           error: function () {
                               alert("失败")
                           }
                       });
                   }
               }

           });



          // $(".add_btn").click(function () {
          //       if($(".BookId").val()=="")alert("图书编号不能为空!");
          //       else{
          //           $.ajax({
          //               url: "/Manager/adOutBook",
          //               type: "POST",
          //               dataType: "json",
          //               contentType : "application/x-www-form-urlencoded;charset=UTF-8",
          //               data: $('.form').serialize(),
          //               success: function (mes) {
          //                   console.log(mes);
          //                   $.each(mes,function (key,value) {
          //                       if(key==200){
          //                           alert(value);
          //                           $(".form input").val("");
          //                       }else{
          //                           alert(value)
          //                       }
          //                   });
          //
          //               },
          //               error: function () {
          //                   alert("删除失败")
          //               }
          //           });
          //       }
          // });

          $(".noadd_btn").click(function () {
              $(".form input").val("");
              $(".add_btn").html("验证");
              $(".data input").attr('disabled', 'true');
              $(".data input").eq(0).removeAttr('disabled');
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
                <form class="form" method="post" action="#">
                    <div class="data data_1"><label>图书编号</label><input class="BookId" name="BookId" type="text"  value="输入图书编号" onfocus="if(value=='输入图书编号') {value=''}" onblur="if (value=='') {value='输入图书编号'}"/></div>
                    <div class="data"><label>图书名称</label><input name="BookName" class="BookName" value=""/></div>
                    <div class="data"><label>作者</label><input name="Author" class="Author" value="" type="text"/></div>
                    <div class="data"><label>译者</label><input name="Translator" class="Translator" value="" type="text"/></div>
                    <div class="data"><label>价格</label><input name="Price" class="Price" value="" type="text"/></div>
                    <div class="data"><label>ISBN编码</label><input name="ISBNCode" class="ISBNCode" value="" type="text"/></div>
                    <div class="data"><label>出版社</label><input name="PublishCompany" class="PublishCompany" value="" type="text"/></div>
                    <div class="data"><label>出版日期</label><input name="ComeUpTime" class="ComeUpTime" value="" type="date"  /></div>
                    <%--<div class="data"><label>借阅状态</label><input name="State" class="State" value="" type="text"/></div>--%>
                    <div class="data"><label>入库者</label><input name="EnteringMen" class="EnteringMen" value="" type="text"/></div>
                   <div class="add_btn" id="add_btn"></div>
                    <div class="noadd_btn">取消</div>
                </form>
   			</div>
   		</div>
   		<div class="clear"></div>
   	</div>
   </div>
</body>
</html>