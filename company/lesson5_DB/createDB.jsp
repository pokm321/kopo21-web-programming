<!-- examtable 을 생성하는 jsp파일 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->
<html>
  <head>

  </head>
  <h1>테이블 만들기 OK</h1>
  <% 
    // JDBC 드라이버를 로드 (초기화)
    Class.forName("com.mysql.cj.jdbc.Driver");

    // 지정된 ip, port, name, password로 MySQL에 연결을 하겠다.
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21"); 

    // 그 연결에서 query문을 보내기위한 객체 생성
    Statement stmt = conn.createStatement();
    
    // 새로운 테이블 생성
    stmt.execute("USE kopoctc;");
    stmt.execute("DROP TABLE IF EXISTS examtable;");
    stmt.execute("create table examtable(" +
      "name varchar(26)," +
      "studentid int not null primary key," +
      "kor int," +
      "eng int," +
      "mat int) DEFAULT CHARSET=utf8;");

    stmt.close(); // 객체닫기
    conn.close(); // 객체닫기
  %>
  <body>
    
  </body>
  </html>