package com.company.task.servlet;
import jakarta.servlet.*;import jakarta.servlet.annotation.WebServlet;import jakarta.servlet.http.*;import java.io.IOException;
@WebServlet("/task/create") public class TaskCreateServlet extends HttpServlet { protected void doGet(HttpServletRequest req,HttpServletResponse resp) throws ServletException,IOException { req.getRequestDispatcher("/WEB-INF/views/task/task_form.jsp").forward(req,resp);} }
