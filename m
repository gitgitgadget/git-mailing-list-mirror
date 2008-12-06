From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] git-gui: Updated German translation
Date: Sat, 6 Dec 2008 21:23:10 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200812062123.11081.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_v8tOJXyP0uMKX0J"
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 06 21:29:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L93m6-0008Bd-5k
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 21:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbYLFU15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 15:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbYLFU15
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 15:27:57 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:38982 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbYLFU1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 15:27:55 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id mB6KRosE002310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 6 Dec 2008 21:27:50 +0100
Received: from [192.168.0.101] (e176221017.adsl.alicedsl.de [85.176.221.17])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id mB6KRm8g013400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Dec 2008 21:27:50 +0100
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102475>

--Boundary-00=_v8tOJXyP0uMKX0J
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached to avoid whitespace issues.

Regards,

Christian

--Boundary-00=_v8tOJXyP0uMKX0J
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-git-gui-Update-German-completed-translation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-git-gui-Update-German-completed-translation.patch"

=46rom 224db827d57b01e908b8b0594b6fa33d512d7ad4 Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Sat, 6 Dec 2008 21:22:16 +0100
Subject: [PATCH] git-gui: Update German (completed) translation.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
=2D--
 po/de.po |  279 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----=
=2D---
 1 files changed, 239 insertions(+), 40 deletions(-)

diff --git a/po/de.po b/po/de.po
index 5c04812..a6f730b 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -7,8 +7,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2008-10-25 13:32+0200\n"
=2D"PO-Revision-Date: 2008-10-25 22:47+0200\n"
+"POT-Creation-Date: 2008-12-06 20:51+0100\n"
+"PO-Revision-Date: 2008-12-06 21:22+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -86,17 +86,15 @@ msgstr "Dateistatus aktualisieren..."
 msgid "Scanning for modified files ..."
 msgstr "Nach ge=C3=A4nderten Dateien suchen..."
=20
=2D#: git-gui.sh:1325
=2D#, fuzzy
+#: git-gui.sh:1367
 msgid "Calling prepare-commit-msg hook..."
=2Dmsgstr "Aufrufen der Vor-Eintragen-Kontrolle..."
+msgstr "Aufrufen der Eintragen-Vorbereiten-Kontrolle..."
=20
=2D#: git-gui.sh:1342
=2D#, fuzzy
+#: git-gui.sh:1384
 msgid "Commit declined by prepare-commit-msg hook."
=2Dmsgstr "Eintragen abgelehnt durch Vor-Eintragen-Kontrolle (=C2=BBpre-com=
mit hook=C2=AB)."
+msgstr "Eintragen abgelehnt durch Eintragen-Vorbereiten-Kontrolle (=C2=BBp=
repare-commit hook=C2=AB)."
=20
=2D#: git-gui.sh:1502 lib/browser.tcl:246
+#: git-gui.sh:1542 lib/browser.tcl:246
 msgid "Ready."
 msgstr "Bereit."
=20
@@ -180,7 +178,11 @@ msgstr "Zusammenf=C3=BChren"
 msgid "Remote"
 msgstr "Andere Archive"
=20
=2D#: git-gui.sh:2242
+#: git-gui.sh:2293
+msgid "Tools"
+msgstr "Werkzeuge"
+
+#: git-gui.sh:2302
 msgid "Explore Working Copy"
 msgstr "Arbeitskopie im Dateimanager"
=20
@@ -363,7 +365,11 @@ msgstr "Einstellungen..."
 msgid "Options..."
 msgstr "Optionen..."
=20
=2D#: git-gui.sh:2113 lib/choose_repository.tcl:47
+#: git-gui.sh:2576
+msgid "Remove..."
+msgstr "Entfernen..."
+
+#: git-gui.sh:2585 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr "Hilfe"
=20
@@ -371,7 +377,11 @@ msgstr "Hilfe"
 msgid "Online Documentation"
 msgstr "Online-Dokumentation"
=20
=2D#: git-gui.sh:2238
+#: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.tcl:=
56
+msgid "Show SSH Key"
+msgstr "SSH-Schl=C3=BCssel anzeigen"
+
+#: git-gui.sh:2707
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
@@ -548,7 +558,11 @@ msgstr "Version:"
 msgid "Copy Commit"
 msgstr "Version kopieren"
=20
=2D#: lib/blame.tcl:260
+#: lib/blame.tcl:275
+msgid "Find Text..."
+msgstr "Text suchen..."
+
+#: lib/blame.tcl:284
 msgid "Do Full Copy Detection"
 msgstr "Volle Kopie-Erkennung"
=20
@@ -609,12 +623,11 @@ msgstr "Eintragender:"
 msgid "Original File:"
 msgstr "Urspr=C3=BCngliche Datei:"
