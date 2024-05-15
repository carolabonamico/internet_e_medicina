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
   SELECT USERNAME
   FROM ACCOUNT
   WHERE ID_ACCOUNT = ?
   <sql:param value="${param.id_acc}"/>
</sql:query>


<!-- ==================== Corpo Centrale ===================== -->
            <tr>
                <td valign="middle" align="center" bgcolor="white">
                    <TABLE border="0">
                        <tr>
                            <td align="center" background="">
                                <table align="center" border="0" cellspacing="0" cellpadding="5" height="380" style="color:#2A5951">
                                   <tr valign="middle">
                                      <td colspan="2" align="center"><img src="error.png" height="150" alt="Cancella"></td>
                                   </tr>
                                   <tr align="center" valign="middle">
                                        <td colspan="2"><h2>Si desidera eliminare l'account ${rset_elenco.rows[0].USERNAME}?</h2></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <form method="post" action="FRANK_act_elimina.jsp">
                                            <input type="submit" name="elimina" value="Elimina" style="color:#2A5951"/>
                                            <input type="hidden" name="id_acc" value="${param.id_acc}"/>
                                            <input type="hidden" name="ruolo" value="${param.ruolo}"/>
                                            </form>
                                        </td>
                                        <td align="left">
                                            <form method="post" action="FRANK_elenco_acc.jsp">
                                            <input type="submit" name="abbandona" value="Annulla" style="color:#2A5951"/>
                                            </form>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </TABLE>
                <!-- ==== distanziamento layout Bottom ==== -->
            <tr> <th>&nbsp </th></tr> 
            <tr> <th>&nbsp </th></tr>   
            <tr> <th>&nbsp </th></tr>


<!-- frammento layout bottom generale -->
<%@ include file="LAYOUT_BOTTOM.jspf" %>