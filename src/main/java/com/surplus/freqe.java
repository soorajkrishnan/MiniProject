
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
@WebServlet(name = "freqe", urlPatterns = { "/freqe" })
public class freqe extends HttpServlet {

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
                String act = request.getParameter("act");
                // Food Request Variables
                String food_name = request.getParameter("fdname");
                String food_cat = request.getParameter("fdcat");
                String fd_qty = request.getParameter("fdqty");
                String Contact_number = request.getParameter("rnum");
                String Cdate = request.getParameter("rdate");
                // Other Request Variables
                String reqCat=request.getParameter("Otype");
                String odetail=request.getParameter("ODetails");
                String OContact=request.getParameter("OContact");              
                
                //Cnverting string to SQL date
                
                
                
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
                                int updateQuery =1;
                                String sqlq=null;
                                switch(act){
                                    case "reqf":   int food_qty=Integer.parseInt(fd_qty);
                                    Date Closing_date=Date.valueOf(Cdate);
                                     sqlq= "INSERT INTO ReqFood(RFood_Name,RFood_Cat,RFood_qty,rnumber,req_date,req_user,curr_status) VALUES (?,?,?,?,?,?,?);";
                                    pstatement = connection.prepareStatement(sqlq);
                                    pstatement.setString(1, food_name);
                                    pstatement.setString(2, food_cat);
                                    pstatement.setInt(3, food_qty);
                                    pstatement.setString(4, Contact_number);
                                    pstatement.setDate(5, Closing_date);
                                    pstatement.setString(6, userName);
                                    pstatement.setInt(7, Status);
                                    updateQuery = pstatement.executeUpdate();
                                    break;
                                case "reqo":
                                    sqlq = "INSERT INTO ReqOth (OR_Cat, OR_Details, OR_phone, req_user, curr_status) VALUES (?, ?, ?, ?, ?);";
                                    pstatement = connection.prepareStatement(sqlq);
                                    pstatement.setString(1, reqCat);
                                    pstatement.setString(2, odetail);
                                    pstatement.setString(3, OContact);
                                    pstatement.setString(4, userName);
                                    pstatement.setInt(5, Status);
                                    updateQuery = pstatement.executeUpdate();
                                    break;
                                }
                                if (updateQuery != 0) {
                                        request.setAttribute("error",
                                                        "<div class='alert alert-danger m-4' role='alert'>Successfully REQUESTED</div>");
                                }
                                //Redirection to Login After Successfull Registration
                                RequestDispatcher req = request.getRequestDispatcher("org.jsp");
                                req.forward(request, response);
                        } catch (SQLException e) {
                                RequestDispatcher req = request.getRequestDispatcher("org.jsp");
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
