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
<h2>Statistics</h2>
</div>

<div class="container-fluid">

		<div>
			<table class="table table-bordered table-striped">
				    <thead>
				      <tr>
				        <th>Program Name</th>
				        <th>Field 1</th>
				        <th>Field 2</th>
				        <th>Field 3</th>
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
	
	
	sql = "select * from program_data"; 
	req = st.executeQuery(sql);
	
	String f1,f2,f3,name;
	int id;
	while(req.next()) 
	{
		if(req.getString("attr1")!=null)
			f1 = req.getString("attr1")+" : "+req.getInt("val1");
		else
			f1 = "---";
		if(req.getString("attr2")!=null)
			f2 = req.getString("attr2")+" : "+req.getInt("val2");
		else
			f2 = "---";
		if(req.getString("attr3")!=null)
			f3 = req.getString("attr3")+" : "+req.getInt("val3");
		else
			f3 = "---";
		id = req.getInt("id");
		sql2 = "select name from programs where id='"+id+"'"; 
		Statement st2 = myCon.createStatement();
		ResultSet req2 = st1.executeQuery(sql2);
		req2.first();
		name = req2.getString(1);
		
	%>
<tr>
      	<td><%out.println(name); %></td>
	<td><%out.println(f1); %></td>
	<td><%out.println(f2); %></td>
	<td><%out.println(f3); %></td>
</tr>
<%
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