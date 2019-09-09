package proj;

import javafx.application.Application;
import javafx.geometry.*;
import javafx.scene.*;
import javafx.scene.control.*;
import javafx.scene.input.KeyCombination;
import javafx.scene.text.*;
import javafx.scene.text.TextAlignment;
import javafx.stage.Stage;
import javafx.scene.layout.*;
import javafx.scene.image.*;
import javafx.scene.control.Alert.AlertType;
import java.time.format.DateTimeFormatter;
import java.sql.*;
import java.util.ArrayList;
import javafx.scene.control.cell.*;
import javafx.beans.binding.*;

import javafx.collections.*;

public class NGOMain extends Application
{
    private Label response;
    private User user;

    private void registration(Stage myStage)
    {
        int count=0;

        myStage.setTitle("NGO Portal");

        GridPane root = new GridPane();

        root.setVgap(20);

        root.getStylesheets().add(getClass().getResource("/style.css").toExternalForm());

        Scene myScene = new Scene(root, 500, 500);

        myStage.setScene(myScene);
        myStage.setFullScreen(true);
        myStage.setFullScreenExitKeyCombination(KeyCombination.NO_MATCH);

        root.setAlignment(Pos.CENTER);

        Text title = new Text("Registration");
        title.setStyle("-fx-text-fill: black; -fx-font-size: 30 pt;");

        GridPane.setRowIndex(title, count++);
        GridPane.setColumnIndex(title, 0);
        GridPane.setHalignment(title, HPos.CENTER);

        Label fnameLabel = new Label("First Name");

        GridPane.setRowIndex(fnameLabel, count++);
        GridPane.setColumnIndex(fnameLabel, 0);

        TextField fnameField = new TextField();
        fnameField.setPrefHeight(40);

        GridPane.setRowIndex(fnameField, count++);
        GridPane.setColumnIndex(fnameField, 0);

        Label lnameLabel = new Label("Last Name");

        GridPane.setRowIndex(lnameLabel, count++);
        GridPane.setColumnIndex(lnameLabel, 0);

        TextField lnameField = new TextField();
        lnameField.setPrefHeight(40);

        GridPane.setRowIndex(lnameField, count++);
        GridPane.setColumnIndex(lnameField, 0);

        Label dobLabel = new Label("Date of Birth (DD/MM/YYYY)");

        GridPane.setRowIndex(dobLabel, count++);
        GridPane.setColumnIndex(dobLabel, 0);

        DatePicker datePicker = new DatePicker();

        GridPane.setRowIndex(datePicker, count++);
        GridPane.setColumnIndex(datePicker, 0);

        Label genderLabel = new Label("Gender");

        GridPane.setRowIndex(genderLabel, count++);
        GridPane.setColumnIndex(genderLabel, 0);

        ToggleGroup group = new ToggleGroup();
        RadioButton male = new RadioButton("Male");
        RadioButton female = new RadioButton("Female");
        male.setToggleGroup(group);
        female.setToggleGroup(group);

        GridPane.setRowIndex(male, count);
        GridPane.setColumnIndex(male, 0);
        GridPane.setRowIndex(female, count++);
        GridPane.setColumnIndex(female, 1);

        Label locationLabel = new Label("Location");

        GridPane.setRowIndex(locationLabel, count++);
        GridPane.setColumnIndex(locationLabel, 0);

        TextField locationField = new TextField();
        locationField.setPrefHeight(40);

        GridPane.setRowIndex(locationField, count++);
        GridPane.setColumnIndex(locationField, 0);

        Label emailLabel = new Label("Email ID");

        GridPane.setRowIndex(emailLabel, count++);
        GridPane.setColumnIndex(emailLabel, 0);

        TextField emailField = new TextField();
        emailField.setPrefHeight(40);

        GridPane.setRowIndex(emailField, count++);
        GridPane.setColumnIndex(emailField, 0);

        Label passwordLabel = new Label("Password");

        GridPane.setRowIndex(passwordLabel, count++);
        GridPane.setColumnIndex(passwordLabel, 0);

        PasswordField passwordField = new PasswordField();
        passwordField.setPrefHeight(40);

        GridPane.setRowIndex(passwordField, count++);
        GridPane.setColumnIndex(passwordField, 0);

        Button register = new Button("Register");
        register.setPrefWidth(200);
        register.getStyleClass().add("allbuttons");

        GridPane.setRowIndex(register, count++);
        GridPane.setColumnIndex(register, 0);
        GridPane.setHalignment(register, HPos.CENTER);

        Button back = new Button("Go Back");
        back.getStyleClass().add("allbuttons");
        back.setPrefWidth(200);

        GridPane.setRowIndex(back, count++);
        GridPane.setColumnIndex(back, 0);
        GridPane.setHalignment(back, HPos.CENTER);

        back.setOnAction((ae)->
        {
            login(myStage);
        });

        Alert alert = new Alert(AlertType.ERROR);

        register.setOnAction((ae)->
        {
            int cannot_register = 0;

            String email = emailField.getText();
            String password = passwordField.getText();
            String fname = fnameField.getText();
            String lname = lnameField.getText();
            String location = locationField.getText();
            String dob=null;
            String gender = null;
            if(datePicker.getValue()!=null)
            {
                dob = datePicker.getValue().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            }
            if(male.isSelected()||female.isSelected())
            {
                gender = ((RadioButton)group.getSelectedToggle()).getText();
            }

            if(email==null||password==null||fname==null||lname==null||dob==null||gender==null||email.isEmpty())
            {
                cannot_register = 1;
                alert.setAlertType(AlertType.ERROR);
                alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
                alert.setContentText("All fields are required.");
                alert.show();
            }
            if(cannot_register==0)
            {
                Registration ob = new Registration();
                int ret = ob.registration(email,password,fname,lname,dob,gender,location);

                if(ret==1)
                {
                    alert.setAlertType(AlertType.ERROR);
                    alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
                    alert.setContentText("This email has already been registered.");
                    alert.show();
                }
                else if(ret==2)
                {
                    alert.setAlertType(AlertType.ERROR);
                    alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
                    alert.setContentText("Registration failed.");
                    alert.show();
                }
                else if(ret==3)
                {
                    login(myStage);
                }
                else
                {
                    alert.setAlertType(AlertType.ERROR);
                    alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
                    alert.setContentText("An unknown error occurred.");
                    alert.show();
                }
            }
        });

        root.getChildren().addAll(title, register, back, emailLabel, emailField, passwordField, passwordLabel, fnameLabel, fnameField, lnameLabel, lnameField);
        root.getChildren().addAll(dobLabel, datePicker, locationLabel, locationField, male, female, genderLabel);

        myStage.show();
    }

