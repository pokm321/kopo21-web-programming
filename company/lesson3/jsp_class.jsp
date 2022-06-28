<html>
  <head>
    <%!
    private class AA {
      private int Sum(int i, int j) {
        return i + j;
      }
    }
    AA aa = new AA();
    %>
  </head>
  <body>
    <% out.println("2 + 3 =" + aa.Sum(2, 3)); %> <br>
    Good...
  </body>
</html>