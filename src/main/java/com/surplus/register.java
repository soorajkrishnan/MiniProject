/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.surplus;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
/**
 *
 * @author Braincracker
 */
@WebServlet(name = "register", urlPatterns = {"/register"})
public class register extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
          
        // TODO Auto-generated method stub
                String driverName = "com.mysql.jdbc.Driver";
		String connectionUrl = "jdbc:mysql://localhost:3306/";
		String dbName = "surplus";
		String userId = "root";
		String dbpassword = "password";
                PreparedStatement pstatement=null;
                Connection connection=null;
                
                
		String first_name = request.getParameter("Fname");
		String last_name = request.getParameter("Lname");
                String orgname = request.getParameter("oname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String address = request.getParameter("address");
		String number = request.getParameter("mnumber");
                String city = request.getParameter("City");
                String state = request.getParameter("State");
                String pincodes = request.getParameter("pcode");
                String utypes=request.getParameter("typeo");
                
                int pincode=Integer.parseInt(pincodes);
                int utype=Integer.parseInt(utypes);
               
                try {
			Class.forName(driverName);
			} catch (ClassNotFoundException e) {
				try (PrintWriter out = response.getWriter()) {
                                out.println("<h1>502 Internal Server Error:  " + e.getMessage() + "</h1>");
                                request.setAttribute("errors", "<div class='alert alert-danger' role='alert'>"+e.getMessage()+"</div>");
			}}

		
		if(first_name.isEmpty() || last_name.isEmpty() || email.isEmpty() || 
				password.isEmpty() || address.isEmpty() || number.isEmpty()||city.isEmpty()||state.isEmpty())
		{       RequestDispatcher req = request.getRequestDispatcher("register.jsp");
                        req.forward(request, response);
                        request.setAttribute("errors", "<div class='alert alert-danger' role='alert'>Enter All Required Feilds</div>");
			
		}
		else
		{       
                    try{ 
                        connection = DriverManager.getConnection(connectionUrl+dbName, userId, dbpassword);
                        String sqlq = "INSERT INTO users(email,upassword,oname,fname,lname,address,phone,city,state,pincode,utype) VALUES (?,?,?,?,?,?,?,?,?,?,?);";
                        pstatement = connection.prepareStatement(sqlq);
                        pstatement.setString(1, email);
                        pstatement.setString(2, password);
                        pstatement.setString(3, orgname);
                        pstatement.setString(4, first_name);                        
                        pstatement.setString(5, last_name);
                        pstatement.setString(6, address); 
                        pstatement.setString(7, number);                        
                        pstatement.setString(8, city);                        
                        pstatement.setString(9, state);
                        pstatement.setInt(10, pincode);               
                        pstatement.setInt(11,utype);
                        
                        int updateQuery = pstatement.executeUpdate();
                       
                        if (updateQuery != 0) {
                                 request.setAttribute("error", "<div class='alert alert-danger' role='alert'>Successfully Signed Up</div>");                  
                        }
			RequestDispatcher req = request.getRequestDispatcher("index.jsp");
			req.forward(request, response);
                    }
                    catch(SQLException e){
                                RequestDispatcher req = request.getRequestDispatcher("register.jsp");
                                req.forward(request, response);
                                request.setAttribute("errors", "<div class='alert alert-danger' role='alert'>"+e.getMessage()+"</div>");
			
                    }
                    finally {
                        try{
                           pstatement.close();
                           connection.close();
                        }
                        catch(SQLException e){
                                RequestDispatcher req = request.getRequestDispatcher("register.jsp");
                                req.forward(request, response);
                                request.setAttribute("errors", "<div class='alert alert-danger' role='alert'>"+e.getMessage()+"</div>");
            }
                    }
		}
	}
    }
    
  
