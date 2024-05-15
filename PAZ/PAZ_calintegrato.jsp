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

<!-- Stato presenza codici 
STATO_PRES - DESCRIZIONE_PRES
1 - Convalidato
2 - Da convalidare
3 - Futuro -->


<!-- QUERY PER L'APPUNTAMENTO PIU' RECENTE -->
<sql:query var="rset_app_da_conv">
  SELECT AP.ID_APPUNT, AP.LUOGO, AP.DETTAGLI_LUOGO, AP.DATA_ORA,
  R.NOME, R.COGNOME, R.ID_RESP, S.NOME_STUDIO
  FROM APPUNTAMENTO AP, AVERE_APPUNT AV, ISCRIZIONE I, RESP R, SSC S
  WHERE AP.ID_APPUNT = AV.ID_APPUNT
  AND AV.ID_ISCRIZIONE = I.ID_ISCRIZ
  AND I.ID_SSC = S.ID_SSC
  AND S.ID_RESP = R.ID_RESP
  AND AP.STATO_PRES = 3
  AND I.ID_PAZ = ?
  ORDER BY AP.DATA_ORA ASC
  <sql:param value="${id_user}"/>
</sql:query>

<!-- QUERY PER LE SELECT -->
<sql:query var="rset_select_responsabile">
  SELECT DISTINCT R.ID_RESP, R.NOME, R.COGNOME
  FROM APPUNTAMENTO AP, AVERE_APPUNT AV, ISCRIZIONE I, RESP R, SSC S
  WHERE AP.ID_APPUNT = AV.ID_APPUNT
  AND AV.ID_ISCRIZIONE = I.ID_ISCRIZ
  AND I.ID_SSC = S.ID_SSC
  AND S.ID_RESP = R.ID_RESP
  AND I.ID_PAZ = ?
  <sql:param value="${id_user}"/>
  <c:if test="${param.appuntamenti == 'Svolti'}">
    AND AP.STATO_PRES = 1
  </c:if>

  <c:if test="${param.appuntamenti == 'Fissati'}">
    AND AP.STATO_PRES = 3
  </c:if>

  <c:if test="${param.appuntamenti == 'In attesa'}">
    AND AP.STATO_PRES = 2
  </c:if>
</sql:query>

<sql:query var="rset_select_presenza">
  SELECT DISTINCT AP.PRESENZA
  FROM APPUNTAMENTO AP, AVERE_APPUNT AV, ISCRIZIONE I, RESP R, SSC S
  WHERE AP.ID_APPUNT = AV.ID_APPUNT
  AND AV.ID_ISCRIZIONE = I.ID_ISCRIZ
  AND I.ID_SSC = S.ID_SSC
  AND S.ID_RESP = R.ID_RESP
  AND AP.PRESENZA IS NOT NULL
  AND I.ID_PAZ = ?
  <sql:param value="${id_user}"/>

  <c:if test="${param.appuntamenti == 'Svolti'}">
    AND AP.STATO_PRES = 1
  </c:if>

  <c:if test="${param.appuntamenti == 'Fissati'}">
    AND AP.STATO_PRES = 3
  </c:if>

  <c:if test="${param.appuntamenti == 'In attesa'}">
    AND AP.STATO_PRES = 2
  </c:if>
</sql:query>

<sql:query var="rset_select_stato_presenza">
  SELECT DISTINCT AP.STATO_PRES, SP.DESCRIZIONE_PRES
  FROM APPUNTAMENTO AP, AVERE_APPUNT AV, ISCRIZIONE I, RESP R, SSC S, STATO_PRESENZA SP
  WHERE AP.ID_APPUNT = AV.ID_APPUNT
  AND AV.ID_ISCRIZIONE = I.ID_ISCRIZ
  AND I.ID_SSC = S.ID_SSC
  AND S.ID_RESP = R.ID_RESP
  AND AP.STATO_PRES = SP.STATO_PRES
  AND I.ID_PAZ = ?
  <sql:param value="${id_user}"/>
</sql:query>

