<%@ page session="true"
         language="java"
         contentType="text/html; charset=UTF-8"
         import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<c:set var="ruolo_pagina" value="RESP"/>
<%@ include file="autorizzazione.jspf"%>
<!-- estrazione dei dati della tabella-->
<%--<c:if test="${not empty flag_appunt}">--%>

<sql:query var="rset_appunt">
  SELECT A.ID_APPUNT, A.LUOGO, A.DATA_ORA, A.DETTAGLI_LUOGO, S.NOME_STUDIO
  FROM APPUNTAMENTO A, AVERE_APPUNT V, ISCRIZIONE I, SSC S
  WHERE A.ID_APPUNT = V.ID_APPUNT AND I.ID_ISCRIZ = V.ID_ISCRIZIONE
  AND I.ID_SSC = S.ID_SSC
  AND I.ID_ISCRIZ=?
  AND I.ID_PAZ=?
  <sql:param value="${param.id_iscriz}"/>
  <sql:param value="${param.id_paz}"/>
  ORDER BY A.DATA_ORA
</sql:query>

<sql:query var="date">
  SELECT DATA_INIZIO, DATA_FINE
  FROM SSC
  WHERE ID_SSC = ?
  <sql:param value="${param.id_ssc}"/>
</sql:query>

<fmt:formatDate var="data_inizio"
           value="${date.rows[0].DATA_INIZIO}"
           type="date"
           dateStyle="medium"/>

<fmt:formatDate var="data_fine"
          value="${date.rows[0].DATA_FINE}"
          type="date"
          dateStyle="medium"/>

<sql:query var="dati_paz">
SELECT NOME, COGNOME
FROM PAZ
WHERE ID_PAZ=?
  <sql:param value="${param.id_paz}"/>
</sql:query>

<%-- query per il conteggio degli appuntamenti --%>
<sql:query var="n_appunt">
  SELECT COUNT(*) as num_app
  FROM AVERE_APPUNT
  WHERE ID_ISCRIZIONE= ?
  <sql:param value="${param.id_iscriz}"/>
</sql:query>

<%@ include file="LAYOUT_TOP.jspf"%>
<%@ include file="LAYOUT_MENU_RESP.jspf"%>

<!-- ==================== Corpo Centrale ===================== -->

  <!-- --------------------- Pulsante indietro --------------------- -->
      <tr valign="top">
        <td align="center" width="17%">
         <a href="RESP_appuntamenti.jsp">
            <img src="undo.png" width="40" height="40" title="Indietro">
          </a>
        </td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="16%">&nbsp</td>
        <td width="16%">&nbsp</td>
      </tr>

