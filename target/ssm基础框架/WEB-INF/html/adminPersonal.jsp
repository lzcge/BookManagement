<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>系统管理员-管理员中心</title>
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
          $(".left ul li:eq(8)").css("color","#FFF");
          $(".left ul li:eq(8)").css("background-color","#B78DE7");
          $(".left ul").find('li:eq(8)').children(".trig").css('display', 'block');
          $(".data input").attr('disabled', 'true');
          $(".inputBtn").click(function() {
             $(".data input").removeAttr('disabled');
          });
          $(".noadd_btn").click(function() {
              $(".oldPassword").val("");
              $(".newPassword").val("");
              $(".realPassword").val("");
            $(".data input").attr('disabled', 'true');
          });


         //提交修改
         $(".add_btn").click(function () {
             var oldPassword = $(".oldPassword").val();
             var newPassword = $(".newPassword").val();
             var realPassword = $(".realPassword").val();
             var phone = $(".phone").val();
             if(oldPassword!="${sysAdmin.adminPassword}"){
                 alert("原密码输入有误")
             }
             else if(oldPassword=="" || newPassword=="" || realPassword=="" || phone==""){
                 alert("任何项输入不能为空")
             }else if(newPassword != realPassword) {
                 alert("输入密码不一致");
             }else{
                 $.ajax({
                     url: "/SysAdmin/updateSysAdmain",
                     type: "POST",
                     dataType: "json",
                     contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                     data : {"adminPassword":$(".realPassword").val(),"adminPhone":$(".phone").val(),"adminEmail":$(".email").val()},
                     success: function (mes) {
                         console.log(mes);
                         $.each(mes,function (key,value) {
                             if(key==200){
                                 alert("修改成功!");
                                 $(".data input").attr('disabled', 'true');
                                 $(".ad_data input").val("");
                                 $(".inputBtn").val("修改资料");
                                 $(".phone").val(value.adminPhone);
                                 $(".email").val(value.adminEmail);
                             }else{
                                 alert(value);
                             }
                         })
                     },
                     error: function () {
                         alert("失败")
                     }

                 });
             }

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
                <input class="inputBtn" style="width:100px;height:34px;margin:0px 0px 20px 150px;font-size:16px"
                type="button" value="修改资料" />
               <div class="data data_1"><label style="color:red">原密码必填。不修改密码时，填入与原来相同的密码</label></div>
            <div class="data"><label>原密码</label><input class="oldPassword" name="oldPassword" type="password" value=""/></div>
            <div class="data"><label>新密码</label><input class="newPassword" name="newPassword" type="password" value=""/></div>
            <div class="data"><label>确认新密码</label><input class="realPassword" name="realPassword" type="password" value=""/></div>
            <div class="data"><label>电话</label><input name="phone" class="phone" value="${sysAdmin.adminPhone}" /></div>
            <div class="data"><label>邮箱</label><input name="email" class="email" type="email" value="${sysAdmin.adminEmail}"/></div>
            <div class="add_btn">提交修改</div>
            <div class="noadd_btn">取消</div>
        </div>
      </div>
      <div class="clear"></div>
    </div>
   </div>
</body>
</html>