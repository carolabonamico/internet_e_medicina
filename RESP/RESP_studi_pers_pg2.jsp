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
SELECT S.COSTO_FISSO_STRUM, S.COSTO_FISSO_ANALISI, S.INCENTIVO, S.TOTPAZ, S.TOTCONV, S.IMPORTO_RAGGIUNTO, S.COSTO_FISSO_STRUM+S.COSTO_FISSO_ANALISI+(S.TOTPAZ*S.INCENTIVO) AS BUDGET_COMPLESSIVO, S.TOTPAZ*S.INCENTIVO AS FONDO_INCENTIVI, S.MOTIVAZIONE, S.NOME_STUDIO, S.DESCRIZIONE, S.AREA_TERAPEUTICA, S.POPOLAZIONE, S.DATA_INIZIO, S.DATA_FINE
FROM SSC S
WHERE S.ID_RESP = ?
  AND S.ID_SSC = ?
  <sql:param value="${id_user}"/>
  <sql:param value="${param.id_ssc}"/>
</sql:query>

<%-- =================================================================== --%>
<%-- Query per l estrazione dei pazienti TESTATI iscritti allo studio    --%>
<%-- =================================================================== --%>
<sql:query var="rset_test_paz">
SELECT COUNT(*) AS TESTATI
  FROM stato_paz_studio ST, ISCRIZIONE I, SSC S
  WHERE I.COD_STATO_PAZ=ST.cod AND S.ID_SSC=I.ID_SSC
       AND ST.descr = "Testato"
       AND I.ID_SSC = ?
       AND S.ID_RESP = ?
  <sql:param value="${param.id_ssc}"/>
  <sql:param value="${id_user}"/>
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
    AND S.ID_RESP = ?
  <sql:param value="${conteggio_testati}"/>
  <sql:param value="${conteggio_testati}"/>
  <sql:param value="${param.id_ssc}"/>
  <sql:param value="${id_user}"/>
</sql:query>


<%-- ======================================================================= --%>
<%-- Query per l estrazione dei pazienti attualmente iscritti allo studio    --%>
<%-- ======================================================================= --%>
<sql:query var="rset_paz_attuali">
SELECT COUNT(*) AS PAZ_ATTUALI
  FROM stato_paz_studio ST, ISCRIZIONE I, SSC S
  WHERE I.COD_STATO_PAZ=ST.cod AND S.ID_SSC=I.ID_SSC
       AND ST.descr != "Scartato"
       AND I.ID_SSC = ?
       AND S.ID_RESP = ?
  <sql:param value="${param.id_ssc}"/>
  <sql:param value="${id_user}"/>
</sql:query>


<!-- ================== Script per il menu a comparsa ================== -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script>$(document).ready(function(){
    $("#menuButton").click(function(){
      $("#menu").slideToggle();
    });
  });</script>

<!-- ==================== Corpo Centrale ===================== -->

<!-- --------------------- Pulsante indietro --------------------- -->
      <tr valign="top">
        <td align="center" width="17%">
          <a href="RESP_studi_pers_DEF.jsp">
            <img src="undo.png" width="40" height="40" title="Indietro">
          </a>
        </td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="16%">&nbsp</td>
        <td width="16%">&nbsp</td>
      </tr>

<!-- =============== Menu a comparsa =============== -->
        <tr>
            <td align="center" colspan="6">
                <button id="menuButton"><font color="green">Note correzione</font></button>
            </td>
        </tr>
        <tr>
            <td colspan="6">
                <div id="menu" style="display:none;" align="left">
        
                  <p>In questa pagina sono presenti i seguenti controlli:</p>
                  <ul>
                  <li>I pulsanti 'Modifica' e 'Chiudi' sono visibili solo per le SSC in stato di 'Bozza' e per quelle  
                      giudicate rivedibili dal PRES.</li>
                  <li>Una SSC in stato di 'Bozza' non puo' essere chiusa se tutti i suoi campi non sono stati compilati.</li>
                  <li>Nella pagina di conferma chiusura della SSC, la textarea di risposta e' visibile solo per quegli studi  
                      che sono da rivedere. Non puo' essere inviata una risposta vuota.</li>
                  <li>In base allo stato dello studio vengono visualizzati dei 'Dettagli Stato Studio' differenti.</li>
                  <li>Se il numero di pazienti attuali e' pari a 0 (cio' significa che nessun paziente fa parte o ha fatto 
                      parte dello studio), allora non compare il bottone che consente di visualizzare i dettagli di tali 
                      pazienti.</li>
                  </ul>
               </div>
            </td>
        </tr>


<!-- --------------------- Messaggi --------------------- -->