<!-- QUERY PER IL CALENDARIO GENERALE -->
<sql:query var="rset_appuntamenti">
  SELECT AP.ID_APPUNT, 
  UCASE(LEFT(AP.LUOGO,1)) AS INIZIALE_LUOGO, LCASE(RIGHT(AP.LUOGO,LENGTH(AP.LUOGO)-1)) AS RESTO_LUOGO, 
  UCASE(LEFT(AP.DETTAGLI_LUOGO,1)) AS INIZIALE_DETT_LUOGO, LCASE(RIGHT(AP.DETTAGLI_LUOGO,LENGTH(AP.DETTAGLI_LUOGO)-1)) AS RESTO_DETT_LUOGO,
  AP.DATA_ORA, AP.PRESENZA, SP.DESCRIZIONE_PRES,
  UCASE(LEFT(AP.NOTE,1)) AS INIZIALE_NOTE, LCASE(RIGHT(AP.NOTE,LENGTH(AP.NOTE)-1)) AS RESTO_NOTE,
  R.NOME, R.COGNOME, R.ID_RESP, S.NOME_STUDIO
  FROM APPUNTAMENTO AP, AVERE_APPUNT AV, ISCRIZIONE I, RESP R, SSC S, STATO_PRESENZA SP
  WHERE AP.ID_APPUNT = AV.ID_APPUNT
  AND AV.ID_ISCRIZIONE = I.ID_ISCRIZ
  AND I.ID_SSC = S.ID_SSC
  AND S.ID_RESP = R.ID_RESP
  AND AP.STATO_PRES = SP.STATO_PRES
  AND I.ID_PAZ = ?
  <sql:param value="${id_user}"/>

    <%-------------------------- AREA CONTROLLI TEXT AREE ------------------------%>
    <%-- CONTROLLO NOME STUDIO --%>
    <c:if test="${not empty param.nome_studio}">
    AND UPPER(S.NOME_STUDIO) LIKE ?
    <sql:param value="${fn:toUpperCase(param.nome_studio)}%"/>
    </c:if>

    <%-------------------------- AREA CONTROLLO DATE ---------------------%>
    <%-- DATA E ORA --%>
    <c:if test="${not empty param.data_ora}">
    AND AP.DATA_ORA = ?
      <sql:param value="${param.data_ora}%"/>
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

    <%-- CONTROLLO STATO_PRESENZA --%>
    <c:if test="${not empty paramValues.stato_presenza && paramValues.stato_presenza[0] != ''}">
    <c:set var="dim_sp" value="${fn:length(paramValues.stato_presenza)}"/>
    <c:if test="${dim_sp == 1}">
    AND SP.STATO_PRES = ?
    <sql:param value="${paramValues.stato_presenza[0]}"/>
    </c:if>
    <c:if test="${dim_sp == 2}">
    AND (SP.STATO_PRES = ?
    OR SP.STATO_PRES = ?)
    <sql:param value="${paramValues.stato_presenza[0]}"/>
    <sql:param value="${paramValues.stato_presenza[1]}"/>
    </c:if>
    <c:if test="${dim_sp > 2}">
    AND (SP.STATO_PRES = ?
    <sql:param value="${paramValues.stato_presenza[0]}"/>
    <c:forEach items="${paramValues.stato_presenza}" begin="1" end="${dim_sp-2}" var="mysp">
    OR SP.STATO_PRES = ?
    <sql:param value="${mysp}"/>
    </c:forEach>
    OR SP.STATO_PRES = ?)
    <sql:param value="${paramValues.stato_presenza[dim_sp-1]}"/>
    </c:if>
    </c:if>

    <%-------------------------- AREA CONTROLLI FILTRI SUPERIORI ------------------------%>
    <c:if test="${param.appuntamenti == 'Svolti'}">
      AND AP.STATO_PRES = 1
    </c:if>

    <c:if test="${param.appuntamenti == 'Fissati'}">
      AND AP.STATO_PRES = 3
    </c:if>

    <c:if test="${param.appuntamenti == 'In attesa'}">
      AND AP.STATO_PRES = 2
    </c:if>

    <c:if test="${param.ordine == 'Crescente'}">
      ORDER BY AP.DATA_ORA DESC
    </c:if>

    <c:if test="${param.ordine == 'Decrescente'}">
      ORDER BY AP.DATA_ORA ASC
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
                  <li>Se non sono presenti appuntamenti per cui simulare la presenza viene mostrato un messaggio di errore apposito;</li>
                  <li>Se non sono presenti appuntamenti nella tabella generale viene mostrato un messaggio di errore apposito;</li>
                  <li>Se i parametri inseriti nei filtri per vagliare gli appuntamenti non producono risultati, viene visualizzato un apposito messaggio di errore.</li>
                  </ul>
                </td>
                </tr>
                </table>
               </div>
            </td>
        </tr>

