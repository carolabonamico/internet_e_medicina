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

<!-- ==================================== TOP =================================== --> 

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_PAZ.jspf" %>  

<%-- DATA E ORA ISCRIZIONE --%>
<sql:query var="rset_data_ora_iscriz">
  SELECT I.DATA_ISCRIZIONE
  FROM ISCRIZIONE I
  WHERE I.ID_ISCRIZ = ?
  <sql:param value="${param.id_iscrizione}"/>
</sql:query>

<fmt:formatDate value="${rset_data_ora_iscriz.rows[0].DATA_ISCRIZIONE}" var="data_ora_iscrizione"
 type="both"
 dateStyle="short"
 />


    <!-- ==================== Corpo Centrale ===================== -->

    <!-- --------------------- Pulsante indietro --------------------- --> 
    <tr valign="top">
      <td align="center" width="20%">
        <form method="post" action="PAZ_dettagli.jsp">
          <input type="image" src="undo.png" width="40" height="40" title="Indietro"/>
          <input type="hidden" name="dettagli" value="${param.dettagli}"/>
          <input type="hidden" name="nome_studio" value="${param.nome_studio}"/>
          <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
          <input type="hidden" name="incentivo" value="${param.incentivo}"/>
          <input type="hidden" name="posizione_studio" value="${param.posizione_studio}"/>
          <input type="hidden" name="data_ora_iscriz" value="${data_ora_iscrizione}"/>
          <input type="hidden" name="id_iscrizione" value="${param.id_iscrizione}"/>
          <input type="hidden" name="vis_med" value="${param.vis_med}"/>
        </form>
      </td>
      <td align="center" width="20%"> &nbsp </td>
      <td align="center" width="20%"> &nbsp </td>
      <td align="center" width="20%"> &nbsp</td>
      <td align="center" width="20%"> &nbsp </td>
    </tr>

 <!-- Se non sto selezionando nulla stampo un messaggio -->
    <c:if test="${param.dettagli == ''}">
      <c:set var="no_select" value="true" scope="request"/>
      <jsp:forward page="PAZ_dettagli.jsp"/>
    </c:if>

    <!-- ==================== Appuntamenti fissati ===================== -->  

    <c:if test="${param.dettagli == 'fissati'}">

      <!-- QUERY PER LA SELECT -->
      <sql:query var="rset_select_responsabile">
        SELECT DISTINCT R.ID_RESP, R.NOME, R.COGNOME
        FROM APPUNTAMENTO AP, SSC S, AVERE_APPUNT AV, ISCRIZIONE I, RESP R
        WHERE AP.ID_APPUNT = AV.ID_APPUNT
        AND AV.ID_ISCRIZIONE = I.ID_ISCRIZ
        AND S.ID_SSC = I.ID_SSC
        AND S.ID_RESP = R.ID_RESP
        AND AP.STATO_PRES = 3
        AND I.ID_PAZ = ?
        AND S.ID_SSC = ?
        <sql:param value="${id_user}"/>
        <sql:param value="${param.id_ssc}"/>
      </sql:query>

      <!-- QUERY APPUNTAMENTI FISSATI -->
      <sql:query var="rset_appfissati">
        SELECT AP.ID_APPUNT, AP.LUOGO, AP.DETTAGLI_LUOGO, AP.DATA_ORA,
        R.ID_RESP, R.NOME, R.COGNOME
        FROM APPUNTAMENTO AP, SSC S, AVERE_APPUNT AV, ISCRIZIONE I, RESP R
        WHERE AP.ID_APPUNT = AV.ID_APPUNT
        AND AV.ID_ISCRIZIONE = I.ID_ISCRIZ
        AND S.ID_SSC = I.ID_SSC
        AND S.ID_RESP = R.ID_RESP
        AND AP.STATO_PRES = 3 
        AND I.ID_PAZ = ?
        AND S.ID_SSC = ?
        <sql:param value="${id_user}"/>
        <sql:param value="${param.id_ssc}"/>

      <%-------------------------- AREA CONTROLLO DATE ---------------------%>
        <%-- DATA INIZIO --%>
        <c:if test="${not empty param.data_app}">
        AND AP.DATA_ORA = ?
        <sql:param value="${param.data_app}%"/>
        </c:if>

      <%----------------------------------- AREA CONTROLLO SELECT ------------------------------%>
        <%-- CONTROLLO RESPONSABILE --%>
        <c:if test="${not empty paramValues.responsabile && paramValues.responsabile[0] != ''}">
        <c:set var="dim_at" value="${fn:length(paramValues.responsabile)}"/>
        <c:if test="${dim_at == 1}">
        AND R.ID_RESP = ?
        <sql:param value="${paramValues.responsabile[0]}"/>
        </c:if>
        <c:if test="${dim_at == 2}">
        AND (R.ID_RESP = ?
        OR R.ID_RESP = ?)
        <sql:param value="${paramValues.responsabile[0]}"/>
        <sql:param value="${paramValues.responsabile[1]}"/>
        </c:if>
        <c:if test="${dim_at > 2}">
        AND (R.ID_RESP = ?
        <sql:param value="${paramValues.responsabile[0]}"/>
        <c:forEach items="${paramValues.responsabile}" begin="1" end="${dim_at-2}" var="myarea">
        OR R.ID_RESP = ?
        <sql:param value="${myarea}"/>
        </c:forEach>
        OR R.ID_RESP = ?)
        <sql:param value="${paramValues.responsabile[dim_at-1]}"/>
        </c:if>
        </c:if>

        <c:if test="${param.ordine == 'Crescente'}">
        ORDER BY AP.DATA_ORA ASC
        </c:if>
          
        <c:if test="${param.ordine == 'Decrescente'}">
        ORDER BY AP.DATA_ORA DESC
        </c:if>
      </sql:query>

