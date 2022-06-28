<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.ArrayList" %> <!-- 자바 import하기 -->
<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21");
      Statement stmt = conn.createStatement();
    
      stmt.execute("USE kopoctc;");
      ResultSet rset = stmt.executeQuery("SELECT * FROM candidate_table;");
    %>
  </head>

  <body>
    <script>
      function checkCharacter(obj) {
        var regExp = /[1234567890\ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
  
        for (var i = obj.value.length - 1; i >= 0; i--) {
          if (regExp.test(obj.value.charAt(i))) {
            obj.value = obj.value.substring(0, i) + obj.value.substring(i + 1, obj.value.length)
            i++;
          }
        }
      }
    </script>

    <table>
      <%
        ArrayList<Integer> idList = new ArrayList<Integer>();
          
        while (rset.next()) {
          idList.add(rset.getInt(1));
          out.println("<tr>");
            out.println("<td id='td1'>기호번호 : " + rset.getInt(1) + "</td>");
            out.println("<td id='td2'>후보명 : " + rset.getString(2) + "</td>");
            out.println("<td id='td3'><a href='A_02.jsp?id=" + rset.getInt(1) + "' id='button'>삭제</a></td>");
          out.println("</tr>");
        }

        int missingID = 0;
        while (true) {
          missingID++;
          if (idList.contains(missingID) == false) {
            break;
          }
        }

        out.println("<form action='A_03.jsp'>");
          out.println("<tr>");
            out.println("<td id='td1'>기호번호 : <input type='number' min='1' max='999' name='id' value='" + missingID + "'></td>");
            out.println("<td id='td2'>후보명 : <input type='text' name='name' maxlength='13' onkeyup='checkCharacter(this)' onkeydown='checkCharacter(this)'></td>");
            out.println("<td id='td3'><input type='submit' id='button' value='추가'></td>");
          out.println("</tr>");
        out.println("</form>");
            
        rset.close();
        stmt.close();
        conn.close();
      %>
    </table>
  </body>
</html>