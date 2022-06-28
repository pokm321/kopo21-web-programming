<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->
<html>
  <head>
    <!-- 빈 학번을 찾고 받은 key값들로 DB에 넣는다 -->
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21"); 
      Statement stmt = conn.createStatement();

      try {
        String name = request.getParameter("name");
        int kor = Integer.parseInt(request.getParameter("kor"));
        int eng = Integer.parseInt(request.getParameter("eng"));
        int mat = Integer.parseInt(request.getParameter("mat"));

        stmt.execute("show global variables like 'log_bin_trust_function_creators';");
        stmt.execute("SET Global log_bin_trust_function_creators = 'ON';");
        stmt.execute("DROP FUNCTION IF EXISTS get_studentid;");
        stmt.execute( "CREATE FUNCTION get_studentid(_start INTEGER) RETURNS INTEGER " + // 비어있는 학번을 찾는 Function
                      "BEGIN " +
                      "  DECLARE _studentid INTEGER; " +
                      "  SET _studentid = _start; " +
                        
                      "  _loop: LOOP " +
                      "    IF (SELECT count(*) FROM examtable WHERE studentid = _studentid) = 0 THEN LEAVE _loop; " +
                      "    END IF; " +
                            
                      "    SET _studentid = _studentid + 1; " +
                      "  END LOOP _loop; " +
                      
                      "  RETURN _studentid; " +
                      "END;");

        ResultSet rset = stmt.executeQuery("SELECT get_studentid(209901);"); // 209901부터 시작해서 비어있는 학번을 찾아라

        int studentid = 0;
        while (rset.next()) {
          studentid = rset.getInt(1); // 그걸 변수에 저장함
        }

        // 그걸 이용해 값을 넣음
        stmt.execute("INSERT INTO examtable VALUES('" + name + "', " + studentid + ", " + kor + ", " + eng + ", " + mat + ");");

        rset.close();
    %>
  </head>
  <body>
    <style>
      #submit {
        margin: 5px;
      }

      table, tr, td {
        border: 1px solid black;
        text-align: center;
      }

      #label {
        width: 150px;
      }

      #data {
        width: 500px;
      }
    </style>
    <!-- insertDB.jsp -->
    <h1>성적입력추가완료</h1>

    <button><a href="inputForm1.html">뒤로가기</a></button>
    <table>
      <tr>
        <td id="label">이름</td>
        <td id="data"><%=name%></td>
      </tr>
      <tr>
        <td>학번</td>
        <td><%=studentid%></td>
      </tr>
      <tr>
        <td>국어</td>
        <td><%=kor%></td>
      </tr>
      <tr>
        <td>영어</td>
        <td><%=eng%></td>
      </tr>
      <tr>
        <td>수학</td>
        <td><%=mat%></td>
      </tr>
    </table>
    <%
      } catch (NumberFormatException e) {
        out.println("<script>alert('빈칸이 존재합니다. 다시 입력해주세요.');location.href='inputForm1.html';</script>");
      } catch (SQLSyntaxErrorException e) {
        out.println("<script>alert('테이블이 존재하지않습니다.');location.href='inputForm1.html';</script>");
      }

      stmt.close();
      conn.close();
    %>
  </body>
</html>