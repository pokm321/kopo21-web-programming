<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.ArrayList" %>
<html>
  <head>
    <script LANGUAGE="JavaScript">
      function submitForm(mode) {
        fm.action = "gongji_write.jsp";
        fm.submit();
      }
    </script>
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

    <form method="post" name="fm">
      <table width="650" border="1" cellspacing="0" cellpadding="5">
        <tr>
          <td><b>번호</b></td>
          <td>신규(insert)<input type="hidden" name="id" value="insert"></td>
        </tr>
        <tr>
          <td><b>제목</b></td>
          <td><input type="text" name="title" size="70" maxlength="70"></td>
        </tr>
        <tr>
          <td><b>일자</b></td>
          <td id="date"></td>
        </tr>
        <tr>
          <td><b>내용</b></td>
          <td><textarea style="width: 500px; height:250px;" name="content" cols="70" row="600"></textarea></td>
        </tr>
      </table>

      <table width="650">
        <tr>
          <td width="600"></td>
          <td><input type="button" value="취소" onclick="location.href='gongji_list.jsp'"></td>
          <td><input type="button" value="쓰기" onclick="submitForm('write')"></td>
        </tr>
      </table>
    </form>
  </body>
</html>