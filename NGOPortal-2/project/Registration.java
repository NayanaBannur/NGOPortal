
package proj;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Registration
{
    public int registration(String email, String password, String fname, String lname, String dob, String gender, String location)
    {
        try
        {

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con= DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/projectjava","root","sql73my2019#");

            Statement statement=con.createStatement();

            String sql = "select * from users";

            ResultSet output = statement.executeQuery(sql);

            while(output.next())
            {
                if(output.getString("email").equals(email))
                {
                    return 1;
                }
            }

            String add_query="insert into users VALUES('"+fname+"','"+lname+"','"+dob+"','"+gender+"','"+email+"','"+location+"','"+password+"')";
            int i = statement.executeUpdate(add_query);
            if(i==0)
            {
                return 2;
            }
            else
            {
                return 3;
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return -1;
    }
}


