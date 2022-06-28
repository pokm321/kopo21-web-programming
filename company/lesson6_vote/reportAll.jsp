<?xml version="1.0" encoding="UTF-8"?> <!-- xml파일로 만들겠다 -->
<%@ page contentType="text/xml; charset=utf-8" %> <!-- xml파일로 만들겠다 -->
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%
  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
  Statement stmt = conn.createStatement();

  stmt.execute("USE kopoctc;");

  // 후보번호, 이름, 득표수, 득표율 순서로 출력하기 (득표수 0인 후보 포함)
  ResultSet rset = stmt.executeQuery("SELECT a.id, a.name, count(b.id), (100 * count(b.id) / (SELECT count(*) FROM vote_table)) FROM candidate_table as a LEFT OUTER JOIN(SELECT * FROM vote_table) as b ON a.id = b.id GROUP BY a.id ORDER BY a.id;");

  // DB의 examtable에서 데이터를 뽑아서 xml형식으로 출력하기
  out.println("<datas>");

  while (rset.next()) {
    out.println("<data>");
    out.println("<id>" + rset.getInt(1) + "</id>");
    out.println("<name>" + rset.getString(2) + "</name>");
    out.println("<voteNumber>" + rset.getInt(3) + "</voteNumber>");
    out.println("<votePercentage>" + rset.getInt(4) + "</votePercentage>");
    out.println("</data>");
  }
  
  out.println("</datas>");

  stmt.close();
  conn.close();
%>