<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@
page import="java.sql.*"
%>

<%
String admin = (String)session.getAttribute("admin");
if (admin != null && admin.equals("true")){
	login = true;
		
}

%>


<%!
String str = "";
boolean login = false;

private void tree(Connection conn, int id, int level){
	ResultSet rs = null;
	Statement stmt = null;
	String preStr = "";
	for(int i=0; i<level; i++)
	{
		preStr += "----";
	}
	try{
		String sql = "select * from article where pid = " + id;
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		String strLogin = "";
		
		while(rs.next()){
		
			if (login){
				strLogin = "<td><a href='Delete.jsp?id=" + 
				rs.getInt("id") + "&pid=" + rs.getInt("pid") + "'>É¾³ý</a></td>";
			}
			
			str += "<tr><td>" + rs.getInt("id") + "</td><td>" + 
				preStr + "<a href='ShowArticleDetail.jsp?id=" + rs.getInt("id") + "'>" + 
				rs.getString("title") + "</a></td>" + strLogin + "</tr>";
			if(rs.getInt("isleaf") != 0){
				tree(conn, rs.getInt("id"), level + 1);
			}
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally{
		try {
			if(rs != null){
				rs.close();
				rs = null;
			}
			if(stmt != null){
				stmt.close();
				stmt = null;
			}
		
		} catch ( SQLException e1) {
			e1.printStackTrace();
		}
	}
} 
%>

<%
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?user=root&password=123456";
Connection connection = DriverManager.getConnection(url);
Statement statement = connection.createStatement();
ResultSet resultSet = statement.executeQuery("select * from article where pid = 0");
String strLogin = "";

while(resultSet.next()){
	if (login){
			strLogin = "<td><a href='Delete.jsp?id=" + 
			resultSet.getInt("id") + "&pid=" + resultSet.getInt("pid") + "'>É¾³ý</a></td>";
	}
	
	str += "<tr><td>" + resultSet.getInt("id") + "</td><td>" + 
		"<a href='ShowArticleDetail.jsp?id=" + resultSet.getInt("id") + "'>" + 
		resultSet.getString("title") + "</a></td>" + strLogin + "</tr>";
	if(resultSet.getInt("isleaf") != 0){
		tree(connection, resultSet.getInt("id"), 1);
	}
}
resultSet.close();
statement.close();
connection.close();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ShowArticleTree.jsp' starting page</title>
    
    <meta http-equiv="Content-Type" content="text/html; charset=gbk">
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
  <a href="Post.jsp" >·¢±íÐÂÌû</a>
  <table border="1">
  <%= str %>
  <% 
  str = ""; 
  login = false;
  
  %>
  </table>
  </body> 
</html>