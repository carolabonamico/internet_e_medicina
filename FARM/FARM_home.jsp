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
<c:set var="ruolo_pagina" value="FARM"/>
<%@ include file="autorizzazione.jspf" %>

<%@ include file="LAYOUT_TOP.jspf"%>
<%@ include file="LAYOUT_MENU_FARM.jspf"%>

<!-- ==================================== QUERY =================================== -->
<sql:query var="nome">
  SELECT NOME_DITTA
  FROM FARM
  WHERE ID_FARM = ?
  <sql:param value="${id_user}"/>
</sql:query>

<sql:query var="studio">
  select ID_SSC from SSC
  where COD_STATO_STUDIO=20 || COD_STATO_STUDIO=40
</sql:query>


<!-- =============================== Corpo Centrale ================================= -->

<tr>
  <td align="center">
    <h2>Benvenuta Ditta Farmaceutica ${nome.rows[0].NOME_DITTA}</h2>
    <h4><i>Ora e' possibile navigare nella sua area riservata.<br/></i></h4>
  </td>
</tr>

<c:if test="${empty studio.rows}">
<tr>
  <td align="center">
    <img src="welcome.png" height="250" alt="welcome"><br/>
  </td>
</tr>

<tr>
  <td align="center">
    <table style="border-bottom:4px solid #2a5951; border-top:4px solid #2a5951;" cellpadding="10">
      <tr>
        <td align="center">
          Non sono presenti studi appena conclusi. Per visualizzare gli studi personali,<a href="FARM_imieistudi.jsp" style="color:#468C7F"><i>premere qui!<br/></i></a>
        </td>
      </tr>
    </table>
  </td>
</tr>
</c:if>

<c:if test="${not empty studio.rows}">
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
          Sono presenti nuovi studi. Per visualizzarli, <a href="FARM_studiclinici.jsp" style="color:#468C7F"><i>premere qui!<br/></i></a>
        </td>
      </tr>
    </table>
  </td>
</tr>
</c:if>

<!-- ==================== Layout finale ===================== -->

<%@ include file="LAYOUT_BOTTOM.jspf" %>