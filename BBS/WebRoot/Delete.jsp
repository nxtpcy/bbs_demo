<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="gbk" %>
<%@ page import="java.sql.*" %>


<% 
String admin = (String)session.getAttribute("admin");
if (admin == null || !admin.equals("true")){
	out.println("小贼！！！别想通过我这关！！");
	return;
}



%>

<%! 
private void del(Connection conn, int id){
	ResultSet rs = null;
	Statement stmt = null;
	
	try{
		String sql = "select * from article where pid = " + id;
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		while(rs.next()){
		
			del(conn, rs.getInt("id"));
			
		}
		stmt.executeUpdate("delete from article where id = " + id);
		
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

int id = Integer.parseInt(request.getParameter("id"));
int pid = Integer.parseInt(request.getParameter("pid"));


Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?user=root&password=123456";
Connection connection = DriverManager.getConnection(url);

connection.setAutoCommit(false);

del(connection, id);

Statement statement = connection.createStatement();
ResultSet resultSet = statement.executeQuery("select count(*) from article where pid = " + pid);
resultSet.next();
int count = resultSet.getInt(1);
resultSet.close();
statement.close();

if (count <= 0)
{
	Statement stmtUpdate = connection.createStatement();
	stmtUpdate.executeUpdate("update article set isleaf = 0 where id = " + pid);
	stmtUpdate.close();
	
}

connection.commit();
connection.setAutoCommit(true);

connection.close();

response.sendRedirect("ShowArticleTree.jsp");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
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
  
  </body>
</html>