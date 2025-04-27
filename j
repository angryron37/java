Practical 1 - JDBC Connectivity
 
filename: main.java
 
import java.sql.*;
import java.util.Scanner;
public class Main {
    public static void main(String[] args) throws ClassNotFoundException {
        Scanner in = new Scanner(System.in);
        System.out.println("Enter Username");
        String un = in.next();
        System.out.println("Enter Password");
        String pw = in.next();
        try {
//DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_name", "root", "");
            String query = "SELECT * FROM login WHERE user_name = ? AND pass = ?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, un);
            stmt.setString(2, pw);
            ResultSet rs = stmt.executeQuery();
            rs.next();
            if (rs.getRow()>0) {
                System.out.println("Login Successful ! "+rs.getString("user_name"));
            }
            else
            {
                System.out.println("Login Fail");
            }
            rs.close();
            stmt.close();
            con.close();
        }
        catch (SQLException e) {
            System.out.println(e);
        }
    }
}
 
 
 
 
 
Practical 2- JDBC Connectivity & Crud Operations
 
filename: main.java
 
import java.sql.*;
import java.util.Scanner;
public class Main {
    // Database connection setup
    private static final String URL = "jdbc:mysql://localhost:3306/StudentDB";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    public static void main(String[] args) {
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
            Scanner scanner = new Scanner(System.in);
            int choice;
            do {
                System.out.println("\n--- Student Information System ---");
                System.out.println("1. Insert Student");
                System.out.println("2. Update Student");
                System.out.println("3. Delete Student");
                System.out.println("4. Display All Students");
                System.out.println("5. Exit");
                System.out.print("Enter your choice: ");
                choice = scanner.nextInt();
                switch (choice) {
                    case 1:
                        insertStudent(connection, scanner);
                        break;
                    case 2:
                        updateStudent(connection, scanner);
                        break;
                    case 3:
                        deleteStudent(connection, scanner);
                        break;
                    case 4:
                        displayStudents(connection);
                        break;
                    case 5:
                        System.out.println("Exiting...");
                        break;
                    default:
                        System.out.println("Invalid choice! Please try again.");
                }
            } while (choice != 5);
            scanner.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    private static void insertStudent(Connection connection, Scanner scanner) {
        try {
            System.out.print("Enter Student ID: ");
            int id = scanner.nextInt();
            scanner.nextLine();
            System.out.print("Enter Name: ");
            String name = scanner.nextLine();
            System.out.print("Enter Age: ");
            int age = scanner.nextInt();
            scanner.nextLine();
            System.out.print("Enter Course: ");
            String course = scanner.nextLine();
            String sql = "INSERT INTO student (student_id, name, age, course) VALUES (?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, id);
                statement.setString(2, name);
                statement.setInt(3, age);
                statement.setString(4, course);
                int rows = statement.executeUpdate();
                if (rows > 0) {
                    System.out.println("Student inserted successfully!");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error inserting student: " + e.getMessage());
        }
    }
    private static void updateStudent(Connection connection, Scanner scanner) {
        try {
            System.out.print("Enter Student ID to Update: ");
            int id = scanner.nextInt();
            scanner.nextLine(); // Consume newline
            System.out.print("Enter New Name: ");
            String name = scanner.nextLine();
            System.out.print("Enter New Age: ");
            int age = scanner.nextInt();
            scanner.nextLine(); // Consume newline
            System.out.print("Enter New Course: ");
            String course = scanner.nextLine();
            String sql = "UPDATE student SET name = ?, age = ?, course = ? WHERE student_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, name);
                statement.setInt(2, age);
                statement.setString(3, course);
                statement.setInt(4, id);
                int rows = statement.executeUpdate();
                if (rows > 0) {
                    System.out.println("Student updated successfully!");
                } else {
                    System.out.println("Student ID not found.");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error updating student: " + e.getMessage());
        }
    }
    private static void deleteStudent(Connection connection, Scanner scanner) {
        try {
            System.out.print("Enter Student ID to Delete: ");
            int id = scanner.nextInt();
            String sql = "DELETE FROM student WHERE student_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, id);
                int rows = statement.executeUpdate();
                if (rows > 0) {
                    System.out.println("Student deleted successfully!");
                } else {
                    System.out.println("Student ID not found.");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error deleting student: " + e.getMessage());
        }
    }
    private static void displayStudents(Connection connection) {
        try {
            String sql = "SELECT * FROM student";
            try (Statement statement = connection.createStatement();
                 ResultSet resultSet = statement.executeQuery(sql)) {
                System.out.println("\n--- Student Records ---");
                while (resultSet.next()) {
                    int id = resultSet.getInt("student_id");
                    String name = resultSet.getString("name");
                    int age = resultSet.getInt("age");
                    String course = resultSet.getString("course");
                    System.out.println("ID: " + id + ", Name: " + name + ", Age: " + age + ", Course: " + course);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error displaying students: " + e.getMessage());
        }
    }
}
 
 
 
 
 
Practical 3- Data Driven GUI Application
 
filename: registration.html
 
<!DOCTYPE html>
<html>
  <head>
    <title>User Registration</title>
  </head>
  <body>
    <h1>Registration Form</h1>
    <form action="RegisterUser" method="post">
      <label for="name">Name:</label>
      <input type="text" name="name" required /><br /><br />
      <label for="birthdate">DOB:</label>
      <input type="date" name="birthdate" required /><br /><br />
      <label for="email">Email ID:</label>
      <input type="email" name="email" required /><br /><br />
      <label for="phone_no">Phone Number:</label>
      <input type="text" name="phone_no" required /><br /><br />
      <button type="submit">Submit</button>
    </form>
  </body>
</html>
 
filename: RegisterUser.java
 
 
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.http.HttpServlet;
 
@WebServlet("/RegisterUser")
public class RegisterUser extends HttpServlet {
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String birthdate = request.getParameter("birthdate");
        String email = request.getParameter("email");
        String phone_no = request.getParameter("phone_no");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/servlets", "root", "");
            String sql = "INSERT INTO users (name, birthdate, email, phone_no) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, birthdate);
            statement.setString(3, email);
            statement.setString(4, phone_no);
            
            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("A new user was inserted successfully.");
            } else {
                System.out.println("No rows inserted.");
            }
 
            // Use contextPath to handle correct redirection
            response.sendRedirect(request.getContextPath() + "/DisplayUsers");
 
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
        }
    }
}
 
filename: DisplayUsers.java
 
 
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
 
@WebServlet("/DisplayUsers")
public class DisplayUsers extends HttpServlet {
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/servlets", "root", "");
            String sql = "SELECT * FROM users";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            out.println("<h1>Registered Users</h1>");
            out.println("<table border='1'>");
            out.println("<tr><th>ID</th><th>Name</th><th>Birthdate</th><th>Email</th><th>Phone Number</th></tr>");
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                Date birthdate = resultSet.getDate("birthdate");
                String email = resultSet.getString("email");
                String phone_no = resultSet.getString("phone_no");
                out.println("<tr>");
                out.println("<td>" + id + "</td>");
                out.println("<td>" + name + "</td>");
                out.println("<td>" + birthdate + "</td>");
                out.println("<td>" + email + "</td>");
                out.println("<td>" + phone_no + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
 
 
 
 
 
Practical 4- A Data Driven Servlet Application
 
filename: index.html
 
<!DOCTYPE html>
<html>
<body>
<h2>Login Form</h2>
<form action="AuthenticateServlet" method="post">
<label for="username">Username:</label>
<input type="text" id="username" name="username" required><br>
<label for="password">Password:</label>
<input type="password" id="password" name="password" required><br>
<button type="submit">Login</button>
</form>
</body>
</html>
 
filename: AuthenticateServlet.java
 
import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
 
@WebServlet("/AuthenticateServlet")
public class AuthenticateServlet extends HttpServlet {
 
    private static final long serialVersionUID = 1L;
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean isAuthenticated = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/servlets", "root", "");
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            isAuthenticated = rs.next();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (isAuthenticated) {
            out.println("<h1>Welcome, " + username + "!</h1>");
        } else {
            out.println("<h1>Invalid username or password!</h1>");
        }
        out.println("<h2>Request Headers:</h2>");
        request.getHeaderNames().asIterator().forEachRemaining(headerName -> {
            out.println(headerName + ": " + request.getHeader(headerName) + "<br>");
        });
        response.addHeader("Custom-Header", "This is Karan and i am your header");
        out.println("<h2>Response Headers:</h2>");
        response.getHeaderNames().forEach(headerName -> {
            out.println(headerName + ": " + response.getHeader(headerName) + "<br>");
        });
        out.close();
    }
}
 
 
 
 
 
Practical 5- Servlet - Session Management
 
filename: index.html
 
<!DOCTYPE html>
<html>
  <head>
    <title>Lab-5</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  </head>
  <body>
    <form action="examInfo">
      <div>
        <input type="text" name="name" placeholder="Enter Name" /><br />
        <input type="text" name="id" placeholder="Enter Id" /><br />
        <input
          type="text"
          name="department"
          placeholder="Enter Department"
        /><br />
 
        <input type="Submit" value="Next" name="btn_next" />
      </div>
    </form>
  </body>
</html>
 
filename: examInfo.java
 
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
 
@WebServlet(urlPatterns = { "/examInfo" })
public class examInfo extends HttpServlet {
 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String nm, id, department;
        try (PrintWriter out = response.getWriter()) {
 
            nm = request.getParameter("name");
            id = request.getParameter("id");
            department = request.getParameter("department");
            Cookie c1, c2, c3;
            c1 = new Cookie("nm", nm);
 
            c2 = new Cookie("id", id);
            c3 = new Cookie("dept", department);
 
            response.addCookie(c1);
            response.addCookie(c2);
            response.addCookie(c3);
 
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>ExamInfo</title>");
            out.println("</head>");
            out.println("<body><form action=\"examResult\">");
            out.println("<h1>Student : " + nm + "</h1><br><hr>");
            out.println("<center><b>Enter ,marks for six subjects [out of 100]</b></center><br>");
            out.println("Enter marks for subject1 <input type=\"text\" name=\"subj1\"><br><br>");
            out.println("Enter marks for subject2 <input type=\"text\" name=\"subj2\"><br><br>");
            out.println("Enter marks for subject3 <input type=\"text\" name=\"subj3\" ><br><br>");
            out.println("Enter marks for subject4 <input type=\"text\" name=\"subj4\" ><br><br>");
            out.println("Enter marks for subject5 <input type=\"text\" name=\"subj5\" ><br><br>");
            out.println("Enter marks for subject6 <input type=\"text\" name=\"subj6\" ><br><br>");
            out.println("<input type=\"Submit\" value=\"Generate Result\">");
            out.println("</form></body>");
            out.println("</html>");
        }
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        processRequest(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
 
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
 
}
 
filename: examResult.java
 
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
@WebServlet(urlPatterns = { "/examResult" })
public class examResult extends HttpServlet {
 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            int m1, m2, m3, m4, m5, m6;
            float avg;
            m1 = Integer.parseInt(request.getParameter("subj1"));
            m2 = Integer.parseInt(request.getParameter("subj2"));
            m3 = Integer.parseInt(request.getParameter("subj3"));
            m4 = Integer.parseInt(request.getParameter("subj4"));
            m5 = Integer.parseInt(request.getParameter("subj5"));
            m6 = Integer.parseInt(request.getParameter("subj6"));
            avg = (float) (m1 + m2 + m3 + m4 + m5 + m6) / 6;
 
            char grade;
            if (avg >= 90) {
                grade = 'A';
            } else if (avg >= 70) {
                grade = 'B';
            } else if (avg >= 60) {
                grade = 'C';
            } else {
 
                grade = 'F';
            }
 
            Cookie[] c = request.getCookies();
 
            out.println("<br>Name :" + c[0].getValue());
            out.println("<br>Id :" + c[1].getValue());
            out.println("<br>Department :" + c[2].getValue());
 
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>ExamResult</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Exam Result :" + grade + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
 
    }
 
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
 
 
 
 
 
Practical 6- Servlet - Request Redirection
 
filename: RedirectServlet.java
 
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import javax.servlet.annotation.WebServlet;
 
@WebServlet(urlPatterns = { "/RedirectServlet" })
public class RedirectServlet extends HttpServlet {
 
    // Handle both GET and POST requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Same logic as POST method for handling GET requests
        handleRedirect(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle the POST method (which will be used when form is submitted)
        handleRedirect(request, response);
    }
 
    // Common logic to handle redirect for both GET and POST requests
    private void handleRedirect(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the URL entered by the user
        String location = request.getParameter("location");
        response.sendRedirect("https://www.google.com/search?q=" + location);
    }
}
 
filename: redirectForm.jsp
 
<!DOCTYPE html>
<html>
  <head>
    <title>Request Redirection</title>
  </head>
  <body>
    <h2>Enter the URL to redirect to:</h2>
    <!-- Use POST method for submitting form data -->
    <form action="RedirectServlet" method="POST">
      <label for="location">URL: </label>
      <input
        type="text"
        id="location"
        name="location"
        placeholder="Enter the URL"
        required
      />
      <input type="submit" value="Go" />
    </form>
  </body>
</html>
 
 
 
 
 
Practical 7- JSP - User Authentication
 
filename: index.html
 
<!DOCTYPE html>
<html>
<head>
<title>TODO supply a title</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
 
<form action="NewServlet">
Username<input type="text" name="uname">
Password<input type="password" name="pwd">
<input type="submit" value="login">
</form>
</body>
</html>
 
filename: NewServlet.java
 
 
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.HttpSession;
 
@WebServlet(urlPatterns = {"/NewServlet"})
public class NewServlet extends HttpServlet {
 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String u, p;
        u = request.getParameter("uname").trim();
        p = request.getParameter("pwd").trim();
        Connection c;
        try {
// PrintWriter out = response.getWriter();
/* TODO output your page here. You may use following sample code. */
            Class.forName("com.mysql.cj.jdbc.Driver");
            c = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/userdb",
                    "root", "");
 
            Statement s = c.createStatement();
            ResultSet rs = s.executeQuery(
                    "select * from users where username='" + u + "' AND password='" + p + "'");
            HttpSession session = request.getSession();
            System.out.println("Record fetched");
            if (rs.next()) {
                session.setAttribute("un", u);
                response.sendRedirect("home.jsp");
            } else {
//session.setAttribute("flag", "Wrong Credentials");
                response.sendRedirect("index.html");
            }
 
        } catch (Exception e) {
            System.out.println(e);
        }
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
 
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
 
}
 
filename: home.jsp
 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Page</title>
</head>
<body>
<%
String un = (String)session.getAttribute("un");
 
%>
<h2>Welcome <%= un %></h2>
</body>
</html>
 
 
 
 
 
Practical 8- JSP - Java Beans
 
filename: index.jsp
 
<%@ page language="java" import="beans.BankAccount" %>
<jsp:useBean id="account" class="beans.BankAccount" scope="session" />
<jsp:setProperty name="account" property="accountHolder" param="name" />
<html>
  <head>
    <title>Bank Account</title>
  </head>
  <body>
    <h2>
      Welcome, <jsp:getProperty name="account" property="accountHolder" />
    </h2>
    <p>
      Current Balance: <jsp:getProperty name="account" property="balance" />
    </p>
    <form action="process.jsp" method="post">
      <label>Deposit Amount:</label>
      <input type="text" name="depositAmount" />
      <input type="submit" name="action" value="Deposit" />
    </form>
    <form action="process.jsp" method="post">
      <label>Withdraw Amount:</label>
      <input type="text" name="withdrawAmount" />
      <input type="submit" name="action" value="Withdraw" />
    </form>
  </body>
</html>
 
filename: process.jsp
 
 
<%@ page language="java" import="beans.BankAccount" %>
<jsp:useBean id="account" class="beans.BankAccount" scope="session" />
 
<%
    String action = request.getParameter("action");
 
    if ("Deposit".equals(action)) {
        double depositAmount = Double.parseDouble(request.getParameter("depositAmount"));
        account.deposit(depositAmount);
        out.println("<script>alert('Deposit Successful!');</script>");
    }
    
    else if ("Withdraw".equals(action)) {
        double withdrawAmount = Double.parseDouble(request.getParameter("withdrawAmount"));
        if (!account.withdraw(withdrawAmount)) {
            out.println("<script>alert('Insufficient Balance!');</script>");
        } else {
            out.println("<script>alert('Withdrawal Successful!');</script>");
        }
    }
 
    response.sendRedirect("index.jsp");
%>
 
filename: BankAccount.java
 
package beans;
 
import java.io.Serializable;
 
public class BankAccount implements Serializable {
    private String accountHolder;
    private double balance;
 
    public BankAccount() {
        this.accountHolder = "Karan";
        this.balance = 0.0;
    }
 
    public String getAccountHolder() {
        return accountHolder;
    }
 
    public void setAccountHolder(String accountHolder) {
        this.accountHolder = accountHolder;
    }
 
    public double getBalance() {
        return balance;
    }
 
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
 
    public boolean withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            return true;
        }
        return false;
    }
}
 
 
 
 
Practical 9- JSP - Custom Tags
 
filename: index.jsp
 
<%@ taglib prefix="c" uri="/WEB-INF/tlds/sortNumbers.tld" %>
<html>
  <head>
    <title>Sort Numbers Custom Tag</title>
  </head>
  <body>
    <h2>Enter 10 Numbers (comma-separated)</h2>
    <form method="post">
      <input type="text" name="numbers" required />
      <select name="order">
        <option value="asc">Ascending</option>
        <option value="desc">Descending</option>
      </select>
      <input type="submit" value="Sort" />
    </form>
    <% String numbers = request.getParameter("numbers"); String order =
    request.getParameter("order"); if (numbers != null && !numbers.isEmpty()) {
    %>
    <h3>Sorted Numbers:</h3>
    <c:sortNumbers numbers="<%= numbers%>" order="<%= order%>" />
    <% }%>
  </body>
</html>
 
filename: SortNumbersTag.java
 
 
package customtags;
 
import java.io.IOException;
import java.util.Arrays;
import jakarta.servlet.jsp.tagext.TagSupport;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.JspWriter;
 
public class SortNumbersTag extends TagSupport {
 
    private String numbers; // Input numbers as a comma-separated string
    private String order; // Sorting order: "asc" or "desc"
// Setter methods
 
    public void setNumbers(String numbers) {
        this.numbers = numbers;
    }
 
    public void setOrder(String order) {
        this.order = order;
    }
 
    @Override
    public int doStartTag() throws JspException {
        if (numbers == null || numbers.trim().isEmpty()) {
            return SKIP_BODY;
        }
        String[] numArray = numbers.split(",");
        int[] intArray = new int[numArray.length];
        try {
            for (int i = 0; i < numArray.length; i++) {
                intArray[i] = Integer.parseInt(numArray[i].trim());
            }
        } catch (NumberFormatException e) {
            throw new JspException("Invalid number format!", e);
        }
// Sorting logic
        Arrays.sort(intArray);
        if ("desc".equalsIgnoreCase(order)) {
            for (int i = 0; i < intArray.length / 2; i++) {
                int temp = intArray[i];
                intArray[i] = intArray[intArray.length - 1 - i];
                intArray[intArray.length - 1 - i] = temp;
            }
        }
// Output sorted numbers
        JspWriter out = pageContext.getOut();
        try {
            out.print(Arrays.toString(intArray));
        } catch (IOException e) {
            throw new JspException("Error in SortNumbersTag", e);
        }
        return SKIP_BODY; // No body content required
    }
}
 
filename: sortNumbers.tld
 
<?xml version="1.0" encoding="UTF-8"?>
<taglib version="2.1" xmlns="http://java.sun.com/xml/ns/javaee"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-jsptaglibrary_2_1.xsd">
    <tlib-version>1.0</tlib-version>
    <tag>
        <name>sortNumbers</name>
        <tag-class>customtags.SortNumbersTag</tag-class>
        <body-content>empty</body-content>
        <attribute>
            <name>numbers</name>
            <required>true</required>
            <rtexprvalue>true</rtexprvalue>
        </attribute>
        <attribute>
            <name>order</name>
            <required>false</required>
            <rtexprvalue>true</rtexprvalue>
        </attribute>
    </tag>
</taglib>
 
 
 
 
 
Practical 10- JSP - Application Context
 
filename: UserCounterListener.java
 
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.concurrent.atomic.AtomicInteger;
 
public class UserCounterListener implements HttpSessionListener {
 
    private static final int MAX_USERS = 3; // Maximum allowed users
    private static AtomicInteger activeUsers = new AtomicInteger(0);
 
    @Override
    public void sessionCreated(HttpSessionEvent event) {
        int count = activeUsers.incrementAndGet();
        ServletContext context = event.getSession().getServletContext();
        context.setAttribute("activeUsers", count);
        System.out.println("Session Created. Active Users: " + count);
    }
 
    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        int count = activeUsers.decrementAndGet();
        ServletContext context = event.getSession().getServletContext();
        context.setAttribute("activeUsers", count);
        System.out.println("Session Destroyed. Active Users: " + count);
    }
}
 
filename: error.jsp
 
<html>
  <head>
    <title>Access Denied</title>
  </head>
  <body>
    <h2>Access Denied</h2>
    <p>Sorry, the application is full. Please try again later.</p>
  </body>
</html>
 
filename: index.jsp
 
<%@ page import="jakarta.servlet.ServletContext" %> <% ServletContext context =
request.getServletContext(); Integer activeUsers = (Integer)
context.getAttribute("activeUsers"); if (activeUsers == null) { activeUsers = 0;
} if (activeUsers > 3) { response.sendRedirect("error.jsp"); return; } %>
<html>
  <head>
    <title>Welcome</title>
  </head>
  <body>
    <h2>Welcome to the Application</h2>
    <p>Active Users: <%= activeUsers%></p>
    <p><a href=''>Logout</a></p>
  </body>
</html>
 
filename: logout.jsp
 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Logout</title>
  </head>
  <body>
    <% session.invalidate(); response.sendRedirect("index.jsp"); %>
  </body>
</html>
 
filename: web.xml
 
<listener>
    <listener-class>UserCounterListener</listener-class>
</listener>
 
 
 
 
 
Practical 11- Simple RESTful Service
 
filename: CurrencyConverterService.java
 
package in.ga.services;
 
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.HashMap;
import java.util.Map;
 
@Path("/currency")
public class CurrencyConverterService {
 
