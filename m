From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk: Update German translation.
Date: Fri, 25 Sep 2009 22:41:21 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200909252241.21976.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Sep 25 23:12:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrI5q-000084-4t
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 23:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbZIYVMc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2009 17:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbZIYVMc
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 17:12:32 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:60349 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbZIYVMa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2009 17:12:30 -0400
X-Greylist: delayed 1842 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2009 17:12:29 EDT
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id n8PKfRkH018073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 25 Sep 2009 22:41:27 +0200
Received: from [192.168.0.101] (e176217061.adsl.alicedsl.de [85.176.217.61])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id n8PKfP1E023885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Sep 2009 22:41:26 +0200
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129114>

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
 po/de.po |  679 +++++++++++++++++++++++++++++++++++-------------------=
--------
 1 files changed, 389 insertions(+), 290 deletions(-)

diff --git a/po/de.po b/po/de.po
index 53ef0d6..af7cef8 100644
--- a/po/de.po
+++ b/po/de.po
@@ -8,8 +8,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2009-05-12 21:55+0200\n"
-"PO-Revision-Date: 2009-05-12 22:18+0200\n"
+"POT-Creation-Date: 2009-09-25 22:22+0200\n"
+"PO-Revision-Date: 2009-09-25 22:39+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -20,21 +20,21 @@ msgstr ""
 msgid "Couldn't get list of unmerged files:"
 msgstr "Liste der nicht zusammengef=FChrten Dateien nicht gefunden:"
=20
-#: gitk:268
+#: gitk:269
 msgid "Error parsing revisions:"
 msgstr "Fehler beim Laden der Versionen:"
=20
-#: gitk:323
+#: gitk:324
 msgid "Error executing --argscmd command:"
 msgstr "Fehler beim Ausf=FChren des --argscmd-Kommandos:"
=20
-#: gitk:336
+#: gitk:337
 msgid "No files selected: --merge specified but no files are unmerged.=
"
 msgstr ""
 "Keine Dateien ausgew=E4hlt: Es wurde --merge angegeben, aber es exist=
ieren "
 "keine nicht zusammengef=FChrten Dateien."
=20
-#: gitk:339
+#: gitk:340
 msgid ""
 "No files selected: --merge specified but no unmerged files are within=
 file "
 "limit."
@@ -42,290 +42,290 @@ msgstr ""
 "Keine Dateien ausgew=E4hlt: Es wurde --merge angegeben, aber es sind =
keine "
 "nicht zusammengef=FChrten Dateien in der Dateiauswahl."
=20
-#: gitk:361 gitk:508
+#: gitk:362 gitk:509
 msgid "Error executing git log:"
 msgstr "Fehler beim Ausf=FChren von =BBgit log=AB:"
=20
-#: gitk:379 gitk:524
+#: gitk:380 gitk:525
 msgid "Reading"
 msgstr "Lesen"
=20
-#: gitk:439 gitk:4061
+#: gitk:440 gitk:4131
 msgid "Reading commits..."
 msgstr "Versionen werden gelesen ..."
=20
-#: gitk:442 gitk:1560 gitk:4064
+#: gitk:443 gitk:1561 gitk:4134
 msgid "No commits selected"
 msgstr "Keine Versionen ausgew=E4hlt"
=20
-#: gitk:1436
+#: gitk:1437
 msgid "Can't parse git log output:"
 msgstr "Ausgabe von =BBgit log=AB kann nicht erkannt werden:"
=20
-#: gitk:1656
+#: gitk:1657
 msgid "No commit information available"
 msgstr "Keine Versionsinformation verf=FCgbar"
=20
-#: gitk:1791 gitk:1815 gitk:3854 gitk:8714 gitk:10250 gitk:10422
+#: gitk:1793 gitk:1817 gitk:3924 gitk:8822 gitk:10358 gitk:10534
 msgid "OK"
 msgstr "Ok"
=20
-#: gitk:1817 gitk:3856 gitk:8311 gitk:8385 gitk:8495 gitk:8544 gitk:87=
16
-#: gitk:10251 gitk:10423
+#: gitk:1819 gitk:3926 gitk:8419 gitk:8493 gitk:8603 gitk:8652 gitk:88=
24
+#: gitk:10359 gitk:10535
 msgid "Cancel"
 msgstr "Abbrechen"
=20
-#: gitk:1917
+#: gitk:1919
 msgid "Update"
 msgstr "Aktualisieren"
=20
-#: gitk:1918
+#: gitk:1920
 msgid "Reload"
 msgstr "Neu laden"
=20
-#: gitk:1919
+#: gitk:1921
 msgid "Reread references"
 msgstr "Zweige neu laden"
=20
-#: gitk:1920
+#: gitk:1922
 msgid "List references"
 msgstr "Zweige/Markierungen auflisten"
=20
-#: gitk:1922
+#: gitk:1924
 msgid "Start git gui"
 msgstr "=BBgit gui=AB starten"
=20
-#: gitk:1924
+#: gitk:1926
 msgid "Quit"
 msgstr "Beenden"
=20
-#: gitk:1916
+#: gitk:1918
 msgid "File"
 msgstr "Datei"
=20
-#: gitk:1928
+#: gitk:1930
 msgid "Preferences"
 msgstr "Einstellungen"
=20
-#: gitk:1927
+#: gitk:1929
 msgid "Edit"
 msgstr "Bearbeiten"
=20
-#: gitk:1932
+#: gitk:1934
 msgid "New view..."
 msgstr "Neue Ansicht ..."
=20
-#: gitk:1933
+#: gitk:1935
 msgid "Edit view..."
 msgstr "Ansicht bearbeiten ..."
=20
-#: gitk:1934
+#: gitk:1936
 msgid "Delete view"
 msgstr "Ansicht entfernen"
