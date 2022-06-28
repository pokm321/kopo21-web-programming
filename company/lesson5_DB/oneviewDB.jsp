<!-- Allview화면에서 하나를 선택하면 해당 사람만 데이터를 보여주는 jsp파일 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->
<html>
  <head>
  </head>
  <% 
    // JDBC 드라이버를 로드 (초기화)
    Class.forName("com.mysql.cj.jdbc.Driver");

    // 지정된 ip, port, name, password로 MySQL에 연결을 하겠다.
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21"); 

    // 그 연결에서 query문을 보내기위한 객체 생성
    Statement stmt = conn.createStatement();
  
    // 받아온 파라미터(이름)와 일치하는 값 출력, 즉 해당 멤버의 데이터 출력
    String ckey = request.getParameter("key");
    stmt.execute("USE kopoctc;");
    ResultSet rset = stmt.executeQuery("SELECT * FROM (SELECT *, rank() over (order by (kor + eng + mat) DESC) FROM examtable) as a WHERE a.name = '" + ckey + "';");
  %>
  
  <h1>[<%=ckey%>]조회</h1> <!-- 멤버 이름 출력 -->

  <table cellspacing="1" width="600" border="1">
    <tr> <!-- 테이블의 레이블 row 생성 -->
      <td width="50"><p align="center">이름</p></td>
      <td width="50"><p align="center">학번</p></td>
      <td width="50"><p align="center">국어</p></td>
      <td width="50"><p align="center">영어</p></td>
      <td width="50"><p align="center">수학</p></td>
      <td width="50"><p align="center">총점</p></td>
      <td width="50"><p align="center">평균</p></td>
      <td width="50"><p align="center">등수</p></td>
    </tr>

  <%
    while (rset.next()) { // 데이터들을 테이블에 출력
      out.println("<tr>");
      out.println("<td width=50><p align=center>" + rset.getString(1) + "</p></td>");
      out.println("<td width=50><p align=center>" + rset.getInt(2) + "</p></td>");
      out.println("<td width=50><p align=center>" + rset.getInt(3) + "</p></td>");
      out.println("<td width=50><p align=center>" + rset.getInt(4) + "</p></td>");
      out.println("<td width=50><p align=center>" + rset.getInt(5) + "</p></td>");
      out.println("<td width=50><p align=center>" + (rset.getInt(3) + rset.getInt(4) + rset.getInt(5)) + "</p></td>");
      out.println("<td width=50><p align=center>" + (rset.getInt(3) + rset.getInt(4) + rset.getInt(5)) / 3 + "</p></td>");
      out.println("<td width=50><p align=center>" + rset.getInt(6) + "</p></td>");
      out.println("<tr>");
    }

    rset.close(); // 객체 닫기
    stmt.close(); // 객체 닫기
    conn.close(); // 객체 닫기
  %>
  <body>
    
  </body>
  </html>