<!-- ================== Script per il menu a comparsa ================== -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script>$(document).ready(function(){
    $("#menuButton").click(function(){
      $("#menu").slideToggle();
    });
  });</script>

<!--======================MENU A COMPARSA=================-->

<tr height="60">
            <td align="center" colspan="6">
                <button id="menuButton"><font color="#25544">Note correzione</font></button>
            </td>
        </tr>
        <tr>
            <td colspan="5" align="center">
                <div id="menu" style="display:none;" align="left">
                  <table cellpadding="10">
                  <tr>
                  <td>
                  <p>In questa pagina sono presenti i seguenti controlli:</p>
                  <ul>
                  <li>Se non sono presenti appuntamenti fissati viene mostrato un messaggio di errore apposito;</li>
                  <li>Se i parametri inseriti nei filtri per vagliare gli appuntamenti non producono risultati, viene visualizzato un apposito messaggio di errore;</li>
                  </ul>
                </td>
                </tr>
                </table>
               </div>
            </td>
        </tr>

  <!----------------------------- Pulsanti Cerca/Mostra tutto ---------------------- -->
  <form method="post" action="#">
    <input type="hidden" name="dettagli" value="${param.dettagli}"/>
    <input type="hidden" name="nome_studio" value="${param.nome_studio}"/>
    <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
    <input type="hidden" name="incentivo" value="${param.incentivo}"/>
    <input type="hidden" name="posizione_studio" value="${param.posizione_studio}"/>
    <input type="hidden" name="data_ora_iscriz" value="${data_ora_iscrizione}"/>
    <input type="hidden" name="id_iscrizione" value="${param.id_iscrizione}"/>

    <tr height="60%" width="100%">
      <td valign="middle" align="center" bgcolor="white" colspan="5">


        <!-- -------------------- Calendario intestazione -------------------- -->
        <h2 style="color:#25544E">Appuntamenti fissati per lo studio "${param.nome_studio}"<br/></h2>
        <p style="color:#25544E">
          <i>In questa pagina e' possibile visualizzare tutti gli appuntamenti futuri che sono stati fissati per lo studio selezionato.<br/>La tabella e' di sola visualizzazione.<br/><br/><br/></i>
        </p>
        <h2 style="color:#25544E">Opzioni di visualizzazione:<br/><br/></h2>
        <table valign="middle" align="center" border="0" cellspacing="0" cellpadding="10">
          <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
            
            <td>Ordine:</td>
            <td align="left">
              <input type="radio" name="ordine" value="Decrescente" onChange="this.form.submit();"
              <c:if test="${param.ordine == 'Decrescente'}">checked="checked"</c:if>
              /> Dal piu' recente al piu' lontano
            </td>
            <td align="left">
              <input type="radio" name="ordine" value="Crescente" onChange="this.form.submit();"
              <c:if test="${param.ordine == 'Crescente'}">checked="checked"</c:if>
              /> Dal piu' lontano al piu' recente
            </td>
          </tr>
        </table>
      </td>
    </tr>

    <tr>
      <td align="center" colspan="5">
        <table valign="middle" align="center" border="0" width="500px" cellspacing="0" cellpadding="10">
          <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
            <td>
              <input type="submit" name="cerca" id="submit-button" value="Cerca" align="center" style="color:#468c7f"/>
            </td>
          </tr>
          <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
            <td>
              <p style="color:#25544E">
                <i>Per ripristinare il valore dei filtri, premere sui "-- Segnaposto --"<br/></i>
              </p>
            </td>
          </tr>
        </table>
      </td>
    </tr>

      <!-- -------------------- Messaggio -------------------- -->
      <c:if test="${rset_appfissati.rowCount == 0 && (
        empty param.data_app &&
        (empty paramValues.responsabile || paramValues.responsabile[0] == '')
      )}">
        <tr>
          <td valign="middle" align="center" colspan="5">
            <font style="color:red"><b>Non risultano presenti appuntamenti fissati per questo studio.<br/></b></font>
          </td>
        </tr>
      </c:if>

      <c:if test="${rset_appfissati.rowCount == 0 && not empty param.data_app}">
        <tr>
          <td valign="middle" align="center" colspan="5">
          <font style="color:red"><b>La ricerca della data non ha prodotto alcun risultato.<br/></b></font>
          </td>
        </tr>
      </c:if>

      <!-- -------------------- Tabella appuntamenti fissati -------------------- -->
      <tr>
      <td align="center" colspan="5">
        <table valign="middle" align="center" border="0" width="800px" cellspacing="0" cellpadding="15">
          <tr bgcolor="#2a5951" style="color:white" height="60">
            <th> Data e ora </th>
            <th> Luogo </th>
            <th> Dettagli luogo </th>
            <th> Responsabile </th>
          </tr>

          <!-- -------------------- Filtri -------------------- -->
          <tr valign="middle" bgcolor="#f2f2f2">
            <td align="center">
              <input type="datetime-local" name="data_app" value="${param.data_app}"/>
            </td>

            <td> &nbsp </td>

            <td> &nbsp </td>

            <td align="center">
              <select name="responsabile" multiple="multiple">
                <option value="" align="center">-- Responsabile --</option>
                <c:forEach items="${rset_select_responsabile.rows}" var="resp">
                  <option value="${resp.ID_RESP}" align="center"
                  <c:forEach items="${paramValues.responsabile}" var="parresp">
                    <c:if test="${parresp == resp.ID_RESP}">selected="selected"</c:if>
                  </c:forEach>
                  >${resp.NOME} ${resp.COGNOME}</option>
                </c:forEach>
              </select>
            </td>
          </tr>
  </form>

          <!-- --------------------------- Tuple --------------------------- -->
          <tbody>
            <c:forEach items="${rset_appfissati.rows}" var="appfiss">
              <tr align="center" bgcolor="#f2f2f2" style="color:#468c7f">
                <fmt:formatDate value="${appfiss.DATA_ORA}" var="data"
		                            type="both"
		                            dateStyle="short"
	              />
                <td>${data}</td>
                <td>${appfiss.LUOGO}</td>
                <td>${appfiss.DETTAGLI_LUOGO}</td>
                <td>${appfiss.NOME} ${appfiss.COGNOME}</td>
              </tr>
            </c:forEach>
          </tbody>
          
        </table>
      </div>
      </td>
      </tr>
    
    </c:if>

    <!-- ==================== Appuntamenti svolti ===================== -->  

    <c:if test="${param.dettagli == 'svolti'}">

      <!-- QUERY PER LE SELECT -->

      <sql:query var="rset_select_presenza">
        SELECT DISTINCT AP.PRESENZA
        FROM APPUNTAMENTO AP, SSC S, AVERE_APPUNT AV, ISCRIZIONE I, RESP R
        WHERE AP.ID_APPUNT = AV.ID_APPUNT
        AND AV.ID_ISCRIZIONE = I.ID_ISCRIZ
        AND S.ID_SSC = I.ID_SSC
        AND S.ID_RESP = R.ID_RESP
        AND AP.STATO_PRES = 1
        AND I.ID_PAZ = ?
        AND S.ID_SSC = ?
        <sql:param value="${id_user}"/>
        <sql:param value="${param.id_ssc}"/>
      </sql:query>

      <sql:query var="rset_select_responsabile">
        SELECT DISTINCT R.ID_RESP, R.NOME, R.COGNOME
        FROM APPUNTAMENTO AP, SSC S, AVERE_APPUNT AV, ISCRIZIONE I, RESP R
        WHERE AP.ID_APPUNT = AV.ID_APPUNT
        AND AV.ID_ISCRIZIONE = I.ID_ISCRIZ
        AND S.ID_SSC = I.ID_SSC
        AND S.ID_RESP = R.ID_RESP      
        AND AP.STATO_PRES = 1
        AND I.ID_PAZ = ?
        AND S.ID_SSC = ?
        <sql:param value="${id_user}"/>
        <sql:param value="${param.id_ssc}"/>
      </sql:query>

      <!-- QUERY APPUNTAMENTI SVOLTI -->
      <sql:query var="rset_appsv">
        SELECT AP.ID_APPUNT, AP.LUOGO, AP.DETTAGLI_LUOGO, AP.DATA_ORA, 
        AP.PRESENZA, AP.NOTE, R.ID_RESP, R.NOME, R.COGNOME
        FROM APPUNTAMENTO AP, SSC S, AVERE_APPUNT AV, ISCRIZIONE I, RESP R
        WHERE AP.ID_APPUNT = AV.ID_APPUNT
        AND AV.ID_ISCRIZIONE = I.ID_ISCRIZ
        AND S.ID_SSC = I.ID_SSC
        AND S.ID_RESP = R.ID_RESP
        AND AP.STATO_PRES = 1
        AND I.ID_PAZ = ?
        AND S.ID_SSC = ?
        <sql:param value="${id_user}"/>
        <sql:param value="${param.id_ssc}"/>

      <%-------------------------- AREA CONTROLLO DATE ---------------------%>
        <%-- DATA INIZIO --%>
        <c:if test="${not empty param.data_app}">
        AND AP.DATA_ORA = ?
        <sql:param value="${param.data_app}%"/>
        </c:if>

      <%----------------------------------- AREA CONTROLLO SELECT ------------------------------%>
        <%-- CONTROLLO RESPONSABILE --%>
        <c:if test="${not empty paramValues.responsabile && paramValues.responsabile[0] != ''}">
        <c:set var="dim_at" value="${fn:length(paramValues.responsabile)}"/>
        <c:if test="${dim_at == 1}">
        AND R.ID_RESP = ?
        <sql:param value="${paramValues.responsabile[0]}"/>
        </c:if>
        <c:if test="${dim_at == 2}">
        AND (R.ID_RESP = ?
        OR R.ID_RESP = ?)
        <sql:param value="${paramValues.responsabile[0]}"/>
        <sql:param value="${paramValues.responsabile[1]}"/>
        </c:if>
        <c:if test="${dim_at > 2}">
        AND (R.ID_RESP = ?
        <sql:param value="${paramValues.responsabile[0]}"/>
        <c:forEach items="${paramValues.responsabile}" begin="1" end="${dim_at-2}" var="myarea">
        OR R.ID_RESP = ?
        <sql:param value="${myarea}"/>
        </c:forEach>
        OR R.ID_RESP = ?)
        <sql:param value="${paramValues.responsabile[dim_at-1]}"/>
        </c:if>
        </c:if>
        
        <%-- CONTROLLO PRESENZA --%>
        <c:if test="${not empty param.presenza}">
        AND AP.PRESENZA = ?
        <sql:param value="${param.presenza}"/>
        </c:if>

        <c:if test="${param.ordine == 'Crescente'}">
        ORDER BY AP.DATA_ORA ASC
        </c:if>
      
        <c:if test="${param.ordine == 'Decrescente'}">
        ORDER BY AP.DATA_ORA DESC
        </c:if>
      </sql:query>
