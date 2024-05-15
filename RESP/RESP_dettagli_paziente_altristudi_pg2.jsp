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

<%-- =================================================================== --%>
<%-- Query per l estrazione di tutti i parametri relativi allo studio    --%>
<%-- =================================================================== --%>
<sql:query var="rset_costi_studio">
SELECT S.COSTO_FISSO_STRUM, S.COSTO_FISSO_ANALISI, S.INCENTIVO, S.TOTPAZ, S.TOTCONV, S.IMPORTO_RAGGIUNTO,
       S.COSTO_FISSO_STRUM+S.COSTO_FISSO_ANALISI+(S.TOTPAZ*S.INCENTIVO) AS BUDGET_COMPLESSIVO,
       S.TOTPAZ*S.INCENTIVO AS FONDO_INCENTIVI
  FROM SSC S
  WHERE S.ID_SSC = ?
  <sql:param value="${param.id_ssc}"/>
</sql:query>

<%-- =================================================================== --%>
<%-- Query per l estrazione dei pazienti TESTATI iscritti allo studio    --%>
<%-- =================================================================== --%>
<sql:query var="rset_test_paz">
SELECT COUNT(*) AS TESTATI
  FROM stato_paz_studio ST, ISCRIZIONE I
  WHERE I.COD_STATO_PAZ=ST.cod
       AND ST.descr = "Testato"
       AND I.ID_SSC = ?
  <sql:param value="${param.id_ssc}"/>
</sql:query>

<!-- Salvo il risultato della query precedente in una variabile -->

<c:set var="conteggio_testati" scope="request" value="${rset_test_paz.rows[0].TESTATI}" />

<%-- ====================================================================== --%>
<%-- Query per l estrazione dei pazienti mancanti e della spesa incentivi   --%>
<%-- ====================================================================== --%>
<sql:query var="rset_paz_manc">
SELECT S.TOTPAZ-? AS PAZ_MANCANTI, S.INCENTIVO*? AS SPESA_INCENTIVI
  FROM SSC S
  WHERE S.ID_SSC = ?
  <sql:param value="${conteggio_testati}"/>
  <sql:param value="${conteggio_testati}"/>
  <sql:param value="${param.id_ssc}"/>
</sql:query>


<%-- ======================================================================= --%>
<%-- Query per l estrazione dei pazienti attualmente iscritti allo studio    --%>
<%-- ======================================================================= --%>
<sql:query var="rset_paz_attuali">
SELECT COUNT(*) AS PAZ_ATTUALI
  FROM stato_paz_studio ST, ISCRIZIONE I
  WHERE I.COD_STATO_PAZ=ST.cod
       AND ST.descr != "Scartato"
       AND I.ID_SSC = ?
  <sql:param value="${param.id_ssc}"/>
</sql:query>


<!-- ==================== Corpo Centrale ===================== -->

      <!-- --------------------- Pulsante indietro --------------------- --> 
      <tr valign="top">
        <td align="center" width="17%">
          <form method="post" action="RESP_dettagli_paziente_altristudi.jsp">
            <input type="image" src="undo.png" width="40" height="40" />
                <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                <input type="hidden" name="descr" value="${param.descr}"/>
                <input type="hidden" name="nome" value="${param.nome}"/>
                <input type="hidden" name="area" value="${param.area}"/>
                <input type="hidden" name="popolazione" value="${param.popolazione}"/>
                <input type="hidden" name="datain" value="${param.data_in}"/>
                <input type="hidden" name="datafine" value="${param.datafine}"/>
                <input type="hidden" name="descrizione" value="${param.descrizione}"/>
                <input type="hidden" name="nome_paz" value="${param.nome_paz}"/>
                <input type="hidden" name="cognome_paz" value="${param.cognome_paz}"/>
                <input type="hidden" name="descr_paz" value="${param.descr_paz}" />
                <input type="hidden" name="totconv" value="${param.totconv}"/>
                <input type="hidden" name="id_paz" value="${param.id_paz}"/>
                <input type="hidden" name="vis_med" value="${param.vis_med}"/>
         </form>
        </td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="16%">&nbsp</td>
        <td width="16%">&nbsp</td>
      </tr>

      <!-- --------------------- Studio selezionato --------------------- -->
      <tr>
        <td align="center" colspan="6" style="color:#25544E">
          <h2>Stai visualizzando i dettagli dello studio "${param.nome}"</h2>
        </td>
      </tr>

      <!-- --------------------- Tabella 1 --------------------- --> 
      <tr>
        <td align="center" colspan="6">
          <table valign="top" align="center" width="85%" cellpadding="10" cellspacing="0">
            <h3 align="center" style="color:#25544E">Dettagli Costi (euro)</h3>
            <tr bgcolor="#2a5951" style="color:white" height="60" width="15%">
              <th> Budget complessivo</th>
              <th> Budget raccolto</th>
              <th> Costo Fisso Strumentazione </th>         
              <th> Costo Fisso Analisi </th>
              <th> Incentivo paziente </th>
              <th> Fondo incentivi  </th>
              <th> Spesa incentivi  </th>  
            </tr>

            <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">          
              <td>${rset_costi_studio.rows[0].BUDGET_COMPLESSIVO}</td>
              <td>${rset_costi_studio.rows[0].IMPORTO_RAGGIUNTO}</td>
              <td>${rset_costi_studio.rows[0].COSTO_FISSO_STRUM}</td>
              <td>${rset_costi_studio.rows[0].COSTO_FISSO_ANALISI}</td>
              <td>${rset_costi_studio.rows[0].INCENTIVO}</td>
              <td>${rset_costi_studio.rows[0].FONDO_INCENTIVI}</td>
              <td>${rset_paz_manc.rows[0].SPESA_INCENTIVI}</td> 
            </tr>
          </table>
        </td>
      </tr>

      <!-- --------------------- Tabella 2 --------------------- --> 
      <tr>
        <td align="center" colspan="6">
          <table valign="top" align="center" width="85%" cellpadding="10" cellspacing="0">
                        <h3 align="center" style="color:#25544E">Dettagli Pazienti </h3>
                        <tr bgcolor="#2a5951" style="color:white" height="60" width="15%">
                            <th>Pazienti Reclutabili</th>              
                            <th>Convocazioni Previste</th>
                            <th> Pazienti Attuali</th>
                            <th> Pazienti Mancanti </th>            
                        </tr>

                        <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
                            
                            <td>${rset_costi_studio.rows[0].TOTPAZ}</td>
                            <td>${rset_costi_studio.rows[0].TOTCONV}</td>
                            <td>${rset_paz_attuali.rows[0].PAZ_ATTUALI}</td>
                            <td>${rset_paz_manc.rows[0].PAZ_MANCANTI}</td>
                        </tr>
        
          </table>
        </td>
      </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>
