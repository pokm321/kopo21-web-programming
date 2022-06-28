<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.ArrayList" %>
<html>
  <head>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();
    %>
  </head>
  
  <body>
    <style>
      #new {
        padding: 10px;
        border: 1px solid;
        color: black;
        text-decoration: none;
        background-color:rgb(227, 227, 227);
        font-size: larger;
      }

      #makedata {
        padding: 8px;
        border: 1px solid;
        color: black;
        text-decoration: none;
        background-color:rgb(229, 133, 133);
        font-size: small;
      }
    </style>
    
    <table cellspacing="1" width="600" border="1" align="center">
      <tr>
        <td width="50"><p align="center">번호</p></td>
        <td width="500"><p align="center">제목</p></td>
        <td width="100"><p align="center">등록일</p></td>
      </tr>

      <%
        ResultSet rset = stmt.executeQuery("SELECT * FROM gongji;");

        while (rset.next()) {
          out.println("<tr>");
          out.println("<td width='50'><p align='center'>" + rset.getInt(1) + "</p></td>");
          out.println("<td width='500'><p align='center'><a href='gongji_view.jsp?key=" + rset.getInt(1) + "'>" + rset.getString(2) + "</p></td>");
          out.println("<td width='100'><p align='center'>" + rset.getDate(3) + "</p></td>");
          out.println("</tr>");
        }

        rset.close();
        stmt.close();
        conn.close();
      %>
    </table>
    <br>
    <table width="600" align="center">
      <tr>
        <td width="550"><input type="button" id="makedata" value="초기화" onclick="window.location='makedata.jsp'"></td>
        <td><input type="button" id="new" value="신규" onclick="window.location='gongji_insert.jsp'"></td>
      </tr>
    </table>
  </body>
</html>