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

<!-- QUERY PER LA SELECT -->
<sql:query var="rset_select_studio">
  SELECT DISTINCT S.NOME_STUDIO
  FROM SSC S, ISCRIZIONE I
  WHERE S.ID_SSC = I.ID_SSC
  AND I.ID_PAZ = ?
  <sql:param value="${id_user}"/>
</sql:query>

<%-- QUERY ESTRAZIONE INCENTIVO TOTALE --%>
<sql:query var="rset_incentivo_tot">
  SELECT SUM(S.INCENTIVO) as INC_TOT
  FROM SSC S, ISCRIZIONE I
  WHERE S.ID_SSC = I.ID_SSC AND I.COD_STATO_PAZ = 50 
  AND I.ID_PAZ = ?
  <sql:param value="${id_user}"/>
</sql:query>

<%-- QUERY ESTRAZIONE INCENTIVI --%>
<sql:query var="rset_incentivi">
  SELECT S.INCENTIVO, S.ID_SSC, S.NOME_STUDIO, I.COD_STATO_PAZ
  FROM SSC S, ISCRIZIONE I
  WHERE S.ID_SSC = I.ID_SSC
  AND I.ID_PAZ = ?
  <sql:param value="${id_user}"/>

  <%-- CONTROLLO STUDIO --%>
  <c:if test="${not empty paramValues.nomestudio&& paramValues.nomestudio[0] != ''}">
              <c:set var="dim_at" value="${fn:length(paramValues.nomestudio)}"/>
              <c:if test="${dim_at == 1}">
              AND S.NOME_STUDIO = ?
              <sql:param value="${paramValues.nomestudio[0]}"/>
              </c:if>
              <c:if test="${dim_at == 2}">
              AND (S.NOME_STUDIO = ?
              OR S.NOME_STUDIO = ?)
              <sql:param value="${paramValues.nomestudio[0]}"/>
              <sql:param value="${paramValues.nomestudio[1]}"/>
              </c:if>
              <c:if test="${dim_at > 2}">
              AND (S.NOME_STUDIO = ?
              <sql:param value="${paramValues.nomestudio[0]}"/>
              <c:forEach items="${paramValues.nomestudio}" begin="1" end="${dim_at-2}" var="myarea">
              OR S.NOME_STUDIO = ?
              <sql:param value="${myarea}"/>
              </c:forEach>
              OR S.NOME_STUDIO = ?)
              <sql:param value="${paramValues.nomestudio[dim_at-1]}"/>
              </c:if>
              </c:if>
              
</sql:query>

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_PAZ.jspf" %>

        <!-- ==================== Corpo Centrale ===================== -->

          <!-- -------------------- Intestazione tabella 1 -------------------- -->
          <tr height="60%" width="100%"  valign="middle">
            <td align="center" bgcolor="white" cellpadding="10">
              <img src="incentivo.png" height="150" alt="Incentivo"><br/><br/>
              <h2 style="color:#25544E">Incentivi<br/></h2>
              <p style="color:#25544E">
                <i>In questa pagina e' possibile visualizzare tutte le informazioni relative agli incentivi di ogni studio.<br/><br/></i>
              </p>
            </td>
          </tr>

          <!----------------------------- Messaggio ---------------------- -->
          <c:if test="${rset_incentivi.rowCount == 0 && empty param.nome_studio}">
            <tr>
              <td valign="middle" align="center">
                <font style="color:red"><b>Non si risulta iscritti ad alcuno studio.<br/></b></font>
              </td>
            </tr>
          </c:if>
        
        <!----------------------------- Pulsanti Cerca/Mostra tutto ---------------------- -->
        <form method="post" action="PAZ_portafoglio.jsp">
            <tr>
              <td valign="middle" align="center">
                <table valign="middle" align="center" border="0" width="500px" cellspacing="0" cellpadding="10">
                  <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
                    <td>
                      <input type="submit" name="cerca" id="submit-button" value="Cerca" align="center" style="color:#468c7f"/>
                    </td>
                  </tr>
                  <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
                    <td>
                      <p style="color:#25544E">
                        <i>Per ripristinare il valore dei filtri, premere sui "-- Segnaposto --"<br/></i>
                      </p>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>

            <tr valign="middle">
              <td align="center" bgcolor="white" cellpadding="10">

                <!-- -------------------- Tabella 1 -------------------- -->
                  <table valign="middle" align="center" border="0" width="700px" cellspacing="0" cellpadding="15">
                    <tr bgcolor="#2a5951" style="color:white" height="60">
                      <th> Nome Studio Clinico </th>
                      <th> Incentivo previsto </th>
                      <th> Incentivo percepito </th>
                    </tr>

                    <tr valign="middle" bgcolor="#f2f2f2">
                      <td align="center">
                        <form method="post" action="#">
                          <select name="nomestudio" multiple="multiple">
                            <option value="" align="center">-- Studio --</option>
                            <c:forEach items="${rset_select_studio.rows}" var="st">
                              <option value="${st.NOME_STUDIO}" align="center"
                              <c:forEach items="${paramValues.nomestudio}" var="parnome">
                                <c:if test="${parnome == st.NOME_STUDIO}">selected="selected"</c:if>
                              </c:forEach>
                              >${st.NOME_STUDIO}</option>
                            </c:forEach>
                          </select>
                        </form>
                      </td>

                      <td> &nbsp </td>

                      <td> &nbsp </td>
                    </tr>

                    <c:forEach items="${rset_incentivi.rows}" var="inc">
                      <tr bgcolor="#f2f2f2"  style="color:#468c7f">
                        <td align="center">${inc.NOME_STUDIO}</td>
                        <td align="center">${inc.INCENTIVO}</td>
                        <td align="center"> 
                          <c:choose>
                          <c:when test="${inc.COD_STATO_PAZ == 10 || inc.COD_STATO_PAZ == 20}">
                            In attesa
                          </c:when>
                          <c:when test="${inc.COD_STATO_PAZ == 30 || inc.COD_STATO_PAZ == 40}">
                            0
                          </c:when>
                          <c:otherwise>
                            ${inc.INCENTIVO}
                          </c:otherwise>
                          </c:choose>
                        </td>
                      </tr>
                    </c:forEach> 
                    
                  </table>
              </td>
            </tr>
                </form>

            <!-- -------------------- Intestazione tabella 2 -------------------- -->
            <tr height="60%" width="100%"  valign="middle">
              <td align="center" bgcolor="white" cellpadding="10">
                <h2 style="color:#25544E">Totale<br/></h2>
                <p style="color:#25544E">
                  <i>In questa sezione e' possibile visualizzare l'incentivo totale percepito da tutti gli studi.<br/><br/><br/></i>
                </p>
          
              <!-- -------------------- Tabella 2 -------------------- -->
                <table valign="middle" align="center" border="0" width="700px" cellspacing="0" cellpadding="10">
                  <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
                    <td>Totale:</td>
                    <td align="left">
                    <c:choose>
                      <c:when test="${rset_incentivo_tot.rows[0].INC_TOT == null}">
                        0 
                      </c:when>
                      <c:otherwise>
                        ${rset_incentivo_tot.rows[0].INC_TOT}
                      </c:otherwise>
                    </c:choose>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>