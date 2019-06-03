<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>登录</title>
    <%--<meta http-equiv="Content-Type" content="text/html;charset=utf-8">--%>
    <link rel="stylesheet" type="text/css" href="../style/login.css">
    <link rel="stylesheet" type="text/css" href="../style/alertStyle.css">
    <link rel="stylesheet" type="text/css" href="../font-awesome/css/font-awesome.min.css">
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


        //登录提交
        window.loginRole = 1;
        $(document).ready(function() {

            //ajax动态生成查询结果
            $(".login_btn").click(function () {
                var data = "";
                var url = "";
                var href="";
                if(loginRole==1){   //读者
                    //传送json数据
                    $.ajax({
                        url: "/User/readerLoginCheck",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                        <!-- 向后端传输的数据 表单数据-->
                        data:{"UserId":$(".username").val(),"PassWord":$(".password").val()},
                        success: function (mes) {
                            console.log(mes);
                            $.each(mes,function(key, value){
                                if(key==400 && value=='UserIdNone') alert("用户名为空");
                                else if(key==400 && value=='passwordNone') alert("密码为空");
                                else if(key==400 && value=='用户不存在') alert("用户不存在，联系管理员");
                                else if(key==200) window.location.href="/UserInfo/readerPerCenter?id="+value.userId;
                            });

                            // else  window.location.href="/Main/readerPerCenter?id="+mes.userId;
                        },
                        error: function () {
                            alert("请求失败请重试")
                        }
                    });
                    // document.getElementById("form").submit();
                }
                else if(loginRole==2){  //图书管理员
                    $.ajax({
                        url: "/Manager/managerLoginCheck",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                        <!-- 向后端传输的数据 表单数据-->
                        data:{"adId":$(".username").val(),"adPassword":$(".password").val()},
                        success: function (mes) {
                            console.log(mes);
                            $.each(mes,function(key, value){
                                if(key==400 && value=='UserIdNone') alert("用户名为空");
                                else if(key==400 && value=='passwordNone') alert("密码为空");
                                else if(key==400 && value=='用户不存在') alert("用户不存在，检查输入是否有误");
                                else if(key==200) window.location.href="/Manager/adPersonal?id="+value.adId;

                            });
                            // else  window.location.href="/Main/readerPerCenter?id="+mes.userId;
                        },
                        error: function () {
                            alert("登录失败请重试")
                        }
                    });
                }else if(loginRole==3){  //系统管理员
                    $.ajax({
                        url: "/SysAdmin/SysAdminLoginCheck",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                        <!-- 向后端传输的数据 表单数据-->
                        data:{"adminId":$(".username").val(),"adminPassword":$(".password").val()},
                        success: function (mes) {
                            console.log(mes);
                            $.each(mes,function(key, value){
                                if(key==400 && value=='UserIdNone') alert("用户名为空");
                                else if(key==400 && value=='passwordNone') alert("密码为空");
                                else if(key==400 && value=='用户不存在') alert("用户不存在，检查输入是否有误");
                                else if(key==200) window.location.href="/SysAdmin/adminPersonal?id="+value.adminId;

                            });
                        },
                        error: function () {
                            alert("登录失败请重试")
                        }
                    });
                }
                $(".username").val("");
                $(".password").val("");
            });

        });

    	function change(){
            loginRole=$(".role").val();
            // if (result==1) {
            //     // window.open("../html/readerPersonal.jsp")
            // }else if(result==3){
            //     // window.open("../html/adminAddReader.jsp")
            // }else if (result==2) {
            //     // window.open("../html/adBorrowBook.jsp")
            // }
        }
        function password_f(){
            alert("亲，请到教务系统修改密码！");
        }

    </script>
</head>
<body>
<div class="login_page">
	<div class="page_top"></div>
	<div class="header"> 
		<img src="../images/logo.png">
		<div class="hello_word">中山图书馆欢迎您</div>
		<div class="clear"></div>
	</div>
	<div class="login">
		<div class="login_part" >
			<select class="role" onchange="change()">
				<option value="1">读者</option>
				<option value="2">图书管理员</option>
				<option value="3">系统管理员</option>
			</select>
			<hr class="lion" />
            <div class="login_input">
            	<div class="user"><i class="fa fa-user"></i></div>
            	<input type="text" class="username" value="" placeholder="请输入通行证号" />&nbsp;<span class="text_red">*</span>
            	<div class="user"><i class="fa fa-lock"></i></div>
            	<input type="password" class="password"/>&nbsp;<span class="text_red">*</span>
            </div>
            <div class="login_btn">登录</div>
            <div class="password_f" onclick="password_f()">忘记密码 ？</div>
		</div>
		<div class="clear"></div>
		<div class="from">@Copyright重庆理工大学中山图书馆</div>
	</div>
</div>
</body>
</html>