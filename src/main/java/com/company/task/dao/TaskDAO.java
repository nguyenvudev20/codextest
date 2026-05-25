package com.company.task.dao;

import com.company.task.util.DBUtil;
import java.sql.*;

public class TaskDAO {
    public ResultSet dashboard(int thang, int nam) throws Exception {
        Connection c = DBUtil.getConnection();
        CallableStatement cs = c.prepareCall("{call sp_task_dashboard_summary(?,?)}");
        cs.setInt(1, thang); cs.setInt(2, nam);
        return cs.executeQuery();
    }
    public void changeStatus(int idTask, String action, String manv, String tennv, String note) throws Exception {
        Connection c = DBUtil.getConnection();
        CallableStatement cs;
        if ("accept".equals(action)) cs = c.prepareCall("{call sp_task_employee_accept(?,?,?)}");
        else if ("submit".equals(action)) { cs = c.prepareCall("{call sp_task_submit_review(?,?,?,?)}"); cs.setString(4, note); }
        else return;
        cs.setInt(1, idTask); cs.setString(2, manv); cs.setString(3, tennv); cs.execute();
        cs.close(); c.close();
    }
}
