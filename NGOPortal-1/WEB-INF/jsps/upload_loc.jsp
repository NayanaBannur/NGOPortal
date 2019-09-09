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
	Statement st1 = myCon.createStatement();
	Statement st2 = myCon.createStatement();
	int ID;
	try {
	   ID = Integer.parseInt((String)request.getParameter("ID"));
	}
	catch (NumberFormatException e)
	{
	   ID = 0;
	}
	int i=0,flag=0;
	String location = (String)request.getParameter("location");
	long millis=System.currentTimeMillis();  
	java.sql.Date date=new java.sql.Date(millis);
	String sql = "select ID from programs where startdate>='"+date+"' and ID='"+ID+"'";
	String sql2 = "select ID from programs where ID='"+ID+"'";
	ResultSet req=st.executeQuery(sql);
	ResultSet req2=st2.executeQuery(sql2);
	if(!req2.next())
	{
		flag=1;
	}
	while(req.next())
	{	
		flag = 1;
		String sql1 = "insert into program_locations values('"+ID+"','"+location+"')";
		i = st1.executeUpdate(sql1);
		break;
	}
	if(i!=0)
	{
		response.sendRedirect("programManagerHome.jsp?status_loc=true");
		return;
	}
	if(flag==0)
	{
		response.sendRedirect("programManagerHome.jsp?status_loc=false");
		return;
		
	}
	if(flag==1)
	{
		response.sendRedirect("programManagerHome.jsp?status_loc=error");
		return;
		
	}
}
catch(SQLException e)
{
	System.out.println(e.getMessage());
}
%>