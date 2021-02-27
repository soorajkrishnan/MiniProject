<%-- 
    Document   : dlist
    Created on : 28-Feb-2021, 12:54:44 am
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
    <title>Table - Brand</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">
    <link rel="stylesheet" href="assets/fonts/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
    <link rel="stylesheet" href="assets/fonts/fontawesome5-overrides.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

</head>

<body id="page-top">
    <% String userName=null;
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
                                        "SELECT Food_Name,Food_Cat,Food_type,delivery,contact,closing_date,closing_time,Donor_user,curr_status FROM food where Donor_user='" + userName + "'");
                     
                        
                        ResultSet resultSet = sql.executeQuery();


                     %>   
                        
    <div id="wrapper">
        <nav class="navbar navbar-dark align-items-start sidebar  sidebar-dark accordion bg-gradient-primary p-0">
            <div class="container-fluid d-flex flex-column p-0">
                <hr class="sidebar-divider my-0">
                <ul class="nav navbar-nav text-light" id="accordionSidebar">
                    <li class="nav-item"><a class="nav-link" href="index.html"><i class="fa fa-plus-square-o" aria-hidden="true"></i><span>Give Donations</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="Remove.html"><i class="fa fa-minus-square-o" aria-hidden="true"></i><span>Cancel Donations</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="profile.html"><i class="fas fa-user"></i><span>Profile</span></a></li>
                    <li class="nav-item"><a class="nav-link active" href="table.html"><i class="fas fa-table"></i><span>Donation List</span></a></li>
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
                                        <div class="dropdown-divider"></div><a class="dropdown-item" href="#"><i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>&nbsp;Logout</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>
                
                <div class="container-fluid">
                    <h3 class="text-dark my-4">Donation List</h3>
                    <div class="card shadow">
                        <div class="card-header py-3">
                            <p class="text-primary m-0 font-weight-bold">Donation List</p>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                                <table class="table my-0" id="dataTable">
                                    <thead>
                                        <tr>
                                            <th>Food Name</th>
                                            <th>Food Category</th>
                                            <th>Food Type</th>
                                            <th>Location</th>
                                            <th>Closing date</th>
                                            <th>Closing time</th>
                                            <th>Contact Number</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% while(resultSet.next()){ %>
                                            <tr>
                                                <td> <%= resultSet.getString("Food_Name") %></td>
                                                <td> <%= resultSet.getString("Food_Cat") %></td>
                                                <td> <%= resultSet.getString("Food_type") %></td>
                                                <td> <%= resultSet.getString("delivery") %></td>
                                                <td> <%= resultSet.getDate("closing_date") %></td>
                                                <td> <%= resultSet.getTime("closing_time") %></td>
                                                <td> <%= resultSet.getString("contact") %></td>

                                            </tr>       
                                        
                                        <%}%>
                                    </tbody>
                                </table>
                            </div>
                            <div class="row">
                                <div class="col-md-6 align-self-center">
                                    <p id="dataTable_info" class="dataTables_info" role="status" aria-live="polite">Showing 1 to <% resultSet.getRow();%></p>
                                </div>
                                <% 

                                    } catch (SQLException e) {
                                          out.print(e.getMessage());
                                   }

                                %>
                                <div class="col-md-6">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <footer class="bg-white sticky-footer">
                <div class="container my-auto">
                    <div class="text-center my-auto copyright"><span>Copyright Â© Brand 2020</span></div>
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
