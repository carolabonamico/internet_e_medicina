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

      <!-- ==================== Corpo Centrale ===================== -->

      <tr valign="middle">
        <td colspan="2" align="center"><img src="validation.png" height="150" alt="Convalida presenza"></td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <h2>Si desidera confermare la presenza all'appuntamento del 09-11-2022 16:42:00 per lo studio clinico "${param.nome_studio}"?</h2>
        </td>
      </tr>

            <!-- --------------------- Pulsanti di conferma/annulla --------------------- --> 
            <!---- Controllo che sia stato selezionata la presenza ---->
            <c:if test="{empty presenza}">
              <c:set var="no_presenza" value="true" scope="request"/>
              <jsp:forward page="PAZ_calintegrato.jsp"/>
            </c:if>

            <tr>
              <td align="right" width="50%">
                <form method="post" action="PAZ_updatepresenza.jsp">
                  <input type="submit" name="presenza" value="Conferma" style="color:#2A5951"/>
                  <input type="hidden" name="id_appunt" value="${param.id_appuntamento}"/>
                </form>
              </td>
              <td align="left"  width="50%">
                <form method="post" action="PAZ_calintegrato.jsp">
                  <input type="submit" name="annulla_presenza" value="Annulla" style="color:#2A5951"/>
                </form>
              </td>
            </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>