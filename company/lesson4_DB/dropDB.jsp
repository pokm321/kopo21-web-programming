<!-- examtable 을 삭제하는 jsp파일 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->
<html>
  <head>

  </head>
  <h1>테이블 지우기 OK</h1>
  <% 
    // JDBC 드라이버를 로드 (초기화)
    Class.forName("com.mysql.cj.jdbc.Driver");

    // 지정된 ip, port, name, password로 MySQL에 연결을 하겠다.
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21"); 

    // 그 연결에서 query문을 보내기위한 객체 생성
    Statement stmt = conn.createStatement();
    
    // 테이블 지우기
    stmt.execute("USE kopoctc;");
    stmt.execute("DROP TABLE examtable;");

    stmt.close(); // 객체 닫기
    conn.close(); // 객체 닫기
  %>
  <body>
    
  </body>
  </html>