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

<%-- ======================================================================= --%>
<%-- Query per l estrazione dei parametri relativi agli appuntamenti         --%>
<%-- ======================================================================= --%>
<sql:query var="rset_app">
SELECT A.LUOGO, A.DETTAGLI_LUOGO, A.DATA_ORA, A.NOTE, A.PRESENZA, R.NOME, R.COGNOME
FROM ISCRIZIONE I, AVERE_APPUNT AP, APPUNTAMENTO A, SSC S, RESP R
WHERE I.ID_ISCRIZ=AP.ID_ISCRIZIONE AND AP.ID_APPUNT=A.ID_APPUNT AND S.ID_SSC=I.ID_SSC AND R.ID_RESP=S.ID_RESP
AND I.ID_SSC = ?
AND I.ID_PAZ = ?
  <sql:param value="${param.id_ssc}"/>
  <sql:param value="${param.id_paz}"/>
</sql:query>

<%-- ======================================================================= --%>
<%-- Query per il controllo del bottone di drop-out                          --%>
<%-- ======================================================================= --%>
<sql:query var="rset_drop">
SELECT COUNT(*) AS CONTA_PRESENZE
FROM ISCRIZIONE I, AVERE_APPUNT AP, APPUNTAMENTO A, SSC S, RESP R
WHERE I.ID_ISCRIZ=AP.ID_ISCRIZIONE AND AP.ID_APPUNT=A.ID_APPUNT AND S.ID_SSC=I.ID_SSC AND R.ID_RESP=S.ID_RESP
AND A.PRESENZA = 'Presente'
AND I.ID_SSC = ?
  <sql:param value="${param.id_ssc}"/>
</sql:query>

<!-- ==================== Corpo Centrale ===================== -->

      <!-- --------------------- Pulsante indietro --------------------- --> 
      <tr valign="top">
        <td align="center" width="17%">
          <form method="post" action="RESP_dettagli_paziente.jsp">
            <input type="image" src="undo.png" width="40" height="40" />
            <input type="hidden" name="id_ssc" value="${param.id_ssc}" />
            <input type="hidden" name="nome_paz" value="${param.nome_paz}" />
            <input type="hidden" name="cognome_paz" value="${param.cognome_paz}" />
            <input type="hidden" name="nome" value="${param.nome}" />
            <input type="hidden" name="totconv" value="${param.totconv}" />
            <input type="hidden" name="id_paz" value="${param.id_paz}" />
            <input type="hidden" name="descr_paz" value="${param.descr_paz}" />
            <input type="hidden" name="vis_med" value="${param.vis_med}" />
         </form>
        </td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="16%">&nbsp</td>
        <td width="16%">&nbsp</td>
      </tr>

      <!-- --------------------- Intestazione --------------------- --> 
      <tr>
        <td align="center" colspan="6">
          <img src="agenda.png" height="150" alt="Calendario paziente"/><br/>
          <h3 align="center" style="color:#25544E">Appuntamenti svolti dal paziente ${param.nome_paz} ${param.cognome_paz} per lo studio "${param.nome}"</h3>
        </td>
      </tr>
      <!-- --------------------------------------------------------- --> 
      
      <!-- -------------------- Tabella -------------------- -->
      <tr>
        <td align="center" colspan="6">
          <div style="width:900px;height:450px;overflow-y: scroll; border:4px solid #2a5951;">
            <table valign="middle" align="center" border="0" width="100%" cellspacing="0" cellpadding="10">

              <tr bgcolor="#2a5951" style="color:white" height="60" width="15%">
                <th> Data e ora </th>
                <th> Luogo </th>
                <th> Dettagli luogo </th>
                <th> Responsabile </th>
                <th> Presenza </th>
                <th> Complicazioni </th>
              </tr>

              <c:forEach items="${rset_app.rows}" var="var_app">

          <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">

              <fmt:formatDate var="var_mydata_ora"
                   value="${var_app.DATA_ORA}"
                   type="both"
                   dateStyle="short"/>

              <td>${var_mydata_ora}</td>

               <td>${var_app.LUOGO}</td>
               <td>${var_app.DETTAGLI_LUOGO}</td>

              <td>${var_app.NOME} ${var_app.COGNOME}</td>
              <td>${var_app.PRESENZA}</td>
              <td>${var_app.NOTE}</td>
            </tr>
         </c:forEach> 
            </table>
          </div>

      <c:if test="${rset_drop.rows[0].CONTA_PRESENZE != param.totconv && param.descr_paz == 'Arruolato'}">
        <table valign="middle" align="center" border="0" width="100%" cellspacing="0" cellpadding="10">
          <tr>
            <td align="right" width="65%">
                <h3 style="color:red">Attenzione! Il paziente non ha concluso le convocazioni previste:<h3>
           </td>
            <td align="left" width="45%">
                <form method="post" action="RESP_act_dropout.jsp">
                    <input type="submit" value="Dichiara drop-out" />
                    <input type="hidden" name="id_ssc" value="${param.id_ssc}" />
                    <input type="hidden" name="id_paz" value="${param.id_paz}" />
                    <input type="hidden" name="nome" value="${param.nome}" />
                    <input type="hidden" name="flag_drop" value="true" />
                </form>
            </td>
          </tr>
       </table>
      </c:if>
        </td>
      </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>