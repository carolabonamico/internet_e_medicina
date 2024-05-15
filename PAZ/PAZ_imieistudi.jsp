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
  FROM SSC S, RESP R, stato_paz_studio ST, ISCRIZIONE I
  WHERE S.ID_RESP = R.ID_RESP 
  AND I.COD_STATO_PAZ = ST.cod
  AND I.ID_SSC = S.ID_SSC
  AND I.ID_PAZ = ?
  <sql:param value="${id_user}"/>
</sql:query>

<sql:query var="rset_select_areaterapeutica">
  SELECT DISTINCT S.AREA_TERAPEUTICA
  FROM SSC S, RESP R, stato_paz_studio ST, ISCRIZIONE I
  WHERE S.ID_RESP = R.ID_RESP 
  AND I.COD_STATO_PAZ = ST.cod
  AND I.ID_SSC = S.ID_SSC
  AND I.ID_PAZ = ?
  <sql:param value="${id_user}"/>
</sql:query>

<sql:query var="rset_select_posizione">
  SELECT DISTINCT ST.cod, ST.descr
  FROM SSC S, RESP R, stato_paz_studio ST, ISCRIZIONE I
  WHERE S.ID_RESP = R.ID_RESP 
  AND I.COD_STATO_PAZ = ST.cod
  AND I.ID_SSC = S.ID_SSC
  AND I.ID_PAZ = ?
  <sql:param value="${id_user}"/>
</sql:query>

