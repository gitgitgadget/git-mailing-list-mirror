From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk: Update German translation.
Date: Wed, 27 Jan 2010 20:30:25 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <201001272030.25998.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RRJYLJDSHuE52Wq"
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 20:31:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaDbc-0006e0-JA
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 20:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab0A0Ta7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 14:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244Ab0A0Ta6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 14:30:58 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:59356 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab0A0Ta5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 14:30:57 -0500
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id o0RJUXqg007291
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 27 Jan 2010 20:30:33 +0100
Received: from ckiste.localnet (e176217185.adsl.alicedsl.de [85.176.217.185])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id o0RJUTQ7019548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Jan 2010 20:30:32 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-generic; KDE/4.3.2; i686; ; )
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138189>

--Boundary-00=_RRJYLJDSHuE52Wq
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christian Stimming <stimming@tuhh.de>
=2D--
Patch inline below, and additionally attached just in case the mailer
messes up the whitespace. Thanks!

 po/de.po |  741 ++++++++++++++++++++++++++++++++++++----------------------=
=2D---
 1 files changed, 432 insertions(+), 309 deletions(-)

diff --git a/po/de.po b/po/de.po
index e224595..c79aa9c 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -8,33 +8,33 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2009-05-12 21:55+0200\n"
=2D"PO-Revision-Date: 2009-05-12 22:18+0200\n"
+"POT-Creation-Date: 2010-01-27 20:21+0100\n"
+"PO-Revision-Date: 2010-01-27 20:27+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
=2D#: gitk:113
+#: gitk:115
 msgid "Couldn't get list of unmerged files:"
 msgstr "Liste der nicht zusammengef=FChrten Dateien nicht gefunden:"
=20
=2D#: gitk:268
+#: gitk:274
 msgid "Error parsing revisions:"
 msgstr "Fehler beim Laden der Versionen:"
=20
=2D#: gitk:323
+#: gitk:329
 msgid "Error executing --argscmd command:"
 msgstr "Fehler beim Ausf=FChren des --argscmd-Kommandos:"
=20
=2D#: gitk:336
+#: gitk:342
 msgid "No files selected: --merge specified but no files are unmerged."
 msgstr ""
 "Keine Dateien ausgew=E4hlt: Es wurde --merge angegeben, aber es existiere=
n "
 "keine nicht zusammengef=FChrten Dateien."
=20
=2D#: gitk:339
+#: gitk:345
 msgid ""
 "No files selected: --merge specified but no unmerged files are within fil=
e "
 "limit."
@@ -42,719 +42,801 @@ msgstr ""
 "Keine Dateien ausgew=E4hlt: Es wurde --merge angegeben, aber es sind kein=
e "
 "nicht zusammengef=FChrten Dateien in der Dateiauswahl."
=20
=2D#: gitk:361 gitk:508
+#: gitk:367 gitk:514
 msgid "Error executing git log:"
 msgstr "Fehler beim Ausf=FChren von =BBgit log=AB:"
=20
=2D#: gitk:379 gitk:524
+#: gitk:385 gitk:530
 msgid "Reading"
 msgstr "Lesen"
=20
=2D#: gitk:439 gitk:4061
+#: gitk:445 gitk:4261
 msgid "Reading commits..."
 msgstr "Versionen werden gelesen ..."
=20
=2D#: gitk:442 gitk:1560 gitk:4064
+#: gitk:448 gitk:1578 gitk:4264
 msgid "No commits selected"
 msgstr "Keine Versionen ausgew=E4hlt"
=20
=2D#: gitk:1436
+#: gitk:1454
 msgid "Can't parse git log output:"
 msgstr "Ausgabe von =BBgit log=AB kann nicht erkannt werden:"
=20
=2D#: gitk:1656
+#: gitk:1674
 msgid "No commit information available"
 msgstr "Keine Versionsinformation verf=FCgbar"
=20
=2D#: gitk:1791 gitk:1815 gitk:3854 gitk:8714 gitk:10250 gitk:10422
+#: gitk:1816
+msgid "mc"
+msgstr "mc"
+
+#: gitk:1851 gitk:4054 gitk:9044 gitk:10585 gitk:10804
 msgid "OK"
 msgstr "Ok"
=20
=2D#: gitk:1817 gitk:3856 gitk:8311 gitk:8385 gitk:8495 gitk:8544 gitk:8716
=2D#: gitk:10251 gitk:10423
+#: gitk:1853 gitk:4056 gitk:8634 gitk:8713 gitk:8828 gitk:8877 gitk:9046
+#: gitk:10586 gitk:10805
 msgid "Cancel"
 msgstr "Abbrechen"
=20
=2D#: gitk:1917
+#: gitk:1975
 msgid "Update"
 msgstr "Aktualisieren"
=20
=2D#: gitk:1918
+#: gitk:1976
 msgid "Reload"
 msgstr "Neu laden"
=20
=2D#: gitk:1919
+#: gitk:1977
 msgid "Reread references"
 msgstr "Zweige neu laden"
=20
=2D#: gitk:1920
+#: gitk:1978
 msgid "List references"
 msgstr "Zweige/Markierungen auflisten"
=20
=2D#: gitk:1922
+#: gitk:1980
 msgid "Start git gui"
 msgstr "=BBgit gui=AB starten"
=20
=2D#: gitk:1924
+#: gitk:1982
 msgid "Quit"
 msgstr "Beenden"
=20
=2D#: gitk:1916
+#: gitk:1974
 msgid "File"
 msgstr "Datei"
=20
=2D#: gitk:1928
+#: gitk:1986
 msgid "Preferences"
 msgstr "Einstellungen"
=20
=2D#: gitk:1927
+#: gitk:1985
 msgid "Edit"
 msgstr "Bearbeiten"
=20
=2D#: gitk:1932
+#: gitk:1990
 msgid "New view..."
 msgstr "Neue Ansicht ..."
=20
=2D#: gitk:1933
+#: gitk:1991
 msgid "Edit view..."
 msgstr "Ansicht bearbeiten ..."
=20
=2D#: gitk:1934
+#: gitk:1992
 msgid "Delete view"
 msgstr "Ansicht entfernen"
=20
=2D#: gitk:1936
+#: gitk:1994
 msgid "All files"
 msgstr "Alle Dateien"
=20
=2D#: gitk:1931 gitk:3666
+#: gitk:1989 gitk:3808
 msgid "View"
 msgstr "Ansicht"
=20
=2D#: gitk:1941 gitk:1951 gitk:2650
+#: gitk:1999 gitk:2009 gitk:2780
 msgid "About gitk"
 msgstr "=DCber gitk"
=20
=2D#: gitk:1942 gitk:1956
+#: gitk:2000 gitk:2014
 msgid "Key bindings"
 msgstr "Tastenk=FCrzel"
=20
=2D#: gitk:1940 gitk:1955
+#: gitk:1998 gitk:2013
 msgid "Help"
 msgstr "Hilfe"
=20
=2D#: gitk:2016
=2Dmsgid "SHA1 ID: "
=2Dmsgstr "SHA1:"
+#: gitk:2091 gitk:8110
+msgid "SHA1 ID:"
+msgstr "SHA1 ID:"
=20
=2D#: gitk:2047
+#: gitk:2122
 msgid "Row"
 msgstr "Zeile"
=20
=2D#: gitk:2078
+#: gitk:2160
 msgid "Find"
 msgstr "Suche"
=20
=2D#: gitk:2079
+#: gitk:2161
 msgid "next"
 msgstr "n=E4chste"
=20
=2D#: gitk:2080
+#: gitk:2162
 msgid "prev"
 msgstr "vorige"
=20
=2D#: gitk:2081
+#: gitk:2163
 msgid "commit"
 msgstr "Version nach"
=20
=2D#: gitk:2084 gitk:2086 gitk:4222 gitk:4245 gitk:4269 gitk:6210 gitk:6282
=2D#: gitk:6366
+#: gitk:2166 gitk:2168 gitk:4422 gitk:4445 gitk:4469 gitk:6410 gitk:6482
+#: gitk:6566
 msgid "containing:"
 msgstr "Beschreibung:"
=20
=2D#: gitk:2087 gitk:3158 gitk:3163 gitk:4297
+#: gitk:2169 gitk:3290 gitk:3295 gitk:4497
 msgid "touching paths:"
 msgstr "Dateien:"
=20
=2D#: gitk:2088 gitk:4302
+#: gitk:2170 gitk:4502
 msgid "adding/removing string:"
 msgstr "=C4nderungen:"
=20
=2D#: gitk:2097 gitk:2099
+#: gitk:2179 gitk:2181
 msgid "Exact"
 msgstr "Exakt"
=20
=2D#: gitk:2099 gitk:4377 gitk:6178
+#: gitk:2181 gitk:4577 gitk:6378
 msgid "IgnCase"
 msgstr "Kein Gro=DF/Klein"
=20
=2D#: gitk:2099 gitk:4271 gitk:4375 gitk:6174
+#: gitk:2181 gitk:4471 gitk:4575 gitk:6374
 msgid "Regexp"
 msgstr "Regexp"
=20
=2D#: gitk:2101 gitk:2102 gitk:4396 gitk:4426 gitk:4433 gitk:6302 gitk:6370
+#: gitk:2183 gitk:2184 gitk:4596 gitk:4626 gitk:4633 gitk:6502 gitk:6570
 msgid "All fields"
 msgstr "Alle Felder"
=20
=2D#: gitk:2102 gitk:4394 gitk:4426 gitk:6241
+#: gitk:2184 gitk:4594 gitk:4626 gitk:6441
 msgid "Headline"
 msgstr "=DCberschrift"
=20
=2D#: gitk:2103 gitk:4394 gitk:6241 gitk:6370 gitk:6804
+#: gitk:2185 gitk:4594 gitk:6441 gitk:6570 gitk:7003
 msgid "Comments"
 msgstr "Beschreibung"
=20
=2D#: gitk:2103 gitk:4394 gitk:4398 gitk:4433 gitk:6241 gitk:6739 gitk:7991
=2D#: gitk:8006
+#: gitk:2185 gitk:4594 gitk:4598 gitk:4633 gitk:6441 gitk:6938 gitk:8285
+#: gitk:8300
 msgid "Author"
 msgstr "Autor"
=20
=2D#: gitk:2103 gitk:4394 gitk:6241 gitk:6741
+#: gitk:2185 gitk:4594 gitk:6441 gitk:6940
 msgid "Committer"
 msgstr "Eintragender"
=20
=2D#: gitk:2132
+#: gitk:2216
 msgid "Search"
 msgstr "Suchen"
=20
=2D#: gitk:2139
+#: gitk:2224
 msgid "Diff"
 msgstr "Vergleich"
=20
=2D#: gitk:2141
+#: gitk:2226
 msgid "Old version"
 msgstr "Alte Version"
=20
=2D#: gitk:2143
+#: gitk:2228
 msgid "New version"
 msgstr "Neue Version"
=20
=2D#: gitk:2145
+#: gitk:2230
 msgid "Lines of context"
 msgstr "Kontextzeilen"
=20
=2D#: gitk:2155
+#: gitk:2240
 msgid "Ignore space change"
 msgstr "Leerzeichen=E4nderungen ignorieren"
=20
=2D#: gitk:2213
+#: gitk:2299
 msgid "Patch"
 msgstr "Patch"
=20
=2D#: gitk:2215
+#: gitk:2301
 msgid "Tree"
 msgstr "Baum"
=20
=2D#: gitk:2359 gitk:2376
+#: gitk:2456 gitk:2473
 msgid "Diff this -> selected"
 msgstr "Vergleich: diese -> gew=E4hlte"
=20
=2D#: gitk:2360 gitk:2377
+#: gitk:2457 gitk:2474
 msgid "Diff selected -> this"
 msgstr "Vergleich: gew=E4hlte -> diese"
=20
=2D#: gitk:2361 gitk:2378
+#: gitk:2458 gitk:2475
 msgid "Make patch"
 msgstr "Patch erstellen"
=20
=2D#: gitk:2362 gitk:8369
+#: gitk:2459 gitk:8692
 msgid "Create tag"
 msgstr "Markierung erstellen"
=20
=2D#: gitk:2363 gitk:8475
+#: gitk:2460 gitk:8808
 msgid "Write commit to file"
 msgstr "Version in Datei schreiben"
