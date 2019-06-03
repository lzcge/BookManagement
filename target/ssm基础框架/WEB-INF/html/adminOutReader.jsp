<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>系统管理员-删除读者</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	<link rel="stylesheet" type="text/css" href="../font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="../style/adminMain.css">
  <link rel="stylesheet" type="text/css" href="../style/adminReader.css">
    <link rel="stylesheet" type="text/css" href="../style/adAddBook.css">
    <link rel="stylesheet" type="text/css" href="../style/alertStyle.css">
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
	      $(".left ul li:eq(1)").css("color","#FFF");
          $(".left ul li:eq(1)").css("background-color","#B78DE7");
          $(".left ul").find('li:eq(1)').children(".trig").css('display', 'block');
          $(".data input").attr('disabled', 'true');
          $(".data input").eq(0).removeAttr('disabled');
           $(".add_btn").html("验证");

           //验证及删除读者
           $(".add_btn").click(function () {
               var btn_value = document.getElementById("add_btn").innerHTML;
               if(btn_value=="验证"){
                   if($(".UserId").val()==""|| $(".UserId").val()=='输入借阅号')alert("借阅号不能为空");
                   else{
                       $.ajax({
                           url: "/SysAdmin/adminOutReaderDisplay",
                           type: "POST",
                           dataType: "json",
                           contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                           data: {"UserId":$(".UserId").val() },
                           success: function (mes) {
                               console.log(mes);
                               $.each(mes,function (key,value) {
                                   if(key==200){
                                       // $(".data input").removeAttr('disabled');
                                       $(".UserName").val(value.userName);
                                       $(".Departments").val(value.departments);
                                       $(".Major").val(value.major);
                                       $(".Phone").val(value.phone);
                                       $(".Email").val(value.email);
                                       $(".Max").val(value.max);
                                       $(".Time").val(value.time);
                                       $(".LendedNum").val(value.lendedNum);
                                       $(".add_btn").html("确认删除");
                                       // $(".sure").append("<div class='add_btn'>确认删除</div>");

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
                   if($(".UserId").val()=="" || $(".UserId").val()=="输入借阅号")alert("借阅号不能为空");
                   else{
                       $.ajax({
                           url: "/SysAdmin/adminOutReader",
                           type: "POST",
                           dataType: "json",
                           contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                           data: {"UserId":$(".UserId").val() },
                           success: function (mes) {
                               console.log(mes);
                               $.each(mes,function (key,value) {
                                   if(key==200){
                                       alert("删除成功!");
                                       $(".data input").val("");
                                       $(".add_btn").html("验证");
                                       // $(".sure").empty();
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

           $(".noadd_btn").click(function () {
               $(".data input").val("");
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
   			<div class="ad_name"><div class="fa_i"><i class="fa fa-user"></i></div><a href="/SysAdmin/adminPersonal?id=${sysAdmin.adminId}">${sysAdmin.adminName}</a></div>
        <div class="out"><a href="/Main/logout">退出</a></div>
   		</div>
   		<div class="clear"></div>
   	</div>
   	<div class="content">
   		<div class="left">
   			<ul>
                <a href="/SysAdmin/adminAddReader"><li>录入新读者<div class="trig"></div></li></a>
                <a href="/SysAdmin/adminOutReader"><li>删除读者<div class="trig"></div></li></a>
                <a href="/SysAdmin/adminAlterReader"><li>修改读者信息<div class="trig"></div></li></a>
                <a href="/SysAdmin/adminAddAd"><li>录入图书管理员<div class="trig"></div></li></a>
                <a href="/SysAdmin/adminOutAd"><li>删除图书管理员<div class="trig"></div></li></a>
                <a href="/SysAdmin/adminAlterAd"><li>修改管理员信息<div class="trig"></div></li></a>
                <a href="/SysAdmin/adminSearchReader"><li>查看读者信息<div class="trig"></div></li></a>
                <a href="/SysAdmin/adminSearchAd"><li>查看管理员信息<div class="trig"></div></li></a>
                <a href="/SysAdmin/adminPersonal?id=${sysAdmin.adminId}"><li>管理员中心<div class="trig"></div></li></a>
   			</ul>
   		</div>
   		<div class="right">
      <!-- class="ad_data"的div中是系统管理员系统的切换部分 -->
   			<div class="ad_data">
   				<div class="data data_1"><label>借阅号</label><input class="UserId" name="UserId" value="输入借阅号" onfocus="if(value=='输入借阅号') {value=''}" onblur="if (value=='') {value='输入借阅号'}"/></div>
                <div class="data"><label>用户名</label><input class="UserName"/></div>
                <div class="data"><label>学院</label><input class="Departments"/></div>
                <div class="data"><label>专业</label><input class="Major"/></div>
                <div class="data"><label>电话</label><input class="Phone"/></div>
                <div class="data"><label>邮箱</label><input class="Email"/></div>
                <div class="data"><label>借阅上限</label><input class="Max"/></div>
                <div class="data"><label>借阅期限</label><input class="Time"/></div>
                <div class="data"><label>在借数量</label><input class="LendedNum"/></div>
               <div class="add_btn" id="add_btn"></div>
                <div class="noadd_btn">取消</div>
   			</div>
   		</div>
   		<div class="clear"></div>
   	</div>
   </div>
</body>
</html>