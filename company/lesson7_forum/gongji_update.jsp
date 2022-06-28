<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.ArrayList" %>
<html>
  <head>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();

      String id = request.getParameter("key");
    %>

    <script LANGUAGE="JavaScript">
      function submitForm(mode) {
        if (mode == "write") {
          fm.action = "gongji_write.jsp";
        } else if (mode == "delete") {
          fm.action = "gongji_delete.jsp";
        }
        fm.submit();
      }
    </script>
  </head>

  <body>
    <form method="post" name="fm">
      <table width="650" border="1" cellspacing="0" cellpadding="5">
        <%
          ResultSet rset = stmt.executeQuery("SELECT * FROM gongji WHERE id=" + id + ";");
          rset.next();
        %>

        <tr>
          <td><b>번호</b></td>
          <td><%=rset.getInt(1)%><input type="hidden" name="id" maxlength="70" value="<%=rset.getInt(1)%>"></td>
        </tr>
        <tr>
          <td><b>제목</b></td>
          <td><input type="text" name="title" size="70" maxlength="70" value="<%=rset.getString(2)%>"></td>
        </tr>
        <tr>
          <td><b>일자</b></td>
          <td><%=rset.getDate(3)%></td>
        </tr>
        <tr>
          <td><b>내용</b></td>
          <td><textarea style="width: 500px; height:250px;" name="content" cols="70" row="600"><%=rset.getString(4)%></textarea></td>
        </tr>
      </table>

      <%
        rset.close();
        stmt.close();
        conn.close();
      %>

      <table width="650">
        <tr>
          <td width="600"></td>
          <td><input type="button" value="취소" onclick="location.href='gongji_list.jsp'"></td>
          <td><input type="button" value="쓰기" onclick="submitForm('write')"></td>
          <td><input type="button" value="삭제" onclick="submitForm('delete')"></td>
        </tr>
      </table>
    </form>
  </body>
</html>