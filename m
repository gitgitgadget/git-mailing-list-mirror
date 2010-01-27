From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] git-gui: Update German translation (12 new or changed strings).
Date: Wed, 27 Jan 2010 20:11:43 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <201001272011.44332.stimming@tuhh.de>
References: <201001262228.11651.stimming@tuhh.de> <20100126235214.GG15015@spearce.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_w/IYLCKTQr7h/lN"
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 20:12:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaDJ7-0006EQ-Tw
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 20:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab0A0TL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 14:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440Ab0A0TL6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 14:11:58 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:58494 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab0A0TL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 14:11:56 -0500
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id o0RJBr3f005713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 27 Jan 2010 20:11:53 +0100
Received: from ckiste.localnet (e176217185.adsl.alicedsl.de [85.176.217.185])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id o0RJBoVa024356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Jan 2010 20:11:53 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-generic; KDE/4.3.2; i686; ; )
In-Reply-To: <20100126235214.GG15015@spearce.org>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138185>

--Boundary-00=_w/IYLCKTQr7h/lN
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Am Mittwoch, 27. Januar 2010 schrieb Shawn O. Pearce:
> >  po/de.po |  824
> > ++++++++++++++++++++++++++++++++------------------------------ 1 files
> > changed, 426 insertions(+), 398 deletions(-)
> 
> Ugh.  This won't apply to my published master branch.  I'm guessing
> mailer damage somewhere in the chain, most likely on my end since
> I've never been able to apply an inline translation patch cleanly.
> 
> Can you please resend as an attachment?

Sure. Sorry for forgetting about that. Patch attached.

Christian

--Boundary-00=_w/IYLCKTQr7h/lN
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-git-gui-Update-German-translation-12-new-or-changed-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-git-gui-Update-German-translation-12-new-or-changed-.patch"

=46rom fb81d92bd53203c5318547dc0f974abbc2fc755e Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Tue, 26 Jan 2010 22:26:45 +0100
Subject: [PATCH] git-gui: Update German translation (12 new or changed stri=
ngs).

=2D--
 po/de.po |  824 ++++++++++++++++++++++++++++++++--------------------------=
=2D---
 1 files changed, 426 insertions(+), 398 deletions(-)

diff --git a/po/de.po b/po/de.po
index 51abb50..44c5ddc 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -7,41 +7,41 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2008-12-06 20:51+0100\n"
=2D"PO-Revision-Date: 2008-12-06 21:22+0100\n"
+"POT-Creation-Date: 2010-01-26 22:22+0100\n"
+"PO-Revision-Date: 2010-01-26 22:25+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
=2D#: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.sh=
:744
=2D#: git-gui.sh:763
+#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.sh:9=
03
+#: git-gui.sh:922
 msgid "git-gui: fatal error"
 msgstr "git-gui: Programmfehler"
=20
=2D#: git-gui.sh:593
+#: git-gui.sh:743
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "Ung=C3=BCltige Zeichensatz-Angabe in %s:"
=20
=2D#: git-gui.sh:620
+#: git-gui.sh:779
 msgid "Main Font"
 msgstr "Programmschriftart"
=20
=2D#: git-gui.sh:621
+#: git-gui.sh:780
 msgid "Diff/Console Font"
 msgstr "Vergleich-Schriftart"
=20
=2D#: git-gui.sh:635
+#: git-gui.sh:794
 msgid "Cannot find git in PATH."
 msgstr "Git kann im PATH nicht gefunden werden."
=20
=2D#: git-gui.sh:662
+#: git-gui.sh:821
 msgid "Cannot parse Git version string:"
 msgstr "Git Versionsangabe kann nicht erkannt werden:"
=20
=2D#: git-gui.sh:680
+#: git-gui.sh:839
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -60,447 +60,479 @@ msgstr ""
 "\n"
 "Soll angenommen werden, =C2=BB%s=C2=AB sei Version 1.5.0?\n"
=20
=2D#: git-gui.sh:918
+#: git-gui.sh:1128
 msgid "Git directory not found:"
 msgstr "Git-Verzeichnis nicht gefunden:"
=20
=2D#: git-gui.sh:925
+#: git-gui.sh:1146
 msgid "Cannot move to top of working directory:"
 msgstr ""
 "Es konnte nicht in das oberste Verzeichnis der Arbeitskopie gewechselt "
 "werden:"
=20
=2D#: git-gui.sh:932
=2Dmsgid "Cannot use funny .git directory:"
=2Dmsgstr "Unerwartete Struktur des .git Verzeichnis:"
+#: git-gui.sh:1154
+msgid "Cannot use bare repository:"
+msgstr "Leeres Projektarchiv kann nicht benutzt werden:"
=20
=2D#: git-gui.sh:937
+#: git-gui.sh:1162
 msgid "No working directory"
 msgstr "Kein Arbeitsverzeichnis"
=20
=2D#: git-gui.sh:1084 lib/checkout_op.tcl:283
+#: git-gui.sh:1334 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr "Dateistatus aktualisieren..."
=20
=2D#: git-gui.sh:1149
+#: git-gui.sh:1390
 msgid "Scanning for modified files ..."
 msgstr "Nach ge=C3=A4nderten Dateien suchen..."
=20
=2D#: git-gui.sh:1367
+#: git-gui.sh:1454
 msgid "Calling prepare-commit-msg hook..."
 msgstr "Aufrufen der Eintragen-Vorbereiten-Kontrolle..."
=20
=2D#: git-gui.sh:1384
+#: git-gui.sh:1471
 msgid "Commit declined by prepare-commit-msg hook."
=2Dmsgstr "Eintragen abgelehnt durch Eintragen-Vorbereiten-Kontrolle (=C2=
=BBprepare-commit hook=C2=AB)."
+msgstr ""
+"Eintragen abgelehnt durch Eintragen-Vorbereiten-Kontrolle (=C2=BBprepare-=
commit "
+"hook=C2=AB)."
=20
=2D#: git-gui.sh:1542 lib/browser.tcl:246
+#: git-gui.sh:1629 lib/browser.tcl:246
 msgid "Ready."
 msgstr "Bereit."
=20
=2D#: git-gui.sh:1590
+#: git-gui.sh:1787
+#, tcl-format
+msgid "Displaying only %s of %s files."
+msgstr "Nur %s von %s Dateien werden angezeigt."
+
+#: git-gui.sh:1913
 msgid "Unmodified"
 msgstr "Unver=C3=A4ndert"
=20
=2D#: git-gui.sh:1592
+#: git-gui.sh:1915
 msgid "Modified, not staged"
 msgstr "Ver=C3=A4ndert, nicht bereitgestellt"
=20
=2D#: git-gui.sh:1593 git-gui.sh:1598
+#: git-gui.sh:1916 git-gui.sh:1924
 msgid "Staged for commit"
 msgstr "Bereitgestellt zum Eintragen"
=20
=2D#: git-gui.sh:1594 git-gui.sh:1599
+#: git-gui.sh:1917 git-gui.sh:1925
 msgid "Portions staged for commit"
 msgstr "Teilweise bereitgestellt zum Eintragen"
=20
=2D#: git-gui.sh:1595 git-gui.sh:1600
+#: git-gui.sh:1918 git-gui.sh:1926
 msgid "Staged for commit, missing"
 msgstr "Bereitgestellt zum Eintragen, fehlend"
=20
=2D#: git-gui.sh:1658
+#: git-gui.sh:1920
 msgid "File type changed, not staged"
 msgstr "Dateityp ge=C3=A4ndert, nicht bereitgestellt"
=20
=2D#: git-gui.sh:1659
+#: git-gui.sh:1921
 msgid "File type changed, staged"
 msgstr "Dateityp ge=C3=A4ndert, bereitgestellt"
=20
=2D#: git-gui.sh:1661
+#: git-gui.sh:1923
 msgid "Untracked, not staged"
 msgstr "Nicht unter Versionskontrolle, nicht bereitgestellt"
=20
=2D#: git-gui.sh:1602
+#: git-gui.sh:1928
 msgid "Missing"
 msgstr "Fehlend"
=20
=2D#: git-gui.sh:1603
+#: git-gui.sh:1929
 msgid "Staged for removal"
 msgstr "Bereitgestellt zum L=C3=B6schen"
=20
=2D#: git-gui.sh:1604
+#: git-gui.sh:1930
 msgid "Staged for removal, still present"
 msgstr "Bereitgestellt zum L=C3=B6schen, trotzdem vorhanden"
=20
=2D#: git-gui.sh:1606 git-gui.sh:1607 git-gui.sh:1608 git-gui.sh:1609
+#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
+#: git-gui.sh:1936 git-gui.sh:1937
 msgid "Requires merge resolution"
 msgstr "Konfliktaufl=C3=B6sung n=C3=B6tig"
=20
=2D#: git-gui.sh:1644
+#: git-gui.sh:1972
 msgid "Starting gitk... please wait..."
 msgstr "Gitk wird gestartet... bitte warten."
=20
=2D#: git-gui.sh:1698
+#: git-gui.sh:1984
 msgid "Couldn't find gitk in PATH"
 msgstr "Gitk kann im PATH nicht gefunden werden."
=20
=2D#: git-gui.sh:1948 lib/choose_repository.tcl:36
+#: git-gui.sh:2043
+msgid "Couldn't find git gui in PATH"
+msgstr "=C2=BBGit gui=C2=AB kann im PATH nicht gefunden werden."
+
+#: git-gui.sh:2455 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "Projektarchiv"
=20
=2D#: git-gui.sh:1861
+#: git-gui.sh:2456
 msgid "Edit"
 msgstr "Bearbeiten"
=20
=2D#: git-gui.sh:1863 lib/choose_rev.tcl:561
+#: git-gui.sh:2458 lib/choose_rev.tcl:561
 msgid "Branch"
 msgstr "Zweig"
=20
=2D#: git-gui.sh:1866 lib/choose_rev.tcl:548
+#: git-gui.sh:2461 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
 msgstr "Version"
=20
=2D#: git-gui.sh:1869 lib/merge.tcl:120 lib/merge.tcl:149 lib/merge.tcl:167
+#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
 msgid "Merge"
 msgstr "Zusammenf=C3=BChren"
=20
=2D#: git-gui.sh:1870 lib/choose_rev.tcl:557
+#: git-gui.sh:2465 lib/choose_rev.tcl:557
 msgid "Remote"
 msgstr "Andere Archive"
=20
=2D#: git-gui.sh:2293
+#: git-gui.sh:2468
 msgid "Tools"
 msgstr "Werkzeuge"
=20
=2D#: git-gui.sh:2302
+#: git-gui.sh:2477
 msgid "Explore Working Copy"
 msgstr "Arbeitskopie im Dateimanager"
