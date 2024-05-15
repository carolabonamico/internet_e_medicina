<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<c:set var="ruolo_pagina" value="PAZ"/>
<%@ include file="autorizzazione.jspf" %>

<!-- QUERY PER LE SELECT -->
<sql:query var="rset_select_responsabile">
    SELECT DISTINCT R.ID_RESP, R.NOME, R.COGNOME
    FROM SSC S, RESP R
    WHERE S.ID_RESP = R.ID_RESP 
    AND (S.COD_STATO_STUDIO = 40 OR S.COD_STATO_STUDIO = 50)
    AND S.ID_SSC NOT IN (SELECT I.ID_SSC FROM ISCRIZIONE I WHERE S.ID_SSC = I.ID_SSC AND I.ID_PAZ = ?)
    <sql:param value="${id_user}"/>
</sql:query>

<sql:query var="rset_select_areaterapeutica">
    SELECT DISTINCT S.AREA_TERAPEUTICA
    FROM SSC S, RESP R
    WHERE S.ID_RESP = R.ID_RESP 
    AND (S.COD_STATO_STUDIO = 40 OR S.COD_STATO_STUDIO = 50)
    AND S.ID_SSC NOT IN (SELECT I.ID_SSC FROM ISCRIZIONE I WHERE S.ID_SSC = I.ID_SSC AND I.ID_PAZ = ?)
    <sql:param value="${id_user}"/>
</sql:query>

<sql:query var="rset_studi">
  SELECT S.NOME_STUDIO, S.DESCRIZIONE, S.AREA_TERAPEUTICA, S.POPOLAZIONE, 
  S.DATA_INIZIO, S.DATA_FINE, R.NOME, R.COGNOME, S.INCENTIVO, S.ID_SSC, S.VIS_MED
  FROM SSC S, RESP R
  WHERE S.ID_RESP = R.ID_RESP 
  AND (S.COD_STATO_STUDIO = 40 OR S.COD_STATO_STUDIO = 50) 
  AND S.ID_SSC NOT IN (SELECT I.ID_SSC FROM ISCRIZIONE I WHERE S.ID_SSC = I.ID_SSC AND I.ID_PAZ = ?)
  <sql:param value="${id_user}"/>


    
              <%-------------------------- AREA CONTROLLI TEXT AREE ------------------------%>
              <%-- CONTROLLO NOME STUDIO --%>
              <c:if test="${not empty param.nome_studio}">
              AND UPPER(S.NOME_STUDIO) LIKE ?
              <sql:param value="${fn:toUpperCase(param.nome_studio)}%"/>
              </c:if>

              <%-- CONTROLLO DESCRIZIONE --%>
              <c:if test="${not empty param.descrizione}">
              AND UPPER(S.DESCRIZIONE) LIKE ?
              <sql:param value="${fn:toUpperCase(param.descrizione)}%"/>
              </c:if>
            
              <%-- CONTROLLO POPOLAZIONE--%>
              <c:if test="${not empty param.popolazione}">
              AND UPPER(S.POPOLAZIONE) LIKE ?
                <sql:param value="${fn:toUpperCase(param.popolazione)}%"/>
              </c:if>

              <%------------------------------ AREA CONTROLLO NUMBER --------------------------%>
              <%-- CONTROLLO INCENTIVO --%>
              <c:if test="${not empty param.incentivo}">
              AND S.INCENTIVO = ?
                <sql:param value="${param.incentivo}%"/>
              </c:if>

              <%-------------------------- AREA CONTROLLO DATE ---------------------%>
              <%-- DATA INIZIO --%>
              <c:if test="${not empty param.data_inizio}">
              AND S.DATA_INIZIO = ?
                <sql:param value="${param.data_inizio}%"/>
              </c:if>

              <%-- DATA FINE --%>
              <c:if test="${not empty param.data_fine}">
              AND S.DATA_FINE = ?
                <sql:param value="${param.data_fine}%"/>
              </c:if>

              <%----------------------------------- AREA CONTROLLO SELECT ------------------------------%>
              <%-- CONTROLLO AREA TERAPEUTICA --%>
              <c:if test="${not empty paramValues.areaterapeutica && paramValues.areaterapeutica[0] != ''}">
              <c:set var="dim_at" value="${fn:length(paramValues.areaterapeutica)}"/>
              <c:if test="${dim_at == 1}">
              AND S.AREA_TERAPEUTICA = ?
              <sql:param value="${paramValues.areaterapeutica[0]}"/>
              </c:if>
              <c:if test="${dim_at == 2}">
              AND (S.AREA_TERAPEUTICA = ?
              OR S.AREA_TERAPEUTICA = ?)
              <sql:param value="${paramValues.areaterapeutica[0]}"/>
              <sql:param value="${paramValues.areaterapeutica[1]}"/>
              </c:if>
              <c:if test="${dim_at > 2}">
              AND (S.AREA_TERAPEUTICA = ?
              <sql:param value="${paramValues.areaterapeutica[0]}"/>
              <c:forEach items="${paramValues.areaterapeutica}" begin="1" end="${dim_at-2}" var="myarea">
              OR S.AREA_TERAPEUTICA = ?
              <sql:param value="${myarea}"/>
              </c:forEach>
              OR S.AREA_TERAPEUTICA = ?)
              <sql:param value="${paramValues.areaterapeutica[dim_at-1]}"/>
              </c:if>
              </c:if>
              
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
</sql:query>

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_PAZ.jspf" %>

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
                  <li>Se non sono presenti studi ai quali iscriversi viene mostrato un messaggio di errore apposito;</li>
                  <li>Se i parametri inseriti nei filtri per vagliare gli studi non producono risultati, viene visualizzato un apposito messaggio di errore;</li>
                  <li>Se e' necessario sottoporsi ad una visita medica per partecipare allo studio, nella pagina di conferma deve essere selezionato un medico presso cui effettuarla.</li>
                  </ul>
                </td>
                </tr>
                </table>
               </div>
            </td>
        </tr>


