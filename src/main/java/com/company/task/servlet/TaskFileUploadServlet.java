package com.company.task.servlet;

import com.company.task.dao.TaskFileDAO;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;import java.io.IOException;import java.nio.file.Paths;import java.util.*;

@WebServlet("/task/file/upload")
@MultipartConfig(fileSizeThreshold=1024*1024,maxFileSize=20*1024*1024,maxRequestSize=100*1024*1024)
public class TaskFileUploadServlet extends HttpServlet {
 protected void doPost(HttpServletRequest req,HttpServletResponse resp) throws IOException {
  resp.setContentType("application/json;charset=UTF-8");
  try {
   int idTask=Integer.parseInt(req.getParameter("id_task")); String manv=req.getParameter("manv"); String tennv=req.getParameter("tennv");
   String base=getServletContext().getRealPath("/uploads/tasks/"+idTask); File dir=new File(base); if(!dir.exists()) dir.mkdirs();
   Set<String> allow=new HashSet<>(Arrays.asList("pdf","doc","docx","xls","xlsx","png","jpg","jpeg","zip"));
   TaskFileDAO dao=new TaskFileDAO();
   for(Part p:req.getParts()){
    String fn=Paths.get(p.getSubmittedFileName()==null?"":p.getSubmittedFileName()).getFileName().toString(); if(fn.isEmpty()) continue;
    String ext=fn.contains(".")?fn.substring(fn.lastIndexOf('.')+1).toLowerCase():""; if(!allow.contains(ext)) continue;
    String save=UUID.randomUUID().toString()+"_"+fn; p.write(base+File.separator+save);
    dao.insertFile(idTask,fn,save,"uploads/tasks/"+idTask+"/"+save,p.getSize(),p.getContentType(),manv,tennv);
   }
   resp.getWriter().write("{\"success\":true}");
  } catch(Exception e){ resp.getWriter().write("{\"success\":false,\"message\":\""+e.getMessage()+"\"}"); }
 }
}