=20
=2D#: gitk:2364 gitk:8532
+#: gitk:2461 gitk:8865
 msgid "Create new branch"
 msgstr "Neuen Zweig erstellen"
=20
=2D#: gitk:2365
+#: gitk:2462
 msgid "Cherry-pick this commit"
 msgstr "Diese Version pfl=FCcken"
=20
=2D#: gitk:2366
+#: gitk:2463
 msgid "Reset HEAD branch to here"
 msgstr "HEAD-Zweig auf diese Version zur=FCcksetzen"
=20
=2D#: gitk:2367
+#: gitk:2464
 msgid "Mark this commit"
 msgstr "Lesezeichen setzen"
=20
=2D#: gitk:2368
+#: gitk:2465
 msgid "Return to mark"
 msgstr "Zum Lesezeichen"
=20
=2D#: gitk:2369
+#: gitk:2466
 msgid "Find descendant of this and mark"
 msgstr "Abk=F6mmling von Lesezeichen und dieser Version finden"
=20
=2D#: gitk:2370
+#: gitk:2467
 msgid "Compare with marked commit"
 msgstr "Mit Lesezeichen vergleichen"
=20
=2D#: gitk:2384
+#: gitk:2481
 msgid "Check out this branch"
 msgstr "Auf diesen Zweig umstellen"
=20
=2D#: gitk:2385
+#: gitk:2482
 msgid "Remove this branch"
 msgstr "Zweig l=F6schen"
=20
=2D#: gitk:2392
+#: gitk:2489
 msgid "Highlight this too"
 msgstr "Diesen auch hervorheben"
=20
=2D#: gitk:2393
+#: gitk:2490
 msgid "Highlight this only"
 msgstr "Nur diesen hervorheben"
=20
=2D#: gitk:2394
+#: gitk:2491
 msgid "External diff"
 msgstr "Externes Diff-Programm"
=20
=2D#: gitk:2395
+#: gitk:2492
 msgid "Blame parent commit"
 msgstr "Annotieren der Elternversion"
=20
=2D#: gitk:2402
+#: gitk:2499
 msgid "Show origin of this line"
 msgstr "Herkunft dieser Zeile anzeigen"
=20
=2D#: gitk:2403
+#: gitk:2500
 msgid "Run git gui blame on this line"
 msgstr "Diese Zeile annotieren (=BBgit gui blame=AB)"
=20
=2D#: gitk:2652
+#: gitk:2782
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
=2D"Copyright =A9 2005-2008 Paul Mackerras\n"
+"Copyright =A99 2005-2009 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public License"
 msgstr ""
 "\n"
 "Gitk - eine Visualisierung der Git-Historie\n"
 "\n"
=2D"Copyright =A9 2005-2008 Paul Mackerras\n"
+"Copyright =A9 2005-2009 Paul Mackerras\n"
 "\n"
=2D"Benutzung und Weiterverbreitung gem=E4=DF den Bedingungen der GNU Gener=
al Public "
=2D"License"
+"Benutzung und Weiterverbreitung gem=E4=DF den Bedingungen der GNU General=
 Public License"
=20
=2D#: gitk:2660 gitk:2722 gitk:8897
+#: gitk:2790 gitk:2854 gitk:9230
 msgid "Close"
 msgstr "Schlie=DFen"
=20
=2D#: gitk:2679
+#: gitk:2811
 msgid "Gitk key bindings"
 msgstr "Gitk-Tastaturbelegung"
=20
=2D#: gitk:2682
+#: gitk:2814
 msgid "Gitk key bindings:"
 msgstr "Gitk-Tastaturbelegung:"
=20
=2D#: gitk:2684
+#: gitk:2816
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tBeenden"
=20
=2D#: gitk:2685
+#: gitk:2817
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Pos1>\t\tZur neuesten Version springen"
=20
=2D#: gitk:2686
+#: gitk:2818
 msgid "<End>\t\tMove to last commit"
 msgstr "<Ende>\t\tZur =E4ltesten Version springen"
=20
=2D#: gitk:2687
+#: gitk:2819
 msgid "<Up>, p, i\tMove up one commit"
 msgstr "<Hoch>, p, i\tN=E4chste neuere Version"
=20
=2D#: gitk:2688
+#: gitk:2820
 msgid "<Down>, n, k\tMove down one commit"
 msgstr "<Runter>, n, k\tN=E4chste =E4ltere Version"
=20
=2D#: gitk:2689
+#: gitk:2821
 msgid "<Left>, z, j\tGo back in history list"
 msgstr "<Links>, z, j\tEine Version zur=FCckgehen"
=20
=2D#: gitk:2690
+#: gitk:2822
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Rechts>, x, l\tEine Version weitergehen"
=20
=2D#: gitk:2691
+#: gitk:2823
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<BildHoch>\tEine Seite nach oben bl=E4ttern"
=20
=2D#: gitk:2692
+#: gitk:2824
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<BildRunter>\tEine Seite nach unten bl=E4ttern"
=20
=2D#: gitk:2693
+#: gitk:2825
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Pos1>\tZum oberen Ende der Versionsliste bl=E4ttern"
=20
=2D#: gitk:2694
+#: gitk:2826
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-Ende>\tZum unteren Ende der Versionsliste bl=E4ttern"
=20
=2D#: gitk:2695
+#: gitk:2827
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Hoch>\tVersionsliste eine Zeile nach oben bl=E4ttern"
=20
=2D#: gitk:2696
+#: gitk:2828
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Runter>\tVersionsliste eine Zeile nach unten bl=E4ttern"
=20
=2D#: gitk:2697
+#: gitk:2829
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-BildHoch>\tVersionsliste eine Seite nach oben bl=E4ttern"
=20
=2D#: gitk:2698
+#: gitk:2830
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-BildRunter>\tVersionsliste eine Seite nach unten bl=E4ttern"
=20
=2D#: gitk:2699
+#: gitk:2831
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Umschalt-Hoch>\tR=FCckw=E4rts suchen (nach oben; neuere Versionen=
)"
=20
=2D#: gitk:2700
+#: gitk:2832
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Umschalt-Runter> Suchen (nach unten; =E4ltere Versionen)"
=20
=2D#: gitk:2701
+#: gitk:2833
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Entf>, b\t\tVergleich eine Seite nach oben bl=E4ttern"
=20
=2D#: gitk:2702
+#: gitk:2834
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<L=F6schtaste>\tVergleich eine Seite nach oben bl=E4ttern"
=20
=2D#: gitk:2703
+#: gitk:2835
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Leertaste>\tVergleich eine Seite nach unten bl=E4ttern"
=20
=2D#: gitk:2704
+#: gitk:2836
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tVergleich um 18 Zeilen nach oben bl=E4ttern"
=20
=2D#: gitk:2705
+#: gitk:2837
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tVergleich um 18 Zeilen nach unten bl=E4ttern"
=20
=2D#: gitk:2706
+#: gitk:2838
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tSuchen"
=20
=2D#: gitk:2707
+#: gitk:2839
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tWeitersuchen"
=20
=2D#: gitk:2708
+#: gitk:2840
 msgid "<Return>\tMove to next find hit"
 msgstr "<Eingabetaste>\tWeitersuchen"
=20
=2D#: gitk:2709
+#: gitk:2841
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tTastaturfokus ins Suchfeld"
=20
=2D#: gitk:2710
+#: gitk:2842
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tR=FCckw=E4rts weitersuchen"
=20
=2D#: gitk:2711
+#: gitk:2843
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tVergleich zur n=E4chsten Datei bl=E4ttern"
=20
=2D#: gitk:2712
+#: gitk:2844
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tWeitersuchen im Vergleich"
=20
=2D#: gitk:2713
+#: gitk:2845
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tR=FCckw=E4rts weitersuchen im Vergleich"
=20
=2D#: gitk:2714
+#: gitk:2846
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-Nummerblock-Plus>\tSchrift vergr=F6=DFern"
=20
=2D#: gitk:2715
+#: gitk:2847
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-Plus>\tSchrift vergr=F6=DFern"
=20
=2D#: gitk:2716
+#: gitk:2848
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-Nummernblock-Minus> Schrift verkleinern"
=20
=2D#: gitk:2717
+#: gitk:2849
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-Minus>\tSchrift verkleinern"
=20
=2D#: gitk:2718
+#: gitk:2850
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tAktualisieren"
=20
=2D#: gitk:3173
=2D#, tcl-format
=2Dmsgid "Error getting \"%s\" from %s:"
=2Dmsgstr "Fehler beim Holen von =BB%s=AB von =BB%s=AB:"
=2D
=2D#: gitk:3230 gitk:3239
+#: gitk:3305 gitk:3314
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "Fehler beim Erzeugen des tempor=E4ren Verzeichnisses =BB%s=AB:"
=20
=2D#: gitk:3251
+#: gitk:3327
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "Fehler beim Holen von =BB%s=AB von =BB%s=AB:"
+
+#: gitk:3390
 msgid "command failed:"
 msgstr "Kommando fehlgeschlagen:"
=20
=2D#: gitk:3397
+#: gitk:3539
 msgid "No such commit"
 msgstr "Version nicht gefunden"
=20
=2D#: gitk:3411
+#: gitk:3553
 msgid "git gui blame: command failed:"
 msgstr "git gui blame: Kommando fehlgeschlagen:"
=20
=2D#: gitk:3442
+#: gitk:3584
 #, tcl-format
 msgid "Couldn't read merge head: %s"
 msgstr "Zusammenf=FChrungs-Spitze konnte nicht gelesen werden: %s"
=20
=2D#: gitk:3450
+#: gitk:3592
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "Fehler beim Lesen der Bereitstellung (=BBindex=AB): %s"
=20
=2D#: gitk:3475
+#: gitk:3617
 #, tcl-format
 msgid "Couldn't start git blame: %s"
 msgstr "=BBgit blame=AB konnte nicht gestartet werden: %s"
=20
=2D#: gitk:3478 gitk:6209
+#: gitk:3620 gitk:6409
 msgid "Searching"
 msgstr "Suchen"
=20
=2D#: gitk:3510
+#: gitk:3652
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "Fehler beim Ausf=FChren von =BBgit blame=AB: %s"
=20
=2D#: gitk:3538
+#: gitk:3680
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr ""
 "Diese Zeile stammt aus Version %s, die nicht in dieser Ansicht gezeigt wi=
rd"
=20
=2D#: gitk:3552
+#: gitk:3694
 msgid "External diff viewer failed:"
 msgstr "Externes Diff-Programm fehlgeschlagen:"
=20
=2D#: gitk:3670
+#: gitk:3812
 msgid "Gitk view definition"
 msgstr "Gitk-Ansichten"
=20
=2D#: gitk:3674
+#: gitk:3816
 msgid "Remember this view"
 msgstr "Diese Ansicht speichern"
