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
import java.sql.Timestamp;

/**
 *
 * @author yetkin.timocin
 */
public class Tag {
    
    private int tagID;
    private String tag;
    private int timesSearched;
    private int creatorID;
    private int ownerID;
    private Timestamp insertDate;
    private Timestamp lastUsedDate;
    private double rating;
    private int tagType;
    private int status;
    // önemli: bir etiket kaç ayrı postta geçmiş //
    private int distinctPostCount;
    private int tagFollowerCount;
    private CallableStatement callStmt;
    
    public Tag getTagDetails(int tagID) throws InstantiationException, IllegalAccessException, SQLException {
        Tag tempTag = new Tag();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call behati.pkgTagOperations.getTagDetails(?)}");
            callStmt.registerOutParameter(1, java.sql.Types.OTHER);
            callStmt.setInt(2, tagID);
            callStmt.execute();
            rs = (ResultSet) callStmt.getObject(1);
            while (rs.next()) {
                tempTag.setTagID(rs.getInt("tagID"));
                tempTag.setTag(rs.getString("tag"));
                tempTag.setTimesSearched(rs.getInt("timesSearched"));
                tempTag.setCreatorID(rs.getInt("creatorID"));
                tempTag.setOwnerID(rs.getInt("creatorID"));
                tempTag.setInsertDate(rs.getTimestamp("tagPoolInsertDate"));
                tempTag.setLastUsedDate(rs.getTimestamp("lastUsedDate"));
                tempTag.setRating(rs.getDouble("rating"));
                tempTag.setTagType(rs.getInt("tagType"));
                tempTag.setStatus(rs.getInt("status"));
                tempTag.setDistinctPostCount(rs.getInt("tagOccurence"));
                tempTag.setTagFollowerCount(rs.getInt("tagFollowerCount"));
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callStmt);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return tempTag;
    }
    
    public int getTagID() {
        return tagID;
    }
    
    public void setTagID(int tagID) {
        this.tagID = tagID;
    }
    
    public String getTag() {
        return tag;
    }
    
    public void setTag(String tag) {
        this.tag = tag;
    }
    
    public int getTimesSearched() {
        return timesSearched;
    }
    
    public void setTimesSearched(int timesSearched) {
        this.timesSearched = timesSearched;
    }
    
    public int getCreatorID() {
        return creatorID;
    }
    
    public void setCreatorID(int creatorID) {
        this.creatorID = creatorID;
    }
    
    public Timestamp getInsertDate() {
        return insertDate;
    }
    
    public void setInsertDate(Timestamp insertDate) {
        this.insertDate = insertDate;
    }
    
    public Timestamp getLastUsedDate() {
        return lastUsedDate;
    }
    
    public void setLastUsedDate(Timestamp lastUsedDate) {
        this.lastUsedDate = lastUsedDate;
    }
    
    public double getRating() {
        return rating;
    }
    
    public void setRating(double rating) {
        this.rating = rating;
    }
    
    public int getTagType() {
        return tagType;
    }
    
    public void setTagType(int tagType) {
        this.tagType = tagType;
    }
    
    public int getStatus() {
        return status;
    }
    
    public void setStatus(int status) {
        this.status = status;
    }
    
    public int getOwnerID() {
        return ownerID;
    }
    
    public void setOwnerID(int ownerID) {
        this.ownerID = ownerID;
    }
    
    public int getDistinctPostCount() {
        return distinctPostCount;
    }
    
    public void setDistinctPostCount(int distinctPostCount) {
        this.distinctPostCount = distinctPostCount;
    }
    
    public int getTagFollowerCount() {
        return tagFollowerCount;
    }
    
    public void setTagFollowerCount(int followerCount) {
        this.tagFollowerCount = followerCount;
    }
}
