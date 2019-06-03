<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>系统管理员-查看读者信息</title>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
  <link rel="stylesheet" type="text/css" href="../font-awesome/css/font-awesome.min.css">
  <link rel="stylesheet" type="text/css" href="../style/adminMain.css">
  <link rel="stylesheet" type="text/css" href="../style/searchTable.css">
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
          $(".left ul li:eq(6)").css("color","#FFF");
          $(".left ul li:eq(6)").css("background-color","#B78DE7");
          $(".left ul").find('li:eq(6)').children(".trig").css('display', 'block');
          $(".table tbody tr:odd").css("backgroundColor","#DFF0D8");


         //搜索
         $(".btn").click(function () {
             if($(".userName").val()=="" || $(".userName").val()=="输入检索信息")alert("请输入检索信息");
             else{
                 $(".table tbody").empty();
                 //传送json数据
                 $.ajax({
                     url: "/SysAdmin/adminSearchReader",
                     type: "POST",
                     dataType: "json",
                     contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                     <!-- 向后端传输的数据 用userName作为传输信息的媒介-->
                     data : {"userName":$(".username").val()},
                     success: function (mes) {
                         console.log(mes);
                         if(mes.length>0){
                             $.each(mes,function(index, item){
                                 $(".table tbody").append("<tr>"+
                                     "<td>"+item.userId+"</td>"+
                                     "<td>"+item.userName+"</td>"+
                                     "<td>"+item.departments+"</td>"+
                                     "<td>"+item.major+"</td>"+
                                     "<td>"+item.phone+"</td>"+
                                     "<td>"+item.email+"</td>"+
                                     "<td>"+item.max+"</td>"+
                                     "<td>"+item.time+"</td>"+
                                     "<td>"+item.lendedNum+"</td>"+
                                     "</tr>");
                             });
                         }

                     },
                     error: function () {
                         alert("请求失败请重试")
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
         <div class="search">
              <input type="text" class="userName" name="userName" value="输入检索信息" onfocus="if(value=='输入检索信息') {value=''}" onblur="if (value=='') {value='输入检索信息'}" />
              <div class="btn">搜索</div>
          </div>
                 <div class="table_div">
                     <table class="table">
                       <thead>
                          <tr>
                             <th class="tdOne">借阅号</th>
                             <th class="tdOne">用户名</th>
                             <th>学院</th>
                             <th>专业</th>
                             <th>电话</th>
                             <th class="tdOne">邮箱</th>
                             <th>借阅上限</th>
                             <th>借阅期限</th>
                             <th>在借数量</th>
                          </tr>
                       </thead>
                       <tbody>
                           <tr>
                             <td>20151111</td>
                             <td>测试数据</td>
                             <td>计算机科学与工程学院</td>
                             <td>计算机科学与技术专业</td>
                             <td>11223344555</td>
                             <td>1111222233@qq.com</td>
                             <td>10</td>
                             <td>30</td>
                             <td>7</td>
                          </tr>

                          </tbody>
                     </table>
                  </div>
        </div>
      </div>
      <div class="clear"></div>
    </div>
   </div>
</body>
</html>