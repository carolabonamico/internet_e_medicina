<%@ page session="true"
language="java"
contentType="text/html; charset=UTF-8"
import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<!-- controllo sui dati, se anche uno dei dati e' mancante segnalo l'errore -->

<c:if test="${empty param.nome}">
	<c:set var="errnome" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omesso il nome.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${empty param.cognome}">
	<c:set var="errcognome" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omesso il cognome.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${empty param.cod_fiscale}">
	<c:set var="errcod_fiscale" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omesso il codice fiscale.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${empty param.sesso}">
	<c:set var="errsesso" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omesso il sesso.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${empty param.data_nascita}">
	<c:set var="errdata_nascita" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omessa la data di nascita.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${empty param.email}">
	<c:set var="erremail" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omesso l'indirizzo mail.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${empty param.indirizzo}">
	<c:set var="errindirizzo" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omesso l'indirizzo.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${empty param.stato_salute}">
	<c:set var="errstato_salute" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si sono omesse le informazioni circa lo stato di salute.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${empty param.username}">
	<c:set var="errusername" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omesso l'username.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${empty param.password}">
	<c:set var="errpassword" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omessa la password.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${empty param.conf_pass}">
	<c:set var="errconf_pass" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omessa la password di conferma.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${empty param.domanda_sicurezza || param.domanda_sicurezza == ''}">
	<c:set var="errdom" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Non si e' scelta la domanda di sicurezza.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${empty param.risp}">
	<c:set var="errrisp" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omessa la risposta alla domanda di sicurezza.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<!-- CONTROLLO SE LE Password COMBACIANO -->
<c:if test="${param.password != param.conf_pass}">
  <c:set var="msg" scope="request">
		${msg}
    Le password non coincidono!<br/>
  </c:set>
  <c:set var="errflag" value="true"/>
</c:if>

<!--Controllo se l'username non e' gia stato utilizzato nel database -->
 <sql:query var="ctrl_username">
   SELECT USERNAME
   FROM ACCOUNT
   WHERE USERNAME = ?
   <sql:param value="${param.username}"/>
 </sql:query>

 <c:if test="${not empty ctrl_username.rows}">
  <c:set var="msg" scope="request">
		${msg}
    L'username inserito e' gia' stato utilizzato.<br/>
  </c:set>
  <c:set var="errflag" value="true"/>
 </c:if>

 <!--Controllo se la password non e' gia' stata utilizzata nel database -->
  <sql:query var="ctrl_password">
    SELECT PASSWORD
    FROM ACCOUNT
    WHERE PASSWORD = ?
    <sql:param value="${param.password}"/>
  </sql:query>

  <c:if test="${not empty ctrl_password.rows}">
    <c:set var="msg" scope="request">
      ${msg}
      La password inserita e' gia' stata utilizzata.<br/></c:set>
    <c:set var="errflag" value="true"/>
  </c:if>

<!--=== Parsing della data ==== -->
<fmt:parseDate  value="${param.data_nascita}"
                var="data_nascita"
                pattern="yyyy-MM-dd"/>

<!--==== SETTO IL SESSO UN'UNICA LETTERA M O F ====-->
<c:choose>
  <c:when test="${param.sesso == 'maschio'}">
    <c:set var="sesso_1" value="M"/>
  </c:when><c:otherwise>
    <c:set var="sesso_1" value="F"/>
  </c:otherwise>
</c:choose>

<!-- SETTO IL RUOLO NUMERICAMENTE, dato che la registrazione la puo fare
     solo il paziente setto il ruolo a 5 e lo stato di attesa dato che poi la conferma
     verra' data da FRANK-->
  <c:set var="ruolo" value="5"/>
  <c:set var="stato_acc" value="10"/>

<!-- CONTATORE -->
<sql:transaction>
  <sql:query var="rset_codice">
   SELECT valore
   FROM CONTATORI
   where attributo = 'ACCOUNT'
  </sql:query>
  <c:set var="id_paz" value="${rset_codice.rows[0].valore}"/>

  <sql:update>
   UPDATE CONTATORI set valore = valore + 1
   WHERE attributo = 'ACCOUNT'
  </sql:update>
</sql:transaction>

<!--==== Inserimento dei dati nella tabella  del paziente ===-->
<c:if test="${empty errflag}">
<sql:transaction>
  <!--INSERIMENTO NELLA TABELLA DEL PAZIENTE -->
  <sql:update>
  INSERT INTO PAZ(ID_PAZ, NOME, COGNOME, DATA_NASCITA, SESSO, EMAIL, TELEFONO, INDIRIZZO,
                  CODICE_FISC, PROFESSIONE, STATO_SALUTE, ID_DOMANDA, RISPOSTA)
  VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)
  <sql:param value="${id_paz}"/>
  <sql:param value="${param.nome}"/>
  <sql:param value="${param.cognome}"/>
  <sql:dateParam value="${data_nascita}" type="date"/>
  <sql:param value="${sesso_1}"/>
  <sql:param value="${param.email}"/>
  <sql:param value="${param.telefono}"/>
  <sql:param value="${param.indirizzo}"/>
  <sql:param value="${param.cod_fiscale}"/>
  <sql:param value="${param.professione}"/>
  <sql:param value="${param.stato_salute}"/>
  <sql:param value="${param.domanda_sicurezza}"/>
  <sql:param value="${param.risp}"/>
  </sql:update>

<!-- inserimento nella tabella  account -->
  <sql:update>
  INSERT INTO ACCOUNT (ID_ACCOUNT, USERNAME, PASSWORD, COD_RUOLO, STATO_ACC)
  VALUES (?,?,?,?,?)
  <sql:param value="${id_paz}"/>
  <sql:param value="${param.username}"/>
  <sql:param value="${param.password}"/>
  <sql:param value="${ruolo}"/>
  <sql:param value="${stato_acc}"/>
  </sql:update>
</sql:transaction>

<!-- Mi faccio restituire un messeggio nel caso in cui i dati siano stati inseriti correttamente-->
<sql:query var="rset_inserito">
  SELECT a.ID_ACCOUNT,a.USERNAME,a.PASSWORD,a.COD_RUOLO, a.STATO_ACC, p.ID_DOMANDA, p.RISPOSTA,
         p.NOME, p.COGNOME, p.DATA_NASCITA, p.SESSO, p.EMAIL, p.TELEFONO,
         p.INDIRIZZO, p.CODICE_FISC, p.PROFESSIONE, p.STATO_SALUTE, p.ID_DOMANDA, p.RISPOSTA
  FROM ACCOUNT a, PAZ p
  WHERE a.ID_ACCOUNT=p.ID_PAZ
  AND a.ID_ACCOUNT=?
  <sql:param value="${id_paz}"/>
</sql:query>
</c:if>

<c:if test="${errflag}">
	<jsp:forward page="HOME_registrazione.jsp"/>
</c:if>

<jsp:forward page="HOME_confermaregistrazione.jsp"/>