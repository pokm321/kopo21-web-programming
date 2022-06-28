<html>
  <head>
  </head>
  <body>
    <%
    String arr[] = new String[] {"111", "222", "333"};
    try {
      out.println(arr[2] + "<br>");
    } catch (Exception e) {
      out.println("error==>" + e + "<=========<br>");
    }
    %>
    Good...
  </body>
</html>