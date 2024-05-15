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

    <form action="FRANK_act_crea_acc.jsp">
        <tr>
            <td align="center" colspan="2">    
                <table valign="middle" align="center" border="0" width="50%" cellspacing="0" cellpadding="10" style="color:#468c7f">
              
                    <tr>
                        <img src="account.png" height="150" alt="Crea account"/><br/>
                        <h2 style="color:#25544E">Creazione account RESP, PRES e MED<br/></h2>
                        <p>
                            <i>In questa sezione e' possibile creare nuovi account per i responsabili, i presidenti e i medici tramite il modulo sottostante.</i>
                        </p><br/>
                        <!-- controlla se ce errore e lo stampa -->
                        <c:if test="${not empty errmsg}">
                           <b><font color="#CC0000"><br/>${errmsg}<br/></font></b>
                        </c:if>
                        <c:if test="${not empty okmsg}">
                           <b><font color="green"><br/>L'account e' stato creato correttamente<br/></font></b>
                        </c:if>
                    </tr>
                    <tr height="30" >
                        <td colspan="2"> &nbsp; </td>
                    </tr> 

            <!-- ===================== Righe ===================== -->
           
                    <tr bgcolor="#f2f2f2" height="60" width="15%">
                      <td><c:if test="${not empty errruolo}">
                             <b><font color="#CC0000">Ruolo:</font></b></c:if>
                          <c:if test="${empty errruolo}">
                             <b>Ruolo:</b></c:if>
                      </td>
                      <td align="left"> 
                        <SELECT NAME="ruolo">
                            <OPTION VALUE=""> -- Scegli Ruolo -- </OPTION>
                            <OPTION VALUE="Responsabile" <c:if test="${param.ruolo == 'Responsabile'}">selected="selected"</c:if>> Responsabile </OPTION>
                            <OPTION VALUE="Presidente" <c:if test="${param.ruolo == 'Presidente'}">selected="selected"</c:if>> Presidente </OPTION>
                            <OPTION VALUE="Medico" <c:if test="${param.ruolo == 'Medico'}">selected="selected"</c:if>> Medico </OPTION>
                        </SELECT>
                    </td>
                    </tr>

                    <tr  height="60" width="15%">
                      <td><c:if test="${not empty erralbo}">
                             <b><font color="#CC0000">Numero albo:</font></b></c:if>
                          <c:if test="${empty erralbo}">
                             <b>Numero albo:</b></c:if>
                      </td>
                      <td align="left"><input type="text" name="n_albo" value="${param.n_albo}">                       
                      </td>
                    </tr>
      
                    <tr bgcolor="#f2f2f2" height="60" width="15%">
                      <td><c:if test="${not empty errnome}">
                             <b><font color="#CC0000">Nome:</font></b></c:if>
                          <c:if test="${empty errnome}">
                             <b>Nome:</b></c:if>
                      </td>
                      <td align="left"> <input type="text" name="nome" value="${param.nome}">                   
                      </td>
                    </tr>
       
                    <tr  height="60" width="15%">
                      <td><c:if test="${not empty errcognome}">
                             <b><font color="#CC0000">Cognome:</font></b></c:if>
                          <c:if test="${empty errcognome}">
                             <b>Cognome:</b></c:if>
                      </td>
                      <td align="left"><input type="text" name="cognome" value="${param.cognome}">                       
                      </td>
                    </tr>

                    <tr bgcolor="#f2f2f2" height="60" width="15%">
                        <td><c:if test="${not empty errsesso}">
                             <b><font color="#CC0000">Sesso:</font></b></c:if>
                          <c:if test="${empty errsesso}">
                             <b>Sesso:</b></c:if>
                      </td>
                        <td align="left">
                            <input type="radio" name="sesso" value="M"
                               <c:if test="${param.sesso == 'M'}">checked="checked"</c:if> />M<br/>
                            <input type="radio" name="sesso" value="F"
                               <c:if test="${param.sesso == 'F'}">checked="checked"</c:if> />F
                        </td>
                    </tr>

                    <tr  height="60" width="15%">
                        <td><c:if test="${not empty errcod_fiscale}">
                             <b><font color="#CC0000">Codice Fiscale:</font></b></c:if>
                          <c:if test="${empty errcod_fiscale}">
                             <b>Codice Fiscale:</b></c:if>
                      </td>
                        <td align="left">
                            <input type="text" name="cod_fiscale" maxlength="16" value="${param.cod_fiscale}"/>
                        </td>
                    </tr>

                    <tr bgcolor="#f2f2f2" height="60" width="15%">
                        <td><c:if test="${not empty errdomicilio}">
                             <b><font color="#CC0000">Domicilio:</font></b></c:if>
                          <c:if test="${empty errdomicilio}">
                             <b>Domicilio:</b></c:if>
                      </td>
                        <td align="left"><input type="text" name="domicilio" value="${param.domicilio}"></td>
                    </tr>

                    <tr  height="60" width="15%">
                        <td><c:if test="${not empty errdata_nascita}">
                             <b><font color="#CC0000">Data nascita:</font></b></c:if>
                          <c:if test="${empty errdata_nascita}">
                             <b>Data nascita:</b></c:if>
                      </td>
                        <td align="left"><input type="date" name="data_nascita" value="${param.data_nascita}"/></td>
                    </tr> 

                    <tr bgcolor="#f2f2f2" height="60" width="15%">
                        <td><c:if test="${not empty errtelefono}">
                             <b><font color="#CC0000">Cellulare: </font></b>
                           </c:if>
                           <c:if test="${empty errtelefono}">
                             <b>Cellulare:</b> 
                          </c:if>
                      </td>
                        <td align="left">
                            <input type="tel" name="telefono" value="${param.telefono}"/>
                        </td>
                    </tr>

                    <tr  height="60" width="15%">
                        <td><c:if test="${not empty erremail}">
                             <b><font color="#CC0000">Mail dell'account:</font></b></c:if>
                          <c:if test="${empty erremail}">
                             <b>Mail dell'account:</b></c:if>
                      </td>
                        <td align="left"><input type="email" name="email" value="${param.email}"/></td>
                    </tr>

                    <tr bgcolor="#f2f2f2" height="60" width="15%">
                        <td><c:if test="${not empty errusername}">
                             <b><font color="#CC0000">Username:</font></b></c:if>
                          <c:if test="${empty errusername}">
                             <b>Username:</b></c:if>
                      </td>
                        <td align="left"><input type="text" name="username" value="${param.username}"></td>
                    </tr>           

                    <tr height="60" width="15%">
                      <td><c:if test="${not empty errpassword}">
                             <b><font color="#CC0000"><b>Password </b><i>(massimo 10 caratteri)</i>:</font></b></c:if>
                          <c:if test="${empty errpassword}">
                             <b>Password </b><i>(massimo 10 caratteri)</i>:</c:if>
                      </td>
                      <td align="left"> <input type="password" name="password" value="${param.password}"></td>
                    </tr>
      
                    <tr bgcolor="#f2f2f2" height="60" width="15%">
                      <td><c:if test="${not empty errconf_pass}">
                             <b><font color="#CC0000">Conferma password:</font></b></c:if>
                          <c:if test="${empty errconf_pass}">
                             <b>Conferma password:</b></c:if>
                      </td>
                      <td align="left"><input type="password" name="conf_pass" value="${param.conf_pass}"></td>
                    </tr>
                </table>
            </td>
        </tr>
          
        <tr height="60">
            <td align="right" width="50%">
                <input type="submit" name="Invia" value="Conferma" style="color:#25544E">
            </td>
            <td align="left" width="50%">
                <input type="reset" name="Reset" style="color:#25544E">
            </td>
        </tr>
            
    </form>
    
<!-- frammento layout bottom generale -->
<%@ include file="LAYOUT_BOTTOM.jspf" %>