<!-- ==================== Corpo Centrale ===================== -->
  
  <!--------------- Conferma appuntamento tabella ----------------- -->
  <tr height="60%" width="100%">
    <td valign="middle" align="center" bgcolor="white">
      <table valign="middle" align="center" border="0" cellspacing="0" cellpadding="15">

      <!--------------- Conferma appuntamento intestazione ----------------- -->
        <tr height="60%" width="100%"  valign="middle">
          <td align="center" bgcolor="white" colspan="7" cellpadding="10">
            <h2 style="color:#25544E">Conferma appuntamento:<br/></h2>
            <p style="color:#25544E">
              <i>In questa sezione e' possibile visualizzare l'appuntamento fissato piu' recente e confermare la presenza.<br/><br/></i>
            </p> 
          </td>
        </tr>

        <c:choose>
          <c:when test="${not empty rset_app_da_conv.rows[0]}">
          <tr bgcolor="#2a5951" style="color:white" height="60">
            <th> Data e ora </th>
            <th> Nome studio </th>
            <th> Luogo </th>
            <th> Dettagli luogo </th>
            <th> Responsabile </th>
          </tr>
          
          <form method="post" action="PAZ_updatepresenza.jsp">

          <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
            <td>
              <!-- Formattazione dell'output date -->
              <fmt:formatDate value="${rset_app_da_conv.rows[0].DATA_ORA}" var="orario_app_da_conv"
		                          type="both"
		                          dateStyle="short"
	            />
              ${orario_app_da_conv}
            </td>

            <td>${rset_app_da_conv.rows[0].NOME_STUDIO}</td>
            <td>${rset_app_da_conv.rows[0].LUOGO}</td>
            <td>${rset_app_da_conv.rows[0].DETTAGLI_LUOGO}</td>
            <td>${rset_app_da_conv.rows[0].NOME} ${rset_app_da_conv.rows[0].COGNOME}</td>
          </tr>
          
          <tr>
            <td align="center" colspan="5"> &nbsp; </td>
          </tr>

          <tr>
            <td align="center" colspan="5">
              <input type="submit" name="conferma" value="Conferma Presenza" style="color:#468C7F"/>
            </td>
          </tr>

          <input type="hidden" name="id_appuntamento" value="${rset_app_da_conv.rows[0].ID_APPUNT}"/>
          <input type="hidden" name="orario" value="${orario_app_da_conv}"/>
          <input type="hidden" name="update_nome_studio" value="${rset_app_da_conv.rows[0].NOME_STUDIO}"/>
          </form>

          </c:when>
          <c:otherwise>
          <tr valign="middle">
            <td align="center">
            <font style="color:red"><b>Non e' presente alcun appuntamento per cui convelidare la presenza.<br/><br/><br/></b></font>
            </td>
          </tr>
          </c:otherwise>
        </c:choose>

        <c:if test="${ok_msg}">
          <tr>
            <td align="center" colspan="5">
              <font style="color:green"><b>La presenza per l'appuntamento dello studio ${param.update_nome_studio} del ${param.orario} e' stata confermata<br/><br/><br/></b></font>
            </td>
          </tr>
        </c:if>

        <c:if test="${no_ok_msg}">
          <tr>
            <td align="center" colspan="5">
              <font style="color:red"><b>A causa di un problema la presenza per l'appuntamento dello studio ${param.update_nome_studio} del ${param.orario} non e' stata confermata<br/><br/><br/></b></font>
            </td>
          </tr>
        </c:if>

      </table>
    </td>
  </tr>

