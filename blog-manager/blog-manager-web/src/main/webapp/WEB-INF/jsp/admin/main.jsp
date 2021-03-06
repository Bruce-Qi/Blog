<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>博客系统管理员页面-博客云</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.cookie.js"></script>	
<script type="text/javascript">

	var url;

	function openTab(text, url, iconCls) {
		if ($("#tabs").tabs("exists", text)) {
			$("#tabs").tabs("select", text);
		} else {
			var content = "<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/"
					+ url + "'></iframe>";
			$("#tabs").tabs("add", {
				title : text,
				iconCls : iconCls,
				closable : true,
				content : content
			});
		}
	}

	function openPasswordModifyDialog() {
		$("#dlg").dialog("open").dialog("setTitle", "修改密码");
		url = "http://localhost:8087/sso/admin/modifyPassword?id=${admin.adminid}";
	}

	function modifyPassword() {
		$("#fm").form("submit", {
			url : url,
			onSubmit : function() {
				var newPassword = $("#newPassword").val();
				var newPassword2 = $("#newPassword2").val();
				if (!$(this).form("validate")) {
					return false;
				}
				if (newPassword != newPassword2) {
					$.messager.alert("系统提示", "两次密码不一致！");
					return false;
				}
				$.messager.alert("系统提示", "密码修改成功，下一次登录生效！");
				$("#dlg").dialog("close");
				
				return true;
			},
			success : function(result) {
				var result = eval('(' + result + ')');
				if (result.success) {
					$.messager.alert("系统提示", "密码修改成功，下一次登录生效！");
					resetValue();
					$("#dlg").dialog("close");
				} else {
					$.messager.alert("系统提示", "密码修改失败！");
					return;
				}
			}
		});
	}

	function closePasswordModifyDialog() {
		resetValue();
		$("#dlg").dialog("close");
	}

	function resetValue() {
		$("#oldPassword").val("");
		$("#newPassword").val("");
		$("#newPassword2").val("");
	}

	function logout() {
		$.messager.confirm("系统提示", "您确定要退出系统吗？", function(r) {
			if (r) {
				var _ticket = $.cookie("TT_TOKEN_ADMIN");
				if (!_ticket) {
					return;
				}
				$.ajax({
					url : "http://localhost:8087/sso/admin/logout/" + _ticket,
					dataType : "jsonp",
					type : "GET",
					success : function(data) {
						if (data.status == 200) {
							location = "http://localhost:8087/sso/page/admin/login";
						}
					}
				});
			}
		});
	}


</script>
</head>
<body class="easyui-layout">
	<div region="north" style="height: 78px;background-color: #E0ECFF">
		<table style="padding: 5px" width="100%">
			<tr>
				<td width="50%"><img alt="logo"
					src="${pageContext.request.contextPath}/static/images/logo.png.png">
				</td>
				<td valign="bottom" align="right" width="50%"><font size="3">&nbsp;&nbsp;<strong>欢迎：</strong>${admin.username
						}
				</font></td>
			</tr>
		</table>
	</div>
	<div region="center">
		<div class="easyui-tabs" fit="true" border="false" id="tabs">
			<div title="首页" data-options="iconCls:'icon-home'">
				<div align="center" style="padding-top: 100px">
					<font color="green" size="10">欢迎使用</font><br />
					<font color="green" size="6">这里是管理员操作界面</font>
				</div>
			</div>
		</div>
	</div>
	<div region="west" style="width: 200px" title="导航菜单" split="true">
		<div class="easyui-accordion" data-options="fit:true,border:false">
			<div title="常用操作" data-options="selected:true,iconCls:'icon-item'"
				style="padding: 10px">
				<a href="javascript:openTab('发布公告','admin/writeMsg','icon-writeblog')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-writeblog'"
					style="width: 150px">发布公告</a> <a
					href="javascript:openTab('用户管理','admin/UserManager','icon-review')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-review'"
					style="width: 150px">用户管理</a>
					
				
					<a	href="javascript:openTab('博客信息管理','admin/blogManage','icon-bkgl')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-bkgl'" style="width: 150px;">文章管理</a>	
					
					
				<a
					href="javascript:openTab('博客类别信息管理','admin/blogTypeManage','icon-bklb')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-bklb'" style="width: 150px;">博客类别信息管理</a>
					
				<a
					href="javascript:openTab('积分商城','admin/mall/index','icon-grxxxg')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-grxxxg'"
					style="width: 150px;">积分商城</a>
					
			</div>	
	
			
			<div title="个人信息管理" data-options="iconCls:'icon-system'"
				style="padding:10px">
				<a
					href="javascript:openTab('修改个人信息','admin/modifyInfo','icon-grxxxg')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-grxxxg'"
					style="width: 150px;">修改个人信息</a>
					
			   <a href="javascript:openPasswordModifyDialog()"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-modifyPassword'"
					style="width: 150px;">修改密码</a>  <a href="javascript:logout()"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
			</div>
			
		</div>
	</div>
	<div region="south" style="height: 25px;padding: 5px" align="center">
		Powered by <a href="http://www.tianfang1314.cn" target="_blank">天方形田科技</a>
		&nbsp;&nbsp;Copyright © 2015-2016 荣登文化(RD工程)
	</div>


	<div id="dlg" class="easyui-dialog"
		style="width:400px;height:200px;padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">

		<form id="fm" method="post">
			<table cellspacing="8px">
				<tr>
					<td>用户名：</td>
					<td><input type="text" id="userName" name="username"
						readonly="readonly" value="${admin.username }" style="width: 200px" /></td>
				</tr>
				<tr>
					<td>新密码：</td>
					<td><input type="password" id="newPassword" name="newPassword"
						class="easyui-validatebox" required="true" style="width: 200px" /></td>
				</tr>
				<tr>
					<td>确认新密码：</td>
					<td><input type="password" id="newPassword2"
						name="newPassword2" class="easyui-validatebox" required="true"
						style="width: 200px" /></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:modifyPassword()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a
			href="javascript:closePasswordModifyDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>

</body>
</html>