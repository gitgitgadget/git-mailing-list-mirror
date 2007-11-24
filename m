From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 2/2] git-gui: Update German translation. 100% completed.
Date: Sat, 24 Nov 2007 11:05:37 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200711241105.37772.stimming@tuhh.de>
References: <200711241104.32371.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Nov 24 11:06:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivrtl-0001XS-Uh
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 11:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbXKXKFr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Nov 2007 05:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbXKXKFq
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 05:05:46 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:39467 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbXKXKFp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Nov 2007 05:05:45 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lAOA5e9j025103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 24 Nov 2007 11:05:40 +0100
Received: from [192.168.2.102] (p549032F8.dip0.t-ipconnect.de [84.144.50.248])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lAOA5cR4021631
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 24 Nov 2007 11:05:39 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <200711241104.32371.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65941>

---
 po/de.po |  308 +++++++++++++++++++++++++++++++++---------------------=
-------
 1 files changed, 167 insertions(+), 141 deletions(-)

diff --git a/po/de.po b/po/de.po
index 3df30ed..ac8ae0a 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7,41 +7,41 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2007-10-19 21:10+0200\n"
-"PO-Revision-Date: 2007-10-20 15:28+0200\n"
+"POT-Creation-Date: 2007-11-24 10:36+0100\n"
+"PO-Revision-Date: 2007-11-24 10:55+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: git-gui.sh:41 git-gui.sh:590 git-gui.sh:604 git-gui.sh:617 git-gui.=
sh:700
-#: git-gui.sh:719
+#: git-gui.sh:41 git-gui.sh:604 git-gui.sh:618 git-gui.sh:631 git-gui.=
sh:714
+#: git-gui.sh:733
 msgid "git-gui: fatal error"
 msgstr "git-gui: Programmfehler"
=20
-#: git-gui.sh:551
+#: git-gui.sh:565
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "Ung=C3=BCltige Zeichensatz-Angabe in %s:"
=20
-#: git-gui.sh:576
+#: git-gui.sh:590
 msgid "Main Font"
 msgstr "Programmschriftart"
=20
-#: git-gui.sh:577
+#: git-gui.sh:591
 msgid "Diff/Console Font"
 msgstr "Vergleich-Schriftart"
=20
-#: git-gui.sh:591
+#: git-gui.sh:605
 msgid "Cannot find git in PATH."
 msgstr "Git kann im PATH nicht gefunden werden."
=20
-#: git-gui.sh:618
+#: git-gui.sh:632
 msgid "Cannot parse Git version string:"
 msgstr "Git Versionsangabe kann nicht erkannt werden:"
=20
-#: git-gui.sh:636
+#: git-gui.sh:650
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -60,81 +60,81 @@ msgstr ""
 "\n"
 "Soll angenommen werden, =C2=BB%s=C2=AB sei Version 1.5.0?\n"
=20
-#: git-gui.sh:874
+#: git-gui.sh:888
 msgid "Git directory not found:"
 msgstr "Git-Verzeichnis nicht gefunden:"
=20
-#: git-gui.sh:881
+#: git-gui.sh:895
 msgid "Cannot move to top of working directory:"
 msgstr ""
 "Es konnte nicht in das oberste Verzeichnis der Arbeitskopie gewechsel=
t "
 "werden:"
=20
-#: git-gui.sh:888
+#: git-gui.sh:902
 msgid "Cannot use funny .git directory:"
 msgstr "Unerwartete Struktur des .git Verzeichnis:"
=20
-#: git-gui.sh:893
+#: git-gui.sh:907
 msgid "No working directory"
 msgstr "Kein Arbeitsverzeichnis"
=20
-#: git-gui.sh:1040
+#: git-gui.sh:1054
 msgid "Refreshing file status..."
 msgstr "Dateistatus aktualisieren..."