=20
=2D#: git-gui.sh:2247
+#: git-gui.sh:2483
 msgid "Browse Current Branch's Files"
 msgstr "Aktuellen Zweig durchbl=C3=A4ttern"
=20
=2D#: git-gui.sh:1883
+#: git-gui.sh:2487
 msgid "Browse Branch Files..."
 msgstr "Einen Zweig durchbl=C3=A4ttern..."
=20
=2D#: git-gui.sh:1888
+#: git-gui.sh:2492
 msgid "Visualize Current Branch's History"
 msgstr "Aktuellen Zweig darstellen"
=20
=2D#: git-gui.sh:1892
+#: git-gui.sh:2496
 msgid "Visualize All Branch History"
 msgstr "Alle Zweige darstellen"
=20
=2D#: git-gui.sh:1899
+#: git-gui.sh:2503
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Zweig =C2=BB%s=C2=AB durchbl=C3=A4ttern"
=20
=2D#: git-gui.sh:1901
+#: git-gui.sh:2505
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Historie von =C2=BB%s=C2=AB darstellen"
=20
=2D#: git-gui.sh:1906 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Datenbankstatistik"
=20
=2D#: git-gui.sh:1909 lib/database.tcl:34
+#: git-gui.sh:2513 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "Datenbank komprimieren"
=20
=2D#: git-gui.sh:1912
+#: git-gui.sh:2516
 msgid "Verify Database"
 msgstr "Datenbank =C3=BCberpr=C3=BCfen"
=20
=2D#: git-gui.sh:1919 git-gui.sh:1923 git-gui.sh:1927 lib/shortcut.tcl:7
=2D#: lib/shortcut.tcl:39 lib/shortcut.tcl:71
+#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
+#: lib/shortcut.tcl:40 lib/shortcut.tcl:72
 msgid "Create Desktop Icon"
 msgstr "Desktop-Icon erstellen"
=20
=2D#: git-gui.sh:1932 lib/choose_repository.tcl:177 lib/choose_repository.t=
cl:185
+#: git-gui.sh:2539 lib/choose_repository.tcl:183 lib/choose_repository.tcl=
:191
 msgid "Quit"
 msgstr "Beenden"
=20
=2D#: git-gui.sh:1939
+#: git-gui.sh:2547
 msgid "Undo"
 msgstr "R=C3=BCckg=C3=A4ngig"
=20
=2D#: git-gui.sh:1942
+#: git-gui.sh:2550
 msgid "Redo"
 msgstr "Wiederholen"
=20
=2D#: git-gui.sh:1946 git-gui.sh:2443
+#: git-gui.sh:2554 git-gui.sh:3109
 msgid "Cut"
 msgstr "Ausschneiden"
=20
=2D#: git-gui.sh:1949 git-gui.sh:2446 git-gui.sh:2520 git-gui.sh:2614
+#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "Kopieren"
=20
=2D#: git-gui.sh:1952 git-gui.sh:2449
+#: git-gui.sh:2560 git-gui.sh:3115
 msgid "Paste"
 msgstr "Einf=C3=BCgen"
=20
=2D#: git-gui.sh:1955 git-gui.sh:2452 lib/branch_delete.tcl:26
+#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "L=C3=B6schen"
=20
=2D#: git-gui.sh:1959 git-gui.sh:2456 git-gui.sh:2618 lib/console.tcl:71
+#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
 msgid "Select All"
 msgstr "Alle ausw=C3=A4hlen"
=20
=2D#: git-gui.sh:1968
+#: git-gui.sh:2576
 msgid "Create..."
 msgstr "Erstellen..."
=20
=2D#: git-gui.sh:1974
+#: git-gui.sh:2582
 msgid "Checkout..."
 msgstr "Umstellen..."
=20
=2D#: git-gui.sh:1980
+#: git-gui.sh:2588
 msgid "Rename..."
 msgstr "Umbenennen..."
=20
=2D#: git-gui.sh:1985 git-gui.sh:2085
+#: git-gui.sh:2593
 msgid "Delete..."
 msgstr "L=C3=B6schen..."
=20
=2D#: git-gui.sh:1990
+#: git-gui.sh:2598
 msgid "Reset..."
 msgstr "Zur=C3=BCcksetzen..."
=20
=2D#: git-gui.sh:2372
+#: git-gui.sh:2608
 msgid "Done"
 msgstr "Fertig"
=20
=2D#: git-gui.sh:2374
+#: git-gui.sh:2610
 msgid "Commit@@verb"
 msgstr "Eintragen"
=20
=2D#: git-gui.sh:2383 git-gui.sh:2786
+#: git-gui.sh:2619 git-gui.sh:3050
 msgid "New Commit"
 msgstr "Neue Version"
=20
=2D#: git-gui.sh:2010 git-gui.sh:2396
+#: git-gui.sh:2627 git-gui.sh:3057
 msgid "Amend Last Commit"
 msgstr "Letzte nachbessern"
=20
=2D#: git-gui.sh:2019 git-gui.sh:2356 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "Neu laden"
=20
=2D#: git-gui.sh:2025
+#: git-gui.sh:2643
 msgid "Stage To Commit"
 msgstr "Zum Eintragen bereitstellen"
=20
=2D#: git-gui.sh:2031
+#: git-gui.sh:2649
 msgid "Stage Changed Files To Commit"
 msgstr "Ge=C3=A4nderte Dateien bereitstellen"
=20
=2D#: git-gui.sh:2037
+#: git-gui.sh:2655
 msgid "Unstage From Commit"
 msgstr "Aus der Bereitstellung herausnehmen"
=20
=2D#: git-gui.sh:2042 lib/index.tcl:395
+#: git-gui.sh:2661 lib/index.tcl:412
 msgid "Revert Changes"
 msgstr "=C3=84nderungen verwerfen"
=20
=2D#: git-gui.sh:2141 git-gui.sh:2702
+#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
 msgid "Show Less Context"
 msgstr "Weniger Zeilen anzeigen"
=20
=2D#: git-gui.sh:2145 git-gui.sh:2706
+#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
 msgid "Show More Context"
 msgstr "Mehr Zeilen anzeigen"
=20
=2D#: git-gui.sh:2151 git-gui.sh:2470 git-gui.sh:2569
+#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
 msgid "Sign Off"
 msgstr "Abzeichnen"
=20
=2D#: git-gui.sh:2458
+#: git-gui.sh:2696
 msgid "Local Merge..."
 msgstr "Lokales Zusammenf=C3=BChren..."
=20
=2D#: git-gui.sh:2069
+#: git-gui.sh:2701
 msgid "Abort Merge..."
 msgstr "Zusammenf=C3=BChren abbrechen..."
=20
=2D#: git-gui.sh:2475
+#: git-gui.sh:2713 git-gui.sh:2741
 msgid "Add..."
 msgstr "Hinzuf=C3=BCgen..."
=20
=2D#: git-gui.sh:2479
+#: git-gui.sh:2717
 msgid "Push..."
 msgstr "Versenden..."
=20
=2D#: git-gui.sh:2483
+#: git-gui.sh:2721
 msgid "Delete Branch..."
 msgstr "Zweig l=C3=B6schen..."
=20
=2D#: git-gui.sh:2493 git-gui.sh:2515 lib/about.tcl:14
=2D#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
=2D#, tcl-format
=2Dmsgid "About %s"
=2Dmsgstr "=C3=9Cber %s"
=2D
=2D#: git-gui.sh:2099
=2Dmsgid "Preferences..."
=2Dmsgstr "Einstellungen..."
=2D
=2D#: git-gui.sh:2107 git-gui.sh:2639
+#: git-gui.sh:2731 git-gui.sh:3292
 msgid "Options..."
 msgstr "Optionen..."
=20
=2D#: git-gui.sh:2576
+#: git-gui.sh:2742
 msgid "Remove..."
 msgstr "Entfernen..."
=20
=2D#: git-gui.sh:2585 lib/choose_repository.tcl:50
+#: git-gui.sh:2751 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr "Hilfe"
=20
=2D#: git-gui.sh:2154
+#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
+#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
+#, tcl-format
+msgid "About %s"
+msgstr "=C3=9Cber %s"
+
+#: git-gui.sh:2783
 msgid "Online Documentation"
 msgstr "Online-Dokumentation"
=20
=2D#: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.tc=
l:56
+#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.tcl:=
56
 msgid "Show SSH Key"
 msgstr "SSH-Schl=C3=BCssel anzeigen"
=20
=2D#: git-gui.sh:2707
+#: git-gui.sh:2893
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 "Fehler: Verzeichnis =C2=BB%s=C2=AB kann nicht gelesen werden: Datei oder =
Verzeichnis "
 "nicht gefunden"
=20
=2D#: git-gui.sh:2271
+#: git-gui.sh:2926
 msgid "Current Branch:"
 msgstr "Aktueller Zweig:"
=20
=2D#: git-gui.sh:2292
+#: git-gui.sh:2947
 msgid "Staged Changes (Will Commit)"
 msgstr "Bereitstellung (zum Eintragen)"
=20
=2D#: git-gui.sh:2312
+#: git-gui.sh:2967
 msgid "Unstaged Changes"
 msgstr "Nicht bereitgestellte =C3=84nderungen"
=20
=2D#: git-gui.sh:2362
+#: git-gui.sh:3017
 msgid "Stage Changed"
 msgstr "Alles bereitstellen"
=20
=2D#: git-gui.sh:2378 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
 msgid "Push"
 msgstr "Versenden"
=20
=2D#: git-gui.sh:2408
+#: git-gui.sh:3071
 msgid "Initial Commit Message:"
 msgstr "Erste Versionsbeschreibung:"
=20
=2D#: git-gui.sh:2409
+#: git-gui.sh:3072
 msgid "Amended Commit Message:"
 msgstr "Nachgebesserte Beschreibung:"
=20
=2D#: git-gui.sh:2410
+#: git-gui.sh:3073
 msgid "Amended Initial Commit Message:"
 msgstr "Nachgebesserte erste Beschreibung:"
=20
=2D#: git-gui.sh:2411
+#: git-gui.sh:3074
 msgid "Amended Merge Commit Message:"
 msgstr "Nachgebesserte Zusammenf=C3=BChrungs-Beschreibung:"
=20
=2D#: git-gui.sh:2412
+#: git-gui.sh:3075
 msgid "Merge Commit Message:"
 msgstr "Zusammenf=C3=BChrungs-Beschreibung:"
=20
=2D#: git-gui.sh:2413
+#: git-gui.sh:3076
 msgid "Commit Message:"
 msgstr "Versionsbeschreibung:"
