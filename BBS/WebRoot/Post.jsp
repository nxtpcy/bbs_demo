<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<% 
request.setCharacterEncoding("gbk");

String action = request.getParameter("action");

if(action != null && action.equals("post"))
{
	String title = request.getParameter("title");
	String cont = request.getParameter("cont");
	
	cont = cont.replaceAll("\n", "<br>");
	
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost/bbs?user=root&password=123456";
	Connection connection = DriverManager.getConnection(url);
	
	connection.setAutoCommit(false);
	
	String sql = "insert into article values (null, 0, ?, ?, ?, now(), 0)";
	PreparedStatement preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	Statement statement = connection.createStatement();
	
	preparedStatement.setInt(1, -1);
	preparedStatement.setString(2, title);
	preparedStatement.setString(3, cont);
	preparedStatement.executeUpdate();
	
	ResultSet resultSet = preparedStatement.getGeneratedKeys();
	resultSet.next();
	int key = resultSet.getInt(1);
	resultSet.close();
	
	
	statement.executeUpdate("update article set rootid = " + key + " where id = " + key);
	
	
	connection.commit();
	connection.setAutoCommit(true);
	
	statement.close();
	preparedStatement.close();
	connection.close();
	
	response.sendRedirect("ShowArticleFlat.jsp");
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Reply.jsp' starting page</title>
    
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
    <form action="Post.jsp" method="post" >
    	<input type="hidden" name="action" value="post">
    	<table border="1" >
    		<tr>
    			<td>
    				<input type="text" name="title" size="80" >
    			</td>
    		</tr>
    		<tr>
    			<td>
    				<textarea cols="80" rows="12" name="cont" ></textarea>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				<input type="submit" value="Ìá½»" >
    			</td>
    		</tr>
    	</table>
    </form>
  </body>
</html>