=20
-#: git-gui.sh:1105
+#: git-gui.sh:1119
 msgid "Scanning for modified files ..."
 msgstr "Nach ge=C3=A4nderten Dateien suchen..."
=20
-#: git-gui.sh:1280 lib/browser.tcl:245
+#: git-gui.sh:1294 lib/browser.tcl:245
 msgid "Ready."
 msgstr "Bereit."
=20
-#: git-gui.sh:1546
+#: git-gui.sh:1560
 msgid "Unmodified"
 msgstr "Unver=C3=A4ndert"
=20
-#: git-gui.sh:1548
+#: git-gui.sh:1562
 msgid "Modified, not staged"
 msgstr "Ver=C3=A4ndert, nicht bereitgestellt"
=20
-#: git-gui.sh:1549 git-gui.sh:1554
+#: git-gui.sh:1563 git-gui.sh:1568
 msgid "Staged for commit"
 msgstr "Bereitgestellt zum Eintragen"
=20
-#: git-gui.sh:1550 git-gui.sh:1555
+#: git-gui.sh:1564 git-gui.sh:1569
 msgid "Portions staged for commit"
 msgstr "Teilweise bereitgestellt zum Eintragen"
=20
-#: git-gui.sh:1551 git-gui.sh:1556
+#: git-gui.sh:1565 git-gui.sh:1570
 msgid "Staged for commit, missing"
 msgstr "Bereitgestellt zum Eintragen, fehlend"
=20
-#: git-gui.sh:1553
+#: git-gui.sh:1567
 msgid "Untracked, not staged"
 msgstr "Nicht unter Versionskontrolle, nicht bereitgestellt"
=20
-#: git-gui.sh:1558
+#: git-gui.sh:1572
 msgid "Missing"
 msgstr "Fehlend"
=20
-#: git-gui.sh:1559
+#: git-gui.sh:1573
 msgid "Staged for removal"
 msgstr "Bereitgestellt zum L=C3=B6schen"
=20
-#: git-gui.sh:1560
+#: git-gui.sh:1574
 msgid "Staged for removal, still present"
 msgstr "Bereitgestellt zum L=C3=B6schen, trotzdem vorhanden"
=20
-#: git-gui.sh:1562 git-gui.sh:1563 git-gui.sh:1564 git-gui.sh:1565
+#: git-gui.sh:1576 git-gui.sh:1577 git-gui.sh:1578 git-gui.sh:1579
 msgid "Requires merge resolution"
 msgstr "Konfliktaufl=C3=B6sung n=C3=B6tig"
=20
-#: git-gui.sh:1600
+#: git-gui.sh:1614
 msgid "Starting gitk... please wait..."
 msgstr "Gitk wird gestartet... bitte warten."
=20
-#: git-gui.sh:1609
+#: git-gui.sh:1623
 #, tcl-format
 msgid ""
 "Unable to start gitk:\n"
@@ -145,295 +145,295 @@ msgstr ""
 "\n"
 "%s existiert nicht"
=20
-#: git-gui.sh:1809 lib/choose_repository.tcl:35
+#: git-gui.sh:1823 lib/choose_repository.tcl:35
 msgid "Repository"
 msgstr "Projektarchiv"
=20
-#: git-gui.sh:1810
+#: git-gui.sh:1824
 msgid "Edit"
 msgstr "Bearbeiten"
=20
-#: git-gui.sh:1812 lib/choose_rev.tcl:560
+#: git-gui.sh:1826 lib/choose_rev.tcl:560
 msgid "Branch"
 msgstr "Zweig"
=20
-#: git-gui.sh:1815 lib/choose_rev.tcl:547
+#: git-gui.sh:1829 lib/choose_rev.tcl:547
 msgid "Commit@@noun"
 msgstr "Version"
=20
-#: git-gui.sh:1818 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
+#: git-gui.sh:1832 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "Zusammenf=C3=BChren"
=20
-#: git-gui.sh:1819 lib/choose_rev.tcl:556
+#: git-gui.sh:1833 lib/choose_rev.tcl:556
 msgid "Remote"
 msgstr "Andere Archive"
