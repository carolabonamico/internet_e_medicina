<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

  <!-- controllo sui dati, se l'username e' mancante segnalo l'errore -->
  <c:if test="${empty param.nome_user}">
    <c:set var="errnome" value="true" scope="request"/>
    <c:set var="msg" scope="request">
      Non si e' inserito alcun nome utente.<br/>
    </c:set>
    <c:set var="errflag" value="true"/>
  </c:if>

  <!--Controllo se l'username e' effettivamente presente nel database -->
  <c:if test="${not empty param.nome_user}">
    <sql:query var="ctrl_username">
    SELECT USERNAME, COD_RUOLO
    FROM ACCOUNT
    WHERE USERNAME = ?
    <sql:param value="${param.nome_user}"/>
    </sql:query>

    <c:if test="${ctrl_username.rows[0].COD_RUOLO != 5}">
      <c:set var="msg" scope="request">
        Il nome utente indicato e' inesistente.<br/>
      </c:set>
      <c:set var="errflag" value="true"/>
    </c:if>
  </c:if>

<c:if test="${errflag}">
	<jsp:forward page="HOME_pwdimenticata.jsp">
    <jsp:param name="utente" value="${param.nome_user}"/>
  </jsp:forward>
</c:if>

<sql:query var="rset_domanda">
  SELECT S.DOMANDA, S.COD_DOMANDA
  FROM SICUREZZA S, PAZ P, ACCOUNT A
  WHERE P.ID_DOMANDA = S.COD_DOMANDA
  AND A.ID_ACCOUNT = P.ID_PAZ
  AND A.USERNAME = ?
  <sql:param value="${param.nome_user}"/>
</sql:query>

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_HOME.jspf" %>

      <!-- ==================== Corpo Centrale ===================== -->
      
      <!-- --------------------- Pulsante indietro --------------------- --> 
      <tr valign="top">
        <td align="center" width="25%">
          <form method="post" action="HOME_pwdimenticata.jsp">
            <input type="image" src="undo.png" width="40" height="40" title="Indietro"/>
            <input type="hidden" name="utente" value="${param.nome_user}"/>
          </form>
        </td>
        <td>&nbsp</td>
        <td>&nbsp</td>
        <td>&nbsp</td>
      </tr>

      <tr>
        <td align="center" colspan="4">
          <table valign="middle" align="center" border="0" width="60%" cellspacing="0" cellpadding="10" style="color:#468c7f">
            <form method="post" action="HOME_cntrlpw.jsp">
  
                <tr>
                  <h2 style="color:#468c7f">Reimposta password:<br/></h2> 
                </tr> 

                <!-- --------------------- messaggio errore --------------------- -->  
                <c:if test="${not empty msg}">
                  <tr valign="middle" bgcolor="#f2f2f2">
                    <td align="center" colspan="2">
                      <b><font color="red">${msg}</font></b>
                    </td>
                  </tr>
                </c:if>

                <tr bgcolor="#f2f2f2" height="60" width="15%">
                  <td style="color:#468c7f"><b> Domanda di sicurezza: <b></td>
                    <td style="color:#468c7f">${rset_domanda.rows[0].DOMANDA}</td>
                </tr>

                <tr bgcolor="#f2f2f2" height="60" width="15%">
                  <td>
                    <c:if test="${not empty msg}">
                      <b><font color="red"> Inserire risposta: </font></b>
                    </c:if>
                    <c:if test="${empty msg}">
                      <b> Inserire risposta: </b>
                    </c:if>
                  </td>
                  <td><input type="text" name="risposta" value="${param.risposta}" placeholder="Inserisci risposta" length="15" style="color:#468c7f"/></td>
                </tr>
  
          </table>
        </td>
      </tr>

      <tr>
        <td align="center" colspan="4">
          <input type="submit" value="Invia risposta" style="color:#468c7f"/>
          <input type="hidden" name="cod_domanda" value="${rset_domanda.rows[0].COD_DOMANDA}"/>
          <input type="hidden" name="nome_user" value="${param.nome_user}"/>
        </td>
      </tr>
    </form>

<%@ include file="LAYOUT_BOTTOM.jspf" %>