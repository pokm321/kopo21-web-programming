<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.ArrayList" %>
<html>
  <head>
    <script LANGUAGE="JavaScript">
      function submitForm() {
        if (confirm("게시글을 작성하시겠습니까?")) {
          fm.action = "forum_write.jsp";
          fm.submit();
        }
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
        document.getElementsByClassName("date")[0].innerHTML = year + "-" + month + "-" + day;
        document.getEle
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
        background-color: rgb(30, 28, 28);
      }

      #nonlabel {
        background-color: rgb(46, 46, 46);
      }

      #textarea {
        background-color: rgb(62, 62, 62);
      }
    </style>

    <form method="post" name="fm">
      <table width="90%" border="1" cellspacing="0" cellpadding="5">
        <tr>
          <td id="label"><b>번호</b></td>
          <td id="nonlabel">자동부여<input type="hidden" name="id" value="insert"></td>
        </tr>
        <tr>
          <td id="label"><b>제목</b></td>
          <td id="nonlabel"><input id="textarea" style="width: 100%" type="text" name="title" size="70" maxlength="70"></td>
        </tr>
        <tr>
          <td id="label"><b>일자</b></td>
          <td id="nonlabel" class="date"></td>
        </tr>
        <tr>
          <td id="label"><b>내용</b></td>
          <td id="nonlabel"><textarea id="textarea" style="width: 100%; height:250px;" maxlength="8000" name="content" cols="70" row="600"></textarea></td>
        </tr>
      </table>
      <input type="hidden" name="reply_level" value="0">

      <table width="90%">
        <tr>
          <td></td>
          <td width="50"><input type="button" value="취소" onclick="history.back()"></td>
          <td width="50"><input type="button" value="쓰기" onclick="submitForm()"></td>
        </tr>
      </table>
    </form>
  </body>
</html>