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

<c:if test="${not empty param.flag_assenza}">
  <c:set var="assenza" value="Assente"/>
  <c:set var="stato_pres" value="1"/>

  <sql:update>
    UPDATE APPUNTAMENTO SET PRESENZA = ?
    WHERE ID_APPUNT = ?
    <sql:param value="${assenza}"/>
    <sql:param value="${param.id_appunt}"/>
  </sql:update>

  <sql:update>
    UPDATE APPUNTAMENTO SET STATO_PRES = ?
    WHERE ID_APPUNT = ?
    <sql:param value="${stato_pres}"/>
    <sql:param value="${param.id_appunt}"/>
  </sql:update>

  <c:if test="${not empty param.salute_paz}">
    <sql:update>
      UPDATE APPUNTAMENTO SET NOTE = ?
      WHERE ID_APPUNT = ?
      <sql:param value="${param.salute_paz}"/>
      <sql:param value="${param.id_appunt}"/>
    </sql:update>
  </c:if>
</c:if>

<c:if test="${not empty param.flag_presenza}">
  <c:set var="presenza" value="Presente"/>
  <c:set var="stato_pres" value="1"/>

  <sql:update>
    UPDATE APPUNTAMENTO SET PRESENZA = ?
    WHERE ID_APPUNT = ?
    <sql:param value="${presenza}"/>
    <sql:param value="${param.id_appunt}"/>
  </sql:update>

  <sql:update>
    UPDATE APPUNTAMENTO SET STATO_PRES = ?
    WHERE ID_APPUNT = ?
    <sql:param value="${stato_pres}"/>
    <sql:param value="${param.id_appunt}"/>
  </sql:update>

  <c:if test="${not empty param.salute_paz}">
    <sql:update>
      UPDATE APPUNTAMENTO SET NOTE = ?
      WHERE ID_APPUNT = ?
      <sql:param value="${param.salute_paz}"/>
      <sql:param value="${param.id_appunt}"/>
    </sql:update>
  </c:if>
</c:if>

<%-- query di controllo per verificare che il paziente abbia effettuato tutti gli appunamenti --%>

<sql:query var="ctrl_appunt">
  SELECT COUNT(*) as NUM_PRESENZE
  FROM APPUNTAMENTO A, AVERE_APPUNT V, ISCRIZIONE I
  WHERE A.ID_APPUNT = V.ID_APPUNT AND V.ID_ISCRIZIONE = I.ID_ISCRIZ
  AND A.STATO_PRES = 1 AND A.PRESENZA ="Presente"
  AND I.ID_ISCRIZ = ?
  AND I.ID_SSC=?
  <sql:param value="${param.id_iscriz}"/>
  <sql:param value="${param.id_ssc}"/>
</sql:query>

<sql:query var="app_previsti">
  SELECT TOTCONV
  FROM SSC
  WHERE ID_SSC = ?
  <sql:param value="${param.id_ssc}"/>
</sql:query>

<c:if test="${ app_previsti.rows[0].TOTCONV == ctrl_appunt.rows[0].NUM_PRESENZE}">
  <%-- setto tramite query lo stato del paziente uguale a 50--%>
  <sql:update>
    UPDATE ISCRIZIONE SET COD_STATO_PAZ = 50
    WHERE ID_ISCRIZ = ?
    <sql:param value="${param.id_iscriz}"/>
  </sql:update>
</c:if>


<%-- controllo che tutti i paz siano testati--%>
<%-- estrazione dei testati --%>

<sql:query var="testati">
 SELECT COUNT(*) AS TESTATI
 FROM ISCRIZIONE
 WHERE COD_STATO_PAZ = 50
 AND ID_SSC = ?
 <sql:param value="${param.id_ssc}"/>
</sql:query>

<%-- estrazione dei pazienti totali --%>

<sql:query var="N_PAZ">
 SELECT TOTPAZ
 FROM SSC
 WHERE ID_SSC = ?
 <sql:param value="${param.id_ssc}"/>
</sql:query>


<c:choose>
<c:when test="${testati.rows[0].TESTATI < N_PAZ.rows[0].TOTPAZ}">

<jsp:forward page="RESP_presenz_appunt.jsp"/>
</c:when><c:otherwise>

 <%-- qyery per lo statto dello studio --%>
 <sql:update>
 UPDATE SSC SET COD_STATO_STUDIO = 60
 WHERE ID_SSC = ?
 <sql:param value="${param.id_ssc}"/>
 </sql:update>



 <sql:query var="paz_iscritti">
  SELECT ID_ISCRIZ
  FROM ISCRIZIONE
  WHERE COD_STATO_PAZ = 10
  AND ID_SSC= ?
  <sql:param value="${param.id_ssc}"/>
 </sql:query>



 <sql:query var="paz_arruolati">
  SELECT ID_ISCRIZ
  FROM ISCRIZIONE
  WHERE COD_STATO_PAZ = 20
  AND ID_SSC= ?
  <sql:param value="${param.id_ssc}"/>
 </sql:query>



 <%-- query per settare da iscritto a scartato --%>
 <sql:update>
 UPDATE ISCRIZIONE SET COD_STATO_PAZ = 30
 WHERE ID_ISCRIZ = ?
 <sql:param value="${paz_iscritti.rows[0].ID_ISCRIZ}"/>
 </sql:update>



<%-- query per settare da arruolato a drop out --%>
 <sql:update>
 UPDATE ISCRIZIONE SET COD_STATO_PAZ = 40
 WHERE ID_ISCRIZ = ?
 <sql:param value="${paz_arruolati.rows[0].ID_ISCRIZ}"/>
 </sql:update>
</c:otherwise>
</c:choose>

<jsp:forward page="RESP_presenz_appunt.jsp"/>
