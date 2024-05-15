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
<c:set var="ruolo_pagina" value="RESP"/>
<%@ include file="autorizzazione.jspf" %>

<%@ include file="LAYOUT_TOP.jspf"%>
<%@ include file="LAYOUT_MENU_RESP.jspf"%>

 <!-- ==================== Corpo Centrale ===================== -->

  <!-- --------------------- Pulsante indietro --------------------- -->
      <tr valign="top">
        <td align="center" width="17%">
          <a href="RESP_studi_pers_DEF.jsp">
            <img src="undo.png" width="40" height="40" title="Indietro">
          </a>
        </td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="16%">&nbsp</td>
        <td width="16%">&nbsp</td>
      </tr>

      <!-- Intestazione -->
<tr>
  <td align="center" colspan="6">
    <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="20" style="color:#468c7f">
      <tr>
        <td  align="center" colspan="2">
          <c:if test="${not empty errmsg}">
            <img src="error.png" height="100" alt="Errore">
          </c:if>
          <c:if test="${not empty msgok}">
            <img src="check.png" height="100" alt="ok">
          </c:if>
        </td>
      </tr>
      <tr>
        <td align="center" colspan="2">
          <c:if test="${not empty errmsg}">
            <b><font color="#CC0000">${errmsg}</font></b>
          </c:if>
          <c:if test="${not empty msgok}">
            <b>${msgok}</b>
          </c:if>
        </td>
      </tr>

  <c:if test="${empty errmsg && empty msgok}">
        <img src="risultati.png" height="150" alt="Ditta farmaceutica"/><br/>
        <h3 align="center" style="color:#25544E">Risultati<br/></h3>
        <p align="center" style="color:#468c7f">
          <i>In questa sezione e' possibile inserire i risultati dello studio clinico.</i>
        </p>
  </c:if>
        </td>
      </tr>

    <form action="RESP_salva_risultati.jsp" method="post">
      <tr>
        <td align="center">



            <tr bgcolor="#f2f2f2">
              <td align="center">
                 <textarea name="esito" rows="20" cols="85">${param.esito}</textarea>
              </td>
            </tr>
          </table>
        </td>
      </tr>

      <tr>
        <td align="center" colspan="6">
          <input type="submit" value="Salva" style="color:#25544E">
          <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
        </td>
      </tr>
      </form>
      
<%@ include file="LAYOUT_BOTTOM.jspf" %>