    private void login(Stage myStage)
    {
        int count=0;

        myStage.setTitle("NGO Portal");

        GridPane root = new GridPane();

        root.setVgap(30);
        root.setHgap(10);

        root.getStylesheets().add(getClass().getResource("/style.css").toExternalForm());

        Scene myScene = new Scene(root, 500, 500);

        myStage.setScene(myScene);

        myStage.setFullScreen(true);
        myStage.setFullScreenExitKeyCombination(KeyCombination.NO_MATCH);

        root.setAlignment(Pos.CENTER);

        Text title = new Text("Login");
        title.setStyle("-fx-text-fill: black; -fx-font-size: 30 pt;");

        GridPane.setRowIndex(title, count++);
        GridPane.setColumnIndex(title, 0);
        GridPane.setHalignment(title, HPos.CENTER);

        Image indexim = new Image("indeximage.jpg");

        ImageView indeximview = new ImageView(indexim);

        indeximview.setFitHeight(300);
        indeximview.setFitWidth(300);
        indeximview.setPreserveRatio(true);

        GridPane.setRowIndex(indeximview, count++);
        GridPane.setColumnIndex(indeximview, 0);
        GridPane.setHalignment(indeximview, HPos.CENTER);

        Label emailLabel = new Label("Email ID");

        GridPane.setRowIndex(emailLabel, count++);
        GridPane.setColumnIndex(emailLabel, 0);

        TextField emailField = new TextField();
        emailField.setPrefHeight(40);

        GridPane.setRowIndex(emailField, count++);
        GridPane.setColumnIndex(emailField, 0);

        Label passwordLabel = new Label("Password");

        GridPane.setRowIndex(passwordLabel, count++);
        GridPane.setColumnIndex(passwordLabel, 0);

        PasswordField passwordField = new PasswordField();
        passwordField.setPrefHeight(40);

        GridPane.setRowIndex(passwordField, count++);
        GridPane.setColumnIndex(passwordField, 0);

        Button login = new Button("Login");

        GridPane.setRowIndex(login, count++);
        GridPane.setColumnIndex(login, 0);
        GridPane.setHalignment(login, HPos.CENTER);

        login.getStyleClass().add("allbuttons");
        login.setPrefWidth(300);

        Text regtext = new Text("Don't have an account? Sign up. ");

        GridPane.setRowIndex(regtext, count++);
        GridPane.setColumnIndex(regtext, 0);
        GridPane.setHalignment(regtext, HPos.CENTER);

        Button register = new Button("Register");
        register.setPrefWidth(300);

        GridPane.setRowIndex(register, count++);
        GridPane.setColumnIndex(register, 0);
        GridPane.setHalignment(register, HPos.CENTER);

        register.getStyleClass().add("allbuttons");

        Button back = new Button("Go Back");
        back.setPrefWidth(300);

        GridPane.setRowIndex(back, count++);
        GridPane.setColumnIndex(back, 0);
        GridPane.setHalignment(back, HPos.CENTER);

        back.getStyleClass().add("allbuttons");

        Alert alert = new Alert(AlertType.ERROR);

        login.setOnAction((ae) ->
        {
            String email = emailField.getText();
            String password = passwordField.getText();

            if(email==null||email.isEmpty()||password==null||password.isEmpty())
            {
                alert.setAlertType(AlertType.ERROR);
                alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
                alert.setContentText("All fields are required.");
                alert.show();
            }
            else
            {
                Login ob = new Login();
                int ret = ob.login(email,password);

                if(ret==1)
                {
                    user.setEmail(email);
                    user.setName(email);
                    home(myStage,user);
                }
                else if(ret==2)
                {
                    alert.setAlertType(AlertType.ERROR);
                    alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
                    alert.setContentText("Password Incorrect.");
                    alert.show();
                }
                else if(ret==3)
                {
                    alert.setAlertType(AlertType.ERROR);
                    alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
                    alert.setContentText("Email Incorrect.");
                    alert.show();
                }
                else
                {
                    alert.setAlertType(AlertType.ERROR);
                    alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
                    alert.setContentText("Email not registered.");
                    alert.show();
                }
            }
        });

        register.setOnAction((ae)->
        {
            registration(myStage);
        });

        back.setOnAction((ae)->
        {

            home(myStage,user);
        });

        root.getChildren().addAll(title, indeximview,emailLabel, emailField, passwordField, passwordLabel,login,register,back, regtext);

        myStage.show();
    }

