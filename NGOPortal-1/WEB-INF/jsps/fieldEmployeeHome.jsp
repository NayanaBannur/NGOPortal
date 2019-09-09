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
        
    </head>
	
    <body>
    
    
        <%
String email=(String)session.getAttribute("email");
String name=(String)session.getAttribute("name");
String type=(String)session.getAttribute("type");

if(email==null)
{
	response.sendRedirect("index.jsp");
}
if(type!=null&&type.equals("fieldemployee")==false)
{
	response.sendRedirect("logout.jsp");
}
%>


<nav class="navbar navbar-expand-sm bg-light">
	<div class="container-fluid">
		<ul class="navbar-nav" style="width: 100px;">
<li class="px-2 nav-item text-nowrap" style="width: 100px;">
				<a class="nav-brand text-primary">NGO Portal</a>
	</li>
</ul>
 		<ul class="nav nav-tabs justify-content-left" id="tabs">
<li class="nav-item text-nowrap" style="width: 100px;">
		<a class="nav-link active text-primary text-center" data-toggle="tab" href="#home">Home</a>
</li>
<li class="nav-item text-nowrap" style="width: 100px;">
		<a class="nav-link text-primary text-center" data-toggle="tab" href="#Programs">Programs</a>
</li>
<li class="nav-item text-nowrap" style="width: 100px;">
					<a class="nav-link text-primary text-center" data-toggle="tab" href="#Upload">Upload</a>
			</li>
</ul>
<ul class="navbar-nav" style="width: 100px;">
<li class="px-2 nav-item text-nowrap text-primary text-center" style="width: 100px;">
    					<a class="nav-link" href="logout.jsp">Logout</a>
  				</li>
  			</ul>
	</div>
</nav>


      <br>
      
      	
<div class="tab-content">


		<div class="tab-pane container active" id="home">
			<div class="container-fluid">
      			<div class="row">
						<p>Early Years: Early Childhood Program </p>
						</div>
						<div class="row">
						<ul>
				<li>Direct implementation</li>
				<li>Early Childhood Education</li>
				<li>Early Years Learning Programs</li>
				<li>Government Partnerships</li>
				<li>Anganwadi / ICDS</li>
				</ul>
				</div>
				<div class="row">
				<p>ELEMENTARY YEARS</p>
				</div>
				<div class="row">
				<ul>
				<li>Direct implementation</li>
				<li>Read India (TaRL)</li>
				<li>Urdu</li>
				<li>Government Partnerships</li>
				<li>Grades 3-5 (TaRL)</li>
				<li>Grades 6 and above</li>
				<li>District Institutes of Education and Training</li>
				</ul>
				</div>
				<div class="row">
				<p>BEYOND ELEMENTARY</p>
				</div>
				<div class="row">
				<ul>
				<li>Second Chance</li>
						</ul>
						</div>
		</div>
		</div>
			
			
			<div class="tab-pane container fade" id="Programs">  
			<h2>Programs</h2> 
			
			<div class="container-fluid">
				<form class="form-inline" action="fieldEmployeeHome.jsp" method="post">
					
					<div class="p-1 form-group col-sm-4">	
						<label class="p-2" for="time">Time of Event:</label><br>
				<select required name="time" class="form-control">
				  	<option selected value="all">All</option>
				  	<option value="current">Current</option>
				  	<option value="past">Past</option>
				</select>
			</div>
      		
      		<button type="submit" class="btn btn-primary">Apply</button><br>
				</form>
			</div>  
			<br>
			
			<p>
	<%
String disp_time;
String time = (String)request.getParameter("time");

if(time==null||time.equals("all"))
	disp_time="All";
else if(time.equals("current"))
	disp_time="Current";
else
	disp_time="Past";

