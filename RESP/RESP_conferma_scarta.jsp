Conferma_scarta
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
      <tr valign="middle">
        <td colspan="2" align="center"><img src="medical_history.png" height="150" alt="Cancella"></td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <h2>E' sicuro di voler scartare il paziente ${param.nome_paz} ${param.cognome_paz} per lo studio ${param.nome}?<br/></h2>
        </td>
      </tr>
      <!-- --------------------- Pulsanti --------------------- --> 
      <tr>
        <form method="post" action="RESP_arruola_scarta.jsp" >
          <td align="right" width="50%">
            <input type="submit" value="Si" style="color:#25544E">
            <input type="hidden" name="id_ssc" value="${param.id_ssc}" />
            <input type="hidden" name="nome" value="${param.nome}" />
            <input type="hidden" name="flag_scarta" value="true" />
            <input type="hidden" name="nome_paz" value="${param.nome_paz}" />
            <input type="hidden" name="cognome_paz" value="${param.cognome_paz}"/>
            <input type="hidden" name="descr_paz" value="${param.descr_paz}" />
            <input type="hidden" name="totconv" value="${param.totconv}"/>
            <input type="hidden" name="id_paz" value="${param.id_paz}"/>
            <input type="hidden" name="vis_med" value="${param.vis_med}"/>
          </td>
        </form>
        <form method="post" action="RESP_elenco_PAZ_DEF.jsp">
          <td align="left"  width="50%">
            <input type="submit" value="No" style="color:#25544E">
            <input type="hidden" name="id_ssc" value="${param.id_ssc}" />
            <input type="hidden" name="nome" value="${param.nome}" />
            <input type="hidden" name="nome_paz" value="${param.nome_paz}" />
            <input type="hidden" name="cognome_paz" value="${param.cognome_paz}"/>
            <input type="hidden" name="descr_paz" value="${param.descr_paz}" />
            <input type="hidden" name="totconv" value="${param.totconv}"/>
            <input type="hidden" name="id_paz" value="${param.id_paz}"/>
            <input type="hidden" name="vis_med" value="${param.vis_med}"/>
          </td>
        </form>
      </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>