    private void home(Stage myStage, User user)
    {
        DisplayText ob = new DisplayText();

        myStage.setTitle("NGO PORTAL");
        BorderPane root = new BorderPane();

        root.getStylesheets().add(getClass().getResource("/style.css").toExternalForm());

        Scene myScene = new Scene(root,800,700);

        ScrollPane pane = new ScrollPane();

        pane.setFitToWidth(true);

        response = new Label();

        response.setText(ob.getHome());

        response.setWrapText(true);
        response.setTextAlignment(TextAlignment.JUSTIFY);
        response.setFont(Font.font(16));

        response.setPadding(new Insets(20));
        response.setStyle("-fx-line-spacing: 1em;");

        GridPane.setRowIndex(response, 0);
        GridPane.setColumnIndex(response, 0);

        myStage.setScene(myScene);

        myStage.setFullScreen(true);
        myStage.setFullScreenExitKeyCombination(KeyCombination.NO_MATCH);

        String buttonval;
        if(user.getEmail().equals(""))
            buttonval = "Login";
        else
            buttonval = "Logout";

        MenuBar mb = new MenuBar();
        mb.getStylesheets().add(getClass().getResource("/style.css").toExternalForm());

        Menu programsMenu = new Menu("Programs");
        MenuItem p1 = new MenuItem("Early years programme");
        MenuItem p2 = new MenuItem("Vocational training");
        MenuItem p3 = new MenuItem("Hybrid teaching");
        MenuItem p4 = new MenuItem("Digital classrooms");
        SeparatorMenuItem sep = new SeparatorMenuItem();
        MenuItem plist = new MenuItem("Programs");

        programsMenu.getItems().addAll(p1,p2,p3,p4,sep,plist);

        mb.getMenus().add(programsMenu);

        Menu involvedMenu = new Menu("Get involved");

        MenuItem job = new MenuItem("Job");
        MenuItem internship = new MenuItem("Internship");

        involvedMenu.getItems().addAll(job, internship);
        mb.getMenus().add(involvedMenu);

        Menu supportMenu = new Menu("Support us");
        MenuItem donate = new MenuItem("Donate");

        supportMenu.getItems().addAll(donate);
        mb.getMenus().add(supportMenu);

        Menu reachMenu = new Menu("Reach Us");
        MenuItem contact = new MenuItem("Contact");
        reachMenu.getItems().addAll(contact);

        mb.getMenus().add(reachMenu);

        Menu aboutMenu = new Menu("About us");

        MenuItem vision = new MenuItem("Vision and Mission");

        aboutMenu.getItems().addAll(vision);
        mb.getMenus().add(aboutMenu);

        p1.setOnAction((ae)->
        {
            myStage.setTitle("Early years programmes");
            response.setText(ob.getEarlyYearsProgrammes());
        });

        p2.setOnAction((ae)->
        {
            myStage.setTitle("Vocational Training");
            response.setText(ob.getVocationalTraining());
        });

        p3.setOnAction((ae)->
        {
            myStage.setTitle("Hybrid Teaching");
            response.setText(ob.getHybridTeaching());
        });

        p4.setOnAction((ae)->
        {
            myStage.setTitle("Digital Classrooms");
            response.setText(ob.getDigitalClassrooms());
        });

        plist.setOnAction((ae)->
        {
            programs(myStage,user);
        });

        job.setOnAction((ae)->
        {
            myStage.setTitle("Jobs");
            response.setText(ob.getJobs());

        });

        internship.setOnAction((ae)->
        {
            myStage.setTitle("Internships");
            response.setText(ob.getInternship());
        });

        donate.setOnAction((ae)->
        {
            makedonation(myStage,user);
        });

        vision.setOnAction((ae)->
        {
            myStage.setTitle("About us");
            response.setText(ob.getVision());
        });

        contact.setOnAction((ae)->
        {
            myStage.setTitle("Contact");
            response.setText(ob.getContact());
        });

        Button loginButton = new Button(buttonval);

        loginButton.getStyleClass().add("loginbutton");

        Region spacer = new Region();
        Button username = new Button("Logged in as "+user.getName());
        username.setDisable(true);
        Separator separator = new Separator();
        separator.setOrientation(Orientation.VERTICAL);
        spacer.getStyleClass().add("menu-bar");
        HBox.setHgrow(spacer, Priority.SOMETIMES);
        HBox menubar = new HBox(mb, spacer, separator, loginButton);
        if(user.getEmail().equals(""))
        {
            username.setText("");
        }
        if(!user.getEmail().equals(""))
        {
            menubar.getChildren().add(2,username);
        }

        loginButton.setOnAction((ae)->
        {
            if(user.getEmail().equals(""))
            {
                login(myStage);
            }
            else
            {
                user.setName("");
                user.setEmail("");
                home(myStage,user);

            }
        });

        username.setStyle("-fx-background-color: aliceblue;");
        menubar.setStyle("-fx-background-color: aliceblue;");
        spacer.setStyle("-fx-background-color: aliceblue;");

        root.setTop(menubar);

        pane.setContent(response);
        root.setCenter(pane);
        myStage.show();
    }

