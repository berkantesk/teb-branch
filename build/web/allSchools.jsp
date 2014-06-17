
<%@page import="com.tebeshir.classes.School"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%
    School newSchool = new School();
    Vector<School> allSchools = newSchool.getAllActiveSchools();

    String schoolQuery = request.getParameter("q");

    List<String> schools = null;
    String schoolName = null;
    for (int i = 0; i < allSchools.size(); i++) {
        schoolName = allSchools.get(i).getSchoolName();
        if (schoolName.toLowerCase().contains(schoolQuery.toLowerCase())) {
            out.println(schoolName);
        }
    }
%>
