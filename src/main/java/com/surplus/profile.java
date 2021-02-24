
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

/**
 *
 * @author Sooraj Krishnan V S
 */
@WebServlet(name = "profile", urlPatterns = { "/profile" })
public class profile extends HttpServlet {

        /**
         *
         */
        private static final long serialVersionUID = 1L;

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {

                // Database Variables
                String driverName = "com.mysql.jdbc.Driver";
                String connectionUrl = "jdbc:mysql://localhost:3306/";
                String dbName = "surplus";
                String userId = "root";
                String dbpassword = "password";
                PreparedStatement ps = null;
                Connection connection = null;
                
                // Registation Variables
                String first_name = request.getParameter("fname");
                String last_name = request.getParameter("lname");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                String number = request.getParameter("number");
                String city = request.getParameter("city");
                String state = request.getParameter("state");

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

                                String updateUser= "UPDATE users SET email=?,fname=?,lname=?,phone=?,address=?,city=?,state=? where email='" + email + "'";
                                ps = connection.prepareStatement(updateUser);
                                ps.setString(1, email);
                                ps.setString(2, first_name);
                                ps.setString(3, last_name);
                                ps.setString(4, number);
                                ps.setString(5, address);
                                ps.setString(6, city);
                                ps.setString(7, state);
                                int updateQuery = ps.executeUpdate();
                                    if (updateQuery != 0) {
                                            request.setAttribute("error",
                                                            "<div class='alert alert-danger' role='alert'>Successfully Updated</div>");
                                    }
                               
                                //Redirection to Login After Successfull Registration
                                RequestDispatcher req = request.getRequestDispatcher("profile.jsp");
                                req.forward(request, response);
                        } catch (SQLException e) {
                               try (PrintWriter out = response.getWriter()) {
                                out.println("<h1>502 Internal Server Error:  " + e.getMessage() + "</h1>");
                        }

                        } finally {
                                try {
                                ps.close();     
                                connection.close();
                                } catch (SQLException e) {
                                        try (PrintWriter out = response.getWriter()) {
                                out.println("<h1>502 Internal Server Error:  " + e.getMessage() + "</h1>");
                        }
                                }
                        }
                }
        }

