package proj;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class Donate
{
    public int donation(String email, double amount)
    {
        try
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con= DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/projectjava","root","sql73my2019#");

            Statement statement=con.createStatement();

            String add_query="insert into donations VALUES('"+email+"','"+amount+"')";
            int i = statement.executeUpdate(add_query);
            if(i==0)
            {
                return 1;
            }
            else
            {
                return 2;
            }

        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return -1;
    }
}


