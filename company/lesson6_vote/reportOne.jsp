<?xml version="1.0" encoding="UTF-8"?> <!-- xml파일로 만들겠다 -->
<%@ page contentType="text/xml; charset=utf-8" %> <!-- xml파일로 만들겠다 -->
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%
  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
  Statement stmt = conn.createStatement();

  int id = Integer.parseInt(request.getParameter("id"));
  
  stmt.execute("USE kopoctc;");
  ResultSet rset = stmt.executeQuery("SELECT name FROM candidate_table WHERE id = " + id + ";");

  // DB의 examtable에서 데이터를 뽑아서 xml형식으로 출력하기
  out.println("<datas>");

  rset.next();
  out.println("<hubo>" + id + ". " + rset.getString(1) + "</hubo>"); // 후보기호, 이름

  for (int i = 1; i < 10; i++) { // 10대부터 90대까지 출력
    rset = stmt.executeQuery("SELECT age, count(age), (100 * count(age) / (SELECT count(*) FROM vote_table WHERE id = " + id + ")) FROM vote_table WHERE id = " + id + " AND age = " + i + " GROUP BY age;");
    out.println("<data>");
    out.println("<age>" + i + "0" + "</age>");
    rset.next();
    try {
      out.println("<pyosu>" + rset.getInt(2) + "</pyosu>");
    } catch (SQLException e) { // 해당 데이터가 없으면 0개라는 뜻
        out.println("<pyosu>0</pyosu>");
    }

    try {
      out.println("<pyoyul>" + rset.getInt(3) + "</pyoyul>");
    } catch (SQLException e) { // 해당 데이터가 없으면 0개라는 뜻
        out.println("<pyoyul>0</pyoyul>");
    }
    out.println("</data>");
  }
  out.println("</datas>");

  stmt.close();
  conn.close();
%>