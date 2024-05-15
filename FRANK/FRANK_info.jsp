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

           <!-- ==================== Tasto Indietro ===================== -->
           <tr valign="top">
             <td align="center" width="25%" colspan="2">
              <c:choose>
                <c:when test="${not empty param.conv_acc}">
                    <a href="FRANK_CONV_PAZ.jsp">
                      <img src="undo.png" width="40" height="40" title="Indietro">
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="FRANK_elenco_acc.jsp">
                      <img src="undo.png" width="40" height="40" title="Indietro">
                    </a>
                </c:otherwise>
             </c:choose>
            </td>
            <td width="25%">&nbsp</td>
            <td width="25%">&nbsp</td>
            <td width="25%">&nbsp</td>
           </tr>

<!--   ESTRAZIONE DATI A SECONDA DEL RUOLO   -->

<!-- ================== PAZIENTE ================== -->
<c:if test="${param.ruolo == 'PAZ'}">
   <sql:query var="rset_dati">
      SELECT P.ID_PAZ, P.NOME, P.COGNOME, P.DATA_NASCITA, P.SESSO, P.EMAIL, P.TELEFONO, P.INDIRIZZO, P.CODICE_FISC, P.PROFESSIONE, P.STATO_SALUTE
      FROM PAZ P
      WHERE P.ID_PAZ = ?
      <sql:param value="${param.id_acc}"/>  
   </sql:query>


<tr>
                <td align="center" colspan="5" width="100%">
                        <table valign="middle" align="center" border=0" width="50%" cellspacing="0" cellpadding="10" style="color:#468c7f">

                          <tr>
                                <img src="personal.png" height="150" alt="Informazioni personali"/><br/>
                                <h2 style="color:#25544E">Dati anagrafici e contatti<br/></h2>
                            </tr>
                                                 
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Nome</b></td>
                                <td>${rset_dati.rows[0].NOME}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Cognome</b></td>
                                <td>${rset_dati.rows[0].COGNOME}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Sesso</b></td>
                                <td>
                                   <c:if test="${rset_dati.rows[0].SESSO == 'M'}">
                                     Maschio
                                   </c:if>
                                   <c:if test="${rset_dati.rows[0].SESSO == 'F'}">
                                     Femmina
                                   </c:if>
                                </td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Codice Fiscale</b></td>
                                <td>${rset_dati.rows[0].CODICE_FISC}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Domicilio</b></td>
                                <td>${rset_dati.rows[0].INDIRIZZO}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Data di nascita</b></td>
                                <td>${rset_dati.rows[0].DATA_NASCITA}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>E-mail</b></td>
                                <td>${rset_dati.rows[0].EMAIL}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Cellulare</b></td>
                                <td>${rset_dati.rows[0].TELEFONO}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Professione</b></td>
                                <td>${rset_dati.rows[0].PROFESSIONE}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Stato salute</b></td>
                                <td>${rset_dati.rows[0].STATO_SALUTE}</td>
                            </tr>
                   
                            <c:if test="${not empty param.conv_acc}">
                             <form method="post" action="FRANK_act_convalida.jsp"
                               <tr height="60" width="15%">
                                   <td colspan="2" align="center">
                                      <input type="submit" name="Convalida" value="Convalida" style="color:#468c7f"/>
                                   </td>
                               </tr>
                               <input type="hidden" name="id_acc" value="${param.id_acc}"/>
                               <input type="hidden" name="ruolo" value="${param.ruolo}"/>
                              </form>
                            </c:if>
                             
                        </table>
                </td>
            </tr>
</c:if>



