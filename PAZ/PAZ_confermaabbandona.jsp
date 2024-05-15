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

<c:if test="${param.tasto == 'Abbandona'}">

            <!-- ==================== Corpo Centrale ===================== -->
            <tr valign="middle">
              <td colspan="2" align="center"><img src="abbandona.png" height="150" alt="Abbandona"></td>
            </tr>
            <tr>
              <td colspan="2" align="center">
                <h2>Si desidera abbandonare lo studio clinico "${param.nome_studio_att}"?</h2>
              </td>
            </tr>
            <!-- --------------------- Pulsanti abbandona/annulla --------------------- --> 
            <tr>
              <td align="right" width="50%">
                <form method="post" action="PAZ_updateabbandona.jsp">
                  <input type="submit" name="conferma" value="Abbandona" style="color:#2A5951"/>
                  <input type="hidden" value="${param.id_iscrizione}" name="id_iscrizione"/>
                  <input type="hidden" name="posizione_studio" value="${param.posizione_studio}"/>
                  <input type="hidden" name="nome_studio_att" value="${param.nome_studio_att}"/>
                </form>
              </td>
              <td align="left"  width="50%">
                <form method="post" action="PAZ_imieistudi.jsp">
                  <input type="submit" name="annulla_abbandona" value="Annulla" style="color:#2A5951"/>
                </form>
              </td>
            </tr>
</c:if>
<c:if test="${param.tasto == 'Disiscriviti'}">

            <!-- ==================== Corpo Centrale ===================== -->
            <tr valign="middle">
              <td colspan="2" align="center"><img src="abbandona.png" height="150" alt="Lascia"></td>
            </tr>
            <tr>
              <td colspan="2" align="center">
                <h2>Ci si desidera disiscrivere dallo studio clinico "${param.nome_studio_att}"?</h2>
              </td>
            </tr>
            <!-- --------------------- Pulsanti abbandona/annulla --------------------- --> 
            <tr>
              <td align="right" width="50%">
                <form method="post" action="PAZ_updateabbandona.jsp">
                  <input type="submit" name="conferma" value="Cancella iscrizione" style="color:#2A5951"/>
                  <input type="hidden" value="${param.id_iscrizione}" name="id_iscrizione"/>
                  <input type="hidden" name="nome_studio_att" value="${param.nome_studio_att}"/>
                </form>
              </td>
              <td align="left"  width="50%">
                <form method="post" action="PAZ_imieistudi.jsp">
                  <input type="submit" name="annulla_disiscrizione" value="Annulla" style="color:#2A5951"/>
                </form>
              </td>
            </tr>
</c:if>

<%@ include file="LAYOUT_BOTTOM.jspf" %>