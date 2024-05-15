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
<c:set var="ruolo_pagina" value="FARM"/>
<%@ include file="autorizzazione.jspf" %>

<%@ include file="LAYOUT_TOP.jspf"%>
<%@ include file="LAYOUT_MENU_FARM.jspf"%> 
 
              <!-- ==================== Corpo Centrale ===================== -->
      <tr valign="middle">
        <td align="center"><img src="payment.png" height="150" alt="Conferma"></td>
      </tr>
      <tr>
        <td align="center">
          <h2 style="color:#25544E">Pagamento effettuato con successo!</h2>
          
        </td>
      </tr>
      <tr>
        <td align="center">
           <a href="FARM_studiclinici.jsp" style="color:#468C7F"> Cliccami se vuoi 
             finanziare altri studi! </a> 
          </h3>
     <tr>
              
<%@ include file="LAYOUT_BOTTOM.jspf" %>