=20
-#: git-gui.sh:1828
+#: git-gui.sh:1842
 msgid "Browse Current Branch's Files"
 msgstr "Aktuellen Zweig durchbl=C3=A4ttern"
=20
-#: git-gui.sh:1832
+#: git-gui.sh:1846
 msgid "Browse Branch Files..."
 msgstr "Einen Zweig durchbl=C3=A4ttern..."
=20
-#: git-gui.sh:1837
+#: git-gui.sh:1851
 msgid "Visualize Current Branch's History"
 msgstr "Aktuellen Zweig darstellen"
=20
-#: git-gui.sh:1841
+#: git-gui.sh:1855
 msgid "Visualize All Branch History"
 msgstr "Alle Zweige darstellen"
=20
-#: git-gui.sh:1848
+#: git-gui.sh:1862
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Zweig =C2=BB%s=C2=AB durchbl=C3=A4ttern"
=20
-#: git-gui.sh:1850
+#: git-gui.sh:1864
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Historie von =C2=BB%s=C2=AB darstellen"
=20
-#: git-gui.sh:1855 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:1869 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Datenbankstatistik"
=20
-#: git-gui.sh:1858 lib/database.tcl:34
+#: git-gui.sh:1872 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "Datenbank komprimieren"
=20
-#: git-gui.sh:1861
+#: git-gui.sh:1875
 msgid "Verify Database"
 msgstr "Datenbank =C3=BCberpr=C3=BCfen"
=20
-#: git-gui.sh:1868 git-gui.sh:1872 git-gui.sh:1876 lib/shortcut.tcl:7
+#: git-gui.sh:1882 git-gui.sh:1886 git-gui.sh:1890 lib/shortcut.tcl:7
 #: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
 msgstr "Desktop-Icon erstellen"
=20
-#: git-gui.sh:1881 lib/choose_repository.tcl:176 lib/choose_repository=
=2Etcl:184
+#: git-gui.sh:1895 lib/choose_repository.tcl:176 lib/choose_repository=
=2Etcl:184
 msgid "Quit"
 msgstr "Beenden"
=20
-#: git-gui.sh:1888
+#: git-gui.sh:1902
 msgid "Undo"
 msgstr "R=C3=BCckg=C3=A4ngig"
=20
-#: git-gui.sh:1891
+#: git-gui.sh:1905
 msgid "Redo"
 msgstr "Wiederholen"
=20
-#: git-gui.sh:1895 git-gui.sh:2388
+#: git-gui.sh:1909 git-gui.sh:2403
 msgid "Cut"
 msgstr "Ausschneiden"
=20
-#: git-gui.sh:1898 git-gui.sh:2391 git-gui.sh:2462 git-gui.sh:2534
+#: git-gui.sh:1912 git-gui.sh:2406 git-gui.sh:2477 git-gui.sh:2549
 #: lib/console.tcl:67
 msgid "Copy"
 msgstr "Kopieren"
=20
-#: git-gui.sh:1901 git-gui.sh:2394
+#: git-gui.sh:1915 git-gui.sh:2409
 msgid "Paste"
 msgstr "Einf=C3=BCgen"
=20
-#: git-gui.sh:1904 git-gui.sh:2397 lib/branch_delete.tcl:26
+#: git-gui.sh:1918 git-gui.sh:2412 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "L=C3=B6schen"
=20
-#: git-gui.sh:1908 git-gui.sh:2401 git-gui.sh:2538 lib/console.tcl:69
+#: git-gui.sh:1922 git-gui.sh:2416 git-gui.sh:2553 lib/console.tcl:69
 msgid "Select All"
 msgstr "Alle ausw=C3=A4hlen"
=20
-#: git-gui.sh:1917
+#: git-gui.sh:1931
 msgid "Create..."
 msgstr "Erstellen..."
