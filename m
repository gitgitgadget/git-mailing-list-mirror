From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [Gitk PATCH 5/6] gitk: regenerated po files
Date: Tue,  7 Oct 2008 23:56:48 +0200
Message-ID: <1223416609-18864-6-git-send-email-robin.rosenberg@dewire.com>
References: <1223416609-18864-1-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-2-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-3-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-4-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-5-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: speace@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 08 00:00:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnKbE-0003He-Gw
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 00:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472AbYJGV63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 17:58:29 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755603AbYJGV62
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 17:58:28 -0400
Received: from av7-2-sn3.vrr.skanova.net ([81.228.9.182]:43709 "EHLO
	av7-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069AbYJGV6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 17:58:09 -0400
Received: by av7-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 847D338427; Tue,  7 Oct 2008 23:58:07 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av7-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 3E1DF38423; Tue,  7 Oct 2008 23:58:07 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id E257B37E43;
	Tue,  7 Oct 2008 23:58:06 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
In-Reply-To: <1223416609-18864-5-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97752>

make update-po

Also unmade all new "fuzzy" tags

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 po/de.po |   92 +++++++++++++++++++++++++++++++++++++-----------------=
-------
 po/es.po |   92 +++++++++++++++++++++++++++++++++++++-----------------=
-------
 po/it.po |   92 +++++++++++++++++++++++++++++++++++++-----------------=
-------
 po/sv.po |   92 +++++++++++++++++++++++++++++++++++++-----------------=
-------
 4 files changed, 224 insertions(+), 144 deletions(-)

diff --git a/po/de.po b/po/de.po
index af18389..aea76a7 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7,7 +7,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-10-07 23:06+0200\n"
+"POT-Creation-Date: 2008-10-07 23:08+0200\n"
 "PO-Revision-Date: 2008-05-24 22:40+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
@@ -67,67 +67,67 @@ msgid "Cancel"
 msgstr "Abbrechen"
=20
 #: gitk:1798
-msgid "File"
+msgid "&File"
 msgstr "Datei"
=20
 #: gitk:1800
-msgid "Update"
+msgid "&Update"
 msgstr "Aktualisieren"
=20
 #: gitk:1801
-msgid "Reload"
+msgid "&Reload"
 msgstr "Neu laden"
=20
 #: gitk:1802
-msgid "Reread references"
+msgid "R&eread references"
 msgstr "Zweige neu laden"
=20
 #: gitk:1803
-msgid "List references"
+msgid "&List references"
 msgstr "Zweige/Markierungen auflisten"
=20
 #: gitk:1804
-msgid "Quit"
+msgid "&Quit"
 msgstr "Beenden"
=20
 #: gitk:1806
-msgid "Edit"
+msgid "&Edit"
 msgstr "Bearbeiten"
=20
 #: gitk:1807
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "Einstellungen"
=20
-#: gitk:1810 gitk:3193
-msgid "View"
+#: gitk:1810
+msgid "&View"
 msgstr "Ansicht"
=20
 #: gitk:1811
-msgid "New view..."
+msgid "&New view..."
 msgstr "Neue Ansicht..."
=20
 #: gitk:1812
-msgid "Edit view..."
+msgid "&Edit view..."
 msgstr "Ansicht bearbeiten..."
=20
 #: gitk:1814
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "Ansicht l=C3=B6schen"
=20
 #: gitk:1816
-msgid "All files"
+msgid "&All files"
 msgstr "Alle Dateien"
=20
 #: gitk:1820
-msgid "Help"
+msgid "&Help"
 msgstr "Hilfe"
=20
-#: gitk:1821 gitk:2484
-msgid "About gitk"
+#: gitk:1821
+msgid "&About gitk"
 msgstr "=C3=9Cber gitk"
=20
 #: gitk:1822
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "Tastenk=C3=BCrzel"
=20
 #: gitk:1879
@@ -232,61 +232,65 @@ msgid "Tree"
 msgstr "Baum"
=20
 #: gitk:2204 gitk:2219
-msgid "Diff this -> selected"
+msgid "Diff &this -> selected"
 msgstr "Vergleich diese -> gew=C3=A4hlte"
=20
 #: gitk:2206 gitk:2221
-msgid "Diff selected -> this"
+msgid "Diff &selected -> this"
 msgstr "Vergleich gew=C3=A4hlte -> diese"
=20
 #: gitk:2208 gitk:2223
-msgid "Make patch"
+msgid "&Make patch"
 msgstr "Patch erstellen"
=20
-#: gitk:2209 gitk:7458
-msgid "Create tag"
+#: gitk:2209
+msgid "Create ta&g"
 msgstr "Markierung erstellen"
=20
-#: gitk:2210 gitk:7557
-msgid "Write commit to file"
+#: gitk:2210
+msgid "&Write commit to file"
 msgstr "Version in Datei schreiben"
=20
-#: gitk:2211 gitk:7611
-msgid "Create new branch"
+#: gitk:2211
+msgid "Create new &branch"
 msgstr "Neuen Zweig erstellen"
=20
 #: gitk:2212
-msgid "Cherry-pick this commit"
+msgid "C&herry-pick this commit"
 msgstr "Diese Version pfl=C3=BCcken"
=20
 #: gitk:2214
-msgid "Reset HEAD branch to here"
+msgid "&Reset HEAD branch to here"
 msgstr "HEAD-Zweig auf diese Version zur=C3=BCcksetzen"
=20
 #: gitk:2230
-msgid "Check out this branch"
+msgid "Check &out this branch"
 msgstr "Auf diesen Zweig umstellen"
=20
 #: gitk:2232
-msgid "Remove this branch"
+msgid "Re&move this branch"
 msgstr "Zweig l=C3=B6schen"
=20
 #: gitk:2238
-msgid "Highlight this too"
+msgid "Highlight this &too"
 msgstr "Diesen auch hervorheben"
=20
 #: gitk:2240
-msgid "Highlight this only"
+msgid "Highlight this &only"
 msgstr "Nur diesen hervorheben"
=20
 #: gitk:2242
-msgid "External diff"
+msgid "E&xternal diff"
 msgstr "Externer Vergleich"
=20
 #: gitk:2244
-msgid "Blame parent commit"
+msgid "&Blame parent commit"
 msgstr ""
=20
+#: gitk:2484
+msgid "About gitk"
+msgstr "=C3=9Cber gitk"
+
 #: gitk:2485
 msgid ""
 "\n"
@@ -476,6 +480,10 @@ msgstr "<F5>\t\tAktualisieren"
 msgid "No such commit"
 msgstr "Keine =C3=84nderungen eingetragen"
=20
+#: gitk:3193
+msgid "View"
+msgstr "Ansicht"
+
 #: gitk:3197
 msgid "Gitk view definition"
 msgstr "Gitk Ansichten"
@@ -648,6 +656,10 @@ msgstr "Erzeugen"
 msgid "Error creating patch:"
 msgstr "Fehler beim Patch erzeugen:"
=20
+#: gitk:7458
+msgid "Create tag"
+msgstr "Markierung erstellen"
+
 #: gitk:7460 gitk:7559 gitk:7613
 msgid "ID:"
 msgstr "ID:"
@@ -673,6 +685,10 @@ msgstr "Markierung =C2=BB%s=C2=AB existiert bereit=
s."
 msgid "Error creating tag:"
 msgstr "Fehler bei Markierung erstellen:"
=20
+#: gitk:7557
+msgid "Write commit to file"
+msgstr "Version in Datei schreiben"
+
 #: gitk:7568
 msgid "Command:"
 msgstr "Kommando:"
@@ -685,6 +701,10 @@ msgstr "Schreiben"
 msgid "Error writing commit:"
 msgstr "Fehler beim Schreiben der Version:"
=20
+#: gitk:7611
+msgid "Create new branch"
+msgstr "Neuen Zweig erstellen"
+
 #: gitk:7618
 msgid "Name:"
 msgstr "Name:"
diff --git a/po/es.po b/po/es.po
index 620eebd..a8d142f 100644
--- a/po/es.po
+++ b/po/es.po
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: gitk\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-10-07 23:06+0200\n"
+"POT-Creation-Date: 2008-10-07 23:08+0200\n"
 "PO-Revision-Date: 2008-03-25 11:20+0100\n"
 "Last-Translator: Santiago Gala <santiago.gala@gmail.com>\n"
 "Language-Team: Spanish\n"
@@ -69,68 +69,68 @@ msgid "Cancel"
 msgstr "Cancelar"
=20
 #: gitk:1798
-msgid "File"
+msgid "&File"
 msgstr "Archivo"
=20
 #: gitk:1800
-msgid "Update"
+msgid "&Update"
 msgstr "Actualizar"
=20
 #: gitk:1801
 #, fuzzy
-msgid "Reload"
+msgid "&Reload"
 msgstr "Leyendo"
=20
 #: gitk:1802
-msgid "Reread references"
+msgid "R&eread references"
 msgstr "Releer referencias"
=20
 #: gitk:1803
-msgid "List references"
+msgid "&List references"
 msgstr "Lista de referencias"
=20
 #: gitk:1804
-msgid "Quit"
+msgid "&Quit"
 msgstr "Salir"
=20
 #: gitk:1806
-msgid "Edit"
+msgid "&Edit"
 msgstr "Editar"
=20
 #: gitk:1807
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "Preferencias"
=20
-#: gitk:1810 gitk:3193
-msgid "View"
+#: gitk:1810
+msgid "&View"
 msgstr "Vista"
=20
 #: gitk:1811
-msgid "New view..."
+msgid "&New view..."
 msgstr "Nueva vista..."
=20
 #: gitk:1812
-msgid "Edit view..."
+msgid "&Edit view..."
 msgstr "Modificar vista..."
=20
 #: gitk:1814
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "Eliminar vista"
=20
 #: gitk:1816
-msgid "All files"
+msgid "&All files"
 msgstr "Todos los archivos"
=20
 #: gitk:1820
-msgid "Help"
+msgid "&Help"
 msgstr "Ayuda"
=20
-#: gitk:1821 gitk:2484
-msgid "About gitk"
+#: gitk:1821
+msgid "&About gitk"
 msgstr "Acerca de gitk"
=20
 #: gitk:1822
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "Combinaciones de teclas"
=20
 #: gitk:1879
@@ -235,61 +235,65 @@ msgid "Tree"
 msgstr "=C3=81rbol"
=20
 #: gitk:2204 gitk:2219
-msgid "Diff this -> selected"
+msgid "Diff &this -> selected"
 msgstr "Diferencia de esta -> seleccionada"
=20
 #: gitk:2206 gitk:2221
-msgid "Diff selected -> this"
+msgid "Diff &selected -> this"
 msgstr "Diferencia de seleccionada -> esta"
=20
 #: gitk:2208 gitk:2223
-msgid "Make patch"
+msgid "&Make patch"
 msgstr "Crear patch"
=20
-#: gitk:2209 gitk:7458
-msgid "Create tag"
+#: gitk:2209
+msgid "Create ta&g"
 msgstr "Crear etiqueta"
=20
-#: gitk:2210 gitk:7557
-msgid "Write commit to file"
+#: gitk:2210
+msgid "&Write commit to file"
 msgstr "Escribir revisiones a archivo"
=20
-#: gitk:2211 gitk:7611
-msgid "Create new branch"
+#: gitk:2211
+msgid "Create new &branch"
 msgstr "Crear nueva rama"
=20
 #: gitk:2212
-msgid "Cherry-pick this commit"
+msgid "C&herry-pick this commit"
 msgstr "A=C3=B1adir esta revisi=C3=B3n a la rama actual (cherry-pick)"
=20
 #: gitk:2214
-msgid "Reset HEAD branch to here"
+msgid "&Reset HEAD branch to here"
 msgstr "Traer la rama HEAD aqu=C3=AD"
=20
 #: gitk:2230
-msgid "Check out this branch"
+msgid "Check &out this branch"
 msgstr "Cambiar a esta rama"
=20
 #: gitk:2232
-msgid "Remove this branch"
+msgid "Re&move this branch"
 msgstr "Eliminar esta rama"
=20
 #: gitk:2238
-msgid "Highlight this too"
+msgid "Highlight this &too"
 msgstr "Seleccionar tambi=C3=A9n"
=20
 #: gitk:2240
-msgid "Highlight this only"
+msgid "Highlight this &only"
 msgstr "Seleccionar s=C3=B3lo"
=20
 #: gitk:2242
-msgid "External diff"
+msgid "E&xternal diff"
 msgstr ""
=20
 #: gitk:2244
-msgid "Blame parent commit"
+msgid "&Blame parent commit"
 msgstr ""
=20
+#: gitk:2484
+msgid "About gitk"
+msgstr "Acerca de gitk"
+
 #: gitk:2485
 #, fuzzy
 msgid ""
@@ -480,6 +484,10 @@ msgstr "<F5>\t\tActualizar"
 msgid "No such commit"
 msgstr "No se han guardado cambios"
=20
+#: gitk:3193
+msgid "View"
+msgstr "Vista"
+
 #: gitk:3197
 msgid "Gitk view definition"
 msgstr "Definici=C3=B3n de vistas de Gitk"
@@ -653,6 +661,10 @@ msgstr "Generar"
 msgid "Error creating patch:"
 msgstr "Error en la creaci=C3=B3n del parche:"
=20
+#: gitk:7458
+msgid "Create tag"
+msgstr "Crear etiqueta"
+
 #: gitk:7460 gitk:7559 gitk:7613
 msgid "ID:"
 msgstr "ID:"
@@ -678,6 +690,10 @@ msgstr "La etiqueta \"%s\" ya existe"
 msgid "Error creating tag:"
 msgstr "Error al crear la etiqueta:"
=20
+#: gitk:7557
+msgid "Write commit to file"
+msgstr "Escribir revisiones a archivo"
+
 #: gitk:7568
 msgid "Command:"
 msgstr "Comando:"
@@ -690,6 +706,10 @@ msgstr "Escribir"
 msgid "Error writing commit:"
 msgstr "Error al escribir revisi=C3=B3n:"
=20
+#: gitk:7611
+msgid "Create new branch"
+msgstr "Crear nueva rama"
+
 #: gitk:7618
 msgid "Name:"
 msgstr "Nombre:"
diff --git a/po/it.po b/po/it.po
index 15efe29..2406ac2 100644
--- a/po/it.po
+++ b/po/it.po
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: gitk\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-10-07 23:06+0200\n"
+"POT-Creation-Date: 2008-10-07 23:08+0200\n"
 "PO-Revision-Date: 2008-03-13 17:34+0100\n"
 "Last-Translator: Michele Ballabio <barra_cuda@katamail.com>\n"
 "Language-Team: Italian\n"
@@ -69,68 +69,68 @@ msgid "Cancel"
 msgstr "Annulla"
=20
 #: gitk:1798
-msgid "File"
+msgid "&File"
 msgstr "File"
=20
 #: gitk:1800
-msgid "Update"
+msgid "&Update"
 msgstr "Aggiorna"
=20
 #: gitk:1801
 #, fuzzy
-msgid "Reload"
+msgid "&Reload"
 msgstr "Lettura in corso"
=20
 #: gitk:1802
-msgid "Reread references"
+msgid "R&eread references"
 msgstr "Rileggi riferimenti"
=20
 #: gitk:1803
-msgid "List references"
+msgid "&List references"
 msgstr "Elenca riferimenti"
=20
 #: gitk:1804
-msgid "Quit"
+msgid "&Quit"
 msgstr "Esci"
=20
 #: gitk:1806
-msgid "Edit"
+msgid "&Edit"
 msgstr "Modifica"
=20
 #: gitk:1807
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "Preferenze"
=20
-#: gitk:1810 gitk:3193
-msgid "View"
+#: gitk:1810
+msgid "&View"
 msgstr "Vista"
=20
 #: gitk:1811
-msgid "New view..."
+msgid "&New view..."
 msgstr "Nuova vista..."
=20
 #: gitk:1812
-msgid "Edit view..."
+msgid "&Edit view..."
 msgstr "Modifica vista..."
=20
 #: gitk:1814
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "Elimina vista"
=20
 #: gitk:1816
-msgid "All files"
+msgid "&All files"
 msgstr "Tutti i file"
=20
 #: gitk:1820
-msgid "Help"
+msgid "&Help"
 msgstr "Aiuto"
=20
-#: gitk:1821 gitk:2484
-msgid "About gitk"
+#: gitk:1821
+msgid "&About gitk"
 msgstr "Informazioni su gitk"
=20
 #: gitk:1822
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "Scorciatoie da tastiera"
=20
 #: gitk:1879
@@ -235,61 +235,65 @@ msgid "Tree"
 msgstr "Directory"
=20
 #: gitk:2204 gitk:2219
-msgid "Diff this -> selected"
+msgid "Diff &this -> selected"
 msgstr "Diff questo -> selezionato"
=20
 #: gitk:2206 gitk:2221
-msgid "Diff selected -> this"
+msgid "Diff &selected -> this"
 msgstr "Diff selezionato -> questo"
=20
 #: gitk:2208 gitk:2223
-msgid "Make patch"
+msgid "&Make patch"
 msgstr "Crea patch"
=20
-#: gitk:2209 gitk:7458
-msgid "Create tag"
+#: gitk:2209
+msgid "Create ta&g"
 msgstr "Crea etichetta"
=20
-#: gitk:2210 gitk:7557
-msgid "Write commit to file"
+#: gitk:2210
+msgid "&Write commit to file"
 msgstr "Scrivi revisione in un file"
=20
-#: gitk:2211 gitk:7611
-msgid "Create new branch"
+#: gitk:2211
+msgid "Create new &branch"
 msgstr "Crea un nuovo ramo"
=20
 #: gitk:2212
-msgid "Cherry-pick this commit"
+msgid "C&herry-pick this commit"
 msgstr "Porta questa revisione in cima al ramo attuale"
=20
 #: gitk:2214
-msgid "Reset HEAD branch to here"
+msgid "&Reset HEAD branch to here"
 msgstr "Aggiorna il ramo HEAD a questa revisione"
=20
 #: gitk:2230
-msgid "Check out this branch"
+msgid "Check &out this branch"
 msgstr "Attiva questo ramo"
=20
 #: gitk:2232
-msgid "Remove this branch"
+msgid "Re&move this branch"
 msgstr "Elimina questo ramo"
=20
 #: gitk:2238
-msgid "Highlight this too"
+msgid "Highlight this &too"
 msgstr "Evidenzia anche questo"
=20
 #: gitk:2240
-msgid "Highlight this only"
+msgid "Highlight this &only"
 msgstr "Evidenzia solo questo"
=20
 #: gitk:2242
-msgid "External diff"
+msgid "E&xternal diff"
 msgstr ""
=20
 #: gitk:2244
-msgid "Blame parent commit"
+msgid "&Blame parent commit"
 msgstr ""
=20
+#: gitk:2484
+msgid "About gitk"
+msgstr "Informazioni su gitk"
+
 #: gitk:2485
 #, fuzzy
 msgid ""
@@ -480,6 +484,10 @@ msgstr "<F5>\t\tAggiorna"
 msgid "No such commit"
 msgstr "Nessuna modifica archiviata"
=20
+#: gitk:3193
+msgid "View"
+msgstr "Vista"
+
 #: gitk:3197
 msgid "Gitk view definition"
 msgstr "Scelta vista Gitk"
@@ -653,6 +661,10 @@ msgstr "Genera"
 msgid "Error creating patch:"
 msgstr "Errore nella creazione della patch:"
=20
+#: gitk:7458
+msgid "Create tag"
+msgstr "Crea etichetta"
+
 #: gitk:7460 gitk:7559 gitk:7613
 msgid "ID:"
 msgstr "ID:"
@@ -678,6 +690,10 @@ msgstr "L'etichetta \"%s\" esiste gi=C3=A0"
 msgid "Error creating tag:"
 msgstr "Errore nella creazione dell'etichetta:"
=20
+#: gitk:7557
+msgid "Write commit to file"
+msgstr "Scrivi revisione in un file"
+
 #: gitk:7568
 msgid "Command:"
 msgstr "Comando:"
@@ -690,6 +706,10 @@ msgstr "Scrivi"
 msgid "Error writing commit:"
 msgstr "Errore nella scrittura della revisione:"
=20
+#: gitk:7611
+msgid "Create new branch"
+msgstr "Crea un nuovo ramo"
+
 #: gitk:7618
 msgid "Name:"
 msgstr "Nome:"
diff --git a/po/sv.po b/po/sv.po
index 85b65dd..c1c3ed2 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: sv\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-10-07 23:06+0200\n"
+"POT-Creation-Date: 2008-10-07 23:08+0200\n"
 "PO-Revision-Date: 2008-08-03 19:03+0200\n"
 "Last-Translator: Mikael Magnusson <mikachu@gmail.com>\n"
 "Language-Team: Swedish <sv@li.org>\n"
@@ -68,67 +68,67 @@ msgid "Cancel"
 msgstr "Avbryt"
=20
 #: gitk:1798
-msgid "File"
+msgid "&File"
 msgstr "Arkiv"
=20
 #: gitk:1800
-msgid "Update"
+msgid "&Update"
 msgstr "Uppdatera"
=20
 #: gitk:1801
-msgid "Reload"
+msgid "&Reload"
 msgstr "Ladda om"
=20
 #: gitk:1802
-msgid "Reread references"
+msgid "R&eread references"
 msgstr "L=C3=A4s om referenser"
=20
 #: gitk:1803
-msgid "List references"
+msgid "&List references"
 msgstr "Visa referenser"
=20
 #: gitk:1804
-msgid "Quit"
+msgid "&Quit"
 msgstr "Avsluta"
=20
 #: gitk:1806
-msgid "Edit"
+msgid "&Edit"
 msgstr "Redigera"
=20
 #: gitk:1807
-msgid "Preferences"
+msgid "&Preferences"
 msgstr "Inst=C3=A4llningar"
=20
-#: gitk:1810 gitk:3193
-msgid "View"
+#: gitk:1810
+msgid "&View"
 msgstr "Visa"
=20
 #: gitk:1811
-msgid "New view..."
+msgid "&New view..."
 msgstr "Ny vy..."
=20
 #: gitk:1812
-msgid "Edit view..."
+msgid "&Edit view..."
 msgstr "=C3=84ndra vy..."
=20
 #: gitk:1814
-msgid "Delete view"
+msgid "&Delete view"
 msgstr "Ta bort vy"
=20
 #: gitk:1816
-msgid "All files"
+msgid "&All files"
 msgstr "Alla filer"
=20
 #: gitk:1820
-msgid "Help"
+msgid "&Help"
 msgstr "Hj=C3=A4lp"
=20
-#: gitk:1821 gitk:2484
-msgid "About gitk"
+#: gitk:1821
+msgid "&About gitk"
 msgstr "Om gitk"
=20
 #: gitk:1822
-msgid "Key bindings"
+msgid "&Key bindings"
 msgstr "Tangentbordsbindningar"
=20
 #: gitk:1879
@@ -233,61 +233,65 @@ msgid "Tree"
 msgstr "Tr=C3=A4d"
=20
 #: gitk:2204 gitk:2219
-msgid "Diff this -> selected"
+msgid "Diff &this -> selected"
 msgstr "Diff denna -> markerad"
=20
 #: gitk:2206 gitk:2221
-msgid "Diff selected -> this"
+msgid "Diff &selected -> this"
 msgstr "Diff markerad -> denna"
=20
 #: gitk:2208 gitk:2223
-msgid "Make patch"
+msgid "&Make patch"
 msgstr "Skapa patch"
=20
-#: gitk:2209 gitk:7458
-msgid "Create tag"
+#: gitk:2209
+msgid "Create ta&g"
 msgstr "Skapa tagg"
=20
-#: gitk:2210 gitk:7557
-msgid "Write commit to file"
+#: gitk:2210
+msgid "&Write commit to file"
 msgstr "Skriv incheckning till fil"
=20
-#: gitk:2211 gitk:7611
-msgid "Create new branch"
+#: gitk:2211
+msgid "Create new &branch"
 msgstr "Skapa ny gren"
=20
 #: gitk:2212
-msgid "Cherry-pick this commit"
+msgid "C&herry-pick this commit"
 msgstr "Plocka denna incheckning"
=20
 #: gitk:2214
-msgid "Reset HEAD branch to here"
+msgid "&Reset HEAD branch to here"
 msgstr "=C3=85terst=C3=A4ll HEAD-grenen hit"
=20
 #: gitk:2230
-msgid "Check out this branch"
+msgid "Check &out this branch"
 msgstr "Checka ut denna gren"
=20
 #: gitk:2232
-msgid "Remove this branch"
+msgid "Re&move this branch"
 msgstr "Ta bort denna gren"
=20
 #: gitk:2238
-msgid "Highlight this too"
+msgid "Highlight this &too"
 msgstr "Markera =C3=A4ven detta"
=20
 #: gitk:2240
-msgid "Highlight this only"
+msgid "Highlight this &only"
 msgstr "Markera bara detta"
=20
 #: gitk:2242
-msgid "External diff"
+msgid "E&xternal diff"
 msgstr "Extern diff"
=20
 #: gitk:2244
-msgid "Blame parent commit"
+msgid "&Blame parent commit"
 msgstr ""
=20
+#: gitk:2484
+msgid "About gitk"
+msgstr "Om gitk"
+
 #: gitk:2485
 msgid ""
 "\n"
@@ -476,6 +480,10 @@ msgstr "<F5>\t\tUppdatera"
 msgid "No such commit"
 msgstr "Inga =C3=A4ndringar incheckade"
=20
+#: gitk:3193
+msgid "View"
+msgstr "Visa"
+
 #: gitk:3197
 msgid "Gitk view definition"
 msgstr "Definition av Gitk-vy"
@@ -648,6 +656,10 @@ msgstr "Generera"
 msgid "Error creating patch:"
 msgstr "Fel vid generering av patch:"
=20
+#: gitk:7458
+msgid "Create tag"
+msgstr "Skapa tagg"
+
 #: gitk:7460 gitk:7559 gitk:7613
 msgid "ID:"
 msgstr "Id:"
@@ -673,6 +685,10 @@ msgstr "Taggen \"%s\" finns redan"
 msgid "Error creating tag:"
 msgstr "Fel vid skapande av tagg:"
=20
+#: gitk:7557
+msgid "Write commit to file"
+msgstr "Skriv incheckning till fil"
+
 #: gitk:7568
 msgid "Command:"
 msgstr "Kommando:"
@@ -685,6 +701,10 @@ msgstr "Skriv"
 msgid "Error writing commit:"
 msgstr "Fel vid skrivning av incheckning:"
=20
+#: gitk:7611
+msgid "Create new branch"
+msgstr "Skapa ny gren"
+
 #: gitk:7618
 msgid "Name:"
 msgstr "Namn:"
--=20
1.6.0.2.308.gef4a
