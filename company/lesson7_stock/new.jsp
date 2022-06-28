<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>

  <head>
  </head>

  <body onload="getDate()">
    <script>
      function getDate() {
        date = new Date();
        year = date.getFullYear();
        month = date.getMonth() + 1;
        day = date.getDate();
        document.getElementsByName("date")[0].innerHTML = year + "-" + month + "-" + day;
        document.getElementsByName("date")[1].innerHTML = year + "-" + month + "-" + day;
      }
    </script>

    <style>
      #button {
        padding: 10px;
        border: 1px solid;
        color: black;
        text-decoration: none;
        background-color:rgb(227, 227, 227);
        font-size: medium;
      }

      img {
        margin: 10px;
      }
    </style>

    <h1 align="center">(주)트와이스 재고 현황 - 신규등록3</h1>

    <form action="writeNew.jsp" method="post" enctype="multipart/form-data">
      <table cellspacing="1" border="1" align="center">
        <tr>
          <td width="150">상품 번호</td>
          <td width="550"><input type="number" name="id" min="0" max="99999999" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="123456"></td>
        </tr>
        <tr>
          <td>상품명</td>
          <td><input type="text" name="name" maxlength="40" placeholder="바나나"></td>
        </tr>
        <tr>
          <td>재고 현황</td>
          <td><input type="number" name="number" min="0" max="999999" placeholder="10"></td>
        </tr>
        <tr>
          <td>상품등록일</td>
          <td name="date"></td>
        </tr>
        <tr>
          <td>재고파악일</td>
          <td name="date"></td>
        </tr>
        <tr>
          <td>상품설명</td>
          <td><textarea name="content" maxlength="200" placeholder="알래스카산 바나나로 맘모스의 아침식사" cols="50" rows="4"></textarea></td>
        </tr>
        <tr>
          <td>상품사진</td>
          <td><input type="file" name="file"></td>
        </tr>
      </table>
      <br>
      <table>
        <td width="670"></td>
        <td>
          <a id="button" href="list.jsp?from=0&cnt=20">취소</a>
          <input type="submit" id="button" value="등록">
        </td>
      </table>
    </form>
  </body>
</html>