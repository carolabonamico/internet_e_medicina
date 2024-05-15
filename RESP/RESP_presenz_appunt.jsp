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

<sql:query var="rset_filtro">
  SELECT DISTINCT S.NOME_STUDIO, S.ID_SSC
  FROM SSC S, ISCRIZIONE I
  WHERE I.ID_SSC = S.ID_SSC
  AND S.ID_RESP= ?
  <sql:param value="${id_user}"/>
</sql:query>

<%--estraggo gli appunamenti in base allo studio selezionato--%>
<c:if test="${not empty param.studio_select && param.studio_select != ''}">
<sql:query var="set_presenze">
  SELECT A.ID_APPUNT, P.NOME, P.COGNOME, P.EMAIL, I.ID_ISCRIZ,
         P.TELEFONO, S.NOME_STUDIO, A.DATA_ORA, I.ID_PAZ
    FROM APPUNTAMENTO A, ISCRIZIONE I, AVERE_APPUNT AV, PAZ P, SSC S
    WHERE A.ID_APPUNT=AV.ID_APPUNT AND I.ID_ISCRIZ=AV.ID_ISCRIZIONE
    AND I.ID_PAZ=P.ID_PAZ AND I.ID_SSC = S.ID_SSC
    AND A.STATO_PRES = 2
    AND S.ID_RESP = ?
    AND S.ID_SSC = ?
    <sql:param value="${id_user}"/>
    <sql:param value="${param.studio_select}"/>
    GROUP  BY A.ID_APPUNT, P.NOME, P.COGNOME
    ORDER BY A.DATA_ORA
</sql:query>
</c:if>


<!-- ==================== Corpo Centrale ===================== -->

<tr>
  <td align="center" colspan="3">
    <img src="check.png" height="150" alt="Presenti"/><br/>
    <h3 align="center" style="color:#25544E">Elenco pazienti presenti (autocertificati)</h3>
    <p>
      <i>In questa sezione e' visibile l'elenco dei pazienti che hanno autocertificato almeno una  presenza ad un appuntamento. </i>
    </p>
  </td>
</tr>

<tr>
<td>
<!-- ==== ZONA DI SELEZIONE DELLO STUDIO CLINICO DA PRENDERE IN ANALISI ==== -->
<table valign="middle" align="center" border="0"
  width="60%" cellspacing="0" cellpadding="10" style="color:#25544E">
  <tr bgcolor="#f2f2f2" height="60" width="15%">
    <td><b>Selezionare lo studio del quale si vogliono vedere i pazienti:</b></td>
    <td align="left">

     <form action="#" method="post">
      <select name="studio_select" onChange="this.form.submit();">
        <option value="">-- Area --</option>
        <c:forEach items="${rset_filtro.rows}" var="studio">
          <option value="${studio.ID_SSC}"
            <c:if test="${param.studio_select == studio.ID_SSC}">
            selected="selected"
            </c:if>
            > ${studio.NOME_STUDIO} - ${studio.ID_SSC}</option>
        </c:forEach>
      </select>
      </form>
    </td>
  </tr>
</table>
 </td>
</tr>
<!-- -------------------- Tabella -------------------- -->
<tr width="100%">
  <td align="center">
    <table valign="middle" align="center" border="0" width="60%" cellspacing="0" cellpadding="15">
       <tr bgcolor="#2a5951" style="color:white" height="60">
          <th> Nome </th>
          <th> Cognome </th>
          <th> Indirizzo email </th>
          <th> Cellulare </th>
          <th> Studio di partecipazione </th>
          <th> Data e Ora appuntamento</th>
          <th>&nbsp</th>
      </tr>
      <c:forEach items="${set_presenze.rows}" var="presenze">
      <tr align="center" valign="middle" bgcolor="#f2f2f2"  style="color:#468c7f">
          <td>${presenze.NOME}</td>
          <td>${presenze.COGNOME}</td>
          <td>${presenze.EMAIL}</td>
          <td>${presenze.TELEFONO}</td>
          <td>${presenze.NOME_STUDIO}</td>

          <fmt:formatDate var="data_appunt"
                     value="${presenze.DATA_ORA}"
                     type="both"
                     dateStyle="medium"
                     timeStyle="medium"/>

          <td>${data_appunt}</td>
          <td>
              <form method="post" action="RESP_presenz_appunt_pg2.jsp">
                <input type="submit" value="Conferma Presenza" style="color:#25544E" />
                <input type="hidden" name="id_appunt" value="${presenze.ID_APPUNT}"/>
                <input type="hidden" name="nome" value="${presenze.NOME}"/>
                <input type="hidden" name="cognome" value="${presenze.COGNOME}"/>
                <input type="hidden" name="data" value="${data_appunt}"/>
                <input type="hidden" name="id_iscriz" value="${presenze.ID_ISCRIZ}"/>
                <input type="hidden" name="id_ssc" value="${param.studio_select}"/>
                <input type="hidden" name="id_paz" value="${presenze.ID_PAZ}"/>
              </form>
          </td>
        </tr>
       </c:forEach>
      </table>
  </td>
</tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>