=20
=2D#: git-gui.sh:2459 git-gui.sh:2622 lib/console.tcl:73
+#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
 msgid "Copy All"
 msgstr "Alle kopieren"
=20
=2D#: git-gui.sh:2483 lib/blame.tcl:107
+#: git-gui.sh:3149 lib/blame.tcl:104
 msgid "File:"
 msgstr "Datei:"
=20
=2D#: git-gui.sh:2834
+#: git-gui.sh:3255
 msgid "Refresh"
 msgstr "Aktualisieren"
=20
=2D#: git-gui.sh:2631
+#: git-gui.sh:3276
 msgid "Decrease Font Size"
 msgstr "Schriftgr=C3=B6=C3=9Fe verkleinern"
=20
=2D#: git-gui.sh:2635
+#: git-gui.sh:3280
 msgid "Increase Font Size"
 msgstr "Schriftgr=C3=B6=C3=9Fe vergr=C3=B6=C3=9Fern"
=20
=2D#: git-gui.sh:3033 lib/blame.tcl:281
+#: git-gui.sh:3288 lib/blame.tcl:281
 msgid "Encoding"
 msgstr "Zeichenkodierung"
=20
=2D#: git-gui.sh:3044
+#: git-gui.sh:3299
 msgid "Apply/Reverse Hunk"
 msgstr "Kontext anwenden/umkehren"
=20
=2D#: git-gui.sh:2875
+#: git-gui.sh:3304
 msgid "Apply/Reverse Line"
 msgstr "Zeile anwenden/umkehren"
=20
=2D#: git-gui.sh:2885
+#: git-gui.sh:3323
 msgid "Run Merge Tool"
 msgstr "Zusammenf=C3=BChrungswerkzeug"
=20
=2D#: git-gui.sh:2890
+#: git-gui.sh:3328
 msgid "Use Remote Version"
 msgstr "Entfernte Version benutzen"
=20
=2D#: git-gui.sh:2894
+#: git-gui.sh:3332
 msgid "Use Local Version"
 msgstr "Lokale Version benutzen"
=20
=2D#: git-gui.sh:2898
+#: git-gui.sh:3336
 msgid "Revert To Base"
 msgstr "Urspr=C3=BCngliche Version benutzen"
=20
=2D#: git-gui.sh:3091
+#: git-gui.sh:3354
+msgid "Visualize These Changes In The Submodule"
+msgstr "Diese =C3=84nderungen im Untermodul darstellen"
+
+#: git-gui.sh:3358
+msgid "Visualize Current Branch History In The Submodule"
+msgstr "Aktuellen Zweig im Untermodul darstellen"
+
+#: git-gui.sh:3362
+msgid "Visualize All Branch History In The Submodule"
+msgstr "Alle Zweige im Untermodul darstellen"
+
+#: git-gui.sh:3367
+msgid "Start git gui In The Submodule"
+msgstr "Git gui im Untermodul starten"
+
+#: git-gui.sh:3389
 msgid "Unstage Hunk From Commit"
 msgstr "Kontext aus Bereitstellung herausnehmen"
=20
=2D#: git-gui.sh:2748
+#: git-gui.sh:3391
+msgid "Unstage Lines From Commit"
+msgstr "Zeilen aus der Bereitstellung herausnehmen"
+
+#: git-gui.sh:3393
 msgid "Unstage Line From Commit"
 msgstr "Zeile aus der Bereitstellung herausnehmen"
=20
=2D#: git-gui.sh:2750
+#: git-gui.sh:3396
 msgid "Stage Hunk For Commit"
 msgstr "Kontext zur Bereitstellung hinzuf=C3=BCgen"
=20
=2D#: git-gui.sh:2751
+#: git-gui.sh:3398
+msgid "Stage Lines For Commit"
+msgstr "Zeilen zur Bereitstellung hinzuf=C3=BCgen"
+
+#: git-gui.sh:3400
 msgid "Stage Line For Commit"
 msgstr "Zeile zur Bereitstellung hinzuf=C3=BCgen"
=20
=2D#: git-gui.sh:2771
+#: git-gui.sh:3424
 msgid "Initializing..."
 msgstr "Initialisieren..."
=20
=2D#: git-gui.sh:2762
+#: git-gui.sh:3541
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -516,7 +548,7 @@ msgstr ""
 "von %s an Git weitergegeben werden:\n"
 "\n"
=20
=2D#: git-gui.sh:2792
+#: git-gui.sh:3570
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -526,7 +558,7 @@ msgstr ""
 "Dies ist ein bekanntes Problem der Tcl-Version, die\n"
 "in Cygwin mitgeliefert wird."
=20
=2D#: git-gui.sh:2797
+#: git-gui.sh:3575
 #, tcl-format
 msgid ""
 "\n"
@@ -546,15 +578,15 @@ msgstr ""
 msgid "git-gui - a graphical user interface for Git."
 msgstr "git-gui - eine grafische Oberfl=C3=A4che f=C3=BCr Git."
=20
=2D#: lib/blame.tcl:77
+#: lib/blame.tcl:72
 msgid "File Viewer"
 msgstr "Datei-Browser"
=20
=2D#: lib/blame.tcl:81
+#: lib/blame.tcl:78
 msgid "Commit:"
 msgstr "Version:"
=20
=2D#: lib/blame.tcl:264
+#: lib/blame.tcl:271
 msgid "Copy Commit"
 msgstr "Version kopieren"
=20
@@ -566,88 +598,88 @@ msgstr "Text suchen..."
 msgid "Do Full Copy Detection"
 msgstr "Volle Kopie-Erkennung"
=20
=2D#: lib/blame.tcl:263
+#: lib/blame.tcl:288
 msgid "Show History Context"
 msgstr "Historien-Kontext anzeigen"
=20
=2D#: lib/blame.tcl:266
+#: lib/blame.tcl:291
 msgid "Blame Parent Commit"
 msgstr "Elternversion annotieren"
=20
=2D#: lib/blame.tcl:394
+#: lib/blame.tcl:450
 #, tcl-format
 msgid "Reading %s..."
 msgstr "%s lesen..."
=20
=2D#: lib/blame.tcl:488
+#: lib/blame.tcl:557
 msgid "Loading copy/move tracking annotations..."
 msgstr "Annotierungen f=C3=BCr Kopieren/Verschieben werden geladen..."
=20
=2D#: lib/blame.tcl:508
+#: lib/blame.tcl:577
 msgid "lines annotated"
 msgstr "Zeilen annotiert"
=20
=2D#: lib/blame.tcl:689
+#: lib/blame.tcl:769
 msgid "Loading original location annotations..."
 msgstr "Annotierungen f=C3=BCr urspr=C3=BCnglichen Ort werden geladen..."
=20
=2D#: lib/blame.tcl:692
+#: lib/blame.tcl:772
 msgid "Annotation complete."
 msgstr "Annotierung vollst=C3=A4ndig."
=20
=2D#: lib/blame.tcl:737
+#: lib/blame.tcl:802
 msgid "Busy"
 msgstr "Verarbeitung l=C3=A4uft"
=20
=2D#: lib/blame.tcl:738
+#: lib/blame.tcl:803
 msgid "Annotation process is already running."
 msgstr "Annotierung l=C3=A4uft bereits."
=20
=2D#: lib/blame.tcl:777
+#: lib/blame.tcl:842
 msgid "Running thorough copy detection..."
 msgstr "Intensive Kopie-Erkennung l=C3=A4uft..."
=20
=2D#: lib/blame.tcl:827
+#: lib/blame.tcl:910
 msgid "Loading annotation..."
 msgstr "Annotierung laden..."
=20
=2D#: lib/blame.tcl:802
+#: lib/blame.tcl:963
 msgid "Author:"
 msgstr "Autor:"
=20
=2D#: lib/blame.tcl:806
+#: lib/blame.tcl:967
 msgid "Committer:"
 msgstr "Eintragender:"
=20
=2D#: lib/blame.tcl:811
+#: lib/blame.tcl:972
 msgid "Original File:"
 msgstr "Urspr=C3=BCngliche Datei:"
=20
=2D#: lib/blame.tcl:1021
+#: lib/blame.tcl:1020
 msgid "Cannot find HEAD commit:"
 msgstr "Zweigspitze (=C2=BBHEAD=C2=AB) kann nicht gefunden werden:"
=20
=2D#: lib/blame.tcl:1076
+#: lib/blame.tcl:1075
 msgid "Cannot find parent commit:"
 msgstr "Elternversion kann nicht gefunden werden:"
=20
=2D#: lib/blame.tcl:1001
+#: lib/blame.tcl:1090
 msgid "Unable to display parent"
 msgstr "Elternversion kann nicht angezeigt werden"
=20
=2D#: lib/blame.tcl:1002 lib/diff.tcl:191
+#: lib/blame.tcl:1091 lib/diff.tcl:320
 msgid "Error loading diff:"
 msgstr "Fehler beim Laden des Vergleichs:"
=20
=2D#: lib/blame.tcl:1142
+#: lib/blame.tcl:1231
 msgid "Originally By:"
 msgstr "Urspr=C3=BCnglich von:"
=20
=2D#: lib/blame.tcl:931
+#: lib/blame.tcl:1237
 msgid "In File:"
 msgstr "In Datei:"
=20
=2D#: lib/blame.tcl:936
+#: lib/blame.tcl:1242
 msgid "Copied Or Moved Here By:"
 msgstr "Kopiert oder verschoben durch:"
=20
@@ -661,16 +693,18 @@ msgstr "Umstellen"
=20
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:282
=2D#: lib/checkout_op.tcl:522 lib/choose_font.tcl:43 lib/merge.tcl:171
=2D#: lib/option.tcl:103 lib/remote_branch_delete.tcl:42 lib/transport.tcl:=
97
+#: lib/checkout_op.tcl:579 lib/choose_font.tcl:43 lib/merge.tcl:172
+#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.tcl:42
+#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
+#: lib/transport.tcl:108
 msgid "Cancel"
 msgstr "Abbrechen"
=20
=2D#: lib/branch_checkout.tcl:32 lib/browser.tcl:287
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:328
 msgid "Revision"
 msgstr "Version"
=20
=2D#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:242
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:280
 msgid "Options"
 msgstr "Optionen"
=20
@@ -690,7 +724,7 @@ msgstr "Zweig erstellen"
 msgid "Create New Branch"
 msgstr "Neuen Zweig erstellen"
=20
=2D#: lib/branch_create.tcl:31 lib/choose_repository.tcl:371
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
 msgid "Create"
 msgstr "Erstellen"
=20
@@ -698,7 +732,7 @@ msgstr "Erstellen"
 msgid "Branch Name"
 msgstr "Zweigname"
=20
=2D#: lib/branch_create.tcl:43
+#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
 msgid "Name:"
 msgstr "Name:"
