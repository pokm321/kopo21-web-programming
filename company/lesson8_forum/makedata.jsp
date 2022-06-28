
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>

<html>
  <head>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();

      stmt.execute("SET time_zone='+09:00';");
    %>
  </head>

  <body>
    <%
      stmt.execute("DROP TABLE IF EXISTS forum;");
      stmt.execute("CREATE TABLE forum(id int not null primary key auto_increment, title varchar(70), date date, content text, rootid INT, reply_level INT, reply_order INT, viewcount INT) DEFAULT CHARSET=UTF8;");

      for (int i = 1; i < 50; i++) {
        stmt.execute("INSERT INTO forum(title, date, content, rootid, reply_level, reply_order, viewcount) VALUES('공지사항" + i + "', date(now()), '공지사항내용 " + i + " 입니다.', " + i + ", 0, 0, 0);");
      }
      stmt.execute("INSERT INTO forum(title, date, content, rootid, reply_level, reply_order, viewcount) VALUES('댓글1', date(now()), '댓글내용1', 45, 1, 0, 0);");
      stmt.execute("INSERT INTO forum(title, date, content, rootid, reply_level, reply_order, viewcount) VALUES('댓글2', date(now()), '댓글내용2', 45, 1, 1, 0);");
      stmt.execute("INSERT INTO forum(title, date, content, rootid, reply_level, reply_order, viewcount) VALUES('대댓글1', date(now()), '대댓글내용1', 45, 2, 0, 0);");

      out.println("<script>alert('초기화되었습니다.');location.href='forum_list.jsp?from=0&cnt=20';</script>");
      
      stmt.close();
      conn.close();
    %>
  </body>
</html>
