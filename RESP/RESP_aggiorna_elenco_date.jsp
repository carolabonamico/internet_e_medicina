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

<!-- controllo che tutti i campi siano inseriti-->
<c:if test="${ empty param.appuntamento_paz ||
               empty param.luogo_appunt ||
               empty param.dettagli_luogo_appunt}">
  <c:set var="errmsg" scope="request"> E' necessario inserire tutti i campi</c:set>

  <c:if test="${empty param.appuntamento_paz}">
    <c:set var="errdata" scope="request" value="true"/>
  </c:if>

  <c:if test="${empty param.luogo_appunt}">
    <c:set var="errluogo" scope="request" value="true"/>
  </c:if>

  <c:if test="${empty param.dettagli_luogo_appunt}">
    <c:set var="errdettaglio" scope="request" value="true"/>
  </c:if>

<%-- ripasso l'id iscrizione e l'id paziente per non sfasciare la pagina dopo --%>
  <c:set var="id_iscriz" scope="request">${param.id_iscriz}</c:set>
  <c:set var="id_paz" scope="request">${param.id_paz}</c:set>
  <c:set var="totconv" scope="request">${param.totconv}</c:set>

  <c:set var="data_inizio" scope="request"> ${param.data_inizio}</c:set>
  <c:set var="data_fine" scope="request">${param.data_fine}</c:set>

  <jsp:forward page="RESP_appunt_paz.jsp"/>
</c:if>

<!-- parsing della data-->
<fmt:parseDate  value="${param.appuntamento_paz}"
                var="data_ora"
                pattern="yyyy-MM-dd'T'HH:mm"
                type="both"
                dateStyle="medium"
                timeStyle="medium"/>

<%-- CONTATORE --%>
<sql:transaction>
  <sql:query var="rset_codice">
   SELECT valore
   FROM CONTATORI
   where attributo = 'APPUNTAMENTI'
  </sql:query>
  <c:set var="id_appunt" value="${rset_codice.rows[0].valore}"/>

  <sql:update>
   UPDATE CONTATORI set valore = valore + 1
   WHERE attributo = 'APPUNTAMENTI'
  </sql:update>
</sql:transaction>


<!-- inserimento dei dati nel db -->
<sql:update>
  INSERT INTO APPUNTAMENTO (ID_APPUNT, LUOGO, DETTAGLI_LUOGO, DATA_ORA)
  VALUES (?,?,?,?)
  <sql:param value="${id_appunt}"/>
  <sql:param value="${param.luogo_appunt}"/>
  <sql:param value="${param.dettagli_luogo_appunt}"/>
  <sql:dateParam value="${data_ora}" type="timestamp"/>
</sql:update>

<sql:update>
  INSERT INTO AVERE_APPUNT (ID_APPUNT,ID_ISCRIZIONE)
  VALUES(?,?)
  <sql:param value="${id_appunt}"/>
  <sql:param value="${param.id_iscriz}"/>
</sql:update>

<sql:query var="insert_ok">
  SELECT ID_APPUNT
  FROM APPUNTAMENTO
  WHERE ID_APPUNT=?
  <sql:param value="${id_appunt}"/>
</sql:query>

<c:if test="${not empty insert_ok.rows}">
  <c:set var="okmsg" scope="request"> L'appuntamento e' stato inserito correttamente </c:set>
  <%--<c:set var="flag_appunt" value="true" scope="request"/> --%>

<%-- ripasso l'id iscrizione e l'id paziente per non sfasciare la pagina dopo --%>
  <c:set var="id_iscriz" scope="request">${param.id_iscriz}</c:set>
  <c:set var="id_paz" scope="request">${param.id_paz}</c:set>
  <c:set var="totconv" scope="request">${param.totconv}</c:set>

  <c:set var="data_inizio" scope="request"> ${param.data_inizio}</c:set>
  <c:set var="data_fine" scope="request">${param.data_fine}</c:set>

  <jsp:forward page="RESP_appunt_paz.jsp"/>
</c:if>
