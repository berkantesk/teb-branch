/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.classes;

import com.tebeshir.dao.PostgresConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.Vector;

/**
 *
 * @author yetkin.timocin
 */
public class Post {

    private int postID;
    private int studentID;
    private int mainBoardID;
    private String originalMessage;
    private Timestamp insertDate;
    private int status;
    private Vector<PostTag> postTags;
    private int likerCount;
    private int commenterCount;
    private int followerCount;
    private CallableStatement callStmt;

    public Vector<Post> getAllMessagesOfThisBoard(int boardID) throws InstantiationException, IllegalAccessException, SQLException {
        Vector<Post> allMessages = new Vector<Post>();
        PostTag tempPostTag = new PostTag();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call behati.pkgPostOperations.allMessagesOfThisBoard(?)}");
            callStmt.registerOutParameter(1, java.sql.Types.OTHER);
            callStmt.setInt(2, boardID);
            callStmt.execute();
            rs = (ResultSet) callStmt.getObject(1);
            while (rs.next()) {
                Post tempPost = new Post();
                tempPost.setPostID(rs.getInt("postID"));
                tempPost.setStudentID(rs.getInt("studentID"));
                tempPost.setMainBoardID(rs.getInt("mainBoardID"));
                tempPost.setOriginalMessage(rs.getString("originalMessage"));
                tempPost.setInsertDate(rs.getTimestamp("insertDate"));
                tempPost.setStatus(rs.getInt("status"));
                tempPost.setPostTags(tempPostTag.getTagsOfThisPost(tempPost.postID));
                tempPost.setLikerCount(rs.getInt("postLikerCount"));
                tempPost.setFollowerCount(rs.getInt("postFollowerCount"));
                allMessages.add(tempPost);
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callStmt);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return allMessages;
    }
    
    public Post getPostDetailsByID(int postID) throws InstantiationException, IllegalAccessException, SQLException {
        Post returnPost = new Post();
        PostTag tempPostTag = new PostTag();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call behati.pkgPostOperations.getPostDetailsByID(?)}");
            callStmt.registerOutParameter(1, java.sql.Types.OTHER);
            callStmt.setInt(2, postID);
            callStmt.execute();
            rs = (ResultSet) callStmt.getObject(1);
            while (rs.next()) {
                returnPost.setPostID(rs.getInt("postID"));
                returnPost.setStudentID(rs.getInt("studentID"));
                returnPost.setMainBoardID(rs.getInt("mainBoardID"));
                returnPost.setOriginalMessage(rs.getString("originalMessage"));
                returnPost.setInsertDate(rs.getTimestamp("insertDate"));
                returnPost.setStatus(rs.getInt("status"));
                returnPost.setPostTags(tempPostTag.getTagsOfThisPost(returnPost.postID));
                returnPost.setLikerCount(rs.getInt("postLikerCount"));
                returnPost.setFollowerCount(rs.getInt("postFollowerCount"));
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callStmt);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return returnPost;
    }

    public Vector<Post> getAllMessagesOfThisBoardWithFilter(int boardID, int tagID) throws InstantiationException, IllegalAccessException, SQLException {
        Vector<Post> allMessages = new Vector<Post>();
        PostTag tempPostTag = new PostTag();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();

        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call behati.pkgPostOperations.allMessagesOfThisBoardWithFilter(?, ?)}");
            callStmt.registerOutParameter(1, java.sql.Types.OTHER);
            callStmt.setInt(2, boardID);
            callStmt.setInt(3, tagID);
            callStmt.execute();
            rs = (ResultSet) callStmt.getObject(1);
            while (rs.next()) {
                Post tempPost = new Post();
                tempPost.setPostID(rs.getInt("postID"));
                tempPost.setStudentID(rs.getInt("studentID"));
                tempPost.setMainBoardID(rs.getInt("mainBoardID"));
                tempPost.setOriginalMessage(rs.getString("originalMessage"));
                tempPost.setInsertDate(rs.getTimestamp("insertDate"));
                tempPost.setStatus(rs.getInt("status"));
                tempPost.setPostTags(tempPostTag.getTagsOfThisPost(tempPost.postID));
                allMessages.add(tempPost);
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callStmt);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return allMessages;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public int getMainBoardID() {
        return mainBoardID;
    }

    public void setMainBoardID(int mainBoardID) {
        this.mainBoardID = mainBoardID;
    }

    public String getOriginalMessage() {
        return originalMessage;
    }

    public void setOriginalMessage(String originalMessage) {
        this.originalMessage = originalMessage;
    }

    public Timestamp getInsertDate() {
        return insertDate;
    }

    public void setInsertDate(Timestamp insertDate) {
        this.insertDate = insertDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Vector<PostTag> getPostTags() {
        return postTags;
    }

    public void setPostTags(Vector<PostTag> postTags) {
        this.postTags = postTags;
    }

    public int getLikerCount() {
        return likerCount;
    }

    public void setLikerCount(int likeCount) {
        this.likerCount = likeCount;
    }

    public int getCommenterCount() {
        return commenterCount;
    }

    public void setCommenterCount(int commentCount) {
        this.commenterCount = commentCount;
    }

    public int getFollowerCount() {
        return followerCount;
    }

    public void setFollowerCount(int followerCount) {
        this.followerCount = followerCount;
    }
}
