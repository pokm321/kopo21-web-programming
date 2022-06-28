<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->
<html>
  <head>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();

      int id = Integer.parseInt(request.getParameter("id"));

      stmt.execute("USE kopoctc;");
      stmt.execute("DELETE FROM candidate_table WHERE id = " + id + ";");
      stmt.execute("DELETE FROM vote_table WHERE id = " + id + ";");
      stmt.close();
      conn.close();

      out.println("후보등록 결과 : 후보가 삭제되었습니다.");
    %>
  </head>

  <body>
    
  </body>
</html>