=20
@@ -722,7 +756,7 @@ msgstr "Nein"
 msgid "Fast Forward Only"
 msgstr "Nur Schnellzusammenf=C3=BChrung"
=20
=2D#: lib/branch_create.tcl:85 lib/checkout_op.tcl:514
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:571
 msgid "Reset"
 msgstr "Zur=C3=BCcksetzen"
=20
@@ -764,15 +798,26 @@ msgstr "Lokale Zweige"
 msgid "Delete Only If Merged Into"
 msgstr "Nur l=C3=B6schen, wenn zusammengef=C3=BChrt nach"
=20
=2D#: lib/branch_delete.tcl:54
=2Dmsgid "Always (Do not perform merge test.)"
=2Dmsgstr "Immer (ohne Zusammenf=C3=BChrungstest)"
+#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
+msgid "Always (Do not perform merge checks)"
+msgstr "Immer (Keine Zusammenf=C3=BChrungspr=C3=BCfung)"
=20
 #: lib/branch_delete.tcl:103
 #, tcl-format
 msgid "The following branches are not completely merged into %s:"
 msgstr "Folgende Zweige sind noch nicht mit =C2=BB%s=C2=AB zusammengef=C3=
=BChrt:"
=20
+#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Das Wiederherstellen von gel=C3=B6schten Zweigen ist nur mit gr=C3=B6=C3=
=9Ferem Aufwand "
+"m=C3=B6glich.\n"
+"\n"
+"Sollen die ausgew=C3=A4hlten Zweige gel=C3=B6scht werden?"
+
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
@@ -802,7 +847,7 @@ msgstr "Neuer Name:"
 msgid "Please select a branch to rename."
 msgstr "Bitte w=C3=A4hlen Sie einen Zweig zum umbenennen."
=20
=2D#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr "Zweig =C2=BB%s=C2=AB existiert bereits."
@@ -833,37 +878,38 @@ msgstr "[Nach oben]"
 msgid "Browse Branch Files"
 msgstr "Dateien des Zweigs durchbl=C3=A4ttern"
=20
=2D#: lib/browser.tcl:278 lib/choose_repository.tcl:387
=2D#: lib/choose_repository.tcl:474 lib/choose_repository.tcl:484
=2D#: lib/choose_repository.tcl:987
+#: lib/browser.tcl:278 lib/choose_repository.tcl:398
+#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
+#: lib/choose_repository.tcl:1028
 msgid "Browse"
 msgstr "Bl=C3=A4ttern"
=20
=2D#: lib/checkout_op.tcl:79
+#: lib/checkout_op.tcl:85
 #, tcl-format
 msgid "Fetching %s from %s"
 msgstr "=C3=84nderungen =C2=BB%s=C2=AB von =C2=BB%s=C2=AB anfordern"
=20
=2D#: lib/checkout_op.tcl:127
+#: lib/checkout_op.tcl:133
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
 msgstr "Fehler: =C2=BB%s=C2=AB kann nicht als Zweig oder Version erkannt w=
erden"
=20
=2D#: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
+#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
+#: lib/sshkey.tcl:53
 msgid "Close"
 msgstr "Schlie=C3=9Fen"
=20
=2D#: lib/checkout_op.tcl:169
+#: lib/checkout_op.tcl:175
 #, tcl-format
 msgid "Branch '%s' does not exist."
 msgstr "Zweig =C2=BB%s=C2=AB existiert nicht."
=20
=2D#: lib/checkout_op.tcl:193
+#: lib/checkout_op.tcl:194
 #, tcl-format
 msgid "Failed to configure simplified git-pull for '%s'."
 msgstr "Fehler beim Einrichten der vereinfachten git-pull f=C3=BCr =C2=BB%=
s=C2=AB."
=20
=2D#: lib/checkout_op.tcl:228
+#: lib/checkout_op.tcl:229
 #, tcl-format
 msgid ""
 "Branch '%s' already exists.\n"
@@ -876,21 +922,21 @@ msgstr ""
 "Zweig kann nicht mit =C2=BB%s=C2=AB schnellzusammengef=C3=BChrt werden. R=
egul=C3=A4res "
 "Zusammenf=C3=BChren ist notwendig."
=20
=2D#: lib/checkout_op.tcl:220
+#: lib/checkout_op.tcl:243
 #, tcl-format
 msgid "Merge strategy '%s' not supported."
 msgstr "Zusammenf=C3=BChrungsmethode =C2=BB%s=C2=AB nicht unterst=C3=BCtzt=
=2E"
=20
=2D#: lib/checkout_op.tcl:239
+#: lib/checkout_op.tcl:262
 #, tcl-format
 msgid "Failed to update '%s'."
 msgstr "Aktualisieren von =C2=BB%s=C2=AB fehlgeschlagen."
=20
=2D#: lib/checkout_op.tcl:251
+#: lib/checkout_op.tcl:274
 msgid "Staging area (index) is already locked."
 msgstr "Bereitstellung (=C2=BBindex=C2=AB) ist zur Bearbeitung gesperrt (=
=C2=BBlocked=C2=AB)."
=20
=2D#: lib/checkout_op.tcl:266
+#: lib/checkout_op.tcl:289
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -906,32 +952,32 @@ msgstr ""
 "\n"
 "Es wird gleich neu geladen.\n"
=20
=2D#: lib/checkout_op.tcl:322
+#: lib/checkout_op.tcl:345
 #, tcl-format
 msgid "Updating working directory to '%s'..."
 msgstr "Arbeitskopie umstellen auf =C2=BB%s=C2=AB..."
=20
=2D#: lib/checkout_op.tcl:323
+#: lib/checkout_op.tcl:346
 msgid "files checked out"
 msgstr "Dateien aktualisiert"
=20
=2D#: lib/checkout_op.tcl:353
+#: lib/checkout_op.tcl:376
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr ""
 "Auf Zweig =C2=BB%s=C2=AB umstellen abgebrochen (Zusammenf=C3=BChren der D=
ateien ist "
 "notwendig)."
=20
=2D#: lib/checkout_op.tcl:354
+#: lib/checkout_op.tcl:377
 msgid "File level merge required."
 msgstr "Zusammenf=C3=BChren der Dateien ist notwendig."
=20
=2D#: lib/checkout_op.tcl:358
+#: lib/checkout_op.tcl:381
 #, tcl-format
 msgid "Staying on branch '%s'."
 msgstr "Es wird auf Zweig =C2=BB%s=C2=AB verblieben."
=20
=2D#: lib/checkout_op.tcl:429
+#: lib/checkout_op.tcl:452
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
@@ -943,32 +989,32 @@ msgstr ""
 "Wenn Sie auf einem Zweig arbeiten m=C3=B6chten, erstellen Sie bitte jetzt=
 einen "
 "Zweig mit der Auswahl =C2=BBAbgetrennte Arbeitskopie-Version=C2=AB."
=20
=2D#: lib/checkout_op.tcl:446 lib/checkout_op.tcl:450
+#: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
 #, tcl-format
 msgid "Checked out '%s'."
 msgstr "Umgestellt auf =C2=BB%s=C2=AB."
=20
=2D#: lib/checkout_op.tcl:478
+#: lib/checkout_op.tcl:535
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
 msgstr "Zur=C3=BCcksetzen von =C2=BB%s=C2=AB nach =C2=BB%s=C2=AB wird folg=
ende Versionen verwerfen:"
=20
=2D#: lib/checkout_op.tcl:500
+#: lib/checkout_op.tcl:557
 msgid "Recovering lost commits may not be easy."
 msgstr ""
 "Verworfene Versionen k=C3=B6nnen nur mit gr=C3=B6=C3=9Ferem Aufwand wiede=
rhergestellt "
 "werden."
=20
=2D#: lib/checkout_op.tcl:505
+#: lib/checkout_op.tcl:562
 #, tcl-format
 msgid "Reset '%s'?"
 msgstr "=C2=BB%s=C2=AB zur=C3=BCcksetzen?"
=20
=2D#: lib/checkout_op.tcl:510 lib/merge.tcl:163
+#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
 msgid "Visualize"
 msgstr "Darstellen"
=20
=2D#: lib/checkout_op.tcl:578
+#: lib/checkout_op.tcl:635
 #, tcl-format
 msgid ""
 "Failed to set current branch.\n"
@@ -1014,231 +1060,231 @@ msgstr ""
 msgid "Git Gui"
 msgstr "Git Gui"
=20
=2D#: lib/choose_repository.tcl:81 lib/choose_repository.tcl:376
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
 msgid "Create New Repository"
 msgstr "Neues Projektarchiv"
=20
=2D#: lib/choose_repository.tcl:87
+#: lib/choose_repository.tcl:93
 msgid "New..."
 msgstr "Neu..."
=20
=2D#: lib/choose_repository.tcl:94 lib/choose_repository.tcl:460
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
 msgid "Clone Existing Repository"
 msgstr "Projektarchiv klonen"
=20
=2D#: lib/choose_repository.tcl:100
+#: lib/choose_repository.tcl:106
 msgid "Clone..."
 msgstr "Klonen..."
=20
=2D#: lib/choose_repository.tcl:107 lib/choose_repository.tcl:976
+#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
 msgid "Open Existing Repository"
 msgstr "Projektarchiv =C3=B6ffnen"
=20
=2D#: lib/choose_repository.tcl:113
+#: lib/choose_repository.tcl:119
 msgid "Open..."
 msgstr "=C3=96ffnen..."
=20
=2D#: lib/choose_repository.tcl:126
+#: lib/choose_repository.tcl:132
 msgid "Recent Repositories"
 msgstr "Zuletzt benutzte Projektarchive"
=20
=2D#: lib/choose_repository.tcl:132
+#: lib/choose_repository.tcl:138
 msgid "Open Recent Repository:"
 msgstr "Zuletzt benutztes Projektarchiv =C3=B6ffnen:"
=20
=2D#: lib/choose_repository.tcl:296 lib/choose_repository.tcl:303
=2D#: lib/choose_repository.tcl:310
+#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
+#: lib/choose_repository.tcl:320
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "Projektarchiv =C2=BB%s=C2=AB konnte nicht erstellt werden:"
=20
=2D#: lib/choose_repository.tcl:387
+#: lib/choose_repository.tcl:391
 msgid "Directory:"
 msgstr "Verzeichnis:"
=20
=2D#: lib/choose_repository.tcl:412 lib/choose_repository.tcl:537
=2D#: lib/choose_repository.tcl:1011
+#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
+#: lib/choose_repository.tcl:1052
 msgid "Git Repository"
 msgstr "Git Projektarchiv"
