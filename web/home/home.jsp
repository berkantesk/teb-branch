<%-- 
    Document   : index
    Created on : Nov 28, 2013, 11:19:14 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" class="no-js">
    <head>
        <jsp:include page="/inc/head.jsp" flush="true" />
        <style type="text/css">.jqstooltip { position: absolute;left: 0px;top: 0px;visibility: hidden;background: rgb(0, 0, 0) transparent;background-color: rgba(0,0,0,0.6);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";color: white;font: 10px arial, san serif;text-align: left;white-space: nowrap;padding: 5px;border: 1px solid white;z-index: 10000;}.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}</style>
    </head>
    <!-- END HEAD -->
    <%
        //Student currentStudent = (Student) request.getAttribute("currentStudent");
        Student currentStudent = (Student) session.getAttribute("currentStudent");
        if (currentStudent == null) {
            /*if (session.getAttribute("currentStudent") != null) {
             currentStudent = (Student) session.getAttribute("currentStudent");
             } else {*/
            response.sendRedirect("../welcome.jsp");
            //RequestDispatcher dispatcher = request.getRequestDispatcher("../welcome.jsp");
            //dispatcher.forward(request, response);
            //}
        }/* else {
            session.setAttribute("currentStudent", currentStudent);
        }*/
    %>
    <!-- BEGIN BODY -->
    <body class="page-header-fixed page-footer-fixed" style="">

        <!-- BEGIN HEADER -->
        <jsp:include page="/inc/header.jsp" flush="true" />
        <!-- END HEADER -->


        <div class="clearfix"></div>
        <!-- BEGIN CONTAINER -->
        <div class="page-container">


            <!-- BEGIN PAGE -->
            <div class="page-content">

                <!-- BEGIN PAGE HEADER-->
                <div class="row">
                    <div class="col-md-12">
                        <jsp:include page="boardDetails.jsp" flush="true"/>
                    </div>
                </div>


                <div class="row">

                    <!-- TABS BEGIN -->
                    <div class="tabbable tabbable-custom">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab_1_1" data-toggle="tab">Postlar</a></li>
                            <li class=""><a href="#tab_1_2" data-toggle="tab">Takipçiler</a></li>
                            <li class=""><a href="#tab_1_3" data-toggle="tab">Etiketler</a></li>
                        </ul>
                        <div class="tab-content">

                            <!-- POST DIV BEGIN -->
                            <jsp:include page="homeTabPost.jsp" flush="true"/>
                            <!-- POST DIV END -->

                            <!-- FOLLOWER DIV BEGIN -->
                            <jsp:include page="homeTabBoardFollowers.jsp" flush="true"/>
                            <!-- FOLLOWER DIV END -->

                            <!-- TAGS DIV BEGIN -->
                            <jsp:include page="homeTabBoardTags.jsp" flush="true"/>
                            <!-- TAGS DIV END -->
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
        <jsp:include page="/inc/footer.jsp" flush="true" />
        <!-- END FOOTER -->
    </body>                                                      <!-- END BODY -->
</html>