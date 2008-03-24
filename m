From: sgala@marlow.memojo.com
Subject: [PATCH] gitk: Changes in Spanish translation after review by Wincent Colaiuta
Date: Mon, 24 Mar 2008 17:37:52 +0100
Message-ID: <1206376672-7194-1-git-send-email-sgala@apache.org>
References: <1206316703-15481-1-git-send-email-sgala@apache.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santiago Gala <sgala@apache.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 17:39:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdphM-00021Q-IT
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 17:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979AbYCXQiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 12:38:16 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754886AbYCXQiQ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 12:38:16 -0400
Received: from 233.Red-81-33-31.staticIP.rima-tde.net ([81.33.31.233]:1260
	"EHLO mail.hisitech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754883AbYCXQiP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 12:38:15 -0400
Received: by mail.hisitech.com (Postfix, from userid 65534)
	id 4208315CC1D; Mon, 24 Mar 2008 17:38:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on
	webserver2.intranet.hisitech.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	NO_REAL_NAME autolearn=ham version=3.1.9
Received: from marlow.memojo.com (unknown [172.27.70.234])
	by mail.hisitech.com (Postfix) with SMTP id 997BF15C5E6;
	Mon, 24 Mar 2008 17:37:51 +0100 (CET)
Received: by marlow.memojo.com (sSMTP sendmail emulation); Mon, 24 Mar 2008 17:37:53 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1206316703-15481-1-git-send-email-sgala@apache.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78057>

Changes to Spanish translation after comments by Wincent Colaiuta
in the git list, see
http://thread.gmane.org/gmane.comp.version-control.git/77983/focus=3D78=
011

Signed-off-by: Santiago Gala <sgala@apache.org>
---
 gitk-git/po/es.po |  110 ++++++++++++++++++++++++++-------------------=
-------
 1 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/gitk-git/po/es.po b/gitk-git/po/es.po
index 1e28f11..8a60931 100644
--- a/gitk-git/po/es.po
+++ b/gitk-git/po/es.po
@@ -30,7 +30,7 @@ msgstr "Leyendo revisiones..."
=20
 #: gitk:275
 msgid "Can't parse git log output:"
-msgstr "No puedo analizar la salida de git log:"
+msgstr "Error analizando la salida de git log:"
=20
 #: gitk:386 gitk:2195
 msgid "No commits selected"
@@ -103,7 +103,7 @@ msgstr "Ayuda"
=20
 #: gitk:683 gitk:1317
 msgid "About gitk"
-msgstr "Informaci=C3=B3n sobre gitk"
+msgstr "Acerca de gitk"
=20
 #: gitk:684
 msgid "Key bindings"
@@ -127,19 +127,19 @@ msgstr ">>"
=20
 #: gitk:794
 msgid "commit"
-msgstr "revisiones"
+msgstr "revisi=C3=B3n"
=20
 #: gitk:797 gitk:799 gitk:2356 gitk:2379 gitk:2403 gitk:4306 gitk:4369
 msgid "containing:"
-msgstr "que contienen:"
+msgstr "que contiene:"
=20
 #: gitk:800 gitk:1778 gitk:1783 gitk:2431
 msgid "touching paths:"
-msgstr "que modifican path:"
+msgstr "que modifica path:"
=20
 #: gitk:801 gitk:2436
 msgid "adding/removing string:"
-msgstr "que a=C3=B1aden/eliminan cadena:"
+msgstr "que a=C3=B1ade/elimina cadena:"
=20
 #: gitk:810 gitk:812
 msgid "Exact"
@@ -184,11 +184,11 @@ msgstr "Diferencia"
=20
 #: gitk:854
 msgid "Old version"
-msgstr "Versi=C3=B3n ant=C3=ADgua"
+msgstr "Versi=C3=B3n antigua"
=20
 #: gitk:856
 msgid "New version"
-msgstr "Versi=C3=B3n Nueva"
+msgstr "Versi=C3=B3n nueva"
=20
 #: gitk:858
 msgid "Lines of context"
@@ -208,19 +208,19 @@ msgstr "=C3=81rbol"
=20
 #: gitk:1053 gitk:1068 gitk:6022
 msgid "Diff this -> selected"
-msgstr "Diff esta -> seleccionada"
+msgstr "Diferencia de esta -> seleccionada"
=20
 #: gitk:1055 gitk:1070 gitk:6023
 msgid "Diff selected -> this"
-msgstr "Diff seleccionada -> esta"
+msgstr "Diferencia de seleccionada -> esta"
=20
 #: gitk:1057 gitk:1072 gitk:6024
 msgid "Make patch"
-msgstr "Crea patch"
+msgstr "Crear patch"
=20
 #: gitk:1058 gitk:6162
 msgid "Create tag"
-msgstr "Crea etiqueta"
+msgstr "Crear etiqueta"
=20
 #: gitk:1059 gitk:6255
 msgid "Write commit to file"
@@ -232,7 +232,7 @@ msgstr "Crear nueva rama"
=20
 #: gitk:1061
 msgid "Cherry-pick this commit"
-msgstr "A=C3=B1ade esta revisi=C3=B3n a la rama actual (cherry-pick)"
+msgstr "A=C3=B1adir esta revisi=C3=B3n a la rama actual (cherry-pick)"
=20
 #: gitk:1063
 msgid "Reset HEAD branch to here"
@@ -244,7 +244,7 @@ msgstr "Activar esta rama"
=20
 #: gitk:1081
 msgid "Remove this branch"
-msgstr "Elimina esta rama"
+msgstr "Eliminar esta rama"
=20
 #: gitk:1087
 msgid "Highlight this too"
@@ -268,8 +268,8 @@ msgstr ""
 "\n"
 "Copyright =C2=A9 2005-2006 Paul Mackerras\n"
 "\n"
-"Uso y redistribuci=C3=B3n permitidos seg=C3=BAn los t=C3=A9rminos de =
la Licencia General P=C3=BAblica"
-"GNU"
+"Uso y redistribuci=C3=B3n permitidos seg=C3=BAn los t=C3=A9rminos de =
la Licencia P=C3=BAblica General de "
+"GNU (GNU GPL)"
=20
 #: gitk:1326 gitk:1387 gitk:6581
 msgid "Close"
@@ -318,7 +318,7 @@ msgstr "<PageUp>\tSubir una p=C3=A1gina en la lista=
 de revisiones"
=20
 #: gitk:1357
 msgid "<PageDown>\tMove down one page in commit list"
-msgstr "<PageDown>\tSubir una p=C3=A1gina en la lista de revisiones"
+msgstr "<PageDown>\tBajar una p=C3=A1gina en la lista de revisiones"
=20
 #: gitk:1358
 #, tcl-format
@@ -333,26 +333,26 @@ msgstr "<%s-End>\tDesplazarse al final de la list=
a de revisiones"
 #: gitk:1360
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
-msgstr "<%s-Up>\tDesplazarse una l=C3=ADnea arriba en la lista de revi=
siones"
+msgstr "<%s-Up>\tDesplazar una l=C3=ADnea hacia arriba la lista de rev=
isiones"
=20
 #: gitk:1361
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
-msgstr "<%s-Down>\tDesplazarse una l=C3=ADnea abajo en la lista de rev=
isiones"
+msgstr "<%s-Down>\tDesplazar una l=C3=ADnea hacia abajo la lista de re=
visiones"
=20
 #: gitk:1362
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
-msgstr "<%s-PageUp>\tDesplaza hacia arriba una p=C3=A1gina la lista de=
 revisiones"
+msgstr "<%s-PageUp>\tDesplazar una p=C3=A1gina hacia arriba la lista d=
e revisiones"
=20
 #: gitk:1363
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
-msgstr "<%s-PageDown>\tDesplaza hacia abajo una p=C3=A1gina la lista d=
e revisiones"
+msgstr "<%s-PageDown>\tDesplazar una p=C3=A1gina hacia abajo la lista =
de revisiones"
=20
 #: gitk:1364
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
-msgstr "<Shift-Up>\tBusca hacia atr=C3=A1s (ariba, revisiones siguient=
es)"
+msgstr "<Shift-Up>\tBuscar hacia atr=C3=A1s (ariba, revisiones siguien=
tes)"
=20
 #: gitk:1365
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
@@ -381,24 +381,24 @@ msgstr "d\t\tDesplaza hacia abajo 18 l=C3=ADneas =
la vista de diferencias"
 #: gitk:1371
 #, tcl-format
 msgid "<%s-F>\t\tFind"