<!-- ================== Script per il menu a comparsa ================== -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script>$(document).ready(function(){
    $("#menuButton").click(function(){
      $("#menu").slideToggle();
    });
  });</script>

<!--======================MENU A COMPARSA=================-->

<tr height="60">
            <td align="center" colspan="6">
                <button id="menuButton"><font color="#25544">Note correzione</font></button>
            </td>
        </tr>
        <tr>
            <td colspan="5" align="center">
                <div id="menu" style="display:none;" align="left">
                  <table cellpadding="10">
                  <tr>
                  <td>
                  <p>In questa pagina sono presenti i seguenti controlli:</p>
                  <ul>
                  <li>Se non sono presenti appuntamenti fissati viene mostrato un messaggio di errore apposito;</li>
                  <li>Se i parametri inseriti nei filtri per vagliare gli appuntamenti non producono risultati, viene visualizzato un apposito messaggio di errore;</li>
                  </ul>
                </td>
                </tr>
                </table>
               </div>
            </td>
        </tr>
  <!----------------------------- Pulsanti Cerca/Mostra tutto ---------------------- -->
  <form method="post" action="#">
  <input type="hidden" name="dettagli" value="${param.dettagli}"/>
  <input type="hidden" name="nome_studio" value="${param.nome_studio}"/>
  <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
  <input type="hidden" name="incentivo" value="${param.incentivo}"/>
  <input type="hidden" name="posizione_studio" value="${param.posizione_studio}"/>
  <input type="hidden" name="data_ora_iscriz" value="${data_ora_iscrizione}"/>
  <input type="hidden" name="id_iscrizione" value="${param.id_iscrizione}"/>


      <tr height="60%" width="100%">
        <td valign="middle" align="center" bgcolor="white" colspan="5">

          <!-- -------------------- Calendario intestazione -------------------- -->
          <h2 style="color:#25544E">Appuntamenti svolti per lo studio "${param.nome_studio}"<br/></h2>
          <p style="color:#25544E">
            <i>In questa pagina e' possibile visualizzare tutti gli appuntamenti conclusi che sono stati fatti per lo studio selezionato.<br/>La tabella e' di sola visualizzazione.<br/><br/><br/></i>
          </p>
          <h2 style="color:#25544E">Opzioni di visualizzazione:<br/><br/></h2>
          <table valign="middle" align="center" border="0" cellspacing="0" cellpadding="10">
            <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
              
              <td>Ordine:</td>
              <td align="left">
                <input type="radio" name="ordine" value="Decrescente" onChange="this.form.submit();"
                <c:if test="${param.ordine == 'Decrescente'}">checked="checked"</c:if>
                /> Dal piu' recente al piu' lontano
              </td>
              <td align="left">
                <input type="radio" name="ordine" value="Crescente" onChange="this.form.submit();"
                <c:if test="${param.ordine == 'Crescente'}">checked="checked"</c:if>
                /> Dal piu' lontano al piu' recente
              </td>
            </tr>
          </table>
        </td>
      </tr>

      <tr>
      <td align="center" colspan="5">
        <table valign="middle" align="center" border="0" width="500px" cellspacing="0" cellpadding="10">
          <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
            <td>
              <input type="submit" name="cerca" id="submit-button" value="Cerca" align="center" style="color:#468c7f"/>
            </td>
          </tr>
          <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
            <td>
              <p style="color:#25544E">
                <i>Per ripristinare il valore dei filtri, premere sui "-- Segnaposto --"<br/></i>
              </p>
            </td>
          </tr>
        </table>
      </td>
      </tr>

      <!-- -------------------- Messaggio -------------------- -->
      <c:if test="${rset_appsv.rowCount == 0 && (
        empty param.data_app &&
        empty param.presenza &&
        (empty paramValues.responsabile || paramValues.responsabile[0] == '')
      )}">
        <tr>
          <td valign="middle" align="center" colspan="5">
            <font style="color:red"><b>Non risultano presenti appuntamenti svolti per questo studio.<br/></b></font>
          </td>
        </tr>
      </c:if>
      
      <c:if test="${rset_appsv.rowCount == 0 && not empty param.data_app}">
        <tr>
          <td valign="middle" align="center" colspan="5">
            <font style="color:red"><b>La ricerca della data non ha prodotto alcun risultato.<br/></b></font>
          </td>
        </tr>
      </c:if>

      <!-- -------------------- Tabella appuntamenti svolti -------------------- -->
      <tr>
      <td align="center" colspan="5">
        <table valign="middle" align="center" border="0" width="900px" cellspacing="0" cellpadding="10">
          <tr bgcolor="#2a5951" style="color:white" height="60" width="15%">
            <th> Data e ora </th>
            <th> Luogo </th>
            <th> Dettagli luogo </th>
            <th> Responsabile </th>
            <th> Presenza </th>
            <th> Complicazioni </th>
          </tr>

          <!-- -------------------- Filtri -------------------- -->
          <tr valign="middle" bgcolor="#f2f2f2">

            <td align="center">
              <input type="datetime-local" name="data_app" value="${param.data_app}"/>
            </td>

            <td> &nbsp </td>

            <td> &nbsp </td>
            
            <td align="center">
              <select name="responsabile" multiple="multiple">
                <option value="" align="center">-- Responsabile --</option>
                <c:forEach items="${rset_select_responsabile.rows}" var="resp">
                  <option value="${resp.ID_RESP}" align="center"
                  <c:forEach items="${paramValues.responsabile}" var="parresp">
                    <c:if test="${parresp == resp.ID_RESP}">selected="selected"</c:if>
                  </c:forEach>
                  >${resp.NOME} ${resp.COGNOME}</option>
                </c:forEach>
              </select>
            </td>

            <td align="center">
              <select name="presenza">
                <option value="" align="center">-- Presenza --</option>
                <c:forEach items="${rset_select_presenza.rows}" var="pres1">
                  <option value="${pres1.PRESENZA}" align="center"
                    <c:if test="${presenza == pres1.PRESENZA}">selected="selected"</c:if>
                  >${pres1.PRESENZA}</option>
                </c:forEach>
              </select>
            </td>
            <td>&nbsp</td>
          </tr>
  </form>

          <!-- -------------------- Tuple -------------------- -->
          <tbody>
            <c:forEach items="${rset_appsv.rows}" var="appsv">
              <tr align="center" style="color:#468c7f" bgcolor="#f2f2f2">

                <!-- Formattazione dell'output date -->
                <fmt:formatDate value="${appsv.DATA_ORA}" var="data"
		                            type="both"
		                            dateStyle="short"
	              />
                <td>${data}</td>
                <td>${appsv.LUOGO}</td>
                <td>${appsv.DETTAGLI_LUOGO}</td>
                <td>${appsv.NOME} ${appsv.COGNOME}</td>

                <c:if test="${appsv.PRESENZA == 'Presente'}">
                  <td><img src="Arruolato.png" width="30" height="30" alt="bottone"></td>
                </c:if>
                <c:if test="${appsv.PRESENZA == 'Assente'}">
                  <td><img src="Scartato.png" width="30" height="30" alt="bottone"></td>
                </c:if>

                <td>${appsv.NOTE}</td>
              </tr>
            </c:forEach>
          </tbody>

        </table>
      </div>
      </td>
      </tr>
    </c:if>

    <!-- ==================== Incentivo ===================== -->  

    <c:if test="${param.dettagli == 'incentivo'}">
    
      <!-- -------------------- Intestazione tabella -------------------- -->
      <tr height="60%" width="100%"  valign="middle">
        <td align="center" colspan="5">
            <h2 style="color:#25544E">Incentivo relativo allo studio "${param.nome_studio}":<br/></h2>
            <p style="color:#25544E">
              <i>In questa pagina e' possibile visualizzare l'incentivo percepito per la partecipazione allo studio selezionato.</i>
            </p> 
        </td>
      </tr>

        <!-- --------------------- Tabella --------------------- -->
      <tr>
        <td align="center" colspan="5">
          <table valign="middle" align="center" border="0" width="50%" cellspacing="0" cellpadding="10">
            <tr bgcolor="#2a5951" style="color:white" height="60">
              <th> Incentivo previsto </th>
              <th> Incentivo percepito </th>
            </tr>
            <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
              <td>${param.incentivo}</td>
              <td align="center"> 
                <c:choose>
                  <c:when test="${param.posizione_studio == 10 || param.posizione_studio == 20}">
                  In attesa
                  </c:when>
                  <c:when test="${param.posizione_studio == 30 || param.posizione_studio == 40}">
                  0
                  </c:when>
                  <c:otherwise>
                  ${param.incentivo}
                  </c:otherwise>
                </c:choose>
              </td>             
            </tr>
          </table>
        </td>
      </tr>
    </c:if>

    <c:if test="${param.dettagli == 'visita_medica'}">

    <!-- QUERY VISITA -->
    <sql:query var="scheda">
      SELECT E.ID_VISITA, E.ALTEZZA_CM, E.COD_IDONEITA, E.COMPLICANZE, E.FREQUENZA_CARDIACA, 
      E.PRESSIONE_MAX, E.PRESSIONE_MIN, E.PESO_KG, M.NOME, M.COGNOME, E.DATA_VISITA, E.COD_IDONEITA, E.CERTIFICATO
      FROM ESITO_VISITA E, MED M, ISCRIZIONE I
      WHERE E.ID_MED = M.ID_MED
      AND E.ID_VISITA = I.ID_VISITA
      AND I.ID_ISCRIZ = ?
      <sql:param value="${param.id_iscrizione}"/>
    </sql:query>

    <!-- ==================== Corpo Centrale ===================== -->

    <tr>
      <td colspan="5" align="center">
        <!-- -------------------- Intestazione -------------------- -->
        <h2 style="color:#25544E">Visita medica per lo studio "${param.nome_studio}"<br/></h2>
        <p style="color:#25544E">
          <i>In questa pagina e' possibile visualizzare tutti i dettagli relativi alla visita medica sostenuta per lo studio selezionato.<br/>La tabella e' di sola visualizzazione.</i>
        </p>
      </td>
    </tr>

    <c:choose>
    <c:when test="${empty scheda.rows[0].COD_IDONEITA}">
    <tr>
      <td colspan="5" align="center">
        <h2 style="color:#25544E">La visita medica non e' ancora stata effettuata.<br/></h2>
      </td>
    </tr>
    </c:when>
    <c:otherwise>
    <tr>
      <td colspan="5" align="center">
       <p style="color:#25544E">
          <i><b>Per fare il download del certificato, premere qui:<br/><br/><a onClick='window.open("certificato${scheda.rows[0].ID_VISITA}.pdf?pdf=${scheda.rows[0].CERTIFICATO}","certificato")'><img src="download.png" heigh="50" width="50"></a></b><br/><br/>
          Dal certificato si risulta:<br/></i>
        </p>
        <input type="checkbox" name="idoneita" style="color:#2a5951"
        <c:if test="${scheda.rows[0].COD_IDONEITA == 1}">checked="checked"</c:if> disabled="disabled"
        > Idoneo </checkbox></td>
      </td>
    </tr>

    <!-- Formattazione dell'output date -->
    <fmt:formatDate value="${scheda.rows[0].DATA_VISITA}" var="data"
                    type="date"
                    dateStyle="short"
    />

    <tr>
      <td colspan="5" align="center">
        <h4>La visita medica e' stata seguita dal medico ${scheda.rows[0].COGNOME} ${scheda.rows[0].NOME} in data ${data}.<br/></h4>
      </td>
    </tr>

    <tr width="100%"> 
      <td valign="middle" bgcolor="white" align="center" colspan="5" height="100%" width="100%">

        <table cellpadding="5" border="0" width="50%">
          <h2 style="color:#25544E">Risultati visita:<br></h2>

          <c:forEach items="${scheda.rows}" var="dati">
            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Altezza:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.ALTEZZA_CM} cm
              </td>
            </tr>
    
            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Peso:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.PESO_KG} kg
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Peso:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.PESO_KG} kg
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Frequenza cardiaca:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.FREQUENZA_CARDIACA} bpm
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Pressione minima:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.PRESSIONE_MIN} mmHg
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Pressione massima:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.PRESSIONE_MAX} mmHg
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Complicanza:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.COMPLICANZE}
              </td>
            </tr>
          </c:forEach>
        </table>
      </td>
    </tr>
    </c:otherwise>
    </c:choose>
    </c:if>

<%@ include file="LAYOUT_BOTTOM.jspf" %>