=20
-#: gitk:1936
+#: gitk:1938
 msgid "All files"
 msgstr "Alle Dateien"
=20
-#: gitk:1931 gitk:3666
+#: gitk:1933 gitk:3678
 msgid "View"
 msgstr "Ansicht"
=20
-#: gitk:1941 gitk:1951 gitk:2650
+#: gitk:1943 gitk:1953 gitk:2655
 msgid "About gitk"
 msgstr "=DCber gitk"
=20
-#: gitk:1942 gitk:1956
+#: gitk:1944 gitk:1958
 msgid "Key bindings"
 msgstr "Tastenk=FCrzel"
=20
-#: gitk:1940 gitk:1955
+#: gitk:1942 gitk:1957
 msgid "Help"
 msgstr "Hilfe"
=20
-#: gitk:2016
+#: gitk:2018
 msgid "SHA1 ID: "
 msgstr "SHA1:"
=20
-#: gitk:2047
+#: gitk:2049
 msgid "Row"
 msgstr "Zeile"
=20
-#: gitk:2078
+#: gitk:2080
 msgid "Find"
 msgstr "Suche"
=20
-#: gitk:2079
+#: gitk:2081
 msgid "next"
 msgstr "n=E4chste"
=20
-#: gitk:2080
+#: gitk:2082
 msgid "prev"
 msgstr "vorige"
=20
-#: gitk:2081
+#: gitk:2083
 msgid "commit"
 msgstr "Version nach"
=20
-#: gitk:2084 gitk:2086 gitk:4222 gitk:4245 gitk:4269 gitk:6210 gitk:62=
82
-#: gitk:6366
+#: gitk:2086 gitk:2088 gitk:4292 gitk:4315 gitk:4339 gitk:6280 gitk:63=
52
+#: gitk:6436
 msgid "containing:"
 msgstr "Beschreibung:"
=20
-#: gitk:2087 gitk:3158 gitk:3163 gitk:4297
+#: gitk:2089 gitk:3163 gitk:3168 gitk:4367
 msgid "touching paths:"
 msgstr "Dateien:"
=20
-#: gitk:2088 gitk:4302
+#: gitk:2090 gitk:4372
 msgid "adding/removing string:"
 msgstr "=C4nderungen:"
=20
-#: gitk:2097 gitk:2099
+#: gitk:2099 gitk:2101
 msgid "Exact"
 msgstr "Exakt"
=20
-#: gitk:2099 gitk:4377 gitk:6178
+#: gitk:2101 gitk:4447 gitk:6248
 msgid "IgnCase"
 msgstr "Kein Gro=DF/Klein"
=20
-#: gitk:2099 gitk:4271 gitk:4375 gitk:6174
+#: gitk:2101 gitk:4341 gitk:4445 gitk:6244
 msgid "Regexp"
 msgstr "Regexp"
=20
-#: gitk:2101 gitk:2102 gitk:4396 gitk:4426 gitk:4433 gitk:6302 gitk:63=
70
+#: gitk:2103 gitk:2104 gitk:4466 gitk:4496 gitk:4503 gitk:6372 gitk:64=
40
 msgid "All fields"
 msgstr "Alle Felder"
=20
-#: gitk:2102 gitk:4394 gitk:4426 gitk:6241
+#: gitk:2104 gitk:4464 gitk:4496 gitk:6311
 msgid "Headline"
 msgstr "=DCberschrift"
=20
-#: gitk:2103 gitk:4394 gitk:6241 gitk:6370 gitk:6804
+#: gitk:2105 gitk:4464 gitk:6311 gitk:6440 gitk:6874
 msgid "Comments"
 msgstr "Beschreibung"
=20
-#: gitk:2103 gitk:4394 gitk:4398 gitk:4433 gitk:6241 gitk:6739 gitk:79=
91
-#: gitk:8006
+#: gitk:2105 gitk:4464 gitk:4468 gitk:4503 gitk:6311 gitk:6809 gitk:80=
71
+#: gitk:8086
 msgid "Author"
 msgstr "Autor"
=20
-#: gitk:2103 gitk:4394 gitk:6241 gitk:6741
+#: gitk:2105 gitk:4464 gitk:6311 gitk:6811
 msgid "Committer"
 msgstr "Eintragender"
=20
-#: gitk:2132
+#: gitk:2134
 msgid "Search"
 msgstr "Suchen"
=20
-#: gitk:2139
+#: gitk:2141
 msgid "Diff"
 msgstr "Vergleich"
=20
-#: gitk:2141
+#: gitk:2143
 msgid "Old version"
 msgstr "Alte Version"
=20
-#: gitk:2143
+#: gitk:2145
 msgid "New version"
 msgstr "Neue Version"
=20
-#: gitk:2145
+#: gitk:2147
 msgid "Lines of context"
 msgstr "Kontextzeilen"
=20
-#: gitk:2155
+#: gitk:2157
 msgid "Ignore space change"
 msgstr "Leerzeichen=E4nderungen ignorieren"
=20
-#: gitk:2213
+#: gitk:2215
 msgid "Patch"
 msgstr "Patch"
=20
-#: gitk:2215
+#: gitk:2217
 msgid "Tree"
 msgstr "Baum"
=20
-#: gitk:2359 gitk:2376
+#: gitk:2361 gitk:2378
 msgid "Diff this -> selected"
 msgstr "Vergleich: diese -> gew=E4hlte"
=20
-#: gitk:2360 gitk:2377
+#: gitk:2362 gitk:2379
 msgid "Diff selected -> this"
 msgstr "Vergleich: gew=E4hlte -> diese"
=20
-#: gitk:2361 gitk:2378
+#: gitk:2363 gitk:2380
 msgid "Make patch"
 msgstr "Patch erstellen"
