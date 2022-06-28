<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->

<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();
    
      int id = Integer.parseInt(request.getParameter("id"));

      ResultSet rset = stmt.executeQuery("SELECT name FROM candidate_table WHERE id = " + id + ";");
    %>
  </head>
    
  <body>
    <%rset.next();%>
    <h1><%=id + ". " + rset.getString(1) + " 후보 득표성향 분석"%></h1>
    <table>
      <%
        for (int i = 1; i < 10; i++) { // 10대부터 90대까지 출력
          rset = stmt.executeQuery("SELECT age, count(age), (100 * count(age) / (SELECT count(*) FROM vote_table WHERE id = " + id + ")) FROM vote_table WHERE id = " + id + " AND age = " + i + " GROUP BY age;");

          int barlength = 0;
          rset.next();
          try {
            barlength = rset.getInt(3);
          } catch (SQLException e) { // 해당 age의 데이터가 없으면 출력
              out.println("<tr>");
              out.println("<td id='agetd'>" + i + "0대</td>");
              out.println("<td id='bartd'><span id='bar' style='width: " + (barlength * 6 + 5) + "px;'> </span>&nbsp &nbsp0(0%)</td>");
              out.println("</tr>");
              continue;
          }

          // 해당 age의 데이터가 있으면 출력
          out.println("<tr>");
          out.println("<td id='agetd'>" + rset.getInt(1) + "0대</td>");
          out.println("<td id='bartd'><span id='bar' style='width: " + (barlength * 6 + 5) + "px;'> </span>&nbsp &nbsp" + rset.getInt(2) + "(" + rset.getInt(3) + "%)</td>");
          out.println("</tr>");
        }
      %>
    </table>   
  </body>
</html>