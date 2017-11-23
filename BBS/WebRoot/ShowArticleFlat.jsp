<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@
page import="java.sql.*"
%>




<%
int pageSize = 3;
int pageNo;

String strPageNo = request.getParameter("pageNo");
if (strPageNo == null || strPageNo.equals("")){
	pageNo = 1;
	
} else {

	try{
		pageNo = Integer.parseInt(strPageNo.trim());
	} catch (NumberFormatException e){
		pageNo = 1;
		
	}
	
	
	if (pageNo <= 0)
	{
		pageNo = 1;
		
	}
	
}






Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?user=root&password=123456";
Connection connection = DriverManager.getConnection(url);

Statement stmtCount = connection.createStatement();
ResultSet rsCount = stmtCount.executeQuery("select count(*) from article where pid = 0");
rsCount.next();
int totalRecords = rsCount.getInt(1);
int totalPages = totalRecords % pageSize == 0 ? totalRecords / pageSize : totalRecords / pageSize + 1;

if (pageNo > totalPages)
{
	pageNo = totalPages;
	
}

int startPos = (pageNo - 1) * pageSize;

Statement statement = connection.createStatement();
ResultSet resultSet = statement.executeQuery("select * from article where pid = 0 order by pdate desc limit " + startPos + ", " + pageSize);
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
  <a href="Post.jsp" >发表新帖</a>
  <table border="1">
  <%
  while (resultSet.next()){
  %>
  
  	<tr>
  		<td>
  			<%=resultSet.getString("title")  %>
  		</td>
  	</tr>	
  
  <%
  }
  resultSet.close();
  statement.close();
  connection.close();
  %>
  </table>
     共<%=totalPages %>页        第<%=pageNo %>页
  <a href="ShowArticleFlat.jsp?pageNo=<%=pageNo-1 %>">上一页</a> &nbsp;&nbsp;&nbsp;&nbsp;
  <a href="ShowArticleFlat.jsp?pageNo=<%=pageNo+1 %>">下一页</a> &nbsp;&nbsp;&nbsp;&nbsp;
  <a href="ShowArticleFlat.jsp?pageNo=1">首 页</a> &nbsp;&nbsp;&nbsp;&nbsp;
  <a href="ShowArticleFlat.jsp?pageNo=<%=totalPages %>">尾 页</a> 
  
  <form name="form1" action="ShowArticleFlat.jsp">
  	<select name="pageNo" onchange="document.form1.submit()">
  		<%
  		for (int i=1; i<=totalPages; i++){
  		%>
  		<option value=<%=i %> <%=(i == pageNo) ? "selected" : "" %>>第<%=i %>页
  		<% 
  		}
  		%>
  	</select>
  </form>
  
  <form name="form2" action="ShowArticleFlat.jsp">
  	<input type="text" size=6 name="pageNo" value=<%=pageNo %> />
  	<input type="submit" value="Go" />
  </form>
  
  </body> 
</html>
