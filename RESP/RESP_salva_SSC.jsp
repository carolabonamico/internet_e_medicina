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
<c:set var="ruolo_pagina" value="RESP"/>
<%@ include file="autorizzazione.jspf" %>

<c:if test="${empty param.studio}">
  <c:set var="errmsg" scope="request"> Il nome dello studio e' obbligatorio</c:set>
</c:if>

<!--=== setto a 10, ossia in stato di bozza===-->
<c:set var="stato_studio" value="10"/>
<c:set var="revisione" value="0"/>
<c:set var="visita" value="2"/>
<%-- CONTATORE --%>
<c:if test="${empty param.flag_mod}">
<sql:transaction>
  <sql:query var="rset_codice">
   SELECT VALORE
   FROM CONTATORI
   WHERE ATTRIBUTO = 'SSC'
  </sql:query>
  <c:set var="id_ssc" value="${rset_codice.rows[0].valore}"/>

  <sql:update>
   UPDATE CONTATORI set VALORE = VALORE + 1
   WHERE ATTRIBUTO = 'SSC'
  </sql:update>
</sql:transaction>
</c:if>

<!--parso le date-->
<c:if test="${not empty param.data_inizio}">
<fmt:parseDate  value="${param.data_inizio}"
                var="data_inizio"
                pattern="yyyy-MM-dd"/>
</c:if>

<c:if test="${not empty param.data_fine}">
<fmt:parseDate  value="${param.data_fine}"
                var="data_fine"
                pattern="yyyy-MM-dd"/>
</c:if>

<!-- inserisco i dati nel database-->
<c:choose>
  <c:when test="${empty param.flag_mod}">
  <sql:transaction>
    <sql:update>
      INSERT INTO SSC (ID_SSC)
      VALUES (?)
      <sql:param value="${id_ssc}"/>
    </sql:update>

    <c:if test="${not empty param.studio}">
      <sql:update>
        UPDATE SSC SET NOME_STUDIO = ?
        WHERE ID_SSC = ?
        <sql:param value="${param.studio}"/>
        <sql:param value="${id_ssc}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.descrizione}">
      <sql:update>
        UPDATE SSC SET DESCRIZIONE=?
        WHERE ID_SSC = ?
        <sql:param value="${param.descrizione}"/>
        <sql:param value="${id_ssc}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.area}">
      <sql:update>
        UPDATE SSC SET AREA_TERAPEUTICA=?
        WHERE ID_SSC = ?
        <sql:param value="${param.area}"/>
        <sql:param value="${id_ssc}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.popolazione}">
      <sql:update>
        UPDATE SSC SET POPOLAZIONE = ?
        WHERE ID_SSC= ?
        <sql:param value="${param.popolazione}"/>
        <sql:param value="${id_ssc}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty data_inizio}">
      <sql:update>
        UPDATE SSC SET DATA_INIZIO=?
        WHERE ID_SSC= ?
        <sql:dateParam value="${data_inizio}" type="date"/>
        <sql:param value="${id_ssc}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty data_fine}">
      <sql:update>
        UPDATE SSC SET DATA_FINE=?
        WHERE ID_SSC= ?
        <sql:dateParam value="${data_fine}" type="date"/>
        <sql:param value="${id_ssc}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.costo_stru}">
      <sql:update>
        UPDATE SSC SET COSTO_FISSO_STRUM=?
        WHERE ID_SSC= ?
        <sql:param value="${param.costo_stru}"/>
        <sql:param value="${id_ssc}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.costo_analisi}">
      <sql:update>
        UPDATE SSC SET COSTO_FISSO_ANALISI=?
        WHERE ID_SSC = ?
        <sql:param value="${param.costo_analisi}"/>
        <sql:param value="${id_ssc}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.incentivo}">
      <sql:update>
        UPDATE SSC SET INCENTIVO=?
        WHERE ID_SSC = ?
        <sql:param value="${param.incentivo}"/>
        <sql:param value="${id_ssc}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.totconv}">
      <sql:update>
        UPDATE SSC SET TOTCONV=?
        WHERE ID_SSC = ?
        <sql:param value="${param.totconv}"/>
        <sql:param value="${id_ssc}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.totpaz}">
      <sql:update>
        UPDATE SSC SET TOTPAZ=?
        WHERE ID_SSC = ?
        <sql:param value="${param.totpaz}"/>
        <sql:param value="${id_ssc}"/>
      </sql:update>
    </c:if>

    <sql:update>
      UPDATE SSC SET COD_STATO_STUDIO=?
      WHERE ID_SSC = ?
      <sql:param value="${stato_studio}"/>
      <sql:param value="${id_ssc}"/>
    </sql:update>

    <sql:update>
      UPDATE SSC SET ID_RESP=?
      WHERE ID_SSC = ?
      <sql:param value="${id_user}"/>
      <sql:param value="${id_ssc}"/>
    </sql:update>

    <sql:update>
      UPDATE SSC SET TOTPAZ_EFFETTIVI = 0
      WHERE ID_SSC = ?
      <sql:param value="${id_ssc}"/>
    </sql:update>

    <sql:update>
      UPDATE SSC SET RIVISTO = ?
      WHERE ID_SSC = ?
      <sql:param value="${revisione}"/>
      <sql:param value="${id_ssc}"/>
    </sql:update>

    <sql:update>
      UPDATE SSC SET VIS_MED = ?
      WHERE ID_SSC = ?
      <sql:param value="${visita}"/>
      <sql:param value="${id_ssc}"/>
    </sql:update>

  </sql:transaction>
