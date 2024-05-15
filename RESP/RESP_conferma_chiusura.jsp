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


<!-- Se la SSC non e' ancora stata interamente compilata, deve tornarmi un messaggio di errore, in quanto non e' possibile chiuderla -->

<c:if test="${flag_controllo_campi}">

<c:if test="${empty param.nome        ||
              empty param.area        ||
              empty param.popolazione ||
              empty param.datain      ||
              empty param.datafine    ||
              empty param.descrizione}">

<c:set var="errchius" scope="request">ATTENZIONE! Per chiudere la SSC devi prima terminare la compilazione: procedi dunque alla modifica.</c:set>
 
<jsp:forward page="RESP_studi_pers_pg2.jsp" />
</c:if>
</c:if>

<c:remove var="flag_controllo_campi" />


      <!-- ==================== Corpo Centrale ===================== -->
<tr>
  <td align="center" colspan="2">
    <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="20" style="color:#468c7f">
      <tr>
        <td align="center" colspan="2">
          <c:if test="${not empty errrisp}">
            <img src="error.png" height="100" alt="Errore">
          </c:if>
        </td>
      </tr>
      <tr>
        <td align="center" colspan="2">
          <c:if test="${not empty errrisp}">
            <b><font color="#CC0000">${errrisp}</font></b>
          </c:if>
        </td>
      </tr>

        <img src="medical_history.png" height="150" alt="Ditta farmaceutica"/><br/>
        <h2>E' sicuro di voler chiudere la SSC ${param.id_ssc} relativa allo studio "${param.nome}"?<br/></h2>
        <p align="center" style="color:#468c7f">
          <i>Verra' inviata una notifica al PRES per l'approvazione.</i>
        </p>
  </td>
</tr>
<form method="post" action="RESP_act_conferma_chiusura.jsp">
      <!-- Se lo studio e' da rivedere deve essere compilata una risposta alla richiesta di revisione fornita dal PRES -->
      <c:if test="${param.rivisto == 1}">
        <tr>
                <td align="center" colspan="2">
                    <textarea name="risposta" rows="10" cols="85" placeholder="Compilare la risposta alla richiesta di revisione fornita dal PRES">${param.risposta}</textarea>
                </td>
            
        </tr>
      </c:if>

      <!-- --------------------- Pulsanti --------------------- --> 
      <tr>
          <td align="right" width="50%">
            <input type="submit" name="conferma_canc" value="Si" style="color:#25544E">
            <input type="hidden" name="id_ssc" value="${param.id_ssc}" />
            <input type="hidden" name="flag_conf_chiusura" value="true" />
            <input type="hidden" name="rivisto" value="${param.rivisto}" />
            <input type="hidden" name="nome" value="${param.nome}" />

          </td>
        </form>
        <form method="post" action="RESP_studi_pers_DEF.jsp">
          <td align="left"  width="50%">
            <input type="submit" name="annulla_canc" value="No" style="color:#25544E">
          </td>
        </form>
      </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>