<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.ArrayList" %>
<html>
  <head>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();

      String id = request.getParameter("key");
      try {
        ResultSet rset = stmt.executeQuery("SELECT * FROM forum WHERE id=" + id + ";");
        rset.next();
    %>

    <script LANGUAGE="JavaScript">
      function submitForm(mode) {
        if (mode == "write") {
          fm.action = "forum_write.jsp";
        } else if (mode == "delete") {
          fm.action = "forum_delete.jsp";
        }
        fm.submit();
      }
    </script>
  </head>

  <body>
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
    <form method="post" name="fm">
      <table width="90%" border="1" cellspacing="0" cellpadding="5">
        <tr>
          <td id="label"><b>번호</b></td>
          <td><%=rset.getInt(1)%><input type="hidden" name="id" maxlength="70" value="<%=rset.getInt(1)%>"></td>
        </tr>
        <tr>
          <td id="label"><b>제목</b></td>
          <td><input id="textarea" style="width: 100%" type="text" name="title" size="60" maxlength="70" value="<%=rset.getString(2)%>"></td>
        </tr>
        <tr>
          <td id="label"><b>일자</b></td>
          <td><%=rset.getDate(3)%></td>
        </tr>
        <tr>
          <td id="label"><b>내용</b></td>
          <td><textarea id="textarea" style="width: 100%; height:250px;" name="content" maxlength="8000" cols="70" row="600"><%=rset.getString(4)%></textarea></td>
        </tr>
      </table>

      <table width="90%">
        <tr>
          <td></td>
          <td width="50"><input type="button" value="취소" onclick="location.href='forum_view.jsp?id=<%=id%>'"></td>
          <td width="50"><input type="button" value="쓰기" onclick="submitForm('write')"></td>
          <td width="50"><input type="button" value="삭제" onclick="submitForm('delete')"></td>
        </tr>
      </table>
    </form>

    <%
        rset.close();
      } catch (SQLException e) {
        out.println("<script>alert('존재하지않는 게시글입니다.');location.href='forum_list.jsp?from=0&cnt=20';</script>");
      }

      stmt.close();
      conn.close();
    %>

  </body>
</html>