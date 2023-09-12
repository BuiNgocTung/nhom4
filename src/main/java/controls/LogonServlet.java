package controls;

import daos.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;
import vn.edu.iuh.fit.week1.HelloServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/logon"})
public class LogonServlet extends HelloServlet {
    private UserDAO dao;



    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter out = resp.getWriter();
            HttpSession session= req.getSession(true);
            dao = new UserDAO(session);

            String us = req.getParameter("userName");

            String psd =req.getParameter("mk");
            boolean kq = dao.logon(us,psd);
            if(!kq){
                out.println("<h1>Invalid Username or Password!");
            }
            else {
               Object obj = session.getAttribute("ds");
               if (obj ==null){
                   User user = (User) session.getAttribute("us");
                   out.println(user);
               }
               else{
                   List<User> list = (ArrayList<User>) obj;
                   list.forEach(out::println);
               }
            }
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }
}
