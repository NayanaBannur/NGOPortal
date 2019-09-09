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
<%
String ID=(String)request.getParameter("ID");

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

	String sql = "select * from programs where ID='"+ID+"'";
	
	ResultSet req = st.executeQuery(sql);
	
	req.first();
	
	String pname=req.getString(2);
	String startdate=req.getString(3);
	String lastdate=req.getString(4);
	String description=req.getString(7);
	if(description==null)
		description="No description available.";
	
	String sql1 = "select firstname,lastname from users where email='"+req.getString("manager")+"'"; 
	Statement st1 = myCon.createStatement();
	ResultSet req1 = st1.executeQuery(sql1);
	req1.first();
	String manager_name = req1.getString(1)+" "+req1.getString(2);
	
	String sql2 = "select firstname,lastname from users where email='"+req.getString("funder")+"'"; 
	Statement st2 = myCon.createStatement();
	ResultSet req2 = st1.executeQuery(sql2);
	req2.first();
	String funder_name = req2.getString(1)+" "+req2.getString(2);
	
	req.close();
	req1.close();
	req2.close();
	
	st.close();
	st1.close();
	st2.close();
	
	%>
<div class="container-fluid">

<div class="row p-2">
<h2 class="text-nowrap"><%=pname%></h2>
</div>

<div class="row p-2">
<h4 class="text-nowrap">Program ID <%=ID%></h4>
</div>

<div class="row p-2">
<%=description %>
</div>

<h4 class="text-nowrap p-2">Gallery</h4>

<div class="container-fluid">
	<%
Statement st3 = myCon.createStatement();

String sql3 = "select path from program_images where ID='"+ID+"'";

ResultSet req3 = st3.executeQuery(sql3);

int flag=0;

while(req3.next())
{
	flag=1;
	String path = req3.getString(1);
%>
<img src="<%=path %>" alt="Image Not Found" class="img-thumbnail p-2"><br/><br/>
<% 
}

if(flag==0)
	out.println("No images available.");
req3.close();
st3.close();
%>
</div>

<h4 class="text-nowrap p-2">Locations</h4>

<div class="container-fluid">
	<%
Statement st4 = myCon.createStatement();

String sql4 = "select location from program_locations where ID='"+ID+"'";

ResultSet req4 = st4.executeQuery(sql4);

int flag1=0;

while(req4.next())
{
	flag1=1;
	String loc = req4.getString(1);
%>
<p><%=loc %></p>
<% 
}

if(flag1==0)
	out.println("No locations available.");
req4.close();
st4.close();
%>

</div>

<h4 class="text-nowrap p-2">Other information</h4>

<div class="container-fluid">
	<%
Statement st5 = myCon.createStatement();

String sql5 = "select * from program_data where ID='"+ID+"'";

ResultSet req5 = st5.executeQuery(sql5);

int flag2=0;

while(req5.next())
{
	flag2=1;
	String attr[]=new String[3];
	int val[]=new int[3],num=3,i;
	attr[0] = req5.getString(2);
	attr[1] = req5.getString(4);
	attr[2] = req5.getString(6);
	val[0] = req5.getInt(3);
	val[1] = req5.getInt(5);
	val[2] = req5.getInt(7);
	
	if(attr[2]==null)
		num=2;
	if(attr[1]==null)
		num=1;
	if(attr[0]==null) 
		num=0;
	for(i=0;i<num;i++)
	{
		%>
<p><%=attr[i] %>: <%= val[i]%></p>
<% 
	}
}

if(flag2==0)
	out.println("No other information available.");
req5.close();
st5.close();
%>

</div>

<div class="row p-4">
<button class="btn btn-primary" onclick="goBack()">Go Back</button>
</div>
</div>
<%
}
catch(SQLException e)
{
	e.printStackTrace();
}

%>
</body>
</html>