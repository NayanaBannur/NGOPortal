<%@page import="java.sql.*"%>

<%! 
String url = "jdbc:mysql://localhost:3306/Project2";
String user ="root";
String pass = "sql73my2019#";
String result="true";
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
	int ID;
	try {
	   ID = Integer.parseInt((String)request.getParameter("ID"));
	}
	catch (NumberFormatException e)
	{
	   ID = 0;
	}
	
	String filePath = (String)request.getParameter("image");
	
	String sql = "insert into program_images values('"+ID+"','"+filePath+"')";

	int i = st.executeUpdate(sql);
	
	if(i==0)
	{
		response.sendRedirect("fieldEmployeeHome.jsp?status_im=error");
	}
	else
	{
		response.sendRedirect("fieldEmployeeHome.jsp?status_im=true");
	}
}
catch(SQLException e)
{
	System.out.println(e.getMessage());
}
%>