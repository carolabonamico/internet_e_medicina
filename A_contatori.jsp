<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<!-- PAGINA PER LA CREAZIONE DELLA TABELLA DEI CONTATORI 
(LA TABELLA E' SEPARATA E NON COLLEGATA ALLE ALTRE)-->

<sql:update>
DROP TABLE if exists CONTATORI
</sql:update>

<sql:update>
CREATE TABLE CONTATORI (
	ATTRIBUTO    VARCHAR(30) PRIMARY KEY,
	VALORE       NUMERIC(10)
)
</sql:update>

<!-- ===== DEVONO PARTIRE DA 1 E NON DA 0 ==== -->
<sql:update>
INSERT INTO CONTATORI VALUES ('ISCRIZIONI',    1)
</sql:update>