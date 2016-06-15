From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 08/15] German translation for git-gui
Date: Sun, 2 Sep 2007 17:34:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021733460.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1827328118-1188750843=:28586"
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:34:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsPU-0005TT-LY
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131AbXIBQes (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933051AbXIBQes
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:34:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:43510 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932102AbXIBQep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:34:45 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:34:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 02 Sep 2007 18:34:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/h70h2npLhX0qxf92TMK3/Ygk129darom8GpIZ7A
	bvLiOTwaYmQU3j
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57356>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1827328118-1188750843=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


From: Christian Stimming <stimming@tuhh.de>

Signed-off-by: Christian Stimming <stimming@tuhh.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/de.po | 1398 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1398 insertions(+), 0 deletions(-)
 create mode 100644 po/de.po

diff --git a/po/de.po b/po/de.po
new file mode 100644
index 0000000..7d57dd1
--- /dev/null
+++ b/po/de.po
@@ -0,0 +1,1398 @@
+# Translation of git-gui to German.
+# Copyright (C) 2007 Shawn Pearce, et al.
+# This file is distributed under the same license as the git package.
+# Christian Stimming <stimming@tuhh.de>, 2007
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-08-11 17:28+0200\n"
+"PO-Revision-Date: 2007-08-11 17:37+0200\n"
+"Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
+"Language-Team: German\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: git-gui.sh:531
+msgid "Cannot find git in PATH."
+msgstr "Git kann im PATH nicht gefunden werden."
+
+#: git-gui.sh:550
+msgid "Cannot parse Git version string:"
+msgstr "Git Versionsangabe kann nicht erkannt werden:"
+
+#: git-gui.sh:567
+#, tcl-format
+msgid ""
+"Git version cannot be determined.\n"
+"\n"
+"%s claims it is version '%s'.\n"
+"\n"
+"%s requires at least Git 1.5.0 or later.\n"
+"\n"
+"Assume '%s' is version 1.5.0?\n"
+msgstr ""
+"Die Version von Git kann nicht bestimmt werden.\n"
+"\n"
+"»%s« behauptet, es sei Version »%s«.\n"
+"\n"
+"%s benötigt mindestens Git 1.5.0 oder höher.\n"
+"\n"
+"Soll angenommen werden, »%s« sei Version 1.5.0?\n"
+
+#: git-gui.sh:689
+msgid "Cannot find the git directory:"
+msgstr "Git-Verzeichnis kann nicht gefunden werden:"
+
+#: git-gui.sh:697
+msgid "Git directory not found:"
+msgstr "Git-Verzeichnis nicht gefunden:"
+
+#: git-gui.sh:703
+msgid "Cannot use funny .git directory:"
+msgstr "Unerwartete Struktur des .git Verzeichnis:"
+
+#: git-gui.sh:708
+msgid "No working directory"
+msgstr "Kein Arbeitsverzeichnis"
+
+#: git-gui.sh:854
+msgid "Refreshing file status..."
+msgstr "Dateistatus aktualisieren..."
+
+#: git-gui.sh:891
+msgid "Scanning for modified files ..."
+msgstr "Nach geänderten Dateien suchen..."
+
+#: git-gui.sh:1057 lib/browser.tcl:247
+msgid "Ready."
+msgstr "Bereit."
+
+#: git-gui.sh:1322
+msgid "Unmodified"
+msgstr "Unverändert"
+
+#: git-gui.sh:1324
+msgid "Modified, not staged"
+msgstr "Verändert, nicht bereitgestellt"
+
+#: git-gui.sh:1325 git-gui.sh:1330
+msgid "Staged for commit"
+msgstr "Bereitgestellt zur Übertragung"
+
+#: git-gui.sh:1326 git-gui.sh:1331
+msgid "Portions staged for commit"
+msgstr "Teilweise bereitgestellt zur Übertragung"
+
+#: git-gui.sh:1327 git-gui.sh:1332
+msgid "Staged for commit, missing"
+msgstr "Bereitgestellt zur Übertragung, fehlend"
+
+#: git-gui.sh:1329
+msgid "Untracked, not staged"
+msgstr "Nicht unter Versionskontrolle, nicht bereitgestellt"
+
+#: git-gui.sh:1334
+msgid "Missing"
+msgstr "Fehlend"
+
+#: git-gui.sh:1335
+msgid "Staged for removal"
+msgstr "Bereitgestellt zum Löschen"
+
+#: git-gui.sh:1336
+msgid "Staged for removal, still present"
+msgstr "Bereitgestellt zum Löschen, trotzdem vorhanden"
+
+#: git-gui.sh:1338 git-gui.sh:1339 git-gui.sh:1340 git-gui.sh:1341
+msgid "Requires merge resolution"
+msgstr "Konfliktauflösung nötig"
+
+#: git-gui.sh:1383
+msgid "Starting gitk... please wait..."
+msgstr "Gitk wird gestartet... bitte warten."
+
+#: git-gui.sh:1392
+#, tcl-format
+msgid ""
+"Unable to start gitk:\n"
+"\n"
+"%s does not exist"
+msgstr ""
+"Gitk kann nicht gestartet werden:\n"
+"\n"
+"%s existiert nicht"
+
+#: git-gui.sh:1609
+#, tcl-format
+msgid "Invalid font specified in gui.%s:"
+msgstr "Ungültige Zeichensatz-Angabe in gui.%s:"
+
+#: git-gui.sh:1634
+msgid "Main Font"
+msgstr "Programmschriftart"
+
+#: git-gui.sh:1635
+msgid "Diff/Console Font"
+msgstr "Vergleich-Schriftart"
+
+#: git-gui.sh:1649
+msgid "Repository"
+msgstr "Projektarchiv"
+
+#: git-gui.sh:1650
+msgid "Edit"
+msgstr "Bearbeiten"
+
+#: git-gui.sh:1652
+msgid "Branch"
+msgstr "Zweig"
+
+#: git-gui.sh:1655 git-gui.sh:1842 git-gui.sh:2152
+msgid "Commit"
+msgstr "Übertragen"
+
+#: git-gui.sh:1658 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+msgid "Merge"
+msgstr "Zusammenführen"
+
+#: git-gui.sh:1659
+msgid "Fetch"
+msgstr "Anfordern"
+
+#: git-gui.sh:1660 git-gui.sh:2158 lib/transport.tcl:88 lib/transport.tcl:172
+msgid "Push"
+msgstr "Ausliefern"
+
+#: git-gui.sh:1669
+msgid "Browse Current Branch's Files"
+msgstr "Aktuellen Zweig durchblättern"
+
+#: git-gui.sh:1673
+msgid "Browse Branch Files..."
+msgstr "Einen Zweig durchblättern..."
+
+#: git-gui.sh:1678
+msgid "Visualize Current Branch's History"
+msgstr "Aktuellen Zweig darstellen"
+
+#: git-gui.sh:1682
+msgid "Visualize All Branch History"
+msgstr "Alle Zweige darstellen"
+
+#: git-gui.sh:1689
+#, tcl-format
+msgid "Browse %s's Files"
+msgstr "Zweig »%s« durchblättern"
+
+#: git-gui.sh:1691
+#, tcl-format
+msgid "Visualize %s's History"
+msgstr "Historie von »%s« darstellen"
+
+#: git-gui.sh:1696 lib/database.tcl:27 lib/database.tcl:67
+msgid "Database Statistics"
+msgstr "Datenbankstatistik"
+
+#: git-gui.sh:1699 lib/database.tcl:34
+msgid "Compress Database"
+msgstr "Datenbank komprimieren"
+
+#: git-gui.sh:1702
+msgid "Verify Database"
+msgstr "Datenbank überprüfen"
+
+#: git-gui.sh:1709 git-gui.sh:1713 git-gui.sh:1717 lib/shortcut.tcl:9
+#: lib/shortcut.tcl:45 lib/shortcut.tcl:84
+msgid "Create Desktop Icon"
+msgstr "Desktop-Icon erstellen"
+
+#: git-gui.sh:1722
+msgid "Quit"
+msgstr "Beenden"
+
+#: git-gui.sh:1729
+msgid "Undo"
+msgstr "Rückgängig"
+
+#: git-gui.sh:1732
+msgid "Redo"
+msgstr "Wiederholen"
+
+#: git-gui.sh:1736 git-gui.sh:2222
+msgid "Cut"
+msgstr "Ausschneiden"
+
+#: git-gui.sh:1739 git-gui.sh:2225 git-gui.sh:2296 git-gui.sh:2368
+#: lib/console.tcl:69
+msgid "Copy"
+msgstr "Kopieren"
+
+#: git-gui.sh:1742 git-gui.sh:2228
+msgid "Paste"
+msgstr "Einfügen"
+
+#: git-gui.sh:1745 git-gui.sh:2231 lib/branch_delete.tcl:26
+#: lib/remote_branch_delete.tcl:38
+msgid "Delete"
+msgstr "Löschen"
+
+#: git-gui.sh:1749 git-gui.sh:2235 git-gui.sh:2372 lib/console.tcl:71
+msgid "Select All"
+msgstr "Alle auswählen"
+
+#: git-gui.sh:1758
+msgid "Create..."
+msgstr "Erstellen..."
+
+#: git-gui.sh:1764
+msgid "Checkout..."
+msgstr "Auschecken..."
+
+#: git-gui.sh:1770
+msgid "Rename..."
+msgstr "Umbenennen..."
+
+#: git-gui.sh:1775 git-gui.sh:1873
+msgid "Delete..."
+msgstr "Löschen..."
+
+#: git-gui.sh:1780
+msgid "Reset..."
+msgstr "Zurücksetzen..."
+
+#: git-gui.sh:1792 git-gui.sh:2169
+msgid "New Commit"
+msgstr "Neu übertragen"
+
+#: git-gui.sh:1800 git-gui.sh:2176
+msgid "Amend Last Commit"
+msgstr "Letzte Übertragung nachbessern"
+
+#: git-gui.sh:1809 git-gui.sh:2136 lib/remote_branch_delete.tcl:99
+msgid "Rescan"
+msgstr "Neu laden"
+
+#: git-gui.sh:1815
+msgid "Stage To Commit"
+msgstr "Zur Übertragung bereitstellen"
+
+#: git-gui.sh:1820
+msgid "Stage Changed Files To Commit"
+msgstr "Geänderte Dateien zur Übertragung bereitstellen"
+
+#: git-gui.sh:1826
+msgid "Unstage From Commit"
+msgstr "Aus der Bereitstellung herausnehmen"
+
+#: git-gui.sh:1831 lib/index.tcl:376
+msgid "Revert Changes"
+msgstr "Änderungen revidieren"
+
+#: git-gui.sh:1838 git-gui.sh:2148 git-gui.sh:2246
+msgid "Sign Off"
+msgstr "Abzeichnen"
+
+#: git-gui.sh:1853
+msgid "Local Merge..."
+msgstr "Lokales Zusammenführen..."
+
+#: git-gui.sh:1858
+msgid "Abort Merge..."
+msgstr "Zusammenführen abbrechen..."
+
+#: git-gui.sh:1870
+msgid "Push..."
+msgstr "Ausliefern..."
+
+#: git-gui.sh:1880
+msgid "Apple"
+msgstr "Apple"
+
+#: git-gui.sh:1883 git-gui.sh:1901 lib/option.tcl:65
+#, tcl-format
+msgid "About %s"
+msgstr "Über %s"
+
+#: git-gui.sh:1885 git-gui.sh:1891 git-gui.sh:2414
+msgid "Options..."
+msgstr "Optionen..."
+
+#: git-gui.sh:1897
+msgid "Help"
+msgstr "Hilfe"
+
+#: git-gui.sh:1938
+msgid "Online Documentation"
+msgstr "Online-Dokumentation"
+
+#: git-gui.sh:2054
+msgid "Current Branch:"
+msgstr "Aktueller Zweig:"
+
+#: git-gui.sh:2075
+msgid "Staged Changes (Will Be Committed)"
+msgstr "Bereitgestellte Änderungen (werden übertragen)"
+
+#: git-gui.sh:2095
+msgid "Unstaged Changes (Will Not Be Committed)"
+msgstr "Nicht bereitgestellte Änderungen (werden nicht übertragen)"
+
+#: git-gui.sh:2142
+msgid "Stage Changed"
+msgstr "Geänderte bereitstellen"
+
+#: git-gui.sh:2188
+msgid "Initial Commit Message:"
+msgstr "Erstmalige Übertragungsmeldung"
+
+#: git-gui.sh:2189
+msgid "Amended Commit Message:"
+msgstr "Übertragungsmeldung mit Nachbesserung:"
+
+#: git-gui.sh:2190
+msgid "Amended Initial Commit Message:"
+msgstr "Erstmalige Übertragungsmeldung mit Nachbesserung:"
+
+#: git-gui.sh:2191
+msgid "Amended Merge Commit Message:"
+msgstr "Zusammenführungs-Übertragungsmeldung mit Nachbesserung"
+
+#: git-gui.sh:2192
+msgid "Merge Commit Message:"
+msgstr "Übertragungsmeldung Zusammenführung:"
+
+#: git-gui.sh:2193
+msgid "Commit Message:"
+msgstr "Übertragungsmeldung:"
+
+#: git-gui.sh:2238 git-gui.sh:2376 lib/console.tcl:73
+msgid "Copy All"
+msgstr "Alle kopieren"
+
+#: git-gui.sh:2262 lib/blame.tcl:104
+msgid "File:"
+msgstr "Datei:"
+
+#: git-gui.sh:2364
+msgid "Refresh"
+msgstr "Aktualisieren"
+
+#: git-gui.sh:2385
+msgid "Apply/Reverse Hunk"
+msgstr "Änderung anwenden/umkehren"
+
+#: git-gui.sh:2391
+msgid "Decrease Font Size"
+msgstr "Schriftgröße verkleinern"
+
+#: git-gui.sh:2395
+msgid "Increase Font Size"
+msgstr "Schriftgröße vergrößern"
+
+#: git-gui.sh:2400
+msgid "Show Less Context"
+msgstr "Weniger Kontext anzeigen"
+
+#: git-gui.sh:2407
+msgid "Show More Context"
+msgstr "Mehr Kontext anzeigen"
+
+#: git-gui.sh:2422
+msgid "Unstage Hunk From Commit"
+msgstr "Aus der Bereitstellung herausnehmen"
+
+#: git-gui.sh:2426 git-gui.sh:2430
+msgid "Stage Hunk For Commit"
+msgstr "In die Bereitstellung hinzufügen"
+
+#: git-gui.sh:2440
+msgid "Initializing..."
+msgstr "Initialisieren..."
+
+#: lib/blame.tcl:77
+msgid "File Viewer"
+msgstr "Datei-Browser"
+
+#: lib/blame.tcl:81
+msgid "Commit:"
+msgstr "Übertragung:"
+
+#: lib/blame.tcl:249
+msgid "Copy Commit"
+msgstr "Übertragung kopieren"
+
+#: lib/blame.tcl:369
+#, tcl-format
+msgid "Reading %s..."
+msgstr "%s lesen..."
+
+#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+msgid "Checkout Branch"
+msgstr "Zweig auschecken"
+
+#: lib/branch_checkout.tcl:23
+msgid "Checkout"
+msgstr "Auschecken"
+
+#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
+#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:283
+#: lib/checkout_op.tcl:522 lib/merge.tcl:172 lib/option.tcl:172
+#: lib/remote_branch_delete.tcl:42 lib/transport.tcl:92
+msgid "Cancel"
+msgstr "Abbrechen"
+
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:288
+msgid "Revision"
+msgstr "Version"
+
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:159
+#: lib/option.tcl:274
+msgid "Options"
+msgstr "Optionen"
+
+#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "Übernahmezweig anfordern"
+
+#: lib/branch_checkout.tcl:44
+msgid "Detach From Local Branch"
+msgstr "Verbindung zu lokalem Zweig lösen"
+
+#: lib/branch_create.tcl:22
+msgid "Create Branch"
+msgstr "Zweig erstellen"
+
+#: lib/branch_create.tcl:27
+msgid "Create New Branch"
+msgstr "Neuen Zweig erstellen"
+
+#: lib/branch_create.tcl:31
+msgid "Create"
+msgstr "Erstellen"
+
+#: lib/branch_create.tcl:40
+msgid "Branch Name"
+msgstr "Zweigname"
+
+#: lib/branch_create.tcl:43
+msgid "Name:"
+msgstr "Name:"
+
+#: lib/branch_create.tcl:58
+msgid "Match Tracking Branch Name"
+msgstr "Passend zu Übernahmezweig-Name"
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "Anfangsversion"
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "Existierenden Zweig aktualisieren:"
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "Nein"
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "Nur Schnellzusammenführung"
+
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:514
+msgid "Reset"
+msgstr "Zurücksetzen"
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "Auschecken nach Erstellen"
+
+#: lib/branch_create.tcl:131
+msgid "Please select a tracking branch."
+msgstr "Bitte wählen Sie einen Übernahmezweig."
+
+#: lib/branch_create.tcl:140
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "Übernahmezweig »%s« ist kein Zweig im Projektarchiv der Gegenseite."
+
+#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
+msgid "Please supply a branch name."
+msgstr "Bitte geben Sie einen Zweignamen an."
+
+#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "»%s« ist kein zulässiger Zweigname."
+
+#: lib/branch_delete.tcl:15
+msgid "Delete Branch"
+msgstr "Zweig löschen"
+
+#: lib/branch_delete.tcl:20
+msgid "Delete Local Branch"
+msgstr "Lokalen Zweig löschen"
+
+#: lib/branch_delete.tcl:37
+msgid "Local Branches"
+msgstr "Lokale Zweige"
+
+#: lib/branch_delete.tcl:52
+msgid "Delete Only If Merged Into"
+msgstr "Nur löschen, wenn darin zusammengeführt"
+
+#: lib/branch_delete.tcl:54
+msgid "Always (Do not perform merge test.)"
+msgstr "Immer (ohne Zusammenführungstest)"
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr "Folgende Zweige sind noch nicht mit »%s« zusammengeführt:"
+
+#: lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult. \n"
+"\n"
+" Delete the selected branches?"
+msgstr ""
+"Gelöschte Zweige können nur mit größerem Aufwand wiederhergestellt werden.\n"
+"\n"
+"Gewählte Zweige jetzt löschen?"
+
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"Fehler beim Löschen der Zweige:\n"
+"%s"
+
+#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
+msgid "Rename Branch"
+msgstr "Zweig umbenennen"
+
+#: lib/branch_rename.tcl:26
+msgid "Rename"
+msgstr "Umbenennen"
+
+#: lib/branch_rename.tcl:36
+msgid "Branch:"
+msgstr "Zweig:"
+
+#: lib/branch_rename.tcl:39
+msgid "New Name:"
+msgstr "Neuer Name:"
+
+#: lib/branch_rename.tcl:75
+msgid "Please select a branch to rename."
+msgstr "Bitte wählen Sie einen Zweig zum umbenennen."
+
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "Zweig »%s« existiert bereits."
+
+#: lib/branch_rename.tcl:117
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "Fehler beim Umbenennen von »%s«."
+
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "Starten..."
+
+#: lib/browser.tcl:26
+msgid "File Browser"
+msgstr "Datei-Browser"
+
+#: lib/browser.tcl:127 lib/browser.tcl:144
+#, tcl-format
+msgid "Loading %s..."
+msgstr "%s laden..."
+
+#: lib/browser.tcl:188
+msgid "[Up To Parent]"
+msgstr "[Nach oben]"
+
+#: lib/browser.tcl:268 lib/browser.tcl:274
+msgid "Browse Branch Files"
+msgstr "Dateien des Zweigs durchblättern"
+
+#: lib/browser.tcl:279
+msgid "Browse"
+msgstr "Blättern"
+
+#: lib/checkout_op.tcl:79
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "Änderungen »%s« von »%s« anfordern"
+
+#: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
+msgid "Close"
+msgstr "Schließen"
+
+#: lib/checkout_op.tcl:169
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr "Zweig »%s« existiert nicht."
+
+#: lib/checkout_op.tcl:206
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr ""
+"Zweig »%s« existiert bereits.\n"
+"\n"
+"Zweig kann nicht mit »%s« schnellzusammengeführt werden. Reguläres "
+"Zusammenführen ist notwendig."
+
+#: lib/checkout_op.tcl:220
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr "Zusammenführungsmethode »%s« nicht unterstützt."
+
+#: lib/checkout_op.tcl:239
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr "Aktualisieren von »%s« fehlgeschlagen."
+
+#: lib/checkout_op.tcl:251
+msgid "Staging area (index) is already locked."
+msgstr "Bereitstellung (»index«) ist zur Bearbeitung gesperrt (»locked«)."
+
+#: lib/checkout_op.tcl:266
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before the current branch can be changed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
+"\n"
+"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
+"geändert.  Vor dem Wechseln des lokalen Zweigs muss neu geladen werden.\n"
+"\n"
+"Es wird gleich neu geladen.\n"
+
+#: lib/checkout_op.tcl:353
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
+msgstr ""
+"Auschecken von »%s« abgebrochen (Zusammenführen der Dateien ist notwendig)."
+
+#: lib/checkout_op.tcl:354
+msgid "File level merge required."
+msgstr "Zusammenführen der Dateien ist notwendig."
+
+#: lib/checkout_op.tcl:358
+#, tcl-format
+msgid "Staying on branch '%s'."
+msgstr "Es wird auf Zweig »%s« verblieben."
+
+#: lib/checkout_op.tcl:429
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This Detached "
+"Checkout'."
+msgstr ""
+"Die Arbeitskopie ist nicht auf einem lokalen Zweig.\n"
+"\n"
+"Wenn Sie auf einem Zwei arbeiten möchten, erstellen Sie bitte jetzt einen "
+"Zweig mit der Auswahl »Abgetrennte Auscheck-Version«."
+
+#: lib/checkout_op.tcl:478
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgstr "Zurücksetzen von »%s« nach »%s« wird folgende Versionen verwerfen:"
+
+#: lib/checkout_op.tcl:500
+msgid "Recovering lost commits may not be easy."
+msgstr ""
+"Verworfene Versionen können nur mit größerem Aufwand wiederhergestellt "
+"werden."
+
+#: lib/checkout_op.tcl:505
+#, tcl-format
+msgid "Reset '%s'?"
+msgstr "»%s« zurücksetzen?"
+
+#: lib/checkout_op.tcl:510 lib/merge.tcl:164
+msgid "Visualize"
+msgstr "Darstellen"
+
+#: lib/checkout_op.tcl:578
+#, tcl-format
+msgid ""
+"Failed to set current branch.\n"
+"\n"
+"This working directory is only partially switched.  We successfully updated "
+"your files, but failed to update an internal Git file.\n"
+"\n"
+"This should not have occurred.  %s will now close and give up."
+msgstr ""
+"Lokaler Zweig kann nicht gesetzt werden.\n"
+"\n"
+"Diese Arbeitskopie ist nur teilweise umgestellt. Die Dateien sind korrekt "
+"aktualisiert, aber einige interne Git-Dateien konnten nicht geändert "
+"werden.\n"
+"\n"
+"Dies ist ein interner Programmfehler von %s. Programm wird jetzt abgebrochen."
+
+#: lib/choose_rev.tcl:53
+msgid "This Detached Checkout"
+msgstr "Abgetrennte Auscheck-Version"
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "Version Regexp-Ausdruck:"
+
+#: lib/choose_rev.tcl:74
+msgid "Local Branch"
+msgstr "Lokaler Zweig"
+
+#: lib/choose_rev.tcl:79
+msgid "Tracking Branch"
+msgstr "Übernahmezweig"
+
+#: lib/choose_rev.tcl:84
+msgid "Tag"
+msgstr "Markierung"
+
+#: lib/choose_rev.tcl:317
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Ungültige Version: %s"
+
+#: lib/choose_rev.tcl:338
+msgid "No revision selected."
+msgstr "Keine Version ausgewählt."
+
+#: lib/choose_rev.tcl:346
+msgid "Revision expression is empty."
+msgstr "Versions-Ausdruck ist leer."
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit before this "
+"to amend.\n"
+msgstr ""
+"Keine Version zur Nachbesserung vorhanden.\n"
+"\n"
+"Sie sind dabei, die erste Version zu übertragen. Es gibt keine existierende "
+"Version, die Sie nachbessern könnten.\n"
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort the "
+"current merge activity.\n"
+msgstr ""
+"Nachbesserung währen Zusammenführung nicht möglich.\n"
+"\n"
+"Sie haben das Zusammenführen von Versionen angefangen, aber noch nicht "
+"beendet. Sie können keine vorige Übertragung nachbessern, solange eine "
+"unfertige Zusammenführung existiert. Dazu müssen Sie die Zusammenführung "
+"beenden oder abbrechen.\n"
+
+#: lib/commit.tcl:49
+msgid "Error loading commit data for amend:"
+msgstr "Fehler beim Laden der Versionsdaten für Nachbessern:"
+
+#: lib/commit.tcl:76
+msgid "Unable to obtain your identity:"
+msgstr "Benutzername konnte nicht bestimmt werden:"
+
+#: lib/commit.tcl:81
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "Ungültiger Wert von GIT_COMMITTER_INDENT:"
+
+#: lib/commit.tcl:133
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
+"\n"
+"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
+"geändert.  Vor einer neuen Übertragung muss neu geladen werden.\n"
+"\n"
+"Es wird gleich neu geladen.\n"
+
+#: lib/commit.tcl:154
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the file "
+"before committing.\n"
+msgstr ""
+"Nicht zusammengeführte Dateien können nicht übertragen werden.\n"
+"\n"
+"Die Datei %s hat noch nicht aufgelöste Zusammenführungs-Konflikte. Sie "
+"müssen diese Konflikte auflösen, bevor Sie übertragen können.\n"
+
+#: lib/commit.tcl:162
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"Unbekannter Dateizustand »%s«.\n"
+"\n"
+"Datei »%s« kann nicht übertragen werden.\n"
+
+#: lib/commit.tcl:170
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"Keine Änderungen vorhanden, die übertragen werden könnten.\n"
+"\n"
+"Sie müssen mindestens eine Datei bereitstellen, bevor Sie übertragen "
+"können.\n"
+
+#: lib/commit.tcl:183
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentance what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
+msgstr ""
+"Bitte geben Sie eine Übertragungsmeldung ein.\n"
+"\n"
+"Eine gute Übertragungsmeldung enthält folgende Abschnitte:\n"
+"\n"
+"- Erste Zeile: Eine Zusammenfassung, was man gemacht hat.\n"
+"\n"
+"- Zweite Zeile: Leerzeile\n"
+"\n"
+"- Rest der Meldung: Eine ausführliche Beschreibung, warum diese Änderung "
+"hilfreich ist.\n"
+
+#: lib/commit.tcl:257
+msgid "write-tree failed:"
+msgstr "write-tree fehlgeschlagen:"
+
+#: lib/commit.tcl:279
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"Keine Änderungen zu übertragen.\n"
+"\n"
+"Es gibt keine geänderte Datei bei dieser Übertragung und es wurde auch "
+"nichts zusammengeführt.\n"
+"\n"
+"Das Arbeitsverzeichnis wird daher jetzt neu geladen.\n"
+
+#: lib/commit.tcl:286
+msgid "No changes to commit."
+msgstr "Keine Änderungen, die übertragen werden können."
+
+#: lib/commit.tcl:317
+msgid "commit-tree failed:"
+msgstr "commit-tree fehlgeschlagen:"
+
+#: lib/commit.tcl:339
+msgid "update-ref failed:"
+msgstr "update-ref fehlgeschlagen:"
+
+#: lib/commit.tcl:430
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "Version %s übertragen: %s"
+
+#: lib/console.tcl:55
+msgid "Working... please wait..."
+msgstr "Verarbeitung. Bitte warten..."
+
+#: lib/console.tcl:184
+msgid "Success"
+msgstr "Erfolgreich"
+
+#: lib/console.tcl:194
+msgid "Error: Command Failed"
+msgstr "Fehler: Kommando fehlgeschlagen"
+
+#: lib/database.tcl:43
+msgid "Number of loose objects"
+msgstr "Anzahl unverknüpfter Objekte"
+
+#: lib/database.tcl:44
+msgid "Disk space used by loose objects"
+msgstr "Festplattenplatz von unverknüpften Objekten"
+
+#: lib/database.tcl:45
+msgid "Number of packed objects"
+msgstr "Anzahl komprimierter Objekte"
+
+#: lib/database.tcl:46
+msgid "Number of packs"
+msgstr "Anzahl Komprimierungseinheiten"
+
+#: lib/database.tcl:47
+msgid "Disk space used by packed objects"
+msgstr "Festplattenplatz von komprimierten Objekten"
+
+#: lib/database.tcl:48
+msgid "Packed objects waiting for pruning"
+msgstr "Komprimierte Objekte, die zum Löschen vorgesehen sind"
+
+#: lib/database.tcl:49
+msgid "Garbage files"
+msgstr "Dateien im Mülleimer"
+
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "Objektdatenbank komprimieren"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "Die Objektdatenbank durch »fsck-objects« überprüfen lassen"
+
+#: lib/diff.tcl:42
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may have "
+"the same state."
+msgstr ""
+"Keine Änderungen feststellbar.\n"
+"\n"
+"»%s« enthält keine Änderungen. Zwar wurde das Änderungsdatum dieser Datei "
+"von einem anderen Programm modifiziert, aber der Inhalt der Datei ist "
+"unverändert.\n"
+"\n"
+"Das Arbeitsverzeichnis wird jetzt neu geladen, um diese Änderung bei allen "
+"Dateien zu prüfen."
+
+#: lib/diff.tcl:97
+msgid "Error loading file:"
+msgstr "Fehler beim Laden der Datei:"
+
+#: lib/diff.tcl:162
+msgid "Error loading diff:"
+msgstr "Fehler beim Laden des Vergleichs:"
+
+#: lib/diff.tcl:278
+msgid "Failed to unstage selected hunk."
+msgstr "Fehler beim Herausnehmen der gewählten Dateien aus der Bereitstellung."
+
+#: lib/diff.tcl:285
+msgid "Failed to stage selected hunk."
+msgstr "Fehler beim Bereitstellen der gewählten Dateien."
+
+#: lib/error.tcl:12 lib/error.tcl:102
+msgid "error"
+msgstr "Fehler"
+
+#: lib/error.tcl:28
+msgid "warning"
+msgstr "Warnung"
+
+#: lib/error.tcl:81
+msgid "You must correct the above errors before committing."
+msgstr ""
+"Sie müssen die obigen Fehler zuerst beheben, bevor Sie übertragen können."
+
+#: lib/index.tcl:364
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "Änderungen in Datei »%s« revidieren?"
+
+#: lib/index.tcl:366
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr "Änderungen in den gewählten %i Dateien revidieren?"
+
+#: lib/index.tcl:372
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr ""
+"Alle nicht bereitgestellten Änderungen werden beim Revidieren verloren gehen."
+
+#: lib/index.tcl:375
+msgid "Do Nothing"
+msgstr "Nichts tun"
+
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
+msgstr ""
+"Zusammenführen kann nicht gleichzeitig mit Nachbessern durchgeführt werden.\n"
+"\n"
+"Sie müssen zuerst die Nachbesserungs-Übertragung abschließen, bevor Sie "
+"zusammenführen können.\n"
+
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
+"\n"
+"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
+"geändert.  Vor einem Zusammenführen muss neu geladen werden.\n"
+"\n"
+"Es wird gleich neu geladen.\n"
+
+#: lib/merge.tcl:44
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the current "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+"Zusammenführung mit Konflikten.\n"
+"\n"
+"Die Datei »%s« enthält Konflikte beim Zusammenführen. Sie müssen diese "
+"Konflikte per Hand auflösen. Anschließend müssen Sie die Datei wieder "
+"bereitstellen und übertragen, um die Zusammenführung abzuschließen. Erst "
+"danach kann eine neue Zusammenführung begonnen werden.\n"
+
+#: lib/merge.tcl:54
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doing so "
+"will help you abort a failed merge, should the need arise.\n"
+msgstr ""
+"Es liegen Änderungen vor.\n"
+"\n"
+"Die Datei »%s« wurde geändert.  Sie sollten zuerst die bereitgestellte "
+"Übertragung abschließen, bevor Sie eine Zusammenführung beginnen.  Mit "
+"dieser Reihenfolge können Sie mögliche Konflikte beim Zusammenführen "
+"wesentlich einfacher beheben oder abbrechen.\n"
+
+#: lib/merge.tcl:106
+#, tcl-format
+msgid "%s of %s"
+msgstr "%s von %s"
+
+#: lib/merge.tcl:119
+#, tcl-format
+msgid "Merging %s and %s"
+msgstr "Zusammenführen von %s und %s"
+
+#: lib/merge.tcl:131
+msgid "Merge completed successfully."
+msgstr "Zusammenführen erfolgreich abgeschlossen."
+
+#: lib/merge.tcl:133
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "Zusammenführen fehlgeschlagen. Konfliktauflösung ist notwendig."
+
+#: lib/merge.tcl:158
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "Zusammenführen in %s"
+
+#: lib/merge.tcl:177
+msgid "Revision To Merge"
+msgstr "Zusammenzuführende Version"
+
+#: lib/merge.tcl:212
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"Abbruch der Nachbesserung ist nicht möglich.\n"
+"\n"
+"Sie müssen die Nachbesserung der Übertragung abschließen.\n"
+
+#: lib/merge.tcl:222
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"Zusammenführen abbrechen?\n"
+"\n"
+"Wenn Sie abbrechen, gehen alle noch nicht übertragenen Änderungen verloren.\n"
+"\n"
+"Zusammenführen jetzt abbrechen?"
+
+#: lib/merge.tcl:228
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr ""
+"Änderungen zurücksetzen?\n"
+"\n"
+"Wenn Sie zurücksetzen, gehen alle noch nicht übertragenen Änderungen "
+"verloren.\n"
+"\n"
+"Änderungen jetzt zurücksetzen?"
+
+#: lib/merge.tcl:239
+msgid "Aborting"
+msgstr "Abbruch"
+
+#: lib/merge.tcl:266
+msgid "Abort failed."
+msgstr "Abbruch fehlgeschlagen."
+
+#: lib/merge.tcl:268
+msgid "Abort completed.  Ready."
+msgstr "Abbruch durchgeführt. Bereit."
+
+#: lib/option.tcl:77
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui - eine grafische Oberfläche für Git."
+
+#: lib/option.tcl:164
+msgid "Restore Defaults"
+msgstr "Voreinstellungen wiederherstellen"
+
+#: lib/option.tcl:168
+msgid "Save"
+msgstr "Speichern"
+
+#: lib/option.tcl:178
+#, tcl-format
+msgid "%s Repository"
+msgstr "Projektarchiv %s"
+
+#: lib/option.tcl:179
+msgid "Global (All Repositories)"
+msgstr "Global (Alle Projektarchive)"
+
+#: lib/option.tcl:185
+msgid "User Name"
+msgstr "Benutzername"
+
+#: lib/option.tcl:186
+msgid "Email Address"
+msgstr "E-Mail-Adresse"
+
+#: lib/option.tcl:188
+msgid "Summarize Merge Commits"
+msgstr "Zusammenführungs-Übertragungen zusammenfassen"
+
+#: lib/option.tcl:189
+msgid "Merge Verbosity"
+msgstr "Ausführlichkeit der Zusammenführen-Meldungen"
+
+#: lib/option.tcl:190
+msgid "Show Diffstat After Merge"
+msgstr "Vergleichsstatistik nach Zusammenführen anzeigen"
+
+#: lib/option.tcl:192
+msgid "Trust File Modification Timestamps"
+msgstr "Auf Dateiänderungsdatum verlassen"
+
+#: lib/option.tcl:193
+msgid "Prune Tracking Branches During Fetch"
+msgstr "Übernahmezweige löschen während Anforderung"
+
+#: lib/option.tcl:194
+msgid "Match Tracking Branches"
+msgstr "Passend zu Übernahmezweig"
+
+#: lib/option.tcl:195
+msgid "Number of Diff Context Lines"
+msgstr "Anzahl der Kontextzeilen beim Vergleich"
+
+#: lib/option.tcl:196
+msgid "New Branch Name Template"
+msgstr "Namensvorschlag für neue Zweige"
+
+#: lib/option.tcl:305
+msgid "Failed to completely save options:"
+msgstr "Optionen konnten nicht gespeichert werden:"
+
+#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
+msgid "Delete Remote Branch"
+msgstr "Zweig im Projektarchiv der Gegenseite löschen"
+
+#: lib/remote_branch_delete.tcl:47
+msgid "From Repository"
+msgstr "Von Projektarchiv"
+
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:118
+msgid "Remote:"
+msgstr "Gegenseite:"
+
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:133
+msgid "Arbitrary URL:"
+msgstr "Kommunikation mit URL:"
+
+#: lib/remote_branch_delete.tcl:84
+msgid "Branches"
+msgstr "Zweige"
+
+#: lib/remote_branch_delete.tcl:109
+msgid "Delete Only If"
+msgstr "Löschen, falls"
+
+#: lib/remote_branch_delete.tcl:111
+msgid "Merged Into:"
+msgstr "Zusammenführen mit:"
+
+#: lib/remote_branch_delete.tcl:119
+msgid "Always (Do not perform merge checks)"
+msgstr "Immer (Keine Zusammenführungsprüfung)"
+
+#: lib/remote_branch_delete.tcl:152
+msgid "A branch is required for 'Merged Into'."
+msgstr "Für »Zusammenführen mit« muss ein Zweig angegeben werden."
+
+#: lib/remote_branch_delete.tcl:189
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched the "
+"necessary commits.  Try fetching from %s first."
+msgstr ""
+"Ein oder mehrere Zusammenführungen sind fehlgeschlagen, da Sie nicht die "
+"notwendigen Versionen vorher angefordert haben.  Sie sollten versuchen, "
+"zuerst von »%s« anzufordern."
+
+#: lib/remote_branch_delete.tcl:207
+msgid "Please select one or more branches to delete."
+msgstr "Bitte wählen Sie mindestens einen Zweig, der gelöscht werden soll."
+
+#: lib/remote_branch_delete.tcl:216
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Das Wiederherstellen von gelöschten Zweigen ist nur mit größerem Aufwand "
+"möglich.\n"
+"\n"
+"Sollen die ausgewählten Zweige gelöscht werden?"
+
+#: lib/remote_branch_delete.tcl:226
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr "Zweige auf »%s« werden gelöscht"
+
+#: lib/remote_branch_delete.tcl:286
+msgid "No repository selected."
+msgstr "Kein Projektarchiv ausgewählt."
+
+#: lib/remote_branch_delete.tcl:291
+#, tcl-format
+msgid "Scanning %s..."
+msgstr "%s laden..."
+
+#: lib/remote.tcl:162
+#, tcl-format
+msgid "Fetch from %s..."
+msgstr "Von »%s« anfordern..."
+
+#: lib/remote.tcl:172
+#, tcl-format
+msgid "Prune from %s..."
+msgstr "Löschen von »%s«..."
+
+#: lib/remote.tcl:206
+#, tcl-format
+msgid "Push to %s..."
+msgstr "Nach %s ausliefern..."
+
+#: lib/shortcut.tcl:26 lib/shortcut.tcl:74
+msgid "Cannot write script:"
+msgstr "Fehler beim Schreiben des Scripts:"
+
+#: lib/shortcut.tcl:149
+msgid "Cannot write icon:"
+msgstr "Fehler beim Erstellen des Icons:"
+
+#: lib/status_bar.tcl:58
+#, tcl-format
+msgid "%s ... %i of %i %s (%2i%%)"
+msgstr "%s ... %i von %i %s (%2i%%)"
+
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "Neue Änderungen von »%s« holen"
+
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "Übernahmezweige löschen, die in »%s« gelöscht wurden"
+
+#: lib/transport.tcl:26
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "Änderungen nach %s ausliefern"
+
+#: lib/transport.tcl:68
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "%s %s nach %s ausliefern"
+
+#: lib/transport.tcl:84
+msgid "Push Branches"
+msgstr "Zweige ausliefern"
+
+#: lib/transport.tcl:98
+msgid "Source Branches"
+msgstr "Herkunftszweige"
+
+#: lib/transport.tcl:115
+msgid "Destination Repository"
+msgstr "Ziel-Projektarchiv"
+
+#: lib/transport.tcl:153
+msgid "Transfer Options"
+msgstr "Netzwerk-Einstellungen"
+
+#: lib/transport.tcl:155
+msgid "Use thin pack (for slow network connections)"
+msgstr "Kompaktes Datenformat benutzen (für langsame Netzverbindungen)"
+
+#: lib/transport.tcl:159
+msgid "Include tags"
+msgstr "Mit Markierungen übertragen"
-- 
1.5.3.2.g46909


--8323584-1827328118-1188750843=:28586--
