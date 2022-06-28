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
        String name = request.getParameter("name");

        if (name.length() == 0) {
          id = Integer.parseInt(request.getParameter("name"));
        }

        stmt.execute("USE kopoctc;");
        stmt.execute("INSERT INTO candidate_table VALUES(" + id + ", '" + name + "');");

        out.println("후보등록 결과 : 후보가 추가되었습니다.");

      } catch (NumberFormatException e) {
        out.println("<script>alert('빈칸이 존재합니다. 다시 시도해주세요.');location.href='A_01.jsp';</script>");
      } catch (SQLIntegrityConstraintViolationException e) {
        out.println("<script>alert('이미 존재하는 후보번호입니다. 다른 번호를 선택해주세요.');location.href='A_01.jsp';</script>");
      }

      stmt.close();
      conn.close();
    %>
  </head>

  <body>
    
  </body>
</html>