=20
-#: gitk:2362 gitk:8369
+#: gitk:2364 gitk:8477
 msgid "Create tag"
 msgstr "Markierung erstellen"
=20
-#: gitk:2363 gitk:8475
+#: gitk:2365 gitk:8583
 msgid "Write commit to file"
 msgstr "Version in Datei schreiben"
=20
-#: gitk:2364 gitk:8532
+#: gitk:2366 gitk:8640
 msgid "Create new branch"
 msgstr "Neuen Zweig erstellen"
=20
-#: gitk:2365
+#: gitk:2367
 msgid "Cherry-pick this commit"
 msgstr "Diese Version pfl=FCcken"
=20
-#: gitk:2366
+#: gitk:2368
 msgid "Reset HEAD branch to here"
 msgstr "HEAD-Zweig auf diese Version zur=FCcksetzen"
=20
-#: gitk:2367
+#: gitk:2369
 msgid "Mark this commit"
 msgstr "Lesezeichen setzen"
=20
-#: gitk:2368
+#: gitk:2370
 msgid "Return to mark"
 msgstr "Zum Lesezeichen"
=20
-#: gitk:2369
+#: gitk:2371
 msgid "Find descendant of this and mark"
 msgstr "Abk=F6mmling von Lesezeichen und dieser Version finden"
=20
-#: gitk:2370
+#: gitk:2372
 msgid "Compare with marked commit"
 msgstr "Mit Lesezeichen vergleichen"
=20
-#: gitk:2384
+#: gitk:2386
 msgid "Check out this branch"
 msgstr "Auf diesen Zweig umstellen"
=20
-#: gitk:2385
+#: gitk:2387
 msgid "Remove this branch"
 msgstr "Zweig l=F6schen"
=20
-#: gitk:2392
+#: gitk:2394
 msgid "Highlight this too"
 msgstr "Diesen auch hervorheben"
=20
-#: gitk:2393
+#: gitk:2395
 msgid "Highlight this only"
 msgstr "Nur diesen hervorheben"
=20
-#: gitk:2394
+#: gitk:2396
 msgid "External diff"
 msgstr "Externes Diff-Programm"
=20
-#: gitk:2395
+#: gitk:2397
 msgid "Blame parent commit"
 msgstr "Annotieren der Elternversion"
=20
-#: gitk:2402
+#: gitk:2404
 msgid "Show origin of this line"
 msgstr "Herkunft dieser Zeile anzeigen"
=20
-#: gitk:2403
+#: gitk:2405
 msgid "Run git gui blame on this line"
 msgstr "Diese Zeile annotieren (=BBgit gui blame=AB)"
=20
-#: gitk:2652
+#: gitk:2657
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -342,419 +342,502 @@ msgstr ""
 "Benutzung und Weiterverbreitung gem=E4=DF den Bedingungen der GNU Gen=
eral Public "
 "License"
=20
-#: gitk:2660 gitk:2722 gitk:8897
+#: gitk:2665 gitk:2727 gitk:9005
 msgid "Close"
 msgstr "Schlie=DFen"
=20
-#: gitk:2679
+#: gitk:2684
 msgid "Gitk key bindings"
 msgstr "Gitk-Tastaturbelegung"
=20
-#: gitk:2682
+#: gitk:2687
 msgid "Gitk key bindings:"
 msgstr "Gitk-Tastaturbelegung:"
=20
-#: gitk:2684
+#: gitk:2689
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tBeenden"
=20
-#: gitk:2685
+#: gitk:2690
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Pos1>\t\tZur neuesten Version springen"
=20
-#: gitk:2686
+#: gitk:2691
 msgid "<End>\t\tMove to last commit"
 msgstr "<Ende>\t\tZur =E4ltesten Version springen"
=20
-#: gitk:2687
+#: gitk:2692
 msgid "<Up>, p, i\tMove up one commit"
 msgstr "<Hoch>, p, i\tN=E4chste neuere Version"
=20
-#: gitk:2688
+#: gitk:2693
 msgid "<Down>, n, k\tMove down one commit"
 msgstr "<Runter>, n, k\tN=E4chste =E4ltere Version"
=20
-#: gitk:2689
+#: gitk:2694
 msgid "<Left>, z, j\tGo back in history list"
 msgstr "<Links>, z, j\tEine Version zur=FCckgehen"
=20
-#: gitk:2690
+#: gitk:2695
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Rechts>, x, l\tEine Version weitergehen"
=20
-#: gitk:2691
+#: gitk:2696
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<BildHoch>\tEine Seite nach oben bl=E4ttern"
=20
-#: gitk:2692
+#: gitk:2697
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<BildRunter>\tEine Seite nach unten bl=E4ttern"
=20
-#: gitk:2693
+#: gitk:2698
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Pos1>\tZum oberen Ende der Versionsliste bl=E4ttern"
=20
-#: gitk:2694
+#: gitk:2699
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-Ende>\tZum unteren Ende der Versionsliste bl=E4ttern"
=20
-#: gitk:2695
+#: gitk:2700
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Hoch>\tVersionsliste eine Zeile nach oben bl=E4ttern"
=20
-#: gitk:2696
+#: gitk:2701
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Runter>\tVersionsliste eine Zeile nach unten bl=E4ttern"
=20
-#: gitk:2697
+#: gitk:2702
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-BildHoch>\tVersionsliste eine Seite nach oben bl=E4ttern"
=20
-#: gitk:2698
+#: gitk:2703
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-BildRunter>\tVersionsliste eine Seite nach unten bl=E4tter=
n"
=20
-#: gitk:2699
+#: gitk:2704
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Umschalt-Hoch>\tR=FCckw=E4rts suchen (nach oben; neuere Versi=
onen)"
=20
-#: gitk:2700
+#: gitk:2705
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Umschalt-Runter> Suchen (nach unten; =E4ltere Versionen)"
=20
-#: gitk:2701
+#: gitk:2706
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Entf>, b\t\tVergleich eine Seite nach oben bl=E4ttern"
=20
-#: gitk:2702
+#: gitk:2707
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<L=F6schtaste>\tVergleich eine Seite nach oben bl=E4ttern"
=20
-#: gitk:2703
+#: gitk:2708
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Leertaste>\tVergleich eine Seite nach unten bl=E4ttern"
=20
-#: gitk:2704
+#: gitk:2709
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tVergleich um 18 Zeilen nach oben bl=E4ttern"
=20
-#: gitk:2705
+#: gitk:2710
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tVergleich um 18 Zeilen nach unten bl=E4ttern"
=20
-#: gitk:2706
+#: gitk:2711
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tSuchen"
=20
-#: gitk:2707
+#: gitk:2712
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tWeitersuchen"
=20
-#: gitk:2708
+#: gitk:2713
 msgid "<Return>\tMove to next find hit"
 msgstr "<Eingabetaste>\tWeitersuchen"
