<?xml version="1.0" encoding="UTF-8"?> <!-- xml파일로 만들겠다 -->
<%@ page contentType="text/xml; charset=utf-8" %> <!-- xml파일로 만들겠다 -->
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%
  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
  Statement stmt = conn.createStatement();
  ResultSet rset = stmt.executeQuery("SELECT * FROM examtable;");

  // DB의 examtable에서 데이터를 뽑아서 xml형식으로 출력하기
  out.println("<datas>");

  while (rset.next()) {
    out.println("<data>");
    out.println("<name>" + rset.getString(1) + "</name>");
    out.println("<studentid>" + Integer.toString(rset.getInt(2)) + "</studentid>");
    out.println("<kor>" + rset.getString(3) + "</kor>");
    out.println("<eng>" + rset.getString(4) + "</eng>");
    out.println("<mat>" + rset.getString(5) + "</mat>");
    out.println("</data>");
  }
  
  out.println("</datas>");

  stmt.close();
  conn.close();
%>