<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<html>
  <head></head>

  <body>
    <!-- DB에 접근해서 카운트를 하나올리고 조회 -->
    <h1><center>JSP Databse 실습 1</center></h1><br><br><br>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21"); 
      Statement stmt = conn.createStatement();

      stmt.execute("USE kopoctc;"); // DB선택
      stmt.execute("UPDATE counttable SET count = count + 1;"); // 카운트 하나 올리기
      ResultSet rset = stmt.executeQuery("SELECT * FROM counttable;"); // 카운트 조회

      while (rset.next()) {
        out.println("<p id='count'>현재 홈페이지 방문 조회수는 <b>[" + rset.getInt(1) + "]</b> 입니다.</p>");
      }
    %>
  </body>
</html>