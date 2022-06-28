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
          <td><%=rset.getInt(1)%></td>
        </tr>
        <tr>
          <td><b>제목</b></td>
          <td><%=rset.getString(2)%></td>
        </tr>
        <tr>
          <td><b>일자</b></td>
          <td><%=rset.getDate(3)%></td>
        </tr>
        <tr>
          <td><b>내용</b></td>
          <td><%=rset.getString(4)%></td>
        </tr>
      </table>

      <table width="650">
        <tr>
          <td width="600"></td>
          <td><input type="button" value="목록" onclick="location.href='gongji_list.jsp'"></td>
          <td><input type="button" value="수정" onclick="location.href='gongji_update.jsp?key=<%=rset.getInt(1)%>'"></td>
          <td><input type="button" value="삭제" onclick="location.href='gongji_delete.jsp?id=<%=rset.getInt(1)%>'"></td>
        </tr>
      </table>

      <%
        rset.close();
        stmt.close();
        conn.close();
      %>
    </form>
  </body>
</html>