<c:if test="${not empty errchius}">
<tr>
  <td align="center" colspan="6">
    <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="20" style="color:#468c7f">
      <tr>
        <td  align="center" colspan="6">
            <img src="error.png" height="100" alt="Errore">
        </td>
      </tr>
      <tr>
        <td align="center" colspan="6">
          <c:if test="${not empty errchius}">
            <b><font color="#CC0000">${errchius}</font></b>
          </c:if>
        </td>
      </tr>
     </table>
  </td>
</tr>
</c:if>
      
      <!-- --------------------- Studio selezionato --------------------- -->
      <tr>
        <td align="center" colspan="6" style="color:#25544E">
          <h2>Stai visualizzando i dettagli dello studio "${param.nome}"</h2>
        </td>
      </tr>

<c:if test="${param.descr == 'Approvato' ||
              param.descr == 'Attivo'    ||
              param.descr == 'Concluso'  ||
              param.descr == 'Annullato' ||
              param.rivisto == 1}">
      <!-- --------------------- Tabella 0 --------------------- -->
      <tr>
        <td align="center" colspan="6">
          <table valign="top" align="center" width="85%" cellpadding="10" cellspacing="0">
            <h3 align="center" style="color:#25544E">Dettagli Stato Studio</h3><br/>
            <c:if test="${param.descr == 'Approvato' || param.descr == 'Attivo' || param.descr == 'Concluso'}">
             <h4 align="center" style="color:#468c7f">Lo studio selezionato e' stato approvato per il seguente motivo:</h4>
            </c:if>
            <c:if test="${param.descr == 'Annullato'}">
             <h4 align="center" style="color:#468c7f">Lo studio selezionato e' stato annullato per il seguente motivo:</h4>
            </c:if>
            <c:if test="${param.rivisto == 1 && param.descr == 'Bozza'}">
              <h4 align="center" style="color:red">Lo studio selezionato deve essere rivisto per il seguente motivo:</h4>
            </c:if>
            </tr>
            <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
              <td>${rset_costi_studio.rows[0].MOTIVAZIONE}</td>
            </tr>
          </table>
        </td>
      </tr>
</c:if>

      <!-- --------------------- Tabella 1 --------------------- -->
      <tr>
        <td align="center" colspan="6">
          <table valign="top" align="center" width="85%" cellpadding="10" cellspacing="0">
            <h3 align="center" style="color:#25544E">Dettagli Costi (euro)</h3>
            <tr bgcolor="#2a5951" style="color:white" height="60" width="15%">
              <th>Budget complessivo</th>
              <th>Budget raccolto</th>
              <th>Costo Fisso Strumentazione</th>
              <th>Costo Fisso Analisi</th>
              <th>Incentivo paziente</th>
              <th>Fondo incentivi</th>
              <th>Spesa incentivi</th>
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
                            <th>Pazienti Attuali</th>
                            <th>Pazienti Mancanti </th>
                        </tr>

                        <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">

                            <td>${rset_costi_studio.rows[0].TOTPAZ}</td>
                            <td>${rset_costi_studio.rows[0].TOTCONV}</td>

                         <c:if test="${rset_paz_attuali.rows[0].PAZ_ATTUALI != 0}">
                            <td>
                                <form method="post" action="RESP_elenco_PAZ_DEF.jsp">
                                    <input type="submit" value="${rset_paz_attuali.rows[0].PAZ_ATTUALI}" />
               <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
               <input type="hidden" name="descr" value="${param.descr}"/>
               <input type="hidden" name="nome" value="${param.nome}"/>
               <input type="hidden" name="totconv" value="${rset_costi_studio.rows[0].TOTCONV}"/>
               <input type="hidden" name="vis_med" value="${param.vis_med}"/>
                                </form>
                            </td>
                         </c:if>
                          <c:if test="${rset_paz_attuali.rows[0].PAZ_ATTUALI == 0}">
                            <td>${rset_paz_attuali.rows[0].PAZ_ATTUALI}</td>
                         </c:if>
                            <td>${rset_paz_manc.rows[0].PAZ_MANCANTI}</td>
                        </tr>

          </table>
        </td>
      </tr>

      <!-- --------------------- Nota --------------------- -->
    <c:if test="${rset_paz_attuali.rows[0].PAZ_ATTUALI != 0}">
      <tr>
        <td align="center" colspan="6">
          <i style="color:#468c7f">NOTA: per visualizzare l'elenco dei pazienti attualmente iscritti allo studio, cliccare sul bottone contenente il numero </i>
        </td>
      </tr>
    </c:if>


<!-- Setto flag -->
<c:set var="flag_controllo_campi" scope="session" value="true"/>



      <!-- --------------------- Pulsanti --------------------- -->
