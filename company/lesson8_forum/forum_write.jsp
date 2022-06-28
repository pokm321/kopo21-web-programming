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

      if (title.trim().length() == 0) {
        out.println("<script>alert('제목을 입력해주세요.');history.back();</script>");
        return;
      }

      if (id.equals("insert")) {
        stmt.execute("INSERT INTO forum(title, date, content, rootid, reply_level, reply_order, viewcount) SELECT '" + title + "', date(now()), '" + content + "', MAX(rootid) + 1, 0, 0, 0 FROM forum;");
        out.println("<script>alert('게시글을 작성했습니다.');location.href='forum_list.jsp?from=0&cnt=20';</script>");
      } else if (id.equals("insert_re")) {
        String rootid = new String(request.getParameter("rootid").getBytes("8859_1"), "UTF-8");
        String replyLevel = new String(request.getParameter("reply_level").getBytes("8859_1"), "UTF-8");
        
        stmt.execute("INSERT INTO forum(title, date, content, rootid, reply_level, reply_order, viewcount) SELECT '" + title + "', date(now()), '" + content + "', " + rootid + ", " + replyLevel + ", IFNULL(MAX(reply_order) + 1, 0), 0 FROM forum WHERE rootid = " + rootid + " AND reply_level = " + replyLevel + ";");
        out.println("<script>alert('게시글을 작성했습니다.');location.href='forum_list.jsp?from=0&cnt=20';</script>");
      } else {
        stmt.execute("UPDATE forum SET title='" + title + "', content='" + content + "' WHERE id=" + id + ";");
        out.println("<script>alert('" + id + "번 게시글을 수정했습니다.');location.href='forum_list.jsp?from=0&cnt=20';</script>");
      }

      stmt.close();
      conn.close();

    %>
  </head>

  <body>
  </body>
</html>