<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->
<html>
  <head>

  </head>
  <!-- AllsetDB.jsp examtable에 데이터를 insert하는 jsp파일 -->
  <% 
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
    Statement stmt = conn.createStatement();
    
    try {
    // DB테이블에 하나씩 값 넣기
    stmt.execute("DELETE FROM examtable WHERE studentid > 0;");
    stmt.execute("INSERT INTO examtable VALUES('나연', 209901, 95, 100, 95);");
    stmt.execute("INSERT INTO examtable VALUES('정연', 209902, 95, 95, 95);");
    stmt.execute("INSERT INTO examtable VALUES('모모', 209903, 100, 100, 100);");
    stmt.execute("INSERT INTO examtable VALUES('사나', 209904, 100, 95, 90);");
    stmt.execute("INSERT INTO examtable VALUES('지효', 209905, 80, 100, 70);");
    stmt.execute("INSERT INTO examtable VALUES('미나', 209906, 100, 100, 70);");
    stmt.execute("INSERT INTO examtable VALUES('다현', 209907, 70, 70, 70);");
    stmt.execute("INSERT INTO examtable VALUES('채영', 209908, 80, 75, 72);");
    stmt.execute("INSERT INTO examtable VALUES('쯔위', 209909, 78, 79, 82);");
    out.println("<h1>실습데이터 입력 OK</h1>");
    } catch (SQLSyntaxErrorException e) {
      out.println("<h1>실습데이터 입력 실패 (table이 존재하지않음)</h1>");
    }

    stmt.close(); // 객체 닫기
    conn.close(); // 객체 닫기
  %>
  <body>
    
  </body>
  </html>