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

      <!-- ==================== Corpo Centrale ===================== -->
      <tr valign="middle">
        <td colspan="2" align="center"><img src="eraser.png" height="150" alt="Cancella"></td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <h2 style="color:#25544E">Si desidera 'ELIMINARE' l'account 'PAZ' di 'marco_rossi' con ID '34'?</h2>
        </td>
      </tr>

      <!-- --------------------- Pulsanti di modifica/annulla --------------------- --> 
      <tr valign="middle">
        <td align="right" width="50%">
            <form method="post" action="FRANK_elenco_acc.jsp">
                <input type="submit" name="conferma" value="Conferma" style="color:#2A5951"/>
            </form>
        </td>
        <td align="left" width="50%">
            <form method="post" action="FRANK_elenco_acc.jsp">
                <input type="submit" name="annulla" value="Annulla" style="color:#2A5951"/>
            </form>
        </td>
      </tr>

            
<!-- frammento layout bottom generale -->
 <%@ include file="LAYOUT_BOTTOM.jspf" %>