=20
=2D#: gitk:3675
=2Dmsgid "Commits to include (arguments to git log):"
=2Dmsgstr "Versionen anzeigen (Argumente von git log):"
+#: gitk:3817
+msgid "References (space separated list):"
+msgstr "Zweige/Markierungen (durch Leerzeichen getrennte Liste):"
=20
=2D#: gitk:3676
=2Dmsgid "Use all refs"
=2Dmsgstr "Alle Zweige verwenden"
+#: gitk:3818
+msgid "Branches & tags:"
+msgstr "Zweige/Markierungen:"
=20
=2D#: gitk:3677
=2Dmsgid "Strictly sort by date"
=2Dmsgstr "Streng nach Datum sortieren"
+#: gitk:3819
+msgid "All refs"
+msgstr "Alle Markierungen und Zweige"
=20
=2D#: gitk:3678
=2Dmsgid "Mark branch sides"
=2Dmsgstr "Zweig-Seiten markieren"
+#: gitk:3820
+msgid "All (local) branches"
+msgstr "Alle (lokalen) Zweige"
=20
=2D#: gitk:3679
=2Dmsgid "Since date:"
=2Dmsgstr "Von Datum:"
+#: gitk:3821
+msgid "All tags"
+msgstr "Alle Markierungen"
=20
=2D#: gitk:3680
=2Dmsgid "Until date:"
=2Dmsgstr "Bis Datum:"
+#: gitk:3822
+msgid "All remote-tracking branches"
+msgstr "Alle =DCbernahmezweige"
+
+#: gitk:3823
+msgid "Commit Info (regular expressions):"
+msgstr "Versionsinformationen (regul=E4re Ausdr=FCcke):"
+
+#: gitk:3824
+msgid "Author:"
+msgstr "Autor:"
+
+#: gitk:3825
+msgid "Committer:"
+msgstr "Eintragender:"
+
+#: gitk:3826
+msgid "Commit Message:"
+msgstr "Versionsbeschreibung:"
=20
=2D#: gitk:3681
=2Dmsgid "Max count:"
=2Dmsgstr "Max. Anzahl:"
+#: gitk:3827
+msgid "Matches all Commit Info criteria"
+msgstr "Alle Versionsinformationen-Kriterien erf=FCllen"
=20
=2D#: gitk:3682
=2Dmsgid "Skip:"
+#: gitk:3828
+msgid "Changes to Files:"
+msgstr "Dateien:"
+
+#: gitk:3829
+msgid "Fixed String"
+msgstr "Zeichenkette"
+
+#: gitk:3830
+msgid "Regular Expression"
+msgstr "Regul=E4rer Ausdruck"
+
+#: gitk:3831
+msgid "Search string:"
+msgstr "Suchausdruck:"
+
+#: gitk:3832
+msgid ""
+"Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2009 "
+"15:27:38\"):"
+msgstr "Datum (=BB2 weeks ago=AB, =BB2009-03-17 15:27:38=AB, =BBMarch 17, =
2009 15:27:38=AB)"
+
+#: gitk:3833
+msgid "Since:"
+msgstr "Von:"
+
+#: gitk:3834
+msgid "Until:"
+msgstr "Bis:"
+
+#: gitk:3835
+msgid "Limit and/or skip a number of revisions (positive integer):"
+msgstr "Versionsanzahl begrenzen oder einige =FCberspringen (ganzzahliger =
Wert):"
+
+#: gitk:3836
+msgid "Number to show:"
+msgstr "Anzeigen:"
+
+#: gitk:3837
+msgid "Number to skip:"
 msgstr "=DCberspringen:"
=20
=2D#: gitk:3683
+#: gitk:3838
+msgid "Miscellaneous options:"
+msgstr "Sonstiges:"
+
+#: gitk:3839
+msgid "Strictly sort by date"
+msgstr "Streng nach Datum sortieren"
+
+#: gitk:3840
+msgid "Mark branch sides"
+msgstr "Zweig-Seiten markieren"
+
+#: gitk:3841
 msgid "Limit to first parent"
 msgstr "Auf erste Elternversion beschr=E4nken"
=20
=2D#: gitk:3684
+#: gitk:3842
+msgid "Simple history"
+msgstr "Einfache Historie"
+
+#: gitk:3843
+msgid "Additional arguments to git log:"
+msgstr "Zus=E4tzliche Argumente f=FCr =BBgit log=AB:"
+
+#: gitk:3844
+msgid "Enter files and directories to include, one per line:"
+msgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
+
+#: gitk:3845
 msgid "Command to generate more commits to include:"
 msgstr "Versionsliste durch folgendes Kommando erzeugen lassen:"
=20
=2D#: gitk:3780
+#: gitk:3967
 msgid "Gitk: edit view"
 msgstr "Gitk: Ansicht bearbeiten"
=20
=2D#: gitk:3793
=2Dmsgid "Name"
=2Dmsgstr "Name"
+#: gitk:3975
+msgid "-- criteria for selecting revisions"
+msgstr "-- Auswahl der angezeigten Versionen"
=20
=2D#: gitk:3841
=2Dmsgid "Enter files and directories to include, one per line:"
=2Dmsgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
+#: gitk:3980
+msgid "View Name"
+msgstr "Ansichtsname"
=20
=2D#: gitk:3855
+#: gitk:4055
 msgid "Apply (F5)"
 msgstr "Anwenden (F5)"
=20
=2D#: gitk:3893
+#: gitk:4093
 msgid "Error in commit selection arguments:"
 msgstr "Fehler in den ausgew=E4hlten Versionen:"
=20
=2D#: gitk:3946 gitk:3998 gitk:4446 gitk:4460 gitk:5721 gitk:11114 gitk:111=
15
+#: gitk:4146 gitk:4198 gitk:4646 gitk:4660 gitk:5921 gitk:11534 gitk:11535
 msgid "None"
 msgstr "Keine"
=20
=2D#: gitk:4394 gitk:6241 gitk:7993 gitk:8008
+#: gitk:4594 gitk:6441 gitk:8287 gitk:8302
 msgid "Date"
 msgstr "Datum"
=20
=2D#: gitk:4394 gitk:6241
+#: gitk:4594 gitk:6441
 msgid "CDate"
 msgstr "Eintragedatum"
=20
=2D#: gitk:4543 gitk:4548
+#: gitk:4743 gitk:4748
 msgid "Descendant"
 msgstr "Abk=F6mmling"
=20
=2D#: gitk:4544
+#: gitk:4744
 msgid "Not descendant"
 msgstr "Kein Abk=F6mmling"
=20
=2D#: gitk:4551 gitk:4556
+#: gitk:4751 gitk:4756
 msgid "Ancestor"
 msgstr "Vorg=E4nger"
=20
=2D#: gitk:4552
+#: gitk:4752
 msgid "Not ancestor"
 msgstr "Kein Vorg=E4nger"
=20
=2D#: gitk:4842
+#: gitk:5042
 msgid "Local changes checked in to index but not committed"
 msgstr "Lokale =C4nderungen bereitgestellt, aber nicht eingetragen"
=20
=2D#: gitk:4878
+#: gitk:5078
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokale =C4nderungen, nicht bereitgestellt"
=20
=2D#: gitk:6559
+#: gitk:6759
 msgid "many"
 msgstr "viele"
=20
=2D#: gitk:6743
+#: gitk:6942
 msgid "Tags:"
 msgstr "Markierungen:"
=20
=2D#: gitk:6760 gitk:6766 gitk:7986
+#: gitk:6959 gitk:6965 gitk:8280
 msgid "Parent"
 msgstr "Eltern"
=20
=2D#: gitk:6771
+#: gitk:6970
 msgid "Child"
 msgstr "Kind"
=20
=2D#: gitk:6780
+#: gitk:6979
 msgid "Branch"
 msgstr "Zweig"
=20
=2D#: gitk:6783
+#: gitk:6982
 msgid "Follows"
 msgstr "Folgt auf"
=20
=2D#: gitk:6786
+#: gitk:6985
 msgid "Precedes"
 msgstr "Vorg=E4nger von"
=20
=2D#: gitk:7279
+#: gitk:7522
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Fehler beim Laden des Vergleichs: %s"
=20
=2D#: gitk:7819
+#: gitk:8108
 msgid "Goto:"
 msgstr "Gehe zu:"
=20
=2D#: gitk:7821
=2Dmsgid "SHA1 ID:"
=2Dmsgstr "SHA1 ID:"
=2D
=2D#: gitk:7840
+#: gitk:8129
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Kurzer SHA1-Hashwert =BB%s=AB ist mehrdeutig"
=20
=2D#: gitk:7852
+#: gitk:8136
+#, tcl-format
+msgid "Revision %s is not known"
+msgstr "Version =BB%s=AB ist unbekannt"
+
+#: gitk:8146
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA1-Hashwert =BB%s=AB ist unbekannt"
=20
=2D#: gitk:7854
+#: gitk:8148
 #, tcl-format
=2Dmsgid "Tag/Head %s is not known"
=2Dmsgstr "Markierung/Zweig =BB%s=AB ist unbekannt"
+msgid "Revision %s is not in the current view"
+msgstr "Version =BB%s=AB wird in der aktuellen Ansicht nicht angezeigt"
=20
=2D#: gitk:7996
+#: gitk:8290
 msgid "Children"
 msgstr "Kinder"
=20
=2D#: gitk:8053
+#: gitk:8348
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Zweig =BB%s=AB hierher zur=FCcksetzen"
=20
=2D#: gitk:8055
+#: gitk:8350
 msgid "Detached head: can't reset"
 msgstr "Zweigspitze ist abgetrennt: Zur=FCcksetzen nicht m=F6glich"
=20
=2D#: gitk:8164 gitk:8170
+#: gitk:8459 gitk:8465
 msgid "Skipping merge commit "
 msgstr "=DCberspringe Zusammenf=FChrungs-Version "
=20
=2D#: gitk:8179 gitk:8184
+#: gitk:8474 gitk:8479
 msgid "Error getting patch ID for "
 msgstr "Fehler beim Holen der Patch-ID f=FCr "
=20
=2D#: gitk:8180 gitk:8185
+#: gitk:8475 gitk:8480
 msgid " - stopping\n"
 msgstr " - Abbruch.\n"
=20
=2D#: gitk:8190 gitk:8193 gitk:8201 gitk:8211 gitk:8220
+#: gitk:8485 gitk:8488 gitk:8496 gitk:8510 gitk:8519
 msgid "Commit "
 msgstr "Version "
=20
=2D#: gitk:8194
+#: gitk:8489
 msgid ""
 " is the same patch as\n"
 "       "
@@ -762,7 +844,7 @@ msgstr ""
 " ist das gleiche Patch wie\n"
 "       "
=20
=2D#: gitk:8202
+#: gitk:8497
 msgid ""
 " differs from\n"
 "       "
@@ -770,117 +852,138 @@ msgstr ""
 " ist unterschiedlich von\n"
 "       "
=20
=2D#: gitk:8204
=2Dmsgid "- stopping\n"
=2Dmsgstr "- Abbruch.\n"
+#: gitk:8499
+msgid ""
+"Diff of commits:\n"
+"\n"
+msgstr ""
+"Vergleich der Versionen:\n"
+"\n"
=20
=2D#: gitk:8212 gitk:8221
+#: gitk:8511 gitk:8520
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " hat %s Kinder. Abbruch\n"
=20
=2D#: gitk:8252
+#: gitk:8539
+#, tcl-format
+msgid "Error writing commit to file: %s"
+msgstr "Fehler beim Schreiben der Version in Datei: %s"
+
+#: gitk:8545
+#, tcl-format
+msgid "Error diffing commits: %s"
+msgstr "Fehler beim Vergleichen der Versionen: %s"
+
+#: gitk:8575
 msgid "Top"
 msgstr "Oben"
=20
=2D#: gitk:8253
+#: gitk:8576
 msgid "From"
 msgstr "Von"
=20
=2D#: gitk:8258
+#: gitk:8581
 msgid "To"
 msgstr "bis"
=20
=2D#: gitk:8282
+#: gitk:8605
 msgid "Generate patch"
 msgstr "Patch erstellen"
=20
=2D#: gitk:8284
+#: gitk:8607
 msgid "From:"
 msgstr "Von:"
=20
=2D#: gitk:8293
+#: gitk:8616
 msgid "To:"
 msgstr "bis:"
=20
=2D#: gitk:8302
+#: gitk:8625
 msgid "Reverse"
 msgstr "Umgekehrt"
=20
=2D#: gitk:8304 gitk:8489
+#: gitk:8627 gitk:8822
 msgid "Output file:"
 msgstr "Ausgabedatei:"
=20
=2D#: gitk:8310
+#: gitk:8633
 msgid "Generate"
 msgstr "Erzeugen"
=20
=2D#: gitk:8348
+#: gitk:8671
 msgid "Error creating patch:"
 msgstr "Fehler beim Erzeugen des Patches:"
=20
=2D#: gitk:8371 gitk:8477 gitk:8534
+#: gitk:8694 gitk:8810 gitk:8867
 msgid "ID:"
 msgstr "ID:"
=20
=2D#: gitk:8380
+#: gitk:8703
 msgid "Tag name:"
 msgstr "Markierungsname:"
=20
=2D#: gitk:8384 gitk:8543
+#: gitk:8706
+msgid "Tag message is optional"
+msgstr "Eine Markierungsbeschreibung ist optional"
+
+#: gitk:8708
+msgid "Tag message:"
+msgstr "Markierungsbeschreibung:"
+
+#: gitk:8712 gitk:8876
 msgid "Create"
 msgstr "Erstellen"
=20
=2D#: gitk:8401
+#: gitk:8730
 msgid "No tag name specified"
 msgstr "Kein Markierungsname angegeben"
=20
=2D#: gitk:8405
+#: gitk:8734
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Markierung =BB%s=AB existiert bereits."
=20
=2D#: gitk:8411
+#: gitk:8744
 msgid "Error creating tag:"
 msgstr "Fehler beim Erstellen der Markierung:"
