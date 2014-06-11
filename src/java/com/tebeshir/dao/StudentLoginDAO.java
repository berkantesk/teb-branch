/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.dao;

import com.tebeshir.classes.School;
import com.tebeshir.classes.Student;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class StudentLoginDAO {

    private CallableStatement callStmt;

    public int login(String userName, String password) throws InstantiationException, IllegalAccessException, SQLException {
        int result = 0;
        PostgresConnection pgConn = new PostgresConnection();
        Connection dbConn = PostgresConnection.getConnection();
        try {
            callStmt = dbConn.prepareCall("{? = call doutzen.pkgStudentAuthentication.studentLogin(?, ?)}");
            callStmt.registerOutParameter(1, java.sql.Types.NUMERIC);
            callStmt.setString(2, userName);
            callStmt.setString(3, password);
            callStmt.execute();
            result = callStmt.getBigDecimal(1).intValue();
            callStmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            PostgresConnection.closeConnection(dbConn);
            callStmt.close();
        }
        return result;
    }
}
