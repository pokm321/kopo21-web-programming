<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->

<html>
  <head>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();
    
      try {
      int id = Integer.parseInt(request.getParameter("id"));
      int age = Integer.parseInt(request.getParameter("age"));

      stmt.execute("INSERT INTO vote_table VALUES(" + id + ", '" + age + "');");

      out.println("투표 결과 : " + id + "번에 투표하였습니다.");
      out.println("<br><br>");
      out.println("나이 : " + age + "0대");
      } catch (NumberFormatException e) { // 후보가 하나도 없을경우
          out.println("<script>alert('후보가 존재하지 않습니다.');location.href='B_01.jsp';</script>");
        }
    %>
  </head>

  <body>

  </body>
</html>