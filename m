From: sgala@marlow.memojo.com
Subject: [PATCH] Spanish translation of gitk.
Date: Mon, 24 Mar 2008 00:58:23 +0100
Message-ID: <1206316703-15481-1-git-send-email-sgala@apache.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santiago Gala <sgala@apache.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 01:32:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdabl-0001H5-S3
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 01:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757977AbYCXAb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 20:31:27 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757767AbYCXAb1
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 20:31:27 -0400
Received: from 233.Red-81-33-31.staticIP.rima-tde.net ([81.33.31.233]:2327
	"EHLO mail.hisitech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757479AbYCXAbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 20:31:25 -0400
X-Greylist: delayed 1876 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Mar 2008 20:31:24 EDT
Received: by mail.hisitech.com (Postfix, from userid 65534)
	id B1A9A15CC3F; Mon, 24 Mar 2008 01:00:06 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on
	webserver2.intranet.hisitech.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	NO_REAL_NAME autolearn=ham version=3.1.9
Received: from marlow.memojo.com (unknown [172.27.70.188])
	by mail.hisitech.com (Postfix) with SMTP id 984C815CCAF;
	Mon, 24 Mar 2008 00:58:20 +0100 (CET)
Received: by marlow.memojo.com (sSMTP sendmail emulation); Mon, 24 Mar 2008 00:58:23 +0100
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77983>

I copied the italian one and translated the strings from there,
it should be done now, unless I have missed some string.
---
 gitk-git/po/es.po |  890 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 890 insertions(+), 0 deletions(-)

diff --git a/gitk-git/po/es.po b/gitk-git/po/es.po
new file mode 100644
index 0000000..1e28f11
--- /dev/null
+++ b/gitk-git/po/es.po
@@ -0,0 +1,890 @@
+# Translation of gitk
+# Copyright (C) 2005-2008 Santiago Gala
+# This file is distributed under the same license as the gitk package.
+# Santiago Gala <santiago.gala@gmail.com>, 2008.
+#
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: gitk\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2008-03-13 17:29+0100\n"
+"PO-Revision-Date: 2008-03-13 17:34+0100\n"
+"Last-Translator: Santiago Gala <santiago.gala@gmail.com>\n"
+"Language-Team: Spanish\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: gitk:111
+msgid "Error executing git rev-list:"
+msgstr "Error al ejecutar git rev-list:"
+
+#: gitk:124
+msgid "Reading"
+msgstr "Leyendo"
+
+#: gitk:151 gitk:2191
+msgid "Reading commits..."
+msgstr "Leyendo revisiones..."
+
+#: gitk:275
+msgid "Can't parse git log output:"
+msgstr "No puedo analizar la salida de git log:"
+
+#: gitk:386 gitk:2195
+msgid "No commits selected"
+msgstr "No se seleccionaron revisiones"
+
+#: gitk:500
+msgid "No commit information available"
+msgstr "Falta informaci=C3=B3n sobre las revisiones"
+
+#: gitk:599 gitk:621 gitk:1955 gitk:6423 gitk:7923 gitk:8082
+msgid "OK"
+msgstr "Aceptar"
+
+#: gitk:623 gitk:1956 gitk:6107 gitk:6178 gitk:6275 gitk:6321 gitk:642=
5
+#: gitk:7924 gitk:8083
+msgid "Cancel"
+msgstr "Cancelar"
+
+#: gitk:661
+msgid "File"
+msgstr "Archivo"
+
+#: gitk:663
+msgid "Update"
+msgstr "Actualizar"
+
+#: gitk:664
+msgid "Reread references"
+msgstr "Releer referencias"
+
+#: gitk:665
+msgid "List references"
+msgstr "Lista de referencias"
+
+#: gitk:666
+msgid "Quit"
+msgstr "Salir"
+
+#: gitk:668
+msgid "Edit"
+msgstr "Editar"
+
+#: gitk:669
+msgid "Preferences"
+msgstr "Preferencias"
+
+#: gitk:672 gitk:1892
+msgid "View"
+msgstr "Vista"
+
+#: gitk:673
+msgid "New view..."
+msgstr "Nueva vista..."
+
+#: gitk:674 gitk:2133 gitk:8722
+msgid "Edit view..."
+msgstr "Modificar vista..."
+
+#: gitk:676 gitk:2134 gitk:8723
+msgid "Delete view"
+msgstr "Eliminar vista"
+
+#: gitk:678
+msgid "All files"
+msgstr "Todos los archivos"
+
+#: gitk:682
+msgid "Help"
+msgstr "Ayuda"
+
+#: gitk:683 gitk:1317
+msgid "About gitk"
+msgstr "Informaci=C3=B3n sobre gitk"
+
+#: gitk:684
+msgid "Key bindings"
+msgstr "Combinaciones de teclas"
+
+#: gitk:741
+msgid "SHA1 ID: "
+msgstr "SHA1 ID: "
+
+#: gitk:791
+msgid "Find"
+msgstr "Buscar"
+
+#: gitk:792
+msgid "next"
+msgstr "<<"
+
+#: gitk:793
+msgid "prev"
+msgstr ">>"
+
+#: gitk:794
+msgid "commit"
+msgstr "revisiones"
+
+#: gitk:797 gitk:799 gitk:2356 gitk:2379 gitk:2403 gitk:4306 gitk:4369
+msgid "containing:"
+msgstr "que contienen:"
+
+#: gitk:800 gitk:1778 gitk:1783 gitk:2431
+msgid "touching paths:"
+msgstr "que modifican path:"
+
+#: gitk:801 gitk:2436
+msgid "adding/removing string:"
+msgstr "que a=C3=B1aden/eliminan cadena:"
+
+#: gitk:810 gitk:812
+msgid "Exact"
+msgstr "Exacto"
+
+#: gitk:812 gitk:2514 gitk:4274
+msgid "IgnCase"
+msgstr "NoMay=C3=BAs"
+
+#: gitk:812 gitk:2405 gitk:2512 gitk:4270
+msgid "Regexp"
+msgstr "Regex"
+
+#: gitk:814 gitk:815 gitk:2533 gitk:2563 gitk:2570 gitk:4380 gitk:4436
+msgid "All fields"
+msgstr "Todos los campos"
+
+#: gitk:815 gitk:2531 gitk:2563 gitk:4336
+msgid "Headline"
+msgstr "T=C3=ADtulo"
+
+#: gitk:816 gitk:2531 gitk:4336 gitk:4436 gitk:4827
+msgid "Comments"
+msgstr "Comentarios"
+
+#: gitk:816 gitk:2531 gitk:2535 gitk:2570 gitk:4336 gitk:4763 gitk:595=
6
+#: gitk:5971
+msgid "Author"
+msgstr "Autor"
+
+#: gitk:816 gitk:2531 gitk:4336 gitk:4765
+msgid "Committer"
+msgstr ""
+
+#: gitk:845
+msgid "Search"
+msgstr "Buscar"
+
+#: gitk:852
+msgid "Diff"
+msgstr "Diferencia"
+
+#: gitk:854
+msgid "Old version"
+msgstr "Versi=C3=B3n ant=C3=ADgua"
+
+#: gitk:856
+msgid "New version"
+msgstr "Versi=C3=B3n Nueva"
+
+#: gitk:858
+msgid "Lines of context"
+msgstr "L=C3=ADneas de contexto"
+
+#: gitk:868
+msgid "Ignore space change"
+msgstr "Ignora cambios de espaciado"
+
+#: gitk:926
+msgid "Patch"
+msgstr "Parche"
+
+#: gitk:928
+msgid "Tree"
+msgstr "=C3=81rbol"
+
+#: gitk:1053 gitk:1068 gitk:6022
+msgid "Diff this -> selected"
+msgstr "Diff esta -> seleccionada"
+
+#: gitk:1055 gitk:1070 gitk:6023
+msgid "Diff selected -> this"
+msgstr "Diff seleccionada -> esta"
+
+#: gitk:1057 gitk:1072 gitk:6024
+msgid "Make patch"
+msgstr "Crea patch"
+
+#: gitk:1058 gitk:6162
+msgid "Create tag"
+msgstr "Crea etiqueta"
+
+#: gitk:1059 gitk:6255
+msgid "Write commit to file"
+msgstr "Escribir revisiones a archivo"
+
+#: gitk:1060 gitk:6309
+msgid "Create new branch"
+msgstr "Crear nueva rama"
+
+#: gitk:1061
+msgid "Cherry-pick this commit"
+msgstr "A=C3=B1ade esta revisi=C3=B3n a la rama actual (cherry-pick)"
+
+#: gitk:1063
+msgid "Reset HEAD branch to here"
+msgstr "Traer la rama HEAD aqu=C3=AD"
+
+#: gitk:1079
+msgid "Check out this branch"
+msgstr "Activar esta rama"
+
+#: gitk:1081
+msgid "Remove this branch"
+msgstr "Elimina esta rama"
+
+#: gitk:1087
+msgid "Highlight this too"
+msgstr "Seleccionar tambi=C3=A9n"
+
+#: gitk:1089
+msgid "Highlight this only"
+msgstr "Seleccionar s=C3=B3lo"
+
+#: gitk:1318
+msgid ""
+"\n"
+"Gitk - a commit viewer for git\n"
+"\n"
+"Copyright =C2=A9 2005-2006 Paul Mackerras\n"
+"\n"
+"Use and redistribute under the terms of the GNU General Public Licens=
e"
+msgstr ""
+"\n"
+"Gitk - un visualizador de revisiones para git\n"
+"\n"
+"Copyright =C2=A9 2005-2006 Paul Mackerras\n"
+"\n"
+"Uso y redistribuci=C3=B3n permitidos seg=C3=BAn los t=C3=A9rminos de =
la Licencia General P=C3=BAblica"
+"GNU"
+
+#: gitk:1326 gitk:1387 gitk:6581
+msgid "Close"
+msgstr "Cerrar"
+
+#: gitk:1345
+msgid "Gitk key bindings"
+msgstr "Combinaciones de tecla de Gitk"
+
+#: gitk:1347
+msgid "Gitk key bindings:"
+msgstr "Combinaciones de tecla de Gitk:"
+
+#: gitk:1349
+#, tcl-format
+msgid "<%s-Q>\t\tQuit"
+msgstr "<%s-Q>\t\tSalir"
+
+#: gitk:1350
+msgid "<Home>\t\tMove to first commit"
+msgstr "<Home>\t\tIr a la primera revisi=C3=B3n"
+
+#: gitk:1351
+msgid "<End>\t\tMove to last commit"
+msgstr "<End>\t\tIr a la =C3=BAltima revisi=C3=B3n"
+
+#: gitk:1352
+msgid "<Up>, p, i\tMove up one commit"
+msgstr "<Up>, p, i\tSubir una revisi=C3=B3n"
+
+#: gitk:1353
+msgid "<Down>, n, k\tMove down one commit"
+msgstr "<Down>, n, k\tBajar una revisi=C3=B3n"
+
+#: gitk:1354
+msgid "<Left>, z, j\tGo back in history list"
+msgstr "<Left>, z, j\tRetroceder en la historia"
+
+#: gitk:1355
+msgid "<Right>, x, l\tGo forward in history list"
+msgstr "<Right>, x, l\tAvanzar en la historia"
+
+#: gitk:1356
+msgid "<PageUp>\tMove up one page in commit list"
+msgstr "<PageUp>\tSubir una p=C3=A1gina en la lista de revisiones"
+
+#: gitk:1357
+msgid "<PageDown>\tMove down one page in commit list"
+msgstr "<PageDown>\tSubir una p=C3=A1gina en la lista de revisiones"
+
+#: gitk:1358
+#, tcl-format
+msgid "<%s-Home>\tScroll to top of commit list"
+msgstr "<%s-Home>\tDesplazarse al inicio de la lista de revisiones"
+
+#: gitk:1359
+#, tcl-format
+msgid "<%s-End>\tScroll to bottom of commit list"
+msgstr "<%s-End>\tDesplazarse al final de la lista de revisiones"
+
+#: gitk:1360
+#, tcl-format
+msgid "<%s-Up>\tScroll commit list up one line"
+msgstr "<%s-Up>\tDesplazarse una l=C3=ADnea arriba en la lista de revi=
siones"
+
+#: gitk:1361
+#, tcl-format
+msgid "<%s-Down>\tScroll commit list down one line"
+msgstr "<%s-Down>\tDesplazarse una l=C3=ADnea abajo en la lista de rev=
isiones"
+
+#: gitk:1362
+#, tcl-format
+msgid "<%s-PageUp>\tScroll commit list up one page"
+msgstr "<%s-PageUp>\tDesplaza hacia arriba una p=C3=A1gina la lista de=
 revisiones"
+
+#: gitk:1363
+#, tcl-format
+msgid "<%s-PageDown>\tScroll commit list down one page"
+msgstr "<%s-PageDown>\tDesplaza hacia abajo una p=C3=A1gina la lista d=
e revisiones"
+
+#: gitk:1364
+msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
+msgstr "<Shift-Up>\tBusca hacia atr=C3=A1s (ariba, revisiones siguient=
es)"
+
+#: gitk:1365
+msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
+msgstr "<Shift-Down>\tBuscar hacia adelante (abajo, revisiones anterio=
res)"
+
+#: gitk:1366
+msgid "<Delete>, b\tScroll diff view up one page"
+msgstr "<Delete>, b\tDesplaza hacia arriba una p=C3=A1gina la vista de=
 diferencias"