=20
=2D#: lib/blame.tcl:1013
=2D#, fuzzy
+#: lib/blame.tcl:1021
 msgid "Cannot find HEAD commit:"
=2Dmsgstr "Elternversion kann nicht gefunden werden:"
+msgstr "Zweigspitze (=C2=BBHEAD=C2=AB) kann nicht gefunden werden:"
=20
=2D#: lib/blame.tcl:1068
+#: lib/blame.tcl:1076
 msgid "Cannot find parent commit:"
 msgstr "Elternversion kann nicht gefunden werden:"
=20
@@ -1049,7 +1062,7 @@ msgstr "Zuletzt benutztes Projektarchiv =C3=B6ffnen:"
 msgid "Failed to create repository %s:"
 msgstr "Projektarchiv =C2=BB%s=C2=AB konnte nicht erstellt werden:"
=20
=2D#: lib/choose_repository.tcl:381 lib/choose_repository.tcl:478
+#: lib/choose_repository.tcl:387
 msgid "Directory:"
 msgstr "Verzeichnis:"
=20
@@ -1058,12 +1071,12 @@ msgstr "Verzeichnis:"
 msgid "Git Repository"
 msgstr "Git Projektarchiv"
=20
=2D#: lib/choose_repository.tcl:437
+#: lib/choose_repository.tcl:442
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "Verzeichnis =C2=BB%s=C2=AB existiert bereits."
=20
=2D#: lib/choose_repository.tcl:441
+#: lib/choose_repository.tcl:446
 #, tcl-format
 msgid "File %s already exists."
 msgstr "Datei =C2=BB%s=C2=AB existiert bereits."
@@ -1072,11 +1085,11 @@ msgstr "Datei =C2=BB%s=C2=AB existiert bereits."
 msgid "Clone"
 msgstr "Klonen"
=20
=2D#: lib/choose_repository.tcl:467
+#: lib/choose_repository.tcl:473
 msgid "Source Location:"
=2Dmsgstr ""
+msgstr "Herkunft:"
=20
=2D#: lib/choose_repository.tcl:478
+#: lib/choose_repository.tcl:484
 msgid "Target Directory:"
 msgstr "Zielverzeichnis:"
=20
@@ -1565,20 +1578,24 @@ msgid ""
 "LOCAL: deleted\n"
 "REMOTE:\n"
 msgstr ""
+"LOKAL: gel=C3=B6scht\n"
+"ANDERES:\n"
=20
 #: lib/diff.tcl:125
 msgid ""
 "REMOTE: deleted\n"
 "LOCAL:\n"
 msgstr ""
+"ANDERES: gel=C3=B6scht\n"
+"LOKAL:\n"
=20
 #: lib/diff.tcl:132
 msgid "LOCAL:\n"
=2Dmsgstr ""
+msgstr "LOKAL:\n"
=20
 #: lib/diff.tcl:135
 msgid "REMOTE:\n"
=2Dmsgstr ""
+msgstr "ANDERES:\n"
=20
 #: lib/diff.tcl:197 lib/diff.tcl:296
 #, tcl-format
@@ -1603,6 +1620,8 @@ msgid ""
 "* Untracked file is %d bytes.\n"
 "* Showing only first %d bytes.\n"
 msgstr ""
+"* Datei nicht unter Versionskontrolle, Dateigr=C3=B6=C3=9Fe %d Bytes.\n"
+"* Nur erste %d Bytes werden angezeigt.\n"
=20
 #: lib/diff.tcl:228
 #, tcl-format
@@ -1611,8 +1630,11 @@ msgid ""
 "* Untracked file clipped here by %s.\n"
 "* To see the entire file, use an external editor.\n"
 msgstr ""
+"\n"
+"* Datei nicht unter Versionskontrolle, hier abgeschnitten durch %s.\n"
+"* Zum Ansehen der vollst=C3=A4ndigen Datei externen Editor benutzen.\n"
=20
=2D#: lib/diff.tcl:437
+#: lib/diff.tcl:436
 msgid "Failed to unstage selected hunk."
 msgstr ""
 "Fehler beim Herausnehmen des gew=C3=A4hlten Kontexts aus der Bereitstellu=
ng."
@@ -2045,7 +2067,7 @@ msgstr "Namensvorschlag f=C3=BCr neue Zweige"
=20
 #: lib/option.tcl:155
 msgid "Default File Contents Encoding"
=2Dmsgstr "Vorgestellte Zeichenkodierung"
+msgstr "Voreingestellte Zeichenkodierung"
=20
 #: lib/option.tcl:203
 msgid "Change"
@@ -2113,19 +2135,18 @@ msgid "Do Nothing Else Now"
 msgstr "Nichts tun"