=20
=2D#: gitk:8486
+#: gitk:8819
 msgid "Command:"
 msgstr "Kommando:"
=20
=2D#: gitk:8494
+#: gitk:8827
 msgid "Write"
 msgstr "Schreiben"
=20
=2D#: gitk:8512
+#: gitk:8845
 msgid "Error writing commit:"
 msgstr "Fehler beim Schreiben der Version:"
=20
=2D#: gitk:8539
+#: gitk:8872
 msgid "Name:"
 msgstr "Name:"
=20
=2D#: gitk:8562
+#: gitk:8895
 msgid "Please specify a name for the new branch"
 msgstr "Bitte geben Sie einen Namen f=FCr den neuen Zweig an."
=20
=2D#: gitk:8567
+#: gitk:8900
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "Zweig =BB%s=AB existiert bereits. Soll er =FCberschrieben werden?"
=20
=2D#: gitk:8633
+#: gitk:8966
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
=2D"Version =BB%s=AB ist bereits im Zweig =BB%s=AB enthalten -- trotzdem er=
neut "
=2D"eintragen?"
+"Version =BB%s=AB ist bereits im Zweig =BB%s=AB enthalten -- trotzdem erne=
ut eintragen?"
=20
=2D#: gitk:8638
+#: gitk:8971
 msgid "Cherry-picking"
 msgstr "Version pfl=FCcken"
=20
=2D#: gitk:8647
+#: gitk:8980
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -890,7 +993,7 @@ msgstr ""
 "vorliegen. Bitte diese =C4nderungen eintragen, zur=FCcksetzen oder\n"
 "zwischenspeichern (=BBgit stash=AB) und dann erneut versuchen."
=20
=2D#: gitk:8653
+#: gitk:8986
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -899,34 +1002,34 @@ msgstr ""
 "ist. Soll das Zusammenf=FChrungs-Werkzeug (=BBgit citool=AB) aufgerufen\n"
 "werden, um diesen Konflikt aufzul=F6sen?"
=20
=2D#: gitk:8669
+#: gitk:9002
 msgid "No changes committed"
 msgstr "Keine =C4nderungen eingetragen"
=20
=2D#: gitk:8695
+#: gitk:9028
 msgid "Confirm reset"
 msgstr "Zur=FCcksetzen best=E4tigen"
=20
=2D#: gitk:8697
+#: gitk:9030
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Zweig =BB%s=AB auf =BB%s=AB zur=FCcksetzen?"
=20
=2D#: gitk:8701
+#: gitk:9032
 msgid "Reset type:"
 msgstr "Art des Zur=FCcksetzens:"
=20
=2D#: gitk:8705
+#: gitk:9035
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Harmlos: Arbeitskopie und Bereitstellung unver=E4ndert"
=20
=2D#: gitk:8708
+#: gitk:9038
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr ""
 "Gemischt: Arbeitskopie unver=E4ndert,\n"
 "Bereitstellung zur=FCckgesetzt"
=20
=2D#: gitk:8711
+#: gitk:9041
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -934,21 +1037,21 @@ msgstr ""
 "Hart: Arbeitskopie und Bereitstellung\n"
 "(Alle lokalen =C4nderungen werden gel=F6scht)"
=20
=2D#: gitk:8728
+#: gitk:9058
 msgid "Resetting"
 msgstr "Zur=FCcksetzen"
=20
=2D#: gitk:8785
+#: gitk:9118
 msgid "Checking out"
 msgstr "Umstellen"
=20
=2D#: gitk:8838
+#: gitk:9171
 msgid "Cannot delete the currently checked-out branch"
 msgstr ""
 "Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kann nicht "
 "gel=F6scht werden."
=20
=2D#: gitk:8844
+#: gitk:9177
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -957,16 +1060,16 @@ msgstr ""
 "Die Versionen auf Zweig =BB%s=AB existieren auf keinem anderen Zweig.\n"
 "Zweig =BB%s=AB trotzdem l=F6schen?"
=20
=2D#: gitk:8875
+#: gitk:9208
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Markierungen und Zweige: %s"
=20
=2D#: gitk:8890
+#: gitk:9223
 msgid "Filter"
 msgstr "Filtern"
=20
=2D#: gitk:9185
+#: gitk:9518
 msgid ""
 "Error reading commit topology information; branch and preceding/following=
 "
 "tag information will be incomplete."
@@ -974,182 +1077,202 @@ msgstr ""
 "Fehler beim Lesen der Strukturinformationen; Zweige und Informationen zu "
 "Vorg=E4nger/Nachfolger werden unvollst=E4ndig sein."
=20
=2D#: gitk:10171
+#: gitk:10504
 msgid "Tag"
 msgstr "Markierung"
=20
=2D#: gitk:10171
+#: gitk:10504
 msgid "Id"
 msgstr "Id"
=20
=2D#: gitk:10219
+#: gitk:10554
 msgid "Gitk font chooser"
 msgstr "Gitk-Schriften w=E4hlen"
=20
=2D#: gitk:10236
+#: gitk:10571
 msgid "B"
 msgstr "F"
=20
=2D#: gitk:10239
+#: gitk:10574
 msgid "I"
 msgstr "K"
=20
=2D#: gitk:10334
+#: gitk:10692
 msgid "Gitk preferences"
 msgstr "Gitk-Einstellungen"
=20
=2D#: gitk:10336
+#: gitk:10694
 msgid "Commit list display options"
 msgstr "Anzeige der Versionsliste"
=20
=2D#: gitk:10339
+#: gitk:10697
 msgid "Maximum graph width (lines)"
 msgstr "Maximale Graphenbreite (Zeilen)"
=20
=2D#: gitk:10343
+#: gitk:10700
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximale Graphenbreite (% des Fensters)"
=20
=2D#: gitk:10347
+#: gitk:10703
 msgid "Show local changes"
 msgstr "Lokale =C4nderungen anzeigen"
=20
=2D#: gitk:10350
+#: gitk:10706
 msgid "Auto-select SHA1"
 msgstr "SHA1-Hashwert automatisch ausw=E4hlen"
=20
=2D#: gitk:10354
+#: gitk:10709
+msgid "Hide remote refs"
+msgstr "Entfernte Zweige/Markierungen ausblenden"
+
+#: gitk:10713
 msgid "Diff display options"
 msgstr "Anzeige des Vergleichs"
=20
=2D#: gitk:10356
+#: gitk:10715
 msgid "Tab spacing"
 msgstr "Tabulatorbreite"
=20
=2D#: gitk:10359
+#: gitk:10718
 msgid "Display nearby tags"
 msgstr "Naheliegende Markierungen anzeigen"
=20
=2D#: gitk:10362
+#: gitk:10721
 msgid "Limit diffs to listed paths"
 msgstr "Vergleich nur f=FCr angezeigte Pfade"
=20
=2D#: gitk:10365
+#: gitk:10724
 msgid "Support per-file encodings"
 msgstr "Zeichenkodierung pro Datei ermitteln"
=20
=2D#: gitk:10371 gitk:10436
+#: gitk:10730 gitk:10819
 msgid "External diff tool"
 msgstr "Externes Diff-Programm"
=20
=2D#: gitk:10373
+#: gitk:10731
 msgid "Choose..."
 msgstr "W=E4hlen ..."
=20
=2D#: gitk:10378
+#: gitk:10736
+msgid "General options"
+msgstr "Allgemeine Optionen"
+
+#: gitk:10739
+msgid "Use themed widgets"
+msgstr "Aussehen der Benutzeroberfl=E4che durch Thema bestimmen"
+
+#: gitk:10741
+msgid "(change requires restart)"
+msgstr "(=C4nderungen werden erst nach Neustart wirksam)"
+
+#: gitk:10743
+msgid "(currently unavailable)"
+msgstr "(Momentan nicht verf=FCgbar)"
+
+#: gitk:10747
 msgid "Colors: press to choose"
 msgstr "Farben: Klicken zum W=E4hlen"
=20
=2D#: gitk:10381
+#: gitk:10750
+msgid "Interface"
+msgstr "Benutzeroberfl=E4che"
+
+#: gitk:10751
+msgid "interface"
+msgstr "Benutzeroberfl=E4che"
+
+#: gitk:10754
 msgid "Background"
 msgstr "Hintergrund"
=20
=2D#: gitk:10382 gitk:10412
+#: gitk:10755 gitk:10785
 msgid "background"
 msgstr "Hintergrund"
=20
=2D#: gitk:10385
+#: gitk:10758
 msgid "Foreground"
 msgstr "Vordergrund"
=20
=2D#: gitk:10386
+#: gitk:10759
 msgid "foreground"
 msgstr "Vordergrund"
=20
=2D#: gitk:10389
+#: gitk:10762
 msgid "Diff: old lines"
 msgstr "Vergleich: Alte Zeilen"
=20
=2D#: gitk:10390
+#: gitk:10763
 msgid "diff old lines"
 msgstr "Vergleich - Alte Zeilen"
=20
=2D#: gitk:10394
+#: gitk:10767
 msgid "Diff: new lines"
 msgstr "Vergleich: Neue Zeilen"
=20
=2D#: gitk:10395
+#: gitk:10768
 msgid "diff new lines"
 msgstr "Vergleich - Neue Zeilen"
=20
=2D#: gitk:10399
+#: gitk:10772
 msgid "Diff: hunk header"
 msgstr "Vergleich: =C4nderungstitel"
=20
=2D#: gitk:10401
+#: gitk:10774
 msgid "diff hunk header"
 msgstr "Vergleich - =C4nderungstitel"
=20
=2D#: gitk:10405
+#: gitk:10778
 msgid "Marked line bg"
 msgstr "Hintergrund f=FCr markierte Zeile"
=20
=2D#: gitk:10407
+#: gitk:10780
 msgid "marked line background"
 msgstr "Hintergrund f=FCr markierte Zeile"
=20
=2D#: gitk:10411
+#: gitk:10784
 msgid "Select bg"
 msgstr "Hintergrundfarbe ausw=E4hlen"
=20
=2D#: gitk:10415
+#: gitk:10788
 msgid "Fonts: press to choose"
 msgstr "Schriftart: Klicken zum W=E4hlen"
=20
=2D#: gitk:10417
+#: gitk:10790
 msgid "Main font"
 msgstr "Programmschriftart"
=20
=2D#: gitk:10418
+#: gitk:10791
 msgid "Diff display font"
 msgstr "Schriftart f=FCr Vergleich"
=20
=2D#: gitk:10419
+#: gitk:10792
 msgid "User interface font"
 msgstr "Beschriftungen"
=20
=2D#: gitk:10446
+#: gitk:10829
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: Farbe w=E4hlen f=FCr %s"
=20
=2D#: gitk:10893
=2Dmsgid ""
=2D"Sorry, gitk cannot run with this version of Tcl/Tk.\n"
=2D" Gitk requires at least Tcl/Tk 8.4."
=2Dmsgstr ""
=2D"Gitk l=E4uft nicht mit dieser Version von Tcl/Tk.\n"
=2D"Gitk ben=F6tigt mindestens Tcl/Tk 8.4."
=2D
=2D#: gitk:11020
+#: gitk:11433
 msgid "Cannot find a git repository here."
 msgstr "Kein Git-Projektarchiv gefunden."
=20
=2D#: gitk:11024
+#: gitk:11437
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
 msgstr "Git-Verzeichnis =BB%s=AB wurde nicht gefunden."
=20
=2D#: gitk:11071
+#: gitk:11484
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Mehrdeutige Angabe =BB%s=AB: Sowohl Version als auch Dateiname exi=
stiert."
=20
=2D#: gitk:11083
+#: gitk:11496
 msgid "Bad arguments to gitk:"
 msgstr "Falsche Kommandozeilen-Parameter f=FCr gitk:"
=20
=2D#: gitk:11167
+#: gitk:11587
 msgid "Command line"
 msgstr "Kommandozeile"
=2D-=20
1.6.3.3


--Boundary-00=_RRJYLJDSHuE52Wq
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-gitk-Update-German-translation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-gitk-Update-German-translation.patch"

=46rom a8264b64382a350dca0b4efb04e3e99a6b2d25bb Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Wed, 27 Jan 2010 20:28:47 +0100
Subject: [PATCH] gitk: Update German translation.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
=2D--
 po/de.po |  741 ++++++++++++++++++++++++++++++++++++----------------------=
