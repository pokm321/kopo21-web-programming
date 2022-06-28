<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>

  <head>
    <% 
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();
    
      int id = Integer.parseInt(request.getParameter("id"));

      ResultSet rset = stmt.executeQuery("SELECT * FROM stocktable WHERE id=" + id + ";");
      rset.next();
    %>
  </head>

  <body>
    <style>
      #delete {
        padding: 10px;
        border: 1px solid;
        color: black;
        text-decoration: none;
        background-color:rgb(229, 133, 133);
      }

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

    <h1 align="center">(주)트와이스 재고 현황 - 제품상세</h1> <!-- 제목 표시 -->
    <table cellspacing="1" border="1" align="center">
      <tr>
        <td width="150">상품 번호</td>
        <td width="550"><%=rset.getInt(1)%></td>
      </tr>
      <tr>
        <td>상품명</td>
        <td style = "word-break: break-all"><%=rset.getString(2)%></td>
      </tr>
      <tr>
        <td>재고 현황</td>
        <td><%=rset.getInt(3)%></td>
      </tr>
      <tr>
        <td>상품등록일</td>
        <td><%=rset.getDate(5)%></td>
      </tr>
      <tr>
        <td>재고파악일</td>
        <td><%=rset.getDate(4)%></td>
      </tr>
      <tr>
        <td>상품설명</td>
        <td style = "word-break: break-all"><%=rset.getString(6)%></td>
      </tr>
      <tr>
        <td>상품사진</td>
        <td><img width="300" src="<%=rset.getString(7)%>"><br>&nbsp <%=rset.getString(7)%></td>
      </tr>
    </table>
    <br>
    <table align="center">
      <td width="450"><a id="button" href="list.jsp?from=0&cnt=20">목록</a></td>
      <td width="70"></td>
      <td>
        <a id="delete" href="delete.jsp?id=<%=rset.getInt(1)%>">상품삭제</a>
        <a id="button" href="update.jsp?id=<%=rset.getInt(1)%>">재고수정</a>
      </td>
    </table>

    <%
      rset.close();
      stmt.close();
      conn.close();
    %>
  </body>
</html>