
<%@page import="java.sql.*"%>

<%! 
String url = "jdbc:mysql://localhost:3306/Project2";
String user ="root";
String pass = "sql73my2019#";
String result="false";
String type,name,approved;
%>
<%
String email = (String)request.getParameter("email");
String password = (String)request.getParameter("password");
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

	String sql = "select * from users";

	ResultSet output = st.executeQuery(sql);
	int i = 1;
	while(output.next()) {
		if(output.getString("email").equals(email)){
			if(output.getString("password").equals(password))
			{
				approved = output.getString("approved");
				if(approved.equals("Yes"))
					result="true";
				else if(approved.equals("Pending"))
					result="approval_pending";
				else
					result="denied";	
				type = output.getString("type");
				name = output.getString("firstname");
			}
		}

	}
	
	if(result.equals("true")){
		result =  "false";
		session.setAttribute("email",email);
		session.setAttribute("name",name);
		session.setAttribute("type",type);
		
		if(type.equals("admin"))
			response.sendRedirect("adminHome.jsp");
		if(type.equals("fieldemployee"))
			response.sendRedirect("fieldEmployeeHome.jsp");
		if(type.equals("programmanager"))
			response.sendRedirect("programManagerHome.jsp");
		if(type.equals("funder"))
			response.sendRedirect("funderHome.jsp");
		return;
	}
	
	if(result.equals("approval_pending")){
		response.sendRedirect("index.jsp?status=approval_pending");
	}
	
	if(result.equals("denied")){
		response.sendRedirect("index.jsp?status=denied");
	}
	 
	if(result.equals("false")){
		response.sendRedirect("index.jsp?status=false");
	}
	 
	if(result.equals("error")){
	    response.sendRedirect("index.jsp?status=error");
	}	
}
catch(SQLException e)
{
	System.out.println(e.getMessage());
}
%>