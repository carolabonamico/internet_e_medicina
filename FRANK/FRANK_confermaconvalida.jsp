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
            
            <!-- ==================== Corpo Centrale ===================== -->
            <tr>
                <td valign="middle" align="center" bgcolor="white">
                    <TABLE border="0">
                        <tr>
                            <td align="center" background="">
                                <table align="center" border="0" cellspacing="0" cellpadding="5" height="380" style="color:#2A5951">
                                    <tr align="center" valign="middle">
                                        <td colspan="2"><h2>Si desidera convalidare l'account PAZ di marco_rossi con ID '34'?</h2></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <form method="post" action="FRANK_infopaz.jsp">
                                            <input type="submit" name="Convalida" value="Convalida" style="color:#2A5951"/>
                                            </form>
                                        </td>
                                        <td align="left">
                                            <form method="post" action="FRANK_infopaz.jsp">
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