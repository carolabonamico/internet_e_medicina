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
<!-- Intestazione -->
<tr>
  <td align="center" colspan="2">
    <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="20" style="color:#468c7f">
      <tr>
        <td  align="center" colspan="2">
          <c:if test="${not empty errmsg}">
            <img src="error.png" height="100" alt="Errore">
          </c:if>
          <c:if test="${not empty okmsg}">
            <img src="check.png" height="100" alt="ok">
          </c:if>
        </td>
      </tr>
      <tr>
        <td align="center" colspan="2">
          <c:if test="${not empty errmsg}">
            <b><font color="#CC0000">${errmsg}</font></b>
          </c:if>
          <c:if test="${not empty okmsg}">
            <b>${okmsg}</b>
          </c:if>
        </td>
      </tr>

  <c:if test="${empty errmsg && empty okmsg}">
  <img src="vitamin.png" height="150" alt="Ditta farmaceutica"/><br/>
  <h3 align="center" style="color:#25544E">Account ditta farmaceutica<br/></h3>
  <p align="center" style="color:#468c7f">
    <i>In questa sezione e' possibile creare nuovi account per le ditte farmaceuitche, tramite il modulo sottostante.</i>
  </p>
</c:if>
  </td>
</tr>
<form action="RESP_ctrlsalva_farm.jsp" method="post">
<tr>
  <td align="center" colspan="2">
    <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="20" style="color:#468c7f">

      <tr bgcolor="#f2f2f2" height="60" width="15%">
        <td>
          <c:if test="${not empty errnome}"><b><font color="#CC0000">Nome della ditta:</font></b></c:if>
          <c:if test="${empty errnome}"><font color="#468c7f"><b>Nome della ditta: </b></font></c:if>
        </td>
        <td align="left"><input type="text" name="Nome_ditta" value="${param.Nome_ditta}"></td>
      </tr>

      <tr height="60" width="15%">
        <td>
          <c:if test="${not empty errusername_farm}"><b><font color="#CC0000">Username:</font></b></c:if>
          <c:if test="${empty errusername_farm}"><font color="#468c7f"><b>Username: </b></font></c:if>
        </td>
        <td align="left"><input type="text" name="Username_farm" value="${param.Username_farm}"></td>
      </tr>

      <tr bgcolor="#f2f2f2" height="60" width="15%">
        <td>
          <c:if test="${not empty errpassword_farm}"><b><font color="#CC0000">Password:<i>(massimo 10 caratteri)</i>:</font></b></c:if>
          <c:if test="${empty errpassword_farm}"><font color="#468c7f"><b>Password </b><i>(massimo 10 caratteri)</i>:</font></c:if>
        </td>
        <td align="left"> <input type="password" name="password_farm"></td>
      </tr>

      <tr height="60" width="15%">
        <td>
          <c:if test="${not empty errconf_pass_farm}"><b><font color="#CC0000">Conferma password:</font></b></c:if>
          <c:if test="${empty errconf_pass_farm}"><font color="#468c7f"><b>Conferma password:</b></font></c:if>
        </td>
        <td align="left"><input type="password" name="conf_pass_farm"></td>
      </tr>

      <tr bgcolor="#f2f2f2" height="60" width="15%">
        <td>
          <c:if test="${not empty errmail}"><b><font color="#CC0000">Mail della ditta:</font></b></c:if>
          <c:if test="${empty errmail}"><font color="#468c7f"><b>Mail della ditta: </b></font></c:if>
        </td>
        <td align="left"><input type="email" name="mail_farm" value="${param.mail_farm}"></td>
      </tr>

      <tr height="60" width="15%">
        <td>
          <c:if test="${not empty errrespons}"><b><font color="#CC0000">Titolare ditta:</font></b></c:if>
          <c:if test="${empty errrespons}"><font color="#468c7f"><b>Titolare ditta: </b></font></c:if>
        </td>
        <td align="left"><input type="text" name="responsabile" value="${param.responsabile}"></td>
      </tr>

      <tr bgcolor="#f2f2f2" height="60" width="15%">
        <td>
          <c:if test="${not empty errtell}"><b><font color="#CC0000">Numero di telefono del Titolare:</font></b></c:if>
          <c:if test="${empty errtell}"><font color="#468c7f"><b>Numero di telefono del Titolare:</b></font></c:if>
        </td>
        <td align="left"><input type="tel" name="telefono" placeholder="123 456 7890" pattern="[0-9]{3} [0-9]{3} [0-9]{4}" value="${param.telefono}"></td>
      </tr>

      <tr height="60" width="15%">
        <td>
          <c:if test="${not empty errindirizzo}"><b><font color="#CC0000">Indirizzo sede:</font></b></c:if>
          <c:if test="${empty errindirizzo}"><font color="#468c7f"><b>Indirizzo sede:</b></font></c:if>
        </td>
        <td>
          <input type="text" name="indirizzo" value="${param.indirizzo}"/>
        </td>
       </tr>
    </table>
  </td>
</tr>
<tr>
  <td align="right" width="50%">
    <input type="submit" name="Invia" style="color:#25544E">
  </td>
  <td align="left" width="50%">
    <input type="reset" name="Reset" style="color:#25544E">
  </td>
</tr>
</form>

<%@ include file="LAYOUT_BOTTOM.jspf" %>
