<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>基本资料</title>
	<%--<meta http-equiv="Content-Type" content="text/html;charset=utf-8">--%>
	<link rel="stylesheet" type="text/css" href="../font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="../style/readerMain.css">
	<link rel="stylesheet" type="text/css" href="../style/readerPersonal.css">
	<script type="text/javascript" src="../script/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">

        $(document).ready(function() {
            //退出
            $(".out_page").click(function () {
                window.location.href="/Main/logout";
            });
        });

	  $(function(){
	  	 var Lis=$(".menu ul li").eq(0);
	  	 Lis.css('border-bottom', '7px solid #419EDC');
	  	 Lis.css('margin-top', '-7px');
	  	 Lis.css('color', '#419EDC');
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
	<div class="data"><label>借阅号</label><div>${userInfo.userId}</div></div>
	<div class="data"><label>用户名</label><div>${userInfo.userName}</div></div>
    <div class="data"><label>学院</label><div>${userInfo.departments}</div></div>
    <div class="data"><label>专业</label><div>${userInfo.major}</div></div>
	<div class="data"><label>电话</label><div>${userInfo.phone}</div></div>
    <div class="data"><label>邮箱</label><div>${userInfo.email}</div></div>
    <div class="data"><label>借阅上限</label><div>${userInfo.max}</div></div>
    <div class="data"><label>借阅期限</label><div>${userInfo.time}天</div></div>
    <div class="data"><label>已借数量</label><div>${userInfo.lendedNum}</div></div>
</div>
<div class="footer">
	    <br/>   
		<p>@Copyright重庆理工大学中山图书馆</p>
	</div>
</body>
</html>