</c:when><c:otherwise>
  <sql:transaction>
    <c:if test="${not empty param.studio}">
      <sql:update>
        UPDATE SSC SET NOME_STUDIO = ?
        WHERE ID_SSC = ?
        <sql:param value="${param.studio}"/>
        <sql:param value="${param.id_ssc_mod}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.descrizione}">
      <sql:update>
        UPDATE SSC SET DESCRIZIONE=?
        WHERE ID_SSC = ?
        <sql:param value="${param.descrizione}"/>
        <sql:param value="${param.id_ssc_mod}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.area}">
      <sql:update>
        UPDATE SSC SET AREA_TERAPEUTICA=?
        WHERE ID_SSC = ?
        <sql:param value="${param.area}"/>
        <sql:param value="${param.id_ssc_mod}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.popolazione}">
      <sql:update>
        UPDATE SSC SET POPOLAZIONE=?
        WHERE ID_SSC= ?
        <sql:param value="${param.popolazione}"/>
        <sql:param value="${param.id_ssc_mod}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty data_inizio}">
      <sql:update>
        UPDATE SSC SET DATA_INIZIO=?
        WHERE ID_SSC = ?
        <sql:dateParam value="${data_inizio}" type="date"/>
        <sql:param value="${param.id_ssc_mod}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty data_fine}">
      <sql:update>
        UPDATE SSC SET DATA_FINE=?
        WHERE ID_SSC = ?
        <sql:dateParam value="${data_fine}" type="date"/>
        <sql:param value="${param.id_ssc_mod}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.costo_stru}">
      <sql:update>
        UPDATE SSC SET COSTO_FISSO_STRUM=?
        WHERE ID_SSC = ?
        <sql:param value="${param.costo_stru}"/>
        <sql:param value="${param.id_ssc_mod}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.costo_analisi}">
      <sql:update>
        UPDATE SSC SET COSTO_FISSO_ANALISI=?
        WHERE ID_SSC = ?
        <sql:param value="${param.costo_analisi}"/>
        <sql:param value="${param.id_ssc_mod}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.incentivo}">
      <sql:update>
        UPDATE SSC SET INCENTIVO=?
        WHERE ID_SSC = ?
        <sql:param value="${param.incentivo}"/>
        <sql:param value="${param.id_ssc_mod}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.totconv}">
      <sql:update>
        UPDATE SSC SET TOTCONV=?
        WHERE ID_SSC = ?
        <sql:param value="${param.totconv}"/>
        <sql:param value="${param.id_ssc_mod}"/>
      </sql:update>
    </c:if>

    <c:if test="${not empty param.totpaz}">
      <sql:update>
        UPDATE SSC SET TOTPAZ=?
        WHERE ID_SSC = ?
        <sql:param value="${param.totpaz}"/>
        <sql:param value="${param.id_ssc_mod}"/>
      </sql:update>
    </c:if>

    <sql:update>
      UPDATE SSC SET COD_STATO_STUDIO=?
      WHERE ID_SSC = ?
      <sql:param value="${stato_studio}"/>
      <sql:param value="${param.id_ssc_mod}"/>
    </sql:update>

    <sql:update>
      UPDATE SSC SET ID_RESP=?
      WHERE ID_SSC = ?
      <sql:param value="${id_user}"/>
      <sql:param value="${param.id_ssc_mod}"/>
    </sql:update>
    </sql:transaction>
  </c:otherwise>
</c:choose>
<!-- controllo l'inserimento della ssc nel db -->

<sql:query var="ctrl_ok">
  SELECT ID_SSC
  FROM SSC
  WHERE ID_SSC=?
  OR ID_SSC=?
  <sql:param value="${id_ssc}"/>
  <sql:param value="${param.id_ssc_mod}"/>
</sql:query>

<c:if test="${not empty ctrl_ok.rows}">
    <c:set var="ok_msg" scope="request">La scheda e' stata salvata come bozza nel DB</c:set>
    <jsp:forward page="RESP_studi_pers_DEF.jsp"/>
</c:if>
