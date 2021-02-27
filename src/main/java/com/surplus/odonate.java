
package com.surplus;
//IO Imports
import java.io.IOException;
import java.io.PrintWriter;
//SQL Imports
import java.sql.*;
//Servlet imports
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Cookie;
import java.sql.Date;  


/**
 *
 * @author Sooraj Krishnan V S
 */
@WebServlet(name = "odonate", urlPatterns = { "/odonate" })
public class odonate extends HttpServlet {

        /**
         *
         */
        private static final long serialVersionUID = 1L;

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
                 String userName=null; 
                 HttpSession session = request.getSession();
               //allow access only if session exists 
               if(session.getAttribute("user")==null)
               {
                request.setAttribute("error", "You need to login to access that page" );
                response.sendRedirect("index.jsp");
               }else{
                 userName=(String) session.getAttribute("user");
                 String sessionID=null;
                 Cookie[] cookies=request.getCookies();
                 if(cookies !=null)
                 { 
                     for(Cookie cookie : cookies){
                        if(cookie.getName().equals("user")) userName=cookie.getValue();
                     }
                 }
                // Database Variables
                String driverName = "com.mysql.jdbc.Driver";
                String connectionUrl = "jdbc:mysql://localhost:3306/";
                String dbName = "surplus";
                String userId = "root";
                String dbpassword = "password";
                PreparedStatement pstatement = null;
                Connection connection = null;
                // Registation Variables
                String don_cat = request.getParameter("doncat");
                String don_type = request.getParameter("dontype");
                String doi = request.getParameter("doi");
                String C_number = request.getParameter("cnum");
                String dloc = request.getParameter("dloc");
                
               int Status=1;

                try {
                        Class.forName(driverName);
                } catch (ClassNotFoundException e) {
                        try (PrintWriter out = response.getWriter()) {
                                out.println("<h1>502 Internal Server Error:  " + e.getMessage() + "</h1>");
                                request.setAttribute("errors", "<div class='alert alert-danger' role='alert'>"
                                                + e.getMessage() + "</div>");
                        }
                }
                //Validation for Null Inputs
                        try {   
                                //Database Insertion
                                connection = DriverManager.getConnection(connectionUrl + dbName, userId, dbpassword);
                                String sqlq = "INSERT INTO donations(Don_Cat,Don_type,Don_det,Dlocation,Contact,Don_user,curr_status) VALUES (?,?,?,?,?,?,?);";
                                pstatement = connection.prepareStatement(sqlq);
                                pstatement.setString(1, don_cat);
                                pstatement.setString(2, don_type);
                                pstatement.setString(3, doi);
                                pstatement.setString(4, dloc);
                                pstatement.setString(5, C_number);
                                pstatement.setString(6, userName);
                                pstatement.setInt(7, Status);
                                int updateQuery = pstatement.executeUpdate();

                                if (updateQuery != 0) {
                                        request.setAttribute("error",
                                                        "<div class='alert alert-danger' role='alert'>Successfully Registred for Donating food</div>");
                                }
                                //Redirection to Login After Successfull Registration
                                RequestDispatcher req = request.getRequestDispatcher("user.jsp");
                                req.forward(request, response);
                        } catch (SQLException e) {
                                RequestDispatcher req = request.getRequestDispatcher("user.jsp");
                                req.forward(request, response);
                                request.setAttribute("errors", "<div class='alert alert-danger' role='alert'>"
                                                + e.getMessage() + "</div>");

                        } finally {
                                try {
                                        pstatement.close();
                                        connection.close();
                                } catch (SQLException e) {
                                        RequestDispatcher req = request.getRequestDispatcher("user.jsp");
                                        req.forward(request, response);
                                        request.setAttribute("errors", "<div class='alert alert-danger' role='alert'>"
                                                        + e.getMessage() + "</div>");
                                }
                        }
                }
        }
}
