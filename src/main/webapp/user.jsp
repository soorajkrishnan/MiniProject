<%-- 
    Document   : user
    Created on : 15-Jan-2021, 12:27:53 pm
    Author     : Braincracker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
String userName = null;
//allow access only if session exists
if(session.getAttribute("user") == null){
        request.setAttribute("error", "You need to login to access that page");
	response.sendRedirect("index.jsp");
}else userName = (String) session.getAttribute("user");
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
	if(cookie.getName().equals("user")) userName = cookie.getValue();
}
}
%>
    <div id="wrapper">
        <nav class="navbar navbar-dark align-items-start sidebar  sidebar-dark accordion bg-gradient-primary p-0">
            <div class="container-fluid d-flex flex-column p-0">
                <hr class="sidebar-divider my-0">
                <ul class="nav navbar-nav text-light" id="accordionSidebar">
                    <li class="nav-item"><a class="nav-link" href="index.html"><i class="fa fa-plus-square-o" aria-hidden="true"></i><span>Give Donations</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="Remove.html"><i class="fa fa-minus-square-o" aria-hidden="true"></i><span>Cancel Donations</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="profile.html"><i class="fas fa-user"></i><span>Profile</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="table.html"><i class="fas fa-table"></i><span>Donation List</span></a></li>
                  
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
                                <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#"><span class="d-none d-lg-inline mr-2 text-gray-600 small">${user}</span><img class="border rounded-circle img-profile" src="assets/img/avatars/avatar1.jpeg"></a>
                                    <div class="dropdown-menu shadow dropdown-menu-right animated--grow-in"><a class="dropdown-item" href="#"><i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>&nbsp;Profile</a><a class="dropdown-item" href="#"><i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>&nbsp;Settings</a><a class="dropdown-item" href="#"><i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>&nbsp;Activity log</a>
                                        <div class="dropdown-divider"></div><a class="dropdown-item" href="/logout"><i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i><form action="<%=response.encodeURL("logout") %>" method="post">
<input type="submit" value="Logout" ></form></a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>
                <div class="container-flex">
                    <div class="d-sm-flex justify-content-between align-items-center m-3">
                        <h3 class="text-dark text-center">Give Donations</h3>
                    </div>
                    <div class="row d-flex justify-content-center donate-food ">
                        <div class="col-12">
                            <div class="card b-0 ">
                                <div class="p-3">
                                <h3 class="heading text-dark">Donate Food</h3>
                                    
                                </div>
                            <form action="" class="p-3">
                                <div class="form-group">
                                  <label for="food">Food Name</label>
                                  <input type="text" class="form-control" name="" id="food" aria-describedby="helpId" placeholder="Food Name">
                                </div>
                                <div class="form-group">
                                    <label for="food type">Food Category</label>
                                    <select class="custom-select" name="" id="">
                                        <option selected value="">Cereal</option>
                                        <option value="">Vegitarian</option>
                                        <option value="">Non-Vegitarian</option>
                                    </select>
                                </div>
                                <label for="food type">Food Type</label>
                                <div class="form-check">
                                    <label class="form-check-label">
                                    <input type="radio" class="form-check-input" name="rad" id="radio" value="checkedValue" checked>
                                    Fresh
                                  </label>
                                    <label class="form-check-label ml-5">
                                    <input type="radio" class="form-check-input" name="rad" id="radio" value="checkedValue1">
                                    Surplus
                                  </label>
                                </div>
                                <br>
                                <div class="form-group">
                                  <label for="">Location</label>
                                  <input type="text" class="form-control" name="" id="" aria-describedby="helpId" placeholder="Location for food delivary">
                                </div>
                                
                                <div class="form-group">
                                  <label for="">Contact Number</label>
                                  <input type="text" class="form-control" name="" id="" aria-describedby="helpId" placeholder="Enter Contact Number">
                                </div>
                                <div class="form-row">
                                    
                                <div class="form-group col-md-6">
                                    <label for="">Closing Date</label>
                                    <div class="input-group date" id="datepicker">
                                      <input class="form-control" placeholder="MM/DD/YYYY"/><span class="input-group-append input-group-addon"><span class="input-group-text"><i class="fa fa-calendar"></i></span></span>
                                    </div>
                                  </div>
                                  <div class="form-group col-md-6">
                                    <label for="">Closing Time</label>
                                    <div class="input-group time" id="timepicker">
                                      <input class="form-control" placeholder="HH:MM AM/PM"/><span class="input-group-append input-group-addon"><span class="input-group-text"><i class="fa fa-clock"></i></span></span>
                                    </div>
                                  </div>
                                </div>
                                <button type="submit" class="btn btn-primary">Donate Food</button>
                            </form>
                            
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-flex">
                <div class="row d-flex justify-content-center donate-food ">
                    <div class="col-12">
                        <div class="card b-0 ">
                            <div class="p-3">
                            <h3 class="heading text-dark">Other Donations</h3>
                                
                            </div>
                        <form action="" class="p-3">
                            <div class="form-group">
                                <label for="food type">Donation Category</label>
                                <select class="custom-select" name="" id="">
                                    <option selected value="">Cloth</option>
                                    <option value="">Medicine</option>
                                    <option value="">Daily Items</option>
                                </select>
                            </div>
                            <label for="food type">Donation Type</label>
                            <div class="form-check ml-3">
                                <label class="form-check-label">
                                <input type="radio" class="form-check-input" name="rad" id="radio" value="checkedValue" checked>
                                Fresh
                              </label>
                                <label class="form-check-label ml-5">
                                <input type="radio" class="form-check-input" name="rad" id="radio" value="checkedValue1">
                                Used
                              </label>
                            </div>
                            <div class="form-group">
                              <label for="">Details about Items</label>
                              <textarea class="form-control" name="" id="" rows="3"></textarea>
                            </div>
                            <br>
                            <div class="form-group">
                              <label for="">Location</label>
                              <input type="text" class="form-control" name="" id="" aria-describedby="helpId" placeholder="Location for food delivary">
                            </div>
                            
                            <div class="form-group">
                              <label for="">Contact Number</label>
                              <input type="text" class="form-control" name="" id="" aria-describedby="helpId" placeholder="Enter Contact Number">
                            </div>
                            <button type="submit" class="btn btn-primary">Donate Items</button>
                        </form>
                        
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
