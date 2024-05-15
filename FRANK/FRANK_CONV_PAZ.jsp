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

<sql:query var="rset_elenco">
  SELECT A.ID_ACCOUNT, A.USERNAME, A.PASSWORD, S.DESCR_STATO, R.DESCRIZIONE
  FROM ACCOUNT A, RUOLO R, STATO_ACCOUNT S
  WHERE S.COD_STATO = A.STATO_ACC AND
        R.COD_RUOLO = A.COD_RUOLO AND
        A.COD_RUOLO = '5' AND
        S.COD_STATO = '10'
</sql:query>

<!-- --------------------- Intestazione --------------------- --> 
<tr>
    <td align="center" colspan="3">
      <img src="validation.png" height="150" alt="Convalida"/><br/>
      <h3 align="center" style="color:#25544E">Elenco degli account "paziente" in attesa di convalida</h3>
    </td>
  </tr>

 <!-- --------------------- Messaggio di conferma --------------------- --> 
 <c:if test="${not empty convmsg}">  
   <tr>
     <td align="center">   
         <b><font color="green"><br/>${convmsg}</font></b>  
     </td>
  </tr>
</c:if>

 <!-- -------------------- Tabella -------------------- -->
 <tr>
    <td align="center">
        <table valign="middle" align="center" border="0" width="600px" cellspacing="0" cellpadding="15">
            <tr bgcolor="#2a5951" style="color:white" height="60" width="15%">
                <th> ID account </th>
                <th> Username </th>
                <th> Password </th>
                <th> Stato </th>
                <th> &nbsp </th>
            </tr>

                    <c:forEach items="${rset_elenco.rows}" var="myvar">
            <tr bgcolor="f2f2f2" height="70" align="center" valign="middle" style="color:#468c7f">
                <td>${myvar.ID_ACCOUNT}</td>
                <td>${myvar.USERNAME}</td>
                <td>${myvar.PASSWORD}</td>

                <td> 
                    <img src="bottone_giallo.png" width="30" height="30" alt="simbolo attesa" /><br/>
                    In Attesa
                </td>
                <!-- tasti azioni -->
                <td>
                    <form method="post" action="FRANK_info.jsp">
                        <input type="submit" name="Dettagli" value="Dettagli" style="color:#468c7f"/>
                        <input type="hidden" name="id_acc" value="${myvar.ID_ACCOUNT}"/>
                        <input type="hidden" name="ruolo" value="${myvar.DESCRIZIONE}"/>
                        <input type="hidden" name="conv_acc" value="true"/>
                    </form>
                </td>
            </tr>
          </c:forEach>
        </table>
    </td>
 </tr>

        
<!-- frammento layout bottom generale -->
<%@ include file="LAYOUT_BOTTOM.jspf" %>