<c:if test="${param.descr == 'Bozza' && param.rivisto == 0}">
  <tr>
    <td align="right" width="50%" colspan="3">
      <form method="post" action="RESP_crea_SSC.jsp">
         <input type="submit" value="Modifica" />
         <input type="hidden" name="flag_mod" value="true"/>
         <input type="hidden" name="id_ssc_mod" value="${param.id_ssc}"/>
         <input type="hidden" name="descr" value="${param.descr}"/>
         <input type="hidden" name="studio" value="${param.nome}"/>
         <input type="hidden" name="data_inizio" value="${param.datain}"/>
         <input type="hidden" name="data_fine" value="${param.datafine}"/>
         <input type="hidden" name="costo_stru" value="${rset_costi_studio.rows[0].COSTO_FISSO_STRUM}"/>
         <input type="hidden" name="costo_analisi" value="${rset_costi_studio.rows[0].COSTO_FISSO_ANALISI}"/>
         <input type="hidden" name="incentivo" value="${rset_costi_studio.rows[0].INCENTIVO}"/>
         <input type="hidden" name="totconv" value="${rset_costi_studio.rows[0].TOTCONV}"/>
         <input type="hidden" name="totpaz" value="${rset_costi_studio.rows[0].TOTPAZ}"/>
         <input type="hidden" name="area" value="${param.area}"/>
         <input type="hidden" name="descrizione" value="${param.descrizione}"/>
         <input type="hidden" name="popolazione" value="${param.popolazione}"/>
      </form>
    </td>
    <td align="left" width="50%" colspan="3">
      <form method="post" action="RESP_conferma_chiusura.jsp">
         <input type="submit" name="bottone" value="Chiudi" />
         <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
         <input type="hidden" name="descr" value="${param.descr}"/>
         <input type="hidden" name="nome" value="${param.nome}"/>
         <input type="hidden" name="area" value="${param.area}"/>
         <input type="hidden" name="popolazione" value="${param.popolazione}"/>
         <input type="hidden" name="datain" value="${param.datain}"/>
         <input type="hidden" name="datafine" value="${param.datafine}"/>
         <input type="hidden" name="descrizione" value="${param.descrizione}"/>
         <input type="hidden" name="rivisto" value="${param.rivisto}"/>
      </form>
    </td>
  </tr>
</c:if>

<c:if test="${param.descr == 'Bozza' && param.rivisto == 1}">
  <tr>
    <td align="right" width="50%" colspan="3">
      <form method="post" action="RESP_crea_SSC.jsp">
         <input type="submit" value="Modifica" />
         <input type="hidden" name="flag_mod" value="true"/>
         <input type="hidden" name="id_ssc_mod" value="${param.id_ssc}"/>
         <input type="hidden" name="descr" value="${param.descr}"/>
         <input type="hidden" name="studio" value="${param.nome}"/>
         <input type="hidden" name="data_inizio" value="${param.datain}"/>
         <input type="hidden" name="data_fine" value="${param.datafine}"/>
         <input type="hidden" name="costo_stru" value="${rset_costi_studio.rows[0].COSTO_FISSO_STRUM}"/>
         <input type="hidden" name="costo_analisi" value="${rset_costi_studio.rows[0].COSTO_FISSO_ANALISI}"/>
         <input type="hidden" name="incentivo" value="${rset_costi_studio.rows[0].INCENTIVO}"/>
         <input type="hidden" name="totconv" value="${rset_costi_studio.rows[0].TOTCONV}"/>
         <input type="hidden" name="totpaz" value="${rset_costi_studio.rows[0].TOTPAZ}"/>
         <input type="hidden" name="area" value="${param.area}"/>
         <input type="hidden" name="descrizione" value="${param.descrizione}"/>
         <input type="hidden" name="popolazione" value="${param.popolazione}"/>
      </form>
    </td>
    <td align="left" width="50%" colspan="3">
      <form method="post" action="RESP_conferma_chiusura.jsp">
         <input type="submit" name="bottone" value="Chiudi" />
         <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
         <input type="hidden" name="descr" value="${param.descr}"/>
         <input type="hidden" name="nome" value="${param.nome}"/>
         <input type="hidden" name="area" value="${param.area}"/>
         <input type="hidden" name="popolazione" value="${param.popolazione}"/>
         <input type="hidden" name="datain" value="${param.datain}"/>
         <input type="hidden" name="datafine" value="${param.datafine}"/>
         <input type="hidden" name="descrizione" value="${param.descrizione}"/>
         <input type="hidden" name="rivisto" value="${param.rivisto}"/>
      </form>
    </td>
  </tr>
</c:if>

   

<%@ include file="LAYOUT_BOTTOM.jspf" %>