<!-- -------------------- Filtri superiori -------------------- -->
  <form method="post" action="PAZ_calintegrato.jsp">
  <tr height="60%" width="100%">
    <td valign="middle" align="center" bgcolor="white">
      <img src="calendar.png" height="150" alt="Calendario">
      <h2 style="color:#25544E">Opzioni di visualizzazione:<br/><br/></h2>
      <table valign="middle" align="center" border="0" cellspacing="0" cellpadding="10">
        <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
          
          <td>Ordine:&nbsp;&nbsp;&nbsp;</td>
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
          <td> &nbsp </td>
          <td> &nbsp </td> 

        </tr>

        <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
          
          <td>Tipo:&nbsp;&nbsp;&nbsp;</td>
          <td align="left">
            <input type="radio" name="appuntamenti" value="Svolti" onChange="this.form.submit();"
            <c:if test="${param.appuntamenti == 'Svolti'}">checked="checked"</c:if>
            /> Appuntamenti svolti
          </td>

          <td align="left">
            <input type="radio" name="appuntamenti" value="Fissati" onChange="this.form.submit();"
            <c:if test="${param.appuntamenti == 'Fissati'}">checked="checked"</c:if>
            /> Appuntamenti fissati
          </td>

          <td align="left">
            <input type="radio" name="appuntamenti" value="In attesa" onChange="this.form.submit();"
            <c:if test="${param.appuntamenti == 'In attesa'}">checked="checked"</c:if>
            /> Appuntamenti in attesa di convalida 
          </td>

          <td align="left">
            <input type="radio" name="appuntamenti" value="" onChange="this.form.submit();"
            <c:if test="${empty param.appuntamenti || param.appuntamenti == ''}">checked="checked"</c:if>
            /> Mostra tutti 
          </td> 
        </tr>
      </table>
    </td>
  </tr>

  <!----------------------------- Pulsanti Cerca/Mostra tutto ---------------------- -->
  <tr>
    <td valign="middle" align="center">
      
      <!-- -------------------- Calendario intestazione -------------------- -->
      <h2 style="color:#25544E">Calendario:<br/></h2>
      <p style="color:#25544E">
        <i>In questa sezione e' possibile visualizzare tutti gli appuntamenti, ovvero quelli fissati e quelli gia' svolti.<br/><br/><br/></i>
      </p>

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
  <c:if test="${rset_appuntamenti.rowCount == 0 && (
    not empty param.nome_studio ||
    not empty param.data_ora ||
    not empty param.ordine ||
    not empty param.appuntamenti
  )}">
    <tr>
      <td valign="middle" align="center">
      <font style="color:red"><b>La ricerca non ha prodotto alcun risultato.<br/></b></font>
      </td>
    </tr>
  </c:if>

  <c:if test="${rset_appuntamenti.rowCount == 0 && (
    empty param.nome_studio &&
    empty param.data_ora &&
    (empty paramValues.responsabile || paramValues.responsabile[0] == '') &&
    (empty paramValues.presenza || paramValues.presenza[0] == '') &&
    empty param.ordine &&
    empty param.appuntamenti
  )}">
    <tr>
      <td valign="middle" align="center">
        <font style="color:red"><b>Non risultano presenti appuntamenti nel calendario.<br/></b></font>
      </td>
    </tr>
  </c:if>

  <tr height="60%" width="100%"  valign="middle">
    <td align="center" bgcolor="white" cellpadding="10">

      <!-- -------------------- Calendario tabella -------------------- -->
      <table valign="middle" align="center" border="0" width="100%" cellspacing="0" cellpadding="15">
        <tr bgcolor="#2a5951" style="color:white" height="60">
          <th> Data e ora </th>
          <th> Nome studio </th>
          <th> Luogo </th>
          <th> Dettagli luogo </th>
          <th> Responsabile </th>

          <c:if test="${param.appuntamenti == 'Svolti'}">
            <th> Presenza </th>
            <th> Complicazioni </th>
          </c:if>

          <c:if test="${param.appuntamenti == 'Mostra tutti' || empty param.appuntamenti}">
            <th> Presenza </th>
            <th> Stato della presenza </th>
            <th> Complicazioni </th>
          </c:if>

          <c:if test="${param.appuntamenti == 'In attesa'}">
            <th> Presenza in attesa di convalida</th>
          </c:if>
        </tr>

        <!--------------------------- FILTRI ---------------------------->
        <tr valign="middle" bgcolor="#f2f2f2">
          <td align="center">
            <input type="datetime-local" name="data_ora" value="${param.data_ora}"/>
          </td>

          <td align="center">
            <input type="text" id="search" name="nome_studio" value="${param.nome_studio}" 
            length="10" placeholder="Cerca..."/>
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

          <c:if test="${param.appuntamenti == 'Svolti'}">
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

            <td> &nbsp </td>
          </c:if>

          <c:if test="${param.appuntamenti == 'Mostra tutti' || empty param.appuntamenti}">
            <td align="center">
              <select name="presenza">
                <option value="" align="center">-- Presenza --</option>
                <c:forEach items="${rset_select_presenza.rows}" var="pres1">
                  <c:if test="${pres1.PRESENZA != NULL}">
                  <option value="${pres1.PRESENZA}" align="center"
                    <c:if test="${presenza == pres1.PRESENZA}">selected="selected"</c:if>
                  >${pres1.PRESENZA}</option>
                  </c:if>
                </c:forEach>
              </select>
            </td>
  
            <td align="center">
                <select name="stato_presenza" multiple="multiple">
                  <option value="" align="center">-- Stato --</option>
                  <c:forEach items="${rset_select_stato_presenza.rows}" var="stato_pres">
                    <option value="${stato_pres.STATO_PRES}" align="center"
                    <c:forEach items="${paramValues.stato_presenza}" var="parstato">
                      <c:if test="${parstato == sta_pres.STATO_PRES}">selected="selected"</c:if>
                    </c:forEach>
                    >${stato_pres.DESCRIZIONE_PRES}</option>
                  </c:forEach>
                </select>
            </td>
            <td>&nbsp</td>
          </c:if>