<!-- ================== PRESIDENTE ================== -->
<c:if test="${param.ruolo == 'PRES'}">
   <sql:query var="rset_dati">
      SELECT ID_PRES, NOME, COGNOME, SESSO, CF, DOMICILIO, DATA_NASCITA, MAIL, CELLULARE, N_ALBO
      FROM PRES
      WHERE ID_PRES = ?
      <sql:param value="${param.id_acc}"/> 
   </sql:query>


   <tr>
                <td align="center" colspan="5" width="100%">
                        <table valign="middle" align="center" border="0" width="50%" cellspacing="0" cellpadding="10" style="color:#468c7f">

                          <tr>
                                <img src="personal.png" height="150" alt="Informazioni personali"/><br/>
                                <h2 style="color:#25544E">Dati anagrafici e contatti<br/></h2>
                            </tr>
                                                 
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Nome</b></td>
                                <td>${rset_dati.rows[0].NOME}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Cognome</b></td>
                                <td>${rset_dati.rows[0].COGNOME}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Sesso</b></td>
                                <td>
                                   <c:if test="${rset_dati.rows[0].SESSO == 'M'}">
                                     Maschio
                                   </c:if>
                                   <c:if test="${rset_dati.rows[0].SESSO == 'F'}">
                                     Femmina
                                   </c:if>
                                </td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Codice Fiscale</b></td>
                                <td>${rset_dati.rows[0].CF}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Domicilio</b></td>
                                <td>${rset_dati.rows[0].DOMICILIO}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Data di nascita</b></td>
                                <td>${rset_dati.rows[0].DATA_NASCITA}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>E-mail</b></td>
                                <td>${rset_dati.rows[0].MAIL}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Cellulare</b></td>
                                <td>${rset_dati.rows[0].CELLULARE}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Numero di albo</b></td>
                                <td>${rset_dati.rows[0].N_ALBO}</td>
                            </tr>
                             
                        </table>
                </td>
            </tr>
</c:if>


<!-- ================== RESPONSABILE ================== -->
<c:if test="${param.ruolo == 'RESP'}">
   <sql:query var="rset_dati">
      SELECT ID_RESP, NOME, COGNOME, SESSO, CF, DOMICILIO, DATA_NASCITA, MAIL, CELLULARE, N_ALBO
      FROM RESP
      WHERE ID_RESP = ?
      <sql:param value="${param.id_acc}"/> 
   </sql:query>


<tr>
                <td align="center" colspan="5" width="100%">
                        <table valign="middle" align="center" border="0" width="50%" cellspacing="0" cellpadding="10" style="color:#468c7f">

                          <tr>
                                <img src="identity_card.png" height="150" alt="Informazioni personali"/><br/>
                                <h2 style="color:#25544E">Dati anagrafici e contatti<br/></h2>
                            </tr>
                                                 
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Nome</b></td>
                                <td>${rset_dati.rows[0].NOME}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Cognome</b></td>
                                <td>${rset_dati.rows[0].COGNOME}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Sesso</b></td>
                                <td>
                                   <c:if test="${rset_dati.rows[0].SESSO == 'M'}">
                                     Maschio
                                   </c:if>
                                   <c:if test="${rset_dati.rows[0].SESSO == 'F'}">
                                     Femmina
                                   </c:if>
                                </td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Codice Fiscale</b></td>
                                <td>${rset_dati.rows[0].CF}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Domicilio</b></td>
                                <td>${rset_dati.rows[0].DOMICILIO}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Data di nascita</b></td>
                                <td>${rset_dati.rows[0].DATA_NASCITA}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>E-mail</b></td>
                                <td>${rset_dati.rows[0].MAIL}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Cellulare</b></td>
                                <td>${rset_dati.rows[0].CELLULARE}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Numero di albo</b></td>
                                <td>${rset_dati.rows[0].N_ALBO}</td>
                            </tr>
                             
                        </table>
                </td>
            </tr>
</c:if>