=2D---
 1 files changed, 432 insertions(+), 309 deletions(-)

diff --git a/po/de.po b/po/de.po
index e224595..c79aa9c 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -8,33 +8,33 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2009-05-12 21:55+0200\n"
=2D"PO-Revision-Date: 2009-05-12 22:18+0200\n"
+"POT-Creation-Date: 2010-01-27 20:21+0100\n"
+"PO-Revision-Date: 2010-01-27 20:27+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
=2D#: gitk:113
+#: gitk:115
 msgid "Couldn't get list of unmerged files:"
 msgstr "Liste der nicht zusammengef=C3=BChrten Dateien nicht gefunden:"
=20
=2D#: gitk:268
+#: gitk:274
 msgid "Error parsing revisions:"
 msgstr "Fehler beim Laden der Versionen:"
=20
=2D#: gitk:323
+#: gitk:329
 msgid "Error executing --argscmd command:"
 msgstr "Fehler beim Ausf=C3=BChren des --argscmd-Kommandos:"
=20
=2D#: gitk:336
+#: gitk:342
 msgid "No files selected: --merge specified but no files are unmerged."
 msgstr ""
 "Keine Dateien ausgew=C3=A4hlt: Es wurde --merge angegeben, aber es existi=
eren "
 "keine nicht zusammengef=C3=BChrten Dateien."
=20
=2D#: gitk:339
+#: gitk:345
 msgid ""
 "No files selected: --merge specified but no unmerged files are within fil=
e "
 "limit."
@@ -42,719 +42,801 @@ msgstr ""
 "Keine Dateien ausgew=C3=A4hlt: Es wurde --merge angegeben, aber es sind k=
eine "
 "nicht zusammengef=C3=BChrten Dateien in der Dateiauswahl."
=20
=2D#: gitk:361 gitk:508
+#: gitk:367 gitk:514
 msgid "Error executing git log:"
 msgstr "Fehler beim Ausf=C3=BChren von =C2=BBgit log=C2=AB:"
=20
=2D#: gitk:379 gitk:524
+#: gitk:385 gitk:530
 msgid "Reading"
 msgstr "Lesen"
=20
=2D#: gitk:439 gitk:4061
+#: gitk:445 gitk:4261
 msgid "Reading commits..."
 msgstr "Versionen werden gelesen ..."
=20
=2D#: gitk:442 gitk:1560 gitk:4064
+#: gitk:448 gitk:1578 gitk:4264
 msgid "No commits selected"
 msgstr "Keine Versionen ausgew=C3=A4hlt"
=20
=2D#: gitk:1436
+#: gitk:1454
 msgid "Can't parse git log output:"
 msgstr "Ausgabe von =C2=BBgit log=C2=AB kann nicht erkannt werden:"
=20
=2D#: gitk:1656
+#: gitk:1674
 msgid "No commit information available"
 msgstr "Keine Versionsinformation verf=C3=BCgbar"
=20
=2D#: gitk:1791 gitk:1815 gitk:3854 gitk:8714 gitk:10250 gitk:10422
+#: gitk:1816
+msgid "mc"
+msgstr "mc"
+
+#: gitk:1851 gitk:4054 gitk:9044 gitk:10585 gitk:10804
 msgid "OK"
 msgstr "Ok"
=20
=2D#: gitk:1817 gitk:3856 gitk:8311 gitk:8385 gitk:8495 gitk:8544 gitk:8716
=2D#: gitk:10251 gitk:10423
+#: gitk:1853 gitk:4056 gitk:8634 gitk:8713 gitk:8828 gitk:8877 gitk:9046
+#: gitk:10586 gitk:10805
 msgid "Cancel"
 msgstr "Abbrechen"
=20
=2D#: gitk:1917
+#: gitk:1975
 msgid "Update"
 msgstr "Aktualisieren"
=20
=2D#: gitk:1918
+#: gitk:1976
 msgid "Reload"
 msgstr "Neu laden"
=20
=2D#: gitk:1919
+#: gitk:1977
 msgid "Reread references"
 msgstr "Zweige neu laden"
=20
=2D#: gitk:1920
+#: gitk:1978
 msgid "List references"
 msgstr "Zweige/Markierungen auflisten"
=20
=2D#: gitk:1922
+#: gitk:1980
 msgid "Start git gui"
 msgstr "=C2=BBgit gui=C2=AB starten"
=20
=2D#: gitk:1924
+#: gitk:1982
 msgid "Quit"
 msgstr "Beenden"
=20
=2D#: gitk:1916
+#: gitk:1974
 msgid "File"
 msgstr "Datei"
=20
=2D#: gitk:1928
+#: gitk:1986
 msgid "Preferences"
 msgstr "Einstellungen"
=20
=2D#: gitk:1927
+#: gitk:1985
 msgid "Edit"
 msgstr "Bearbeiten"
=20
=2D#: gitk:1932
+#: gitk:1990
 msgid "New view..."
 msgstr "Neue Ansicht ..."
=20
=2D#: gitk:1933
+#: gitk:1991
 msgid "Edit view..."
 msgstr "Ansicht bearbeiten ..."
=20
=2D#: gitk:1934
+#: gitk:1992
 msgid "Delete view"
 msgstr "Ansicht entfernen"
=20
=2D#: gitk:1936
+#: gitk:1994
 msgid "All files"
 msgstr "Alle Dateien"
=20
=2D#: gitk:1931 gitk:3666
+#: gitk:1989 gitk:3808
 msgid "View"
 msgstr "Ansicht"
=20
=2D#: gitk:1941 gitk:1951 gitk:2650
+#: gitk:1999 gitk:2009 gitk:2780
 msgid "About gitk"
 msgstr "=C3=9Cber gitk"
=20
=2D#: gitk:1942 gitk:1956
+#: gitk:2000 gitk:2014
 msgid "Key bindings"
 msgstr "Tastenk=C3=BCrzel"
=20
=2D#: gitk:1940 gitk:1955
+#: gitk:1998 gitk:2013
 msgid "Help"
 msgstr "Hilfe"
=20
=2D#: gitk:2016
=2Dmsgid "SHA1 ID: "
=2Dmsgstr "SHA1:"
+#: gitk:2091 gitk:8110
+msgid "SHA1 ID:"
+msgstr "SHA1 ID:"
=20
=2D#: gitk:2047
+#: gitk:2122
 msgid "Row"
 msgstr "Zeile"
=20
=2D#: gitk:2078
+#: gitk:2160
 msgid "Find"
 msgstr "Suche"
=20
=2D#: gitk:2079
+#: gitk:2161
 msgid "next"
 msgstr "n=C3=A4chste"
=20
=2D#: gitk:2080
+#: gitk:2162
 msgid "prev"
 msgstr "vorige"
=20
=2D#: gitk:2081
+#: gitk:2163
 msgid "commit"
 msgstr "Version nach"
=20
=2D#: gitk:2084 gitk:2086 gitk:4222 gitk:4245 gitk:4269 gitk:6210 gitk:6282
=2D#: gitk:6366
+#: gitk:2166 gitk:2168 gitk:4422 gitk:4445 gitk:4469 gitk:6410 gitk:6482
+#: gitk:6566
 msgid "containing:"
 msgstr "Beschreibung:"
=20
=2D#: gitk:2087 gitk:3158 gitk:3163 gitk:4297
+#: gitk:2169 gitk:3290 gitk:3295 gitk:4497
 msgid "touching paths:"
 msgstr "Dateien:"
=20
=2D#: gitk:2088 gitk:4302
+#: gitk:2170 gitk:4502
 msgid "adding/removing string:"
 msgstr "=C3=84nderungen:"
=20
=2D#: gitk:2097 gitk:2099
+#: gitk:2179 gitk:2181
 msgid "Exact"
 msgstr "Exakt"
=20
=2D#: gitk:2099 gitk:4377 gitk:6178
+#: gitk:2181 gitk:4577 gitk:6378
 msgid "IgnCase"
 msgstr "Kein Gro=C3=9F/Klein"
=20
=2D#: gitk:2099 gitk:4271 gitk:4375 gitk:6174
+#: gitk:2181 gitk:4471 gitk:4575 gitk:6374
 msgid "Regexp"
 msgstr "Regexp"
=20
=2D#: gitk:2101 gitk:2102 gitk:4396 gitk:4426 gitk:4433 gitk:6302 gitk:6370
+#: gitk:2183 gitk:2184 gitk:4596 gitk:4626 gitk:4633 gitk:6502 gitk:6570
 msgid "All fields"
 msgstr "Alle Felder"
=20
=2D#: gitk:2102 gitk:4394 gitk:4426 gitk:6241
+#: gitk:2184 gitk:4594 gitk:4626 gitk:6441
 msgid "Headline"
 msgstr "=C3=9Cberschrift"
=20
=2D#: gitk:2103 gitk:4394 gitk:6241 gitk:6370 gitk:6804
+#: gitk:2185 gitk:4594 gitk:6441 gitk:6570 gitk:7003
 msgid "Comments"
 msgstr "Beschreibung"
=20
=2D#: gitk:2103 gitk:4394 gitk:4398 gitk:4433 gitk:6241 gitk:6739 gitk:7991
=2D#: gitk:8006
+#: gitk:2185 gitk:4594 gitk:4598 gitk:4633 gitk:6441 gitk:6938 gitk:8285
+#: gitk:8300
 msgid "Author"
 msgstr "Autor"
=20
=2D#: gitk:2103 gitk:4394 gitk:6241 gitk:6741
+#: gitk:2185 gitk:4594 gitk:6441 gitk:6940
 msgid "Committer"
 msgstr "Eintragender"
=20
=2D#: gitk:2132
+#: gitk:2216
 msgid "Search"
 msgstr "Suchen"
=20
=2D#: gitk:2139
+#: gitk:2224
 msgid "Diff"
 msgstr "Vergleich"
=20
=2D#: gitk:2141
+#: gitk:2226
 msgid "Old version"
 msgstr "Alte Version"
=20
=2D#: gitk:2143
+#: gitk:2228
 msgid "New version"
 msgstr "Neue Version"
=20
=2D#: gitk:2145
+#: gitk:2230
 msgid "Lines of context"
 msgstr "Kontextzeilen"
=20
=2D#: gitk:2155
+#: gitk:2240
 msgid "Ignore space change"
 msgstr "Leerzeichen=C3=A4nderungen ignorieren"
=20
=2D#: gitk:2213
+#: gitk:2299
 msgid "Patch"
 msgstr "Patch"
=20
=2D#: gitk:2215
+#: gitk:2301
 msgid "Tree"
 msgstr "Baum"
=20
=2D#: gitk:2359 gitk:2376
+#: gitk:2456 gitk:2473
 msgid "Diff this -> selected"
 msgstr "Vergleich: diese -> gew=C3=A4hlte"
=20
=2D#: gitk:2360 gitk:2377
+#: gitk:2457 gitk:2474
 msgid "Diff selected -> this"
 msgstr "Vergleich: gew=C3=A4hlte -> diese"
=20
=2D#: gitk:2361 gitk:2378
+#: gitk:2458 gitk:2475
 msgid "Make patch"
 msgstr "Patch erstellen"
=20
=2D#: gitk:2362 gitk:8369
+#: gitk:2459 gitk:8692
 msgid "Create tag"
 msgstr "Markierung erstellen"
=20
=2D#: gitk:2363 gitk:8475
+#: gitk:2460 gitk:8808
 msgid "Write commit to file"
 msgstr "Version in Datei schreiben"
=20
=2D#: gitk:2364 gitk:8532
+#: gitk:2461 gitk:8865
 msgid "Create new branch"
 msgstr "Neuen Zweig erstellen"
=20
=2D#: gitk:2365
+#: gitk:2462
 msgid "Cherry-pick this commit"
 msgstr "Diese Version pfl=C3=BCcken"
=20
=2D#: gitk:2366
+#: gitk:2463
 msgid "Reset HEAD branch to here"
 msgstr "HEAD-Zweig auf diese Version zur=C3=BCcksetzen"
=20
=2D#: gitk:2367
+#: gitk:2464
 msgid "Mark this commit"
 msgstr "Lesezeichen setzen"
=20
=2D#: gitk:2368
+#: gitk:2465
 msgid "Return to mark"
 msgstr "Zum Lesezeichen"
=20
=2D#: gitk:2369
+#: gitk:2466
 msgid "Find descendant of this and mark"
 msgstr "Abk=C3=B6mmling von Lesezeichen und dieser Version finden"
