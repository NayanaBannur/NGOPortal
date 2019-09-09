<html>
    <head>
        <title>NGO Portal</title>
    </head>
 
    <body>
        <%
        String email=(String)session.getAttribute("email");
        String type=(String)session.getAttribute("type");
        //redirect user to login page if not logged in
        if(email==null){
        	response.sendRedirect("index.jsp");
        }
        %>
    
        <p>Welcome <%=email%></p> 
        <p>Session ID is  :  <%=request.getSession().getId()%></p> 
        <p>User type is  :  <%=type%></p> 
        <a href="logout.jsp">Logout</a>
    </body>
</html>