-msgstr "<%s-F>\t\tBusca"
+msgstr "<%s-F>\t\tBuscar"
=20
 #: gitk:1372
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
-msgstr "<%s-G>\t\tBusca siguiente"
+msgstr "<%s-G>\t\tBuscar siguiente"
=20
 #: gitk:1373
 msgid "<Return>\t\tMove to next find hit"
-msgstr "<Return>\t\tBusca siguiente"
+msgstr "<Return>\t\tBuscar siguiente"
=20
 #: gitk:1374
 msgid "/\t\tMove to next find hit, or redo find"
-msgstr "/\t\tBusca siguiente, o vuelve a buscar"
+msgstr "/\t\tBuscar siguiente, o volver a buscar"
=20
 #: gitk:1375
 msgid "?\t\tMove to previous find hit"
-msgstr "?\t\tBusca anterior"
+msgstr "?\t\tBuscar anterior"
=20
 #: gitk:1376
 msgid "f\t\tScroll diff view to next file"
@@ -417,22 +417,22 @@ msgstr "<%s-R>\t\tBuscar anterior en la vista de =
diferencias"
 #: gitk:1379
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
-msgstr "<%s-KP+>\tMayor tama=C3=B1o de tipograf=C3=ADa"
+msgstr "<%s-KP+>\tAumentar tama=C3=B1o del texto"
=20
 #: gitk:1380
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
-msgstr "<%s-plus>\tMayor tama=C3=B1o de tipograf=C3=ADa"
+msgstr "<%s-plus>\tAumentar tama=C3=B1o del texto"
=20
 #: gitk:1381
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
-msgstr "<%s-KP->\tMenor tama=C3=B1o de tipograf=C3=ADa"
+msgstr "<%s-KP->\tDisminuir tama=C3=B1o del texto"
=20
 #: gitk:1382
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
-msgstr "<%s-minus>\tMenor tama=C3=B1o de tipograf=C3=ADa"
+msgstr "<%s-minus>\tDisminuir tama=C3=B1o del texto"
=20
 #: gitk:1383
 msgid "<F5>\t\tUpdate"