=20
=2D#: gitk:2370
+#: gitk:2467
 msgid "Compare with marked commit"
 msgstr "Mit Lesezeichen vergleichen"
=20
=2D#: gitk:2384
+#: gitk:2481
 msgid "Check out this branch"
 msgstr "Auf diesen Zweig umstellen"
=20
=2D#: gitk:2385
+#: gitk:2482
 msgid "Remove this branch"
 msgstr "Zweig l=C3=B6schen"
=20
=2D#: gitk:2392
+#: gitk:2489
 msgid "Highlight this too"
 msgstr "Diesen auch hervorheben"
=20
=2D#: gitk:2393
+#: gitk:2490
 msgid "Highlight this only"
 msgstr "Nur diesen hervorheben"
=20
=2D#: gitk:2394
+#: gitk:2491
 msgid "External diff"
 msgstr "Externes Diff-Programm"
=20
=2D#: gitk:2395
+#: gitk:2492
 msgid "Blame parent commit"
 msgstr "Annotieren der Elternversion"
=20
=2D#: gitk:2402
+#: gitk:2499
 msgid "Show origin of this line"
 msgstr "Herkunft dieser Zeile anzeigen"
=20
=2D#: gitk:2403
+#: gitk:2500
 msgid "Run git gui blame on this line"
 msgstr "Diese Zeile annotieren (=C2=BBgit gui blame=C2=AB)"
=20
=2D#: gitk:2652
+#: gitk:2782
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
=2D"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"Copyright =C2=A99 2005-2009 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public License"
 msgstr ""
 "\n"
 "Gitk - eine Visualisierung der Git-Historie\n"
 "\n"
=2D"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"Copyright =C2=A9 2005-2009 Paul Mackerras\n"
 "\n"
=2D"Benutzung und Weiterverbreitung gem=C3=A4=C3=9F den Bedingungen der GNU=
 General Public "
=2D"License"
+"Benutzung und Weiterverbreitung gem=C3=A4=C3=9F den Bedingungen der GNU G=
eneral Public License"
=20
=2D#: gitk:2660 gitk:2722 gitk:8897
+#: gitk:2790 gitk:2854 gitk:9230
 msgid "Close"
 msgstr "Schlie=C3=9Fen"
=20
=2D#: gitk:2679
+#: gitk:2811
 msgid "Gitk key bindings"
 msgstr "Gitk-Tastaturbelegung"
=20
=2D#: gitk:2682
+#: gitk:2814
 msgid "Gitk key bindings:"
 msgstr "Gitk-Tastaturbelegung:"
=20
=2D#: gitk:2684
+#: gitk:2816
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tBeenden"
=20
=2D#: gitk:2685
+#: gitk:2817
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Pos1>\t\tZur neuesten Version springen"
=20
=2D#: gitk:2686
+#: gitk:2818
 msgid "<End>\t\tMove to last commit"
 msgstr "<Ende>\t\tZur =C3=A4ltesten Version springen"
=20
=2D#: gitk:2687
+#: gitk:2819
 msgid "<Up>, p, i\tMove up one commit"
 msgstr "<Hoch>, p, i\tN=C3=A4chste neuere Version"
=20
=2D#: gitk:2688
+#: gitk:2820
 msgid "<Down>, n, k\tMove down one commit"
 msgstr "<Runter>, n, k\tN=C3=A4chste =C3=A4ltere Version"
=20
=2D#: gitk:2689
+#: gitk:2821
 msgid "<Left>, z, j\tGo back in history list"
 msgstr "<Links>, z, j\tEine Version zur=C3=BCckgehen"
=20
=2D#: gitk:2690
+#: gitk:2822
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Rechts>, x, l\tEine Version weitergehen"
=20
=2D#: gitk:2691
+#: gitk:2823
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<BildHoch>\tEine Seite nach oben bl=C3=A4ttern"
=20
=2D#: gitk:2692
+#: gitk:2824
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<BildRunter>\tEine Seite nach unten bl=C3=A4ttern"
=20
=2D#: gitk:2693
+#: gitk:2825
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Pos1>\tZum oberen Ende der Versionsliste bl=C3=A4ttern"
=20
=2D#: gitk:2694
+#: gitk:2826
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-Ende>\tZum unteren Ende der Versionsliste bl=C3=A4ttern"
=20
=2D#: gitk:2695
+#: gitk:2827
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Hoch>\tVersionsliste eine Zeile nach oben bl=C3=A4ttern"
=20
=2D#: gitk:2696
+#: gitk:2828
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Runter>\tVersionsliste eine Zeile nach unten bl=C3=A4ttern"
=20
=2D#: gitk:2697
+#: gitk:2829
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-BildHoch>\tVersionsliste eine Seite nach oben bl=C3=A4ttern"
=20
=2D#: gitk:2698
+#: gitk:2830
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-BildRunter>\tVersionsliste eine Seite nach unten bl=C3=A4ttern"
=20
=2D#: gitk:2699
+#: gitk:2831
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Umschalt-Hoch>\tR=C3=BCckw=C3=A4rts suchen (nach oben; neuere Ver=
sionen)"
=20
=2D#: gitk:2700
+#: gitk:2832
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Umschalt-Runter> Suchen (nach unten; =C3=A4ltere Versionen)"
=20
=2D#: gitk:2701
+#: gitk:2833
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Entf>, b\t\tVergleich eine Seite nach oben bl=C3=A4ttern"
=20
=2D#: gitk:2702
+#: gitk:2834
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<L=C3=B6schtaste>\tVergleich eine Seite nach oben bl=C3=A4ttern"
=20
=2D#: gitk:2703
+#: gitk:2835
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Leertaste>\tVergleich eine Seite nach unten bl=C3=A4ttern"
=20
=2D#: gitk:2704
+#: gitk:2836
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tVergleich um 18 Zeilen nach oben bl=C3=A4ttern"
=20
=2D#: gitk:2705
+#: gitk:2837
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tVergleich um 18 Zeilen nach unten bl=C3=A4ttern"
=20
=2D#: gitk:2706
+#: gitk:2838
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tSuchen"
=20
=2D#: gitk:2707
+#: gitk:2839
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tWeitersuchen"
=20
=2D#: gitk:2708
+#: gitk:2840
 msgid "<Return>\tMove to next find hit"
 msgstr "<Eingabetaste>\tWeitersuchen"
=20
=2D#: gitk:2709
+#: gitk:2841
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tTastaturfokus ins Suchfeld"
=20
=2D#: gitk:2710
+#: gitk:2842
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tR=C3=BCckw=C3=A4rts weitersuchen"
=20
=2D#: gitk:2711
+#: gitk:2843
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tVergleich zur n=C3=A4chsten Datei bl=C3=A4ttern"
=20
=2D#: gitk:2712
+#: gitk:2844
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tWeitersuchen im Vergleich"
=20
=2D#: gitk:2713
+#: gitk:2845
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tR=C3=BCckw=C3=A4rts weitersuchen im Vergleich"
=20
=2D#: gitk:2714
+#: gitk:2846
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-Nummerblock-Plus>\tSchrift vergr=C3=B6=C3=9Fern"
=20
=2D#: gitk:2715
+#: gitk:2847
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-Plus>\tSchrift vergr=C3=B6=C3=9Fern"
=20
=2D#: gitk:2716
+#: gitk:2848
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-Nummernblock-Minus> Schrift verkleinern"
=20
=2D#: gitk:2717
+#: gitk:2849
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-Minus>\tSchrift verkleinern"
=20
=2D#: gitk:2718
+#: gitk:2850
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tAktualisieren"
=20
=2D#: gitk:3173
=2D#, tcl-format
=2Dmsgid "Error getting \"%s\" from %s:"
=2Dmsgstr "Fehler beim Holen von =C2=BB%s=C2=AB von =C2=BB%s=C2=AB:"
=2D
=2D#: gitk:3230 gitk:3239
+#: gitk:3305 gitk:3314
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "Fehler beim Erzeugen des tempor=C3=A4ren Verzeichnisses =C2=BB%s=
=C2=AB:"
=20
=2D#: gitk:3251
+#: gitk:3327
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "Fehler beim Holen von =C2=BB%s=C2=AB von =C2=BB%s=C2=AB:"
+
+#: gitk:3390
 msgid "command failed:"
 msgstr "Kommando fehlgeschlagen:"
=20
=2D#: gitk:3397
+#: gitk:3539
 msgid "No such commit"
 msgstr "Version nicht gefunden"
=20
=2D#: gitk:3411
+#: gitk:3553
 msgid "git gui blame: command failed:"
 msgstr "git gui blame: Kommando fehlgeschlagen:"
=20
=2D#: gitk:3442
+#: gitk:3584
 #, tcl-format
 msgid "Couldn't read merge head: %s"
 msgstr "Zusammenf=C3=BChrungs-Spitze konnte nicht gelesen werden: %s"
=20
=2D#: gitk:3450
+#: gitk:3592
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "Fehler beim Lesen der Bereitstellung (=C2=BBindex=C2=AB): %s"
=20
=2D#: gitk:3475
+#: gitk:3617
 #, tcl-format
 msgid "Couldn't start git blame: %s"
 msgstr "=C2=BBgit blame=C2=AB konnte nicht gestartet werden: %s"
=20
=2D#: gitk:3478 gitk:6209
+#: gitk:3620 gitk:6409
 msgid "Searching"
 msgstr "Suchen"
=20
=2D#: gitk:3510
+#: gitk:3652
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "Fehler beim Ausf=C3=BChren von =C2=BBgit blame=C2=AB: %s"
=20
=2D#: gitk:3538
+#: gitk:3680
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr ""
 "Diese Zeile stammt aus Version %s, die nicht in dieser Ansicht gezeigt wi=
rd"
=20
=2D#: gitk:3552
+#: gitk:3694
 msgid "External diff viewer failed:"
 msgstr "Externes Diff-Programm fehlgeschlagen:"
=20
=2D#: gitk:3670
+#: gitk:3812
 msgid "Gitk view definition"
 msgstr "Gitk-Ansichten"
=20
=2D#: gitk:3674
+#: gitk:3816
 msgid "Remember this view"
 msgstr "Diese Ansicht speichern"
=20
=2D#: gitk:3675
=2Dmsgid "Commits to include (arguments to git log):"
=2Dmsgstr "Versionen anzeigen (Argumente von git log):"
+#: gitk:3817
+msgid "References (space separated list):"
+msgstr "Zweige/Markierungen (durch Leerzeichen getrennte Liste):"
=20
=2D#: gitk:3676
=2Dmsgid "Use all refs"
=2Dmsgstr "Alle Zweige verwenden"
+#: gitk:3818
+msgid "Branches & tags:"
+msgstr "Zweige/Markierungen:"
=20
=2D#: gitk:3677
=2Dmsgid "Strictly sort by date"
=2Dmsgstr "Streng nach Datum sortieren"
+#: gitk:3819
+msgid "All refs"
+msgstr "Alle Markierungen und Zweige"
=20
=2D#: gitk:3678
=2Dmsgid "Mark branch sides"
=2Dmsgstr "Zweig-Seiten markieren"
+#: gitk:3820
+msgid "All (local) branches"
+msgstr "Alle (lokalen) Zweige"
=20
=2D#: gitk:3679
=2Dmsgid "Since date:"
=2Dmsgstr "Von Datum:"
+#: gitk:3821
+msgid "All tags"
+msgstr "Alle Markierungen"
=20
=2D#: gitk:3680
=2Dmsgid "Until date:"
=2Dmsgstr "Bis Datum:"
+#: gitk:3822
+msgid "All remote-tracking branches"
+msgstr "Alle =C3=9Cbernahmezweige"
+
+#: gitk:3823
+msgid "Commit Info (regular expressions):"
+msgstr "Versionsinformationen (regul=C3=A4re Ausdr=C3=BCcke):"
+
+#: gitk:3824
+msgid "Author:"
+msgstr "Autor:"
+
+#: gitk:3825
+msgid "Committer:"
+msgstr "Eintragender:"
+
+#: gitk:3826
+msgid "Commit Message:"
+msgstr "Versionsbeschreibung:"
=20
=2D#: gitk:3681
=2Dmsgid "Max count:"
=2Dmsgstr "Max. Anzahl:"
+#: gitk:3827
+msgid "Matches all Commit Info criteria"
+msgstr "Alle Versionsinformationen-Kriterien erf=C3=BCllen"
=20
=2D#: gitk:3682
=2Dmsgid "Skip:"
+#: gitk:3828
+msgid "Changes to Files:"
+msgstr "Dateien:"
+
+#: gitk:3829
+msgid "Fixed String"
+msgstr "Zeichenkette"
+
+#: gitk:3830
+msgid "Regular Expression"
+msgstr "Regul=C3=A4rer Ausdruck"
+
+#: gitk:3831
+msgid "Search string:"
+msgstr "Suchausdruck:"
+
+#: gitk:3832
+msgid ""
+"Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2009 "
+"15:27:38\"):"
+msgstr "Datum (=C2=BB2 weeks ago=C2=AB, =C2=BB2009-03-17 15:27:38=C2=AB, =
=C2=BBMarch 17, 2009 15:27:38=C2=AB)"
+
+#: gitk:3833
+msgid "Since:"
+msgstr "Von:"
+
+#: gitk:3834
+msgid "Until:"
+msgstr "Bis:"
+
+#: gitk:3835
+msgid "Limit and/or skip a number of revisions (positive integer):"
+msgstr "Versionsanzahl begrenzen oder einige =C3=BCberspringen (ganzzahlig=
er Wert):"
+
+#: gitk:3836
+msgid "Number to show:"
+msgstr "Anzeigen:"
+
+#: gitk:3837
+msgid "Number to skip:"
 msgstr "=C3=9Cberspringen:"
