<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.ArrayList" %>
<html>
  <head>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();

      String id = request.getParameter("id");

      stmt.execute("DELETE FROM forum WHERE id=" + id + ";");

      stmt.close();
      conn.close();

      out.println("<script>alert('" + id + "번 게시글이 삭제되었습니다.');location.href='forum_list.jsp?from=0&cnt=20';</script>");
    %>
  </head>

  <body>
  </body>
</html>