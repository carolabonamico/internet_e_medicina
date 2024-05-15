<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<!-- ==================================== Tagliola =================================== --> 
<c:set var="ruolo_pagina" value="RESP"/>
<%@ include file="autorizzazione.jspf" %>

<%@ include file="LAYOUT_TOP.jspf"%>
<%@ include file="LAYOUT_MENU_RESP.jspf"%>


<!-- ==================== Corpo Centrale ===================== -->
<sql:query var="nome">
  SELECT NOME, COGNOME, SESSO
  FROM RESP
  WHERE ID_RESP = ?
  <sql:param value="${id_user}"/>
</sql:query>

<sql:query var="studio_rivisto">
SELECT ID_SSC 
FROM SSC
where RIVISTO = 1
</sql:query>

  <!-- ============================ Notifiche in ingresso=========================== -->
  <tr>
    <td align="center">
      <h2><c:if test="${nome.rows[0].SESSO == 'M'}">Benvenuto</c:if><c:if test="${nome.rows[0].SESSO == 'F'}">Benvenuta</c:if> Responsabile ${nome.rows[0].COGNOME} ${nome.rows[0].NOME}</h2>
      <h4><i>Ora e' possibile navigare nella sua area riservata.<br/></i></h4>
    </td>
  </tr>

  <c:if test="${empty studio_rivisto.rows}">
  <tr>
    <td align="center">
      <img src="welcome.png" height="150" alt="welcome"><br/>
    </td>
  </tr>

  <tr>
    <td align="center">
      <table style="border-bottom:4px solid #2a5951; border-top:4px solid #2a5951;" cellpadding="10">
        <tr>
          <td align="center">
            Non sono presenti studi da rivedere. Per visualizzare gli studi personali, premere qui!
          </td>
          <td align="center">
            <form method="post" action="RESP_studi_pers_DEF.jsp">
             <input type="submit" value="Vai ai dettagli" style="color:#2a5951"/>
           </form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  </c:if>

  <c:if test="${not empty studio_rivisto.rows}">
  <tr>
    <td align="center">
      <img src="notification.png" height="150" alt="Notifica"><br/>
    </td>
  </tr>

  <tr>
    <td align="center">
      <table style="border-bottom:4px solid #2a5951; border-top:4px solid #2a5951;" cellpadding="10">
        <tr>
          <td align="center">
            E' presente uno studio da rivedere. Per visualizzarlo, premere qui!
          </td>
          <td align="center">
          <form method="post" action="RESP_studi_pers_DEF.jsp">
             <input type="submit" value="Vai ai dettagli" style="color:#2a5951"/>
           </form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  </c:if>

<%@ include file="LAYOUT_BOTTOM.jspf" %>