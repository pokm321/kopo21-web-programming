<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*, javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.ParserConfigurationException, org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.NodeList, org.xml.sax.SAXException" %>

<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css" />
  </head>

  <body>
    <h1>후보 별 득표율</h1>
    <table>
      <%
        DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
        Document doc = docBuilder.parse("http://192.168.23.30:8080/company/lesson6_vote/reportAll.jsp"); // 가져올 xml의 URL
    
        NodeList tag_id = doc.getElementsByTagName("id"); // xml id tag
        NodeList tag_name = doc.getElementsByTagName("name"); // xml name tag
        NodeList tag_voteNumber = doc.getElementsByTagName("voteNumber"); // xml voteNumber tag
        NodeList tag_votePercentage = doc.getElementsByTagName("votePercentage"); // xml votePercentage tag

        for (int i = 0; i < tag_name.getLength(); i++) {
          int barlength = Integer.parseInt(tag_votePercentage.item(i).getFirstChild().getNodeValue()) * 5 + 5;

          out.println("<tr>");
          out.println("<td id='nametd'><a id='button2' href='C_02.jsp?id=" + tag_id.item(i).getFirstChild().getNodeValue() + "'>" + tag_id.item(i).getFirstChild().getNodeValue() + " " + tag_name.item(i).getFirstChild().getNodeValue() + "</a></td>");
          out.println("<td id='bartd'><span id='bar' style='width: " + barlength + "px;'> </span>&nbsp &nbsp" + tag_voteNumber.item(i).getFirstChild().getNodeValue() + "(" + tag_votePercentage.item(i).getFirstChild().getNodeValue() + "%)</td>");
          out.println("</tr>");
        }
      %>
    </table>
  </body>
</html>