<sql:query var="rset_studi">
  SELECT S.NOME_STUDIO, S.DESCRIZIONE, S.AREA_TERAPEUTICA, S.DATA_INIZIO, S.DATA_FINE, 
  S.INCENTIVO, S.ID_SSC, R.NOME, R.COGNOME, ST.cod, ST.descr, I.ID_ISCRIZ, S.VIS_MED
  FROM SSC S, RESP R, stato_paz_studio ST, ISCRIZIONE I
  WHERE S.ID_RESP = R.ID_RESP 
  AND I.COD_STATO_PAZ = ST.cod
  AND I.ID_SSC = S.ID_SSC
  AND I.ID_PAZ = ?
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

              <%-- CONTROLLO POSIZIONE --%>
              <c:if test="${not empty paramValues.posizione && paramValues.posizione[0] != ''}">
              <c:set var="dim_pos" value="${fn:length(paramValues.posizione)}"/>
              <c:if test="${dim_pos == 1}">
              AND ST.cod = ?
              <sql:param value="${paramValues.posizione[0]}"/>
              </c:if>
              <c:if test="${dim_pos == 2}">
              AND (ST.cod = ?
              OR ST.cod = ?)
              <sql:param value="${paramValues.posizione[0]}"/>
              <sql:param value="${paramValues.posizione[1]}"/>
              </c:if>
              <c:if test="${dim_pos > 2}">
              AND (ST.cod = ?
              <sql:param value="${paramValues.posizione[0]}"/>
              <c:forEach items="${paramValues.posizione}" begin="1" end="${dim_pos-2}" var="mypos">
              OR ST.cod = ?
              <sql:param value="${mypos}"/>
              </c:forEach>
              OR ST.cod = ?)
              <sql:param value="${paramValues.posizione[dim_pos-1]}"/>
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
                  <li>Se non sono presenti studi ai quali si e' iscritti viene mostrato un messaggio di errore apposito;</li>
                  <li>Se i parametri inseriti nei filtri per vagliare gli studi non producono risultati, viene visualizzato un apposito messaggio di errore;</li>
                  <li>Se non e' necessario sottoporsi ad una visita medica per partecipare allo studio, nella sezione 'dettagli' non verra' visualizzata la voce 'visita medica'.</li>
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
            <td align="center" bgcolor="white" colspan="7" cellpadding="10">
              <img src="medical_record.png" height="150" alt="I miei studi"><br/><br/>
              <h2 style="color:#25544E">I miei studi<br/></h2>
              <p style="color:#25544E">
                <i>In questa pagina e' possibile visualizzare tutti gli studi per cui si e' presentata la richiesta di partecipazione con il relativo stato.
                  <br/>Premere sul pulsante "Dettagli" per visualizzare maggiori informazioni riguardo lo studio selezionato.
                  <br/>Premere "Abbandona" per abbandonare lo studio per cui si e' stati arruolati.
                  <br/>Premere "Annulla iscrizione" per disicriversi da uno studio a cui ci si e' iscritti ma per cui non si e' ancora stati arruolati e per cui non e' prevista alcuna visita medica . 
              </p> 
            </td>
          </tr>

      <!-- --------------------------- Legenda --------------------------- -->

          <tr width="100%">
            <td valign="middle" align="center" bgcolor="white">
              <h2 style="color:#25544E"> Posizioni <br/></h2>
              <table valign="middle" align="center" border="0" width="400px" cellspacing="0" cellpadding="10">
                <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
                  <td><img src="Iscritto.png" width="30" height="30" alt="bottone"></td>
                  <td align="left"> Iscritto </td>
                  <td><img src="Arruolato.png" width="30" height="30" alt="bottone"></td>
                  <td align="left"> Arruolato </td>
                </tr>
                <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
                  <td><img src="Scartato.png" width="30" height="30" alt="bottone"></td>
                  <td align="left"> Scartato </td>
                  <td><img src="Dropout.png" width="30" height="30" alt="bottone"></td>
                  <td align="left"> Dropout </td>
                </tr>
                <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f" >
                  <td>&nbsp</td>
                  <td><img src="Testato.png" width="30" height="30" alt="bottone"></td>
                  <td align="left"> Testato </td>
                  <td>&nbsp</td>
                </tr>
              </table>
            </td>
          </tr>

        <!----------------------------- Pulsanti Cerca/Mostra tutto ---------------------- -->
        <form method="post" action="PAZ_imieistudi.jsp">
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

            <!----------------------------- Messaggi ---------------------- -->
            <c:if test="${confpart == 'true'}">
              <tr>
                <td valign="middle" align="center">
                  <font style="color:green"><b>L'iscrizione allo studio "${param.nome_studio_att2}" e' avvenuta correttamente!</b></font>
                </td>
              </tr>
              <c:set var="confpart" value="false"/>
            </c:if>
            
            <c:if test="${confabb == 'true'}">
              <tr>
                <td valign="middle" align="center">
                  <font style="color:green"><b>Lo studio "${param.nome_studio_att2}" e' stato abbandonato correttamente!</b></font>
                </td>
              </tr>
              <c:set var="confabb" value="false"/>
            </c:if>

            <c:if test="${conf_annull_iscriz == 'true'}">
              <tr>
                <td valign="middle" align="center">
                  <font style="color:green"><b>L'iscrizione allo studio "${param.nome_studio_att2}" e' stata cancellata correttamente!</b></font>
                </td>
              </tr>
              <c:set var="conf_annull_iscriz" value="false"/>
            </c:if>

            <c:if test="${rset_studi.rowCount == 0 && (
                          not empty param.nome_studio ||
                          not empty param.descrizione ||
                          not empty param.incentivo ||
                          not empty param.data_inizio ||
                          not empty param.data_fine
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
              (empty paramValues.responsabile || paramValues.responsabile[0] == '') &&
              (empty paramValues.areaterapeutica || paramValues.areaterapeutica[0] == '') &&
              (empty paramValues.posizione || paramValues.posizione[0] == '')
            )}">
              <tr>
                <td valign="middle" align="center">
                  <font style="color:red"><b>Non si risulta iscritti ad alcuno studio.<br/></b></font>
                </td>
              </tr>
            </c:if>

          <!----------------------------- Tabella ------------------------>
          <tr valign="middle">
            <td align="center">
              <table valign="middle" align="center" border="0" width="100%" cellspacing="0" cellpadding="15">
                <tr bgcolor="#2a5951" style="color:white" height="60">
                    <th>&nbsp</th>
                    <th>Dettagli</th>
                    <th>Posizione</th>
                    <th>Nome Studio Clinico</th>
                    <th>Descrizione</th>
                    <th>Area terapeutica</th>
                    <th>Data Inizio</th>
                    <th>Data Fine</th>
                    <th>Responsabile</th>
                    <th>Incentivo</th>
                  </tr>

                  <!--------------------------- FILTRI ---------------------------->
                  <tr valign="middle" bgcolor="#f2f2f2">

                    <td align="center"> &nbsp </td>

                    <td align="center"> &nbsp </td>

                    <td align="center">
                      <select name="posizione" multiple="multiple">
                        <option value="" align="center">-- Posizione --</option>
                        <c:forEach items="${rset_select_posizione.rows}" var="pos">
                          <option value="${pos.cod}" align="center"
                          <c:forEach items="${paramValues.posizione}" var="parpos">
                            <c:if test="${parpos == pos.cod}">selected="selected"</c:if>
                          </c:forEach>
                          >${pos.descr}</option>
                        </c:forEach>
                      </select>
                    </td>

                    <td align="center">
                      <input type="text" id="search" name="nome_studio" value="${param.nome_studio}" size="13" placeholder="Cerca..."/>
                    </td>   
             
                    <td align="center">
                      <input type="text" id="search" name="descrizione" value="${param.descrizione}" size="13" placeholder="Cerca..."/>
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
        </form>

                    <!-- --------------------------- Tuple --------------------------- -->
                    <tbody>
                      <c:forEach items="${rset_studi.rows}" var="studi">
                        <tr align="center" 
                        <c:if test="${empty param.codice_stato_studio_home || param.codice_stato_studio_home != studi.cod}">bgcolor="#f2f2f2"</c:if>
                        <c:if test="${param.codice_stato_studio_home == studi.cod}">bgcolor="#ffff66"</c:if>
                        style="color:#468c7f">

                          <c:choose>
                            <c:when test="${studi.cod == 20}">
                              <td>
                                <form method="post" action="PAZ_confermaabbandona.jsp">
                                  <input type="submit" name="tasto" value="Abbandona" style="color:#468c7f"/>
                                  <input type="hidden" name="nome_studio_att" value="${studi.NOME_STUDIO}"/>
                                  <input type="hidden" name="id_ssc" value="${studi.ID_SSC}"/>
                                  <input type="hidden" name="id_iscrizione" value="${studi.ID_ISCRIZ}"/>
                                  <input type="hidden" name="posizione_studio" value="${studi.cod}"/>
                                </form>
                              </td>
                            </c:when>
                            <c:when test="${studi.cod == 10 && studi.VIS_MED == 0}">
                              <td>
                                <form method="post" action="PAZ_confermaabbandona.jsp">
                                  <input type="submit" name="tasto" value="Disiscriviti" style="color:#468c7f"/>
                                  <input type="hidden" name="nome_studio_att" value="${studi.NOME_STUDIO}"/>
                                  <input type="hidden" name="id_iscrizione" value="${studi.ID_ISCRIZ}"/>
                                </form>
                              </td>
                            </c:when>
                            <c:otherwise>
                              <td> &nbsp </td>
                            </c:otherwise>
                          </c:choose>

                          <td>
                            <form method="post" action="PAZ_dettagli.jsp">
                              <input type="submit" name="Dettagli" value="Scopri" style="color:#468c7f"/>
                              <input type="hidden" name="nome_studio" value="${studi.NOME_STUDIO}"/>
                              <input type="hidden" name="id_ssc" value="${studi.ID_SSC}"/>
                              <input type="hidden" name="incentivo" value="${studi.INCENTIVO}"/>
                              <input type="hidden" name="posizione_studio" value="${studi.cod}"/>
                              <input type="hidden" name="id_iscrizione" value="${studi.ID_ISCRIZ}"/>
                              <input type="hidden" name="vis_med" value="${studi.VIS_MED}"/>
                            </form>
                          </td>                          

                          <c:if test="${studi.cod == 10}">
                            <td><img src="Iscritto.png" width="30" height="30" alt="bottone"></td>
                          </c:if>
                          <c:if test="${studi.cod == 20}">
                            <td><img src="Arruolato.png" width="30" height="30" alt="bottone"></td>
                          </c:if>
                          <c:if test="${studi.cod == 30}">
                            <td><img src="Scartato.png" width="30" height="30" alt="bottone"></td>
                          </c:if>
                          <c:if test="${studi.cod == 40}">
                            <td><img src="Dropout.png" width="30" height="30" alt="bottone"></td>
                          </c:if>
                          <c:if test="${studi.cod == 50}">
                            <td><img src="Testato.png" width="30" height="30" alt="bottone"></td>
                          </c:if>

                          <td>${studi.NOME_STUDIO}</td>
                          <td>${studi.DESCRIZIONE}</td>
                          <td>${studi.AREA_TERAPEUTICA}</td>

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
            </td>
          </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>