=20
=2D#: lib/choose_repository.tcl:442
+#: lib/choose_repository.tcl:448
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "Verzeichnis =C2=BB%s=C2=AB existiert bereits."
=20
=2D#: lib/choose_repository.tcl:446
+#: lib/choose_repository.tcl:452
 #, tcl-format
 msgid "File %s already exists."
 msgstr "Datei =C2=BB%s=C2=AB existiert bereits."
=20
=2D#: lib/choose_repository.tcl:455
+#: lib/choose_repository.tcl:466
 msgid "Clone"
 msgstr "Klonen"
=20
=2D#: lib/choose_repository.tcl:473
+#: lib/choose_repository.tcl:479
 msgid "Source Location:"
 msgstr "Herkunft:"
=20
=2D#: lib/choose_repository.tcl:484
+#: lib/choose_repository.tcl:490
 msgid "Target Directory:"
 msgstr "Zielverzeichnis:"
=20
=2D#: lib/choose_repository.tcl:490
+#: lib/choose_repository.tcl:502
 msgid "Clone Type:"
 msgstr "Art des Klonens:"
=20
=2D#: lib/choose_repository.tcl:495
+#: lib/choose_repository.tcl:508
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "Standard (schnell, teilweise redundant, Hardlinks)"
=20
=2D#: lib/choose_repository.tcl:501
+#: lib/choose_repository.tcl:514
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "Alles kopieren (langsamer, volle Redundanz)"
=20
=2D#: lib/choose_repository.tcl:507
+#: lib/choose_repository.tcl:520
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "Verkn=C3=BCpft (schnell, nicht empfohlen, kein Backup)"
=20
=2D#: lib/choose_repository.tcl:543 lib/choose_repository.tcl:590
=2D#: lib/choose_repository.tcl:736 lib/choose_repository.tcl:806
=2D#: lib/choose_repository.tcl:1017 lib/choose_repository.tcl:1025
+#: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
+#: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
+#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "Kein Git-Projektarchiv in =C2=BB%s=C2=AB gefunden."
=20
=2D#: lib/choose_repository.tcl:579
+#: lib/choose_repository.tcl:592
 msgid "Standard only available for local repository."
 msgstr "Standard ist nur f=C3=BCr lokale Projektarchive verf=C3=BCgbar."
=20
=2D#: lib/choose_repository.tcl:583
+#: lib/choose_repository.tcl:596
 msgid "Shared only available for local repository."
 msgstr "Verkn=C3=BCpft ist nur f=C3=BCr lokale Projektarchive verf=C3=BCgb=
ar."
=20
=2D#: lib/choose_repository.tcl:604
+#: lib/choose_repository.tcl:617
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "Projektarchiv =C2=BB%s=C2=AB existiert bereits."
=20
=2D#: lib/choose_repository.tcl:615
+#: lib/choose_repository.tcl:628
 msgid "Failed to configure origin"
 msgstr "Der Ursprungsort konnte nicht eingerichtet werden"
=20
=2D#: lib/choose_repository.tcl:627
+#: lib/choose_repository.tcl:640
 msgid "Counting objects"
 msgstr "Objekte werden gez=C3=A4hlt"
=20
=2D#: lib/choose_repository.tcl:628
+#: lib/choose_repository.tcl:641
 msgid "buckets"
 msgstr "Buckets"
=20
=2D#: lib/choose_repository.tcl:652
+#: lib/choose_repository.tcl:665
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "Kopien von Objekten/Info/Alternates konnten nicht erstellt werden:=
 %s"
=20
=2D#: lib/choose_repository.tcl:688
+#: lib/choose_repository.tcl:701
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "Von =C2=BB%s=C2=AB konnte nichts geklont werden."
=20
=2D#: lib/choose_repository.tcl:690 lib/choose_repository.tcl:904
=2D#: lib/choose_repository.tcl:916
+#: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
+#: lib/choose_repository.tcl:929
 msgid "The 'master' branch has not been initialized."
 msgstr "Der =C2=BBmaster=C2=AB-Zweig wurde noch nicht initialisiert."
=20
=2D#: lib/choose_repository.tcl:703
+#: lib/choose_repository.tcl:716
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "Hardlinks nicht verf=C3=BCgbar. Stattdessen wird kopiert."
=20
=2D#: lib/choose_repository.tcl:715
+#: lib/choose_repository.tcl:728
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "Kopieren von =C2=BB%s=C2=AB"
=20
=2D#: lib/choose_repository.tcl:746
+#: lib/choose_repository.tcl:759
 msgid "Copying objects"
 msgstr "Objektdatenbank kopieren"
=20
=2D#: lib/choose_repository.tcl:747
+#: lib/choose_repository.tcl:760
 msgid "KiB"
 msgstr "KB"
=20
=2D#: lib/choose_repository.tcl:771
+#: lib/choose_repository.tcl:784
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "Objekt kann nicht kopiert werden: %s"
=20
=2D#: lib/choose_repository.tcl:781
+#: lib/choose_repository.tcl:794
 msgid "Linking objects"
 msgstr "Objekte verlinken"
=20
=2D#: lib/choose_repository.tcl:782
+#: lib/choose_repository.tcl:795
 msgid "objects"
 msgstr "Objekte"
=20
=2D#: lib/choose_repository.tcl:790
+#: lib/choose_repository.tcl:803
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "F=C3=BCr Objekt konnte kein Hardlink erstellt werden: %s"
=20
=2D#: lib/choose_repository.tcl:845
+#: lib/choose_repository.tcl:858
 msgid "Cannot fetch branches and objects.  See console output for details."
 msgstr ""
 "Zweige und Objekte konnten nicht angefordert werden.  Kontrollieren Sie d=
ie "
 "Ausgaben auf der Konsole f=C3=BCr weitere Angaben."
=20
=2D#: lib/choose_repository.tcl:856
+#: lib/choose_repository.tcl:869
 msgid "Cannot fetch tags.  See console output for details."
 msgstr ""
 "Markierungen konnten nicht angefordert werden.  Kontrollieren Sie die "
 "Ausgaben auf der Konsole f=C3=BCr weitere Angaben."
=20
=2D#: lib/choose_repository.tcl:880
+#: lib/choose_repository.tcl:893
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr ""
 "Die Zweigspitze (HEAD) konnte nicht gefunden werden.  Kontrollieren Sie d=
ie "
 "Ausgaben auf der Konsole f=C3=BCr weitere Angaben."
=20
=2D#: lib/choose_repository.tcl:889
+#: lib/choose_repository.tcl:902
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "Verzeichnis =C2=BB%s=C2=AB kann nicht aufger=C3=A4umt werden."
=20
=2D#: lib/choose_repository.tcl:895
+#: lib/choose_repository.tcl:908
 msgid "Clone failed."
 msgstr "Klonen fehlgeschlagen."
=20
=2D#: lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:915
 msgid "No default branch obtained."
 msgstr "Kein voreingestellter Zweig gefunden."
=20
=2D#: lib/choose_repository.tcl:913
+#: lib/choose_repository.tcl:926
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "=C2=BB%s=C2=AB wurde nicht als Version gefunden."
=20
=2D#: lib/choose_repository.tcl:925
+#: lib/choose_repository.tcl:938
 msgid "Creating working directory"
 msgstr "Arbeitskopie erstellen"
=20
=2D#: lib/choose_repository.tcl:926 lib/index.tcl:65 lib/index.tcl:127
=2D#: lib/index.tcl:193
+#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
+#: lib/index.tcl:198
 msgid "files"
 msgstr "Dateien"
=20
=2D#: lib/choose_repository.tcl:955
+#: lib/choose_repository.tcl:968
 msgid "Initial file checkout failed."
 msgstr "Erstellen der Arbeitskopie fehlgeschlagen."
=20
=2D#: lib/choose_repository.tcl:971
+#: lib/choose_repository.tcl:1011
 msgid "Open"
 msgstr "=C3=96ffnen"
=20
=2D#: lib/choose_repository.tcl:981
+#: lib/choose_repository.tcl:1021
 msgid "Repository:"
 msgstr "Projektarchiv:"
=20
=2D#: lib/choose_repository.tcl:1031
+#: lib/choose_repository.tcl:1072
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "Projektarchiv =C2=BB%s=C2=AB konnte nicht ge=C3=B6ffnet werden."
@@ -1311,19 +1357,24 @@ msgstr ""
 "unfertige Zusammenf=C3=BChrung existiert. Dazu m=C3=BCssen Sie die Zusamm=
enf=C3=BChrung "
 "beenden oder abbrechen.\n"
=20
=2D#: lib/commit.tcl:49
+#: lib/commit.tcl:48
 msgid "Error loading commit data for amend:"
 msgstr "Fehler beim Laden der Versionsdaten f=C3=BCr Nachbessern:"
=20
=2D#: lib/commit.tcl:76
+#: lib/commit.tcl:75
 msgid "Unable to obtain your identity:"
 msgstr "Benutzername konnte nicht bestimmt werden:"
=20
=2D#: lib/commit.tcl:81
+#: lib/commit.tcl:80
 msgid "Invalid GIT_COMMITTER_IDENT:"
 msgstr "Ung=C3=BCltiger Wert von GIT_COMMITTER_INDENT:"
=20
=2D#: lib/commit.tcl:133
+#: lib/commit.tcl:129
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "Warning: Tcl/Tk unterst=C3=BCtzt die Zeichencodierung =C2=BB%s=C2=
=AB nicht."
+
+#: lib/commit.tcl:149
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -1339,7 +1390,7 @@ msgstr ""
 "\n"
 "Es wird gleich neu geladen.\n"
=20
=2D#: lib/commit.tcl:154
+#: lib/commit.tcl:172
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1352,7 +1403,7 @@ msgstr ""
 "Die Datei =C2=BB%s=C2=AB hat noch nicht aufgel=C3=B6ste Zusammenf=C3=BChr=
ungs-Konflikte. Sie "
 "m=C3=BCssen diese Konflikte aufl=C3=B6sen, bevor Sie eintragen k=C3=B6nne=
n.\n"
=20
=2D#: lib/commit.tcl:162
+#: lib/commit.tcl:180
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1363,7 +1414,7 @@ msgstr ""
 "\n"
 "Datei =C2=BB%s=C2=AB kann nicht eingetragen werden.\n"
=20
=2D#: lib/commit.tcl:170
+#: lib/commit.tcl:188
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1373,7 +1424,7 @@ msgstr ""
 "\n"
 "Sie m=C3=BCssen mindestens eine Datei bereitstellen, bevor Sie eintragen =
k=C3=B6nnen.\n"
=20
=2D#: lib/commit.tcl:183
+#: lib/commit.tcl:203
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1393,47 +1444,42 @@ msgstr ""
 "\n"
 "- Rest: Eine ausf=C3=BChrliche Beschreibung, warum diese =C3=84nderung hi=
