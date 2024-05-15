<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_HOME.jspf" %>

      <!-- ==================== Corpo Centrale ===================== -->
      <tr valign="middle">
        <td colspan="2" align="center"><img src="check.png" height="150" alt="Conferma"></td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <h2 style="color:#25544E">Ora e' possibile effettuare il login ed accedere a tutti i nostri servizi!</h2>
          <p>
            <i>Se invece si desidera tornare alla homepage del sito, premere sul logo in alto a sinistra!</i>
          </p>
        </td>
      </tr>

      <!-- --------------------- Pulsante --------------------- --> 
      <tr valign="middle">
        <td align="center">
          <form method="post" action="HOME_areariservata.jsp">
            <input type="submit" name="registrazione_ok" value="Effettua il login" style="color:#2A5951"/>
          </form>
        </td>
      </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>