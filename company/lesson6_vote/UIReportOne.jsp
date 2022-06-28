<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*, javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.ParserConfigurationException, org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.NodeList, org.xml.sax.SAXException" %>

<html>
  <hea<body>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <table>
      <%
        DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
        Document doc = docBuilder.parse("http://192.168.23.30:8080/company/lesson6_vote/reportOne.jsp?id=" + request.getParameter("id")); // 가져올 xml의 URL
    
        NodeList tag_hubo = doc.getElementsByTagName("hubo"); // xml hubo tag
        NodeList tag_age = doc.getElementsByTagName("age"); // xml age tag
        NodeList tag_pyosu = doc.getElementsByTagName("pyosu"); // xml pyosu tag
        NodeList tag_pyoyul = doc.getElementsByTagName("pyoyul"); // xml pyoyul tag

        out.println("<h1>" + tag_hubo.item(0).getFirstChild().getNodeValue() + " 후보 득표성향 분석</h1>");
        
        for (int i = 0; i < tag_age.getLength(); i++) {
          int barlength = Integer.parseInt(tag_pyoyul.item(i).getFirstChild().getNodeValue()) * 6 + 5;

          out.println("<tr>");
          out.println("<td id='agetd'>" + tag_age.item(i).getFirstChild().getNodeValue() + "대</td>");
          out.println("<td id='bartd'><span id='bar' style='width: " + barlength + "px;'> </span>&nbsp &nbsp" + tag_pyosu.item(i).getFirstChild().getNodeValue() + "(" + tag_pyoyul.item(i).getFirstChild().getNodeValue() + "%)</td>");
          out.println("</tr>");
        }
      %>
    </table>
  </body>
</html>