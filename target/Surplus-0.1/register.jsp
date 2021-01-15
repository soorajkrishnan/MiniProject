<%-- 
    Document   : register
    Created on : 15-Jan-2021, 8:50:42 pm
    Author     : Braincracker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
    />
    <title>Register - Surplus</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
    />
    <link rel="stylesheet" href="assets/fonts/fontawesome-all.min.css" />
    <link rel="stylesheet" href="assets/fonts/font-awesome.min.css" />
    <link rel="stylesheet" href="assets/fonts/fontawesome5-overrides.min.css" />
    <link rel="stylesheet" href="assets/css/style.css" />
  </head>

  <body class="bg-gradient-primary">
    <div class="container regisration">
      <div class="card shadow-lg o-hidden border-0 my-5">
        <div class="card-body p-0">
          <div class="row">
            <div class="col-lg-5 d-none d-lg-flex">
              <div
                class="flex-grow-1 bg-register-image"
                style='background-image: url("assets/img/dogs/image2.jpeg");'
              ></div>
            </div>
            <div class="col-lg-7">
              <div class="p-3 ">
                <div class="text-center">
                  <h4 class="text-dark mb-4">Start Caring</h4>
                </div>
                <form>
                  <div class="card">
                    <div class="form-group row">
                      <label for="inputEmail3" class="col-sm-2 col-form-label"
                        >Email</label
                      >
                      <div class="col-sm-10">
                        <input
                          type="email"
                          class="form-control"
                          id="inputEmail3"
                          placeholder="Email"
                        />
                      </div>
                    </div>
                    <div class="form-group row">
                      <label
                        for="inputPassword3"
                        class="col-sm-2 col-form-label"
                        >Password</label
                      >
                      <div class="col-sm-10">
                        <input
                          type="password"
                          class="form-control"
                          id="inputPassword3"
                          placeholder="Password"
                        />
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputAddress2">Organization Name</label>
                    <input
                      type="text"
                      class="form-control"
                      id="inputAddress2"
                      placeholder="Provide Name if NGO/ Orphanage"
                    />
                  </div>
                  <div class="form-row">
                    <div class="form-group col-md-6">
                      <label for="Fname">First Name</label>
                      <input
                        type="text"
                        class="form-control"
                        id="Fname"
                        placeholder="First Name"
                      />
                    </div>
                    <div class="form-group col-md-6">
                      <label for="Lname">Last Name</label>
                      <input
                        type="text"
                        class="form-control"
                        id="Lname"
                        placeholder="Last Name"
                      />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="address">Address</label>
                    <input
                      type="text"
                      class="form-control"
                      id="address"
                      placeholder="House Address / NGO Address"
                    />
                  </div>
                  <div class="form-group">
                    <label for="address">Mobile Number</label>
                    <input
                      type="text"
                      class="form-control"
                      id="address"
                      placeholder=""
                    />
                  </div>

                  <div class="form-row">
                    <div class="form-group col-md-5">
                      <label for="inputCity">City</label>
                      <input type="text" class="form-control" id="inputCity" />
                    </div>
                    <div class="form-group col-md-4">
                      <label for="inputState">State</label>
                      <select
                        id="inputState"
                        class="form-control"
                        placeholder="State"
                      >
                        <option selected>Kerala</option>
                        <option>Tamil Nadu</option>
                        <option>Karnataka</option>
                      </select>
                    </div>
                    <div class="form-group col-md-3">
                      <label for="Pincode">Pin Code</label>
                      <input type="text" class="form-control" id="Pincode" />
                    </div>
                  </div>
                  <div class="form-group pl-3">
                    <div class="form-check">
                      <input
                        class="form-check-input"
                        type="checkbox"
                        id="gridCheck"
                      />
                      <label class="form-check-label" for="gridCheck">
                        Organization
                      </label>
                    </div>
                  </div>
                  <div class="row mb-4">
                    <div class="col text-center">
                      <button type="submit" class="btn btn-primary">
                        Sign Up
                      </button>
                    </div>
                  </div>
                </form>
                <div class="text-center">
                  <a class="small" href="login.html"
                    >Already have an account? Login!</a
                  >
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/chart.min.js"></script>
    <script src="assets/js/bs-init.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.js"></script>
    <script src="assets/js/theme.js"></script>
  </body>
</html>
