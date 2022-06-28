<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>

  <head>
    <% 
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();
    
      String type = request.getParameter("type");
      String id = "";
      String number = "";
      try {
        id = request.getParameter("id");
        number = request.getParameter("number");
        stmt.execute("UPDATE stocktable SET number=" + number + ", update_date=date(now()) WHERE id=" + id + ";");
        out.println("<script>alert('재고가 수정되었습니다.');location.href='detail.jsp?id=" + id + "';</script>");
      } catch (Exception e) {
        out.println("<script>alert('재고 수량을 입력하세요.');location.href='update.jsp?id=" + id + "';</script>");
      }

      stmt.close();
      conn.close();
    %>
  </head>

  <body>
    
  </body>
</html>