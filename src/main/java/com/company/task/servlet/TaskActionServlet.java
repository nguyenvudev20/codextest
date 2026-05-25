package com.company.task.servlet;
import com.company.task.dao.TaskDAO;
import jakarta.servlet.annotation.WebServlet;import jakarta.servlet.http.*;import java.io.IOException;
@WebServlet("/task/action") public class TaskActionServlet extends HttpServlet { protected void doPost(HttpServletRequest req,HttpServletResponse resp) throws IOException { resp.setContentType("application/json;charset=UTF-8"); try { new TaskDAO().changeStatus(Integer.parseInt(req.getParameter("id_task")),req.getParameter("action"),req.getParameter("manv"),req.getParameter("tennv"),req.getParameter("note")); resp.getWriter().write("{\"success\":true}"); } catch(Exception e){ resp.getWriter().write("{\"success\":false,\"message\":\""+e.getMessage()+"\"}"); } } }
