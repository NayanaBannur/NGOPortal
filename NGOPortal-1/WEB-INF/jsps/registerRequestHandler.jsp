
<%@page import="java.sql.*"%>

<%! 
String url = "jdbc:mysql://localhost:3306/Project2";
String user ="root";
String pass = "sql73my2019#";
String result="true";
%>
<%

String email = (String)request.getParameter("email");
String firstname = (String)request.getParameter("firstname");
String lastname = (String)request.getParameter("lastname");
String type = (String)request.getParameter("type");
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
	
	System.out.println("Email:"+email);
	result = "true";
	while(output.next()) 
	{
		System.out.println(output.getString("email"));
		if(output.getString("email").equals(email))
		{
			System.out.println(output.getString("email"));
			result =  "false";
		}
	}
	
	System.out.println("Value of result = " +result );
	
	if(result.equals("true"))
	{
		String add_query = "insert into users(email,firstname,lastname,type,password,approved) values('"+email+"','"+firstname+"','"+lastname+"','"+type+"','"+password+"','Pending')";
		int i = st.executeUpdate(add_query);
		result = "false";
		
		if(i==0)
		{
			result = "error";
			response.sendRedirect("register.jsp?status=error");
		}
		else
		{
			result = "true";
			response.sendRedirect("register.jsp?status=true");
		}
		return;
		
	}
	if(result.equals("false")){
		response.sendRedirect("register.jsp?status=false");
	}
	 
	/*
	if(result.equals("error")){
	    response.sendRedirect("register.jsp?status=error");
	}
	*/
}
catch(SQLException e)
{
	System.out.println(e.getMessage());
}
 
%>