<!-- Intestazione -->
<tr>
  <td align="center" colspan="6">
    <c:if test="${not empty errmsg}">
      <img src="error.png" height="150" alt="Errore"/><br/>
      <h3><font color="#CC0000">${errmsg}</font></h3>
    </c:if>
    <c:if test="${empty errmsg && empty okmsg}">
      <img src="agenda.png" height="150" alt="Agenda"/><br/>
      <h3 align="center" style="color:#25544E">
      Inserire le date dei vari appuntamenti per lo studio "${param.nome_studio}", del paziente ${dati_paz.rows[0].NOME} ${dati_paz.rows[0].COGNOME}:<br/>
      <i>(Fare attenzione a inserie le date all'interno del periodo dello studio e a inserie tutti i campi.<br>
        ps: data la complessita' del controllo sulle date, quest'ultimo non e' stato inserito)</i> </h3>
    </c:if>
    <c:if test="${not empty okmsg}">
      <img src="check.png" height="100" alt="ok"/><br/>
      <font color="#468c7f"><b>${okmsg}</b></font>
    </c:if>
  </td>
</tr>

<form action="RESP_aggiorna_elenco_date.jsp" method="post">
  <!-- Tabella -->
  <tr>
    <td align="center" colspan="6">
      <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="10" style="color:#468c7f">

        <tr bgcolor="#f2f2f2" height="60" width="15%">
          <td colspan="2"><b>Numero di appuntamenti che il paziente deve fare:</b><br><i>(Il dato e' preso dalle specifiche della SSC)</i></td>
          <td align="left" colspan="2">${param.totconv}</td>
        </tr>
        <tr>
          <td width="25%"><b>Data inizio dello studio</b></td>
          <td width="25%">
            ${data_inizio}
            <c:if test="${not empty param.flag_pass}">
              ${param.data_inizio}
              <c:set var="data_inizio" value="${param.data_inizio}"/>
            </c:if>
          </td>
          <td width="25%"> <b> Data fine dello studio <b></td>
          <td width="25%">
            ${data_fine}
            <c:if test="${not empty param.flag_pass}">
              ${param.data_fine}
              <c:set var="data_fine" value="${param.data_fine}"/>
            </c:if>
          </td>
        </tr>
        <tr bgcolor="#f2f2f2" height="60" width="15%">
          <c:if test="${not empty errdata}">
            <td colspan="2"><font color="#CC0000"><b>Inserire la data dell'appuntamento:</b></font></td>
          </c:if>
          <c:if test="${empty errdata}">
            <td colspan="2"><b>Inserire la data dell'appuntamento:</b></td>
          </c:if>
          <td align="left" colspan="2"><input type="datetime-local" name="appuntamento_paz"></td>
        </tr>
        <tr height="60" width="15%">
          <c:if test="${not empty errluogo}">
            <td colspan="2"><font color="#CC0000"><b>Inserire il luogo in cui si svolgera' l'appuntamento:</b></font></td>
          </c:if>
          <c:if test="${empty errluogo}">
            <td colspan="2"><b>Inserire il luogo in cui si svolgera' l'appuntamento:</b></td>
          </c:if>
          <td colspan="2">
            <textarea name="luogo_appunt" rows="3" cols="50"
            placeholder="Inserire qui il luogo"
            value="${param.luogo_appunt}"
            ></textarea>
          </td>
        </tr>
        <tr bgcolor="#f2f2f2" height="60" width="15%">
          <c:if test="${not empty errdettaglio}">
            <td colspan="2"><font color="#CC0000"><b>Inserire i dettagli per il luogo dell'appuntamento</b></font></td>
          </c:if>
          <c:if test="${empty errdettaglio}">
            <td colspan="2"><b>Inserire i dettagli per il luogo dell'appuntamento</b></td>
          </c:if>
          <td colspan="2">
          <textarea name="dettagli_luogo_appunt" rows="3" cols="50"
          placeholder="Inserie i dettagli. es:(Scala A,Piano 2,Laboratorio 5)"
          value="${param.dettagli_luogo_appunt}"
          ></textarea></td>
        </tr>
      </table>
    </td>
  </tr>
  <!-- Pulsante di conferma data -->
  <tr>
    <td align="center" colspan="6">
      <c:if test="${n_appunt.rows[0].num_app < param.totconv}">

      <input type="submit" value="Conferma Data" style="color:#25544E"/>
      <input type="hidden" name="id_iscriz" value="${param.id_iscriz}"/>
      <input type="hidden" name="id_paz" value="${param.id_paz}"/>
      <input type="hidden" name="totconv" value="${param.totconv}"/>
      <input type="hidden" name="studio" value="${param.nome_studio}"/>
      <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>

      <input type="reset" style="color:#25544E"/>
      </c:if>
    </td>
  </tr>
  </form>

<tr>
  <td align="center" colspan="6">
    <table valign="middle" align="center" border="0" width="80%" cellspacing="0" cellpadding="15">
      <tr bgcolor="#2a5951" style="color:white" height="60">
        <th>ID dell'appuntamento</th>
        <th>Studio di partecipazione</th>
        <th>Data e ora</th>
        <th>Luogo</th>
        <th>Dettagli luogo</th>
        <th colspan="2">&nbsp</th>
      </tr>

      <c:forEach items="${rset_appunt.rows}" var="appunt">
      <tr bgcolor="#f2f2f2" height="60" width="15%">
        <td> ${appunt.ID_APPUNT} </td>
        <td> ${appunt.NOME_STUDIO}</td>

        <fmt:formatDate var="data_appunt"
                   value="${appunt.DATA_ORA}"
                   type="both"
                   dateStyle="medium"
                   timeStyle="medium"/>

        <td> ${data_appunt}</td>
        <td>${appunt.LUOGO}</td>
        <td>${appunt.DETTAGLI_LUOGO}</td>

        <form action="RESP_conf_modifica_appunt.jsp" method="post">
          <td>
            <input type="submit" name="modifica_data" value="Modifica" style="color:#25544E"/>

            <input type="hidden" name="id_appunt_mod" value="${appunt.ID_APPUNT}"/>
            <input type="hidden" name="luogo" value="${appunt.LUOGO}"/>
            <input type="hidden" name="dettagli" value="${appunt.DETTAGLI_LUOGO}"/>
            <input type="hidden" name="data" value="${data_appunt}"/>

            <input type="hidden" name="id_iscriz" value="${param.id_iscriz}"/>
            <input type="hidden" name="id_paz" value="${param.id_paz}"/>
            <input type="hidden" name="totconv" value="${param.totconv}"/>
            <input type="hidden" name="nome_studio" value="${appunt.NOME_STUDIO}"/>

            <input type="hidden" name="data_inizio" value="${data_inizio}"/>
            <input type="hidden" name="data_fine" value="${data_fine}"/>
          </td>
        </form>

        <form action="RESP_canc_appunt.jsp" method="post">
          <td>
            <input type="submit" value="Cancella" style="color:#25544E"/>
            <input type="hidden" name="id_appunt_canc" value="${appunt.ID_APPUNT}"/>
            <input type="hidden" name="id_iscriz" value="${param.id_iscriz}"/>
            <input type="hidden" name="id_paz" value="${param.id_paz}"/>
            <input type="hidden" name="totconv" value="${param.totconv}"/>
            <input type="hidden" name="nome_studio" value="${appunt.NOME_STUDIO}"/>
            <input type="hidden" name="data_studio" value="${data_appunt}"/>

            <input type="hidden" name="data_inizio" value="${data_inizio}"/>
            <input type="hidden" name="data_fine" value="${data_fine}"/>
          </td>
        </form>
      </tr>
    </c:forEach>
    </table>
  </td>
</tr>

<tr>
  <c:if test="${n_appunt.rows[0].num_app < param.totconv}">
  <form action="RESP_appuntamenti.jsp" method="post">
    <td align="center" colspan="6">
      <input type="submit" name="Salva" value="Salva le modifiche" style="color:#25544E"/>
    </td>
  </form>
</c:if>

<c:if test="${n_appunt.rows[0].num_app == param.totconv}">
  <form action="RESP_appuntamenti.jsp" method="post">
    <td align="center" colspan="3">
      <input type="submit" name="Salva" value="Salva le modifiche" style="color:#25544E"/>
    </td>
  </form>

  <form action="RESP_ctrl_chiusura_app.jsp" method="post">
    <td align="center" colspan="3">
      <input type="submit" name="chiudi" value="Chiudi calendario" style="color:#25544E"/>
      <input type="hidden" name="id_paz" value="${param.id_paz}"/>
      <input type="hidden" name="id_iscriz" value="${param.id_iscriz}"/>
    </td>
  </form>
</tr>
</c:if>
<%@ include file="LAYOUT_BOTTOM.jspf" %>