%>
Displaying:<br>
<%= disp_time %> Programs
</p> 
			
			<table class="table table-bordered">
	    <thead>
	      <tr>
	      	<th>Program ID</th>
	        <th>Program Name</th>
	        <th>Start Date</th>
	        <th>End Date</th>
	        <th>Program Manager</th>
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
	
	long millis=System.currentTimeMillis();  
	java.sql.Date date=new java.sql.Date(millis);  

	String sql;
	ResultSet req;
	
	String manager_name,funder_name;
	
	if(time!=null&&time.equals("current"))
	{
		sql = "select * from programs where startdate>='"+date+"'"; 
		req = st.executeQuery(sql);
	}
	else if(time!=null&&time.equals("past"))
	{
		sql = "select * from programs where startdate<'"+date+"'"; 
		req = st.executeQuery(sql);
	}
	else
	{
		sql = "select * from programs"; 
		req = st.executeQuery(sql);
	}
	
	while(req.next()) 
	{
		String sql1 = "select firstname,lastname from users where email='"+req.getString("manager")+"'"; 
		Statement st1 = myCon.createStatement();
		ResultSet req1 = st1.executeQuery(sql1);
		req1.first();
		manager_name = req1.getString(1)+" "+req1.getString(2);
		
		String sql2 = "select firstname,lastname from users where email='"+req.getString("funder")+"'"; 
		Statement st2 = myCon.createStatement();
		ResultSet req2 = st1.executeQuery(sql2);
		req2.first();
		funder_name = req2.getString(1)+" "+req2.getString(2);
	%>
<tr>
	<td><%out.println(req.getInt("ID")); %></td>
<td><%out.println(req.getString("name")); %></td>
<td><%out.println(req.getString("startdate")); %></td>
<td><%out.println(req.getString("lastdate")); %></td>
<td><%out.println(manager_name); %></td>
<td><%out.println(funder_name); %></td>
<td><a href=<%= "\"viewProgram.jsp?ID=" + req.getInt(1) + "\"" %> >View More</a></td>
</tr>
<%
	req1.close();
	st1.close();
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
	
<br>    
 		
</div>


<div class="tab-pane container fade" id="Upload">

<div class="container-fluid ">
	
	<div class="row">
	<div class="column col-sm-6">
	
	<h3>Upload Data</h3>
	<p>Upload event information. Each event can have a maximum of three attributes.</p>
	<form action="upload_data.jsp" method="post">
	<div class="p-2 col-sm-12">
		<label for="ID">Program ID:</label><br>
			<input type="text" name="ID" placeholder="Enter program ID" class="form-control" required/>
	</div>
	<div class="p-2 col-sm-12">
		<label for="attr">New Attribute:</label><br>
			<input type="text" name="attr" placeholder="Enter new attribute" class="form-control" required/>
	</div>
	
	<div class="p-2 col-sm-12">
		<label for="value">Attribute Value:</label><br>
			<input type="text" name="value" placeholder="Enter attribute value" class="form-control" required/>
	</div>

	<div class="p-2">
	<button type="submit" class="btn btn-primary">Upload</button><br>
	</div>
	</form>
		<div class="row">
		<%
String status_data=request.getParameter("status_data");
    if(status_data!=null)
    {
    	if(status_data.equals("true"))
    	{
    		out.println("Data uploaded!");	           		
    	}
    	else if(status_data.equals("false"))
    	{
    		out.println("Maximum number of attributes reached! Could not upload.");
    	}
    	else
    	{
    		out.println("Invalid ID!");
    	}
    }
%>
	</div>

</div>

<div class="column col-sm-6">
<h3>Upload Images</h3>
<p>Upload event images.</p>
<form action="upload_im.jsp" method="post">
<div class="p-2 col-sm-12">
	<label for="ID">Program ID:</label><br>
		<input type="text" name="ID" placeholder="Enter program ID" class="form-control" required/>
</div>
<div class="p-2 col-sm-12">
	<label for="image">Image Upload:</label><br>
		<input type="text" name="image" placeholder="Enter image path" class="form-control" required/>
</div>
<div class="p-2">
<button type="submit" class="btn btn-primary">Upload</button><br>
</div>
</form>
	<div class="row">
	<%
String status_im=request.getParameter("status_im");
    if(status_im!=null)
    {
    	if(status_im.equals("true"))
    	{
    		out.println("Image uploaded!");	           		
    	}
    	else
    	{
    		out.println("An error occurred!");
    	}
    }
%>
	  				</div>
  				</div>
  				
	  			</div>
	  			
	        </div>
  			</div>
  			
  			
		</div>
    </body>
</html>