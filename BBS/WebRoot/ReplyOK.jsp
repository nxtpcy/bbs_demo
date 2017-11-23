<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="gbk" %>
<%@ page import="java.sql.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<% 
request.setCharacterEncoding("gbk");

int id = Integer.parseInt(request.getParameter("id"));
int rootid = Integer.parseInt(request.getParameter("rootid"));
String title = request.getParameter("title");
if (title == null){
	out.println("error!!!title is null!");
	return;
	
}

title = title.trim();
if (title.equals("")){
	out.println("title can not be empty!please input again!");
	return;
	
}

String cont = request.getParameter("cont");

cont = cont.trim();
if (cont.equals("")){
	out.println("content can not be empty!please input again!!!");
	return;
	
}

cont = cont.replaceAll("\n", "<br>");

Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?user=root&password=123456";
Connection connection = DriverManager.getConnection(url);

connection.setAutoCommit(false);

String sql = "insert into article values (null, ?, ?, ?, ?, now(), 0)";
PreparedStatement preparedStatement = connection.prepareStatement(sql);
Statement statement = connection.createStatement();

preparedStatement.setInt(1, id);
preparedStatement.setInt(2, rootid);
preparedStatement.setString(3, title);
preparedStatement.setString(4, cont);
preparedStatement.executeUpdate();

statement.executeUpdate("update article set isleaf = 1 where id = " + id);

connection.commit();
connection.setAutoCommit(true);

statement.close();
preparedStatement.close();
connection.close();

response.sendRedirect("ShowArticleTree.jsp");


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ReplyOK.jsp' starting page</title>
    
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
    <font color="red" size="7" >
    	OK!!!
    </font>
  </body>
</html>