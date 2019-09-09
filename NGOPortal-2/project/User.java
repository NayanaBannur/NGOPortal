package proj;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class User
{
    private String email;
    private String name;

    public User()
    {
        this.email = "";
        this.name = "";
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    public String getEmail()
    {
        return email;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String email)
    {
        try
        {

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/projectjava", "root", "sql73my2019#");

            Statement statement = con.createStatement();

            String sql = "select * from users";

            ResultSet output = statement.executeQuery(sql);

            while (output.next()) {
                if (output.getString("email").equals(email)) {
                    this.name = output.getString("firstname");
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
