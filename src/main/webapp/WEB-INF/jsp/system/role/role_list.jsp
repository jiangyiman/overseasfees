﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../admin/top.jsp"%>
</head>
<body>
	<div class="container-fluid" id="main-container">
		<div id="page-content" class="clearfix">
			<div class="row-fluid">
				<div class="row-fluid">
				<form action="system/role" method="post" name="roleForm" id="roleForm">
					<shiro:hasPermission name="system:role:add">
					<table style="width: 100%;">
						<tr>
							<td style="vertical-align: top; text-align: right;"><a
								class="btn btn-small btn-success" onclick="add();">创建</a></td>
						</tr>
					</table>
					</shiro:hasPermission>
					<!-- 检索  -->
					<shiro:hasPermission name="system:role:query">
					<table>
						<tr>
							<td><span class="input-icon"> 
							      <input autocomplete="off" id="nav-search-input" type="text"
									name="roleName" value="" placeholder="这里输入关键词" /> <i id="nav-search-icon" class="icon-search"></i>
								</span>
							</td>
							<td style="vertical-align: top;"><button
									class="btn btn-mini btn-light" onclick="search();" title="检索">
									<i id="nav-search-icon" class="icon-search"></i>
								</button>
							</td>
						</tr>
					</table>
					</shiro:hasPermission>
					<!-- 检索  -->
				  <table id="table_report" class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th class="center">
							<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
							</th>
							<th>序号</th>
							<th>角色名称</th>
							<th><i class="icon-time"></i>创建时间</th>
							<shiro:hasAnyPermission name="system:role:jurisdiction,system:role:view,system:role:del">
							<th class="center">操作</th>
							</shiro:hasAnyPermission>
						</tr>
					</thead>
					<tbody>
					<!-- 开始循环 -->	
					<c:choose>
						<c:when test="${not empty rolelist}">
							<c:forEach items="${rolelist}" var="role" varStatus="vs">
								<tr>
									<td class="center" style="width: 30px;">
									   <label><input type='checkbox' name='ids' value="${role.id }" /><span class="lbl"></span></label>
									</td>	
									<td class='center' style="width: 30px;">${vs.index+1}</td>
									<td>${role.roleName}</td>
									<td><fmt:formatDate value="${role.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
									<shiro:hasAnyPermission name="system:role:jurisdiction,system:role:view,system:role:del">
									<td style="width: 60px;">
										<div class='hidden-phone visible-desktop btn-group'>
										<shiro:hasPermission name="system:role:jurisdiction">
										    <a class='btn btn-mini btn-info' title="权限分配" onclick="jurisdiction(${role.id });"><i class='icon-pencil'>权限分配</i></a>
										</shiro:hasPermission>
										<shiro:hasPermission name="system:role:view">
											<a class='btn btn-mini btn-info' title="编辑" 
											onclick="editUserType(${role.id });">
											<i class='icon-edit'>编辑</i></a>
										</shiro:hasPermission>	
											<shiro:hasPermission name="system:role:del">
											<a class='btn btn-mini btn-danger' title="删除" 
											<c:if test="${role.roleCode != 'admin'}">onclick="delUserType(${role.id}, '${role.roleName}');"</c:if>>
											<i class='icon-trash'>删除</i></a>
										</shiro:hasPermission>
										</div>
									</td>
									</shiro:hasAnyPermission>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr class="main_info">
								<td colspan="10" class="center">没有相关数据</td>
							</tr>
						</c:otherwise>
					</c:choose>
					</tbody>
				</table>
				<div class="page-header position-relative">
				<table style="width:100%;">
					<tr>
						<td style="vertical-align:top;">
							<div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">
								${page.pageStr}
							</div>
						</td>
					</tr>
				 </table>
				</div>
				</form>
			</div>
			<!-- PAGE CONTENT ENDS HERE -->
		</div>
		<!--/row-->
	</div>
</div>
	<!--/#page-content-->
	<!--/.fluid-container#main-container-->
	<!--[if !IE]> -->
	<!-- <![endif]-->
	<!--[if IE]>
	<script src="assets/js/jquery-1.11.1.min.js"></script>
	<![endif]-->
	<!--[if !IE]> -->
	<script type="text/javascript">
			window.jQuery || document.write("<script src='assets/js/jquery.min.js'>"+"<"+"/script>");
	</script>
	<!-- <![endif]-->

	<!--[if IE]>
	<script type="text/javascript">
	 window.jQuery || document.write("<script src='assets/js/jquery1x.min.js'>"+"<"+"/script>");
	</script>
	<![endif]-->
	<!-- 返回顶部  -->
	<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse"> <i
		class="icon-double-angle-up icon-only"></i>
	</a>
	<!-- 引入 -->
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
	<!-- 下拉框 -->
	<script type="text/javascript"
		src="static/js/bootstrap-datepicker.min.js"></script>
	<!-- 日期框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script>
	<!-- 确认窗口 -->
	<!-- 引入 -->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.jqGrid.min.js"></script>
	<!--jqGrid-->
	<script type="text/javascript">
		$(top.hangge());
		//检索
		function search(){
			top.jzts();
			$("#roleForm").submit();
		}
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="角色新增";
			 diag.URL = '<%=basePath%>system/toRoleAdd';
			/*  diag.Width = 480;
			 diag.Height = 240; */
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage('${page.currentPage}');
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//修改
		function editUserType(roleId){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="角色修改";
			 diag.URL = '<%=basePath%>system/toRoleEdit?roleId='+roleId;
			/*  diag.Width = 480;
			 diag.Height = 240; */
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					nextPage('${page.currentPage }');
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function delUserType(roleId , msg){
			bootbox.confirm("确定要删除["+msg+"]吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>system/doDelRole?roleId=" + roleId
							+ "&tm=" + new Date().getTime();
					$.get(url, function(data) {
						nextPage('${page.currentPage }');
					});
				}
			});
		}
		
		//权限分配
		function jurisdiction(roleId){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="权限分配";
			 diag.URL = '<%=basePath%>system/tojurisdiction?roleId='+roleId;
			 diag.Width = 480;
			 diag.Height = 240;
			 diag.CancelEvent = function(){ //关闭事件
					diag.close();
				 };
			 diag.show();
		}
	</script>
</body>
</html>