<c:if test="${param.appuntamenti == 'In attesa'}">
            <td>&nbsp</td>
</c:if>
        </tr>
  </form>

        <!-- -------------------- Tuple -------------------- -->
        <tbody>
          <c:forEach items="${rset_appuntamenti.rows}" var="app">
            <tr align="center" bgcolor="#f2f2f2" style="color:#468c7f">
              <td>
                <!-- Formattazione dell'output date -->
                <fmt:formatDate value="${app.DATA_ORA}" var="orario_app"
		                            type="both"
		                            dateStyle="short"
	              />
                ${orario_app}
              </td>

              <td>${app.NOME_STUDIO}</td>
              <td>${app.INIZIALE_LUOGO}${app.RESTO_LUOGO}</td>
              <td>${app.INIZIALE_DETT_LUOGO}${app.RESTO_DETT_LUOGO}</td>
              <td>${app.NOME} ${app.COGNOME}</td>

              <c:if test="${param.appuntamenti == 'Mostra tutti' || empty param.appuntamenti}">
                <c:choose>
                    <c:when test="${app.PRESENZA == 'Presente'}">
                      <td><img src="Arruolato.png" width="30" height="30" alt="bottone"></td>
                    </c:when>
                    <c:when test="${app.PRESENZA == 'Assente'}">
                      <td><img src="Scartato.png" width="30" height="30" alt="bottone"></td>
                    </c:when>
                    <c:otherwise>
                      <td> &nbsp; </td>
                    </c:otherwise>
                </c:choose>
                <td>${app.DESCRIZIONE_PRES}</td>
                <td>${app.INIZIALE_NOTE}${app.RESTO_NOTE}</td>
              </c:if>

              <c:if test="${param.appuntamenti == 'Svolti'}">
                <c:choose>
                    <c:when test="${app.PRESENZA == 'Presente'}">
                      <td><img src="Arruolato.png" width="30" height="30" alt="bottone"></td>
                    </c:when>
                    <c:when test="${app.PRESENZA == 'Assente'}">
                      <td><img src="Scartato.png" width="30" height="30" alt="bottone"></td>
                    </c:when>
                    <c:otherwise>
                      <td> &nbsp; </td>
                    </c:otherwise>
                </c:choose>
                <td>${app.INIZIALE_NOTE}${app.RESTO_NOTE}</td>
              </c:if>

              <c:if test="${param.appuntamenti == 'In attesa'}">
                <c:choose>
                    <c:when test="${app.PRESENZA == 'Presente'}">
                      <td><img src="Arruolato.png" width="30" height="30" alt="bottone"></td>
                    </c:when>
                    <c:when test="${app.PRESENZA == 'Assente'}">
                      <td><img src="Scartato.png" width="30" height="30" alt="bottone"></td>
                    </c:when>
                    <c:otherwise>
                      <td> &nbsp; </td>
                    </c:otherwise>
                </c:choose>
              </c:if>

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
      </div>
    </td>
  </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>