lfreich ist.\n"
=20
=2D#: lib/commit.tcl:207
=2D#, tcl-format
=2Dmsgid "warning: Tcl does not support encoding '%s'."
=2Dmsgstr "Warning: Tcl/Tk unterst=C3=BCtzt die Zeichencodierung =C2=BB%s=
=C2=AB nicht."
=2D
=2D#: lib/commit.tcl:221
+#: lib/commit.tcl:234
 msgid "Calling pre-commit hook..."
 msgstr "Aufrufen der Vor-Eintragen-Kontrolle..."
=20
=2D#: lib/commit.tcl:236
+#: lib/commit.tcl:249
 msgid "Commit declined by pre-commit hook."
 msgstr "Eintragen abgelehnt durch Vor-Eintragen-Kontrolle (=C2=BBpre-commi=
t hook=C2=AB)."
=20
=2D#: lib/commit.tcl:259
+#: lib/commit.tcl:272
 msgid "Calling commit-msg hook..."
 msgstr "Aufrufen der Versionsbeschreibungs-Kontrolle..."
=20
=2D#: lib/commit.tcl:274
+#: lib/commit.tcl:287
 msgid "Commit declined by commit-msg hook."
 msgstr ""
 "Eintragen abgelehnt durch Versionsbeschreibungs-Kontrolle (=C2=BBcommit-m=
essage "
 "hook=C2=AB)."
=20
=2D#: lib/commit.tcl:287
+#: lib/commit.tcl:300
 msgid "Committing changes..."
 msgstr "=C3=84nderungen eintragen..."
=20
=2D#: lib/commit.tcl:303
+#: lib/commit.tcl:316
 msgid "write-tree failed:"
 msgstr "write-tree fehlgeschlagen:"
=20
=2D#: lib/commit.tcl:304 lib/commit.tcl:348 lib/commit.tcl:368
+#: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
 msgid "Commit failed."
 msgstr "Eintragen fehlgeschlagen."
=20
=2D#: lib/commit.tcl:321
+#: lib/commit.tcl:334
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "Version =C2=BB%s=C2=AB scheint besch=C3=A4digt zu sein"
=20
=2D#: lib/commit.tcl:326
+#: lib/commit.tcl:339
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1448,19 +1494,19 @@ msgstr ""
 "\n"
 "Das Arbeitsverzeichnis wird daher jetzt neu geladen.\n"
=20
=2D#: lib/commit.tcl:333
+#: lib/commit.tcl:346
 msgid "No changes to commit."
 msgstr "Keine =C3=84nderungen, die eingetragen werden k=C3=B6nnen."
=20
=2D#: lib/commit.tcl:347
+#: lib/commit.tcl:360
 msgid "commit-tree failed:"
 msgstr "commit-tree fehlgeschlagen:"
=20
=2D#: lib/commit.tcl:367
+#: lib/commit.tcl:381
 msgid "update-ref failed:"
 msgstr "update-ref fehlgeschlagen:"
=20
=2D#: lib/commit.tcl:454
+#: lib/commit.tcl:469
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr "Version %s =C3=BCbertragen: %s"
@@ -1513,21 +1559,19 @@ msgstr "Objektdatenbank komprimieren"
 msgid "Verifying the object database with fsck-objects"
 msgstr "Die Objektdatenbank durch =C2=BBfsck-objects=C2=AB =C3=BCberpr=C3=
=BCfen lassen"
=20
=2D#: lib/database.tcl:108
+#: lib/database.tcl:107
 #, tcl-format
 msgid ""
 "This repository currently has approximately %i loose objects.\n"
 "\n"
 "To maintain optimal performance it is strongly recommended that you compr=
ess "
=2D"the database when more than %i loose objects exist.\n"
+"the database.\n"
 "\n"
 "Compress the database now?"
 msgstr ""
 "Dieses Projektarchiv enth=C3=A4lt ungef=C3=A4hr %i nicht verkn=C3=BCpfte =
Objekte.\n"
 "\n"
=2D"F=C3=BCr eine optimale Performance wird empfohlen, die Datenbank des "
=2D"Projektarchivs zu komprimieren, sobald mehr als %i nicht verkn=C3=BCpft=
e Objekte "
=2D"vorliegen.\n"
+"F=C3=BCr eine optimale Performance wird empfohlen, die Datenbank des Proj=
ektarchivs zu komprimieren.\n"
 "\n"
 "Soll die Datenbank jetzt komprimiert werden?"
=20
@@ -1536,7 +1580,7 @@ msgstr ""
 msgid "Invalid date from Git: %s"
 msgstr "Ung=C3=BCltiges Datum von Git: %s"
=20
=2D#: lib/diff.tcl:42
+#: lib/diff.tcl:64
 #, tcl-format
 msgid ""
 "No differences detected.\n"
@@ -1551,19 +1595,19 @@ msgid ""
 msgstr ""
 "Keine =C3=84nderungen feststellbar.\n"
 "\n"
=2D"=C2=BB%s=C2=AB enth=C3=A4lt keine =C3=84nderungen. Zwar wurde das =C3=
=84nderungsdatum dieser Datei "
=2D"von einem anderen Programm modifiziert, aber der Inhalt der Datei ist "
+"=C2=BB%s=C2=AB enth=C3=A4lt keine =C3=84nderungen. Zwar wurde das =C3=84n=
derungsdatum dieser Datei von "
+"einem anderen Programm modifiziert, aber der Inhalt der Datei ist "
 "unver=C3=A4ndert.\n"
 "\n"
 "Das Arbeitsverzeichnis wird jetzt neu geladen, um diese =C3=84nderung bei=
 allen "
 "Dateien zu pr=C3=BCfen."
=20
=2D#: lib/diff.tcl:81
+#: lib/diff.tcl:104
 #, tcl-format
 msgid "Loading diff of %s..."
 msgstr "Vergleich von =C2=BB%s=C2=AB laden..."
=20
=2D#: lib/diff.tcl:120
+#: lib/diff.tcl:125
 msgid ""
 "LOCAL: deleted\n"
 "REMOTE:\n"
@@ -1571,7 +1615,7 @@ msgstr ""
 "LOKAL: gel=C3=B6scht\n"
 "ANDERES:\n"
=20
=2D#: lib/diff.tcl:125
+#: lib/diff.tcl:130
 msgid ""
 "REMOTE: deleted\n"
 "LOCAL:\n"
@@ -1579,32 +1623,32 @@ msgstr ""
 "ANDERES: gel=C3=B6scht\n"
 "LOKAL:\n"
=20
=2D#: lib/diff.tcl:132
+#: lib/diff.tcl:137
 msgid "LOCAL:\n"
 msgstr "LOKAL:\n"
=20
=2D#: lib/diff.tcl:135
+#: lib/diff.tcl:140
 msgid "REMOTE:\n"
 msgstr "ANDERES:\n"
=20
=2D#: lib/diff.tcl:197 lib/diff.tcl:296
+#: lib/diff.tcl:202 lib/diff.tcl:319
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "Datei =C2=BB%s=C2=AB kann nicht angezeigt werden"
=20
=2D#: lib/diff.tcl:115
+#: lib/diff.tcl:203
 msgid "Error loading file:"
 msgstr "Fehler beim Laden der Datei:"
=20
=2D#: lib/diff.tcl:122
+#: lib/diff.tcl:210
 msgid "Git Repository (subproject)"
 msgstr "Git-Projektarchiv (Unterprojekt)"
=20
=2D#: lib/diff.tcl:134
+#: lib/diff.tcl:222
 msgid "* Binary file (not showing content)."
 msgstr "* Bin=C3=A4rdatei (Inhalt wird nicht angezeigt)"
=20
=2D#: lib/diff.tcl:222
+#: lib/diff.tcl:227
 #, tcl-format
 msgid ""
 "* Untracked file is %d bytes.\n"
@@ -1613,7 +1657,7 @@ msgstr ""
 "* Datei nicht unter Versionskontrolle, Dateigr=C3=B6=C3=9Fe %d Bytes.\n"
 "* Nur erste %d Bytes werden angezeigt.\n"
=20
=2D#: lib/diff.tcl:228
+#: lib/diff.tcl:233
 #, tcl-format
 msgid ""
 "\n"
@@ -1624,20 +1668,20 @@ msgstr ""
 "* Datei nicht unter Versionskontrolle, hier abgeschnitten durch %s.\n"
 "* Zum Ansehen der vollst=C3=A4ndigen Datei externen Editor benutzen.\n"
=20
=2D#: lib/diff.tcl:436
+#: lib/diff.tcl:482
 msgid "Failed to unstage selected hunk."
 msgstr ""
 "Fehler beim Herausnehmen des gew=C3=A4hlten Kontexts aus der Bereitstellu=
ng."
=20
=2D#: lib/diff.tcl:310
+#: lib/diff.tcl:489
 msgid "Failed to stage selected hunk."
 msgstr "Fehler beim Bereitstellen des gew=C3=A4hlten Kontexts."
=20
=2D#: lib/diff.tcl:386
+#: lib/diff.tcl:568
 msgid "Failed to unstage selected line."
 msgstr "Fehler beim Herausnehmen der gew=C3=A4hlten Zeile aus der Bereitst=
ellung."
=20
=2D#: lib/diff.tcl:394
+#: lib/diff.tcl:576
 msgid "Failed to stage selected line."
 msgstr "Fehler beim Bereitstellen der gew=C3=A4hlten Zeile."
=20
@@ -1675,7 +1719,7 @@ msgstr "Bereitstellung kann nicht wieder freigegeben =
werden."
 msgid "Index Error"
 msgstr "Fehler in Bereitstellung"
=20
=2D#: lib/index.tcl:21
+#: lib/index.tcl:17
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically started to=
 "
 "resynchronize git-gui."
@@ -1684,7 +1728,7 @@ msgstr ""
 "Git-Aktualisierung wird jetzt gestartet, um git-gui wieder mit git zu "
 "synchronisieren."
=20
=2D#: lib/index.tcl:27
+#: lib/index.tcl:28
 msgid "Continue"
 msgstr "Fortsetzen"
=20
@@ -1692,44 +1736,44 @@ msgstr "Fortsetzen"
 msgid "Unlock Index"
 msgstr "Bereitstellung freigeben"
=20
=2D#: lib/index.tcl:282
+#: lib/index.tcl:289
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "Datei =C2=BB%s=C2=AB aus der Bereitstellung herausnehmen"
=20
=2D#: lib/index.tcl:313
+#: lib/index.tcl:328
 msgid "Ready to commit."
 msgstr "Bereit zum Eintragen."