=20
=2D#: gitk:3683
+#: gitk:3838
+msgid "Miscellaneous options:"
+msgstr "Sonstiges:"
+
+#: gitk:3839
+msgid "Strictly sort by date"
+msgstr "Streng nach Datum sortieren"
+
+#: gitk:3840
+msgid "Mark branch sides"
+msgstr "Zweig-Seiten markieren"
+
+#: gitk:3841
 msgid "Limit to first parent"
 msgstr "Auf erste Elternversion beschr=C3=A4nken"
=20
=2D#: gitk:3684
+#: gitk:3842
+msgid "Simple history"
+msgstr "Einfache Historie"
+
+#: gitk:3843
+msgid "Additional arguments to git log:"
+msgstr "Zus=C3=A4tzliche Argumente f=C3=BCr =C2=BBgit log=C2=AB:"
+
+#: gitk:3844
+msgid "Enter files and directories to include, one per line:"
+msgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
+
+#: gitk:3845
 msgid "Command to generate more commits to include:"
 msgstr "Versionsliste durch folgendes Kommando erzeugen lassen:"
=20
=2D#: gitk:3780
+#: gitk:3967
 msgid "Gitk: edit view"
 msgstr "Gitk: Ansicht bearbeiten"
=20
=2D#: gitk:3793
=2Dmsgid "Name"
=2Dmsgstr "Name"
+#: gitk:3975
+msgid "-- criteria for selecting revisions"
+msgstr "-- Auswahl der angezeigten Versionen"
=20
=2D#: gitk:3841
=2Dmsgid "Enter files and directories to include, one per line:"
=2Dmsgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
+#: gitk:3980
+msgid "View Name"
+msgstr "Ansichtsname"
=20
=2D#: gitk:3855
+#: gitk:4055
 msgid "Apply (F5)"
 msgstr "Anwenden (F5)"
=20
=2D#: gitk:3893
+#: gitk:4093
 msgid "Error in commit selection arguments:"
 msgstr "Fehler in den ausgew=C3=A4hlten Versionen:"
=20
=2D#: gitk:3946 gitk:3998 gitk:4446 gitk:4460 gitk:5721 gitk:11114 gitk:111=
15
+#: gitk:4146 gitk:4198 gitk:4646 gitk:4660 gitk:5921 gitk:11534 gitk:11535
 msgid "None"
 msgstr "Keine"
=20
=2D#: gitk:4394 gitk:6241 gitk:7993 gitk:8008
+#: gitk:4594 gitk:6441 gitk:8287 gitk:8302
 msgid "Date"
 msgstr "Datum"
=20
=2D#: gitk:4394 gitk:6241
+#: gitk:4594 gitk:6441
 msgid "CDate"
 msgstr "Eintragedatum"
=20
=2D#: gitk:4543 gitk:4548
+#: gitk:4743 gitk:4748
 msgid "Descendant"
 msgstr "Abk=C3=B6mmling"
=20
=2D#: gitk:4544
+#: gitk:4744
 msgid "Not descendant"
 msgstr "Kein Abk=C3=B6mmling"
=20
=2D#: gitk:4551 gitk:4556
+#: gitk:4751 gitk:4756
 msgid "Ancestor"
 msgstr "Vorg=C3=A4nger"
=20
=2D#: gitk:4552
+#: gitk:4752
 msgid "Not ancestor"
 msgstr "Kein Vorg=C3=A4nger"
=20
=2D#: gitk:4842
+#: gitk:5042
 msgid "Local changes checked in to index but not committed"
 msgstr "Lokale =C3=84nderungen bereitgestellt, aber nicht eingetragen"
=20
=2D#: gitk:4878
+#: gitk:5078
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokale =C3=84nderungen, nicht bereitgestellt"
=20
=2D#: gitk:6559
+#: gitk:6759
 msgid "many"
 msgstr "viele"
=20
=2D#: gitk:6743
+#: gitk:6942
 msgid "Tags:"
 msgstr "Markierungen:"
=20
=2D#: gitk:6760 gitk:6766 gitk:7986
+#: gitk:6959 gitk:6965 gitk:8280
 msgid "Parent"
 msgstr "Eltern"
=20
=2D#: gitk:6771
+#: gitk:6970
 msgid "Child"
 msgstr "Kind"
=20
=2D#: gitk:6780
+#: gitk:6979
 msgid "Branch"
 msgstr "Zweig"
=20
=2D#: gitk:6783
+#: gitk:6982
 msgid "Follows"
 msgstr "Folgt auf"
=20
=2D#: gitk:6786
+#: gitk:6985
 msgid "Precedes"
 msgstr "Vorg=C3=A4nger von"
=20
=2D#: gitk:7279
+#: gitk:7522
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Fehler beim Laden des Vergleichs: %s"
=20
=2D#: gitk:7819
+#: gitk:8108
 msgid "Goto:"
 msgstr "Gehe zu:"
=20
=2D#: gitk:7821
=2Dmsgid "SHA1 ID:"
=2Dmsgstr "SHA1 ID:"
=2D
=2D#: gitk:7840
+#: gitk:8129
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Kurzer SHA1-Hashwert =C2=BB%s=C2=AB ist mehrdeutig"
=20
=2D#: gitk:7852
+#: gitk:8136
+#, tcl-format
+msgid "Revision %s is not known"
+msgstr "Version =C2=BB%s=C2=AB ist unbekannt"
+
+#: gitk:8146
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA1-Hashwert =C2=BB%s=C2=AB ist unbekannt"
=20
=2D#: gitk:7854
+#: gitk:8148
 #, tcl-format
=2Dmsgid "Tag/Head %s is not known"
=2Dmsgstr "Markierung/Zweig =C2=BB%s=C2=AB ist unbekannt"
+msgid "Revision %s is not in the current view"
+msgstr "Version =C2=BB%s=C2=AB wird in der aktuellen Ansicht nicht angezei=
gt"
=20
=2D#: gitk:7996
+#: gitk:8290
 msgid "Children"
 msgstr "Kinder"
=20
=2D#: gitk:8053
+#: gitk:8348
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Zweig =C2=BB%s=C2=AB hierher zur=C3=BCcksetzen"
=20
=2D#: gitk:8055
+#: gitk:8350
 msgid "Detached head: can't reset"
 msgstr "Zweigspitze ist abgetrennt: Zur=C3=BCcksetzen nicht m=C3=B6glich"
=20
=2D#: gitk:8164 gitk:8170
+#: gitk:8459 gitk:8465
 msgid "Skipping merge commit "
 msgstr "=C3=9Cberspringe Zusammenf=C3=BChrungs-Version "
=20
=2D#: gitk:8179 gitk:8184
+#: gitk:8474 gitk:8479
 msgid "Error getting patch ID for "
 msgstr "Fehler beim Holen der Patch-ID f=C3=BCr "
=20
=2D#: gitk:8180 gitk:8185
+#: gitk:8475 gitk:8480
 msgid " - stopping\n"
 msgstr " - Abbruch.\n"
=20
=2D#: gitk:8190 gitk:8193 gitk:8201 gitk:8211 gitk:8220
+#: gitk:8485 gitk:8488 gitk:8496 gitk:8510 gitk:8519
 msgid "Commit "
 msgstr "Version "
=20
=2D#: gitk:8194
+#: gitk:8489
 msgid ""
 " is the same patch as\n"
 "       "
@@ -762,7 +844,7 @@ msgstr ""
 " ist das gleiche Patch wie\n"
 "       "
=20
=2D#: gitk:8202
+#: gitk:8497
 msgid ""
 " differs from\n"
 "       "
@@ -770,117 +852,138 @@ msgstr ""
 " ist unterschiedlich von\n"
 "       "
=20
=2D#: gitk:8204
=2Dmsgid "- stopping\n"
=2Dmsgstr "- Abbruch.\n"
+#: gitk:8499
+msgid ""
+"Diff of commits:\n"
+"\n"
+msgstr ""
+"Vergleich der Versionen:\n"
+"\n"
=20
=2D#: gitk:8212 gitk:8221
+#: gitk:8511 gitk:8520
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " hat %s Kinder. Abbruch\n"
=20
=2D#: gitk:8252
+#: gitk:8539
+#, tcl-format
+msgid "Error writing commit to file: %s"
+msgstr "Fehler beim Schreiben der Version in Datei: %s"
+
+#: gitk:8545
+#, tcl-format
+msgid "Error diffing commits: %s"
+msgstr "Fehler beim Vergleichen der Versionen: %s"
+
+#: gitk:8575
 msgid "Top"
 msgstr "Oben"
=20
=2D#: gitk:8253
+#: gitk:8576
 msgid "From"
 msgstr "Von"
=20
=2D#: gitk:8258
+#: gitk:8581
 msgid "To"
 msgstr "bis"
=20
=2D#: gitk:8282
+#: gitk:8605
 msgid "Generate patch"
 msgstr "Patch erstellen"
=20
=2D#: gitk:8284
+#: gitk:8607
 msgid "From:"
 msgstr "Von:"
=20
=2D#: gitk:8293
+#: gitk:8616
 msgid "To:"
 msgstr "bis:"
=20
=2D#: gitk:8302
+#: gitk:8625
 msgid "Reverse"
 msgstr "Umgekehrt"
=20
=2D#: gitk:8304 gitk:8489
+#: gitk:8627 gitk:8822
 msgid "Output file:"
 msgstr "Ausgabedatei:"
=20
=2D#: gitk:8310
+#: gitk:8633
 msgid "Generate"
 msgstr "Erzeugen"
=20
=2D#: gitk:8348
+#: gitk:8671
 msgid "Error creating patch:"
 msgstr "Fehler beim Erzeugen des Patches:"
=20
=2D#: gitk:8371 gitk:8477 gitk:8534
+#: gitk:8694 gitk:8810 gitk:8867
 msgid "ID:"
 msgstr "ID:"
=20
=2D#: gitk:8380
+#: gitk:8703
 msgid "Tag name:"
 msgstr "Markierungsname:"
=20
=2D#: gitk:8384 gitk:8543
+#: gitk:8706
+msgid "Tag message is optional"
+msgstr "Eine Markierungsbeschreibung ist optional"
+
+#: gitk:8708
+msgid "Tag message:"
+msgstr "Markierungsbeschreibung:"
+
+#: gitk:8712 gitk:8876
 msgid "Create"
 msgstr "Erstellen"
=20
=2D#: gitk:8401
+#: gitk:8730
 msgid "No tag name specified"
 msgstr "Kein Markierungsname angegeben"
=20
=2D#: gitk:8405
+#: gitk:8734
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Markierung =C2=BB%s=C2=AB existiert bereits."
=20
=2D#: gitk:8411
+#: gitk:8744
 msgid "Error creating tag:"
 msgstr "Fehler beim Erstellen der Markierung:"
=20
=2D#: gitk:8486
+#: gitk:8819
 msgid "Command:"
 msgstr "Kommando:"