=20
-#: git-gui.sh:1923
+#: git-gui.sh:1937
 msgid "Checkout..."
 msgstr "Umstellen..."
=20
-#: git-gui.sh:1929
+#: git-gui.sh:1943
 msgid "Rename..."
 msgstr "Umbenennen..."
=20
-#: git-gui.sh:1934 git-gui.sh:2033
+#: git-gui.sh:1948 git-gui.sh:2048
 msgid "Delete..."
 msgstr "L=C3=B6schen..."
=20
-#: git-gui.sh:1939
+#: git-gui.sh:1953
 msgid "Reset..."
 msgstr "Zur=C3=BCcksetzen..."
=20
-#: git-gui.sh:1951 git-gui.sh:2335
+#: git-gui.sh:1965 git-gui.sh:2350
 msgid "New Commit"
 msgstr "Neue Version"
=20
-#: git-gui.sh:1959 git-gui.sh:2342
+#: git-gui.sh:1973 git-gui.sh:2357
 msgid "Amend Last Commit"
 msgstr "Letzte Version nachbessern"
=20
-#: git-gui.sh:1968 git-gui.sh:2302 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:1982 git-gui.sh:2317 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "Neu laden"
=20
-#: git-gui.sh:1974
+#: git-gui.sh:1988
 msgid "Stage To Commit"
 msgstr "Zum Eintragen bereitstellen"
=20
-#: git-gui.sh:1979
+#: git-gui.sh:1994
 msgid "Stage Changed Files To Commit"
 msgstr "Ge=C3=A4nderte Dateien zum Eintragen bereitstellen"
=20
-#: git-gui.sh:1985
+#: git-gui.sh:2000
 msgid "Unstage From Commit"
 msgstr "Aus der Bereitstellung herausnehmen"
=20
-#: git-gui.sh:1990 lib/index.tcl:352
+#: git-gui.sh:2005 lib/index.tcl:393
 msgid "Revert Changes"
 msgstr "=C3=84nderungen revidieren"
=20
-#: git-gui.sh:1997 git-gui.sh:2314 git-gui.sh:2412
+#: git-gui.sh:2012 git-gui.sh:2329 git-gui.sh:2427
 msgid "Sign Off"
 msgstr "Abzeichnen"
=20
-#: git-gui.sh:2001 git-gui.sh:2318
+#: git-gui.sh:2016 git-gui.sh:2333
 msgid "Commit@@verb"
 msgstr "Eintragen"
=20
-#: git-gui.sh:2012
+#: git-gui.sh:2027
 msgid "Local Merge..."
 msgstr "Lokales Zusammenf=C3=BChren..."
=20
-#: git-gui.sh:2017
+#: git-gui.sh:2032
 msgid "Abort Merge..."
 msgstr "Zusammenf=C3=BChren abbrechen..."
=20
-#: git-gui.sh:2029
+#: git-gui.sh:2044
 msgid "Push..."
 msgstr "Versenden..."
=20
-#: git-gui.sh:2040 lib/choose_repository.tcl:40
+#: git-gui.sh:2055 lib/choose_repository.tcl:40
 msgid "Apple"
 msgstr "Apple"
=20
-#: git-gui.sh:2043 git-gui.sh:2065 lib/about.tcl:13
+#: git-gui.sh:2058 git-gui.sh:2080 lib/about.tcl:13
 #: lib/choose_repository.tcl:43 lib/choose_repository.tcl:49
 #, tcl-format
 msgid "About %s"
 msgstr "=C3=9Cber %s"
=20
-#: git-gui.sh:2047
+#: git-gui.sh:2062
 msgid "Preferences..."
 msgstr "Einstellungen..."
=20
-#: git-gui.sh:2055 git-gui.sh:2580
+#: git-gui.sh:2070 git-gui.sh:2595
 msgid "Options..."
 msgstr "Optionen..."