=20
-#: gitk:2709
+#: gitk:2714
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tTastaturfokus ins Suchfeld"
=20
-#: gitk:2710
+#: gitk:2715
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tR=FCckw=E4rts weitersuchen"
=20
-#: gitk:2711
+#: gitk:2716
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tVergleich zur n=E4chsten Datei bl=E4ttern"
=20
-#: gitk:2712
+#: gitk:2717
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tWeitersuchen im Vergleich"
=20
-#: gitk:2713
+#: gitk:2718
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tR=FCckw=E4rts weitersuchen im Vergleich"
=20
-#: gitk:2714
+#: gitk:2719
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-Nummerblock-Plus>\tSchrift vergr=F6=DFern"
=20
-#: gitk:2715
+#: gitk:2720
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-Plus>\tSchrift vergr=F6=DFern"
=20
-#: gitk:2716
+#: gitk:2721
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-Nummernblock-Minus> Schrift verkleinern"
=20
-#: gitk:2717
+#: gitk:2722
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-Minus>\tSchrift verkleinern"
=20
-#: gitk:2718
+#: gitk:2723
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tAktualisieren"
=20
-#: gitk:3173
-#, tcl-format
-msgid "Error getting \"%s\" from %s:"
-msgstr "Fehler beim Holen von =BB%s=AB von =BB%s=AB:"
-
-#: gitk:3230 gitk:3239
+#: gitk:3178 gitk:3187
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "Fehler beim Erzeugen des tempor=E4ren Verzeichnisses =BB%s=AB:=
"
=20
-#: gitk:3251
+#: gitk:3200
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "Fehler beim Holen von =BB%s=AB von =BB%s=AB:"
+
+#: gitk:3263
 msgid "command failed:"
 msgstr "Kommando fehlgeschlagen:"
=20
-#: gitk:3397
+#: gitk:3409
 msgid "No such commit"
 msgstr "Version nicht gefunden"
=20
-#: gitk:3411
+#: gitk:3423
 msgid "git gui blame: command failed:"
 msgstr "git gui blame: Kommando fehlgeschlagen:"
=20
-#: gitk:3442
+#: gitk:3454
 #, tcl-format
 msgid "Couldn't read merge head: %s"
 msgstr "Zusammenf=FChrungs-Spitze konnte nicht gelesen werden: %s"
=20
-#: gitk:3450
+#: gitk:3462
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "Fehler beim Lesen der Bereitstellung (=BBindex=AB): %s"
=20
-#: gitk:3475
+#: gitk:3487
 #, tcl-format
 msgid "Couldn't start git blame: %s"
 msgstr "=BBgit blame=AB konnte nicht gestartet werden: %s"
=20
-#: gitk:3478 gitk:6209
+#: gitk:3490 gitk:6279
 msgid "Searching"
 msgstr "Suchen"
=20
-#: gitk:3510
+#: gitk:3522
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "Fehler beim Ausf=FChren von =BBgit blame=AB: %s"
=20
-#: gitk:3538
+#: gitk:3550
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr ""
 "Diese Zeile stammt aus Version %s, die nicht in dieser Ansicht gezeig=
t wird"
=20
-#: gitk:3552
+#: gitk:3564
 msgid "External diff viewer failed:"
 msgstr "Externes Diff-Programm fehlgeschlagen:"
=20
-#: gitk:3670
+#: gitk:3682
 msgid "Gitk view definition"
 msgstr "Gitk-Ansichten"
=20
-#: gitk:3674
+#: gitk:3686
 msgid "Remember this view"
 msgstr "Diese Ansicht speichern"
