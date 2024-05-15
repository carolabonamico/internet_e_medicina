<%@page session="true" language="java" 
        contentType="text/html; charset=UTF-8" import="java.sql.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"      prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql"       prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"       prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<!-- ==================================== Tagliola =================================== --> 
<c:set var="ruolo_pagina" value="PAZ"/>
<%@ include file="autorizzazione.jspf" %>

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

<c:if test="${empty param.cod_domanda || param.cod_domanda == ''}">
	<c:set var="errdom" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Non si e' scelta la domanda di sicurezza.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${empty param.risposta}">
	<c:set var="errrisp" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omessa la risposta alla domanda di sicurezza.<br/>
	</c:set>
	<c:set var="errflag" value="true"/>
</c:if>

<c:if test="${errflag}">
	<jsp:forward page="PAZ_modificainfopaz.jsp"/>
</c:if>

<jsp:forward page="PAZ_confermamodificainfopaz.jsp"/>