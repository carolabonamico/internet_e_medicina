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
          <a href="PAZ_imieistudi.jsp">
            <img src="undo.png" width="40" height="40" title="Indietro"/>
          </a>
        </td>
        <td align="center" width="20%"> &nbsp </td>
        <td align="center" width="20%"> &nbsp </td>
        <td align="center" width="20%"> &nbsp </td>
        <td align="center" width="20%"> &nbsp </td>
      </tr>

   
      <!-- --------------------- Form di selezione --------------------- --> 

      <form method="post" action="PAZ_appuntamenti.jsp">
      <tr valign="top">
        <td align="center" colspan="5">
          <img src="dettagli.png" height="150" alt="Dettagli">
        </td>
      </tr>
<c:if test="${not empty no_select}">
                <tr align="center">
                  <td align="center" colspan="5">
                    <b><font color="red">Non e' stato selezionato nulla!<br/><br/><br/></font></b>
                  </td>
                </tr>
       </c:if>

      <tr valign="top">
        <td align="center" colspan="5">
          <h2>E' stato selezionato lo studio clinico "${param.nome_studio}"<br/><br/></h2>

          <c:choose>
            <c:when test="${not empty data_ora_iscrizione}">
              <h4>Iscrizione effettuata in data ${data_ora_iscrizione}<br/><br/></h4>
            </c:when>
            <c:otherwise>
              <h4>Iscrizione effettuata in data ${param.data_ora_iscriz}<br/><br/></h4>
            </c:otherwise>
          </c:choose>

          Selezionare i dettagli da visualizzare: &nbsp;&nbsp;
          <select name="dettagli" style="color:#2A5951">
            <option align="center" value="" selected="true"> -- Dettagli -- </option>
            <option align="center" value="fissati"> Appuntamenti fissati </option>
            <option align="center" value="svolti"> Appuntamenti svolti </option>
            <option align="center" value="incentivo"> Incentivo </option>
            <c:if test="${param.vis_med == 1}">
              <option align="center" value="visita_medica"> Visita medica </option> 
            </c:if>
          </select>
        </td>
      </tr>

      <!-- --------------------- Pulsante di conferma --------------------- -->
      <tr>
        <td align="center" colspan="5"> 
          <input type="submit" value="Conferma" style="color:#2A5951"/>
          <input type="hidden" name="nome_studio" value="${param.nome_studio}"/>
          <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
          <input type="hidden" name="incentivo" value="${param.incentivo}"/>
          <input type="hidden" name="posizione_studio" value="${param.posizione_studio}"/>
          <input type="hidden" name="id_iscrizione" value="${param.id_iscrizione}"/>
          <input type="hidden" name="vis_med" value="${param.vis_med}"/>
        </td>
      </tr>
      </form>

<%@ include file="LAYOUT_BOTTOM.jspf" %>