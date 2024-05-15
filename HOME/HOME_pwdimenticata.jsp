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

  <!-- --------------------- Pulsante indietro --------------------- --> 
  <tr valign="top">
    <td align="center" width="25%">
      <a href="HOME_areariservata.jsp">
        <img src="undo.png" width="40" height="40" title="Indietro"/>
      </a>
    </td>
    <td>&nbsp</td>
    <td>&nbsp</td>
    <td>&nbsp</td>
  </tr>

  <tr>
    <td align="center" colspan="4">
      <table valign="middle" align="center" border="0" width="60%" cellspacing="0" cellpadding="10" style="color:#25544E">
        <form method="post" action="HOME_pwdimenticata2.jsp">
          <tr bgcolor="#f2f2f2" height="60" width="100%" style="color:#468c7f">
            <td align="center" colspan="2"><h3>Reimposta password:</h3></td>
          </tr>

          <!-- --------------------- messaggio errore --------------------- -->  
          <c:if test="${not empty msg}">
            <tr valign="middle" bgcolor="#f2f2f2">
              <td align="center" colspan="2">
                <b><font color="red">${msg}</font></b>
              </td>
            </tr>
          </c:if>

          <tr bgcolor="#f2f2f2" height="60" width="100%" style="color:#468c7f">
            <td bgcolor="#f2f2f2" style="color:#468c7f" align="right">
              <input type="text" name="nome_user" value="${param.utente}" placeholder="Inserisci nome utente" style="color:#468c7f" length="15"/></td>
            <td bgcolor="#f2f2f2">
              <input type="submit" value="Reimposta Password" style="color:#468c7f"/>
            </td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
         
<%@ include file="LAYOUT_BOTTOM.jspf" %>