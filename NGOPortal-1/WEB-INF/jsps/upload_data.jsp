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
	
	int i=0,flag=0,pos=1,newentry=0;
	String attr = (String)request.getParameter("attr");
	int ID,val;
	try
	{
		ID = Integer.parseInt((String)request.getParameter("ID"));
		val = Integer.parseInt((String)request.getParameter("value"));
	}
	catch (NumberFormatException e)
	{
	   ID = 0;
	   val=0;
	}
	String sql = "select * from programs where ID='"+ID+"'";
	ResultSet req=st.executeQuery(sql);
	
	if(!req.first())
	{
		flag=1;
	}
	req.close();
	ResultSet req_arr[]=new ResultSet[3];
	String sql_arr[] = new String[3];
	
	sql_arr[0] = "select ID from program_data where ID='"+ID+"'";
	req_arr[0]=st.executeQuery(sql_arr[0]);
	if(req_arr[0].next())
	{
		req_arr[0].close();
		sql_arr[1] = "select ID from program_data where attr1 is NULL and ID='"+ID+"'";
		req_arr[1]=st.executeQuery(sql_arr[1]);
		if(!req_arr[1].next())
		{
			pos++;
			req_arr[1].close();
			sql_arr[2] = "select ID from program_data where attr2 is NULL and ID='"+ID+"'";
			req_arr[2]=st.executeQuery(sql_arr[2]);
			if(!req_arr[2].next())
			{
				pos++;
				req_arr[2].close();
			}
		}
	}
	else
	{
		if(flag==0)
		{
			newentry = 1;
			flag = 1;
			String sql1 = "insert into program_data(ID,attr"+pos+",val"+pos+") values('"+ID+"','"+attr+"','"+val+"')";
			i = st.executeUpdate(sql1);
		}
		
	}
	if(newentry==0)
	{
		String sqlst = "select ID from program_data where attr"+pos+" is NULL and ID='"+ID+"'";
		ResultSet reqst=st.executeQuery(sqlst);
		while(reqst.next())
		{	
			flag = 1;
			String sql1 = "update program_data set ID='"+ID+"',attr"+pos+"='"+attr+"', val"+pos+"='"+val+"' where attr"+pos+" is NULL and ID='"+ID+"'";
			i = st.executeUpdate(sql1);
			break;
		}
	}
	st.close();
	if(i!=0)
	{
		response.sendRedirect("fieldEmployeeHome.jsp?status_data=true");
		return;
	}
	else
	{
		if(flag==0)
		{
			response.sendRedirect("fieldEmployeeHome.jsp?status_data=false");
			return;
		}
		if(flag==1)
		{
			response.sendRedirect("fieldEmployeeHome.jsp?status_data=error");
			return;
		}
	}
}
catch(SQLException e)
{
	System.out.println(e.getMessage());
}
%>