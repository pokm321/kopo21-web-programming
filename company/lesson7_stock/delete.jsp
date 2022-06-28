<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>

  <head>
    <% 
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();
    
      String id = request.getParameter("id");

      stmt.execute("DELETE FROM stocktable WHERE id=" + id + ";");

      stmt.close();
      conn.close();

      out.println("<script>alert('상품이 삭제되었습니다. 상품번호: " + id + "');location.href='list.jsp?from=0&cnt=20';</script>");
    %>
  </head>

  <body>

  </body>
</html>