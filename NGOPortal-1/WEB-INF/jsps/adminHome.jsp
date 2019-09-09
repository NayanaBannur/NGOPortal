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
        if(type!=null&&type.equals("admin")==false)
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
   						<a class="nav-link text-primary text-center" data-toggle="tab" href="#requests">Requests</a>
  					</li>
  					<li class="nav-item text-nowrap" style="width: 100px;">
    					<a class="nav-link text-primary text-center" data-toggle="tab" href="#EditUsers">Edit Users</a>
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
  			
  			
  			<div class="tab-pane container fade" id="requests">  
  			<h2>Approve membership requests</h2>  
  			<br>    
				  <table class="table table-bordered">
				    <thead>
				      <tr>
				        <th>First Name</th>
				        <th>Last Name</th>
				        <th>Email</th>
				        <th>Role</th>
				        <th>Approved</th>
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
						
							String sql = "select * from users where approved='Pending'";
							
							ResultSet req = st.executeQuery(sql);
							
							while(req.next()) 
							{
								String user_email = req.getString("email");
							%>
								<tr>
						        	<td><%out.println(req.getString("firstname")); %></td>
						        	<td><%out.println(req.getString("lastname")); %></td>
						        	<td><%out.println(req.getString("email")); %></td>
						        	<td><%out.println(req.getString("type")); %></td>
						        	<td>
						        		<div class="form-group">
						        			<form action="approval.jsp" method="post">
										  		<select name="approved" id="approved" required>
										    		<option>Yes</option>
										    		<option>No</option>
										  		</select>
										  		<input type="hidden" name="user_email" value="<%=user_email%>"/>
										  		<input class="btn btn-default" type="submit" value="Submit">	
										  	</form>
										</div>
						        	</td>
						      	</tr>
							<% 
							}
							req.close();
						}
						
						catch(SQLException e)
						{
							System.out.println(e.getMessage());
						}
						%>
					</tbody>
				  </table> 
				  
				  <div class="row">
	  				<%
	  				String status=request.getParameter("status");
			        if(status!=null)
			        {
			        	if(status.equals("true"))
			        	{
			        		out.println("Application status updated!");	           		
			        	}
			        	else 
			        	{
			        		out.println("Unable perform action.");	
			        	}	
			        }
					%>
	  				</div>
				  	 			
  			</div>
  			
  		
  			<div class="tab-pane container fade" id="EditUsers">
  			<h2>Edit Users</h2>
  				<div class="container-fluid ">  
	        	<form action="userEdit.jsp" method="post">
	        		<div class="p-1 form-group col-sm-6">
	        			<label for="user_email">Email address:</label><br>
	    				<input type="email" name="user_email" placeholder="Enter email address" class="form-control" required/>
	        		</div>
	        		<div class="p-1 form-group col-sm-6">
	        			<label for="action">Action:</label><br>
	    				<select name="action" id="action" class="form-control" required>
							<option value="terminate">Terminate Membership</option>
							<option value="admin">Make Admin</option>
							<option value="pm">Make Program Manager</option>
							<option selected value="fe">Make Field Employee</option>
						</select>
	        		</div>
	        		<button type="submit" class="btn btn-primary">Make Changes</button><br>
	        	</form>
	        	<div class="row">
	  				<%
	  				String status_useredit=request.getParameter("status_useredit");
			        if(status_useredit!=null)
			        {
			        	if(status_useredit.equals("true"))
			        	{
			        		out.println("User information updated!");	           		
			        	}
			        	else 
			        	{
			        		out.println("Unable to perform update.");	
			        	}	
			        }
					%>
	  				</div>
	        	</div>
  			</div>
  			
  			
		</div>
    </body>
</html>