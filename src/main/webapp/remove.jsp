<%-- 
    Document   : remove
    Created on : 28-Feb-2021, 3:38:14 am
    Author     : Braincracker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Donations -Surplus</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">
    <link rel="stylesheet" href="assets/fonts/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
    <link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.css'>
    <link rel="stylesheet" href="assets/css/style.css">

</head>

<body id="page-top">
    <% 
       String userName=null;
       String Cmail=null;
               //allow access only if session exists 
               if(session.getAttribute("user")==null)
               {
                request.setAttribute("error", "You need to login to access that page" );
                response.sendRedirect("index.jsp");
               }else
                 userName=(String) session.getAttribute("user");
                 Cmail=(String) session.getAttribute("email");
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
                String password = "password";
                
                PreparedStatement ps = null;

                try {
                        Class.forName(driverName);
                } catch (ClassNotFoundException e) {
                       e.getMessage();
                }
                
                try {
                        // SQL Connection and Authentication
                        Connection connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
                        PreparedStatement sql = connection.prepareStatement(
                                        "SELECT FoodID,Food_Name,Food_Cat,Food_type,delivery,contact,closing_date,closing_time,Donor_user,curr_status,AddedDate FROM food where Donor_user='" + userName + "'");
                        PreparedStatement sql2 = connection.prepareStatement(
                                        "SELECT Don_Cat,Don_type,Don_det,Dlocation,Contact,curr_status FROM donations where Don_user='" + userName + "'");
                     
                        ResultSet resultSet2 = sql2.executeQuery();
                        ResultSet resultSet = sql.executeQuery();
                   
                        

                     %> 
    <div id="wrapper">
        <nav class="navbar navbar-dark align-items-start sidebar  sidebar-dark accordion bg-gradient-primary p-0">
            <div class="container-fluid d-flex flex-column p-0">
                <hr class="sidebar-divider my-0">
                <ul class="nav navbar-nav text-light" id="accordionSidebar">
                    <li class="nav-item"><a class="nav-link" href="user.jsp"><i class="fa fa-plus-square-o" aria-hidden="true"></i><span>Give Donations</span></a></li>
                    <li class="nav-item"><a class="nav-link active" href="#"><i class="fa fa-minus-square-o" aria-hidden="true"></i><span>Cancel Donations</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="profile.jsp"><i class="fas fa-user"></i><span>Profile</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="dlist.jsp"><i class="fas fa-table"></i><span>Donation List</span></a></li>
                    
                </ul>
                <div class="text-center d-none d-md-inline"><button class="btn rounded-circle border-0" id="sidebarToggle" type="button"></button></div>
            </div>
        </nav>
        <div class="d-flex flex-column contents" id="content-wrapper">
            <div id="content">
                <nav class="navbar navbar-light navbar-expand bg-white shadow mb-4 topbar fixed-top">
                    <div class="container-fluid"><button class="btn btn-link d-md-none rounded-circle mr-3" id="sidebarToggleTop" type="button"><i class="fas fa-bars"></i></button>
                        <a class="navbar-brand d-flex justify-content-center align-items-center sidebar-brand m-0" href="#">
                            <div class="sidebar-brand-icon rotate-n-15"><i class="fas fa-donate"></i></div>
                            <div class="sidebar-brand-text mx-3"><span>Surplus</span></div>
                        </a>
                        <ul class="nav navbar-nav flex-nowrap ml-auto">
                            <li class="nav-item dropdown no-arrow mx-1">
                                <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#"><span class="badge badge-danger badge-counter">1</span><i class="fas fa-bell fa-fw"></i></a>
                                    <div class="dropdown-menu dropdown-menu-right dropdown-list dropdown-menu-right animated--grow-in">
                                        <h6 class="dropdown-header">Alerts</h6><a class="d-flex align-items-center dropdown-item" href="#">
                                            <div class="mr-3">
                                                <div class="bg-primary text-white icon-circle"><i class="fa fa-building-o" aria-hidden="true"></i></div>
                                            </div>
                                            <div><span class="small text-gray-500">[Time]</span>
                                                <p>[Orphanage] Requesting donation</p>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </li>
                            <div class="d-none d-sm-block topbar-divider"></div>
                            <li class="nav-item dropdown no-arrow">
                                <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#"><span class="d-none d-lg-inline mr-2 text-gray-600 small">[User Name]</span><img class="border rounded-circle img-profile" src="assets/img/avatars/avatar1.jpeg"></a>
                                    <div class="dropdown-menu shadow dropdown-menu-right animated--grow-in"><a class="dropdown-item" href="#"><i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>&nbsp;Profile</a><a class="dropdown-item" href="#"><i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>&nbsp;Settings</a><a class="dropdown-item" href="#"><i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>&nbsp;Activity log</a>
                                        <form action="<%=response.encodeURL(" logout") %>"
                                                            method="post">
                                                            <input type="submit" class="btn" value="Logout">
                                                            ${error}
                                                        </form>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>
                <div class="container-flex">
                    <div class="d-sm-flex justify-content-between align-items-center m-3">
                        <h3 class="text-dark text-center">Remove Donations</h3>
                    </div>
                    ${error}
                    <div class="container-fluid">
                        <% while(resultSet.next()){ %>
                        <div class="card border-0 mb-3">
                            <div class="card-body">
                              <h5 class="card-title"><%= resultSet.getString("Food_Name") %></h5>
                              <p class="card-text">
                              <div class="row">
                                  <div class="col-md-6">
                                  <strong>Food Category:     </strong><%= resultSet.getString("Food_Cat") %><br>
                                  <strong>Food Type:         </strong><%= resultSet.getString("Food_type") %><br>
                                  <strong>Delivery Location: </strong><%= resultSet.getString("delivery") %><br>
                                  </div>
                                  <div class="col-md-6">
                                  <strong>Closing Date:      </strong><%= resultSet.getString("closing_date") %><br>
                                  <strong>Closing Time:      </strong><%= resultSet.getString("closing_time") %><br>                        
                                  </div>
                                 </div>
                              </p>  
                            </div>
                            <div class="card-footer">
                                <small class="text-muted"><%= resultSet.getString("AddedDate")%></small>
                              
                                <a class="btn bg-white rounded-circle mr-2 float-right" href="delete.jsp?id=<%=resultSet.getString("FoodID") %>"><i class=" fa fa-trash" aria-hidden="true"></i></a>
                                <button class="btn bg-white rounded-circle mr-2 float-right" id="sidebarToggleTop" type="button"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                              </div>
                          </div>
                        <%} 
                                           
                                        %>
                          <div class="card border-0 mb-3 bg-info">
                            <div class="card-body">
                              <h5 class="card-title text-white">[Request]</h5>
                              <p class="card-text text-white">[Request Details]</p>
                            </div>
                            <div class="card-footer bg-success">
                                <small class=" text-white">[created date]</small>
                                <button class="btn bg-white rounded-circle mr-2 float-right" id="sidebarToggleTop" type="button"><i class="fa fa-trash" aria-hidden="true"></i></button>
                                <button class="btn bg-white rounded-circle mr-2 float-right" id="sidebarToggleTop" type="button"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                              </div>
                          </div>
                        <% 

                                    } catch (SQLException e) {
                                          out.print(e.getMessage());
                                   }

                                %>
                    </div>
                </div>
            </div>
            <footer class="bg-white sticky-footer">
                <div class="container my-auto">
                    <div class="text-center my-auto copyright"><span>Copyright © Brand 2020</span></div>
                </div>
            </footer>
        </div><a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
    </div>
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/chart.min.js"></script>
    <script src="assets/js/bs-init.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.js"></script>
    <script src="assets/js/theme.js"></script>
</body>

</html>
