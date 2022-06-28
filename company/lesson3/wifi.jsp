<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->
<html>
  <head>

  </head>

  <body>
    <%
    BufferedReader br = null;
    try {
      br = new BufferedReader(new FileReader("C:\\Users\\user\\Downloads\\FreeWifiData.txt"));
      String readText;

      if ((readText = br.readLine()) == null) {
        out.println("빈 파일입니다.");
        return;
      }
      String[] field_name = readText.split("\t");

      double my_latitude = 37.3860521;
      double my_longitude = 127.1214038;

      int lineCount = 0;
      while ((readText = br.readLine()) != null) {
        String[] field = readText.split("\t");
        out.println("**[" + lineCount + "번째 항목]************\n");
        out.println(field_name[9] + " : " + field[9]); // 지번주소
        out.println(field_name[12] + " : " + field[12]); // 위도
        out.println(field_name[13] + " : " + field[13]); // 경도
        double distance = Math.sqrt(Math.pow(Double.parseDouble(field[12]) - my_latitude, 2))
            + Math.pow(Double.parseDouble(field[13]) - my_longitude, 2);
        out.println(" 현재지점과의 거리 : " + distance);
        out.println("*******************************************");

        lineCount++;
      }
      br.close();
    } catch (Exception e) {
      out.println("파일읽기 실패");
      return;
    }
    %>
  </body>
  </html>