=20
 #: lib/remote_add.tcl:101
=2D#, fuzzy
 msgid "Please supply a remote name."
=2Dmsgstr "Bitte geben Sie einen Zweignamen an."
+msgstr "Bitte geben Sie einen Namen des anderen Archivs an."
=20
 #: lib/remote_add.tcl:114
=2D#, fuzzy, tcl-format
+#, tcl-format
 msgid "'%s' is not an acceptable remote name."
=2Dmsgstr "=C2=BB%s=C2=AB ist kein zul=C3=A4ssiger Zweigname."
+msgstr "=C2=BB%s=C2=AB ist kein zul=C3=A4ssiger Name eines anderen Archivs=
=2E"
=20
 #: lib/remote_add.tcl:125
=2D#, fuzzy, tcl-format
+#, tcl-format
 msgid "Failed to add remote '%s' of location '%s'."
=2Dmsgstr "Fehler beim Umbenennen von =C2=BB%s=C2=AB."
+msgstr "Fehler beim Hinzuf=C3=BCgen des anderen Archivs =C2=BB%s=C2=AB aus=
 Herkunftsort =C2=BB%s=C2=AB."
=20
 #: lib/remote_add.tcl:133 lib/transport.tcl:6
 #, tcl-format
@@ -2133,16 +2154,18 @@ msgid "fetch %s"
 msgstr "=C2=BB%s=C2=AB anfordern"
=20
 #: lib/remote_add.tcl:134
=2D#, fuzzy, tcl-format
+#, tcl-format
 msgid "Fetching the %s"
=2Dmsgstr "=C3=84nderungen =C2=BB%s=C2=AB von =C2=BB%s=C2=AB anfordern"
+msgstr "=C2=BB%s=C2=AB anfordern"
=20
 #: lib/remote_add.tcl:157
 #, tcl-format
 msgid "Do not know how to initialize repository at location '%s'."
=2Dmsgstr "Initialisieren eines anderen Archivs an Adresse =C2=BB%s=C2=AB i=
st nicht m=C3=B6glich."
+msgstr ""
+"Initialisieren eines anderen Archivs an Adresse =C2=BB%s=C2=AB ist nicht =
m=C3=B6glich."
=20
=2D#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:71
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
+#: lib/transport.tcl:81
 #, tcl-format
 msgid "push %s"
 msgstr "=C2=BB%s=C2=AB versenden..."
@@ -2266,9 +2289,9 @@ msgstr "N=C3=A4chster"
 msgid "Prev"
 msgstr "Voriger"
=20
=2D#: lib/search.tcl:24
+#: lib/search.tcl:25
 msgid "Case-Sensitive"
=2Dmsgstr ""
+msgstr "Gro=C3=9F-/Kleinschreibung unterscheiden"
=20
 #: lib/shortcut.tcl:20 lib/shortcut.tcl:61
 msgid "Cannot write shortcut:"
@@ -2315,11 +2338,182 @@ msgstr "Unerwartetes EOF vom Rechtschreibpr=C3=BCf=
ungsprogramm"
 msgid "Spell Checker Failed"
 msgstr "Rechtschreibpr=C3=BCfung fehlgeschlagen"
=20
+#: lib/sshkey.tcl:31
+msgid "No keys found."
+msgstr "Keine Schl=C3=BCssel gefunden."
+
+#: lib/sshkey.tcl:34
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "=C3=96ffentlicher Schl=C3=BCssel gefunden in: %s"
+
+#: lib/sshkey.tcl:40
+msgid "Generate Key"
+msgstr "Schl=C3=BCssel erzeugen"
+
+#: lib/sshkey.tcl:56
+msgid "Copy To Clipboard"
+msgstr "In Zwischenablage kopieren"
+
+#: lib/sshkey.tcl:70
+msgid "Your OpenSSH Public Key"
+msgstr "Ihr OpenSSH =C3=B6ffenlicher Schl=C3=BCssel"
+
+#: lib/sshkey.tcl:78
+msgid "Generating..."
+msgstr "Erzeugen..."
+
+#: lib/sshkey.tcl:84
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"Konnte =C2=BBssh-keygen=C2=AB nicht starten:\n"
+"\n"
+"%s"
+
+#: lib/sshkey.tcl:111
+msgid "Generation failed."
+msgstr "Schl=C3=BCsselerzeugung fehlgeschlagen."
+
+#: lib/sshkey.tcl:118
+msgid "Generation succeded, but no keys found."
+msgstr "Schl=C3=BCsselerzeugung erfolgreich, aber keine Schl=C3=BCssel gef=
unden."
+
+#: lib/sshkey.tcl:121
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "Ihr Schl=C3=BCssel ist abgelegt in: %s"
+
 #: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%s ... %*i von %*i %s (%3i%%)"
