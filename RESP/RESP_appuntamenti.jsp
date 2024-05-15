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

<!--=================== Estrazione dei dati utili per il filtro =============-->
<sql:query var="rset_filtro">
  SELECT DISTINCT S.NOME_STUDIO, S.ID_SSC
  FROM SSC S, ISCRIZIONE I
  WHERE I.ID_SSC = S.ID_SSC
  AND S.ID_RESP= ?
  <sql:param value="${id_user}"/>
</sql:query>

<!--ESTRAGGO I DATI CHE MI SERVONO NELLE RIGHE DELLA TABELLA-->
<c:if test="${not empty param.studio_select && param.studio_select != ''}">
<sql:query var="estraz_dati">
  SELECT P.NOME, P.COGNOME, P.CODICE_FISC, P.EMAIL, P.TELEFONO, P.ID_PAZ, I.ID_ISCRIZ, S.TOTCONV, S.NOME_STUDIO
  FROM SSC S, ISCRIZIONE I, PAZ P
  WHERE I.ID_PAZ = P.ID_PAZ AND I.ID_SSC = S.ID_SSC
  AND COD_STATO_PAZ = 20
  AND S.ID_SSC=?
  <sql:param value="${param.studio_select}"/>
</sql:query>
</c:if>

<!-- ==================== Corpo Centrale ===================== -->
<tr>
  <td align="center" colspan="2">
  <img src="pianifica_app.png" height="150"/><br/>
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

<tr>
  <td align="center">
    <h3 align="center" style="color:#25544E">
    Elenco pazienti per lo studio riguardante ${estraz_dati.rows[0].NOME_STUDIO}:
    </h3>

    <table valign="middle" align="center" border="0" width="100%" cellspacing="0" cellpadding="15">
                <tr bgcolor="#2a5951" style="color:white" height="60">
            <th> Nome </th>
            <th> Cognome </th>
            <th> Codice Fiscale </th>
            <th> Indirizzo email </th>
            <th> Cellulare </th>
            <th> Stato calendario</th>
            <th>&nbsp</th>
        </tr>

        <c:forEach items="${estraz_dati.rows}" var="dati">
        <tr align="center" bgcolor="#f2f2f2" style="color:#468c7f">
            <td>${dati.NOME}</td>
            <td>${dati.COGNOME}</td>
            <td>${dati.CODICE_FISC}</td>
            <td>${dati.EMAIL}</td>
            <td>${dati.TELEFONO}</td>
            <td>
        <%-- compio una query per ogni riga che mi permette di settare lo stato del calendario --%>

              <sql:query var="num_app">
                SELECT COUNT(*) as num_app
                FROM AVERE_APPUNT V, APPUNTAMENTO A
                WHERE V.ID_APPUNT = A.ID_APPUNT
                AND A.STATO_PRES = 3
                AND V.ID_ISCRIZIONE= ?
                <sql:param value="${dati.ID_ISCRIZ}"/>
              </sql:query>

        <%-- controllo che il calendario sia pieno--%>
              <c:choose>
              <c:when test="${num_app.rows[0].num_app == dati.TOTCONV}">
                <c:set var="stato_cal" value="Completato"/>
                ${stato_cal}
              </c:when><c:otherwise>
              <c:set var="stato_cal" value="Da definire"/>
                ${stato_cal}
              </c:otherwise>
              </c:choose>
            </td>
            <td>

            <c:choose>
            <c:when test="${stato_cal == 'Da definire'}">
              <form method="post" action="RESP_appunt_paz.jsp">
                <input type="submit" value="Appuntamenti" style="color:#25544E" />

                <input type="hidden" name="id_paz" value="${dati.ID_PAZ}"/>
                <input type="hidden" name="id_iscriz" value="${dati.ID_ISCRIZ}"/>
                <input type="hidden" name="nome_studio" value="${dati.NOME_STUDIO}"/>
                <input type="hidden" name="totconv" value="${dati.TOTCONV}"/>
                <input type="hidden" name="id_ssc" value="${param.studio_select}">
              </form>
              </c:when><c:otherwise>
              &nbsp
              </c:otherwise>
            </c:choose>
            </td>
        </tr>
       </c:forEach>
      </table>
  </td>
</tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>
