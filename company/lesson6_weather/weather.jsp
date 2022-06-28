<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*, javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.ParserConfigurationException, org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.NodeList, org.xml.sax.SAXException" %>
<html>
<style>
  table {
    width: 95%;
    margin: auto;
    text-align: center;
    border: 3px solid black;
    border-collapse: collapse;
  }

  tr {
    border: 1px solid black;
  }
  
  td {
    padding: 5px;
    border: 1px dashed darkgray;
    white-space: nowrap;
  }

  #label {
    background-color: dimgrey;
    color: aliceblue;
    font-weight: bold;
  }

  #coloredTr {
    background-color: rgb(228, 228, 228);
  }

  h1 {
    text-align: center;
  }
</style>
<%
  DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
  //Document doc = docBuilder.parse(new File("/var/lib/tomcat9/webapps/ROOT/company/lesson6/testdata.xml")); // local path
  int gridx = 61;
  int gridy = 123;
  Document doc = docBuilder.parse("http://www.kma.go.kr/wid/queryDFS.jsp?gridx=" + gridx + "&gridy=" + gridy); // URL
  
  Element root = doc.getDocumentElement(); // root태그를 가져오기도함. 지금은 안씀
  NodeList tag_001 = doc.getElementsByTagName("data"); // xml data tag
  
  out.println("<h1>" + "좌표 (" + gridx + ", " + gridy + ") 의 날씨</h1>");
  out.println("<table>");
  out.println("<tr id='label'>");
  out.println("<td>번호</td>");
  out.println("<td>시간</td>");
  out.println("<td>현재온도</td>");
  out.println("<td>최저/최고 (ºC)</td>"); 
  out.println("<td>날씨</td>"); 
  out.println("<td>강수확률</td>"); 
  out.println("<td>6시간 강수량/적설량 (mm)</td>"); 
  out.println("<td>12시간 강수량/적설량 (mm)</td>"); 
  out.println("<td>풍속(m/s)</td>"); 
  out.println("<td>풍향</td>"); 
  out.println("<td>습도</td>"); 
  out.println("</tr>");
  
  // 태그이름으로 가져온 값들을 순서대로 표에 출력
  for (int i = 0; i < tag_001.getLength(); i++) {
    Element elmt = (Element) tag_001.item(i);
    
    String seq = tag_001.item(i).getAttributes().getNamedItem("seq").getNodeValue();
    String hour = elmt.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue();
    String day = elmt.getElementsByTagName("day").item(0).getFirstChild().getNodeValue();
    String temp = elmt.getElementsByTagName("temp").item(0).getFirstChild().getNodeValue();
    String tmx = elmt.getElementsByTagName("tmx").item(0).getFirstChild().getNodeValue();
    String tmn = elmt.getElementsByTagName("tmn").item(0).getFirstChild().getNodeValue();
    String wfKor = elmt.getElementsByTagName("wfKor").item(0).getFirstChild().getNodeValue();
    String pop = elmt.getElementsByTagName("pop").item(0).getFirstChild().getNodeValue();
    String r12 = elmt.getElementsByTagName("r12").item(0).getFirstChild().getNodeValue();
    String s12 = elmt.getElementsByTagName("s12").item(0).getFirstChild().getNodeValue();
    String ws = elmt.getElementsByTagName("ws").item(0).getFirstChild().getNodeValue().substring(0, 3);
    String wdKor = elmt.getElementsByTagName("wdKor").item(0).getFirstChild().getNodeValue();
    String reh = elmt.getElementsByTagName("reh").item(0).getFirstChild().getNodeValue();
    String r06 = elmt.getElementsByTagName("r06").item(0).getFirstChild().getNodeValue();
    String s06 = elmt.getElementsByTagName("s06").item(0).getFirstChild().getNodeValue();
    
    if (i % 2 != 0) {
      out.println("<tr id='coloredTr'>");
    } else {
      out.println("<tr>");
    }
    out.println("<td>" + seq + "</td>");

    if (day.equals("0")) {
      out.println("<td>" + "금일 " + hour + "시" + "</td>");
    } else if (day.equals("1")) {
      out.println("<td>" + "내일 " + hour + "시" + "</td>");
    } else {
      out.psrintln("<td>" + day + "일 뒤 " + hour + "시" + "</td>");
    }

    out.println("<td>" + temp + " ºC</td>");

    if (tmx.equals("-999.0")) {
      tmx = "-";
    }
    if (tmn.equals("-999.0")) {
      tmn = "-";
    }
    out.println("<td >" + tmn + " / " + tmx + "</td>"); 

    out.println("<td >" + wfKor + "</td>"); 
    
    out.println("<td >" + pop + " %</td>"); 

    if (r06.equals("0.0")) {
      r06 = "-";
    }
    if (s06.equals("0.0")) {
      s06 = "-";
    }
    if (r12.equals("0.0")) {
      r12 = "-";
    }
    if (s12.equals("0.0")) {
      s12 = "-";
    }
    out.println("<td >" + r06 + " / " + s06 + "</td>"); 
    out.println("<td >" + r12 + " / " + s12 + "</td>"); 
    out.println("<td >" + ws + "</td>"); 

    out.println("<td >" + wdKor + "</td>"); 
    out.println("<td >" + reh + " %" + "</td>"); 
    out.println("</tr>");
  }
  out.println("</table>");
  %>
</html>