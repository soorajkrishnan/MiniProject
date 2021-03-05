<%-- 
    Document   : delete
    Created on : 28-Feb-2021, 5:23:14 pm
    Author     : Braincracker
--%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
                String id=request.getParameter("id");
                String driverName = "com.mysql.jdbc.Driver";
                String connectionUrl = "jdbc:mysql://localhost:3306/";
                String dbName = "surplus";
                String userId = "root";
                String password = "password";
                try {
                        Class.forName(driverName);
                } catch (ClassNotFoundException e) {
                       e.getMessage();
                }
                
                try {

                        Connection connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
                        Statement st=connection.createStatement();
                        int i=st.executeUpdate("DELETE FROM food WHERE FoodID="+id);
                        RequestDispatcher rd = getServletContext().getRequestDispatcher("/remove.jsp");
                                request.setAttribute("error",
                                               "<div class='alert alert-success' id='success-alert'><button type='button' class='close' data-dismiss='alert'></button><strong>Succesfully Deleted !</strong></div>");
                                rd.include(request, response);
                    } catch (SQLException e) 
                    {
                        out.print(e.getMessage());
                    }
%> 
