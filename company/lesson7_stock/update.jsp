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

    <h1 align="center">(주)트와이스 재고 현황 - 재고수정</h1>


    <form action="writeUpdate.jsp">
      <table cellspacing="1" border="1" align="center">
        <tr>
          <td width="150">상품 번호</td>
          <%
          try { 
            out.println("<td width='550'><input type='hidden' name='id' value='" + rset.getInt(1) + "'>" + rset.getInt(1) + "</td>");
          } catch (Exception e) {
            out.println("<script>alert('존재하지 않는 품목입니다.');location.href='list.jsp?from=0&cnt=20';</script>");
            return;
          }
            %>
        </tr>
        <tr>
          <td>상품명</td>
          <td style = "word-break: break-all"><%=rset.getString(2)%></td>
        </tr>
        <tr>
          <td>재고 현황</td>
          <td><input type="number" name="number" min="0" max="999999" value="<%=rset.getInt(3)%>"></td>
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
        <td width="580"></td>
        <td>
          <a id="button" href="detail.jsp?id=<%=rset.getInt(1)%>">취소</a>
          <input type="submit" id="button" value="완료">
        </td>
      </table>
    </form>
    

    <%
      rset.close();
      stmt.close();
      conn.close();
    %>
  </body>
</html>