=20
-#: git-gui.sh:2061 lib/choose_repository.tcl:46
+#: git-gui.sh:2076 lib/choose_repository.tcl:46
 msgid "Help"
 msgstr "Hilfe"
=20
-#: git-gui.sh:2102
+#: git-gui.sh:2117
 msgid "Online Documentation"
 msgstr "Online-Dokumentation"
=20
-#: git-gui.sh:2186
+#: git-gui.sh:2201
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
-msgstr ""
+msgstr "Fehler: Verzeichnis =C2=BB%s=C2=AB kann nicht gelesen werden: =
Datei oder Verzeichnis nicht gefunden"
=20
-#: git-gui.sh:2219
+#: git-gui.sh:2234
 msgid "Current Branch:"
 msgstr "Aktueller Zweig:"
=20
-#: git-gui.sh:2240
+#: git-gui.sh:2255
 msgid "Staged Changes (Will Commit)"
 msgstr "Bereitgestellte =C3=84nderungen (zum Eintragen)"
=20
-#: git-gui.sh:2259
+#: git-gui.sh:2274
 msgid "Unstaged Changes"
 msgstr "Nicht bereitgestellte =C3=84nderungen"
=20
-#: git-gui.sh:2308
+#: git-gui.sh:2323
 msgid "Stage Changed"
 msgstr "Alles bereitstellen"
=20
-#: git-gui.sh:2324 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2339 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
 msgstr "Versenden"
=20
-#: git-gui.sh:2354
+#: git-gui.sh:2369
 msgid "Initial Commit Message:"
 msgstr "Erste Versionsbeschreibung:"
=20
-#: git-gui.sh:2355
+#: git-gui.sh:2370
 msgid "Amended Commit Message:"
 msgstr "Nachgebesserte Versionsbeschreibung:"
=20
-#: git-gui.sh:2356
+#: git-gui.sh:2371
 msgid "Amended Initial Commit Message:"
 msgstr "Nachgebesserte erste Versionsbeschreibung:"
=20
-#: git-gui.sh:2357
+#: git-gui.sh:2372
 msgid "Amended Merge Commit Message:"
 msgstr "Nachgebesserte Zusammenf=C3=BChrungs-Versionsbeschreibung:"
=20
-#: git-gui.sh:2358
+#: git-gui.sh:2373
 msgid "Merge Commit Message:"
 msgstr "Zusammenf=C3=BChrungs-Versionsbeschreibung:"
=20
-#: git-gui.sh:2359
+#: git-gui.sh:2374
 msgid "Commit Message:"
 msgstr "Versionsbeschreibung:"
=20
-#: git-gui.sh:2404 git-gui.sh:2542 lib/console.tcl:71
+#: git-gui.sh:2419 git-gui.sh:2557 lib/console.tcl:71
 msgid "Copy All"
 msgstr "Alle kopieren"
=20
-#: git-gui.sh:2428 lib/blame.tcl:104
+#: git-gui.sh:2443 lib/blame.tcl:104
 msgid "File:"
 msgstr "Datei:"
=20
-#: git-gui.sh:2530
+#: git-gui.sh:2545
 msgid "Refresh"
 msgstr "Aktualisieren"
=20
-#: git-gui.sh:2551
+#: git-gui.sh:2566
 msgid "Apply/Reverse Hunk"
 msgstr "=C3=84nderung anwenden/umkehren"
=20
-#: git-gui.sh:2557
+#: git-gui.sh:2572
 msgid "Decrease Font Size"
 msgstr "Schriftgr=C3=B6=C3=9Fe verkleinern"
=20
-#: git-gui.sh:2561
+#: git-gui.sh:2576
 msgid "Increase Font Size"
 msgstr "Schriftgr=C3=B6=C3=9Fe vergr=C3=B6=C3=9Fern"
=20
-#: git-gui.sh:2566
+#: git-gui.sh:2581
 msgid "Show Less Context"
 msgstr "Weniger Kontext anzeigen"
