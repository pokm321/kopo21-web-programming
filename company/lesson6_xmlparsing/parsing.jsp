<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*, javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.ParserConfigurationException, org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.NodeList, org.xml.sax.SAXException" %>
<%
  DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
  //Document doc = docBuilder.parse(new File("/var/lib/tomcat9/webapps/ROOT/company/lesson6/testdata.xml")); // local path
  Document doc = docBuilder.parse("http://192.168.23.30:8080/company/lesson6_xmlparsing/xmlmake.jsp"); // URL

  Element root = doc.getDocumentElement(); // root태그를 가져오기도함. 지금은 안씀
  NodeList tag_name = doc.getElementsByTagName("name"); // xml name tag
  NodeList tag_studentid = doc.getElementsByTagName("studentid"); // xml studentid tag
  NodeList tag_kor = doc.getElementsByTagName("kor"); // xml kor tag
  NodeList tag_eng = doc.getElementsByTagName("eng"); // xml eng tag
  NodeList tag_mat = doc.getElementsByTagName("mat"); // xml mat tag

  out.println("<table cellspacing='1' width='500' border='1'>");
  out.println("<tr>");
  out.println("<td width='100'>이름</td>");
  out.println("<td width='100'>학번</td>");
  out.println("<td width='100'>국어</td>");
  out.println("<td width='100'>영어</td>");
  out.println("<td width='100'>수학</td>");
  out.println("</tr>");

  // 태그이름으로 가져온 값들을 순서대로 표에 출력
  for (int i = 0; i < tag_name.getLength(); i++) {
    out.println("<tr>");
    out.println("<td width='100'>" + tag_name.item(i).getFirstChild().getNodeValue() + "</td>"); // xml name tag
    out.println("<td width='100'>" + tag_studentid.item(i).getFirstChild().getNodeValue() + "</td>"); // xml studentid tag
    out.println("<td width='100'>" + tag_kor.item(i).getFirstChild().getNodeValue() + "</td>"); // xml kor tag
    out.println("<td width='100'>" + tag_eng.item(i).getFirstChild().getNodeValue() + "</td>"); // xml eng tag
    out.println("<td width='100'>" + tag_mat.item(i).getFirstChild().getNodeValue() + "</td>"); // xml mat tag
    out.println("</tr>");
  }
  out.println("</table>");
%>