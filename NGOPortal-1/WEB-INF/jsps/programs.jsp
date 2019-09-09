<%@page import="java.sql.*"%>

<%! 
String url = "jdbc:mysql://localhost:3306/Project2";
String user ="root";
String pass = "sql73my2019#";
%>
<html>
<head>
        <title>NGO Portal</title>
        <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1">
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script>
function goBack() 
{
			window.history.back();
}
</script>
    </head>
<body>

<div class="row pl-5 pb-3">
<h2>Programs</h2>
</div>

<div class="container-fluid">

		<div>
			<table class="table table-bordered table-striped">
				    <thead>
				      <tr>
				        <th>Program Name</th>
				        <th>Start Date</th>
				        <th>End Date</th>
				        <th>Funder</th>
				        <th>More Information</th>
				      </tr>
				    </thead>
				    <tbody>
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

	String sql,sql1,sql2;
	ResultSet req;
	String funder_name;
	
	sql = "select * from programs"; 
	req = st.executeQuery(sql);

	while(req.next()) 
	{
		
		sql2 = "select firstname,lastname from users where email='"+req.getString("funder")+"'"; 
		Statement st2 = myCon.createStatement();
		ResultSet req2 = st1.executeQuery(sql2);
		req2.first();
		funder_name = req2.getString(1)+" "+req2.getString(2);
	%>
<tr>
      	<td><%out.println(req.getString("name")); %></td>
<td><%out.println(req.getString("startdate")); %></td>
<td><%out.println(req.getString("lastdate")); %></td>
<td><%out.println(funder_name); %></td>
<td><a href=<%= "\"viewProgram.jsp?ID=" + req.getInt(1) + "\"" %> >View More</a></td>
</tr>
<%
	req2.close();
	st2.close();
	}
	req.close();
	st.close();
}

catch(SQLException e)
{
	System.out.println(e.getMessage());
}
%>
			
		</tbody>
	  </table>
		
		</div>
		<div class="row p-4">
<button class="btn btn-primary" onclick="goBack()">Go Back</button>
			</div>
</div>

</body>
</html>