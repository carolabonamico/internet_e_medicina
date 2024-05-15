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
 
<c:set var="ruolo_pagina" value="PRES"/>
<%@ include file="autorizzazione.jspf" %>

<!-- ==================================== TOP =================================== --> 

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_PRES.jspf" %>  


<!-- ==================== Corpo Centrale ===================== -->
<sql:query var="nome">
  SELECT NOME, COGNOME, SESSO
  FROM PRES
  WHERE ID_PRES = ?
  <sql:param value="${id_user}"/>
</sql:query>

<sql:query var="studio20">
 select ID_SSC, NOME_STUDIO
 from SSC
 where ((COD_STATO_STUDIO=20 AND RIVISTO=0 and ID_PRES IS NULL)
OR (COD_STATO_STUDIO=20 AND RIVISTO=1 AND ID_PRES=?))
<sql:param value="${id_user}"/>

</sql:query>

    <!-- ============================ Notifiche in ingresso =========================== --> 
    <tr>
      <td align="center">
        <h2><c:if test="${nome.rows[0].SESSO == 'M'}">Benvenuto</c:if><c:if test="${nome.rows[0].SESSO == 'F'}">Benvenuta</c:if> Presidente ${nome.rows[0].COGNOME} ${nome.rows[0].NOME}</h2>
        <h4><i>Ora e' possibile navigare nella sua area riservata.<br/></i></h4>
      </td>
    </tr>

    <c:if test="${empty studio20.rows}">
      <tr>
        <td align="center">
          <img src="welcome.png" height="250" alt="welcome"><br/>
        </td>
      </tr>

      <tr>
        <td align="center">
          <table style="border-bottom:4px solid #2a5951; border-top:4px solid #2a5951;" cellpadding="10">
            <tr>
  <td align="center"><form action="PRES_imieistudi.jsp" method="post"/>
                Non sono presenti studi appena chiusi. Per visualizzare gli studi personali,premere qui!<br/></a><br/><input type="submit" value="Vai ai dettagli" style="color:#2a5951"/></form>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </c:if>

    <c:if test="${not empty studio20.rows}">
      <tr>
        <td align="center">
          <img src="notification.png" height="150" alt="Notifica"><br/>
        </td>
      </tr>

      <tr>
        <td align="center">
          <table style="border-bottom:4px solid #2a5951; border-top:4px solid #2a5951;" cellpadding="10">
            <tr>
              <td align="center"><form action="PRES_studiclinici.jsp" method="post"/>
                Sono presenti studi appena chiusi. Per visualizzare i dettagli,premere qui!<br/></a><br/><input type="submit" value="Vai ai dettagli" style="color:#2a5951"/></form>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </c:if>
      
<!-- ==================================TOP FINALE =================================== --> 

<%@ include file="LAYOUT_BOTTOM.jspf" %>