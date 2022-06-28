
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>

<html>
  <head>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();

      stmt.execute("USE kopoctc;");
    %>
  </head>

  <body>
    <%
      stmt.execute("DROP TABLE IF EXISTS gongji;");
      stmt.execute("CREATE TABLE gongji(id int not null primary key auto_increment, title varchar(70), date date, content text) DEFAULT CHARSET=UTF8;");

      stmt.execute("INSERT INTO gongji(title, date, content) VALUES('공지사항1', date(now()), '공지사항내용1');");
      stmt.execute("INSERT INTO gongji(title, date, content) VALUES('공지사항2', date(now()), '공지사항내용2');");
      stmt.execute("INSERT INTO gongji(title, date, content) VALUES('공지사항3', date(now()), '공지사항내용3');");
      stmt.execute("INSERT INTO gongji(title, date, content) VALUES('공지사항4', date(now()), '공지사항내용4');");
      stmt.execute("INSERT INTO gongji(title, date, content) VALUES('공지사항5', date(now()), '공지사항내용5');");

      out.println("<script>alert('초기화되었습니다.');location.href='gongji_list.jsp';</script>");
      
      stmt.close();
      conn.close();
    %>
  </body>
</html>