    private void makedonation(Stage myStage, User user)
    {
        Alert alert1 = new Alert(AlertType.ERROR);

        if(user.getEmail().equals(""))
        {
            alert1.setAlertType(AlertType.ERROR);
            alert1.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
            alert1.setContentText("Login to donate.");
            alert1.show();
        }
        else
        {
            int count = 0;

            myStage.setTitle("Donations");

            GridPane root = new GridPane();

            root.setVgap(30);

            root.setAlignment(Pos.TOP_CENTER);

            root.getStylesheets().add(getClass().getResource("/style.css").toExternalForm());

            Scene myScene = new Scene(root,500,500);

            myStage.setScene(myScene);

            myStage.setFullScreen(true);
            myStage.setFullScreenExitKeyCombination(KeyCombination.NO_MATCH);

            Text title = new Text("Donate");
            title.setStyle("-fx-font-size: 30 pt;-fx-text-fill: black;");

            GridPane.setRowIndex(title, count++);
            GridPane.setColumnIndex(title, 0);
            GridPane.setHalignment(title, HPos.CENTER);

            TextField amountField = new TextField();
            amountField.setPrefHeight(40);

            GridPane.setRowIndex(amountField, count++);
            GridPane.setColumnIndex(amountField, 0);
            GridPane.setHalignment(amountField, HPos.CENTER);

            Button donateButton = new Button("Submit");
            donateButton.setPrefHeight(40);
            donateButton.setDefaultButton(true);
            donateButton.setPrefWidth(200);

            donateButton.getStyleClass().add("allbuttons");

            GridPane.setRowIndex(donateButton, count++);
            GridPane.setColumnIndex(donateButton, 0);
            GridPane.setHalignment(donateButton, HPos.CENTER);

            Button back = new Button("Go Back");
            back.getStyleClass().add("allbuttons");
            back.setPrefWidth(200);

            back.setOnAction((ae)->
            {
                home(myStage, user);
            });

            GridPane.setRowIndex(back, count);
            GridPane.setColumnIndex(back, 0);
            GridPane.setHalignment(back, HPos.CENTER);

            Alert alert = new Alert(AlertType.ERROR);


            donateButton.setOnAction((ae1)->
            {

                if(amountField.getText()==null||amountField.getText()==""||amountField.getText().isEmpty())
                {
                    alert.setAlertType(AlertType.ERROR);
                    alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
                    alert.setContentText("Enter the amount.");
                    alert.show();
                }
                else
                {
                    double amount = Double.parseDouble(amountField.getText());

                    Donate ob = new Donate();
                    int ret = ob.donation(user.getEmail(), amount);

                    if(ret==1)
                    {
                        alert.setAlertType(AlertType.ERROR);
                        alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
                        alert.setContentText("Donation failed.");
                        alert.show();
                    }
                    else if(ret==2)
                    {
                        home(myStage,user);
                    }
                    else
                    {
                        alert.setAlertType(AlertType.ERROR);
                        alert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
                        alert.setContentText("An unknown error occurred.");
                        alert.show();
                    }
                }
            });
            root.getChildren().addAll(amountField,title,donateButton,back);
            myStage.show();
        }
    }

