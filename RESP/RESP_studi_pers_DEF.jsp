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
<%-- Query per l estrazione di tutti i parametri                         --%>
<%-- =================================================================== --%>
<sql:query var="rset_studio">
SELECT S.ID_SSC, S.NOME_STUDIO, S.AREA_TERAPEUTICA, S.POPOLAZIONE, S.DATA_INIZIO, S.DATA_FINE, S.DESCRIZIONE, S.ESITO, ST.descr, S.RIVISTO, S.VIS_MED, V.DESCR_VIS
  FROM SSC S, stato_studio ST, VISITA_MEDICA V
  WHERE S.COD_STATO_STUDIO=ST.cod AND S.VIS_MED=V.CODICE
        AND S.ID_RESP = ?
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

              <%----------------------------------- AREA CONTROLLO SELECT ----------------------%>
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

              <%-- CONTROLLO STATO SSC --%>
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


<%-- =================================================================== --%>
<%-- Query per l estrazione di tutti i parametri                         --%>
<%-- =================================================================== --%>
<sql:query var="rset_select_areaterapeutica">
  SELECT DISTINCT S.AREA_TERAPEUTICA
  FROM SSC S
  WHERE S.ID_RESP=?
    AND S.AREA_TERAPEUTICA IS NOT NULL 
  <sql:param value="${id_user}"/>
</sql:query>

<%-- =================================================================== --%>
<%-- Query per l estrazione di tutti i parametri                         --%>
<%-- =================================================================== --%>
<sql:query var="rset_select_posizione">
  SELECT DISTINCT ST.cod, ST.descr
  FROM SSC S, stato_studio ST
  WHERE S.COD_STATO_STUDIO = ST.cod
  AND S.ID_RESP = ?
  <sql:param value="${id_user}"/>
</sql:query>



<!-- ==================== Corpo Centrale ===================== -->

<!-- --------------------- Intestazione --------------------- -->
<c:if test="${empty ok_msg}">
  <tr>
    <td align="center" colspan="2">
      <img src="health_check.png" height="150" alt="Lista studi"/><br/>
      <h3 align="center" style="color:#25544E">I miei studi</h3>
      <p>
        <i>In questa sezione e' possibile visualizzare l'elenco delle proprie SSC</i>
      </p>
    </td>
  </tr>
</c:if>


  <!--visualizzazione messaggi -->
  <c:if test="${not empty ok_msg}">
    <tr>
      <td align="center" colspan="2">
       <img src="check.png" height="100" alt="Verificato">
      </td>
    </tr>
    <tr>
      <td align="center" colspan="2"><font color="green"> <b>${ok_msg}</b></td>
    </tr>
  </c:if>

 <c:if test="${not empty ok_conf}">
    <tr>
      <td align="center" colspan="2">
       <img src="check.png" height="100" alt="Verificato">
      </td>
    </tr>
    <tr>
      <td align="center" colspan="2"><font color="green"> <b>${ok_conf}</b></td>
    </tr>
  </c:if>

 <!----------------------------- Pulsanti Cerca/Mostra tutto ---------------------- -->
        <form method="post" action="RESP_studi_pers_DEF.jsp">
            <tr>
              <td valign="middle" align="center">
                <table valign="middle" align="center" border="0" width="30%" cellspacing="0" cellpadding="15">
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

<!-- MESSAGGI -->
<c:if test="${rset_studio.rowCount == 0 && (
                          not empty param.nome_studio ||
                          not empty param.descrizione ||
                          not empty param.data_inizio ||
                          not empty param.data_fine
                        )}">
              <tr>
                <td valign="middle" align="center">
                  <font style="color:red"><b>La ricerca non ha prodotto alcun risultato.<br/></b></font>
                </td>
              </tr>
            </c:if>

            <c:if test="${rset_studio.rowCount == 0 && (
              empty param.nome_studio &&
              empty param.descrizione &&
              empty param.data_inizio &&
              empty param.data_fine &&
              (empty paramValues.areaterapeutica || paramValues.areaterapeutica[0] == '') &&
              (empty paramValues.posizione || paramValues.posizione[0] == '')
            )}">
              <tr>
                <td valign="middle" align="center">
                  <font style="color:red"><b>Non risulta compilata nessuna SSC.<br/></b></font>
                </td>
              </tr>
            </c:if>