=20
=2D#: lib/index.tcl:326
+#: lib/index.tcl:341
 #, tcl-format
 msgid "Adding %s"
 msgstr "=C2=BB%s=C2=AB hinzuf=C3=BCgen..."
=20
=2D#: lib/index.tcl:381
+#: lib/index.tcl:398
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "=C3=84nderungen in Datei =C2=BB%s=C2=AB verwerfen?"
=20
=2D#: lib/index.tcl:383
+#: lib/index.tcl:400
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "=C3=84nderungen in den gew=C3=A4hlten %i Dateien verwerfen?"
=20
=2D#: lib/index.tcl:391
+#: lib/index.tcl:408
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 "Alle nicht bereitgestellten =C3=84nderungen werden beim Verwerfen verlore=
n gehen."
=20
=2D#: lib/index.tcl:394
+#: lib/index.tcl:411
 msgid "Do Nothing"
 msgstr "Nichts tun"
=20
=2D#: lib/index.tcl:419
+#: lib/index.tcl:429
 msgid "Reverting selected files"
 msgstr "=C3=84nderungen in gew=C3=A4hlten Dateien verwerfen"
=20
=2D#: lib/index.tcl:423
+#: lib/index.tcl:433
 #, tcl-format
 msgid "Reverting %s"
 msgstr "=C3=84nderungen in %s verwerfen"
@@ -1761,7 +1805,7 @@ msgstr ""
 "\n"
 "Es wird gleich neu geladen.\n"
=20
=2D#: lib/merge.tcl:44
+#: lib/merge.tcl:45
 #, tcl-format
 msgid ""
 "You are in the middle of a conflicted merge.\n"
@@ -1778,7 +1822,7 @@ msgstr ""
 "bereitstellen und eintragen, um die Zusammenf=C3=BChrung abzuschlie=C3=9F=
en. Erst "
 "danach kann eine neue Zusammenf=C3=BChrung begonnen werden.\n"
=20
=2D#: lib/merge.tcl:54
+#: lib/merge.tcl:55
 #, tcl-format
 msgid ""
 "You are in the middle of a change.\n"
@@ -1795,34 +1839,34 @@ msgstr ""
 "Reihenfolge k=C3=B6nnen Sie m=C3=B6gliche Konflikte beim Zusammenf=C3=BCh=
ren wesentlich "
 "einfacher beheben oder abbrechen.\n"
=20
=2D#: lib/merge.tcl:106
+#: lib/merge.tcl:107
 #, tcl-format
 msgid "%s of %s"
 msgstr "%s von %s"
=20
=2D#: lib/merge.tcl:119
+#: lib/merge.tcl:120
 #, tcl-format
 msgid "Merging %s and %s..."
 msgstr "Zusammenf=C3=BChren von %s und %s..."
=20
=2D#: lib/merge.tcl:130
+#: lib/merge.tcl:131
 msgid "Merge completed successfully."
 msgstr "Zusammenf=C3=BChren erfolgreich abgeschlossen."
=20
=2D#: lib/merge.tcl:132
+#: lib/merge.tcl:133
 msgid "Merge failed.  Conflict resolution is required."
 msgstr "Zusammenf=C3=BChren fehlgeschlagen. Konfliktaufl=C3=B6sung ist not=
wendig."
=20
=2D#: lib/merge.tcl:157
+#: lib/merge.tcl:158
 #, tcl-format
 msgid "Merge Into %s"
 msgstr "Zusammenf=C3=BChren in =C2=BB%s=C2=AB"
=20
=2D#: lib/merge.tcl:176
+#: lib/merge.tcl:177
 msgid "Revision To Merge"
 msgstr "Zusammenzuf=C3=BChrende Version"
=20
=2D#: lib/merge.tcl:211
+#: lib/merge.tcl:212
 msgid ""
 "Cannot abort while amending.\n"
 "\n"
@@ -1832,7 +1876,7 @@ msgstr ""
 "\n"
 "Sie m=C3=BCssen die Nachbesserung der Version abschlie=C3=9Fen.\n"
=20
=2D#: lib/merge.tcl:221
+#: lib/merge.tcl:222
 msgid ""
 "Abort merge?\n"
 "\n"
@@ -1847,7 +1891,7 @@ msgstr ""
 "\n"
 "Zusammenf=C3=BChren jetzt abbrechen?"
=20
=2D#: lib/merge.tcl:227
+#: lib/merge.tcl:228
 msgid ""
 "Reset changes?\n"
 "\n"
@@ -1862,35 +1906,35 @@ msgstr ""
 "\n"
 "=C3=84nderungen jetzt zur=C3=BCcksetzen?"
=20
=2D#: lib/merge.tcl:238
+#: lib/merge.tcl:239
 msgid "Aborting"
 msgstr "Abbruch"
=20
=2D#: lib/merge.tcl:238
+#: lib/merge.tcl:239
 msgid "files reset"
 msgstr "Dateien zur=C3=BCckgesetzt"
=20
=2D#: lib/merge.tcl:265
+#: lib/merge.tcl:267
 msgid "Abort failed."
 msgstr "Abbruch fehlgeschlagen."
=20
=2D#: lib/merge.tcl:267
+#: lib/merge.tcl:269
 msgid "Abort completed.  Ready."
 msgstr "Abbruch durchgef=C3=BChrt. Bereit."
=20
=2D#: lib/mergetool.tcl:14
+#: lib/mergetool.tcl:8
 msgid "Force resolution to the base version?"
 msgstr "Konflikt durch Basisversion ersetzen?"
=20
=2D#: lib/mergetool.tcl:15
+#: lib/mergetool.tcl:9
 msgid "Force resolution to this branch?"
 msgstr "Konflikt durch diesen Zweig ersetzen?"
=20
=2D#: lib/mergetool.tcl:16
+#: lib/mergetool.tcl:10
 msgid "Force resolution to the other branch?"
 msgstr "Konflikt durch anderen Zweig ersetzen?"
=20
=2D#: lib/mergetool.tcl:20
+#: lib/mergetool.tcl:14
 #, tcl-format
 msgid ""
 "Note that the diff shows only conflicting changes.\n"
@@ -1916,31 +1960,31 @@ msgstr "Datei =C2=BB%s=C2=AB hat nicht aufgel=C3=B6=
ste Konflikte. Trotzdem bereitstellen?"
 msgid "Adding resolution for %s"
 msgstr "Aufl=C3=B6sung hinzugef=C3=BCgt f=C3=BCr %s"
=20
=2D#: lib/mergetool.tcl:119
+#: lib/mergetool.tcl:141
 msgid "Cannot resolve deletion or link conflicts using a tool"
 msgstr ""
 "Konflikte durch gel=C3=B6schte Dateien oder symbolische Links k=C3=B6nnen=
 nicht durch "
 "das Zusamenf=C3=BChrungswerkzeug gel=C3=B6st werden."
=20
=2D#: lib/mergetool.tcl:124
+#: lib/mergetool.tcl:146
 msgid "Conflict file does not exist"
 msgstr "Konflikt-Datei existiert nicht"
=20
=2D#: lib/mergetool.tcl:236
+#: lib/mergetool.tcl:264
 #, tcl-format
 msgid "Not a GUI merge tool: '%s'"
 msgstr "Kein GUI Zusammenf=C3=BChrungswerkzeug: =C2=BB%s=C2=AB"
=20
=2D#: lib/mergetool.tcl:240
+#: lib/mergetool.tcl:268
 #, tcl-format
 msgid "Unsupported merge tool '%s'"
 msgstr "Unbekanntes Zusammenf=C3=BChrungswerkzeug: =C2=BB%s=C2=AB"
=20
=2D#: lib/mergetool.tcl:275
+#: lib/mergetool.tcl:303
 msgid "Merge tool is already running, terminate it?"
 msgstr "Zusammenf=C3=BChrungswerkzeug l=C3=A4uft bereits. Soll es abgebroc=
hen werden?"
=20
=2D#: lib/mergetool.tcl:295
+#: lib/mergetool.tcl:323
 #, tcl-format
 msgid ""
 "Error retrieving versions:\n"
@@ -1949,7 +1993,7 @@ msgstr ""
 "Fehler beim Abrufen der Dateiversionen:\n"
 "%s"
=20
=2D#: lib/mergetool.tcl:315
+#: lib/mergetool.tcl:343
 #, tcl-format
 msgid ""
 "Could not start the merge tool:\n"
@@ -1960,11 +2004,11 @@ msgstr ""
 "\n"
 "%s"
=20
=2D#: lib/mergetool.tcl:319
+#: lib/mergetool.tcl:347
 msgid "Running merge tool..."
 msgstr "Zusammenf=C3=BChrungswerkzeug starten..."
=20
=2D#: lib/mergetool.tcl:347 lib/mergetool.tcl:363
+#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
 msgid "Merge tool failed."
 msgstr "Zusammenf=C3=BChrungswerkzeug fehlgeschlagen."
=20
@@ -1982,76 +2026,76 @@ msgstr "Ung=C3=BCltige Archiv-Zeichenkodierung =C2=
=BB%s=C2=AB"
 msgid "Restore Defaults"
 msgstr "Voreinstellungen wiederherstellen"
=20
=2D#: lib/option.tcl:99
+#: lib/option.tcl:121
 msgid "Save"
 msgstr "Speichern"
=20
=2D#: lib/option.tcl:109
+#: lib/option.tcl:131
 #, tcl-format
 msgid "%s Repository"
 msgstr "Projektarchiv %s"
=20
=2D#: lib/option.tcl:110
+#: lib/option.tcl:132
 msgid "Global (All Repositories)"
 msgstr "Global (Alle Projektarchive)"
=20
=2D#: lib/option.tcl:116
+#: lib/option.tcl:138
 msgid "User Name"
 msgstr "Benutzername"
=20
=2D#: lib/option.tcl:117
+#: lib/option.tcl:139
 msgid "Email Address"
 msgstr "E-Mail-Adresse"
=20
=2D#: lib/option.tcl:119
+#: lib/option.tcl:141
 msgid "Summarize Merge Commits"
 msgstr "Zusammenf=C3=BChrungs-Versionen zusammenfassen"
=20
=2D#: lib/option.tcl:120
+#: lib/option.tcl:142
 msgid "Merge Verbosity"
 msgstr "Ausf=C3=BChrlichkeit der Zusammenf=C3=BChren-Meldungen"
=20
=2D#: lib/option.tcl:121
+#: lib/option.tcl:143
 msgid "Show Diffstat After Merge"
 msgstr "Vergleichsstatistik nach Zusammenf=C3=BChren anzeigen"
=20
=2D#: lib/option.tcl:122
+#: lib/option.tcl:144
 msgid "Use Merge Tool"
 msgstr "Zusammenf=C3=BChrungswerkzeug"
