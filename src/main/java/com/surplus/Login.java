package com.surplus;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.Cookie;
import java.io.PrintWriter;


@WebServlet(urlPatterns="/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }
    public void cookies(HttpServletRequest request,HttpServletResponse response, String name)throws ServletException, IOException {
         HttpSession session=request.getSession();
         session.setAttribute("user", name);
         //setting session to expiry in 30 mins
         session.setMaxInactiveInterval(30*60);                                    
         Cookie userName = new Cookie("user", name);
         response.addCookie(userName);
    }

        @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

        @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String driverName = "com.mysql.jdbc.Driver";
		String connectionUrl = "jdbc:mysql://localhost:3306/";
		String dbName = "surplus";
		String userId = "root";
		String password = "password";
		String pwdd=null;
		String email=request.getParameter("email");
		String psswd=request.getParameter("password");
                String name=null;
                String user=null;
                int utype = 0;
		try {
			Class.forName(driverName);
			} catch (ClassNotFoundException e) {
				try (PrintWriter out = response.getWriter()) {
                                out.println("<h1>502 Internal Server Error:  " + e.getMessage() + "</h1>");
			}}

			try{ 
				Connection connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
				/* Statement statement=connection.createStatement();
				String sql ="SELECT upassword,utype,email,fname FROM users where email='"+email+"'";*/
                                PreparedStatement sql=connection.prepareStatement("SELECT upassword,utype,email,fname FROM users where email='"+email+"'");
				ResultSet resultSet = sql.executeQuery();
				while(resultSet.next()) {
                                user=resultSet.getString("email");
				pwdd=resultSet.getString("upassword");
                                name = resultSet.getString("fname");
                                utype= resultSet.getInt("utype");
				}
                                cookies(request,response,name);
                                if(email.equals(user) && psswd.equals(pwdd)){
                                    if(email.equals("admin@surplus.com")){
                                        String encodedURL = response.encodeRedirectURL("user.jsp");
                                        response.sendRedirect(encodedURL);
                                        }
                                    else if(utype!=1){
                                        String encodedURL = response.encodeRedirectURL("user.jsp");                                        
                                        response.sendRedirect(encodedURL);
                                    }
                                    else{
                                        String encodedURL = response.encodeRedirectURL("org.jsp");                                        
                                        response.sendRedirect(encodedURL);
                                    }
                                }else{
                                        RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
                                        request.setAttribute("error", "<div class='alert alert-danger' role='alert'> Invalid Email/ Password</div>");
                                        rd.include(request, response);
		}
                        
                                    
		
	}catch(SQLException ex) { 
		try (PrintWriter out = response.getWriter()) {
            out.println("<h1>502 Internal Server Error:  " + ex.getMessage() + "</h1>");
        }
	}
                        }}
        