=20
-#: gitk:3675
-msgid "Commits to include (arguments to git log):"
-msgstr "Versionen anzeigen (Argumente von git log):"
+#: gitk:3687
+msgid "References (space separated list):"
+msgstr "Zweige/Markierungen (durch Leerzeichen getrennte Liste):"
=20
-#: gitk:3676
-msgid "Use all refs"
-msgstr "Alle Zweige verwenden"
+#: gitk:3688
+msgid "Branches & tags:"
+msgstr "Zweige/Markierungen:"
=20
-#: gitk:3677
-msgid "Strictly sort by date"
-msgstr "Streng nach Datum sortieren"
+#: gitk:3689
+msgid "All refs"
+msgstr "Alle Markierungen und Zweige"
=20
-#: gitk:3678
-msgid "Mark branch sides"
-msgstr "Zweig-Seiten markieren"
+#: gitk:3690
+msgid "All (local) branches"
+msgstr "Alle (lokalen) Zweige"
=20
-#: gitk:3679
-msgid "Since date:"
-msgstr "Von Datum:"
+#: gitk:3691
+msgid "All tags"
+msgstr "Alle Markierungen"
=20
-#: gitk:3680
-msgid "Until date:"
-msgstr "Bis Datum:"
+#: gitk:3692
+msgid "All remote-tracking branches"
+msgstr "Alle =DCbernahmezweige"
=20
-#: gitk:3681
-msgid "Max count:"
-msgstr "Max. Anzahl:"
+#: gitk:3693
+msgid "Commit Info (regular expressions):"
+msgstr "Versionsinformationen (regul=E4re Ausdr=FCcke):"
=20
-#: gitk:3682
-msgid "Skip:"
+#: gitk:3694
+msgid "Author:"
+msgstr "Autor:"
+
+#: gitk:3695
+msgid "Committer:"
+msgstr "Eintragender:"
+
+#: gitk:3696
+msgid "Commit Message:"
+msgstr "Versionsbeschreibung:"
+
+#: gitk:3697
+msgid "Matches all Commit Info criteria"
+msgstr "Alle Versionsinformationen-Kriterien erf=FCllen"
+
+#: gitk:3698
+msgid "Changes to Files:"
+msgstr "Dateien:"
+
+#: gitk:3699
+msgid "Fixed String"
+msgstr "Zeichenkette"
+
+#: gitk:3700
+msgid "Regular Expression"
+msgstr "Regul=E4rer Ausdruck"
+
+#: gitk:3701
+msgid "Search string:"
+msgstr "Suchausdruck:"
+
+#: gitk:3702
+msgid ""
+"Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
+"15:27:38\"):"
+msgstr "Datum (=BB2 weeks ago=AB, =BB2009-03-17 15:27:38=AB, =BBMarch =
17, 2009 15:27:38=AB)"
+
+#: gitk:3703
+msgid "Since:"
+msgstr "Von:"
+
+#: gitk:3704
+msgid "Until:"
+msgstr "Bis:"
+
+#: gitk:3705
+msgid "Limit and/or skip a number of revisions (positive integer):"
+msgstr "Versionsanzahl begrenzen oder einige =FCberspringen (ganzzahli=
ger Wert):"
+
+#: gitk:3706
+msgid "Number to show:"
+msgstr "Anzeigen:"
+
+#: gitk:3707
+msgid "Number to skip:"
 msgstr "=DCberspringen:"
=20
-#: gitk:3683
+#: gitk:3708
+msgid "Miscellaneous options:"
+msgstr "Sonstiges:"
+
+#: gitk:3709
+msgid "Strictly sort by date"
+msgstr "Streng nach Datum sortieren"
+
+#: gitk:3710
+msgid "Mark branch sides"
+msgstr "Zweig-Seiten markieren"
+
+#: gitk:3711
 msgid "Limit to first parent"
 msgstr "Auf erste Elternversion beschr=E4nken"
=20
-#: gitk:3684
+#: gitk:3712
+msgid "Simple history"
+msgstr "Einfache Historie"
+
+#: gitk:3713
+msgid "Additional arguments to git log:"
+msgstr "Zus=E4tzliche Argumente f=FCr =BBgit log=AB:"
+
+#: gitk:3714
+msgid "Enter files and directories to include, one per line:"
+msgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
+
+#: gitk:3715
 msgid "Command to generate more commits to include:"
 msgstr "Versionsliste durch folgendes Kommando erzeugen lassen:"
=20
-#: gitk:3780
+#: gitk:3837
 msgid "Gitk: edit view"
 msgstr "Gitk: Ansicht bearbeiten"
=20
-#: gitk:3793
-msgid "Name"
-msgstr "Name"
+#: gitk:3845
+msgid "-- criteria for selecting revisions"
+msgstr "-- Auswahl der angezeigten Versionen"
=20
-#: gitk:3841
-msgid "Enter files and directories to include, one per line:"
-msgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
+#: gitk:3850
+msgid "View Name:"
+msgstr "Ansichtsname:"
=20
-#: gitk:3855
+#: gitk:3925
 msgid "Apply (F5)"
 msgstr "Anwenden (F5)"
=20
-#: gitk:3893
+#: gitk:3963
 msgid "Error in commit selection arguments:"
 msgstr "Fehler in den ausgew=E4hlten Versionen:"
=20
-#: gitk:3946 gitk:3998 gitk:4446 gitk:4460 gitk:5721 gitk:11114 gitk:1=
1115
+#: gitk:4016 gitk:4068 gitk:4516 gitk:4530 gitk:5791 gitk:11232 gitk:1=
1233
 msgid "None"
 msgstr "Keine"
=20
-#: gitk:4394 gitk:6241 gitk:7993 gitk:8008
+#: gitk:4464 gitk:6311 gitk:8073 gitk:8088
 msgid "Date"
 msgstr "Datum"
=20
-#: gitk:4394 gitk:6241
+#: gitk:4464 gitk:6311
 msgid "CDate"
 msgstr "Eintragedatum"
=20
-#: gitk:4543 gitk:4548
+#: gitk:4613 gitk:4618
 msgid "Descendant"
 msgstr "Abk=F6mmling"
=20
-#: gitk:4544
+#: gitk:4614
 msgid "Not descendant"
 msgstr "Kein Abk=F6mmling"
=20
-#: gitk:4551 gitk:4556
+#: gitk:4621 gitk:4626
 msgid "Ancestor"
 msgstr "Vorg=E4nger"
=20
-#: gitk:4552
+#: gitk:4622
 msgid "Not ancestor"
 msgstr "Kein Vorg=E4nger"
=20
-#: gitk:4842
+#: gitk:4912
 msgid "Local changes checked in to index but not committed"
 msgstr "Lokale =C4nderungen bereitgestellt, aber nicht eingetragen"
=20
-#: gitk:4878
+#: gitk:4948
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokale =C4nderungen, nicht bereitgestellt"
=20
-#: gitk:6559
+#: gitk:6629
 msgid "many"
 msgstr "viele"
