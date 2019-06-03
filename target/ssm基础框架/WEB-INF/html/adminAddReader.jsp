<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>系统管理员-录入读者</title>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
  <link rel="stylesheet" type="text/css" href="../font-awesome/css/font-awesome.min.css">
  <link rel="stylesheet" type="text/css" href="../style/adminMain.css">
   <link rel="stylesheet" type="text/css" href="../style/adminAddReader.css">
   <link rel="stylesheet" type="text/css" href="../style/adminReader.css">
   <link rel="stylesheet" type="text/css" href="../style/searchTable.css">
    <link rel="stylesheet" type="text/css" href="../style/alertStyle.css">
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
          var left_li=$(".left ul li:eq(0)");
              left_li.css("color","#FFF");
              left_li.css("background-color","#B78DE7");
          $(".left ul").find('li:eq(0)').children(".trig").css('display', 'block');
          $(".table tbody tr:odd").css("backgroundColor","#DFF0D8");
          $(".table tbody tr").eq(1).addClass('error')
          $(".table tbody tr").eq(2).addClass('error')
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


         //确定录入
         $(".add_btn").click(function () {
             //验证输入内容得合法性
             if($(".UserId").val()=="")alert("借阅号不能为空");
             else if($(".UserName").val()=="")alert("用户名不能为空");
             else if($(".PassWord").val()=="")alert("密码不能为空");
             else if($(".Departments").val()=="")alert("学院不能为空");
             else if($(".Major").val()=="" )  alert("专业不能为空");
             else{

                 $.ajax({
                     url: "/SysAdmin/adminAddReader",
                     type: "POST",
                     dataType: "json",
                     contentType : "application/x-www-form-urlencoded;charset=UTF-8",
                     data: {"UserId":$(".UserId").val(),"userName":$(".UserName").val(),"passWord":$(".PassWord").val(),"Departments":$(".Departments").val()
                     ,"Major":$(".Major").val(),"Phone":$(".Phone").val(),"Email":$(".Email").val()
                     ,"Max":$("#Max").val(),"Time":$("#Time").val()},
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
               <div class="menu">
                  <ul>
                     <li>手动输入</li>
                     <li>批量导入</li>
                  </ul>
                  <div class="clear"></div>
               </div>
               <div class="menu_left">
                  <div class="data"><label>借阅号</label><input name="UserId" class="UserId"/></div>
                  <div class="data"><label>用户名</label><input name="UserName" class="UserName"/></div>
                  <div class="data"><label>密码</label><input name="PassWord" class="PassWord"/></div>
                  <div class="data"><label>学院</label><input name="Departments" class="Departments"/></div>
                  <div class="data"><label>专业</label><input name="Major" class="Major"/></div>
                  <div class="data"><label>电话</label><input name="Phone" class="Phone"/></div>
                  <div class="data"><label>邮箱</label><input name="Email" class="Email"/></div>
                  <div class="data">
                      <label>借阅上限</label>
                      <select class="bookMax" id="Max" name="Max">
                        <option value="10" >10本</option>
                        <option value="15" >15本</option>
                      </select>
                  </div>
                   <div class="data" >
                      <label>借阅期限</label>
                      <select class="bookMax" id="Time" name="Time">
                        <option value="30">30天</option>
                        <option value="90">90天</option>
                      </select>
                  </div>
                  <div class="add_btn">确认加入</div>
                   <div class="noadd_btn">取消</div>
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
                             <th class="tdOne">借阅号</th>
                             <th class="tdTwo">用户名</th>
                             <th>学院</th>
                             <th>专业</th>
                             <th>电话</th>
                             <th class="tdOne">邮箱</th>
                             <th>借阅上限</th>
                             <th>借阅期限</th>
                             <th class="tdOne">操作</th>
                          </tr>
                       </thead>
                       <tbody>
                           <tr>
                             <td>20151111</td>
                             <td>张三</td>
                             <td>计算机科学与工程学院</td>
                             <td>计算机科学与技术专业</td>
                             <td>11223344555</td>
                             <td>1111222233@qq.com</td>
                             <td>10</td>
                             <td>30</td>
                             <td>
                                <button>打印编码</button>
                                <button>删除</button>
                             </td>
                          </tr>
                           <tr>
                             <td>20151111</td>
                             <td>张三</td>
                             <td>计算机科学与工程学院</td>
                             <td>计算机科学与技术专业</td>
                             <td>11223344</td>
                             <td>1111222233@qq.com</td>
                             <td>10</td>
                             <td>30</td>
                             <td>
                                <button>打印编码</button>
                                <button>删除</button>
                             </td>
                          </tr>
                              <tr>
                                 <td>20151111</td>
                                 <td>张三</td>
                                 <td>计算机科学与工程学院</td>
                                 <td>计算机科学与技术专业</td>
                                 <td>11223344</td>
                                 <td>1111222233@qq.com</td>
                                 <td>10</td>
                                 <td>30</td>
                                 <td>
                                    <button>打印编码</button>
                                    <button>删除</button>
                                 </td>
                             </tr>
                              <tr>
                                 <td>20151111</td>
                                 <td>张三</td>
                                 <td>计算机科学与工程学院</td>
                                 <td>计算机科学与技术专业</td>
                                 <td>11223344</td>
                                 <td>1111222233@qq.com</td>
                                 <td>10</td>
                                 <td>30</td>
                                 <td>
                                    <button>打印编码</button>
                                    <button>删除</button>
                                 </td>
                             </tr>
                              <tr>
                                 <td>20151111</td>
                                 <td>张三</td>
                                 <td>计算机科学与工程学院</td>
                                 <td>计算机科学与技术专业</td>
                                 <td>11223344</td>
                                 <td>1111222233@qq.com</td>
                                 <td>10</td>
                                 <td>90</td>
                                 <td>
                                    <button>打印编码</button>
                                    <button>删除</button>
                                 </td>
                             </tr>
                              <tr>
                                 <td>20151111</td>
                                 <td>张三</td>
                                 <td>计算机科学与工程学院</td>
                                 <td>计算机科学与技术专业</td>
                                 <td>11223344</td>
                                 <td>1111222233@qq.com</td>
                                 <td>10</td>
                                 <td>90</td>
                                 <td>
                                    <button>打印编码</button>
                                    <button>删除</button>
                                 </td>
                             </tr>
                          </tbody>
                     </table>
                       <div class="book_num">读者数量: <span>6</span> 本</div>
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