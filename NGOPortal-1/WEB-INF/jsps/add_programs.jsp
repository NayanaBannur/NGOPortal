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

	String pname = (String)request.getParameter("name");
	String startdate = (String)request.getParameter("startdate");
	String lastdate = (String)request.getParameter("lastdate");
	String manager = (String)request.getParameter("manager");
	String funder = (String)request.getParameter("funder");
	String description = (String)request.getParameter("description");

	String sql = "select * from programs";

	ResultSet output = st.executeQuery(sql);
		
	while(output.next()) 
	{
		if(output.getString("name").equals(pname))
		{
			result =  "false";
		}
	}
		
	if(result.equals("true"))
	{
		String add_query = "insert into programs(name,startdate,lastdate,manager,funder,description) values('"+pname+"','"+startdate+"','"+lastdate+"','"+manager+"','"+funder+"','"+description+"')";
		int i = st.executeUpdate(add_query);
		result = "false";
			
		if(i==0)
		{
			result="error";
			response.sendRedirect("programManagerHome.jsp?status=error");
		}	
		else
		{
			result = "true";
			response.sendRedirect("programManagerHome.jsp?status=true");	
		}
		return;
			
	}
	if(result.equals("false")){
		response.sendRedirect("programManagerHome.jsp?status=false");
	}
		 
	if(result.equals("error")){
		response.sendRedirect("programManagerHome.jsp?status=error");
	}
}
catch(SQLException e)
{
	System.out.println(e.getMessage());
}
%>