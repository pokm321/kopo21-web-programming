<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>

  <head>
    <% 
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();
    
      int cnt = Integer.parseInt(request.getParameter("cnt")); // cnt값을 정수형으로 저장
      int from = Integer.parseInt(request.getParameter("from")); // from값을 정수형으로 저장

      ResultSet rset = stmt.executeQuery("SELECT count(*) FROM stocktable;");
      rset.next();
      int dataNumber = rset.getInt(1);

      rset = stmt.executeQuery("SELECT * FROM stocktable LIMIT " + from + ", " + cnt + ";"); // 가져온 파라미터로 쿼리실행
    %>
  </head>
  <body>
    <style>
      #label {
        background-color: rgb(230, 230, 230);
      }

      #page_control {
        margin: 5px;
        display: inline-block;
        color: black;
        text-decoration: none;
        width: 20px;
      }

      td {
        text-align: center;
      }

      #new {
        padding: 10px;
        border: 1px solid;
        color: black;
        text-decoration: none;
        background-color:rgb(227, 227, 227);
        position: absolute;
        left: 700px;
        font-size: larger;
      }

      #makedata {
        padding: 8px;
        border: 1px solid;
        color: black;
        text-decoration: none;
        background-color:rgb(229, 133, 133);
        position: absolute;
        left: 100px;
        font-size: small;
      }
    </style>

    <h1 align="center">(주)트와이스 재고 현황 - 전체현황</h1> <!-- 제목 표시 -->

    <table cellspacing="1" border="1" align="center">
      <tr id="label"> <!-- 테이블의 레이블 row 생성 -->
        <td width="100">상품번호</td>
        <td width="300">상품명</td>
        <td width="100">현재 재고수</td>
        <td width="100">재고파악일</td>
        <td width="100">상품등록일</td>
      </tr>
  
    <%
      while (rset.next()) { // 현재 페이지에 출력할 데이터들을 테이블에 출력
        out.println("<tr>");
        out.println("<td><a href='detail.jsp?id=" + rset.getInt(1) + "'>" + rset.getInt(1) + "</a></td>");
        out.println("<td><a href='detail.jsp?id=" + rset.getInt(1) + "'>" + rset.getString(2) + "</a></td>");
        out.println("<td>" + rset.getInt(3) + "</td>");
        out.println("<td>" + rset.getDate(4) + "</td>");
        out.println("<td>" + rset.getDate(5) + "</td>");
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

      out.println("<p align=center>");
      if (FROM_FIRST == 0) { // 화면하단에 첫페이지가 1페이지면
        out.println("<a id='page_control' href='list.jsp?from=" + FROM_FIRST + "&cnt=" + cnt + "'><<</a>"); // 현재 그룹의 첫번째 페이지로
      } else { // 그렇지 않으면
        out.println("<a id='page_control' href='list.jsp?from=" + (FROM_FIRST - cnt) + "&cnt=" + cnt + "'><<</a>"); // 이전 그룹의 마지막 페이지로
      }

      for (int i = 0; i < DISPLAYED_PAGES; i++) { // 화면 하단에 페이지 넘버 나타내기
        if ((FROM_FIRST + i * cnt) < dataNumber) {
          if (from == (FROM_FIRST + i * cnt)) { // 현재 페이지면 굵은 글씨로
            out.println("<a id='page_control' href='list.jsp?from=" + (FROM_FIRST + i * cnt) + "&cnt=" + cnt + "'><b>" + (FROM_FIRST / cnt + i + 1) + "</b></a>");
          } else { // 그외에는 일반 글씨로
            out.println("<a id='page_control' href='list.jsp?from=" + (FROM_FIRST + i * cnt) + "&cnt=" + cnt + "'>" + (FROM_FIRST / cnt + i + 1) + "</a>");
          }
        }
      }

      if ((FROM_FIRST + (cnt * DISPLAYED_PAGES)) < dataNumber) {
        out.println("<a id='page_control' href='list.jsp?from=" + (FROM_FIRST + (cnt * DISPLAYED_PAGES)) + "&cnt=" + cnt + "'>>></a>"); // 다음 그룹의 첫번째 페이지로
      }
      out.println("</p>");
    %>

    <a id="makedata" href="makedata.jsp">초기화</a>
    <a id="new" href="new.jsp">신규등록</a>
  </body>
  </html>