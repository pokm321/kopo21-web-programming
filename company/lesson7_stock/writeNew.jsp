<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration" %>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<html>

  <head>
    <% 
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();
    
      String id = "";
      String originalFilename = "";
      try {        
        int size = 1024 * 1024 * 20;
        String path = request.getRealPath("/");
        MultipartRequest multiRequest = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
        originalFilename = multiRequest.getOriginalFileName((String)multiRequest.getFileNames().nextElement());

        id = multiRequest.getParameter("id");
        String number = multiRequest.getParameter("number");
        String name = multiRequest.getParameter("name");
        String date = multiRequest.getParameter("date");
        String content = multiRequest.getParameter("content");

        ResultSet rset = stmt.executeQuery("SELECT count(*) FROM stocktable WHERE id=" + id + ";");
        rset.next();
        if (rset.getInt(1) != 0) {
          out.println("<script>alert('이미 존재하는 상품 번호입니다.');location.href='detail.jsp?id=" + id + "';</script>");
          rset.close();
          return;
        }
        rset.close();

        if (name.length() == 0 || content.length() == 0 || originalFilename.length() == 0) {
          out.println("<script>alert('빈칸이 존재합니다..');history.back();</script>");
          stmt.close();
          conn.close();
          return;
        }

        stmt.execute("INSERT INTO stocktable VALUES(" + id + ", '" + name + "', " + number + ", date(now()), date(now()), '" + content + "', '../../" + originalFilename + "');");
        out.println("<script>alert('상품이 등록되었습니다.');location.href='detail.jsp?id=" + id + "';</script>");
      } catch (Exception e) {
        out.println("<script>alert('" + id + "');location.href='detail.jsp?id=" + id + "';</script>");
      }


      stmt.close();
      conn.close();
    %>
  </head>

  <body>
    
  </body>
</html>