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
<%-- Query per l estrazione dei parametri relativi al responsabile           --%>
<%-- ======================================================================= --%>
<sql:query var="rset_resp">
SELECT R.NOME, R.COGNOME, R.SESSO, R.CF, R.DOMICILIO, R.CELLULARE, R.N_ALBO, R.MAIL
  FROM SSC S, RESP R
  WHERE S.ID_RESP=R.ID_RESP
       AND S.ID_SSC = ?
  <sql:param value="${param.id_ssc_new}"/>
</sql:query>

<!-- ==================== Corpo Centrale ===================== -->

      <!-- --------------------- Pulsante indietro --------------------- --> 
      <tr valign="top">
        <td align="center" width="17%">
          <form method="post" action="RESP_dettagli_paziente_altristudi.jsp">
            <input type="image" src="undo.png" width="40" height="40" />
                <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                <input type="hidden" name="id_ssc_new" value="${var_studi.ID_SSC}"/>
                <input type="hidden" name="descr" value="${param.descr}"/>
                <input type="hidden" name="nome" value="${param.nome}"/>
                <input type="hidden" name="area" value="${param.area}"/>
                <input type="hidden" name="popolazione" value="${param.popolazione}"/>
                <input type="hidden" name="datain" value="${param.datain}"/>
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

      <!-- --------------------- Tabella --------------------- -->
      <tr>
        <td align="center" colspan="6">
          <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="10" style="color:#468c7f">
              
            <tr>
              <img src="resp.png" height="150" alt="Responsabile"/><br/>
              <h2 style="color:#25544E">Generalita' e contatti<br/></h2>
            </tr>

            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <td><b>Nome</b></td>
              <td>${rset_resp.rows[0].NOME}</td>
            </tr>
            <tr height="60" width="15%">
              <td><b>Cognome</b></td>
              <td>${rset_resp.rows[0].COGNOME}</td>
            </tr>
            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <td><b>Sesso</b></td>
              <td>${rset_resp.rows[0].SESSO}</td>
            </tr>
            <tr height="60" width="15%">
              <td><b>Codice Fiscale</b></td>
              <td>${rset_resp.rows[0].CF}</td>
            </tr>
            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <td><b>Albo di ricerca</b></td>
              <td>${rset_resp.rows[0].N_ALBO}</td>
            </tr>
            <tr height="60" width="15%">
              <td><b>Cellulare</b></td>
              <td>${rset_resp.rows[0].CELLULARE}</td>
            </tr>
            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <td><b>E-mail</b></td>
              <td>${rset_resp.rows[0].MAIL}</td>
            </tr>
            <tr height="60" width="15%">
              <td><b>Domicilio</b></td>
              <td>${rset_resp.rows[0].DOMICILIO}</td>
            </tr>
            <tr height="60" width="15%">
              
            </tr>
          </table>
      
        </td>
      </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>