<!-- ==============Tabella =============== -->
<c:if test="${rset_studio.rows[0].RIVISTO == 1}">
<tr>
 <td align="center">
<i style="color:#468c7f">NOTA: Sono evidenziate in giallo le SSC che il PRES ha giudicato come "Rivedibili". Si consultino le informazioni di dettaglio e si provveda ad apportare le modifiche richieste.</i>
 </td>
</tr>
</c:if>
<tr>
    <td align="center">
      
        <table valign="middle" align="center" border="0" width="100%" cellspacing="0" cellpadding="10">
          <tr bgcolor="#2a5951" style="color:white" height="60" width="15%">

              <th>Malattia</th>
              <th>Area Terapeutica</th>
              <th>Popolazione Target</th>
              <th>Data Inizio</th>
              <th>Data Fine</th>
              <th>Descrizione</th>
              <th>Stato</th>
              <th>Dettagli</th>
              <th>Visita Medica</th>
              <th>Risultati</th>
          </tr>

 <!--------------------------- FILTRI ---------------------------->
                  <tr valign="middle" bgcolor="f2f2f2">

                    <td align="center">
                      <input type="text" id="search" name="nome_studio" value="${param.nome_studio}" size="13"  placeholder="Cerca..."/>
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

                    <td>&nbsp</td>

                    <td align="center">
                      <input type="date" name="data_inizio" value="${param.data_inizio}"/>
                    </td>
        
                    <td align="center">
                      <input type="date" name="data_fine" value="${param.data_fine}"/>
                    </td>

                    <td align="center">
                      <input type="text" id="search" name="descrizione" value="${param.descrizione}" size="13" placeholder="Cerca..."/>
                    </td>

                    <td align="center">
                      <select name="posizione" multiple="multiple">
                        <option value="" align="center">-- Stato --</option>
                        <c:forEach items="${rset_select_posizione.rows}" var="pos">
                          <option value="${pos.cod}" align="center"
                          <c:forEach items="${paramValues.posizione}" var="parpos">
                            <c:if test="${parpos == pos.cod}">selected="selected"</c:if>
                          </c:forEach>
                          >${pos.descr}</option>
                        </c:forEach>
                      </select>
                    </td>
                    
                   <td>&nbsp</td>
                   <td>&nbsp</td>
                   <td>&nbsp</td>
                  </tr>
        </form>

