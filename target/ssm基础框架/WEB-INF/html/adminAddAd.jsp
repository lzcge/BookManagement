<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>系统管理员-录入管理员</title>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
  <link rel="stylesheet" type="text/css" href="../font-awesome/css/font-awesome.min.css">
  <link rel="stylesheet" type="text/css" href="../style/adminMain.css">
  <link rel="stylesheet" type="text/css" href="../style/adminReader.css">
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
          $(".left ul li:eq(3)").css("color","#FFF");
          $(".left ul li:eq(3)").css("background-color","#B78DE7");
          $(".left ul").find('li:eq(3)').children(".trig").css('display', 'block');


          //确认添加
         $(".add_btn").click(function () {

             if($(".adId").val()=="")alert("编号不能为空");
             else  if($(".adName").val()=="")alert("用户名不能为空");
             else  if($(".adPassword").val()=="")alert("初始密码不能为空");
             else  if($(".adPhone").val()=="")alert("电话不能为空");
             else{
                 $.ajax({
                     url: "/SysAdmin/adminAddAd",
                     type: "POST",
                     dataType: "json",
                     contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                     data: $(".form").serialize(),
                     success: function (mes) {
                         console.log(mes);
                         $.each(mes,function (key,value) {
                             if(key==200){
                                 alert("添加成功!");
                                 $(".data input").val("");
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
         });

         $(".noadd_btn").click(function () {
             $(".data input").val("");
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
            <form class="form">
                <div class="data"><label>编号</label><input value="" class="adId" name="adId"/></div>
                <div class="data"><label>用户名</label><input value="" class="adName" name="adName"/></div>
                <div class="data"><label>初始密码</label><input value="" class="adPassword" name="adPassword"/></div>
                <div class="data"><label>电话</label><input value="" class="adPhone" name="adPhone"/></div>
                <div class="data"><label>邮箱</label><input value="" class="adEmail" name="adEmail"/></div>
            </form>
                <div class="add_btn">确认添加</div>
                <div class="noadd_btn">取消</div>
        </div>
      </div>
      <div class="clear"></div>
    </div>
   </div>
</body>
</html>