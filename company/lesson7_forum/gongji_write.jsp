<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.ArrayList" %>
<html>
  <head>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();

      String id = new String(request.getParameter("id").getBytes("8859_1"), "UTF-8");
      String title = new String(request.getParameter("title").getBytes("8859_1"), "UTF-8");
      String content = new String(request.getParameter("content").getBytes("8859_1"), "UTF-8");

      if (title.length() == 0) {
        title = "&nbsp";
      }

      if (id.equals("insert")) {
        stmt.execute("INSERT INTO gongji(title, date, content) VALUES('" + title + "', date(now()), '" + content + "');");
        out.println("<script>alert('게시글을 작성했습니다.');location.href='gongji_list.jsp';</script>");
      } else {
        stmt.execute("UPDATE gongji SET title='" + title + "', content='" + content + "' WHERE id=" + id + ";");
        out.println("<script>alert('" + id + "번 게시글을 수정했습니다.');location.href='gongji_list.jsp';</script>");
      }

      stmt.close();
      conn.close();

    %>
  </head>

  <body>
  </body>
</html>