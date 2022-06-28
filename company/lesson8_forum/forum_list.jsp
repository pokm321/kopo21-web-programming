<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.ArrayList" %>
<html>
  <head>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();

      int cnt = Integer.parseInt(request.getParameter("cnt"));
      int from = Integer.parseInt(request.getParameter("from"));
    %>
  </head>
  
  <body>
    <style>
      * {
        text-decoration: none;
        color: rgb(230, 230, 230);
      }

      #new {
        width: 70px;
        font-size: larger;
      }

      input {
        background-color: rgb(129, 101, 101);
      }

      #makedata {
        font-size: larger;
        background-color: rgb(211, 153, 8);
      }

      table {
        table-layout: fixed;
      }

      td {
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow: hidden;
      }

      #posts {
        padding-left: 10px;
      }

      #label {
        background-color: rgb(30, 28, 28);
      }

      #nonlabel {
        background-color: rgb(46, 46, 46);
      }

      #controller {
        display: inline-block;
        min-width: 25px;
      }

      .current_page {
        font-weight: bold;
        text-decoration: underline;
      }
    </style>

    <script>
      function makeData() {
        if (confirm("초기화 하시겠습니까?")) {
          window.location='makedata.jsp';
        }
      }
    </script>
    <table width="90%" align="center">
      <td width="300"><h1 id="title">자유게시판 🔥</h1></td>
      <td></td>
      <td width="40"><input type="button" id="makedata" value="⚠" onclick="makeData()"></td>
    </table>
    
    <table cellspacing="1" width="90%" border="1" align="center">
      <tr id="label">
        <td width="10%"><p align="center">번호</p></td>
        <td><p align="center">제목</p></td>
        <td width="10%"><p align="center">조회수</p></td>
        <td width="15%"><p align="center">등록일</p></td>
      </tr>

      <%
        ResultSet rset = stmt.executeQuery("SELECT count(*) FROM forum;");
        rset.next();
        int totalPosts = rset.getInt(1);

        rset = stmt.executeQuery("SELECT * FROM forum ORDER BY rootid DESC, reply_level ASC, reply_order ASC LIMIT " + from + ", " + cnt + ";");

        while (rset.next()) {
          out.println("<tr id='nonlabel'>");
          out.println("<td><p align='center'>" + rset.getInt(1) + "</p></td>");

          if (rset.getInt(6) == 0) { // 원글이면
            out.println("<td><a href='forum_view.jsp?id=" + rset.getInt(1) + "' id='posts'>" + rset.getString(2));
          } else { // 댓글이면
            out.println("<td><a href='forum_view.jsp?id=" + rset.getInt(1) + "' id='posts'>");
            for (int i = 0; i < rset.getInt(6); i++) {
              out.print("&nbsp&nbsp&nbsp&nbsp");
            }
            out.println("<b>↪&nbsp[Re]</b>&nbsp" + rset.getString(2));
          }
          if (rset.getInt(8) == 0) { // 조회수가 0이면
            out.println("&nbsp<b>[New]</b></td>");
          } else {
            out.println("</td>");
          }

          out.println("<td><p align='center'>" + rset.getInt(8) + "</p></td>");
          out.println("<td><p align='center'>" + rset.getDate(3) + "</p></td>");
          out.println("</tr>");
        }

        rset.close();
        stmt.close();
        conn.close();
      %>
    </table>
    
    <%
      final int DISPLAYED_PAGES = 10; // 화면 하단에 몇개의 페이지를 나타낼지
      final int FROM_FIRST = from / (cnt * DISPLAYED_PAGES) * (cnt * DISPLAYED_PAGES); // 화면 하단에 처음으로 나올 페이지의 from

      out.println("<p align=center>");
      if (FROM_FIRST == 0) { // 화면하단에 첫페이지가 1페이지면
        out.println("<a id='controller' href='forum_list.jsp?from=" + FROM_FIRST + "&cnt=" + cnt + "'><<</a>"); // 현재 그룹의 첫번째 페이지로
      } else { // 그렇지 않으면
        out.println("<a class='controller' href='forum_list.jsp?from=" + (FROM_FIRST - cnt) + "&cnt=" + cnt + "'><<</a>"); // 이전 그룹의 마지막 페이지로
      }

      int i = 0;
      for (i = 0; i < DISPLAYED_PAGES; i++) { // 화면 하단에 페이지 넘버 나타내기
        if ((FROM_FIRST + i * cnt) >= totalPosts) {
          break;
        }

        if (from == (FROM_FIRST + i * cnt)) { // 현재 페이지면 굵은 글씨로
          out.println("<a class='current_page' id='controller' href='forum_list.jsp?from=" + (FROM_FIRST + i * cnt) + "&cnt=" + cnt + "'>" + (FROM_FIRST / cnt + i + 1) + "</a>");
        } else { // 그외에는 일반 글씨로
          out.println("<a id='controller' href='forum_list.jsp?from=" + (FROM_FIRST + i * cnt) + "&cnt=" + cnt + "'>" + (FROM_FIRST / cnt + i + 1) + "</a>");
        }
      }

      if ((FROM_FIRST + (cnt * DISPLAYED_PAGES)) >= totalPosts) {
        out.println("<a id='controller' href='forum_list.jsp?from=" + (FROM_FIRST + (i - 1) * cnt) + "&cnt=" + cnt + "'>>></a>"); // 다음 그룹의 첫번째 페이지로
      } else {
        out.println("<a id='controller' href='forum_list.jsp?from=" + (FROM_FIRST + (cnt * DISPLAYED_PAGES)) + "&cnt=" + cnt + "'>>></a>"); // 다음 그룹의 첫번째 페이지로
      }
      out.println("</p>");
    %>

    <table width="90%" align="center">
      <tr>
        <td></td>
        <td width="70"><input type="button" id="new" value="신규" onclick="window.location='forum_insert.jsp'"></td>
      </tr>
    </table>
  </body>
</html>