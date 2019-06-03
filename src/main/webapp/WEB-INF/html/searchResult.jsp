<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html >
<head>
	<title>搜索结果</title>
	<%--<meta http-equiv="Content-Type" content="text/html;charset=utf-8">--%>
	<link rel="stylesheet" type="text/css" href="../style/searchResult.css">
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

        $(document).ready(function() {
            //ajax动态生成查询结果
            $(".sch_btn").click(function () {
                //传送json数据
                $.ajax({
                    url : "/BookInfo/searchByName",
                    type : "POST",
                    dataType:"json",
                    contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                    <!-- 向后端传输的数据 表单数据-->

                    data : $('#form').serialize(),
                    success:function(mes) {
                        console.log(mes);
                        <!-- 处理后端返回的数据 -->
                        //先把表体部分清空
                        $(".result").empty();
                        if(mes.length>0){
                            $.each(mes,function(index, item){
                                $(".result").append("<div class='book_result'> " +
                                                            "<div class='bk_name'>"+item.bookInfo.bookName+"</div>" +
                                                            "<ul>" +
                                                                "<li>作者："+item.bookInfo.author+"</li>" +
                                                                "<li>出版社："+item.bookInfo.publishCompany+"</li> " +
                                                            "</ul>" +
                                                            "<div class='bor_btn'>" +
                                                                "<div class='btn_name'>借阅</div>" +
                                                                // "<div class='bk_num'>库存总数量：<span>"+item.totalCount+"</span>本</div>" +
                                                                "<div class='bk_num'>可借数：<span>"+item.count+"</span>本</div>" +
                                                            "</div>" +
                                                            "<div class='clear'></div>" +
                                                     "</div>");
                            });
                            //为每个借阅按钮添加监听事件
                            $(".bor_btn").click(function () {
                                var num = $(this).find("span").html();
                                if (num <= 0) {
                                    alert("该书被借光了~~");
                                }
                                else {
                                    alert("请到图书管理员处借阅~~");
                                }
                            });

                       }

                    },
                    error:function(){
                        alert("请求失败请重试")
                    }
                });
                // document.getElementById("form").submit();
            });

        	$(".login").click(function() {
                window.location.href="/Main/login";
                // window.open("../html/login.jsp");
        	});

        	var btns=$(".bor_btn");
        	for (var i = 0; i < btns.length; i++) {
        		var num=$(btns[i]).find("span").html();
        		if (num==0) {
                    $(".bor_btn").eq(i).css('backgroundColor', '#BCBCBC');
        		}
        		else{
        			$(".bor_btn").eq(i).css('backgroundColor', '#28B138');
        		}
        	};
        });


    </script>

</head>
<body>
<div class="search_page">
	<div class="header">
		<div class="home"><a href="/Main/index"><i class="fa fa-home"></i>首页</a></div>
        <div class="login">登录</div>
		<div class="clear"></div>
	</div>
	<div class="content">
		<div class="search">
            <form action="#" method="post" id="form">
                <input value="" placeholder="请输入书名" name="BookName" type="text"/>
                <div class="sch_btn"> 搜索 </div>
            </form>
		</div>
		<div class="result">

			<div class="book_result">
				<div class="bk_name">C语言基础教程</div>
				<ul>
					<li>作者：张三</li>
					<li>出版社：人民教育出版社</li>
				</ul>
				
				<div class="bor_btn">
					<div class="btn_name">借阅</div>
					<div class="bk_num">在库数量：<span>5</span>本</div>
				</div>
				<div class="clear"></div>
			</div>

		</div>

	</div>
</div>
</body>
</html>