<!-- ================== FARM ================== -->
<c:if test="${param.ruolo == 'FARM'}">
   <sql:query var="rset_dati">
      SELECT F.ID_FARM, F.NOME_DITTA, F.EMAIL, F.INDIRIZZO_SEDE, F.TITOLARE_DITTA, F.TELEFONO, F.BUDGET_DISPONIBILE, R.NOME, R.COGNOME     
      FROM FARM F, RESP R
      WHERE F.ID_RESP=R.ID_RESP AND
            ID_FARM = ?
      <sql:param value="${param.id_acc}"/> 
   </sql:query>


<tr>
                <td align="center" colspan="5" width="100%">
                        <table valign="middle" align="center" border="0" width="50%" cellspacing="0" cellpadding="10" style="color:#468c7f">

                          <tr>
                                <img src="vitamin.png" height="150" alt="Informazioni personali"/><br/>
                                <h2 style="color:#25544E">Dati anagrafici e contatti<br/></h2>
                            </tr>
                                                 
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Nome ditta</b></td>
                                <td>${rset_dati.rows[0].NOME_DITTA}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>E-mail</b></td>
                                <td>${rset_dati.rows[0].EMAIL}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Indirizzo sede</b></td>
                                <td>${rset_dati.rows[0].INDIRIZZO_SEDE}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Titolare ditta</b></td>
                                <td>${rset_dati.rows[0].TITOLARE_DITTA}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Telefono</b></td>
                                <td>${rset_dati.rows[0].Telefono}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Budget disponibile</b></td>
                                <td>${rset_dati.rows[0].BUDGET_DISPONIBILE}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Responsabile</b></td>
                                <td>${rset_dati.rows[0].NOME} &nbsp; ${rset_dati.rows[0].COGNOME}</td>
                            </tr>
                             
                        </table>
                </td>
            </tr>
</c:if>

<!-- ================== MEDICO ================== -->
<c:if test="${param.ruolo == 'MED'}">
   <sql:query var="rset_dati">
      SELECT ID_MED, NOME, COGNOME, SESSO, CF, DOMICILIO, DATA_NASCITA, MAIL, CELLULARE, N_ALBO
      FROM MED
      WHERE ID_MED = ?
      <sql:param value="${param.id_acc}"/> 
   </sql:query>


   <tr>
                <td align="center" colspan="5" width="100%">
                        <table valign="middle" align="center" border="0" width="50%" cellspacing="0" cellpadding="10" style="color:#468c7f">

                          <tr>
                                <img src="personal.png" height="150" alt="Informazioni personali"/><br/>
                                <h2 style="color:#25544E">Dati anagrafici e contatti<br/></h2>
                            </tr>
                                                 
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Nome</b></td>
                                <td>${rset_dati.rows[0].NOME}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Cognome</b></td>
                                <td>${rset_dati.rows[0].COGNOME}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Sesso</b></td>
                                <td>
                                   <c:if test="${rset_dati.rows[0].SESSO == 'M'}">
                                     Maschio
                                   </c:if>
                                   <c:if test="${rset_dati.rows[0].SESSO == 'F'}">
                                     Femmina
                                   </c:if>
                                </td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Codice Fiscale</b></td>
                                <td>${rset_dati.rows[0].CF}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Domicilio</b></td>
                                <td>${rset_dati.rows[0].DOMICILIO}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Data di nascita</b></td>
                                <td>${rset_dati.rows[0].DATA_NASCITA}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>E-mail</b></td>
                                <td>${rset_dati.rows[0].MAIL}</td>
                            </tr>
                            <tr height="60" width="15%">
                                <td><b>Cellulare</b></td>
                                <td>${rset_dati.rows[0].CELLULARE}</td>
                            </tr>
                            <tr bgcolor="#f2f2f2" height="60" width="15%">
                                <td><b>Numero di albo</b></td>
                                <td>${rset_dati.rows[0].N_ALBO}</td>
                            </tr>
                             
                        </table>
                </td>
            </tr>
</c:if>



<!-- frammento layout bottom generale -->
<%@ include file="LAYOUT_BOTTOM.jspf" %>