=20
+#: lib/tools_dlg.tcl:22
+msgid "Add Tool"
+msgstr "Werkzeug hinzuf=C3=BCgen"
+
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "Neues Kommando f=C3=BCr Werkzeug hinzuf=C3=BCgen"
+
+#: lib/tools_dlg.tcl:33
+msgid "Add globally"
+msgstr "Global hinzuf=C3=BCgen"
+
+#: lib/tools_dlg.tcl:45
+msgid "Tool Details"
+msgstr "Einzelheiten des Werkzeugs"
+
+#: lib/tools_dlg.tcl:48
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "Benutzen Sie einen Schr=C3=A4gstrich =C2=BB/=C2=AB, um Untermen=C3=
=BCs zu erstellen:"
+
+#: lib/tools_dlg.tcl:61
+msgid "Command:"
+msgstr "Kommando:"
+
+#: lib/tools_dlg.tcl:74
+msgid "Show a dialog before running"
+msgstr "Best=C3=A4tigungsfrage vor Starten anzeigen"
+
+#: lib/tools_dlg.tcl:80
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "Benutzer nach Version fragen (setzt $REVISION)"
+
+#: lib/tools_dlg.tcl:85
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "Benutzer nach zus=C3=A4tzlichen Argumenten fragen (setzt $ARGS)"
+
+#: lib/tools_dlg.tcl:92
+msgid "Don't show the command output window"
+msgstr "Kein Ausgabefenster zeigen"
+
+#: lib/tools_dlg.tcl:97
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "Nur starten, wenn ein Vergleich gew=C3=A4hlt ist ($FILENAME ist ni=
cht leer)"
+
+#: lib/tools_dlg.tcl:121
+msgid "Please supply a name for the tool."
+msgstr "Bitte geben Sie einen Werkzeugnamen an."
+
+#: lib/tools_dlg.tcl:129
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "Werkzeug =C2=BB%s=C2=AB existiert bereits."
+
+#: lib/tools_dlg.tcl:151
+#, tcl-format
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr ""
+"Werkzeug konnte nicht hinzugef=C3=BCgt werden:\n"
+"\n"
+"%s"
+
+#: lib/tools_dlg.tcl:190
+msgid "Remove Tool"
+msgstr "Werkzeug entfernen"
+
+#: lib/tools_dlg.tcl:196
+msgid "Remove Tool Commands"
+msgstr "Werkzeugkommandos entfernen"
+
+#: lib/tools_dlg.tcl:200
+msgid "Remove"
+msgstr "Entfernen"
+
+#: lib/tools_dlg.tcl:236
+msgid "(Blue denotes repository-local tools)"
+msgstr "(Werkzeuge f=C3=BCr lokales Archiv werden in Blau angezeigt)"
+
+#: lib/tools_dlg.tcl:297
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "Kommando aufrufen: %s"
+
+#: lib/tools_dlg.tcl:311
+msgid "Arguments"
+msgstr "Argumente"
+
+#: lib/tools_dlg.tcl:348
+msgid "OK"
+msgstr "Ok"
+
+#: lib/tools.tcl:75
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "Um =C2=BB%s=C2=AB zu starten, muss eine Datei ausgew=C3=A4hlt sein=
=2E"
+
+#: lib/tools.tcl:90
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "Wollen Sie %s wirklich starten?"
+
+#: lib/tools.tcl:110
+#, tcl-format
+msgid "Tool: %s"
+msgstr "Werkzeug: %s"
+
+#: lib/tools.tcl:111
+#, tcl-format
+msgid "Running: %s"
+msgstr "Starten: %s"
+
+#: lib/tools.tcl:149
+#, tcl-format
+msgid "Tool completed succesfully: %s"
+msgstr "Werkzeug erfolgreich abgeschlossen: %s"
+
+#: lib/tools.tcl:151
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "Werkzeug fehlgeschlagen: %s"
+
 #: lib/transport.tcl:7
 #, tcl-format
 msgid "Fetching new changes from %s"
@@ -2340,7 +2534,12 @@ msgstr "=C3=9Cbernahmezweige aufr=C3=A4umen und entf=
ernen, die in =C2=BB%s=C2=AB gel=C3=B6scht wurde
 msgid "Pushing changes to %s"
 msgstr "=C3=84nderungen nach =C2=BB%s=C2=AB versenden"
=20
=2D#: lib/transport.tcl:72
+#: lib/transport.tcl:64
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "Spiegeln nach %s"
+
+#: lib/transport.tcl:82
 #, tcl-format
 msgid "Pushing %s %s to %s"
 msgstr "%s %s nach %s versenden"
=2D-=20
1.6.0.3.517.g759a


--Boundary-00=_v8tOJXyP0uMKX0J--
