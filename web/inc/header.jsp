<%-- 
    Document   : header
    Created on : Jun 12, 2014, 8:12:27 PM
    Author     : berkanteskicioglu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="header navbar navbar-inverse navbar-fixed-top">

            <!-- BEGIN TOP NAVIGATION BAR -->
            <div class="header-inner">

                <!-- BEGIN LOGO -->  
                <a class="navbar-brand" style="margin-left: 160px" href="/">
                    <img src="/images/logo.png" alt="logo" class="img-responsive">
                </a>
                <!-- END LOGO -->

                <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                <a href="javascript:;" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <img src="/images/menu-toggler.png" alt="">
                </a> 
                <!-- END RESPONSIVE MENU TOGGLER -->


                <!-- BEGIN TOP NAVIGATION MENU -->
                <ul class="nav navbar-nav pull-right" style="margin-right: 150px">

                    <!-- BEGIN NOTIFICATION DROPDOWN -->
                    <li class="dropdown" id="header_notification_bar">                        
                        <jsp:include page="/home/notificationDropDown.jsp" flush="true"/>
                    </li>
                    <!-- END NOTIFICATION DROPDOWN -->


                    <!-- BEGIN INBOX DROPDOWN -->
                    <li class="dropdown" id="header_inbox_bar">
                        <jsp:include page="/home/inboxDropDown.jsp" flush="true"/>                        
                    </li>
                    <!-- END INBOX DROPDOWN -->


                    <!-- BEGIN USER DROPDOWN -->
                    <li class="dropdown user">
                        <jsp:include page="/home/profileDropDown.jsp" flush="true"/>
                    </li>
                    <!-- END USER DROPDOWN -->                    

                </ul>
                <!-- END TOP NAVIGATION MENU -->
            </div>
            <!-- END TOP NAVIGATION BAR -->
        </div>