+
+#: gitk:1367
+msgid "<Backspace>\tScroll diff view up one page"
+msgstr "<Backspace>\tDesplaza hacia arriba una p=C3=A1gina la vista de=
 diferencias"
+
+#: gitk:1368
+msgid "<Space>\t\tScroll diff view down one page"
+msgstr "<Space>\t\tDesplaza hacia abajo una p=C3=A1gina la vista de di=
ferencias"
+
+#: gitk:1369
+msgid "u\t\tScroll diff view up 18 lines"
+msgstr "u\t\tDesplaza hacia arriba 18 l=C3=ADneas la vista de diferenc=
ias"
+
+#: gitk:1370
+msgid "d\t\tScroll diff view down 18 lines"
+msgstr "d\t\tDesplaza hacia abajo 18 l=C3=ADneas la vista de diferenci=
as"
+
+#: gitk:1371
+#, tcl-format
+msgid "<%s-F>\t\tFind"
+msgstr "<%s-F>\t\tBusca"
+
+#: gitk:1372
+#, tcl-format
+msgid "<%s-G>\t\tMove to next find hit"
+msgstr "<%s-G>\t\tBusca siguiente"
+
+#: gitk:1373
+msgid "<Return>\t\tMove to next find hit"
+msgstr "<Return>\t\tBusca siguiente"
+
+#: gitk:1374
+msgid "/\t\tMove to next find hit, or redo find"
+msgstr "/\t\tBusca siguiente, o vuelve a buscar"
+
+#: gitk:1375
+msgid "?\t\tMove to previous find hit"
+msgstr "?\t\tBusca anterior"
+
+#: gitk:1376
+msgid "f\t\tScroll diff view to next file"
+msgstr "f\t\tDesplazar la vista de diferencias al archivo siguiente"
+
+#: gitk:1377
+#, tcl-format
+msgid "<%s-S>\t\tSearch for next hit in diff view"
+msgstr "<%s-S>\t\tBuscar siguiente en la vista de diferencias"
+
+#: gitk:1378
+#, tcl-format
+msgid "<%s-R>\t\tSearch for previous hit in diff view"
+msgstr "<%s-R>\t\tBuscar anterior en la vista de diferencias"
+
+#: gitk:1379
+#, tcl-format
+msgid "<%s-KP+>\tIncrease font size"
+msgstr "<%s-KP+>\tMayor tama=C3=B1o de tipograf=C3=ADa"
+
+#: gitk:1380
+#, tcl-format
+msgid "<%s-plus>\tIncrease font size"
+msgstr "<%s-plus>\tMayor tama=C3=B1o de tipograf=C3=ADa"
+
+#: gitk:1381
+#, tcl-format
+msgid "<%s-KP->\tDecrease font size"
+msgstr "<%s-KP->\tMenor tama=C3=B1o de tipograf=C3=ADa"
+
+#: gitk:1382
+#, tcl-format
+msgid "<%s-minus>\tDecrease font size"
+msgstr "<%s-minus>\tMenor tama=C3=B1o de tipograf=C3=ADa"
+
+#: gitk:1383
+msgid "<F5>\t\tUpdate"
+msgstr "<F5>\t\tActualizar"
+
+#: gitk:1896
+msgid "Gitk view definition"
+msgstr "Definici=C3=B3n de vistas de Gitk"
+
+#: gitk:1921
+msgid "Name"
+msgstr "Nombre"
+
+#: gitk:1924
+msgid "Remember this view"
+msgstr "Recordar esta vista"
+
+#: gitk:1928
+msgid "Commits to include (arguments to git rev-list):"
+msgstr "Revisiones a incluir (argumentos a git rev-list):"
+
+#: gitk:1935
+msgid "Command to generate more commits to include:"
+msgstr "Comando que genera m=C3=A1s revisiones a incluir:"
+
+#: gitk:1942
+msgid "Enter files and directories to include, one per line:"
+msgstr "Insertar archivos y directorios a incluir, uno por l=C3=ADnea:=
"
+
+#: gitk:1989
+msgid "Error in commit selection arguments:"
+msgstr "Error en los argumentos de selecci=C3=B3n de las revisiones:"
+
+#: gitk:2043 gitk:2127 gitk:2583 gitk:2597 gitk:3781 gitk:8688 gitk:86=
89
+msgid "None"
+msgstr "Ninguno"
+
+#: gitk:2531 gitk:4336 gitk:5958 gitk:5973
+msgid "Date"
+msgstr "Fecha"
+
+#: gitk:2531 gitk:4336
+msgid "CDate"
+msgstr "Fecha de Creaci=C3=B3n"
+
+#: gitk:2680 gitk:2685
+msgid "Descendant"
+msgstr "Descendiente"
+
+#: gitk:2681
+msgid "Not descendant"
+msgstr "No descendiente"
+
+#: gitk:2688 gitk:2693
+msgid "Ancestor"
+msgstr "Antepasado"
+
+#: gitk:2689
+msgid "Not ancestor"
+msgstr "No antepasado"
+
+#: gitk:2924
+msgid "Local changes checked in to index but not committed"
+msgstr "Cambios locales, a=C3=B1adidos a =C3=ADndice y pendientes de c=
ommit"
+
+#: gitk:2954
+msgid "Local uncommitted changes, not checked in to index"
+msgstr "Cambios locales sin a=C3=B1adir a =C3=ADndice"
+
+#: gitk:4305
+msgid "Searching"
+msgstr "B=C3=BAscando"
+
+#: gitk:4767
+msgid "Tags:"
+msgstr "Etiquetas:"
+
+#: gitk:4784 gitk:4790 gitk:5951
+msgid "Parent"
+msgstr "Padre"
+
+#: gitk:4795
+msgid "Child"
+msgstr "Hija"
+
+#: gitk:4804
+msgid "Branch"
+msgstr "Rama"
+
+#: gitk:4807
+msgid "Follows"
+msgstr "Sigue a"
+
+#: gitk:4810
+msgid "Precedes"
+msgstr "Precede a"
+
+#: gitk:5093
+msgid "Error getting merge diffs:"
+msgstr "Error al leer las diferencias de fusi=C3=B3n:"
+
+#: gitk:5778
+msgid "Goto:"
+msgstr "Ir a:"
+
+#: gitk:5780
+msgid "SHA1 ID:"
+msgstr "SHA1 ID:"
+
+#: gitk:5805
+#, tcl-format
+msgid "Short SHA1 id %s is ambiguous"
+msgstr "La id SHA1 abreviada %s es ambigua"
+
+#: gitk:5817
+#, tcl-format
+msgid "SHA1 id %s is not known"
+msgstr "La id SHA1 %s es desconocida"
+
+#: gitk:5819
+#, tcl-format
+msgid "Tag/Head %s is not known"
+msgstr "La etiqueta/rama %s es deconocida"
+
+#: gitk:5961
+msgid "Children"
+msgstr "Hijos"
+
+#: gitk:6018
+#, tcl-format
+msgid "Reset %s branch to here"
+msgstr "Poner la rama %s en esta revisi=C3=B3n"
+
+#: gitk:6049
+msgid "Top"
+msgstr "Origen"
+
+#: gitk:6050
+msgid "From"
+msgstr "Da"
+
+#: gitk:6055
+msgid "To"
+msgstr "A"
+
+#: gitk:6078
+msgid "Generate patch"
+msgstr "Generar parche"
+
+#: gitk:6080
+msgid "From:"
+msgstr "Da:"
+
+#: gitk:6089
+msgid "To:"
+msgstr "A:"
+
+#: gitk:6098
+msgid "Reverse"
+msgstr "Invertido"
+
+#: gitk:6100 gitk:6269
+msgid "Output file:"
+msgstr "Escribir a archivo:"
+
+#: gitk:6106
+msgid "Generate"
+msgstr "Generar"
+
+#: gitk:6142
+msgid "Error creating patch:"
+msgstr "Error en la creaci=C3=B3n del parche:"
+
+#: gitk:6164 gitk:6257 gitk:6311
+msgid "ID:"
+msgstr "ID:"
+
+#: gitk:6173
+msgid "Tag name:"
+msgstr "Nombre de etiqueta:"
+
+#: gitk:6177 gitk:6320
+msgid "Create"
+msgstr "Crear"
+
+#: gitk:6192
+msgid "No tag name specified"
+msgstr "No se ha especificado etiqueta"
+
+#: gitk:6196
+#, tcl-format
+msgid "Tag \"%s\" already exists"
+msgstr "La etiqueta \"%s\" ya existe"
+
+#: gitk:6202
+msgid "Error creating tag:"
+msgstr "Error al crear la etiqueta:"
+
+#: gitk:6266
+msgid "Command:"
+msgstr "Comando:"
+
+#: gitk:6274
+msgid "Write"
+msgstr "Escribir"
+
+#: gitk:6290
+msgid "Error writing commit:"
+msgstr "Error al escribir revisi=C3=B3n:"
+
+#: gitk:6316
+msgid "Name:"
+msgstr "Nombre:"
+
+#: gitk:6335
+msgid "Please specify a name for the new branch"
+msgstr "Especifique un nombre para la nueva rama"
+
+#: gitk:6364
+#, tcl-format
+msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
+msgstr "La revisi=C3=B3n %s ya est=C3=A1 incluida en la rama %s -- =C2=
=BFVolver a aplicarla?"
+
+#: gitk:6369
+msgid "Cherry-picking"
+msgstr "Eligiendo revisiones (cherry-picking)"
+
+#: gitk:6381
+msgid "No changes committed"
+msgstr "No se han guardado cambios"
+
+#: gitk:6404
+msgid "Confirm reset"
+msgstr "Conferma git reset"
+
+#: gitk:6406
+#, tcl-format
+msgid "Reset branch %s to %s?"
+msgstr "=C2=BFReponer la rama %s a %s?"
+
+#: gitk:6410
+msgid "Reset type:"
+msgstr "Tipo de reposici=C3=B3n:"
+
+#: gitk:6414
+msgid "Soft: Leave working tree and index untouched"
+msgstr "Suave: No altera la copia de trabajo ni el =C3=ADndice"
+
+#: gitk:6417
+msgid "Mixed: Leave working tree untouched, reset index"
+msgstr "Mixta: Actualiza el =C3=ADndice, no altera la copia de trabajo=
"
+
+#: gitk:6420
+msgid ""
+"Hard: Reset working tree and index\n"
+"(discard ALL local changes)"
+msgstr ""
+"Dura: Actualiza el =C3=ADndice y la copia de trabajo\n"
+"(abandona TODAS las modificaciones locales)"
+
+#: gitk:6436
+msgid "Resetting"
+msgstr "Reponiendo"
+
+#: gitk:6493
+msgid "Checking out"
+msgstr "Creando copia de trabajo"
+
+#: gitk:6523
+msgid "Cannot delete the currently checked-out branch"
+msgstr "No se puede borrar la rama sobre la que se trabaja"
+
+#: gitk:6529
+#, tcl-format
+msgid ""
+"The commits on branch %s aren't on any other branch.\n"
+"Really delete branch %s?"
+msgstr ""
+"Las revisiones de la rama %s no est=C3=A1n presentes en otras ramas.\=
n"
+"=C2=BFBorrar la rama %s?"
+
+#: gitk:6560
+#, tcl-format
+msgid "Tags and heads: %s"
+msgstr "Etiquetas y ramas: %s"
+
+#: gitk:6574
+msgid "Filter"
+msgstr "Filtro"
+
+#: gitk:6868
+msgid ""
+"Error reading commit topology information; branch and preceding/follo=
wing "
+"tag information will be incomplete."
+msgstr ""
+"Error al leer la topolog=C3=ADa de revisiones: la informaci=C3=B3n so=
bre "
+"las ramas y etiquetas precedentes y siguientes sar=C3=A1 incompleta."
+
+#: gitk:7852
+msgid "Tag"
+msgstr "Etiqueta"
+
+#: gitk:7852
+msgid "Id"
+msgstr "Id"
+
+#: gitk:7892
+msgid "Gitk font chooser"
+msgstr "Selector de tipograf=C3=ADas gitk"
+
+#: gitk:7909
+msgid "B"
+msgstr "B"
+
+#: gitk:7912
+msgid "I"
+msgstr "I"
+
+#: gitk:8005
+msgid "Gitk preferences"
+msgstr "Preferencias gitk"
+
+#: gitk:8006
+msgid "Commit list display options"
+msgstr "Opciones de visualizaci=C3=B3n de la lista de revisiones"
+
+#: gitk:8009
+msgid "Maximum graph width (lines)"
+msgstr "Larghezza massima del grafico (in linee)"
+
+#: gitk:8013
+#, tcl-format
+msgid "Maximum graph width (% of pane)"
+msgstr "Larghezza massima del grafico (% del pannello)"
+
+#: gitk:8018
+msgid "Show local changes"
+msgstr "Mostra modifiche locali"
+
+#: gitk:8023
+msgid "Auto-select SHA1"
+msgstr "Seleziona automaticamente SHA1 hash"
+
+#: gitk:8028
+msgid "Diff display options"
+msgstr "Opciones de visualizaci=C3=B3n de diferencias"
+
+#: gitk:8030
+msgid "Tab spacing"
+msgstr "Espaciado de  tabulador"
+
+#: gitk:8034
+msgid "Display nearby tags"
+msgstr "Mostrar etiquetas cercanas"
+
+#: gitk:8039
+msgid "Limit diffs to listed paths"
+msgstr "Limita las diferencias a los path seleccionados"
+
+#: gitk:8044
+msgid "Colors: press to choose"
+msgstr "Colores: pulse para seleccionar"
+
+#: gitk:8047
+msgid "Background"
+msgstr "Fondo"
+
+#: gitk:8051
+msgid "Foreground"
+msgstr "Primer plano"
+
+#: gitk:8055
+msgid "Diff: old lines"
+msgstr "Diff: l=C3=ADneas viejas"
+
+#: gitk:8060
+msgid "Diff: new lines"
+msgstr "Diff: l=C3=ADneas nuevas"
+
+#: gitk:8065
+msgid "Diff: hunk header"
+msgstr "Diff: cabecera de fragmento"
+
+#: gitk:8071
+msgid "Select bg"
+msgstr "Seleccione color de fondo"
+
+#: gitk:8075
+msgid "Fonts: press to choose"
+msgstr "Tipograf=C3=ADas: pulse para elegir"
+
+#: gitk:8077
+msgid "Main font"
+msgstr "Tipograf=C3=ADa principal"
+
+#: gitk:8078
+msgid "Diff display font"
+msgstr "Tipograf=C3=ADa para diferencias"
+
+#: gitk:8079
+msgid "User interface font"
+msgstr "Tipograf=C3=ADa para interfaz de usuario"
+
+#: gitk:8095
+#, tcl-format
+msgid "Gitk: choose color for %s"
+msgstr "Gitk: elegir color para %s"
+
+#: gitk:8476
+msgid ""
+"Sorry, gitk cannot run with this version of Tcl/Tk.\n"
+" Gitk requires at least Tcl/Tk 8.4."
+msgstr ""
+"Esta versi=C3=B3n de Tcl/Tk es demasiado antigua.\n"
+" Gitk requiere Tcl/Tk versi=C3=B3n 8.4 o superior."
+
+#: gitk:8565
+msgid "Cannot find a git repository here."
+msgstr "No encuentro un repositorio git aqu=C3=AD."
+
+#: gitk:8569
+#, tcl-format
+msgid "Cannot find the git directory \"%s\"."
+msgstr "No encuentro el directorio git \"%s\"."
+
+#: gitk:8612
+#, tcl-format
+msgid "Ambiguous argument '%s': both revision and filename"
+msgstr "Argumento ambiguo: '%s' es tanto una revisi=C3=B3n como un nom=
bre de archivo"
+
+#: gitk:8624
+msgid "Bad arguments to gitk:"
+msgstr "Argumentos incorrectos a Gitk:"
+
+#: gitk:8636
+msgid "Couldn't get list of unmerged files:"
+msgstr "Imposible obtener la lista de archivos pendientes de mezcla:"
+
+#: gitk:8652
+msgid "No files selected: --merge specified but no files are unmerged.=
"
+msgstr ""
+"No hay archivos seleccionados: se seleccion=C3=B3 la opci=C3=B3n --me=
rge pero no hay "
+"archivos a falta de fusi=C3=B3nError al escribir revisi=C3=B3n:."
+
+#: gitk:8655
+msgid ""
+"No files selected: --merge specified but no unmerged files are within=
 file "
+"limit."
+msgstr ""
+"No hay archivos seleccionados: se seleccion=C3=B3 la opci=C3=B3n --me=
rge pero los archivos "
+"especificados no necesitan fusi=C3=B3n."
+
+#: gitk:8716
+msgid "Command line"
+msgstr "L=C3=ADnea de comandos"
--=20
1.5.4.4