=20
-#: git-gui.sh:2573
+#: git-gui.sh:2588
 msgid "Show More Context"
 msgstr "Mehr Kontext anzeigen"
=20
-#: git-gui.sh:2587
+#: git-gui.sh:2602
 msgid "Unstage Hunk From Commit"
 msgstr "Aus der Bereitstellung herausnehmen"
=20
-#: git-gui.sh:2589
+#: git-gui.sh:2604
 msgid "Stage Hunk For Commit"
 msgstr "In die Bereitstellung hinzuf=C3=BCgen"
=20
-#: git-gui.sh:2608
+#: git-gui.sh:2623
 msgid "Initializing..."
 msgstr "Initialisieren..."
=20
-#: git-gui.sh:2699
+#: git-gui.sh:2718
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -443,15 +443,23 @@ msgid ""
 "by %s:\n"
 "\n"
 msgstr ""
+"M=C3=B6glicherweise gibt es Probleme mit manchen Umgebungsvariablen.\=
n"
+"\n"
+"Die folgenden Umgebungsvariablen k=C3=B6nnen vermutlich nicht \n"
+"von %s an Git weitergegeben werden:\n"
+"\n"
=20
-#: git-gui.sh:2729
+#: git-gui.sh:2748
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
 "Tcl binary distributed by Cygwin."
 msgstr ""
+"\n"
+"Dies ist ein bekanntes Problem der Tcl-Version, die\n"
+"in Cygwin mitgeliefert wird."
=20
-#: git-gui.sh:2734
+#: git-gui.sh:2753
 #, tcl-format
 msgid ""
 "\n"
@@ -461,6 +469,11 @@ msgid ""
 "user.email settings into your personal\n"
 "~/.gitconfig file.\n"
 msgstr ""
+"\n"
+"\n"
+"Um den Namen =C2=BB%s=C2=AB zu =C3=A4ndern, sollten Sie die \n"
+"gew=C3=BCnschten Werte f=C3=BCr die Einstellung user.name und \n"
+"user.email in Ihre Datei ~/.gitconfig einf=C3=BCgen.\n"
=20
 #: lib/about.tcl:25
 msgid "git-gui - a graphical user interface for Git."
@@ -485,19 +498,19 @@ msgstr "%s lesen..."
=20
 #: lib/blame.tcl:473
 msgid "Loading copy/move tracking annotations..."
-msgstr ""
+msgstr "Annotierungen f=C3=BCr Kopieren/Verschieben werden geladen..."
=20
 #: lib/blame.tcl:493
 msgid "lines annotated"
-msgstr ""
+msgstr "Zeilen annotiert"
=20
 #: lib/blame.tcl:674
 msgid "Loading original location annotations..."
-msgstr ""
+msgstr "Annotierungen f=C3=BCr urspr=C3=BCnglichen Ort werden geladen.=
=2E."
=20
 #: lib/blame.tcl:677
 msgid "Annotation complete."
-msgstr ""
+msgstr "Annotierung vollst=C3=A4ndig."
=20
 #: lib/blame.tcl:731
 msgid "Loading annotation..."
@@ -733,7 +746,7 @@ msgstr "=C3=84nderungen =C2=BB%s=C2=AB von =C2=BB%s=
=C2=AB anfordern"
 #: lib/checkout_op.tcl:127
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
-msgstr ""
+msgstr "Fehler: =C2=BB%s=C2=AB kann nicht als Zweig oder Version erkan=
nt werden"
=20
 #: lib/checkout_op.tcl:140 lib/console.tcl:79 lib/database.tcl:31
 msgid "Close"
@@ -994,20 +1007,20 @@ msgstr "Verkn=C3=BCpft ist nur f=C3=BCr lokale P=
rojektarchive verf=C3=BCgbar."
=20
 #: lib/choose_repository.tcl:617
 msgid "Failed to configure origin"