@@ -460,7 +460,7 @@ msgstr "Comando que genera m=C3=A1s revisiones a in=
cluir:"
=20
 #: gitk:1942
 msgid "Enter files and directories to include, one per line:"
-msgstr "Insertar archivos y directorios a incluir, uno por l=C3=ADnea:=
"
+msgstr "Introducir archivos y directorios a incluir, uno por l=C3=ADne=
a:"
=20
 #: gitk:1989
 msgid "Error in commit selection arguments:"
@@ -476,7 +476,7 @@ msgstr "Fecha"
=20
 #: gitk:2531 gitk:4336
 msgid "CDate"
-msgstr "Fecha de Creaci=C3=B3n"
+msgstr "Fecha de creaci=C3=B3n"
=20
 #: gitk:2680 gitk:2685
 msgid "Descendant"
@@ -496,15 +496,15 @@ msgstr "No antepasado"
=20
 #: gitk:2924
 msgid "Local changes checked in to index but not committed"
-msgstr "Cambios locales, a=C3=B1adidos a =C3=ADndice y pendientes de c=
ommit"
+msgstr "Cambios locales a=C3=B1adidos al =C3=ADndice pero sin completa=
r revisi=C3=B3n"
=20
 #: gitk:2954
 msgid "Local uncommitted changes, not checked in to index"
-msgstr "Cambios locales sin a=C3=B1adir a =C3=ADndice"
+msgstr "Cambios locales sin a=C3=B1adir al =C3=ADndice"
=20
 #: gitk:4305
 msgid "Searching"
-msgstr "B=C3=BAscando"
+msgstr "Buscando"
=20
 #: gitk:4767
 msgid "Tags:"
@@ -524,11 +524,11 @@ msgstr "Rama"
=20
 #: gitk:4807
 msgid "Follows"
-msgstr "Sigue a"
+msgstr "Sigue-a"
=20
 #: gitk:4810
 msgid "Precedes"
-msgstr "Precede a"
+msgstr "Precede-a"
=20
 #: gitk:5093
 msgid "Error getting merge diffs:"
@@ -559,7 +559,7 @@ msgstr "La etiqueta/rama %s es deconocida"
=20
 #: gitk:5961
 msgid "Children"
-msgstr "Hijos"
+msgstr "Hijas"
=20
 #: gitk:6018
 #, tcl-format
@@ -572,7 +572,7 @@ msgstr "Origen"
=20
 #: gitk:6050
 msgid "From"
-msgstr "Da"
+msgstr "De"
=20
 #: gitk:6055
 msgid "To"
@@ -584,7 +584,7 @@ msgstr "Generar parche"
=20
 #: gitk:6080
 msgid "From:"
