<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>修改密码</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	<link rel="stylesheet" type="text/css" href="../font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="../style/readerMain.css">
    <link rel="stylesheet" type="text/css" href="../style/alertStyle.css">
	<link rel="stylesheet" type="text/css" href="../style/readerAlterPaswd.css">
	<script type="text/javascript" src="../script/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">

        // 自定义弹窗
        window.alert =alert;
        function alert(e){
            $("body").append('<div id="msg"> <div id="msg_top">信息<span class="msg_close">×</span></div><div id="msg_cont">'+e+'</div><div class="msg_close" id="msg_clear">确定</div></div>');
            $(".msg_close").click(function (){
                $("#msg").remove();
                if(e=="修改成功"){
                    window.location.href="/UserInfo/readerPerCenter?id=${userInfo.userId}";
                }
            });
        }



        //修改提交
        $(document).ready(function() {
            //ajax动态生成查询结果
            $(".add_btn").click(function () {
                var oldPassword = $(".oldPassword").val();
                var newPassword = $(".newPassword").val();
                var realPassword = $(".realPassword").val();
                if(oldPassword=="" || newPassword=="" || realPassword==""){
                    alert("任何项输入不能为空")
                }else if(newPassword != realPassword){
                    alert("输入密码不一致")
                }else{
                    //传送json数据
                    //判断原密码输入是否正确
                    $.ajax({
                        url: "/User/readerLoginCheck",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                        data : {"userId":${userInfo.userId},"passWord":oldPassword},
                        success: function (mes) {
                            console.log(mes);
                            $.each(mes,function(key, value){
                                if(key==400 ) alert("原密码输入有误!");
                                else if(key==200){
                                    //原密码正确，修改密码
                                    $.ajax({
                                        url: "/User/updateReaderPassword",
                                        type: "POST",
                                        dataType: "json",
                                        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                                        data : {"userId":${userInfo.userId},"passWord":realPassword},
                                        success: function (mes) {
                                            console.log(mes);
                                            $.each(mes,function(key, value){
                                                if(key==400 ) alert(value);
                                                else if(key==200){
                                                    alert("修改成功");
                                                }
                                                else{
                                                    alert("未知错误")
                                                }
                                            });
                                        },
                                        error: function () {
                                            alert("请求失败请重试")
                                        }
                                    });

                                }
                            });
                        },
                        error: function () {
                            alert("请求失败请重试")
                        }
                    });


                }

            });

            //退出
            $(".out_page").click(function () {
                window.location.href="/Main/logout";
            });

        });


	  $(function(){
	  	 var Lis=$(".menu ul li").eq(2);
	  	 Lis.css('border-bottom', '7px solid #419EDC');
	  	 Lis.css('margin-top', '-7px');
	  	 Lis.css('color', '#419EDC');
	  	 $('input[type=password]:first').focus();//默认光标位置在input
	  })
	</script>
</head>
<body>
<div class="header">
	<div class="header">
		<div class="home_logo"><a  href="/Main/index"><i class="fa fa-home">首页</i></a></div>
		<div class="page_title">个人中心</div>
		<div class="out_page">退出</div>
	</div>
</div>
<div class="book_logo">
	<img src="../images/booklogo.png">
</div>
<div class="reader_name">${userInfo.userName}</div>
<div class="menu">
	<ul>
        <a href="/UserInfo/readerPerCenter?id=${userInfo.userId}"><li class="first_li">基本资料</li></a>
        <a href="/UserInfo/updateReader"><li class="other_li">修改资料</li></a>
        <a href="/User/updateReaderPassword"><li class="other_li">修改密码</li></a>
		<a href="/BorrowRecord/selReaderBorrowing"><li class="other_li">在借图书</li></a>
		<a href="/BorrowRecord/selReaderBorrowed"><li class="last_li">借阅记录</li></a>
	</ul>
	<div class="clear"></div>
</div>
<!-- class="content"的div中是个人中心的切换部分 -->
<div class="content">
	<div class="data"><label>原密码</label><input class="oldPassword" type="password"  value=""/></div>
    <div class="data"><label>新密码</label><input class="newPassword"   type="password"  value=""/></div>
    <div class="data"><label>确认新密码</label><input class="realPassword"  type="password" value=""/></div>
    <div class="add_btn">确认修改</div>
</div>
<div class="footer">
	    <br/>   
		<p>@Copyright重庆理工大学中山图书馆</p>
	</div>
</body>
</html>