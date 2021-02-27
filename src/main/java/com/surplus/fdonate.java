
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
@WebServlet(name = "fdonate", urlPatterns = { "/fdonate" })
public class fdonate extends HttpServlet {

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
                String food_name = request.getParameter("fdname");
                String food_cat = request.getParameter("fdcat");
                String food_type = request.getParameter("fdtype");
                String food_location = request.getParameter("fdlocation");
                String Contact_number = request.getParameter("contnumber");
                String Cdate = request.getParameter("cdate");
                String Ctime = request.getParameter("ctime");
                
                //Cnverting string to SQL date
                Date Closing_date=Date.valueOf(Cdate);
                Time Closing_time =Time.valueOf(Ctime);
                
                
                int Status= 1;
               

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
                                String sqlq = "INSERT INTO food(Food_Name,Food_Cat,Food_type,delivery,contact,closing_date,closing_time,Donor_user,curr_status) VALUES (?,?,?,?,?,?,?,?,?);";
                                pstatement = connection.prepareStatement(sqlq);
                                pstatement.setString(1, food_name);
                                pstatement.setString(2, food_cat);
                                pstatement.setString(3, food_type);
                                pstatement.setString(4, food_location);
                                pstatement.setString(5, Contact_number);
                                pstatement.setDate(6, Closing_date);
                                pstatement.setTime(7, Closing_time);
                                pstatement.setString(8, userName);
                                pstatement.setInt(9, Status);
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