=20
=2D#: lib/option.tcl:124
+#: lib/option.tcl:146
 msgid "Trust File Modification Timestamps"
 msgstr "Auf Datei=C3=A4nderungsdatum verlassen"
=20
=2D#: lib/option.tcl:124
+#: lib/option.tcl:147
 msgid "Prune Tracking Branches During Fetch"
 msgstr "=C3=9Cbernahmezweige aufr=C3=A4umen w=C3=A4hrend Anforderung"
=20
=2D#: lib/option.tcl:125
+#: lib/option.tcl:148
 msgid "Match Tracking Branches"
 msgstr "Passend zu =C3=9Cbernahmezweig"
=20
=2D#: lib/option.tcl:126
+#: lib/option.tcl:149
 msgid "Blame Copy Only On Changed Files"
 msgstr "Kopie-Annotieren nur bei ge=C3=A4nderten Dateien"
=20
=2D#: lib/option.tcl:127
+#: lib/option.tcl:150
 msgid "Minimum Letters To Blame Copy On"
 msgstr "Mindestzahl Zeichen f=C3=BCr Kopie-Annotieren"
=20
=2D#: lib/option.tcl:128
+#: lib/option.tcl:151
 msgid "Blame History Context Radius (days)"
 msgstr "Anzahl Tage f=C3=BCr Historien-Kontext"
=20
=2D#: lib/option.tcl:129
+#: lib/option.tcl:152
 msgid "Number of Diff Context Lines"
 msgstr "Anzahl der Kontextzeilen beim Vergleich"
=20
=2D#: lib/option.tcl:127
+#: lib/option.tcl:153
 msgid "Commit Message Text Width"
 msgstr "Textbreite der Versionsbeschreibung"
=20
=2D#: lib/option.tcl:128
+#: lib/option.tcl:154
 msgid "New Branch Name Template"
 msgstr "Namensvorschlag f=C3=BCr neue Zweige"
=20
@@ -2067,24 +2111,24 @@ msgstr "=C3=84ndern"
 msgid "Spelling Dictionary:"
 msgstr "W=C3=B6rterbuch Rechtschreibpr=C3=BCfung:"
=20
=2D#: lib/option.tcl:216
+#: lib/option.tcl:254
 msgid "Change Font"
 msgstr "Schriftart =C3=A4ndern"
=20
=2D#: lib/option.tcl:220
+#: lib/option.tcl:258
 #, tcl-format
 msgid "Choose %s"
 msgstr "%s w=C3=A4hlen"
=20
=2D#: lib/option.tcl:226
+#: lib/option.tcl:264
 msgid "pt."
 msgstr "pt."
=20
=2D#: lib/option.tcl:240
+#: lib/option.tcl:278
 msgid "Preferences"
 msgstr "Einstellungen"
=20
=2D#: lib/option.tcl:275
+#: lib/option.tcl:314
 msgid "Failed to completely save options:"
 msgstr "Optionen konnten nicht gespeichert werden:"
=20
@@ -2096,7 +2140,7 @@ msgstr "Anderes Archiv hinzuf=C3=BCgen"
 msgid "Add New Remote"
 msgstr "Neues anderes Archiv hinzuf=C3=BCgen"
=20
=2D#: lib/remote_add.tcl:28
+#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
 msgid "Add"
 msgstr "Hinzuf=C3=BCgen"
=20
@@ -2151,8 +2195,7 @@ msgstr "=C2=BB%s=C2=AB anfordern"
 #: lib/remote_add.tcl:157
 #, tcl-format
 msgid "Do not know how to initialize repository at location '%s'."
=2Dmsgstr ""
=2D"Initialisieren eines anderen Archivs an Adresse =C2=BB%s=C2=AB ist nich=
t m=C3=B6glich."
+msgstr "Initialisieren eines anderen Archivs an Adresse =C2=BB%s=C2=AB ist=
 nicht m=C3=B6glich."
=20
 #: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
 #: lib/transport.tcl:81
@@ -2173,11 +2216,11 @@ msgstr "Zweig in anderem Archiv l=C3=B6schen"
 msgid "From Repository"
 msgstr "In Projektarchiv"
=20
=2D#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:123
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
 msgid "Remote:"
 msgstr "Anderes Archiv:"
=20
=2D#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
 msgid "Arbitrary Location:"
 msgstr "Adresse:"
=20
@@ -2193,10 +2236,6 @@ msgstr "Nur l=C3=B6schen, wenn"
 msgid "Merged Into:"
 msgstr "Zusammengef=C3=BChrt mit:"
=20
=2D#: lib/remote_branch_delete.tcl:119
=2Dmsgid "Always (Do not perform merge checks)"
=2Dmsgstr "Immer (Keine Zusammenf=C3=BChrungspr=C3=BCfung)"
=2D
 #: lib/remote_branch_delete.tcl:152
 msgid "A branch is required for 'Merged Into'."
 msgstr "F=C3=BCr =C2=BBZusammenf=C3=BChren mit=C2=AB muss ein Zweig angege=
ben werden."
@@ -2226,27 +2265,16 @@ msgstr ""
 msgid "Please select one or more branches to delete."
 msgstr "Bitte w=C3=A4hlen Sie mindestens einen Zweig, der gel=C3=B6scht we=
rden soll."
=20
=2D#: lib/remote_branch_delete.tcl:216
=2Dmsgid ""
=2D"Recovering deleted branches is difficult.\n"
=2D"\n"
=2D"Delete the selected branches?"
=2Dmsgstr ""
=2D"Das Wiederherstellen von gel=C3=B6schten Zweigen ist nur mit gr=C3=B6=
=C3=9Ferem Aufwand "
=2D"m=C3=B6glich.\n"
=2D"\n"
=2D"Sollen die ausgew=C3=A4hlten Zweige gel=C3=B6scht werden?"
=2D
 #: lib/remote_branch_delete.tcl:226
 #, tcl-format
 msgid "Deleting branches from %s"
 msgstr "Zweige auf =C2=BB%s=C2=AB werden gel=C3=B6scht"
=20
=2D#: lib/remote_branch_delete.tcl:286
+#: lib/remote_branch_delete.tcl:292
 msgid "No repository selected."
 msgstr "Kein Projektarchiv ausgew=C3=A4hlt."
=20
=2D#: lib/remote_branch_delete.tcl:291
+#: lib/remote_branch_delete.tcl:297
 #, tcl-format
 msgid "Scanning %s..."
 msgstr "=C2=BB%s=C2=AB laden..."
@@ -2259,11 +2287,11 @@ msgstr "Anderes Archiv entfernen"
 msgid "Prune from"
 msgstr "Aufr=C3=A4umen von"
=20
=2D#: lib/remote.tcl:170
+#: lib/remote.tcl:173
 msgid "Fetch from"
 msgstr "Anfordern von"
=20
=2D#: lib/remote.tcl:213
+#: lib/remote.tcl:215
 msgid "Push to"
 msgstr "Versenden nach"
=20
@@ -2271,11 +2299,11 @@ msgstr "Versenden nach"
 msgid "Find:"
 msgstr "Suchen:"
=20
=2D#: lib/search.tcl:22
+#: lib/search.tcl:23
 msgid "Next"
 msgstr "N=C3=A4chster"
=20
=2D#: lib/search.tcl:23
+#: lib/search.tcl:24
 msgid "Prev"
 msgstr "Voriger"
=20
@@ -2283,11 +2311,11 @@ msgstr "Voriger"
 msgid "Case-Sensitive"
 msgstr "Gro=C3=9F-/Kleinschreibung unterscheiden"
=20
=2D#: lib/shortcut.tcl:20 lib/shortcut.tcl:61
+#: lib/shortcut.tcl:21 lib/shortcut.tcl:62
 msgid "Cannot write shortcut:"
 msgstr "Fehler beim Schreiben der Verkn=C3=BCpfung:"
=20
=2D#: lib/shortcut.tcl:136
+#: lib/shortcut.tcl:137
 msgid "Cannot write icon:"
 msgstr "Fehler beim Erstellen des Icons:"
=20
@@ -2316,15 +2344,15 @@ msgstr "Rechtschreibpr=C3=BCfungsprogramm mit Fehle=
r abgebrochen"
 msgid "Unrecognized spell checker"
 msgstr "Unbekanntes Rechtschreibpr=C3=BCfungsprogramm"
=20
=2D#: lib/spellcheck.tcl:180
+#: lib/spellcheck.tcl:186
 msgid "No Suggestions"
 msgstr "Keine Vorschl=C3=A4ge"
=20
=2D#: lib/spellcheck.tcl:381
+#: lib/spellcheck.tcl:388
 msgid "Unexpected EOF from spell checker"
 msgstr "Unerwartetes EOF vom Rechtschreibpr=C3=BCfungsprogramm"
=20
=2D#: lib/spellcheck.tcl:385
+#: lib/spellcheck.tcl:392
 msgid "Spell Checker Failed"
 msgstr "Rechtschreibpr=C3=BCfung fehlgeschlagen"
=20
@@ -2534,31 +2562,31 @@ msgstr "Spiegeln nach %s"
 msgid "Pushing %s %s to %s"
 msgstr "%s %s nach %s versenden"
=20
=2D#: lib/transport.tcl:89
+#: lib/transport.tcl:100
 msgid "Push Branches"
 msgstr "Zweige versenden"
=20
=2D#: lib/transport.tcl:103
+#: lib/transport.tcl:114
 msgid "Source Branches"
 msgstr "Lokale Zweige"
=20
=2D#: lib/transport.tcl:120
+#: lib/transport.tcl:131
 msgid "Destination Repository"
 msgstr "Ziel-Projektarchiv"
=20
=2D#: lib/transport.tcl:158
+#: lib/transport.tcl:169
 msgid "Transfer Options"
 msgstr "Netzwerk-Einstellungen"
=20
=2D#: lib/transport.tcl:160
+#: lib/transport.tcl:171
 msgid "Force overwrite existing branch (may discard changes)"
 msgstr ""
 "=C3=9Cberschreiben von existierenden Zweigen erzwingen (k=C3=B6nnte =C3=
=84nderungen l=C3=B6schen)"
=20
=2D#: lib/transport.tcl:164
+#: lib/transport.tcl:175
 msgid "Use thin pack (for slow network connections)"
 msgstr "Kompaktes Datenformat benutzen (f=C3=BCr langsame Netzverbindungen=
)"
=20
=2D#: lib/transport.tcl:168
+#: lib/transport.tcl:179
 msgid "Include tags"
 msgstr "Mit Markierungen =C3=BCbertragen"
=2D-=20
1.6.3.3


--Boundary-00=_w/IYLCKTQr7h/lN--
