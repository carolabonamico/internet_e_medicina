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
<c:set var="ruolo_pagina" value="FRANK"/>
<%@ include file="autorizzazione.jspf" %>

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_FRANK.jspf" %>

<!-- ============ query per gli account dei paz in attesa ============ -->
<sql:query var="rset_elenco_convalida">
  SELECT A.ID_ACCOUNT, A.USERNAME, A.PASSWORD, S.DESCR_STATO, R.DESCRIZIONE
  FROM ACCOUNT A, RUOLO R, STATO_ACCOUNT S
  WHERE S.COD_STATO = A.STATO_ACC AND
        R.COD_RUOLO = A.COD_RUOLO AND
        A.COD_RUOLO = '5' AND
        S.COD_STATO = '10'
</sql:query>
            
      <!-- ==================== Corpo Centrale ===================== -->

      <!-- --------------------------- Notifiche in ingresso --------------------------- -->
      <tr>
        <td align="center">
          <h2> Benvenuto super-admin Frankenstein! <br/><br/></h2>
          <img src="notification.png" height="150" alt="notifica">
        </td>
      </tr>

      <tr>
        <td align="center">
          <h4><i>Notifiche in ingresso:</i><br/></h4>
      </tr>

      <tr>
        <td align="center">
         <table style="border-bottom:4px solid #2a5951; border-top:4px solid #2a5951;" cellpadding="10">

      <!-- Notifiche relative agli account paz in attesa di convalida -->
          <c:if test="${not empty rset_elenco_convalida.rows}">
            <tr>
              <td align="center">
                Sono presenti degli account di pazienti in attesa di convalida, 
                <a href="FRANK_CONV_PAZ.jsp" style="color:#468C7F"><i>premere qui!<br/></i></a>
              </td>
            </tr>
          </c:if>

       <!-- Nel caso in cui non ci fosse alcuna notifica -->
          <c:if test="${empty rset_elenco_convalida.rows}">
            <tr>
              <td align="center">
                Non e' presente nessuna notifica al momento
              </td>
            </tr>
          </c:if>
         
         </table>
        </td>
      </tr>
            
<!-- frammento layout bottom generale -->
<%@ include file="LAYOUT_BOTTOM.jspf" %>