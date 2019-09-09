<%@page import="java.sql.*"%>

<%! 
String url = "jdbc:mysql://localhost:3306/Project2";
String user ="root";
String pass = "sql73my2019#";
%>
<% 
try
{
	Class.forName("com.mysql.jdbc.Driver");
}
catch(ClassNotFoundException e)
{
	e.printStackTrace();
}
try
{
	Connection myCon = DriverManager.getConnection(url, user, pass);
						
	Statement st = myCon.createStatement();

	String approved = (String)request.getParameter("approved");
	String user_email = (String)request.getParameter("user_email");
	
	if (approved != null && !approved.isEmpty()) 
	{
		long millis=System.currentTimeMillis();  
		java.sql.Date date=new java.sql.Date(millis);    
		String sql = "update users set approved='"+approved+"', joindate='"+date+"' where email='"+user_email+"'";
		int i = st.executeUpdate(sql);
		if(i==0)
		{
			response.sendRedirect("adminHome.jsp?status=false");
			return;
		}
		else
		{
			response.sendRedirect("adminHome.jsp?status=true");
			return;
		}
	}
	response.sendRedirect("adminHome.jsp?status=false");
	return;
}
catch(SQLException e)
{
	System.out.println(e.getMessage());
}
%>