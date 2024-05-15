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
<c:set var="ruolo_pagina" value="PAZ"/>
<%@ include file="autorizzazione.jspf" %>

<c:if test="${param.vis_med == 1 && empty param.medico}">
  <jsp:forward page="PAZ_confermapartecipa.jsp">
    <jsp:param name="msg" value="Per proseguire e' necessario scegliere un medico."/>
    <jsp:param name="nome_studio" value="${param.nome_studio}"/>
    <jsp:param name="id_ssc" value="${param.id_ssc}"/>
    <jsp:param name="incentivo" value="${param.incentivo}"/>
    <jsp:param name="posizione_studio" value="${param.posizione_studio}"/>
    <jsp:param name="id_iscrizione" value="${param.id_iscrizione}"/>
    <jsp:param name="vis_med" value="${param.vis_med}"/>
  </jsp:forward>
</c:if>

<c:set var="cod_stato_paz" value="10"/>

<%-- CONTATORE ISCRIZIONE --%>
<sql:transaction>
  <sql:query var="rset_codice">
   SELECT valore
   FROM CONTATORI
   where attributo = 'ISCRIZIONI'
  </sql:query>
  <c:set var="nuovo_codice" value="${rset_codice.rows[0].valore}"/>

  <sql:update>
   UPDATE CONTATORI set valore = valore + 1
   WHERE attributo = 'ISCRIZIONI'
  </sql:update>
</sql:transaction>

<c:if test="${param.vis_med == 1 && not empty param.medico}">
<%-- CONTATORE VISITA --%>
<sql:transaction>
  <sql:query var="rset_codice_visita">
   SELECT valore
   FROM CONTATORI
   where attributo = 'VISITA'
  </sql:query>
  <c:set var="nuovo_codice_visita" value="${rset_codice_visita.rows[0].valore}"/>

  <sql:update>
   UPDATE CONTATORI set valore = valore + 1
   WHERE attributo = 'VISITA'
  </sql:update>
</sql:transaction>
</c:if>

<%-- DATA CORRENTE --%>
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" var="data_ora_iscrizione"
  pattern="yyyy-MM-dd HH:mm:ss"/>

<fmt:parseDate value="${data_ora_iscrizione}" var="data_ora"
  pattern="yyyy-MM-dd HH:mm:ss"/>

<c:if test="${param.vis_med == 1 && not empty param.medico}">
<%--INSERIMENTO NELLA TABELLA DELLE ISCRIZIONI--%>
<sql:transaction>
  <sql:update>
    INSERT INTO ISCRIZIONE(ID_ISCRIZ, ID_PAZ, COD_STATO_PAZ, ID_SSC, 
    DATA_ISCRIZIONE, ID_VISITA)
    VALUES(?,?,?,?,?,?)
    <sql:param value="${nuovo_codice}"/>
    <sql:param value="${id_user}"/>
    <sql:param value="${cod_stato_paz}"/>
    <sql:param value="${param.id_ssc}"/>
    <sql:dateParam value="${data_ora}" type="timestamp"/>
    <sql:param value="${nuovo_codice_visita}"/>
  </sql:update>
</sql:transaction>

<%--INSERIMENTO NELLA TABELLA DELLE VISITE--%>
<sql:transaction>
  <sql:update>
    INSERT INTO ESITO_VISITA(ID_VISITA,ID_MED)
    VALUES(?,?)
    <sql:param value="${nuovo_codice_visita}"/>
    <sql:param value="${param.medico}"/>
  </sql:update>
</sql:transaction>
</c:if>

<c:if test="${param.vis_med == 0}">
  <%--INSERIMENTO NELLA TABELLA DELLE ISCRIZIONI--%>
  <sql:transaction>
    <sql:update>
      INSERT INTO ISCRIZIONE(ID_ISCRIZ, ID_PAZ, COD_STATO_PAZ, ID_SSC, 
      DATA_ISCRIZIONE)
      VALUES(?,?,?,?,?)
      <sql:param value="${nuovo_codice}"/>
      <sql:param value="${id_user}"/>
      <sql:param value="${cod_stato_paz}"/>
      <sql:param value="${param.id_ssc}"/>
      <sql:dateParam value="${data_ora}" type="timestamp"/>
    </sql:update>
  </sql:transaction>
</c:if>

<c:set var="confpart" scope="request" value="true"/>

<jsp:forward page="PAZ_imieistudi.jsp">
  <jsp:param name="nome_studio_att2" value="${param.nome_studio_att}"/>
</jsp:forward>