=20
-#: gitk:6743
+#: gitk:6813
 msgid "Tags:"
 msgstr "Markierungen:"
=20
-#: gitk:6760 gitk:6766 gitk:7986
+#: gitk:6830 gitk:6836 gitk:8066
 msgid "Parent"
 msgstr "Eltern"
=20
-#: gitk:6771
+#: gitk:6841
 msgid "Child"
 msgstr "Kind"
=20
-#: gitk:6780
+#: gitk:6850
 msgid "Branch"
 msgstr "Zweig"
=20
-#: gitk:6783
+#: gitk:6853
 msgid "Follows"
 msgstr "Folgt auf"
=20
-#: gitk:6786
+#: gitk:6856
 msgid "Precedes"
 msgstr "Vorg=E4nger von"
=20
-#: gitk:7279
+#: gitk:7354
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Fehler beim Laden des Vergleichs: %s"
=20
-#: gitk:7819
+#: gitk:7894
 msgid "Goto:"
 msgstr "Gehe zu:"
=20
-#: gitk:7821
+#: gitk:7896
 msgid "SHA1 ID:"
 msgstr "SHA1-Hashwert:"
=20
-#: gitk:7840
+#: gitk:7915
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Kurzer SHA1-Hashwert =BB%s=AB ist mehrdeutig"
=20
-#: gitk:7852
+#: gitk:7922
+#, tcl-format
+msgid "Revision %s is not known"
+msgstr "Version =BB%s=AB ist unbekannt"
+
+#: gitk:7932
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA1-Hashwert =BB%s=AB ist unbekannt"
=20
-#: gitk:7854
+#: gitk:7934
 #, tcl-format
-msgid "Tag/Head %s is not known"
-msgstr "Markierung/Zweig =BB%s=AB ist unbekannt"
+msgid "Revision %s is not in the current view"
+msgstr "Version =BB%s=AB wird in der aktuellen Ansicht nicht angezeigt=
"
=20
-#: gitk:7996
+#: gitk:8076
 msgid "Children"
 msgstr "Kinder"
=20
-#: gitk:8053
+#: gitk:8133
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Zweig =BB%s=AB hierher zur=FCcksetzen"
=20
-#: gitk:8055
+#: gitk:8135
 msgid "Detached head: can't reset"
 msgstr "Zweigspitze ist abgetrennt: Zur=FCcksetzen nicht m=F6glich"
=20
-#: gitk:8164 gitk:8170
+#: gitk:8244 gitk:8250
 msgid "Skipping merge commit "
 msgstr "=DCberspringe Zusammenf=FChrungs-Version "
=20
-#: gitk:8179 gitk:8184
+#: gitk:8259 gitk:8264
 msgid "Error getting patch ID for "
 msgstr "Fehler beim Holen der Patch-ID f=FCr "
=20
-#: gitk:8180 gitk:8185
+#: gitk:8260 gitk:8265
 msgid " - stopping\n"
 msgstr " - Abbruch.\n"
=20
-#: gitk:8190 gitk:8193 gitk:8201 gitk:8211 gitk:8220
+#: gitk:8270 gitk:8273 gitk:8281 gitk:8294 gitk:8303
 msgid "Commit "
 msgstr "Version "
=20
-#: gitk:8194
+#: gitk:8274
 msgid ""
 " is the same patch as\n"
 "       "
@@ -762,7 +845,7 @@ msgstr ""
 " ist das gleiche Patch wie\n"
 "       "
=20
-#: gitk:8202
+#: gitk:8282
 msgid ""
 " differs from\n"
 "       "
@@ -770,117 +853,129 @@ msgstr ""
 " ist unterschiedlich von\n"
 "       "
=20
-#: gitk:8204
-msgid "- stopping\n"
-msgstr "- Abbruch.\n"
+#: gitk:8284
+msgid ""
+"Diff of commits:\n"
+"\n"
+msgstr "Vergleich der Versionen:\n\n"
=20
-#: gitk:8212 gitk:8221
+#: gitk:8295 gitk:8304
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " hat %s Kinder. Abbruch\n"
=20
-#: gitk:8252
+#: gitk:8324
+#, tcl-format
+msgid "Error writing commit to file: %s"
+msgstr "Fehler beim Schreiben der Version in Datei: %s"
+
+#: gitk:8330
+#, tcl-format
+msgid "Error diffing commits: %s"
+msgstr "Fehler beim Vergleichen der Versionen: %s"
+
+#: gitk:8360
 msgid "Top"
 msgstr "Oben"
=20
-#: gitk:8253
+#: gitk:8361
 msgid "From"
 msgstr "Von"
=20
-#: gitk:8258
+#: gitk:8366
 msgid "To"
 msgstr "bis"
=20
-#: gitk:8282
+#: gitk:8390
 msgid "Generate patch"
 msgstr "Patch erstellen"
=20
-#: gitk:8284
+#: gitk:8392
 msgid "From:"
 msgstr "Von:"
=20
-#: gitk:8293
+#: gitk:8401
 msgid "To:"
 msgstr "bis:"
=20
-#: gitk:8302
+#: gitk:8410
 msgid "Reverse"
 msgstr "Umgekehrt"
=20
-#: gitk:8304 gitk:8489
+#: gitk:8412 gitk:8597
 msgid "Output file:"
 msgstr "Ausgabedatei:"
=20
-#: gitk:8310
+#: gitk:8418
 msgid "Generate"
 msgstr "Erzeugen"
=20
-#: gitk:8348
+#: gitk:8456
 msgid "Error creating patch:"
 msgstr "Fehler beim Erzeugen des Patches:"
=20
-#: gitk:8371 gitk:8477 gitk:8534
+#: gitk:8479 gitk:8585 gitk:8642
 msgid "ID:"
 msgstr "ID:"
