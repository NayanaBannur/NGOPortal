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
     String type=(String)session.getAttribute("type");
     System.out.println("Current user email:"+email);
     //redirect user to home page if already logged in
     if(email!=null)
     {
         if(type.equals("admin"))
     		response.sendRedirect("adminHome.jsp");
         if(type.equals("programmanager"))
     		response.sendRedirect("programManagerHome.jsp");
         if(type.equals("fieldemployee"))
     		response.sendRedirect("fieldEmployeeHome.jsp");
         if(type.equals("funder"))
     		response.sendRedirect("funderHome.jsp");
     }
HttpSession sess = request.getSession();
sess.setMaxInactiveInterval(10000);
System.out.println("Session ID:"+sess.getId());
     String status=request.getParameter("status");
     %>
   
   <div class="container-fluid ">
   	<div class="row p-2 ">
   	<div class="column col-sm-8">
   	<div class="jumbotron">
<h1 class="display-4">NGO</h1>
<p class="lead">We are a well-known and established organization with a goal of improving educational levels among school-age children in India. 
All our activities aim to address a gap or a need in the education system and in society. We aim for high impact and low cost on scale.</p>
<hr class="my-4">
<!-- NAV TABS: Mission, Contact Us -->
  <p>Our mission is to provide quality education for all children.</p>
  <p>
  Over the last fifteen years, we run multiple programs that have all been designed to be comprehensive, scalable and cost-effective. 
  All our programs are child-centric and are designed to ensure that enrollment in schools increase, drop-outs from schools decrease and that children's learning outcomes and overall development improve. 
  In particular, we work in close partnership with the Education Department and the Department of Women and Child Welfare of the government to supplement existing primary school school programs.
  </p>
  
  <img src="images/indeximage.jpg" alt="Responsive image" class="img-fluid p-2 rounded mx-auto d-block">

</div>
</div>
     	<div class="column col-sm-4 bg-light">
     	<div class="row p-2">
     		<h2>Login</h2>
     	</div>
     	<div class="row p-2">
     	<form action="loginRequestHandler.jsp">
     		<div class="p-1 form-group col-sm-12">
     			<label for="email" class="text-nowrap">Email address:</label><br>
 				<input type="email" name="email" placeholder="Enter email address" class="form-control" required/>
     		</div>
     		<div class="p-1 form-group col-sm-12">
     			<label for="password" class="text-nowrap">Password:</label><br>
 				<input type="password" name="password" placeholder="Enter password" class="form-control" required/>
     		</div>
     		<button type="submit" class="btn btn-primary">Login</button><br>
     	</form>
     	</div>
     	<div class="row">
<%

if(status!=null)
{
	if(status.equals("false"))
	{
		   out.print("Incorrect login details!");	           		
	}
	else if(status.equals("approval_pending"))
	{
		   out.print("Approval Pending!");	           		
	}
	else if(status.equals("denied"))
	{
		   out.print("Approval Denied!");	           		
	}
	else
	{
		out.print("An error occurred!");
	}
}
%>
			</div>
			<div class="row p-2">
			<p>Don't have an account?</p>
			</div>
			<div class="row p-2">
        	<a href="register.jsp" class="btn btn-primary" role="button">Sign Up</a>
			</div>
			<hr/>
			<div class="container-fluid">
			<div class="row p-2">
			<h2>Links</h2>
			</div>
			<div class="row p-2">
			<a href="statistics.jsp" class="text" role="button">View Statistics</a>
			</div>
			<div class="row p-2">
			<a href="programs.jsp" class="text" role="button">View Programs</a>
			</div>
			</div>
        	</div>
        	</div>
        </div>
    
    </body>
</html>