-msgstr ""
+msgstr "Der Ursprungsort konnte nicht eingerichtet werden"
=20
 #: lib/choose_repository.tcl:629
 msgid "Counting objects"
-msgstr ""
+msgstr "Objekte werden gez=C3=A4hlt"
=20
 #: lib/choose_repository.tcl:630
 msgid "buckets"
-msgstr ""
+msgstr "Buckets"
=20
 #: lib/choose_repository.tcl:654
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
-msgstr ""
+msgstr "Kopien von Objekten/Info/Alternates konnten nicht erstellt wer=
den: %s"
=20
 #: lib/choose_repository.tcl:690
 #, tcl-format
@@ -1017,11 +1030,11 @@ msgstr "Von =C2=BB%s=C2=AB konnte nichts kopier=
t werden."
 #: lib/choose_repository.tcl:692 lib/choose_repository.tcl:906
 #: lib/choose_repository.tcl:918
 msgid "The 'master' branch has not been initialized."
-msgstr ""
+msgstr "Der =C2=BBmaster=C2=AB-Zweig wurde noch nicht initialisiert."
=20
 #: lib/choose_repository.tcl:705
 msgid "Hardlinks are unavailable.  Falling back to copying."
-msgstr ""
+msgstr "Hardlinks nicht verf=C3=BCgbar. Stattdessen wird kopiert."
=20
 #: lib/choose_repository.tcl:717
 #, tcl-format
@@ -1052,24 +1065,24 @@ msgstr "Objekte"
 #: lib/choose_repository.tcl:792
 #, tcl-format
 msgid "Unable to hardlink object: %s"
-msgstr "Objekt kann nicht hartverlinkt werden: %s"
+msgstr "F=C3=BCr Objekt konnte kein Hardlink erstellt werden: %s"
=20
 #: lib/choose_repository.tcl:847
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
-msgstr ""
+msgstr "Zweige und Objekte konnten nicht angefordert werden.  Kontroll=
ieren Sie die Ausgaben auf der Konsole f=C3=BCr weitere Angaben."
=20
 #: lib/choose_repository.tcl:858
 msgid "Cannot fetch tags.  See console output for details."
-msgstr ""
+msgstr "Markierungen konnten nicht angefordert werden.  Kontrollieren =
Sie die Ausgaben auf der Konsole f=C3=BCr weitere Angaben."
=20
 #: lib/choose_repository.tcl:882
 msgid "Cannot determine HEAD.  See console output for details."
-msgstr ""
+msgstr "Die Zweigspitze (HEAD) konnte nicht gefunden werden.  Kontroll=
ieren Sie die Ausgaben auf der Konsole f=C3=BCr weitere Angaben."
=20
 #: lib/choose_repository.tcl:891
 #, tcl-format
 msgid "Unable to cleanup %s"
-msgstr ""
+msgstr "Verzeichnis =C2=BB%s=C2=AB kann nicht aufger=C3=A4umt werden."
=20
 #: lib/choose_repository.tcl:897
 msgid "Clone failed."
@@ -1077,25 +1090,25 @@ msgstr "Kopieren fehlgeschlagen."
=20
 #: lib/choose_repository.tcl:904
 msgid "No default branch obtained."
-msgstr ""
+msgstr "Kein voreingestellter Zweig gefunden."
=20
 #: lib/choose_repository.tcl:915
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
-msgstr ""
+msgstr "=C2=BB%s=C2=AB wurde nicht als Version gefunden."
=20
 #: lib/choose_repository.tcl:927
 msgid "Creating working directory"
 msgstr "Arbeitskopie erstellen"
=20
-#: lib/choose_repository.tcl:928 lib/index.tcl:15 lib/index.tcl:80
-#: lib/index.tcl:149
+#: lib/choose_repository.tcl:928 lib/index.tcl:65 lib/index.tcl:127
+#: lib/index.tcl:193
 msgid "files"
 msgstr "Dateien"
