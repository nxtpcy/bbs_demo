<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="gbk" %>
<%@ page import="java.sql.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%
String strId = request.getParameter("id");
int id = Integer.parseInt(strId);

Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?user=root&password=123456";
Connection connection = DriverManager.getConnection(url);
Statement statement = connection.createStatement();
ResultSet resultSet = statement.executeQuery("select * from article where id = " + id);

%>

<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ShowArticleDetail.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
	<%
		if(resultSet.next()){
	%>
	<table border="1">
		<tr>
			<td>ID</td>
			<td><%= resultSet.getInt("id") %></td>
		</tr>
		<tr>
			<td>Title</td>
			<td><%= resultSet.getString("title") %></td>
		</tr>
		<tr>
			<td>Content</td>
			<td><%= resultSet.getString("cont") %></td>
		</tr>
	</table>
	<a href="Reply.jsp?id=<%= resultSet.getInt("id") %>&rootid=<%= resultSet.getInt("rootid")%>">»Ø¸´</a>
	<% 
		}
		resultSet.close();
		statement.close();
		connection.close();
	%>	
  </body>
</html>