<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<c:set var="ruolo_pagina" value="PAZ"/>
<%@ include file="autorizzazione.jspf" %>

<sql:query var="rset_select_medico">
  SELECT ID_MED, NOME, COGNOME
  FROM MED
</sql:query>

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_PAZ.jspf" %>

      <!-- ==================== Corpo Centrale ===================== -->
      <tr valign="middle">
        <td colspan="2" align="center"><img src="contract.png" height="150" alt="Partecipa"></td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <h2>Si desidera partecipare allo studio clinico "${param.nome_studio_att}"?</h2>

          <c:if test="${param.vis_med == 1}">
            <h4>Per partecipare a questo studio e' stata disposta una visita medica.<br/>
          </c:if>
        </td>
      </tr>
      
      <form method="post" action="PAZ_updatepartecipa.jsp">
      <c:if test="${param.vis_med == 1}">

      <!----------------------------- Messaggi ---------------------- -->
            <c:if test="${not empty param.msg}">
              <tr>
                <td valign="middle" align="center" colspan="2">
                  <font style="color:red"><b>${param.msg}</b></font>
                </td>
              </tr>
            </c:if>

        <tr>
          <td align="right">
            <p><i>Indicare il medico presso cui effettuare la visita:</i></p>
          </td>
          <td align="left">
            <select name="medico">
              <option value="" align="center">-- Medico --</option>
              <c:forEach items="${rset_select_medico.rows}" var="med">
                <option value="${med.ID_MED}" align="center"
                  <c:if test="${param.medico == med.ID_MED}">selected="selected"</c:if>
                >${med.NOME} ${med.COGNOME}</option>
              </c:forEach>
            </select>
          </td>
        </tr>
      </c:if>

      <!-- --------------------- Pulsanti di partecipa/annulla --------------------- --> 
      <tr>
        <td align="right" width="50%">
            <input type="submit" name="partecipa" value="Conferma" style="color:#2A5951"/>
            <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
            <input type="hidden" name="nome_studio_att" value="${param.nome_studio_att}"/>
            <input type="hidden" name="vis_med" value="${param.vis_med}"/>
        </form>
        </td>
        <td align="left"  width="50%">
          <form method="post" action="PAZ_studiattivi.jsp">
            <input type="submit" name="annulla_partecipa" value="Annulla" style="color:#2A5951"/>
          </form>
        </td>
      </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>