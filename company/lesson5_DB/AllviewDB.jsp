<!-- examtable에 데이터를 모두 보여주는 jsp파일 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->
<html>
  <head>
  </head>
  <!-- AllviewDB.jsp examtable에 데이터를 모두 보여주는 jsp파일 -->
  <% 
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
    Statement stmt = conn.createStatement();
  
    try {
      stmt.execute("USE kopoctc;"); // DB선택
      ResultSet rset = stmt.executeQuery("SELECT *, rank() over (order by (kor + eng + mat) DESC) FROM examtable ORDER BY studentid;"); // examtable 내용 저장
  %>
  
  <h1>전체 조회</h1> <!-- 제목 -->

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
          int kor = rset.getInt(3);
          int eng = rset.getInt(4);
          int mat = rset.getInt(5);

          out.println("<tr>");
          
          // 클릭하면 이름을 key파라미터로 가진채 oneviewDB.jsp를 여는 버튼생성
          out.println("<td width=50><p align=center><a href='oneviewDB.jsp?key=" + rset.getString(1) + "'>" + rset.getString(1) + "</a></p></td>");
          out.println("<td width=50><p align=center>" + rset.getInt(2) + "</p></td>");
          out.println("<td width=50><p align=center>" + kor + "</p></td>");
          out.println("<td width=50><p align=center>" + eng + "</p></td>");
          out.println("<td width=50><p align=center>" + mat + "</p></td>");
          out.println("<td width=50><p align=center>" + (kor + eng + mat) + "</p></td>");
          out.println("<td width=50><p align=center>" + (kor + eng + mat) / 3 + "</p></td>");
          out.println("<td width=50><p align=center>" + rset.getInt(6) + "</p></td>");
          out.println("</tr>");
        }
        rset.close(); // 객체 닫기
      } catch (SQLSyntaxErrorException e) {
        out.println("<h1>전체 조회 실패 (table이 없음)</h1>");
      }
      stmt.close(); // 객체 닫기
      conn.close(); // 객체 닫기
    %>
  </table>
  <body>
    
  </body>
  </html>