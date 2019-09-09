<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1">
        
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<title>Registration</title>
</head>
<body>
<%
HttpSession sess = request.getSession();
sess.setMaxInactiveInterval(10);
System.out.println("Session ID:"+sess.getId());
     String status=request.getParameter("status");
     
     if(status!=null)
     {
     	if(status.equals("false"))
     	{
     		   out.print("This email is already registered!");	 
     		   status=null;
     	}
     	else if(status.equals("true"))
     	{
     		status = null;
     		response.sendRedirect("index.jsp");
     	}
     	else
     	{
     		out.print("Some error occurred!");
     		status = null;
     	}
     }
%>

<div class="container-fluid ">
<h2>Register</h2>
	<form action="registerRequestHandler.jsp">
				    	
		<div class="p-1 form-group col-sm-6">
			<label for="email">Email address</label><br>
				<input type="email" name="email" placeholder="Enter email address" class="form-control" required/>
		</div>
				        	
		<div class="p-1 form-group col-sm-6">
			<label for="firstname">First Name:</label><br>
				<input type="text" name="firstname" placeholder="Enter first name" class="form-control" required/>
		</div>
				        	
		<div class="p-1 form-group col-sm-6">
			<label for="lastname">Last Name:</label><br>
				<input type="text" name="lastname" placeholder="Enter last name" class="form-control" required/>
		</div>
				        	
		<div class="p-1 form-group col-sm-6">
			<label for="type">Role:</label><br>
				<select required name="type" class="form-control">
				  	<option selected value="fieldemployee">Field Employee</option>
				  	<option value="programmanager">Program Manager</option>
				  	<option value="funder">Funder</option>
				</select>
		</div>
				        	
		<div class="p-1 form-group col-sm-6">
			<label for="password">Password:</label><br>
				 <input type="password" name="password" placeholder="Enter password" class="form-control" required/>
		</div>
				        	
		<button type="submit" class="btn btn-primary">Sign Up</button>
	</form>
	<br>
	<a href="index.jsp" class="btn btn-primary" role="button">Cancel</a>
</div>
 

</body>
</html>	