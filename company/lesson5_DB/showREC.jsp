<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->
<!DOCTYPE html>
<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <!-- 성적을 보여주고 수정 또는 삭제를 위해 입력창을 만드는 페이지 -->
    <%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21"); 
    Statement stmt = conn.createStatement();
    try {
      int studentidKey = Integer.parseInt(request.getParameter("studentid"));
      ResultSet rset = stmt.executeQuery("SELECT * FROM (SELECT *, rank() over (order by (kor + eng + mat) DESC) FROM examtable) t WHERE studentid = " + studentidKey + ";");

      String name = "";
      String studentid = "";
      String kor = "";
      String eng = "";
      String mat = "";
      String ranking = "";

      while (rset.next()) {
        name = rset.getString(1);
        studentid = Integer.toString(rset.getInt(2));
        kor = Integer.toString(rset.getInt(3));
        eng = Integer.toString(rset.getInt(4));
        mat = Integer.toString(rset.getInt(5));
        ranking = Integer.toString(rset.getInt(6));
      }
    %>
  </head>
  <body>
    <script>
      function checkCharacter(obj) {
        var regExp = /[1234567890\ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
  
        for (var i = obj.value.length - 1; i >= 0; i--) {
          if (regExp.test(obj.value.charAt(i))) {
            obj.value = obj.value.substring(0, i) + obj.value.substring(i + 1, obj.value.length)
            i++;
          }
        }
      }
    </script>

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

      a {
        border: 1px solid black;
        color: black;
        text-decoration: none;
        padding: 5px;
        background-color: lightgray;
        margin: 10px;
      }
    </style>
    <h1>성적 조회후 정정 / 삭제</h1><br>
    <form action="showREC.jsp">
      조회할 학번 &nbsp &nbsp &nbsp
      <input type="text" name="studentid">
      <input type="submit" id=submit value="조회">
    </form>
    <br>
    <form>
      <table>
        <tr>
          <td id="label">이름</td><td id="data"><input type="text" maxlength="13" name="name" value="<%=name%>" onkeyup="checkCharacter(this)" onkeydown="checkCharacter(this)"></td>
        </tr>
        <tr>
          <td>학번</td><td><%=studentid%><input type="hidden" name="studentid" value="<%=studentid%>"></td>
        </tr>
        <tr>
          <td>국어</td><td><input type="number" min="0" max="100" name="kor" value="<%=kor%>"></td>
        </tr>
        <tr>
          <td>영어</td><td><input type="number" min="0" max="100" name="eng" value="<%=eng%>"></td>
        </tr>
        <tr>
          <td>수학</td><td><input type="number" min="0" max="100" name="mat" value="<%=mat%>"></td>
        </tr>
        <tr>
          <td>총점</td><td><%=Integer.parseInt(mat) + Integer.parseInt(eng) + Integer.parseInt(kor)%></td>
        </tr>
        <tr>
          <td>평균</td><td><%=(Integer.parseInt(mat) + Integer.parseInt(eng) + Integer.parseInt(kor)) / 3%></td>
        </tr>
        <tr>
          <td>등수</td> <td><%=ranking%></td>
        </tr>
      </table><br>
      <%
          if (studentid.length() != 0) {
            out.println("<input type=submit value='수정' formaction='updateDB.jsp'></input>");
            out.println("<input type=submit value='삭제' formaction='deleteDB.jsp'></input>");
          }
        } catch (NumberFormatException e) {
          out.println("<script>alert('해당 학번이 존재하지않습니다.');location.href='inputForm2.html';</script>");
        } catch (SQLSyntaxErrorException e) { // 테이블이 없을경우
          out.println("<script>alert('테이블이 존재하지않습니다.');location.href='inputForm2.html';</script>");
        }
      %>
    </form>
      <br>

  </body>
</html>