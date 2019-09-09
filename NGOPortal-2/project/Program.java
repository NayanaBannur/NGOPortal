
package proj;

import javafx.beans.property.*;


public class Program
{
    private SimpleStringProperty pname;
    private SimpleStringProperty description;

    Program(String pname, String description)
    {
        this.pname = new SimpleStringProperty(pname);
        this.description = new SimpleStringProperty(description);
    }

    public String getDescription()
    {
        return description.get();
    }

    public String getPname()
    {
        return pname.get();
    }
}