=20
-#: gitk:8380
+#: gitk:8488
 msgid "Tag name:"
 msgstr "Markierungsname:"
=20
-#: gitk:8384 gitk:8543
+#: gitk:8492 gitk:8651
 msgid "Create"
 msgstr "Erstellen"
=20
-#: gitk:8401
+#: gitk:8509
 msgid "No tag name specified"
 msgstr "Kein Markierungsname angegeben"
=20
-#: gitk:8405
+#: gitk:8513
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Markierung =BB%s=AB existiert bereits."
=20
-#: gitk:8411
+#: gitk:8519
 msgid "Error creating tag:"
 msgstr "Fehler beim Erstellen der Markierung:"
=20
-#: gitk:8486
+#: gitk:8594
 msgid "Command:"
 msgstr "Kommando:"
=20
-#: gitk:8494
+#: gitk:8602
 msgid "Write"
 msgstr "Schreiben"
=20
-#: gitk:8512
+#: gitk:8620
 msgid "Error writing commit:"
 msgstr "Fehler beim Schreiben der Version:"
=20
-#: gitk:8539
+#: gitk:8647
 msgid "Name:"
 msgstr "Name:"
=20
-#: gitk:8562
+#: gitk:8670
 msgid "Please specify a name for the new branch"
 msgstr "Bitte geben Sie einen Namen f=FCr den neuen Zweig an."
=20
-#: gitk:8567
+#: gitk:8675
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "Zweig =BB%s=AB existiert bereits. Soll er =FCberschrieben werd=
en?"
=20
-#: gitk:8633
+#: gitk:8741
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
 msgstr ""
 "Version =BB%s=AB ist bereits im Zweig =BB%s=AB enthalten -- trotzdem =
erneut "
 "eintragen?"
=20
-#: gitk:8638
+#: gitk:8746
 msgid "Cherry-picking"
 msgstr "Version pfl=FCcken"
=20
-#: gitk:8647
+#: gitk:8755
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -890,7 +985,7 @@ msgstr ""
 "vorliegen. Bitte diese =C4nderungen eintragen, zur=FCcksetzen oder\n"
 "zwischenspeichern (=BBgit stash=AB) und dann erneut versuchen."
=20
-#: gitk:8653
+#: gitk:8761
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -899,34 +994,34 @@ msgstr ""
 "ist. Soll das Zusammenf=FChrungs-Werkzeug (=BBgit citool=AB) aufgeruf=
en\n"
 "werden, um diesen Konflikt aufzul=F6sen?"
=20
-#: gitk:8669
+#: gitk:8777
 msgid "No changes committed"
 msgstr "Keine =C4nderungen eingetragen"
=20
-#: gitk:8695
+#: gitk:8803
 msgid "Confirm reset"
 msgstr "Zur=FCcksetzen best=E4tigen"
=20
-#: gitk:8697
+#: gitk:8805
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Zweig =BB%s=AB auf =BB%s=AB zur=FCcksetzen?"
=20
-#: gitk:8701
+#: gitk:8809
 msgid "Reset type:"
 msgstr "Art des Zur=FCcksetzens:"
=20
-#: gitk:8705
+#: gitk:8813
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Harmlos: Arbeitskopie und Bereitstellung unver=E4ndert"
=20
-#: gitk:8708
+#: gitk:8816
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr ""
 "Gemischt: Arbeitskopie unver=E4ndert,\n"
 "Bereitstellung zur=FCckgesetzt"
=20
-#: gitk:8711
+#: gitk:8819
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -934,21 +1029,21 @@ msgstr ""
 "Hart: Arbeitskopie und Bereitstellung\n"
 "(Alle lokalen =C4nderungen werden gel=F6scht)"
=20
-#: gitk:8728
+#: gitk:8836
 msgid "Resetting"
 msgstr "Zur=FCcksetzen"
=20
-#: gitk:8785
+#: gitk:8893
 msgid "Checking out"
 msgstr "Umstellen"
=20
-#: gitk:8838
+#: gitk:8946
 msgid "Cannot delete the currently checked-out branch"
 msgstr ""
 "Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kann nic=
ht "
 "gel=F6scht werden."
=20
-#: gitk:8844
+#: gitk:8952
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -957,16 +1052,16 @@ msgstr ""
 "Die Versionen auf Zweig =BB%s=AB existieren auf keinem anderen Zweig.=
\n"
 "Zweig =BB%s=AB trotzdem l=F6schen?"
=20
-#: gitk:8875
+#: gitk:8983
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Markierungen und Zweige: %s"
=20
-#: gitk:8890
+#: gitk:8998
 msgid "Filter"
 msgstr "Filtern"
=20
-#: gitk:9185
+#: gitk:9293
 msgid ""
 "Error reading commit topology information; branch and preceding/follo=
wing "
 "tag information will be incomplete."
@@ -974,157 +1069,161 @@ msgstr ""
 "Fehler beim Lesen der Strukturinformationen; Zweige und Informationen=
 zu "
 "Vorg=E4nger/Nachfolger werden unvollst=E4ndig sein."
=20
-#: gitk:10171
+#: gitk:10279
 msgid "Tag"
 msgstr "Markierung"
=20
-#: gitk:10171
+#: gitk:10279
 msgid "Id"
 msgstr "Id"
=20
-#: gitk:10219
+#: gitk:10327
 msgid "Gitk font chooser"
 msgstr "Gitk-Schriften w=E4hlen"
=20
-#: gitk:10236
+#: gitk:10344
 msgid "B"
 msgstr "F"
=20
-#: gitk:10239
+#: gitk:10347
 msgid "I"
 msgstr "K"
=20
-#: gitk:10334
+#: gitk:10443
 msgid "Gitk preferences"
 msgstr "Gitk-Einstellungen"
