<%-- 
    Document   : postDetail
    Created on : Apr 11, 2014, 10:51:50 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.School"%>
<%@page import="com.tebeshir.classes.Post"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" class="no-js">
    <head>
        <meta charset="utf-8"/>
        <title>tebeshir.com</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <meta content="" name="description"/>
        <meta content="" name="author"/>
        <meta name="MobileOptimized" content="320"/>
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="styles/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <link href="styles/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="styles/uniform.default.css" rel="stylesheet" type="text/css"/>
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN PAGE LEVEL PLUGIN STYLES -->
        <link href="styles/daterangepicker-bs3.css" rel="stylesheet" type="text/css"/>
        <link href="styles/fullcalendar.css" rel="stylesheet" type="text/css"/>
        <link href="styles/jqvmap.css" rel="stylesheet" type="text/css"/>
        <link href="styles/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css"/>
        <!-- END PAGE LEVEL PLUGIN STYLES -->
        <!-- BEGIN THEME STYLES --> 
        <link href="styles/style-metronic.css" rel="stylesheet" type="text/css"/>
        <link href="styles/style.css" rel="stylesheet" type="text/css"/>
        <link href="styles/style-responsive.css" rel="stylesheet" type="text/css"/>
        <link href="styles/plugins.css" rel="stylesheet" type="text/css"/>
        <link href="styles/timeline.css" rel="stylesheet" type="text/css"/>
        <link href="styles/tasks.css" rel="stylesheet" type="text/css"/>
        <link href="styles/default.css" rel="stylesheet" type="text/css" id="style_color"/>
        <link href="styles/custom.css" rel="stylesheet" type="text/css"/>
        <!-- END THEME STYLES -->
        <link rel="shortcut icon" href="favicon.ico"/>
        <style type="text/css">.jqstooltip { position: absolute;left: 0px;top: 0px;visibility: hidden;background: rgb(0, 0, 0) transparent;background-color: rgba(0,0,0,0.6);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";color: white;font: 10px arial, san serif;text-align: left;white-space: nowrap;padding: 5px;border: 1px solid white;z-index: 10000;}.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}</style>
    </head>
    <%
        Student currentStudent = (Student) request.getAttribute("currentStudent");
        if (currentStudent == null) {
            if (session.getAttribute("currentStudent") != null) {
                currentStudent = (Student) session.getAttribute("currentStudent");
            } else {
                // session.redirect yap burayı
                RequestDispatcher dispatcher = request.getRequestDispatcher("../welcome.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            session.setAttribute("currentStudent", currentStudent);
        }

        String uri = request.getRequestURI() + // "/people"
                (request.getQueryString() != null ? "?"
                + request.getQueryString() : "");

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

        int postID = Integer.valueOf(request.getParameter("postID"));

        Post currentPost = new Post();
        currentPost = currentPost.getPostDetailsByID(postID);

        boolean myLikeStatus = currentStudent.didILikeThisPost(currentPost.getPostID());
        boolean myFollowStatus = currentStudent.amIFollowingThisPost(currentPost.getPostID());

        Student postOwner = new Student();
        postOwner = postOwner.getStudentById(currentPost.getStudentID());
        School postOwnerSchool = new School();
        String postOwnerSchoolName = postOwnerSchool.getSchoolName(postOwner.getSchoolID());
    %>
    <body class="page-header-fixed page-footer-fixed" style="">

        <!-- BEGIN HEADER -->   
        <div class="header navbar navbar-inverse navbar-fixed-top">

            <!-- BEGIN TOP NAVIGATION BAR -->
            <div class="header-inner">

                <!-- BEGIN LOGO -->  
                <a class="navbar-brand" style="margin-left: 160px" href="home/home.jsp">
                    <img src="images/logo.png" alt="logo" class="img-responsive">
                </a>
                <!-- END LOGO -->

                <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                <a href="javascript:;" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <img src="images/menu-toggler.png" alt="">
                </a> 
                <!-- END RESPONSIVE MENU TOGGLER -->


                <!-- BEGIN TOP NAVIGATION MENU -->
                <ul class="nav navbar-nav pull-right" style="margin-right: 150px">

                    <!-- BEGIN NOTIFICATION DROPDOWN -->
                    <li class="dropdown" id="header_notification_bar">                        
                        <jsp:include page="home/notificationDropDown.jsp" flush="true"/>
                    </li>
                    <!-- END NOTIFICATION DROPDOWN -->


                    <!-- BEGIN INBOX DROPDOWN -->
                    <li class="dropdown" id="header_inbox_bar">
                        <jsp:include page="home/inboxDropDown.jsp" flush="true"/>                        
                    </li>
                    <!-- END INBOX DROPDOWN -->


                    <!-- BEGIN USER DROPDOWN -->
                    <li class="dropdown user">
                        <jsp:include page="home/profileDropDown.jsp" flush="true"/>
                    </li>
                    <!-- END USER DROPDOWN -->                    

                </ul>
                <!-- END TOP NAVIGATION MENU -->
            </div>
            <!-- END TOP NAVIGATION BAR -->
        </div>
        <!-- END HEADER -->

        <div class="clearfix"></div>
        <!-- BEGIN CONTAINER -->
        <div class="page-container">


            <!-- BEGIN PAGE -->
            <div class="page-content">

                <!-- BEGIN PAGE HEADER-->
                <div class="row">
                    <div class="col-md-12">

                    </div>
                </div>


                <div class="row">

                    <!-- TABS BEGIN -->
                    <div class="tabbable tabbable-custom">


                        <ul class="chats">
                            <!-- TEK BİR POST ÖRNEĞİ BEGIN -->
                            <li class="in">
                                <img class="avatar img-responsive" alt="" src="images/avatar1.jpg">
                                    <div class="message">
                                        <span class="arrow"></span>
                                        <a href="profile/student.jsp?student2Bvisited=<%=postOwner.getStudentID()%>" class="name"><%=postOwner.getUsername()%></a>
                                        <a href="home/home.jsp?board2Bvisited=<%=postOwner.getSchoolID()%>" class="name">(<%=postOwnerSchoolName%>)</a>
                                        <span class="datetime">- <%=dateFormat.format(currentPost.getInsertDate())%></span>
                                        <span class="body">
                                            <a href="postDetail.jsp?postID=<%=currentPost.getPostID()%>" style="color: black"><%=currentPost.getOriginalMessage()%></a>
                                            <br/>
                                            <%
                                                for (int j = 0; j < currentPost.getPostTags().size(); j++) {
                                                    if (j == 0) {
                                            %>
                                            <a href="#tab_1_3">Tags</a>
                                            <%
                                                    }
                                            %>
                                            <a href="tag/tag.jsp?board2Bvisited=<%=currentStudent.getSchoolID()%>&tag=<%=currentPost.getPostTags().get(j).getTagId()%>">
                                                #<%=currentPost.getPostTags().get(j).getTag()%>
                                            </a>
                                            <%
                                                }
                                            %>
                                            <span class="post-social">
                                                <!-- follow button begin -->
                                                <%
                                                    if (myFollowStatus == true) {
                                                %>
                                                <span class="btn btn-xs red">
                                                    <form method="post" action="UnfollowPost?postID=<%=currentPost.getPostID()%>&unfollowerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="dIB">
                                                        <input type="submit" class="btn btn-xs red" value="unfollow">
                                                    </form> 
                                                    <span class="count">(<%=currentPost.getFollowerCount()%>)</span>
                                                </span>
                                                <%
                                                    } else {
                                                %>
                                                <span class="btn btn-xs red">
                                                    <form method="post" action="FollowPost?postID=<%=currentPost.getPostID()%>&followerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="dIB">
                                                        <input type="submit" class="btn btn-xs red" value="follow">
                                                    </form>
                                                    <span class="count">(<%=currentPost.getFollowerCount()%>)</span>
                                                </span>
                                                <%
                                                    }
                                                %>
                                                <!-- like button begin -->
                                                <%
                                                    if (myLikeStatus == true) {
                                                %>
                                                <span class="btn btn-xs red">
                                                    <form method="post" action="UnlikePost?postID=<%=currentPost.getPostID()%>&unlikerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="dIB">
                                                        <input type="submit" class="btn btn-xs red" value="unlike">
                                                    </form> 
                                                    <span class="count">(<%=currentPost.getLikerCount()%>)</span>
                                                </span>
                                                <%
                                                } else {
                                                %>
                                                <span class="btn btn-xs red">
                                                    <form method="post" action="LikePost?postID=<%=currentPost.getPostID()%>&likerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="dIB">
                                                        <input type="submit" class="btn btn-xs red" value="like">
                                                    </form> 
                                                    <span class="count">(<%=currentPost.getLikerCount()%>)</span>
                                                </span>
                                                <%
                                                    }
                                                %>
                                                <!-- like button end -->    
                                                <!-- follow button end -->

                                                <a href="#newComment" class="btn btn-xs green">comment <b>(<%=currentPost.getCommenterCount()%>)</b></a>

                                                <!-- social share -->
                                                <div class="btn-group">
                                                    <button class="btn blue btn-xs dropdown-toggle" type="button" data-toggle="dropdown">
                                                        Paylaş <i class="fa fa-angle-down"></i>
                                                    </button>
                                                    <ul class="dropdown-menu" role="menu" style="text-align:left">
                                                        <li style="margin:0; padding:0"><a href="#">Facebook</a></li>
                                                        <li style="margin:0; padding:0"><a href="#">Twitter</a></li>
                                                    </ul>
                                                </div>
                                                <!-- social share end -->

                                            </span>
                                        </span>
                                    </div>
                            </li>
                            <!-- TEK BİR POST ÖRNEĞİ END -->
                        </ul>
                        <div class="tab-content">
                            <!-- POST DIV BEGIN -->
                            <div class="tab-pane active" id="tab_1_1">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#tab_1_1" data-toggle="tab">(<%=currentPost.getLikerCount()%>) likes</a></li>
                                </ul>
                                <!-- POST ATMA ALANI BEGIN -->
                                <form action="PostNewMessage" method="post" id="newPost">
                                    <div class="chat-form">
                                        <div class="input-cont">   
                                            <input class="form-control" type="text" placeholder="burada bu gereksiz olabilir" name="newComment">
                                        </div>
                                        <div class="btn-cont"> 
                                            <span class="arrow"></span>
                                            <a href="#" onclick="$('#newPost').submit();" class="btn blue icn-only"><i class="fa fa-check icon-white"></i></a>
                                        </div>
                                    </div>
                                </form>
                                <!-- POST ATMA ALANI END -->
                            </div>
                            <!-- POST DIV END -->

                        </div>
                    </div>
                    <!-- TABS END -->

                </div>
                <!-- END PAGE HEADER-->

                <div class="clearfix"></div>

            </div>
            <!-- END PAGE -->
        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->
        <div class="footer">
            <div class="footer-inner">
                2013 © Tebeshir
            </div>
            <div class="footer-tools">
                <span class="go-top">
                    <i class="fa fa-angle-up"></i>
                </span>
            </div>
        </div>
        <!-- END FOOTER -->
        <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
        <!-- BEGIN CORE PLUGINS -->   
        <!--[if lt IE 9]>
        <script src="scripts/respond.min.js"></script>
        <script src="scripts/excanvas.min.js"></script> 
        <![endif]-->   
        <script src="scripts/jquery-1.10.2.min.js" type="text/javascript"></script>
        <script src="scripts/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>   
        <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
        <script src="scripts/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
        <script src="scripts/bootstrap.min.js" type="text/javascript"></script>
        <script src="scripts/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="scripts/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="scripts/jquery.blockui.min.js" type="text/javascript"></script>  
        <script src="scripts/jquery.cookie.min.js" type="text/javascript"></script>
        <script src="scripts/jquery.uniform.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <script src="scripts/jqvmap/jquery.vmap.js" type="text/javascript"></script>   
        <script src="scripts/jqvmap/maps/jquery.vmap.russia.js" type="text/javascript"></script>
        <script src="scripts/jqvmap/maps/jquery.vmap.world.js" type="text/javascript"></script>
        <script src="scripts/jqvmap/maps/jquery.vmap.europe.js" type="text/javascript"></script>
        <script src="scripts/jqvmap/maps/jquery.vmap.germany.js" type="text/javascript"></script>
        <script src="scripts/jqvmap/maps/jquery.vmap.usa.js" type="text/javascript"></script>
        <script src="scripts//jqvmap/data/jquery.vmap.sampledata.js" type="text/javascript"></script>  
        <script src="scripts/flot/jquery.flot.js" type="text/javascript"></script>
        <script src="scripts/flot/jquery.flot.resize.js" type="text/javascript"></script>
        <script src="scripts/jquery.pulsate.min.js" type="text/javascript"></script>
        <script src="scripts/moment.min.js" type="text/javascript"></script>
        <script src="scripts/daterangepicker.js" type="text/javascript"></script>     
        <!-- IMPORTANT! fullcalendar depends on jquery-ui-1.10.3.custom.min.js for drag & drop support -->
        <script src="scripts/fullcalendar.min.js" type="text/javascript"></script>
        <script src="scripts/jquery.easy-pie-chart.js" type="text/javascript"></script>
        <script src="scripts/jquery.sparkline.min.js" type="text/javascript"></script>  
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="scripts/index.js" type="text/javascript"></script>
        <script src="scripts/tasks.js" type="text/javascript"></script>        
        <!-- END PAGE LEVEL SCRIPTS -->  

        <!-- END JAVASCRIPTS -->

    </body>
</html>
