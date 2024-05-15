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
<%-- Query per l estrazione dei parametri relativi agli altri studi      --%>
<%-- =================================================================== --%>
<sql:query var="rset_altri_studi">
SELECT S.ID_SSC, S.NOME_STUDIO, S.AREA_TERAPEUTICA, S.POPOLAZIONE, S.DATA_INIZIO, S.DATA_FINE, S.DESCRIZIONE, S.ESITO, ST.descr, R.NOME, R.COGNOME
  FROM SSC S, stato_studio ST, ISCRIZIONE I, RESP R
  WHERE S.COD_STATO_STUDIO=ST.cod AND I.ID_SSC=S.ID_SSC AND R.ID_RESP=S.ID_RESP
       AND S.ID_SSC != ?
       AND I.ID_PAZ = ?
  <sql:param value="${param.id_ssc}"/>
  <sql:param value="${param.id_paz}"/>
</sql:query>

<!-- Salvo l'id della ssc corrente in una variabile -->

<c:set var="id_ssc" scope="request" value="${param.id_ssc}" />


<!-- ==================== Corpo Centrale ===================== -->

      <!-- --------------------- Pulsante indietro --------------------- --> 
      <tr valign="top">
        <td align="left" width="20%">
          <form method="post" action="RESP_dettagli_paziente.jsp">
            <input type="image" src="undo.png" width="40" height="40" />
            <input type="hidden" name="id_ssc" value="${param.id_ssc}" />
            <input type="hidden" name="nome" value="${param.nome}" />
            <input type="hidden" name="nome_paz" value="${param.nome_paz}" />
            <input type="hidden" name="cognome_paz" value="${param.cognome_paz}"/>
            <input type="hidden" name="descr_paz" value="${param.descr_paz}" />
            <input type="hidden" name="totconv" value="${param.totconv}"/>
            <input type="hidden" name="id_paz" value="${param.id_paz}"/>
            <input type="hidden" name="vis_med" value="${param.vis_med}"/>
         </form>
        </td>
      </tr>

      <!-- --------------------- Intestazione --------------------- --> 
      <tr>
        <td align="center" colspan="3">
          <img src="health_check.png" height="150" alt="Studi clinici"/><br/>
          <h3 align="center" style="color:#25544E">Studi clinici del paziente ${param.nome_paz} ${param.cognome_paz}</h3>
          <p>
            <i>Elenco degli altri studi a cui e' iscritto il paziente selezionato.<br/></i>
          </p>
        </td>
      </tr>

      <tr>
        <td align="center">
          
            <table valign="middle" align="center" border="0" width="100%" cellspacing="0" cellpadding="10">
          <tr bgcolor="#2a5951" style="color:white" height="60" width="15%">

              <th>Nome Studio</th>
              <th>Area Terapeutica</th>
              <th>Popolazione Target</th>
              <th>Data Inizio</th>
              <th>Data Fine</th>
              <th>Descrizione</th>
              <th>Stato</th>
              <th>Dettagli SSC</th>
              <th>Dettagli Responsabile</th>

          </tr>

        <c:forEach items="${rset_altri_studi.rows}" var="var_studi">

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
               <form method="post" action="RESP_dettagli_paziente_altristudi_pg2.jsp">
                <input type="submit" value="Visualizza Dettagli">
                <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                <input type="hidden" name="id_ssc_new" value="${var_studi.ID_SSC}"/>
                <input type="hidden" name="descr" value="${var_studi.descr}"/>
                <input type="hidden" name="nome" value="${var_studi.NOME_STUDIO}"/>
                <input type="hidden" name="area" value="${var_studi.AREA_TERAPEUTICA}"/>
                <input type="hidden" name="popolazione" value="${var_studi.POPOLAZIONE}"/>
                <input type="hidden" name="datain" value="${var_studi.DATA_INIZIO}"/>
                <input type="hidden" name="datafine" value="${var_studi.DATA_FINE}"/>
                <input type="hidden" name="descrizione" value="${var_studi.DESCRIZIONE}"/>
                <input type="hidden" name="nome_paz" value="${param.nome_paz}"/>
                <input type="hidden" name="cognome_paz" value="${param.cognome_paz}"/>
                <input type="hidden" name="descr_paz" value="${param.descr_paz}" />
                <input type="hidden" name="totconv" value="${param.totconv}"/>
                <input type="hidden" name="id_paz" value="${param.id_paz}"/>
                <input type="hidden" name="vis_med" value="${param.vis_med}"/>
               </form>
              </td>
              <td>
               <form method="post" action="RESP_dettagli_altriresp.jsp">
                <input type="submit" value="${var_studi.NOME} ${var_studi.COGNOME}">
                <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                <input type="hidden" name="id_ssc_new" value="${var_studi.ID_SSC}"/>
                <input type="hidden" name="descr" value="${var_studi.descr}"/>
                <input type="hidden" name="nome" value="${var_studi.NOME_STUDIO}"/>
                <input type="hidden" name="area" value="${var_studi.AREA_TERAPEUTICA}"/>
                <input type="hidden" name="popolazione" value="${var_studi.POPOLAZIONE}"/>
                <input type="hidden" name="datain" value="${var_studi.DATA_INIZIO}"/>
                <input type="hidden" name="datafine" value="${var_studi.DATA_FINE}"/>
                <input type="hidden" name="descrizione" value="${var_studi.DESCRIZIONE}"/>
                <input type="hidden" name="nome_paz" value="${param.nome_paz}"/>
                <input type="hidden" name="cognome_paz" value="${param.cognome_paz}"/>
                <input type="hidden" name="descr_paz" value="${param.descr_paz}" />
                <input type="hidden" name="totconv" value="${param.totconv}"/>
                <input type="hidden" name="id_paz" value="${param.id_paz}"/>
                <input type="hidden" name="vis_med" value="${param.vis_med}"/>
               </form>
              </td>

            </tr>
         </c:forEach>
    </table>
          
        </td>
      </tr>
                
<%@ include file="LAYOUT_BOTTOM.jspf" %>