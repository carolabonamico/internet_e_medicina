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

      <!-- ==================== Corpo Centrale ===================== -->

      <!-- --------------------- Pulsante indietro --------------------- --> 
      <tr valign="top">
        <td align="center" width="17%">
          <form method="post" action="RESP_elenco_PAZ_DEF.jsp">
            <input type="image" src="undo.png" width="40" height="40" />
            <input type="hidden" name="id_ssc" value="${param.id_ssc}" />
            <input type="hidden" name="nome" value="${param.nome}" />
            <input type="hidden" name="nome_paz" value="${param.nome_paz}" />
            <input type="hidden" name="cognome_paz" value="${param.cognome_paz}"/>
            <input type="hidden" name="descr_paz" value="${param.descr_paz}" />
            <input type="hidden" name="totconv" value="${param.totconv}"/>
            <input type="hidden" name="id_paz" value="${param.id_paz}"/>
            <input type="hidden" name="vis_med" value="${param.vis_med}"/>
            <input type="hidden" name="descr" value="${param.descr}"/>
          </form>
        </td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="16%">&nbsp</td>
        <td width="16%">&nbsp</td>
      </tr>

      <!-- --------------------- Form di selezione --------------------- --> 
      <form method="post" action="#">
      <tr valign="top">
        <td align="center" colspan="6">
          <img src="medical_record.png" height="150" alt="Dettagli">
          <h2>E' stato selezionato il paziente: ${param.nome_paz} ${param.cognome_paz}<br/><br/></h2> 
          Selezionare le informazioni da visualizzare: &nbsp;&nbsp;
          <select name="dettagli" style="color:#2A5951">
            <option value="" selected="true"> -- Informazioni -- </option>
            <option value="altri_studi"> Altri studi </option>
            <option value="anagrafica"> Anagrafica </option>
            <option value="appuntamenti"> Appuntamenti </option>
          </select>
        </td>
      </tr>
      <tr>
        <td align="center" colspan="6">
          <c:if test="${param.dettagli == 'altri_studi'}">
            <jsp:forward page="RESP_dettagli_paziente_altristudi.jsp"/>
          </c:if>
          <c:if test="${param.dettagli == 'anagrafica'}">
            <jsp:forward page="RESP_anagrafica_paz.jsp"/>
          </c:if>
          <c:if test="${param.dettagli == 'appuntamenti'}">
            <jsp:forward page="RESP_dettagli_paziente_app.jsp"/>
          </c:if>  
    

          <!-- --------------------- Pulsante di conferma --------------------- --> 
          <input type="submit" value="Conferma" style="color:#2A5951"/>
          <input type="hidden" name="id_ssc" value="${param.id_ssc}" />
            <input type="hidden" name="nome" value="${param.nome}" />
            <input type="hidden" name="nome_paz" value="${param.nome_paz}" />
            <input type="hidden" name="cognome_paz" value="${param.cognome_paz}"/>
            <input type="hidden" name="descr_paz" value="${param.descr_paz}" />
            <input type="hidden" name="totconv" value="${param.totconv}"/>
            <input type="hidden" name="id_paz" value="${param.id_paz}"/>
            <input type="hidden" name="vis_med" value="${param.vis_med}"/>
        </td>
      </tr>
      </form>

<%@ include file="LAYOUT_BOTTOM.jspf" %>