<!-- ==================== Corpo Centrale ===================== -->

  <!-- --------------------------- Intestazione --------------------------- -->
  <tr height="60%" width="100%"  valign="middle">
    <td align="center" bgcolor="white" cellpadding="10">
      <img src="healthcare2.png" height="150" alt="I miei studi"><br/><br/>
      <h2 style="color:#25544E">Studi attivi<br/></h2>
      <p style="color:#25544E">
        <i>In questa pagina e' possibile visualizzare tutte le informazioni relative agli studi attivi a cui poter partecipare.
        <br/>Attenzione: utilizzare lo scroll orizzontale per visualizzare tutte le informazioni.<br/></i>
      </p>
    </td>
  </tr>

    <!----------------------------- Pulsanti Cerca/Mostra tutto ---------------------- -->
    <form method="post" action="PAZ_studiattivi.jsp">
    <tr>
      <td valign="middle" align="center">
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

    <c:if test="${rset_studi.rowCount == 0 && (
                  not empty param.nome_studio ||
                  not empty param.descrizione ||
                  not empty param.incentivo ||
                  not empty param.data_inizio ||
                  not empty param.data_fine ||
                  not empty param.popolazione
                )}">
      <tr>
        <td valign="middle" align="center">
          <font style="color:red"><b>La ricerca non ha prodotto alcun risultato.<br/></b></font>
        </td>
      </tr>
    </c:if>

    <c:if test="${rset_studi.rowCount == 0 && (
      empty param.nome_studio &&
      empty param.descrizione &&
      empty param.incentivo &&
      empty param.data_inizio &&
      empty param.data_fine &&
      empty param.popolazione &&
      (empty paramValues.responsabile || paramValues.responsabile[0] == '') &&
      (empty paramValues.responsabile || paramValues.areaterapeutica[0] == '')
    )}">
      <tr>
        <td valign="middle" align="center">
          <font style="color:red"><b>Al momento non sono presenti studi a cui potersi iscrivere.<br/></b></font>
        </td>
      </tr>
    </c:if>

    <tr valign="middle">
      <td align="center" bgcolor="white" cellpadding="10">

        <!------------ Tabella studi clinici -------------->
        <table valign="middle" align="center" border="0" width="100%" cellspacing="0" cellpadding="15">
          <tr bgcolor="#2a5951" style="color:white" height="60">
            <th> &nbsp </th>
            <th> Nome Studio Clinico </th>
            <th> Descrizione studio clinico </th>
            <th> Area terapeutica </th>
            <th> Popolazione </th>
            <th> Data Inizio </th>
            <th> Data Fine </th>
            <th> Responsabile </th>
            <th> Incentivo </th>
          </tr>

          <!--------------------------- FILTRI ---------------------------->
          <tr valign="middle" bgcolor="#f2f2f2">
            <td> &nbsp; </td>

            <td align="center">
              <input type="text" id="search" name="nome_studio" value="${param.nome_studio}" length="10" placeholder="Cerca..."/>
            </td>

            <td align="center">
                <input type="text" id="search" name="descrizione" value="${param.descrizione}" length="10" placeholder="Cerca..."/>
            </td>

            <td align="center">
              <select name="areaterapeutica" multiple="multiple">
                <option value="" align="center">-- Area --</option>
                <c:forEach items="${rset_select_areaterapeutica.rows}" var="area">
                  <option value="${area.AREA_TERAPEUTICA}" align="center"
                  <c:forEach items="${paramValues.areaterapeutica}" var="terapeutica">
                    <c:if test="${terapeutica == area.AREA_TERAPEUTICA}">selected="selected"</c:if>
                  </c:forEach>
                  >${area.AREA_TERAPEUTICA}</option>
                </c:forEach>
              </select>
            </td>

            <td align="center">
              <input type="text" id="search" name="popolazione" value="${param.popolazione}" length="10" placeholder="Cerca..."/>
            </td>

            <td align="center">
              <input type="date" name="data_inizio" value="${param.data_inizio}"/>
            </td>

            <td align="center">
              <input type="date" name="data_fine" value="${param.data_fine}"/>
            </td>

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
              <input type="number" min="0" name="incentivo" id="number" value="${param.incentivo}"/>
            </td>           
          </tr>           
          </tr>
    </form>

          <tbody>
          <c:forEach items="${rset_studi.rows}" var="studi">
            <form method="post" action="PAZ_confermapartecipa.jsp">
              <tr align="center" bgcolor="#f2f2f2" style="color:#468c7f">
                <td>
                  <input type="submit" name="partecipa" value="Partecipa" align="center" style="color:#468c7f"/>
                  <input type="hidden" name="nome_studio_att" value="${studi.NOME_STUDIO}"/>
                  <input type="hidden" name="id_ssc" value="${studi.ID_SSC}"/>
                  <input type="hidden" name="vis_med" value="${studi.VIS_MED}"/>
                </td>
                <td>${studi.NOME_STUDIO}</td>
                <td>${studi.DESCRIZIONE}</td>
                <td>${studi.AREA_TERAPEUTICA}</td>
                <td>${studi.POPOLAZIONE}</td>

                <!-- Formattazione dell'output date -->
                <fmt:formatDate value="${studi.DATA_INIZIO}" var="inizio"
		                            type="date"
		                            dateStyle="short"
	              />
                <fmt:formatDate value="${studi.DATA_FINE}" var="fine"
                                type="date"
                                dateStyle="short"
                />

                <td>${inizio}</td>
                <td>${fine}</td>

                <td>${studi.NOME} ${studi.COGNOME}</td>
                <td>${studi.INCENTIVO}</td>
              </tr>
            </form>
          </c:forEach>
          </tbody>
        </table>
        <script>
          const searchInput = document.getElementById("search");
          const rows = document.querySelectorAll("tbody tr");
          searchInput.addEventListener("keyup", function (event) {
            const q = event.target.value.toLowerCase();
            rows.forEach((row) => {
              row.querySelector("td").textContent.toLowerCase().startsWith(q)
                ? (row.style.display = "table-row")
                : (row.style.display = "none");
            });
          });
        </script>
        </div>
      </td>
    </tr>
          
<%@ include file="LAYOUT_BOTTOM.jspf" %>