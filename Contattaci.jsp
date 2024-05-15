<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<!-- ==================== Top ===================== -->
<%@ include file="LAYOUT_TOP.jspf" %>
<c:choose>
<c:when test="${ruolo_user == 'FARM'}">
  <%@ include file="LAYOUT_MENU_FARM.jspf" %>
</c:when>
<c:when test="${ruolo_user == 'PRES'}">
  <%@ include file="LAYOUT_MENU_PRES.jspf" %>
</c:when>
<c:when test="${ruolo_user == 'MED'}">
  <%@ include file="LAYOUT_MENU_MED.jspf" %>
</c:when>
<c:when test="${ruolo_user == 'PAZ'}">
  <%@ include file="LAYOUT_MENU_PAZ.jspf" %>
</c:when>
<c:when test="${ruolo_user == 'RESP'}">
  <%@ include file="LAYOUT_MENU_RESP.jspf" %>
</c:when>
<c:when test="${ruolo_user == 'FRANK'}">
  <%@ include file="LAYOUT_MENU_FARM.jspf" %>
</c:when>
<c:otherwise>
  <%@ include file="LAYOUT_MENU_HOME.jspf" %>
</c:otherwise>
</c:choose>

<tr valign="middle">
  <td colspan="2" align="center"><img src="support.png" height="150" alt="Supporto"></td>
</tr>
<tr>
  <td align="center" colspan="2">
    <h2 style="color:#468c7f">Hai bisogno di aiuto?<br/></h2> 
  </td>
</tr>

<!-- --------------------- messaggio errore --------------------- -->  
<c:if test="${not empty msg1}">
  <tr valign="middle">
    <td align="center" colspan="2">
      <b><font color="red">${msg1}</font></b>
    </td>
  </tr>
  <c:remove var="msg1"/>
</c:if>

<c:if test="${not empty okmsg1}">
  <tr valign="middle">
    <td align="center" colspan="2">
      <b><font color="green">${okmsg1}</font></b>
    </td>
  </tr>
  <c:remove var="okmsg1"/>
</c:if>

<tr>
  <td align="center" colspan="4">
    <table valign="middle" align="center" border="0" width="45%" cellspacing="0" cellpadding="10" style="color:#468c7f">
      <form method="post" action="Invia_aiuti.jsp">

          <tr bgcolor="#f2f2f2" height="60" width="15%">
            <td>
              <c:if test="${not empty erroggetto}">
                <b><font color="red"> Oggetto del messaggio: </font></b>
              </c:if>
              <c:if test="${empty erroggetto}">
                <b> Oggetto del messaggio: </b>
              </c:if>
            </td>
            <td><INPUT TYPE="text" NAME="oggetto" value="${param.oggetto}" size="30" placeholder="Inserisci oggetto del messaggio" style="color:#468c7f"/>
            </td>
          </tr>
          
          <tr height="40" width="15%">&nbsp</tr>

          <tr bgcolor="#f2f2f2" height="60" width="15%">
            <td>
              <c:if test="${not empty errnome}">
                <b><font color="red"> Nome: </font></b>
              </c:if>
              <c:if test="${empty errnome}">
                <b> Nome: </b>
              </c:if>
            </td>
            <td><INPUT TYPE="text" NAME="nome" value="${param.nome}" size="25" placeholder="Inserisci il tuo nome" style="color:#468c7f"/>
            </td>
          </tr>
          
          <tr height="40" width="15%">&nbsp</tr>

          <tr bgcolor="#f2f2f2" height="60" width="15%">
            <td>
              <c:if test="${not empty errmessaggio}">
                <b><font color="red"> Messaggio: </font></b>
              </c:if>
              <c:if test="${empty errmessaggio}">
                <b> Messaggio: </b>
              </c:if>
            </td>
            <td><TEXTAREA NAME="messaggio" COLS="40" ROWS="8" placeholder="Inserisci il tuo messaggio" style="color:#468c7f">${param.messaggio}</TEXTAREA>
            </td>
          </tr>

    </table>
  </td>
</tr>

<tr>
  <td align="center" colspan="4">
    <input type="submit" value="Invia" style="color:#468c7f"/>
  </td>
</tr>
</form>

<%@ include file="LAYOUT_BOTTOM.jspf" %>