-msgstr "Da:"
+msgstr "De:"
=20
 #: gitk:6089
 msgid "To:"
@@ -666,7 +666,7 @@ msgstr "No se han guardado cambios"
=20
 #: gitk:6404
 msgid "Confirm reset"
-msgstr "Conferma git reset"
+msgstr "Confirmar git reset"
=20
 #: gitk:6406
 #, tcl-format
@@ -703,7 +703,7 @@ msgstr "Creando copia de trabajo"
=20
 #: gitk:6523
 msgid "Cannot delete the currently checked-out branch"
-msgstr "No se puede borrar la rama sobre la que se trabaja"
+msgstr "No se puede borrar la rama actual"
=20
 #: gitk:6529
 #, tcl-format
@@ -729,7 +729,7 @@ msgid ""
 "tag information will be incomplete."
 msgstr ""
 "Error al leer la topolog=C3=ADa de revisiones: la informaci=C3=B3n so=
bre "
-"las ramas y etiquetas precedentes y siguientes sar=C3=A1 incompleta."
+"las ramas y etiquetas precedentes y siguientes ser=C3=A1 incompleta."
=20
 #: gitk:7852
 msgid "Tag"
@@ -753,7 +753,7 @@ msgstr "I"
=20
 #: gitk:8005
 msgid "Gitk preferences"
-msgstr "Preferencias gitk"
+msgstr "Preferencias de gitk"
=20
 #: gitk:8006
 msgid "Commit list display options"
@@ -761,20 +761,20 @@ msgstr "Opciones de visualizaci=C3=B3n de la list=
a de revisiones"
=20
 #: gitk:8009
 msgid "Maximum graph width (lines)"
-msgstr "Larghezza massima del grafico (in linee)"
+msgstr "Ancho m=C3=A1ximo del gr=C3=A1fico (en l=C3=ADneas)"
=20
 #: gitk:8013
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
-msgstr "Larghezza massima del grafico (% del pannello)"
+msgstr "Ancho m=C3=A1ximo del gr=C3=A1fico (en % del panel)"
=20
 #: gitk:8018
 msgid "Show local changes"
-msgstr "Mostra modifiche locali"
+msgstr "Mostrar cambios locales"
=20
 #: gitk:8023
 msgid "Auto-select SHA1"
-msgstr "Seleziona automaticamente SHA1 hash"
+msgstr "Seleccionar autom=C3=A1ticamente SHA1 hash"
=20
 #: gitk:8028
 msgid "Diff display options"
@@ -782,7 +782,7 @@ msgstr "Opciones de visualizaci=C3=B3n de diferenci=
as"
=20
 #: gitk:8030
 msgid "Tab spacing"
-msgstr "Espaciado de  tabulador"
+msgstr "Espaciado de tabulador"
=20
 #: gitk:8034
 msgid "Display nearby tags"
@@ -818,7 +818,7 @@ msgstr "Diff: cabecera de fragmento"
=20
 #: gitk:8071
 msgid "Select bg"
-msgstr "Seleccione color de fondo"
+msgstr "Color de fondo de la selecci=C3=B3n"
=20
 #: gitk:8075
 msgid "Fonts: press to choose"
@@ -851,12 +851,12 @@ msgstr ""
=20
 #: gitk:8565
 msgid "Cannot find a git repository here."
-msgstr "No encuentro un repositorio git aqu=C3=AD."
+msgstr "No hay un repositorio git aqu=C3=AD."
=20
 #: gitk:8569
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
-msgstr "No encuentro el directorio git \"%s\"."
+msgstr "No hay el directorio git \"%s\"."
=20
 #: gitk:8612
 #, tcl-format
@@ -869,13 +869,13 @@ msgstr "Argumentos incorrectos a Gitk:"
=20
 #: gitk:8636
 msgid "Couldn't get list of unmerged files:"
-msgstr "Imposible obtener la lista de archivos pendientes de mezcla:"
+msgstr "Imposible obtener la lista de archivos pendientes de fusi=C3=B3=
n:"
=20
 #: gitk:8652
 msgid "No files selected: --merge specified but no files are unmerged.=
"
 msgstr ""
 "No hay archivos seleccionados: se seleccion=C3=B3 la opci=C3=B3n --me=
rge pero no hay "
-"archivos a falta de fusi=C3=B3nError al escribir revisi=C3=B3n:."
+"archivos pendientes de fusi=C3=B3n."
=20
 #: gitk:8655
 msgid ""
--=20
1.5.4.4