    private void programs(Stage myStage, User user)
    {
        myStage.setTitle("Programs");

        FlowPane root = new FlowPane();

        root.getStylesheets().add(getClass().getResource("/style.css").toExternalForm());

        root.setVgap(10);
        root.setHgap(10);

        Scene myScene = new Scene(root,500,500);

        myStage.setScene(myScene);

        myStage.setFullScreen(true);
        myStage.setFullScreenExitKeyCombination(KeyCombination.NO_MATCH);

        root.setAlignment(Pos.TOP_CENTER);

        TableView table = new TableView();

        table.prefWidthProperty().bind(myStage.widthProperty());

        table.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY);

        Text title = new Text("Programs");
        title.setStyle("-fx-font-size: 30 pt;-fx-text-fill: black;");

        table.setEditable(false);

        TableColumn eventCol = new TableColumn("Event");
        TableColumn descriptionCol = new TableColumn("Description");

        eventCol.setMaxWidth( 1f * Integer.MAX_VALUE * 30 ); // 50% width
        descriptionCol.setMaxWidth( 1f * Integer.MAX_VALUE * 70 );

        ResultSet res;

        ArrayList<String> progname = new ArrayList<>();
        ArrayList<String> progdesc = new ArrayList<>();

        try
        {

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con= DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/projectjava","root","sql73my2019#");

            Statement statement=con.createStatement();

            String getProgsQuery = "select * from programs";

            res = statement.executeQuery(getProgsQuery);

            while(res.next())
            {
                progname.add(res.getString(1));
                progdesc.add(res.getString(2));
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        ObservableList<Program> data = FXCollections.observableArrayList();

        for(int i = 0; i<progname.size(); i++)
        {
            data.add(new Program(progname.get(i),progdesc.get(i)));
        }

        eventCol.setCellValueFactory(
                new PropertyValueFactory<Program,String>("pname")
        );
        descriptionCol.setCellValueFactory(
                new PropertyValueFactory<Program,String>("description")
        );

        table.setItems(data);
        table.getColumns().addAll(eventCol, descriptionCol);

        table.setFixedCellSize(40);
        table.prefHeightProperty().bind(Bindings.size(table.getItems()).multiply(table.getFixedCellSize()).add(30));

        Button back = new Button("Go Back");
        back.getStyleClass().add("allbuttons");

        back.setOnAction((ae)->
        {
            home(myStage, user);
        });
        /*
        Button report = new Button("Generate Report");
        report.getStyleClass().add("allbuttons");

        report.setOnAction((ae)->
        {

        });
        */
        VBox vbox = new VBox();
        vbox.setSpacing(30);
        vbox.setPadding(new Insets(10, 0, 0, 10));
        vbox.getChildren().addAll(title, table, back, report);
        vbox.setAlignment(Pos.CENTER);

        root.getChildren().addAll(vbox);
    }

    @Override
    public void start(Stage myStage)
    {
        user = new User();
        home(myStage,user);
    }

    public static void main(String[] args)
    {
        launch(args);
    }
}