<tbody>
        

        
        <c:forEach items="${rset_studio.rows}" var="var_studi">
          <c:if test="${var_studi.RIVISTO == 1}">
          <tr bgcolor="#FFFF66" height="50" align="center" valign="middle" style="color:#468c7f">

              <td>${var_studi.NOME_STUDIO}</td>
              <td>${var_studi.AREA_TERAPEUTICA}</td>
              <td>${var_studi.POPOLAZIONE}</td>

              <fmt:formatDate var="var_mydata_inizio"
                   value="${var_studi.DATA_INIZIO}"
                   type="date"
                   dateStyle="short"/>

              <td>${var_mydata_inizio}</td>

              <fmt:formatDate var="var_mydata_fine"
                   value="${var_studi.DATA_FINE}"
                   type="date"
                   dateStyle="short"/>

                <td>${var_mydata_fine}</td>
                <td>${var_studi.DESCRIZIONE}</td>

               <td>${var_studi.descr}</td>
            


              <td style="color:#468c7f">
                  <form method="post" action="RESP_studi_pers_pg2.jsp">
                      <input type="submit" name="Visualizza Dettagli" value="Visualizza Dettagli" style="color:#468c7f">
                      <input type="hidden" name="id_ssc" value="${var_studi.ID_SSC}"/>
                      <input type="hidden" name="descr" value="${var_studi.descr}"/>
                      <input type="hidden" name="rivisto" value="${var_studi.RIVISTO}"/>
                      <input type="hidden" name="nome" value="${var_studi.NOME_STUDIO}"/>
                      <input type="hidden" name="area" value="${var_studi.AREA_TERAPEUTICA}"/>
                      <input type="hidden" name="popolazione" value="${var_studi.POPOLAZIONE}"/>
                      <input type="hidden" name="datain" value="${var_studi.DATA_INIZIO}"/>
                      <input type="hidden" name="datafine" value="${var_studi.DATA_FINE}"/>
                      <input type="hidden" name="descrizione" value="${var_studi.DESCRIZIONE}"/>
                      <input type="hidden" name="vis_med" value="${var_studi.VIS_MED}"/>
                      <input type="hidden" name="costo_strum" value="${var_studi.COSTO_FISSO_STRUM}"/>
                      <input type="hidden" name="costo_analisi" value="${var_studi.COSTO_FISSO_ANALISI}"/>
                      <input type="hidden" name="incentivo" value="${var_studi.INCENTIVO}"/>
                      <input type="hidden" name="totpaz" value="${var_studi.TOTPAZ}"/>
                      <input type="hidden" name="totconv" value="${var_studi.TOTCONV}"/>
                  </form>
              </td>

              <td>${var_studi.DESCR_VIS}</td>

              <td>
                <c:if test="${var_studi.descr == 'Concluso' && 
                              empty var_studi.ESITO}">
                    <form method="post" action="RESP_compila_risultati.jsp">
                        <input type="submit" name="compila" value="Compila"/>
                        <input type="hidden" name="id_ssc" value="${var_studi.ID_SSC}"/>
                        <input type="hidden" name="descr" value="${var_studi.descr}"/>
                        <input type="hidden" name="rivisto" value="${var_studi.RIVISTO}"/>
                        <input type="hidden" name="nome" value="${var_studi.NOME_STUDIO}"/>
                        <input type="hidden" name="area" value="${var_studi.AREA_TERAPEUTICA}"/>
                        <input type="hidden" name="popolazione" value="${var_studi.POPOLAZIONE}"/>
                        <input type="hidden" name="datain" value="${var_studi.DATA_INIZIO}"/>
                        <input type="hidden" name="datafine" value="${var_studi.DATA_FINE}"/>
                        <input type="hidden" name="descrizione" value="${var_studi.DESCRIZIONE}"/>
                    </form>
                </c:if>

            <c:if test="${not empty var_studi.ESITO}">

               <form method="post" action="RESP_vis_risultati.jsp">
                 <input type="submit" value="Visualizza"/>
                      <input type="hidden" name="id_ssc" value="${var_studi.ID_SSC}"/>
                      <input type="hidden" name="descr" value="${var_studi.descr}"/>
                      <input type="hidden" name="rivisto" value="${var_studi.RIVISTO}"/>
                      <input type="hidden" name="nome" value="${var_studi.NOME_STUDIO}"/>
                      <input type="hidden" name="area" value="${var_studi.AREA_TERAPEUTICA}"/>
                      <input type="hidden" name="popolazione" value="${var_studi.POPOLAZIONE}"/>
                      <input type="hidden" name="datain" value="${var_studi.DATA_INIZIO}"/>
                      <input type="hidden" name="datafine" value="${var_studi.DATA_FINE}"/>
                      <input type="hidden" name="descrizione" value="${var_studi.DESCRIZIONE}"/>
               </form>

            </c:if>
              </td>
            </tr>
            </c:if>
            
            <c:if test="${var_studi.RIVISTO == 0}">
            <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">

              <td>${var_studi.NOME_STUDIO}</td>
              <td>${var_studi.AREA_TERAPEUTICA}</td>
              <td>${var_studi.POPOLAZIONE}</td>

              <fmt:formatDate var="var_mydata_inizio"
                   value="${var_studi.DATA_INIZIO}"
                   type="date"
                   dateStyle="short"/>

              <td>${var_mydata_inizio}</td>

              <fmt:formatDate var="var_mydata_fine"
                   value="${var_studi.DATA_FINE}"
                   type="date"
                   dateStyle="short"/>

                <td>${var_mydata_fine}</td>
                <td>${var_studi.DESCRIZIONE}</td>

               <td>${var_studi.descr}</td>
            


              <td>
                  <form method="post" action="RESP_studi_pers_pg2.jsp">
                      <input type="submit" name="Visualizza Dettagli" value="Visualizza Dettagli">
                      <input type="hidden" name="id_ssc" value="${var_studi.ID_SSC}"/>
                      <input type="hidden" name="descr" value="${var_studi.descr}"/>
                      <input type="hidden" name="rivisto" value="${var_studi.RIVISTO}"/>
                      <input type="hidden" name="nome" value="${var_studi.NOME_STUDIO}"/>
                      <input type="hidden" name="area" value="${var_studi.AREA_TERAPEUTICA}"/>
                      <input type="hidden" name="popolazione" value="${var_studi.POPOLAZIONE}"/>
                      <input type="hidden" name="datain" value="${var_studi.DATA_INIZIO}"/>
                      <input type="hidden" name="datafine" value="${var_studi.DATA_FINE}"/>
                      <input type="hidden" name="descrizione" value="${var_studi.DESCRIZIONE}"/>
                      <input type="hidden" name="vis_med" value="${var_studi.VIS_MED}"/>
                      <input type="hidden" name="costo_strum" value="${var_studi.COSTO_FISSO_STRUM}"/>
                      <input type="hidden" name="costo_analisi" value="${var_studi.COSTO_FISSO_ANALISI}"/>
                      <input type="hidden" name="incentivo" value="${var_studi.INCENTIVO}"/>
                      <input type="hidden" name="totpaz" value="${var_studi.TOTPAZ}"/>
                      <input type="hidden" name="totconv" value="${var_studi.TOTCONV}"/>
                  </form>
              </td>

              <td>${var_studi.DESCR_VIS}</td>       

              <td>
                <c:if test="${var_studi.descr == 'Concluso' && 
                              empty var_studi.ESITO}">
                    <form method="post" action="RESP_compila_risultati.jsp">
                        <input type="submit" name="compila" value="Compila"/>
                        <input type="hidden" name="id_ssc" value="${var_studi.ID_SSC}"/>
                        <input type="hidden" name="descr" value="${var_studi.descr}"/>
                        <input type="hidden" name="rivisto" value="${var_studi.RIVISTO}"/>
                        <input type="hidden" name="nome" value="${var_studi.NOME_STUDIO}"/>
                        <input type="hidden" name="area" value="${var_studi.AREA_TERAPEUTICA}"/>
                        <input type="hidden" name="popolazione" value="${var_studi.POPOLAZIONE}"/>
                        <input type="hidden" name="datain" value="${var_studi.DATA_INIZIO}"/>
                        <input type="hidden" name="datafine" value="${var_studi.DATA_FINE}"/>
                        <input type="hidden" name="descrizione" value="${var_studi.DESCRIZIONE}"/>
                    </form>
                </c:if>

            <c:if test="${not empty var_studi.ESITO}">

               <form method="post" action="RESP_vis_risultati.jsp">
                 <input type="submit" value="Visualizza"/>
                      <input type="hidden" name="id_ssc" value="${var_studi.ID_SSC}"/>
                      <input type="hidden" name="descr" value="${var_studi.descr}"/>
                      <input type="hidden" name="rivisto" value="${var_studi.RIVISTO}"/>
                      <input type="hidden" name="nome" value="${var_studi.NOME_STUDIO}"/>
                      <input type="hidden" name="area" value="${var_studi.AREA_TERAPEUTICA}"/>
                      <input type="hidden" name="popolazione" value="${var_studi.POPOLAZIONE}"/>
                      <input type="hidden" name="datain" value="${var_studi.DATA_INIZIO}"/>
                      <input type="hidden" name="datafine" value="${var_studi.DATA_FINE}"/>
                      <input type="hidden" name="descrizione" value="${var_studi.DESCRIZIONE}"/>
               </form>

            </c:if>
              </td>
            </tr>
            </c:if>
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
