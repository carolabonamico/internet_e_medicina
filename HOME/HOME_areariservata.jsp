<%@ page session="true"
language="java"
contentType="text/html; charset=UTF-8"
import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_HOME.jspf" %>

<sql:query var="frank">
  SELECT USERNAME, PASSWORD
  FROM ACCOUNT
  WHERE COD_RUOLO = 1
</sql:query>
<sql:query var="resp">
  SELECT USERNAME, PASSWORD
  FROM ACCOUNT
  WHERE COD_RUOLO = 2
</sql:query>
<sql:query var="pres">
  SELECT USERNAME, PASSWORD
  FROM ACCOUNT
  WHERE COD_RUOLO = 3
</sql:query>
<sql:query var="farm">
  SELECT USERNAME, PASSWORD
  FROM ACCOUNT
  WHERE COD_RUOLO = 4
</sql:query>
<sql:query var="paz">
  SELECT USERNAME, PASSWORD
  FROM ACCOUNT
  WHERE COD_RUOLO = 5
</sql:query>
<sql:query var="med">
  SELECT USERNAME, PASSWORD
  FROM ACCOUNT
  WHERE COD_RUOLO = 6
</sql:query>

  <!-- ==================== Corpo Centrale ===================== -->

  <!-- ZONA DI INSERIMENTO DEI DATI-->
          <tr>
            <td align="center">
              <table valign="middle" border="0" align="center" border="0" width="50%" cellspacing="0" cellpadding="15" style="color:#25544E">

                <tr>
                  <td align="center" colspan="2">
                    
                    <img src="area_registrata.png" height="150" alt="Area riservata"/><br/>
                    <h3 align="center" style="color:#25544E">
                    Per accedere a tutti i nostri servizi, effettua il login qui:<br/><br/>
                    </h3>

                    <!-- ERRORI COMMESSI-->
                    <c:if test="${not empty errmsg}">
                      <font color="red"><b><br/><br/>${errmsg}<br/><br/></b></font>
                    </c:if>
              
                    <c:if test="${not empty err_user}">
                      <font color="red"><b><br/><br/>${err_user}<br/><br/></b></font>
                    </c:if>
              
                    <c:if test="${not empty err_pass}">
                      <font color="red"><b><br/><br/>${err_pass}<br/><br/></b></font>
                    </c:if>

                  </td>
                </tr>

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script>$(document).ready(function(){
                $("#menuButton").click(function(){
                $("#menu").slideToggle();
                });
                });</script>

        <!-- ==================== Utenze significative ===================== -->
        <c:if test="${not empty frank.rows &&
          not empty med.rows &&
          not empty paz.rows &&
          not empty pres.rows &&
          not empty resp.rows &&
          not empty farm.rows}">

        <tr height="60" width="15%">
          <td align="center" colspan="2">
            <button id="menuButton" style="color:#468C7F">Utenze</button>
          </td>
        </tr>  
        <tr>
          <td align="center" colspan="2">
          <div id="menu" style="display:none;">
            <table cellpadding="10">
              <tr>
                <th>&nbsp</th>
                <th>Username</th>
                <th>Password</th>
              </tr>

              <c:if test="${not empty frank.rows}">
              <tr bgcolor="#f2f2f2" height="40">
                <td align="center" style="color:#25544E">
                  FRANK
                </td>
                <td align="center" style="color:#468C7F">${frank.rows[0].USERNAME}</td>
                <td align="center" style="color:#468C7F">${frank.rows[0].PASSWORD}</td>
              </tr>
              </c:if>

              <c:if test="${not empty resp.rows}">
              <tr bgcolor="#f2f2f2" height="40">
                <td align="center" style="color:#25544E">
                  RESP
                </td>
                <td align="center" style="color:#468C7F">${resp.rows[0].USERNAME}</td>
                <td align="center" style="color:#468C7F">${resp.rows[0].PASSWORD}</td>
              </tr>
              </c:if>

              <c:if test="${not empty pres.rows}">
              <tr bgcolor="#f2f2f2" height="40">
                <td align="center" style="color:#25544E">
                  PRES
                </td>
                <td align="center" style="color:#468C7F">${pres.rows[0].USERNAME}</td>
                <td align="center" style="color:#468C7F">${pres.rows[0].PASSWORD}</td>
              </tr>
              </c:if>

              <tr bgcolor="#f2f2f2" height="40">
                <td align="center" style="color:#25544E">
                  PAZ
                </td>
                <td align="left" style="color:#468C7F">${paz.rows[0].USERNAME}</td>
                <td align="left" style="color:#468C7F">${paz.rows[0].PASSWORD}</td>
              </tr>
              
              <c:if test="${not empty med.rows}">
              <tr bgcolor="#f2f2f2" height="40">
                <td align="center" style="color:#25544E">
                  MED
                </td>
                <td align="left" style="color:#468C7F">${med.rows[0].USERNAME}</td>
                <td align="left" style="color:#468C7F">${med.rows[0].PASSWORD}</td>
              </tr>
              </c:if>

              <c:if test="${not empty farm.rows}">
              <tr bgcolor="#f2f2f2" height="40">
                <td align="center" style="color:#25544E">
                  FARM
                </td>
                <td align="left" style="color:#468C7F">${farm.rows[0].USERNAME}</td>
                <td align="left" style="color:#468C7F">${farm.rows[0].PASSWORD}</td>
              </tr>
              </c:if>
            </table>
          </div>
          </td>
        </tr>
        </c:if>
                
                <!-- ----------------- Tabella -------------------  -->
                <form method="post" action="HOME_login.jsp">
                <tr bgcolor="#f2f2f2" height="60">
                  <td width="50%" align="right"><b>Username:&nbsp;&nbsp;</b></td>
                  <td width="50%" align="left">
                    <input type="text" name="username" value="${param.username}" style="color:#468C7F"/>
                  </td>
                </tr>
                
                <tr bgcolor="#f2f2f2" height="60" width="15%">
                  <td width="50%" align="right"><b>Password:&nbsp;&nbsp;</b></td>
                  <td width="50%" align="left">
                    <input type="password" name="password" value="${param.pass}" style="color:#468C7F"/>
                  </td>
                </tr>

                <tr bgcolor="#f2f2f2" height="40" width="15%">
                  <td colspan="2" align="center">
                    <a href="HOME_pwdimenticata.jsp" align="center" style="color:#468C7F"><i>Sei un paziente ed hai dimenticato la password?</i></a>
                  </td>
                </tr>

                <tr bgcolor="#f2f2f2" height="60" width="15%">
                  <td colspan="2" align="center">
                    <input type="submit" value="Accedi all'Area Riservata" style="color:#25544E">
                  </td>
                </tr>

              </table>
            </td>
          </tr>
        </form>

      <tr style="color:#468c7f" align="center">
        <td>
          <i>Se invece non hai mai eseguito l'accesso sul nostro sito e vuoi diventare volontario:<br/>
          <a href="HOME_registrazione.jsp" align="center" style="color:#468C7F">Registrati qui!</i></a>
        </td>
      </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>