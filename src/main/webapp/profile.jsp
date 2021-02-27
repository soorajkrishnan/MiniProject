<%-- 
    Document   : profile
    Created on : 25-Feb-2021, 12:21:40 am
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
    <title>Profile - Brand</title>
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
                
                PreparedStatement ps,sp = null;

                // User Variables
                String fname= null;
                String lname= null;
                String address= null;
                String phone= null;
                String state= null;
                String city= null;
                String name = null;
                String email = null;
                String created_on =null;

                try {
                        Class.forName(driverName);
                } catch (ClassNotFoundException e) {
                       fname=e.getMessage();
                }

                try {
                        // SQL Connection and Authentication
                        Connection connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
                        PreparedStatement sql = connection.prepareStatement(
                                        "SELECT email,fname,lname,phone,address,city,state,created_on FROM users where email='" + userName + "'");
                     
                        
                        ResultSet resultSet = sql.executeQuery();


                        while (resultSet.next()) {
                                email = resultSet.getString("email");
                                fname = resultSet.getString("fname");
                                lname = resultSet.getString("lname");
                                address = resultSet.getString("address");
                                city = resultSet.getString("city");
                                state = resultSet.getString("state");
                                phone = resultSet.getString("phone");
                                created_on=resultSet.getString("created_on");
                        }
                 } catch (SQLException e) {
                       out.print(e.getMessage());
                }
                String uname=fname+' '+lname;
             %>
    <div id="wrapper">
        <nav class="navbar navbar-dark align-items-start sidebar  sidebar-dark accordion bg-gradient-primary p-0">
            <div class="container-fluid d-flex flex-column p-0">
                <hr class="sidebar-divider my-0">
                <ul class="nav navbar-nav text-light" id="accordionSidebar">
                    <li class="nav-item"><a class="nav-link" href="user.jsp"><i class="fa fa-plus-square-o" aria-hidden="true"></i><span>Give Donations</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="Remove.jsp"><i class="fa fa-minus-square-o" aria-hidden="true"></i><span>Cancel Donations</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="profile.jsp"><i class="fas fa-user"></i><span>Profile</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="table.jsp"><i class="fas fa-table"></i><span>Donation List</span></a></li>
                    
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
                                <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#"><span class="d-none d-lg-inline mr-2 text-gray-600 small"><% out.print(fname); %></span><img class="border rounded-circle img-profile" src="assets/img/avatars/avatar1.jpeg"></a>
                                    <div class="dropdown-menu shadow dropdown-menu-right animated--grow-in"><a class="dropdown-item" href="#"><i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>&nbsp;Profile</a><a class="dropdown-item" href="#"><i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>&nbsp;Settings</a><a class="dropdown-item" href="#"><i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>&nbsp;Activity log</a>
                                        <div class="dropdown-divider"></div><form action="<%=response.encodeURL(" logout") %>"
                                                            method="post">
                                                            <input type="submit" class="btn" value="Logout">
                                                        </form>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>                
                <div class="container-fluid">
                    <h3 class="text-dark my-4">Profile</h3>
                    <div class="row mb-3">
                        <div class="col">
                            <div class="row">
                                <div class="col">
                                    <div class="card shadow mb-3">
                                        <div class="card-header py-3">
                                            <p class="text-primary m-0 font-weight-bold">User Details</p>
                                        </div>
                                        <div class="card-body">
                                            <p style="font-size: 18px;"> 
                                                <b>Name:</b> <% out.print(uname); %><br>
                                                <b>Address:</b> <% out.print(address); %><br>
                                                <b>City</b> <% out.print(city); %><br>
                                                <b>State</b> <% out.print(state); %><br>
                                                <b>Mobile Number:</b> <% out.print(phone); %><br>
                                                <b>Account Created on:</b> <% out.print(created_on); %><br>

                                            </p>
                                            
                                        </div>
                                    </div>
                                    <div class="card shadow mb-3">
                                        <div class="card-header py-3">
                                            <p class="text-primary m-0 font-weight-bold" data-bs-toggle="tooltip" data-bs-placement="right" title="You can only update your Data !">Update Details</p>
                                        </div>
                                        <div class="card-body">
                                            
                                            <form action="profile" method="POST" class="needs-validation" novalidate>
                                                <div class="form-row">
                                                    <div class="col">
                                                        <div class="form-group"><label for="email"><strong>Email Address</strong></label><input class="form-control" type="email" placeholder="<% out.print(email); %> " name="email"></div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="col">
                                                        <div class="form-group"><label for="first_name"><strong>First Name</strong></label><input class="form-control" type="text" placeholder=" <% out.print(fname); %> " name="fname" required></div>
                                                    </div>
                                                    <div class="col">
                                                        <div class="form-group"><label for="last_name"><strong>Last Name</strong></label><input class="form-control" type="text" placeholder="<% out.print(lname); %> " name="lname"></div>
                                                    </div>
                                                </div>
                                               
               
                                                <div class="form-group">
                                                    <label for="phone"><strong>Mobile Number</strong></label>
                                                    <input type="tel" class="form-control" name="number"
                                                        placeholder="<% out.print(phone); %>" pattern="[0-9]{10}" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="address"><strong>Address</strong></label>
                                                    <input class="form-control" type="text" placeholder="<% out.print(address); %>" name="address" required>
                                                </div>
                                                <div class="form-row">
                                                    <div class="col">
                                                        <div class="form-group"><label for="city"><strong>City</strong></label><input class="form-control" type="text" placeholder="<% out.print(city); %>" name="city" required></div>
                                                    </div>
                                                    <div class="col">
                                                        <div class="form-group"><label for="state"><strong>State</strong></label><input class="form-control" type="text" placeholder="<% out.print(state); %>" name="state" required></div>
                                                    </div>
                                                </div>
                                                <div class="form-group"><button class="btn btn-primary btn-md" type="submit" name="update">Update Details</button>
                                                
                                                </div>
                                    
                                            ${error}
                                            </form>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
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
    <script src="assets/js/main.js"></script>

</body>

</html>