    private static final Map<String, Double> exchangeRates = new HashMap<>();
 
    static {
        exchangeRates.put("USD_TO_INR", 83.0);
        exchangeRates.put("EUR_TO_INR", 90.0);
    }
 
    @GET
    @Path("/convert")
    @Produces(MediaType.APPLICATION_JSON)
    public Response convertCurrency(@QueryParam("from") String from,
            @QueryParam("to") String to,
            @QueryParam("amount") double amount) {
        String key = from.toUpperCase() + "_TO_" + to.toUpperCase();
        if (!exchangeRates.containsKey(key)) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("Exchange rate for " + key + " not available.")
                    .build();
        }
        double rate = exchangeRates.get(key);
        double convertedAmount = amount * rate;
        Map<String, Object> response = new HashMap<>();
        response.put("from", from);
        response.put("to", to);
        response.put("amount", amount);
        response.put("convertedAmount", convertedAmount);
        return Response.ok(response).build();
    }
}
 
filename: web.xml
 
<servlet>
<servlet-name>Jersey REST Service</servlet-name>
<servlet-class>org.glassfish.jersey.servlet.ServletContainer</servlet-class>
<init-param>
<param-name>jersey.config.server.provider.packages</param-name>
<param-value>in.ga.services</param-value>
</init-param>
<load-on-startup>1</load-on-startup>
</servlet>
<servlet-mapping>
<servlet-name>Jersey REST Service</servlet-name>
<url-pattern>/ws/*</url-pattern>
</servlet-mapping>
 
filename: pom.xml
 
<dependency>
<groupId>org.glassfish.jersey.core</groupId>
<artifactId>jersey-common</artifactId>
<version>3.1.10</version>
</dependency>
<dependency>
<groupId>org.glassfish.jersey.containers</groupId>
<artifactId>jersey-container-servlet</artifactId>
<version>3.1.10</version>
</dependency>
<dependency>
<groupId>org.glassfish.jersey.inject</groupId>
<artifactId>jersey-hk2</artifactId>
<version>3.1.10</version>
</dependency>
<dependency>
<groupId>org.glassfish.jersey.media</groupId>
<artifactId>jersey-media-json-jackson</artifactId>
<version>3.1.10</version>
</dependency>
