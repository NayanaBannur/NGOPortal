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
if(type!=null&&type.equals("programmanager")==false)
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
<li class="nav-item text-nowrap" style="width: 150px;">
		<a class="nav-link active text-primary text-center" data-toggle="tab" href="#home">Home</a>
</li>
<li class="nav-item text-nowrap" style="width: 150px;">
		<a class="nav-link text-primary text-center" data-toggle="tab" href="#programs">Programs</a>
</li>
<li class="nav-item text-nowrap" style="width: 150px;">
		<a class="nav-link text-primary text-center" data-toggle="tab" href="#EditPrograms">Add Programs</a>
</li>
<li class="nav-item text-nowrap" style="width: 150px;">
					<a class="nav-link text-primary text-center" data-toggle="tab" href="#AddLoc">Update Locations</a>
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
			
			
			<div class="tab-pane container fade" id="programs">  
			<h2>Programs</h2>
			<div class="container-fluid">
				<form class="form-inline" action="programManagerHome.jsp" method="post">
				
					<div class="p-1 form-group col-sm-4">
						<label class="p-2" for="whose">Managed by:</label><br>
       			<select required name="whose" class="form-control">
       				<option selected value="all">Anyone</option>
					<option value="mine">Me</option>
				</select>	
       		</div>
					
					<div class="p-1 form-group col-sm-4">	
						<label class="p-2" for="location">Time of Event:</label><br>
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
String disp_time,disp_whose;
String time = (String)request.getParameter("time");
String whose = (String)request.getParameter("whose");

if(time==null||time.equals("all"))
	disp_time="All";
else if(time.equals("current"))
	disp_time="Current";
else
	disp_time="Past";

if(whose==null||whose.equals("all"))
	disp_whose="Anyone";
else
	disp_whose="Me";

%>
Displaying:<br>
Manager: <%= disp_whose %>,
Time: <%= disp_time %>
</p>
		
		<table class="table table-bordered table-striped">
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

	String sql,sql1,sql2;
	ResultSet req;
	long millis=System.currentTimeMillis();  
	java.sql.Date date=new java.sql.Date(millis); 
	String manager_name,funder_name;
	
	if(whose!=null&&whose.equals("mine"))
	{
		if(time!=null&&time.equals("current"))
		{
			sql = "select * from programs where startdate>='"+date+"' and manager='"+email+"'"; 
			req = st.executeQuery(sql);
		}
		else if(time!=null&&time.equals("past"))
		{
			sql = "select * from programs where startdate<'"+date+"' and manager='"+email+"'"; 
			req = st.executeQuery(sql);
		}
		else
		{
			sql = "select * from programs where manager='"+email+"'"; 
			req = st.executeQuery(sql);
		}
	}
	else
	{
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
	}
	
	while(req.next()) 
	{
		sql1 = "select firstname,lastname from users where email='"+req.getString("manager")+"'"; 
		Statement st1 = myCon.createStatement();
		ResultSet req1 = st1.executeQuery(sql1);
		req1.first();
		manager_name = req1.getString(1)+" "+req1.getString(2);
		
		sql2 = "select firstname,lastname from users where email='"+req.getString("funder")+"'"; 
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

</div>

<div class="tab-pane container fade" id="EditPrograms">
<%
String status=request.getParameter("status");
if(status!=null)
      {
      	if(status.equals("false"))
      	{
      		   out.print("Program already exists!");
      		   status=null;
      	}
      	else if(status.equals("true"))
      	{
      		   out.print("Program added!");	   
      		   status = null;
      	}
      	else
      	{
      		out.print("An error occurred!");
      		status = null;
      	}
      }
%>
		
		<div class="container-fluid ">
	<h2>Add Program</h2>
    	<form action="add_programs.jsp" method="post" id="add_programs">
        	
        	<div class="p-1 form-group col-sm-6">
        		<label for="name">Program Name:</label><br>
    			<input type="text" name="name" placeholder="Enter program name"  class="form-control" required/>
        	</div>
        	
        	<div class="p-1 form-group col-sm-6">
        		<label for="startdate">Start Date:</label><br>
    			<input type="date" name="startdate" placeholder="Enter start date(YYYY/MM/DD)"  class="form-control" required/>
        	</div>
        	
        	<div class="p-1 form-group col-sm-6">
        		<label for="lastdate">End Date:</label><br>
    			<input type="date" name="lastdate" placeholder="Enter end date(YYYY/MM/DD)" class="form-control" required/>
        	</div>
        	
        	<div class="p-1 form-group col-sm-6">
        		<label for="manager">Program Manager (Email Address):</label><br>
    			<input type="email" name="manager" placeholder="Enter program manager's email adress" class="form-control" required/>
        	</div>
        	
        	<div class="p-1 form-group col-sm-6">
        		<label for="funder">Funder (Email Address):</label><br>
    			<input type="email" name="funder" placeholder="Enter funder's email adress" class="form-control" required/>
        	</div>
        	
        	<div class="p-1 form-group col-sm-12">
        		<label for="description">Description:</label><br>
    			<input type="text" name="description" placeholder="Enter description" class="form-control" required/>
        	</div>
        	
        	<button type="submit" class="btn btn-primary">Add</button>
        </form>
        <br>
</div>
		
	</div>
	
	<div class="tab-pane container fade" id="AddLoc">
	
	<div class="column col-sm-6">
		<h2>Add Location</h2>
		<p>Add locations at which the event will happen.</p>
		<form action="upload_loc.jsp" method="post">
		<div class="p-2 col-sm-12">
			<label for="ID">Program ID:</label><br>
 			<input type="text" name="ID" placeholder="Enter program ID" class="form-control" required/>
		</div>
		<div class="p-2 col-sm-12">
			<label for="location">Add Location:</label><br>
 			<input type="text" name="location" placeholder="Enter location" class="form-control" required/>
		</div>
		<div class="p-2">
		<button type="submit" class="btn btn-primary">Add</button><br>
		</div>
		</form>
			<div class="row">
			<%
String status_loc=request.getParameter("status_loc");
    if(status_loc!=null)
    {
    	if(status_loc.equals("true"))
    	{
    		out.println("Location added!");	           		
    	}
    	else if(status_loc.equals("false"))
    	{
    		out.println("This event is already over! Cannot add new locations.");	
    	}
    	else
    	{
    		out.println("Invalid ID.");	
    	}	
    }
%>
	  				</div>
  				</div> 
  			
  			</div>
  			
  			
		</div>
    </body>
</html>