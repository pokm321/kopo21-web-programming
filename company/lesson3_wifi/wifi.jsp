<!-- Allview화면에서 하나를 선택하면 해당 사람만 데이터를 보여주는 jsp파일 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->
<html>

  <head>
    <% 
      // JDBC 드라이버를 로드 (초기화)
      Class.forName("com.mysql.cj.jdbc.Driver");

      // 지정된 ip, port, name, password로 MySQL에 연결을 하겠다.
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21"); 

      // 그 연결에서 query문을 보내기위한 객체 생성
      Statement stmt = conn.createStatement();
    
      int cnt = Integer.parseInt(request.getParameter("cnt")); // cnt값을 정수형으로 저장
      int from = Integer.parseInt(request.getParameter("from")); // from값을 정수형으로 저장
      stmt.execute("USE kopoctc;"); // 쿼리실행

      ResultSet rset = stmt.executeQuery("SELECT count(*) FROM wifitable;");
      rset.next();
      int dataNumber = rset.getInt(1);

      rset = stmt.executeQuery("SELECT * FROM wifitable LIMIT " + from + ", " + cnt + ";"); // 가져온 파라미터로 쿼리실행
    %>
  </head>
  <body>
    <style>
      #label {
        background-color: lightgrey;
      }

      a {
        margin: 5px;
        display: inline-block;
        color: black;
        text-decoration: none;
        width: 20px;
      }
    </style>
    <table cellspacing="1" border="1">
      <tr id="label"> <!-- 테이블의 레이블 row 생성 -->
        <td width="100"><p align="center">번호</p></td>
        <td width="400"><p align="center">주소</p></td>
        <td width="100"><p align="center">위도</p></td>
        <td width="100"><p align="center">경도</p></td>
        <td width="100"><p align="center">거리</p></td>
      </tr>
  
    <%
      while (rset.next()) { // 현재 페이지에 출력할 데이터들을 테이블에 출력
        out.println("<tr>");
        out.println("<td><p align=center>" + Integer.toString(rset.getInt(1)) + "</p></td>");
        out.println("<td><p align=center>" + rset.getString(2) + "</p></td>");
        out.println("<td><p align=center>" + Double.toString(rset.getDouble(3)) + "</p></td>");
        out.println("<td><p align=center>" + Double.toString(rset.getDouble(4)) + "</p></td>");
        out.println("<td><p align=center>" + Double.toString(rset.getDouble(5)) + "</p></td>");
        out.println("</tr>");
      }

      rset.close(); // 객체 닫기
      stmt.close(); // 객체 닫기
      conn.close(); // 객체 닫기
    %>
    </table>

    <%
      final int DISPLAYED_PAGES = 10; // 화면 하단에 몇개의 페이지를 나타낼지
      final int FROM_FIRST = from / (cnt * DISPLAYED_PAGES) * (cnt * DISPLAYED_PAGES); // 화면 하단에 처음으로 나올 페이지의 from

      out.println("<br><p align=center>");
      if (FROM_FIRST == 0) { // 화면하단에 첫페이지가 1페이지면
        out.println("<a href='wifi.jsp?from=" + FROM_FIRST + "&cnt=" + cnt + "'><<</a>"); // 현재 그룹의 첫번째 페이지로
      } else { // 그렇지 않으면
        out.println("<a href='wifi.jsp?from=" + (FROM_FIRST - cnt) + "&cnt=" + cnt + "'><<</a>"); // 이전 그룹의 마지막 페이지로
      }

      for (int i = 0; i < DISPLAYED_PAGES; i++) { // 화면 하단에 페이지 넘버 나타내기
        if ((FROM_FIRST + i * cnt) < dataNumber) {
          if (from == (FROM_FIRST + i * cnt)) { // 현재 페이지면 굵은 글씨로
            out.println("<a href='wifi.jsp?from=" + (FROM_FIRST + i * cnt) + "&cnt=" + cnt + "'><b>" + (FROM_FIRST / cnt + i + 1) + "</b></a>");
          } else { // 그외에는 일반 글씨로
            out.println("<a href='wifi.jsp?from=" + (FROM_FIRST + i * cnt) + "&cnt=" + cnt + "'>" + (FROM_FIRST / cnt + i + 1) + "</a>");
          }
        }
      }

      if ((FROM_FIRST + (cnt * DISPLAYED_PAGES)) < dataNumber) {
        out.println("<a href='wifi.jsp?from=" + (FROM_FIRST + (cnt * DISPLAYED_PAGES)) + "&cnt=" + cnt + "'>>></a>"); // 다음 그룹의 첫번째 페이지로
      }
      out.println("</p>");
    %>
  </body>
  </html>