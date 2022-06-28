
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>

<html>
  <head>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();
    %>
  </head>

  <body>
    <%
      try {
        stmt.execute("drop table stocktable;");
        out.println("drop table stocktable OK<br><br>");
      } catch (Exception e) {
        out.println("drop table stocktable NOT OK<br>");
        out.println(e.toString() + "<br><br>");
      }
    %>

    <%
      stmt.execute("CREATE TABLE stocktable(id INT NOT NULL PRIMARY KEY, name VARCHAR(40), number INT, update_date DATE, post_date DATE, detail VARCHAR(200), picture_path VARCHAR(400)) DEFAULT CHARSET=UTF8;");

      for (int i = 1; i < 20; i++) {
        stmt.execute("INSERT INTO stocktable VALUES(" + (122122 + 5*i) + ", '바나나" + i + "', 10, '2017-06-10', '2017-06-10', '알래스카산 바나나로 맘모스의 아침식사', '../../banana.jpg');");
        stmt.execute("INSERT INTO stocktable VALUES(" + (122123 + 5*i) + ", '딸기" + i + "', 10, '2017-06-10', '2017-06-10', '알래스카산 딸기로 맘모스의 점심식사', '../../strawberry.jpg');");
        stmt.execute("INSERT INTO stocktable VALUES(" + (122124 + 5*i) + ", '사과" + i + "', 12, '2017-06-11', '2017-06-11', '알래스카산 사과로 맘모스의 점심식사', '../../apple.jpg');");
        stmt.execute("INSERT INTO stocktable VALUES(" + (122125 + 5*i) + ", '배" + i + "', 14, '2020-12-18', '2020-12-15', '알래스카산 배로 맘모스의 저녁식사', '../../pear.jpg');");
        stmt.execute("INSERT INTO stocktable VALUES(" + (122126 + 5*i) + ", '참외" + i + "', 15, '2022-03-11', '2020-12-16', '여주산 참외로 맘모스의 저녁식사', '../../kmelon.jpg');");
      }


      out.println("<script>alert('리스트가 초기화되었습니다.');location.href='list.jsp?from=0&cnt=20';</script>");
      
      stmt.close();
      conn.close();
    %>
  </body>
</html>
