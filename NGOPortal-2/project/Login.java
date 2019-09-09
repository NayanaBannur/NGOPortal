
package proj;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Login
{
    public int login(String email, String password)
    {

        try
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con= DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/projectjava","root","sql73my2019#");

            Statement statement=con.createStatement();

            String sql = "select * from users where email='"+email+"'";

            ResultSet output = statement.executeQuery(sql);

            while(output.next())
            {
                System.out.println("Email, password: "+email+","+password);

                if(output.getString("email").equals(email))
                {
                    if(output.getString("password").equals(password))
                    {
                        return 1;
                    }
                    else
                    {
                        return 2;
                    }
                }
                else
                    return 3;
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return -1;
    }
}
