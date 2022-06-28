<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->

<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();
    
      stmt.execute("USE kopoctc;");
      ResultSet rset = stmt.executeQuery("SELECT * FROM candidate_table;");
    %>
  </head>

  <body>
    <p>
      <form action="B_02.jsp">
      <select name="id">
        <%
          while (rset.next()) {
            out.println("<option value='" + rset.getInt(1) + "'>" + rset.getInt(1) + "번 " + rset.getString(2) + "</option>");
          }
        %>
      </select>
      <select name="age">
        <%
          for (int i = 1; i < 10; i++) {
            out.println("<option value='" + i + "'>" + i + "0대</option>");
          }
        %>
      </select>
      <input id="button" type="submit" value="투표하기">
    </form>
    </p>
  </body>
</html>