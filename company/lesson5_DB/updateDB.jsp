<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->

<html>
  <head>
    <!-- 수정버튼을 눌렀을때 해당 입력값들로 DB 업데이트 하는 페이지 -->
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21"); 
      Statement stmt = conn.createStatement();

      try {
        String name = request.getParameter("name");
        int studentid = Integer.parseInt(request.getParameter("studentid"));
        int kor = Integer.parseInt(request.getParameter("kor"));
        int eng = Integer.parseInt(request.getParameter("eng"));
        int mat = Integer.parseInt(request.getParameter("mat"));

        if (name.length() == 0) {
          kor = Integer.parseInt(request.getParameter("name"));
        }

        stmt.execute("USE kopoctc;");
        stmt.execute("UPDATE examtable SET name = '" + name + "', kor = " + kor + ", eng = " + eng + ", mat = " + mat + " WHERE studentid = " + studentid + ";");
    %>
  </head>
  <style>
    #yellow {
      background-color: yellow;
    }
  </style>
  <body>
    <h1>레코드 수정</h1> <!-- 제목 -->
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
          ResultSet rset = stmt.executeQuery("SELECT *, rank() over (order by (kor + eng + mat) DESC) FROM examtable ORDER BY studentid;");

          while (rset.next()) { // 데이터들을 테이블에 출력
            kor = rset.getInt(3);
            eng = rset.getInt(4);
            mat = rset.getInt(5);
          
            if (rset.getInt(2) == studentid) {
              out.println("<tr id='yellow'>");
            } else {
              out.println("<tr>");
            }
            
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
        } catch (NumberFormatException e) {
          out.println("<script>alert('빈칸이 존재합니다. 다시 시도해주세요.');location.href='inputForm2.html';</script>");
        }
    
        stmt.close(); // 객체 닫기
        conn.close(); // 객체 닫기
      %>
    </table>
  </body>
</html>