=20
 #: lib/choose_repository.tcl:957
 msgid "Initial file checkout failed."
-msgstr ""
+msgstr "Erstellen der Arbeitskopie fehlgeschlagen."
=20
 #: lib/choose_repository.tcl:973
 msgid "Open"
@@ -1246,7 +1259,7 @@ msgid ""
 "\n"
 "A good commit message has the following format:\n"
 "\n"
-"- First line: Describe in one sentance what you did.\n"
+"- First line: Describe in one sentence what you did.\n"
 "- Second line: Blank\n"
 "- Remaining lines: Describe why this change is good.\n"
 msgstr ""
@@ -1291,7 +1304,7 @@ msgstr "Keine =C3=84nderungen, die eingetragen we=
rden k=C3=B6nnen."
 #: lib/commit.tcl:303
 #, tcl-format
 msgid "warning: Tcl does not support encoding '%s'."
-msgstr ""
+msgstr "Warning: Tcl/Tk unterst=C3=BCtzt die Zeichencodierung =C2=BB%s=
=C2=AB nicht."
=20
 #: lib/commit.tcl:317
 msgid "commit-tree failed:"
@@ -1446,32 +1459,54 @@ msgid "You must correct the above errors before=
 committing."
 msgstr ""
 "Sie m=C3=BCssen die obigen Fehler zuerst beheben, bevor Sie eintragen=
 k=C3=B6nnen."
=20
-#: lib/index.tcl:241
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "Bereitstellung kann nicht wieder freigegeben werden."
+
+#: lib/index.tcl:15
+msgid "Index Error"
+msgstr "Fehler in Bereitstellung"
+
+#: lib/index.tcl:21
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically starte=
d to "
+"resynchronize git-gui."
+msgstr "Das Aktualisieren der Git-Bereitstellung ist fehlgeschlagen. E=
ine allgemeine Git-Aktualisierung wird jetzt gestartet, um git-gui wied=
er mit git zu synchronisieren."
+
+#: lib/index.tcl:27
+msgid "Continue"
+msgstr "Fortsetzen"
+
+#: lib/index.tcl:31
+msgid "Unlock Index"
+msgstr "Bereitstellung freigeben"
+
+#: lib/index.tcl:282
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "Datei =C2=BB%s=C2=AB aus der Bereitstellung herausnehmen"
=20
-#: lib/index.tcl:285
+#: lib/index.tcl:326
 #, tcl-format
 msgid "Adding %s"
 msgstr "=C2=BB%s=C2=AB hinzuf=C3=BCgen..."
=20
-#: lib/index.tcl:340
+#: lib/index.tcl:381
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "=C3=84nderungen in Datei =C2=BB%s=C2=AB revidieren?"
=20
-#: lib/index.tcl:342
+#: lib/index.tcl:383
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "=C3=84nderungen in den gew=C3=A4hlten %i Dateien revidieren?"
=20
-#: lib/index.tcl:348
+#: lib/index.tcl:389
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 "Alle nicht bereitgestellten =C3=84nderungen werden beim Revidieren ve=
rloren gehen."
=20
-#: lib/index.tcl:351
+#: lib/index.tcl:392
 msgid "Do Nothing"
 msgstr "Nichts tun"
=20
@@ -1867,12 +1902,3 @@ msgstr "Kompaktes Datenformat benutzen (f=C3=BCr=
 langsame Netzverbindungen)"
 #: lib/transport.tcl:168
 msgid "Include tags"
 msgstr "Mit Markierungen =C3=BCbertragen"
-
-#~ msgid "Next >"
-#~ msgstr "Weiter >"
-
-#~ msgid "Fetch"
-#~ msgstr "Anfordern"
-
-#~ msgid "Unstaged Changes (Will Not Be Committed)"
-#~ msgstr "Nicht bereitgestellte =C3=84nderungen (werden nicht eingetr=
agen)"
--=20
1.5.3.4.206.g58ba4
