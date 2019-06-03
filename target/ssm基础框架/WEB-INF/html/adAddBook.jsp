<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>图书管理员-新书入库</title>
	<%--<meta http-equiv="Content-Type" content="text/html;charset=utf-8">--%>
	<link rel="stylesheet" type="text/css" href="../font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="../style/adMain.css">
   <link rel="stylesheet" type="text/css" href="../style/adAddBook.css">
    <link rel="stylesheet" type="text/css" href="../style/alertStyle.css">
   <link rel="stylesheet" type="text/css" href="../style/adBook.css">
	<script type="text/javascript" src="../script/jquery-2.1.4.min.js"></script>
  <script type="text/javascript" charset="utf-8" src="../ueditor/ueditor.config.js"></script>
  <script type="text/javascript" charset="utf-8" src="../ueditor/ueditor.all.min.js"> </script>
  <script type="text/javascript" charset="utf-8" src="../ueditor/lang/zh-cn/zh-cn.js"></script>
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
          var left_li=$(".left ul li:eq(2)");
              left_li.css("color","#FFF");
              left_li.css("background-color","#BBCAF1");
          $(".left ul").find('li:eq(2)').children(".trig").css('display', 'block');
          $(".table tbody tr:odd").css("backgroundColor","#DFF0D8");
          $(".table tbody tr").eq(3).addClass('error');
          $(".table tbody tr").eq(4).addClass('error');
          $(".data_1 input").attr('readonly', 'readonly');//图书编码默认不可输入


           // 打印编码根据数据库生成一个新的图书编码
           $(".P_btn").click(function () {
               $.ajax({
                   url: "/BookInfo/getNewBookId",
                   type: "POST",
                   dataType: "json",
                   contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                   <!-- 生成一个新的图书编码 -->
                   success: function (mes) {
                       console.log(mes);
                       //
                       document.getElementById("BookId").value=parseInt(mes.bookId)+1+"";
                   },
                   error: function () {
                       alert("失败")
                   }
               });

           });

           //确定加入图书
           $(".add_btn").click(function () {
               //验证输入内容得合法性
                if($(".BookId").val()=="")alert("图书编码不能为空");
                else if($(".BookName").val()=="")alert("图书名不能为空");
                else if($(".Author").val()=="")alert("图书作者不能为空");
                else if($(".Price").val()==""
                    || !/^(0|[1-9]\d*|[1-9]\d*\.\d+|0\.\d*[1-9]\d*)$/.test($(".Price").val()))
                    alert("图书价格输入有误");
                else if($(".ISBNCode").val()=="")alert("图书ISBN不能为空");
                else if($(".PublishCompany").val()=="")alert("图书出版社不能为空");
                else if($(".ComeUpTime").val()=="")alert("图书出版时间不能为空");
                else if($(".EnteringMen").val()=="")alert("图书录入者不能为空");
                else{

                    $.ajax({
                        url: "/Manager/adAddBook",
                        type: "POST",
                        dataType: "json",
                        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                        data: $('.form').serialize(),
                        success: function (mes) {
                            console.log(mes);
                            if(mes==200){
                                alert("添加成功!");
                                $(".form input").val("");
                            }else{
                                alert("添加错误")
                            }
                        },
                        error: function () {
                            alert("失败")
                        }
                    });
                }
           });

           $(".noadd_btn").click(function () {
               $(".form input").val("");
           });

          var m_li=$(".menu ul li");
              m_li.eq(0).addClass('addCss');
              m_li.eq(0).click(function() {
                 $(".menu_left").css('display', 'block');
                 $(".menu_right").css('display', 'none');
                 m_li.eq(1).removeClass('addCss')
                 m_li.eq(0).addClass('addCss')
                
              });
              m_li.eq(1).click(function() {
                   $(".menu_left").css('display', 'none');
                   $(".menu_right").css('display', 'block');
                   m_li.eq(0).removeClass('addCss')
                   m_li.eq(1).addClass('addCss')
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
               <div class="menu">
                  <ul>
                     <li>手动输入</li>
                     <li>批量导入</li>
                  </ul>
                  <div class="clear"></div>
               </div>
               <div class="menu_left">
                   <form class="form" method="post" action="#">
                      <div class="data data_1"><label>图书编号</label><input placeholder="请点击导入" name="BookId" id="BookId" class="BookId" value="" type="text" /><button type="button" class="P_btn">打印编码</button></div>
                      <div class="data"><label>图书名称</label><input name="BookName" class="BookName" value="" type="text"/></div>
                      <div class="data"><label>作者</label><input name="Author" class="Author" value="" type="text"/></div>
                      <div class="data"><label>译者</label><input name="Translator" class="Translator" value="" type="text"/></div>
                      <div class="data"><label>价格</label><input name="Price" class="Price" value="" type="text"/></div>
                      <div class="data"><label>ISBN编码</label><input name="ISBNCode" class="ISBNCode" value="" type="text"/></div>
                      <div class="data"><label>出版社</label><input name="PublishCompany" class="PublishCompany" value="" type="text"/></div>
                      <div class="data"><label>出版日期</label><input name="ComeUpTime" class="ComeUpTime" value="" type="date"/></div>
                      <div class="data"><label>入库者</label><input name="EnteringMen" class="EnteringMen" value="" type="text"/></div>
                      <div class="add_btn">确认加入</div>
                       <div class="noadd_btn">取消</div>
                   </form>
               </div>
               <div class="menu_right">
                  <input id="upload" style="width:300px"  type="text" value=""/>  
                  <script id="myeditor"></script>  
                  <input type="button" onclick="upFiles()" value="上传文件" />
                    <div>
                         <script id="editor" type="text/plain" style="width:1024px;height:500px;"/>
                    </div>
                  <div class="table_div">
                     
                     <table class="table">
                       <thead>
                          <tr>
                             <th class="tdOne">图书编号</th>
                             <th>图书名称</th>
                             <th class="tdTwo">作者</th>
                             <th class="tdTwo">译者</th>
                             <th class="tdTwo">价格</th>
                             <th>出版社</th>
                             <th class="tdOne">出版日期</th>
                             <th>ISBN编码</th>
                             <th class="tdTwo">入库者</th>
                             <th class="tdOne">操作</th>
                          </tr>
                       </thead>
                       <tbody>
                           <tr>
                             <td>20151111</td>
                             <td>C#入门经典</td>
                             <td>张三</td>
                             <td>李四</td>
                             <td>23</td>
                             <td>人民教育出版社</td>
                             <td>2015-1-1</td>
                             <td>isbn</td>
                             <td>李斯</td>
                             <td>
                                <button>打印编码</button>
                                <button>删除</button>
                             </td>
                          </tr>
                           <tr>
                             <td>20151112</td>
                             <td>C#入门经典</td>
                             <td>张三</td>
                             <td>李四</td>
                             <td>23</td>
                             <td>人民教育出版社</td>
                             <td>2015-1-1</td>
                             <td>isbn</td>
                             <td>李斯</td>
                             <td>
                                <button>打印编码</button>
                                <button>删除</button>
                             </td>
                          </tr>
                              <tr>
                                <td>20151113</td>
                                <td>C#入门经典</td>
                                <td>张三</td>
                                <td>无</td>
                                <td>23</td>
                                <td>人民教育出版社</td>
                                <td>2015-1-1</td>
                                <td>isbn</td>
                                <td>李斯</td>
                                <td>
                                  <button>打印编码</button>
                                  <button>删除</button>
                                </td>
                             </tr>
                              <tr>
                                <td>20151114</td>
                                <td>C#入门经典</td>
                                <td>张三</td>
                                <td>无</td>
                                <td>23</td>
                                <td>人民教育出版社</td>
                                <td>2015-1-1</td>
                                <td>isbn</td>
                                <td>李斯</td>
                                <td>
                                  <button>打印编码</button>
                                  <button>删除</button>
                                </td>
                             </tr>
                              <tr>
                                <td>20151114</td>
                                <td>C#入门经典</td>
                                <td>张三</td>
                                <td>无</td>
                                <td>23</td>
                                <td>人民教育出版社</td>
                                <td>2015-1-1</td>
                                <td>isbn</td>
                                <td>李斯</td>
                                <td>
                                  <button>打印编码</button>
                                  <button>删除</button>
                                </td>
                             </tr>
                              <tr>
                                <td>20151115</td>
                                <td>C#入门经典</td>
                                <td>张三</td>
                                <td>无</td>
                                <td>23</td>
                                <td>人民教育出版社</td>
                                <td>2015-1-1</td>
                                <td>isbn</td>
                                <td>李斯</td>
                                <td>
                                  <button>打印编码</button>
                                  <button>删除</button>
                                </td>
                             </tr>
                          </tbody>
                     </table>
                      <div class="book_num">图书数量: <span>6</span> 本</div>
                      <button class="submit">确认导入</button>
                  </div>
               </div>
   			</div>
   		</div>
   		<div class="clear"></div>
   	</div>
   </div>
   <script type="text/javascript">
                //重新实例化一个编辑器，防止在上面的editor编辑器中显示上传的图片或者文件
                var _editor = UE.getEditor('editor');
                _editor.ready(function () {
                    //设置编辑器不可用
                    //_editor.setDisabled();
                    //隐藏编辑器，因为不会用到这个编辑器实例，所以要隐藏
                    _editor.hide();

                    //侦听文件上传
                    _editor.addListener('afterUpfile', function (t, arg) {
                        $("#file").attr("value", _editor.options.filePath + arg[0].url);
                    })
                });

                //弹出文件上传的对话框
                function upFiles() {
                    var myFiles = _editor.getDialog("attachment");
                    myFiles.open();
                }
   </script>
</body>
</html>