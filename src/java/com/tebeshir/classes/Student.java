/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.classes;

import com.tebeshir.dao.PostgresConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class Student {

    private int studentID;
    private String username;
    private String mail;
    private String password;
    private int schoolID;
    private int status;
    private Date registrationDate;
    private Vector<Post> posts;
    private CallableStatement callStmt;

    public Student getStudentDetailsByLoginCredentials(String loginCredential) throws InstantiationException, IllegalAccessException, SQLException {
        Student tempStudent = new Student();
        Connection dbConn = PostgresConnection.getConnection();
        ResultSet rs = null;
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call doutzen.pkgStudentOperations.getStudentDetails(?)}");
            callStmt.registerOutParameter(1, java.sql.Types.OTHER);
            callStmt.setString(2, loginCredential);
            callStmt.execute();
            rs = (ResultSet) callStmt.getObject(1);
            try {
                while (rs.next()) {
                    tempStudent.setStudentID(rs.getInt("studentID"));
                    tempStudent.setUsername(rs.getString("userName"));
                    tempStudent.setMail(rs.getString("eMail"));
                    tempStudent.setSchoolID(rs.getInt("school"));
                    tempStudent.setStatus(rs.getInt("status"));
                    tempStudent.setRegistrationDate(rs.getDate("registrationDate"));
                }
                dbConn.commit();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            rs.close();
            callStmt.close();
            PostgresConnection.closeConnection(dbConn);
        }
        return tempStudent;
    }

    public Student getStudentById(int studentID) throws InstantiationException, IllegalAccessException, SQLException {
        Student tempStudent = new Student();
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call doutzen.pkgStudentOperations.getStudentDetailsByID(?)}");
            callStmt.registerOutParameter(1, java.sql.Types.OTHER);
            callStmt.setInt(2, studentID);
            callStmt.execute();
            ResultSet rs = (ResultSet) callStmt.getObject(1);
            try {
                while (rs.next()) {
                    tempStudent.setStudentID(rs.getInt("studentID"));
                    tempStudent.setUsername(rs.getString("userName"));
                    tempStudent.setMail(rs.getString("eMail"));
                    tempStudent.setSchoolID(rs.getInt("school"));
                    tempStudent.setStatus(rs.getInt("status"));
                    tempStudent.setRegistrationDate(rs.getDate("registrationDate"));
                }
                dbConn.commit();
            } catch (Exception ex) {
                ex.printStackTrace();
            } finally {
                rs.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            callStmt.close();
            PostgresConnection.closeConnection(dbConn);
        }
        return tempStudent;
    }

    public Vector<Post> getStudentPosts(int studentID) throws InstantiationException, IllegalAccessException, SQLException {
        Vector<Post> studentPosts = new Vector<Post>();
        PostTag tempPostTag = new PostTag();
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call behati.pkgPostOperations.allMessagesOfAStudent(?)}");
            callStmt.registerOutParameter(1, java.sql.Types.OTHER);
            callStmt.setInt(2, studentID);
            callStmt.execute();
            ResultSet rs = (ResultSet) callStmt.getObject(1);
            try {
                while (rs.next()) {
                    Post tempPost = new Post();
                    tempPost.setPostID(rs.getInt("postID"));
                    tempPost.setStudentID(rs.getInt("studentID"));
                    tempPost.setMainBoardID(rs.getInt("mainBoardID"));
                    tempPost.setOriginalMessage(rs.getString("originalMessage"));
                    tempPost.setInsertDate(rs.getTimestamp("insertDate"));
                    tempPost.setStatus(rs.getInt("status"));
                    tempPost.setPostTags(tempPostTag.getTagsOfThisPost(tempPost.getPostID()));
                    studentPosts.add(tempPost);
                }
                dbConn.commit();
            } catch (Exception ex) {
                ex.printStackTrace();
            } finally {
                rs.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            callStmt.close();
            PostgresConnection.closeConnection(dbConn);
        }
        return studentPosts;
    }

    public Vector<String> getStudentActivities(int studentID) throws InstantiationException, IllegalAccessException, SQLException {
        Vector<String> studentActivities = new Vector<String>();
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call doutzen.pkgStudentOperations.getStudentActivities(?)}");
            callStmt.registerOutParameter(1, java.sql.Types.OTHER);
            callStmt.setInt(2, studentID);
            callStmt.execute();
            ResultSet rs = (ResultSet) callStmt.getObject(1);
            try {
                while (rs.next()) {
                    StudentActivity tempStudentActivity = new StudentActivity();
                    tempStudentActivity.setActivityID(rs.getInt("activity_id"));
                    tempStudentActivity.setStudentID(rs.getInt("student_id"));
                    tempStudentActivity.setActivityTime(rs.getDate("activity_time"));
                    tempStudentActivity.setActivityType(rs.getInt("activity_type"));
                    tempStudentActivity.setObjectID(rs.getInt("object_id"));
                    String result = tempStudentActivity.toString();
                    studentActivities.add(result);
                }
                dbConn.commit();
            } catch (Exception ex) {
                ex.printStackTrace();
            } finally {
                rs.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            callStmt.close();
            PostgresConnection.closeConnection(dbConn);
        }
        return studentActivities;
    }

    public boolean amIFollowingThisTag(int tagID, int studentID) throws InstantiationException, IllegalAccessException, SQLException {
        boolean result = false;
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call behati.pkgTagOperations.isUserFollowingThisTag(?, ?)}");
            callStmt.registerOutParameter(1, java.sql.Types.NUMERIC);
            callStmt.setInt(2, tagID);
            callStmt.setInt(3, studentID);
            callStmt.execute();
            result = (callStmt.getBigDecimal(1).intValue() == 0) ? true : false;
            dbConn.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            callStmt.close();
            PostgresConnection.closeConnection(dbConn);
        }
        return result;
    }

    public boolean amIFollowingThisPost(int postID) throws InstantiationException, IllegalAccessException, SQLException {
        boolean result = false;
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call behati.pkgPostOperations.isUserFollowingThisPost(?, ?)}");
            callStmt.registerOutParameter(1, java.sql.Types.NUMERIC);
            callStmt.setInt(2, postID);
            callStmt.setInt(3, this.studentID);
            callStmt.execute();
            result = (callStmt.getBigDecimal(1).intValue() == 0) ? true : false;
            dbConn.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            callStmt.close();
            PostgresConnection.closeConnection(dbConn);
        }
        return result;
    }

    public boolean didILikeThisPost(int postID) throws InstantiationException, IllegalAccessException, SQLException {
        boolean result = false;
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call behati.pkgPostOperations.didUserLikeThisPost(?, ?)}");
            callStmt.registerOutParameter(1, java.sql.Types.NUMERIC);
            callStmt.setInt(2, postID);
            callStmt.setInt(3, this.studentID);
            callStmt.execute();
            result = (callStmt.getBigDecimal(1).intValue() == 0) ? true : false;
            dbConn.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            callStmt.close();
            PostgresConnection.closeConnection(dbConn);
        }
        return result;
    }

    public static void main(String args[]) throws InstantiationException, IllegalAccessException, SQLException {
        Student tempStudent = new Student();
        boolean result = tempStudent.amIFollowingThisTag(1, 1);
        System.out.println("result: " + result);
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    public int getSchoolID() {
        return schoolID;
    }

    public void setSchoolID(int schoolID) {
        this.schoolID = schoolID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Vector<Post> getPosts() {
        return posts;
    }

    public void setPosts(Vector<Post> posts) {
        this.posts = posts;
    }
}
