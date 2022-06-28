<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.ArrayList" %>
<html>
  <head>
    <script LANGUAGE="JavaScript">
      function submitForm(mode) {
        fm.action = "forum_write.jsp";
        fm.submit();
      }
    </script>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();

      String id = request.getParameter("id");
      try {
        ResultSet rset = stmt.executeQuery("SELECT * FROM forum WHERE id = " + id + ";");
        rset.next();      
    %>
  </head>

  <body onload="getDate()">
    <script>
      function getDate() {
        date = new Date();
        year = date.getFullYear();
        month = date.getMonth() + 1;
        day = date.getDate();
        document.getElementById("date").innerHTML = year + "-" + month + "-" + day;
      }
    </script>

    <style>
      * {
        color: rgb(241, 241, 241);
      }

      input {
        background-color: rgb(129, 101, 101);
      }

      #label {
        white-space: nowrap;
      }

      #textarea {
        background-color: rgb(62, 62, 62);
      }
    </style>

    <h4><%=rset.getString(2)%> 에 대한 답글...</h4>
    <form method="post" name="fm">
      <table width="90%" border="1" cellspacing="0" cellpadding="5">
        <tr>
          <td id="label"><b>번호</b></td>
          <td>자동부여<input type="hidden" name="id" value="insert_re"></td>
        </tr>
        <tr>
          <td id="label"><b>제목</b></td>
          <td><input id="textarea" style="width: 100%;" type="text" name="title" size="70" maxlength="70"></td>
        </tr>
        <tr>
          <td id="label"><b>일자</b></td>
          <td id="date"></td>
        </tr>
        <tr>
          <td id="label"><b>내용</b></td>
          <td><textarea id="textarea" style="width: 100%; height:250px;" name="content" maxlength="8000" cols="70" row="600"></textarea></td>
        </tr>
      </table>
      <input type="hidden" name="rootid" value="<%=(rset.getInt(5))%>">
      <input type="hidden" name="reply_level" value="<%=(rset.getInt(6) + 1)%>">
      <table width="90%">
        <tr>
          <td></td>
          <td width="50"><input type="button" value="취소" onclick="location.href='forum_view.jsp?id=<%=id%>'"></td>
          <td width="50"><input type="button" value="쓰기" onclick="submitForm('write')"></td>
        </tr>
      </table>
    </form>
      
    <%
      } catch (SQLException e) {
        out.println("<script>alert('존재하지않는 게시글입니다.');location.href='forum_list.jsp?from=0&cnt=20';</script>");
      }

      stmt.close();
      conn.close();
    %>

  </body>
</html>