=20
=2D#: gitk:8494
+#: gitk:8827
 msgid "Write"
 msgstr "Schreiben"
=20
=2D#: gitk:8512
+#: gitk:8845
 msgid "Error writing commit:"
 msgstr "Fehler beim Schreiben der Version:"
=20
=2D#: gitk:8539
+#: gitk:8872
 msgid "Name:"
 msgstr "Name:"
=20
=2D#: gitk:8562
+#: gitk:8895
 msgid "Please specify a name for the new branch"
 msgstr "Bitte geben Sie einen Namen f=C3=BCr den neuen Zweig an."
=20
=2D#: gitk:8567
+#: gitk:8900
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "Zweig =C2=BB%s=C2=AB existiert bereits. Soll er =C3=BCberschrieben=
 werden?"
=20
=2D#: gitk:8633
+#: gitk:8966
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
=2D"Version =C2=BB%s=C2=AB ist bereits im Zweig =C2=BB%s=C2=AB enthalten --=
 trotzdem erneut "
=2D"eintragen?"
+"Version =C2=BB%s=C2=AB ist bereits im Zweig =C2=BB%s=C2=AB enthalten -- t=
rotzdem erneut eintragen?"
=20
=2D#: gitk:8638
+#: gitk:8971
 msgid "Cherry-picking"
 msgstr "Version pfl=C3=BCcken"
=20
=2D#: gitk:8647
+#: gitk:8980
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -890,7 +993,7 @@ msgstr ""
 "vorliegen. Bitte diese =C3=84nderungen eintragen, zur=C3=BCcksetzen oder\=
n"
 "zwischenspeichern (=C2=BBgit stash=C2=AB) und dann erneut versuchen."
=20
=2D#: gitk:8653
+#: gitk:8986
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -899,34 +1002,34 @@ msgstr ""
 "ist. Soll das Zusammenf=C3=BChrungs-Werkzeug (=C2=BBgit citool=C2=AB) auf=
gerufen\n"
 "werden, um diesen Konflikt aufzul=C3=B6sen?"
=20
=2D#: gitk:8669
+#: gitk:9002
 msgid "No changes committed"
 msgstr "Keine =C3=84nderungen eingetragen"
=20
=2D#: gitk:8695
+#: gitk:9028
 msgid "Confirm reset"
 msgstr "Zur=C3=BCcksetzen best=C3=A4tigen"
=20
=2D#: gitk:8697
+#: gitk:9030
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Zweig =C2=BB%s=C2=AB auf =C2=BB%s=C2=AB zur=C3=BCcksetzen?"
=20
=2D#: gitk:8701
+#: gitk:9032
 msgid "Reset type:"
 msgstr "Art des Zur=C3=BCcksetzens:"
=20
=2D#: gitk:8705
+#: gitk:9035
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Harmlos: Arbeitskopie und Bereitstellung unver=C3=A4ndert"
=20
=2D#: gitk:8708
+#: gitk:9038
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr ""
 "Gemischt: Arbeitskopie unver=C3=A4ndert,\n"
 "Bereitstellung zur=C3=BCckgesetzt"
=20
=2D#: gitk:8711
+#: gitk:9041
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -934,21 +1037,21 @@ msgstr ""
 "Hart: Arbeitskopie und Bereitstellung\n"
 "(Alle lokalen =C3=84nderungen werden gel=C3=B6scht)"
=20
=2D#: gitk:8728
+#: gitk:9058
 msgid "Resetting"
 msgstr "Zur=C3=BCcksetzen"
=20
=2D#: gitk:8785
+#: gitk:9118
 msgid "Checking out"
 msgstr "Umstellen"
=20
=2D#: gitk:8838
+#: gitk:9171
 msgid "Cannot delete the currently checked-out branch"
 msgstr ""
 "Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kann nicht "
 "gel=C3=B6scht werden."
=20
=2D#: gitk:8844
+#: gitk:9177
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -957,16 +1060,16 @@ msgstr ""
 "Die Versionen auf Zweig =C2=BB%s=C2=AB existieren auf keinem anderen Zwei=
g.\n"
 "Zweig =C2=BB%s=C2=AB trotzdem l=C3=B6schen?"
=20
=2D#: gitk:8875
+#: gitk:9208
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Markierungen und Zweige: %s"
=20
=2D#: gitk:8890
+#: gitk:9223
 msgid "Filter"
 msgstr "Filtern"
=20
=2D#: gitk:9185
+#: gitk:9518
 msgid ""
 "Error reading commit topology information; branch and preceding/following=
 "
 "tag information will be incomplete."
@@ -974,182 +1077,202 @@ msgstr ""
 "Fehler beim Lesen der Strukturinformationen; Zweige und Informationen zu "
 "Vorg=C3=A4nger/Nachfolger werden unvollst=C3=A4ndig sein."
=20
=2D#: gitk:10171
+#: gitk:10504
 msgid "Tag"
 msgstr "Markierung"
=20
=2D#: gitk:10171
+#: gitk:10504
 msgid "Id"
 msgstr "Id"
=20
=2D#: gitk:10219
+#: gitk:10554
 msgid "Gitk font chooser"
 msgstr "Gitk-Schriften w=C3=A4hlen"
=20
=2D#: gitk:10236
+#: gitk:10571
 msgid "B"
 msgstr "F"
=20
=2D#: gitk:10239
+#: gitk:10574
 msgid "I"
 msgstr "K"
=20
=2D#: gitk:10334
+#: gitk:10692
 msgid "Gitk preferences"
 msgstr "Gitk-Einstellungen"
=20
=2D#: gitk:10336
+#: gitk:10694
 msgid "Commit list display options"
 msgstr "Anzeige der Versionsliste"
=20
=2D#: gitk:10339
+#: gitk:10697
 msgid "Maximum graph width (lines)"
 msgstr "Maximale Graphenbreite (Zeilen)"
=20
=2D#: gitk:10343
+#: gitk:10700
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximale Graphenbreite (% des Fensters)"
=20
=2D#: gitk:10347
+#: gitk:10703
 msgid "Show local changes"
 msgstr "Lokale =C3=84nderungen anzeigen"
=20
=2D#: gitk:10350
+#: gitk:10706
 msgid "Auto-select SHA1"
 msgstr "SHA1-Hashwert automatisch ausw=C3=A4hlen"
=20
=2D#: gitk:10354
+#: gitk:10709
+msgid "Hide remote refs"
+msgstr "Entfernte Zweige/Markierungen ausblenden"
+
+#: gitk:10713
 msgid "Diff display options"
 msgstr "Anzeige des Vergleichs"
=20
=2D#: gitk:10356
+#: gitk:10715
 msgid "Tab spacing"
 msgstr "Tabulatorbreite"
=20
=2D#: gitk:10359
+#: gitk:10718
 msgid "Display nearby tags"
 msgstr "Naheliegende Markierungen anzeigen"
=20
=2D#: gitk:10362
+#: gitk:10721
 msgid "Limit diffs to listed paths"
 msgstr "Vergleich nur f=C3=BCr angezeigte Pfade"
=20
=2D#: gitk:10365
+#: gitk:10724
 msgid "Support per-file encodings"
 msgstr "Zeichenkodierung pro Datei ermitteln"
=20
=2D#: gitk:10371 gitk:10436
+#: gitk:10730 gitk:10819
 msgid "External diff tool"
 msgstr "Externes Diff-Programm"
=20
=2D#: gitk:10373
+#: gitk:10731
 msgid "Choose..."
 msgstr "W=C3=A4hlen ..."
=20
=2D#: gitk:10378
+#: gitk:10736
+msgid "General options"
+msgstr "Allgemeine Optionen"
+
+#: gitk:10739
+msgid "Use themed widgets"
+msgstr "Aussehen der Benutzeroberfl=C3=A4che durch Thema bestimmen"
+
+#: gitk:10741
+msgid "(change requires restart)"
+msgstr "(=C3=84nderungen werden erst nach Neustart wirksam)"
+
+#: gitk:10743
+msgid "(currently unavailable)"
+msgstr "(Momentan nicht verf=C3=BCgbar)"
+
+#: gitk:10747
 msgid "Colors: press to choose"
 msgstr "Farben: Klicken zum W=C3=A4hlen"
=20
=2D#: gitk:10381
+#: gitk:10750
+msgid "Interface"
+msgstr "Benutzeroberfl=C3=A4che"
+
+#: gitk:10751
+msgid "interface"
+msgstr "Benutzeroberfl=C3=A4che"
+
+#: gitk:10754
 msgid "Background"
 msgstr "Hintergrund"
=20
=2D#: gitk:10382 gitk:10412
+#: gitk:10755 gitk:10785
 msgid "background"
 msgstr "Hintergrund"
=20
=2D#: gitk:10385
+#: gitk:10758
 msgid "Foreground"
 msgstr "Vordergrund"
=20
=2D#: gitk:10386
+#: gitk:10759
 msgid "foreground"
 msgstr "Vordergrund"
=20
=2D#: gitk:10389
+#: gitk:10762
 msgid "Diff: old lines"
 msgstr "Vergleich: Alte Zeilen"
=20
=2D#: gitk:10390
+#: gitk:10763
 msgid "diff old lines"
 msgstr "Vergleich - Alte Zeilen"
=20
=2D#: gitk:10394
+#: gitk:10767
 msgid "Diff: new lines"
 msgstr "Vergleich: Neue Zeilen"
=20
=2D#: gitk:10395
+#: gitk:10768
 msgid "diff new lines"
 msgstr "Vergleich - Neue Zeilen"
=20
=2D#: gitk:10399
+#: gitk:10772
 msgid "Diff: hunk header"
 msgstr "Vergleich: =C3=84nderungstitel"
=20
=2D#: gitk:10401
+#: gitk:10774
 msgid "diff hunk header"
 msgstr "Vergleich - =C3=84nderungstitel"
=20
=2D#: gitk:10405
+#: gitk:10778
 msgid "Marked line bg"
 msgstr "Hintergrund f=C3=BCr markierte Zeile"
=20
=2D#: gitk:10407
+#: gitk:10780
 msgid "marked line background"
 msgstr "Hintergrund f=C3=BCr markierte Zeile"
=20
=2D#: gitk:10411
+#: gitk:10784
 msgid "Select bg"
 msgstr "Hintergrundfarbe ausw=C3=A4hlen"
=20
=2D#: gitk:10415
+#: gitk:10788
 msgid "Fonts: press to choose"
 msgstr "Schriftart: Klicken zum W=C3=A4hlen"
=20
=2D#: gitk:10417
+#: gitk:10790
 msgid "Main font"
 msgstr "Programmschriftart"
=20
=2D#: gitk:10418
+#: gitk:10791
 msgid "Diff display font"
 msgstr "Schriftart f=C3=BCr Vergleich"
=20
=2D#: gitk:10419
+#: gitk:10792
 msgid "User interface font"
 msgstr "Beschriftungen"
=20
=2D#: gitk:10446
+#: gitk:10829
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: Farbe w=C3=A4hlen f=C3=BCr %s"
=20
=2D#: gitk:10893
=2Dmsgid ""
=2D"Sorry, gitk cannot run with this version of Tcl/Tk.\n"
=2D" Gitk requires at least Tcl/Tk 8.4."
=2Dmsgstr ""
=2D"Gitk l=C3=A4uft nicht mit dieser Version von Tcl/Tk.\n"
=2D"Gitk ben=C3=B6tigt mindestens Tcl/Tk 8.4."
=2D
=2D#: gitk:11020
+#: gitk:11433
 msgid "Cannot find a git repository here."
 msgstr "Kein Git-Projektarchiv gefunden."
=20
=2D#: gitk:11024
+#: gitk:11437
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
 msgstr "Git-Verzeichnis =C2=BB%s=C2=AB wurde nicht gefunden."
=20
=2D#: gitk:11071
+#: gitk:11484
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Mehrdeutige Angabe =C2=BB%s=C2=AB: Sowohl Version als auch Dateina=
me existiert."
=20
=2D#: gitk:11083
+#: gitk:11496
 msgid "Bad arguments to gitk:"
 msgstr "Falsche Kommandozeilen-Parameter f=C3=BCr gitk:"
=20
=2D#: gitk:11167
+#: gitk:11587
 msgid "Command line"
 msgstr "Kommandozeile"
=2D-=20
1.6.3.3


--Boundary-00=_RRJYLJDSHuE52Wq--
