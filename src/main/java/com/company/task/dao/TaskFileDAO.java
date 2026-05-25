package com.company.task.dao;

import com.company.task.util.DBUtil;
import java.sql.*;

public class TaskFileDAO {
    public void insertFile(int idTask, String tenGoc, String tenLuu, String duongDan, long dungLuong, String loai, String manv, String tennv) throws Exception {
        Connection c = DBUtil.getConnection();
        CallableStatement cs = c.prepareCall("{call sp_task_insert_file(?,?,?,?,?,?,?,?)}");
        cs.setInt(1,idTask);cs.setString(2,tenGoc);cs.setString(3,tenLuu);cs.setString(4,duongDan);cs.setLong(5,dungLuong);cs.setString(6,loai);cs.setString(7,manv);cs.setString(8,tennv);
        cs.execute(); cs.close(); c.close();
    }
}
