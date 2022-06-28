<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.ArrayList" %>
<html>
  <head>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();

      String id = request.getParameter("id");
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

      #status {
        width: 90%;
      }

      #content {
        width: 85%;
        padding-left: 20px;
        white-space: normal;
        word-break: break-all;
      }

      table {
        table-layout: fixed;
      }

      #label {
        white-space: nowrap;
        background-color: rgb(30, 28, 28);
      }

      #nonlabel {
        background-color: rgb(46, 46, 46);
      }

      td {
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow: hidden;
      }
    </style>

    <form method="post" name="fm">
      <table id="status" border="1" cellspacing="0" cellpadding="5">
        <%
          stmt.execute("UPDATE forum SET viewcount = viewcount + 1 WHERE id = " + id + ";");
          ResultSet rset = stmt.executeQuery("SELECT * FROM forum WHERE id=" + id + ";");
          rset.next();
        %>
        <tr>
          <td id="label" width="80"><b>번호</b></td>
          <td id="nonlabel" colspan="5"><%=rset.getInt(1)%></td>
        </tr>
        <tr>
          <td id="label"><b>제목</b></td>
          <td id="nonlabel" colspan="5"><%=rset.getString(2)%></td>
        </tr>
        <tr>
          <td id="label"><b>일자</b></td>
          <td id="nonlabel" colspan="5"><%=rset.getDate(3)%></td>
        </tr>
        <tr>
          <td id="label"><b>조회수</b></td>
          <td id="nonlabel" colspan="5"><%=rset.getInt(8)%></td>
        </tr>
        <tr>
          <td id="label"><b>원글번호</b></td>
          <td id="nonlabel"><%=rset.getInt(5)%></td>
          <td id="label" width="100"><b>댓글레벨</b></td>
          <td id="nonlabel"><%=rset.getInt(6)%></td>
          <td id="label" width="100"><b>댓글순서</b></td>
          <td id="nonlabel"><%=rset.getInt(7)%></td>
        </tr>
      </table><br>

      <div id="content"><%=rset.getString(4)%></div><br>

      <table width="90%" border="1">
        <tr></tr>
      </table><br>

      <table width="90%">
        <tr>
          <td></td>
          <td width="50"><input type="button" value="목록" onclick="location.href='forum_list.jsp?from=0&cnt=20'"></td>
          <td width="50"><input type="button" value="수정" onclick="location.href='forum_update.jsp?key=<%=rset.getInt(1)%>'"></td>
          <td width="50"><input type="button" value="삭제" onclick="location.href='forum_delete.jsp?id=<%=rset.getInt(1)%>'"></td>
          <td width="50"><input type="button" value="댓글" onclick="location.href='forum_insert_re.jsp?id=<%=rset.getInt(1)%>'"></td>
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