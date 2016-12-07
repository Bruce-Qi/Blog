<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>评论审核管理页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">

	function commentReview(state){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			 $.messager.alert("系统提示","请选择要删除的数据！");
			 return;
		 }
		 var strIds=[];
		 for(var i=0;i<selectedRows.length;i++){
			 strIds.push(selectedRows[i].commentid);
		 }
		 var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确定要审核这<font color=red>"+selectedRows.length+"</font>条评论吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath}/user/comment/review",{ids:ids,state:state},function(result){
					if(result.success){
						 $.messager.alert("系统提示","提交成功！");
						 $("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","提交失败！");
					}
				},"json");
			} 
  	   });
	}
	function formatBlogTitle(val,row){
	
		if(val==''){
			return "<font color='red'>该博客已被删除！</font>";
		}else{
			return "<a target='_blank' href='http://localhost:8085/blog/articles/"+row.blogid+".html'>"+row.title+"</a>";			
		}
	}
	
		
	function formatBlogusername(val,row){
		return "<a target='_blank' href='http://localhost:8085/userlist?username="+row.username + "'>"+row.username+"</a>";			

	}
	

</script>
</head>
<body style="margin: 1px">
<table id="dg" title="评论审核管理" class="easyui-datagrid"
   fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/user/comment/list?state=0&username=${user.username}" fit="true" toolbar="#tb">
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="commentid" width="20" align="center">编号</th>
   		<th field="title" width="200" align="center" formatter="formatBlogTitle">博客标题</th>
   		<th field="username" width="100" align="center"  formatter="formatBlogusername">评论者用户名</th>
   		<th field="content" width="200" align="center">评论内容</th>
   		<th field="commentdate" width="50" align="center">评论日期</th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 		<a href="javascript:commentReview(1)" class="easyui-linkbutton" iconCls="icon-ok" plain="true">审核通过</a>
 		<a href="javascript:commentReview(2)" class="easyui-linkbutton" iconCls="icon-no" plain="true">审核不通过</a>
 	</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 </div>
 
 
</body>
</html>