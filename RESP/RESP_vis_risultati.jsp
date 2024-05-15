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
<%-- Query per l estrazione dell'esito dello studio                      --%>
<%-- =================================================================== --%>
<sql:query var="rset_esito">
SELECT S.ESITO
  FROM SSC S
  WHERE S.ID_SSC = ?
  <sql:param value="${param.id_ssc}"/>
</sql:query>

  <!-- ==================== Corpo Centrale ===================== -->

  <!-- --------------------- Pulsante indietro --------------------- -->
      <tr valign="top">
        <td align="center" width="17%">
          <a href="RESP_studi_pers_DEF.jsp">
            <img src="undo.png" width="40" height="40" title="Indietro">
          </a>
        </td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="16%">&nbsp</td>
        <td width="16%">&nbsp</td>
      </tr>

  <!-- --------------------- Tabella --------------------- --> 
  <tr>
    <td align="center" width="100%" colspan="6">
      <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="10" style="color:#468c7f">
        
      
              <tr align="center">
                <img src="pie_chart.png" height="150" alt="Risultati"/><br/><br/>
                <h2 style="color:#25544E">Risultati dello studio clinico "${param.nome}"<br/><br/></h2>
              </tr> 

              <tr align="center" bgcolor="#f2f2f2">
                <td>${rset_esito.rows[0].ESITO}</td>
              </tr>

      </table>
    </td>
    <td width="50%"> &nbsp </td>
  </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>