=20
-#: gitk:10336
+#: gitk:10445
 msgid "Commit list display options"
 msgstr "Anzeige der Versionsliste"
=20
-#: gitk:10339
+#: gitk:10448
 msgid "Maximum graph width (lines)"
 msgstr "Maximale Graphenbreite (Zeilen)"
=20
-#: gitk:10343
+#: gitk:10452
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximale Graphenbreite (% des Fensters)"
=20
-#: gitk:10347
+#: gitk:10456
 msgid "Show local changes"
 msgstr "Lokale =C4nderungen anzeigen"
=20
-#: gitk:10350
+#: gitk:10459
 msgid "Auto-select SHA1"
 msgstr "SHA1-Hashwert automatisch ausw=E4hlen"
=20
-#: gitk:10354
+#: gitk:10463
 msgid "Diff display options"
 msgstr "Anzeige des Vergleichs"
=20
-#: gitk:10356
+#: gitk:10465
 msgid "Tab spacing"
 msgstr "Tabulatorbreite"
=20
-#: gitk:10359
+#: gitk:10468
 msgid "Display nearby tags"
 msgstr "Naheliegende Markierungen anzeigen"
=20
-#: gitk:10362
+#: gitk:10471
+msgid "Hide remote refs"
+msgstr "Entfernte Zweige/Markierungen ausblenden"
+
+#: gitk:10474
 msgid "Limit diffs to listed paths"
 msgstr "Vergleich nur f=FCr angezeigte Pfade"
=20
-#: gitk:10365
+#: gitk:10477
 msgid "Support per-file encodings"
 msgstr "Zeichenkodierung pro Datei ermitteln"
=20
-#: gitk:10371 gitk:10436
+#: gitk:10483 gitk:10548
 msgid "External diff tool"
 msgstr "Externes Diff-Programm"
=20
-#: gitk:10373
+#: gitk:10485
 msgid "Choose..."
 msgstr "W=E4hlen ..."
=20
-#: gitk:10378
+#: gitk:10490
 msgid "Colors: press to choose"
 msgstr "Farben: Klicken zum W=E4hlen"
=20
-#: gitk:10381
+#: gitk:10493
 msgid "Background"
 msgstr "Hintergrund"
=20
-#: gitk:10382 gitk:10412
+#: gitk:10494 gitk:10524
 msgid "background"
 msgstr "Hintergrund"
=20
-#: gitk:10385
+#: gitk:10497
 msgid "Foreground"
 msgstr "Vordergrund"
=20
-#: gitk:10386
+#: gitk:10498
 msgid "foreground"
 msgstr "Vordergrund"
=20
-#: gitk:10389
+#: gitk:10501
 msgid "Diff: old lines"
 msgstr "Vergleich: Alte Zeilen"
=20
-#: gitk:10390
+#: gitk:10502
 msgid "diff old lines"
 msgstr "Vergleich - Alte Zeilen"
=20
-#: gitk:10394
+#: gitk:10506
 msgid "Diff: new lines"
 msgstr "Vergleich: Neue Zeilen"
=20
-#: gitk:10395
+#: gitk:10507
 msgid "diff new lines"
 msgstr "Vergleich - Neue Zeilen"
=20
-#: gitk:10399
+#: gitk:10511
 msgid "Diff: hunk header"
 msgstr "Vergleich: =C4nderungstitel"
=20
-#: gitk:10401
+#: gitk:10513
 msgid "diff hunk header"
 msgstr "Vergleich - =C4nderungstitel"
=20
-#: gitk:10405
+#: gitk:10517
 msgid "Marked line bg"
 msgstr "Hintergrund f=FCr markierte Zeile"
=20
-#: gitk:10407
+#: gitk:10519
 msgid "marked line background"
 msgstr "Hintergrund f=FCr markierte Zeile"
=20
-#: gitk:10411
+#: gitk:10523
 msgid "Select bg"
 msgstr "Hintergrundfarbe ausw=E4hlen"
=20
-#: gitk:10415
+#: gitk:10527
 msgid "Fonts: press to choose"
 msgstr "Schriftart: Klicken zum W=E4hlen"
=20
-#: gitk:10417
+#: gitk:10529
 msgid "Main font"
 msgstr "Programmschriftart"
=20
-#: gitk:10418
+#: gitk:10530
 msgid "Diff display font"
 msgstr "Schriftart f=FCr Vergleich"
=20
-#: gitk:10419
+#: gitk:10531
 msgid "User interface font"
 msgstr "Beschriftungen"
=20
-#: gitk:10446
+#: gitk:10558
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: Farbe w=E4hlen f=FCr %s"
=20
-#: gitk:10893
+#: gitk:11009
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -1132,24 +1231,24 @@ msgstr ""
 "Gitk l=E4uft nicht mit dieser Version von Tcl/Tk.\n"
 "Gitk ben=F6tigt mindestens Tcl/Tk 8.4."
=20
-#: gitk:11020
+#: gitk:11137
 msgid "Cannot find a git repository here."
 msgstr "Kein Git-Projektarchiv gefunden."
=20
-#: gitk:11024
+#: gitk:11141
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
 msgstr "Git-Verzeichnis =BB%s=AB wurde nicht gefunden."
=20
-#: gitk:11071
+#: gitk:11188
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Mehrdeutige Angabe =BB%s=AB: Sowohl Version als auch Dateiname=
 existiert."
=20
-#: gitk:11083
+#: gitk:11200
 msgid "Bad arguments to gitk:"
 msgstr "Falsche Kommandozeilen-Parameter f=FCr gitk:"
=20
-#: gitk:11167
+#: gitk:11285
 msgid "Command line"
 msgstr "Kommandozeile"
--=20
1.6.1.rc3.51.g5832d
