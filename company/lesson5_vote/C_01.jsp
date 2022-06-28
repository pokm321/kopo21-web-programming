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

      // 후보번호, 이름, 득표수, 득표율 순서로 출력하기 (득표수 0인 후보 포함)
      ResultSet rset = stmt.executeQuery("SELECT a.id, a.name, count(b.id), (100 * count(b.id) / (SELECT count(*) FROM vote_table)) FROM candidate_table as a LEFT OUTER JOIN(SELECT * FROM vote_table) as b ON a.id = b.id GROUP BY a.id ORDER BY a.id;");
    %>
  </head>

  <body>
    <h1>후보 별 득표율2</h1>
    <table>
      <%
      while (rset.next()) {
        int barlength = rset.getInt(4);

        out.println("<tr>");
        out.println("<td id='nametd'><a id='button2' href='C_02.jsp?id=" + rset.getInt(1) + "'>" + rset.getInt(1) + " " + rset.getString(2) + "</a></td>");
        out.println("<td id='bartd'><span id='bar' style='width: " + (barlength * 5 + 5) + "px;'> </span>&nbsp &nbsp" + rset.getInt(3) + "(" + rset.getInt(4) + "%)</td>");
        out.println("</tr>");
      }
      %>
    </table>
  </body>
</html>