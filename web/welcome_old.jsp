<%-- 
    Document   : welcome
    Created on : Nov 28, 2013, 11:03:59 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <link rel="stylesheet" type="text/css" href="css/index.css" />
        <!-- autocomplete için gerekli olan importlar -->
        <link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script src="js/jquery.autocomplete.js"></script>
        <style>
            input {
                font-size: 120%;
            }
        </style>
        <script>
            jQuery(function() {
                $("#schoolName").autocomplete("allSchools.jsp");
            });
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>tebeshir welcome</title>
    </head>
    <%
        Student currentStudent = new Student();
        if (session.getAttribute("currentStudent") != null) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
        }
    %>
    <body>

        <div id="login">
            <div class="login_sol">
                <div class="login_sol1"><img src="images/index/index_1.jpg" width="700" height="450" /></div>
            </div>
            <div class="login_sag">
                <div class="login_sag_login">
                    <div class="login_sag_login_title"><del1>tebeshir loginyeko</del1></div>
                    <div class="login_sag_login_info">
                        <!-- bu form StudentLogin servletine post ediyor -->
                        <form action="StudentLogin" method="post">
                            <p>
                                <label><del2>username :</del2></label>
                                <input type="text" name="loginUserName" /> 
                            </p>
                            <p>
                                <label><del2>password :</del2></label>
                                <input type="password" name="loginPassword" /> 
                            </p>
                            <p>
                                <label>&nbsp;</label>
                                <input type="submit" value="login" class="buton" />
                            </p>
                        </form>
                    </div>
                </div>

                <div class="login_sag_account">
                    <div class="login_sag_account_title"><del1>tebeshir student</del1></div>
                    <div class="login_sag_account_info">
                        <form action="StudentRegister" method="post">
                            <p>
                                <label><del2>username :</del2></label>
                                <input type="text" name="userName" /> 
                            </p>

                            <p>
                                <label><del2>mail :</del2></label>
                                <input type="text" name="userMail" /> 
                            </p>

                            <p>
                                <label><del2>password :</del2></label>
                                <input type="password" name="userPassword" /> 
                            </p>

                            <p>
                                <label><del2>school :</del2></label>
                                <input type="text" id="schoolName" name="schoolName" style="font-size: x-small; height: 20px;"/>
                            </p>

                            <p>
                                <label>&nbsp;</label>
                                <input type="submit" value="add me!" class="buton" />
                            </p>
                        </form>
                    </div>
                </div>
            </div>
            <div class="login_alt"><center><del3>About - Help - Blog - Status - Jobs - Terms - Advertisers</del3></center></div>
        </div>
    </body>
</html>