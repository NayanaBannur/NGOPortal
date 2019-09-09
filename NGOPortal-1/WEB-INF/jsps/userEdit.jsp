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

	String action = (String)request.getParameter("action");
	String user_email = (String)request.getParameter("user_email");
	
	String sql;
	
	if(action.equals("terminate"))
	{
		long millis=System.currentTimeMillis();  
		java.sql.Date date=new java.sql.Date(millis);    
		sql = "update users set approved='No', enddate='"+date+"' where email='"+user_email+"'";
		int i = st.executeUpdate(sql);
		if(i==0)
			response.sendRedirect("adminHome.jsp?status_useredit=false");
		else
			response.sendRedirect("adminHome.jsp?status_useredit=true");
	}
	else if(action.equals("admin"))
	{
		sql = "update users set type='admin' where email='"+user_email+"' and approved='Yes'";
		int i = st.executeUpdate(sql);
		if(i==0)
			response.sendRedirect("adminHome.jsp?status_useredit=false");
		else
			response.sendRedirect("adminHome.jsp?status_useredit=true");
	}
	else if(action.equals("fe"))
	{
		sql = "update users set type='fieldemployee' where email='"+user_email+"' and approved='Yes'";
		int i = st.executeUpdate(sql);
		if(i==0)
			response.sendRedirect("adminHome.jsp?status_useredit=false");
		else
			response.sendRedirect("adminHome.jsp?status_useredit=true");
	}
	else if(action.equals("pm"))
	{
		sql = "update users set type='programmanager' where email='"+user_email+"' and approved='Yes'";
		int i = st.executeUpdate(sql);
		if(i==0)
			response.sendRedirect("adminHome.jsp?status_useredit=false");
		else
			response.sendRedirect("adminHome.jsp?status_useredit=true");
	}
	else
	{
		response.sendRedirect("adminHome.jsp?status_useredit=false");
	}
}
catch(SQLException e)
{
	System.out.println(e.getMessage());
}
%>