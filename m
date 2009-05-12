From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk: Update German translation.
Date: Tue, 12 May 2009 22:20:23 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200905122220.24064.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IodCK9HvJNql491"
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue May 12 22:46:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3yrV-0003RC-GY
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 22:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbZELUpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 16:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbZELUpy
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 16:45:54 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:37023 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbZELUpv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 16:45:51 -0400
X-Greylist: delayed 1489 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2009 16:45:50 EDT
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id n4CKKTAG029304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 12 May 2009 22:20:39 +0200
Received: from [192.168.0.101] (e176211025.adsl.alicedsl.de [85.176.211.25])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id n4CKKRwM020743
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 May 2009 22:20:29 +0200
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118953>

--Boundary-00=_IodCK9HvJNql491
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached to avoid whitespace mangling.

--Boundary-00=_IodCK9HvJNql491
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-gitk-Proof-reading-of-German-translation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-gitk-Proof-reading-of-German-translation.patch"

=46rom 66e19dff6019d034fbbf7054d5a09a2a54148f64 Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Tue, 12 May 2009 22:17:40 +0200
Subject: [PATCH 1/2] gitk: Proof-reading of German translation

By Frederik Schwarzer <schwarzerf@gmail.com>
Date: Thu, 25 Dec 2008 17:59:39 +0100

Signed-off-by: Christian Stimming <stimming@tuhh.de>
=2D--
 po/de.po |  115 +++++++++++++++++++++++++++++++---------------------------=
=2D--
 1 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/po/de.po b/po/de.po
index 825dc98..9e8e2ba 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -1,8 +1,9 @@
 # Translation of gitk to German.
 # Copyright (C) 2007 Paul Mackerras.
 # This file is distributed under the same license as the gitk package.
=2D# Christian Stimming <stimming@tuhh.de>, 2007
 #
+# Christian Stimming <stimming@tuhh.de>, 2007.
+# Frederik Schwarzer <schwarzerf@gmail.com>, 2008.
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
@@ -17,7 +18,7 @@ msgstr ""
=20
 #: gitk:113
 msgid "Couldn't get list of unmerged files:"
=2Dmsgstr "Liste der nicht-zusammengef=C3=BChrten Dateien nicht gefunden:"
+msgstr "Liste der nicht zusammengef=C3=BChrten Dateien nicht gefunden:"
=20
 #: gitk:272
 msgid "Error parsing revisions:"
@@ -25,25 +26,25 @@ msgstr "Fehler beim Laden der Versionen:"
=20
 #: gitk:327
 msgid "Error executing --argscmd command:"
=2Dmsgstr "Fehler beim --argscmd Kommando:"
+msgstr "Fehler beim Ausf=C3=BChren des --argscmd-Kommandos:"
=20
 #: gitk:340
 msgid "No files selected: --merge specified but no files are unmerged."
 msgstr ""
=2D"Keine Dateien ausgew=C3=A4hlt: --merge angegeben, es existieren aber ke=
ine nicht-"
=2D"zusammengef=C3=BChrten Dateien."
+"Keine Dateien ausgew=C3=A4hlt: Es wurde --merge angegeben, aber es existi=
eren "
+"keine nicht zusammengef=C3=BChrten Dateien."
=20
 #: gitk:343
 msgid ""
 "No files selected: --merge specified but no unmerged files are within fil=
e "
 "limit."
 msgstr ""
=2D"Keine Dateien ausgew=C3=A4hle: --merge angegeben, aber keine nicht-"
=2D"zusammengef=C3=BChrten Dateien sind in der Dateiauswahl."
+"Keine Dateien ausgew=C3=A4hlt: Es wurde --merge angegeben, aber es sind k=
eine "
+"nicht zusammengef=C3=BChrten Dateien in der Dateiauswahl."
=20
 #: gitk:365 gitk:503
 msgid "Error executing git log:"
=2Dmsgstr "Fehler beim Ausf=C3=BChren von git-log:"
+msgstr "Fehler beim Ausf=C3=BChren von =C2=BBgit log=C2=AB:"
=20
 #: gitk:378
 msgid "Reading"
@@ -51,15 +52,15 @@ msgstr "Lesen"
=20
 #: gitk:438 gitk:3462
 msgid "Reading commits..."
=2Dmsgstr "Versionen lesen..."
+msgstr "Versionen werden gelesen ..."
=20
 #: gitk:441 gitk:1528 gitk:3465
 msgid "No commits selected"
=2Dmsgstr "Keine Versionen ausgew=C3=A4hlt."
+msgstr "Keine Versionen ausgew=C3=A4hlt"
=20
 #: gitk:1399
 msgid "Can't parse git log output:"
=2Dmsgstr "Ausgabe von git-log kann nicht erkannt werden:"
+msgstr "Ausgabe von =C2=BBgit log=C2=AB kann nicht erkannt werden:"
=20
 #: gitk:1605
 msgid "No commit information available"
@@ -112,15 +113,15 @@ msgstr "Bearbeiten"
=20
 #: gitk:1821
 msgid "New view..."
=2Dmsgstr "Neue Ansicht..."
+msgstr "Neue Ansicht ..."
=20
 #: gitk:1822
 msgid "Edit view..."
=2Dmsgstr "Ansicht bearbeiten..."
+msgstr "Ansicht bearbeiten ..."
=20
 #: gitk:1823
 msgid "Delete view"
=2Dmsgstr "Ansicht l=C3=B6schen"
+msgstr "Ansicht entfernen"
=20
 #: gitk:1825
 msgid "All files"
@@ -213,7 +214,7 @@ msgstr "Eintragender"
=20
 #: gitk:2003
 msgid "Search"
=2Dmsgstr "Suche"
+msgstr "Suchen"
=20
 #: gitk:2010
 msgid "Diff"
@@ -245,11 +246,11 @@ msgstr "Baum"
=20
 #: gitk:2213 gitk:2226
 msgid "Diff this -> selected"
=2Dmsgstr "Vergleich diese -> gew=C3=A4hlte"
+msgstr "Vergleich: diese -> gew=C3=A4hlte"
=20
 #: gitk:2214 gitk:2227
 msgid "Diff selected -> this"
=2Dmsgstr "Vergleich gew=C3=A4hlte -> diese"
+msgstr "Vergleich: gew=C3=A4hlte -> diese"
=20
 #: gitk:2215 gitk:2228
 msgid "Make patch"
@@ -293,7 +294,7 @@ msgstr "Nur diesen hervorheben"
=20
 #: gitk:2244
 msgid "External diff"
=2Dmsgstr "Externer Vergleich"
+msgstr "Externes Diff-Programm"
=20
 #: gitk:2255
 msgid "Blame parent commit"
@@ -305,7 +306,7 @@ msgstr "Herkunft dieser Zeile anzeigen"
=20
 #: gitk:2361
 msgid "Run git gui blame on this line"
=2Dmsgstr "Annotieren (=C2=BBgit gui blame=C2=AB) von dieser Zeile"
+msgstr "Diese Zeile annotieren (=C2=BBgit gui blame=C2=AB)"
=20
 #: gitk:2606
 msgid ""
@@ -317,7 +318,7 @@ msgid ""
 "Use and redistribute under the terms of the GNU General Public License"
 msgstr ""
 "\n"
=2D"Gitk - eine Visualisierung der Git Historie\n"
+"Gitk - eine Visualisierung der Git-Historie\n"
 "\n"
 "Copyright =C2=A9 2005-2008 Paul Mackerras\n"
 "\n"
@@ -330,11 +331,11 @@ msgstr "Schlie=C3=9Fen"
=20
 #: gitk:2515
 msgid "Gitk key bindings"
=2Dmsgstr "Gitk Tastaturbelegung"
+msgstr "Gitk-Tastaturbelegung"
=20
 #: gitk:2517
 msgid "Gitk key bindings:"
=2Dmsgstr "Gitk Tastaturbelegung:"
+msgstr "Gitk-Tastaturbelegung:"
=20
 #: gitk:2519
 #, tcl-format
@@ -396,7 +397,7 @@ msgstr "<%s-Runter>\tVersionsliste eine Zeile nach unte=
n bl=C3=A4ttern"
 #: gitk:2532
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
=2Dmsgstr "<%s-BildHoch>\tVersionsliste eine Seite hoch bl=C3=A4ttern"
+msgstr "<%s-BildHoch>\tVersionsliste eine Seite nach oben bl=C3=A4ttern"
=20
 #: gitk:2533
 #, tcl-format
@@ -425,11 +426,11 @@ msgstr "<Leertaste>\tVergleich eine Seite nach unten =
bl=C3=A4ttern"
=20
 #: gitk:2539
 msgid "u\t\tScroll diff view up 18 lines"
=2Dmsgstr "u\t\tVergleich um 18 Zeilen nach oben (=C2=BBup=C2=AB) bl=C3=A4t=
tern"
+msgstr "u\t\tVergleich um 18 Zeilen nach oben bl=C3=A4ttern"
=20
 #: gitk:2540
 msgid "d\t\tScroll diff view down 18 lines"
=2Dmsgstr "d\t\tVergleich um 18 Zeilen nach unten (=C2=BBdown=C2=AB) bl=C3=
=A4ttern"
+msgstr "d\t\tVergleich um 18 Zeilen nach unten bl=C3=A4ttern"
=20
 #: gitk:2541
 #, tcl-format
@@ -455,7 +456,7 @@ msgstr "?\t\tR=C3=BCckw=C3=A4rts weitersuchen"
=20
 #: gitk:2546
 msgid "f\t\tScroll diff view to next file"
=2Dmsgstr "f\t\tVergleich zur n=C3=A4chsten Datei (=C2=BBfile=C2=AB) bl=C3=
=A4ttern"
+msgstr "f\t\tVergleich zur n=C3=A4chsten Datei bl=C3=A4ttern"
=20
 #: gitk:2547
 #, tcl-format
@@ -470,22 +471,22 @@ msgstr "<%s-R>\t\tR=C3=BCckw=C3=A4rts weitersuchen im=
 Vergleich"
 #: gitk:2549
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
=2Dmsgstr "<%s-Nummerblock-Plus>\tSchriftgr=C3=B6=C3=9Fe vergr=C3=B6=C3=9Fe=
rn"
+msgstr "<%s-Nummerblock-Plus>\tSchrift vergr=C3=B6=C3=9Fern"
=20
 #: gitk:2550
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
=2Dmsgstr "<%s-Plus>\tSchriftgr=C3=B6=C3=9Fe vergr=C3=B6=C3=9Fern"
+msgstr "<%s-Plus>\tSchrift vergr=C3=B6=C3=9Fern"
=20
 #: gitk:2551
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
=2Dmsgstr "<%s-Nummernblock-> Schriftgr=C3=B6=C3=9Fe verkleinern"
+msgstr "<%s-Nummernblock-Minus> Schrift verkleinern"
=20
 #: gitk:2552
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
=2Dmsgstr "<%s-Minus>\tSchriftgr=C3=B6=C3=9Fe verkleinern"
+msgstr "<%s-Minus>\tSchrift verkleinern"
=20
 #: gitk:2553
 msgid "<F5>\t\tUpdate"
@@ -499,7 +500,7 @@ msgstr "Fehler beim Holen von =C2=BB%s=C2=AB von =C2=BB=
%s=C2=AB:"
 #: gitk:3036 gitk:3045
 #, tcl-format
 msgid "Error creating temporary directory %s:"
=2Dmsgstr "Fehler beim Erzeugen eines tempor=C3=A4ren Verzeichnisses =C2=BB=
%s=C2=AB:"
+msgstr "Fehler beim Erzeugen des tempor=C3=A4ren Verzeichnisses =C2=BB%s=
=C2=AB:"
=20
 #: gitk:3058
 msgid "command failed:"
@@ -541,16 +542,16 @@ msgstr "Fehler beim Ausf=C3=BChren von =C2=BBgit blam=
e=C2=AB: %s"
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr ""
=2D"Diese Zeile stammt aus Version %s, welche nicht in dieser Ansicht gezei=
gt "
=2D"wird."
+"Diese Zeile stammt aus Version %s, die nicht in dieser Ansicht gezeigt "
+"wird"
=20
 #: gitk:3508
 msgid "External diff viewer failed:"
=2Dmsgstr "Externes Vergleich-(Diff-)Programm fehlgeschlagen:"
+msgstr "Externes Diff-Programm fehlgeschlagen:"
=20
 #: gitk:3210
 msgid "Gitk view definition"
=2Dmsgstr "Gitk Ansichten"
+msgstr "Gitk-Ansichten"
=20
 #: gitk:3630
 msgid "Remember this view"
@@ -558,7 +559,7 @@ msgstr "Diese Ansicht speichern"
=20
 #: gitk:3232
 msgid "Commits to include (arguments to git log):"
=2Dmsgstr "Versionen anzeigen (Argumente von git-log):"
+msgstr "Versionen anzeigen (Argumente von git log):"
=20
 #: gitk:3632
 msgid "Use all refs"
@@ -630,7 +631,7 @@ msgstr "Abk=C3=B6mmling"
=20
 #: gitk:3940
 msgid "Not descendant"
=2Dmsgstr "Nicht Abk=C3=B6mmling"
+msgstr "Kein Abk=C3=B6mmling"
=20
 #: gitk:3947 gitk:3952
 msgid "Ancestor"
@@ -638,7 +639,7 @@ msgstr "Vorg=C3=A4nger"
=20
 #: gitk:3948
 msgid "Not ancestor"
=2Dmsgstr "Nicht Vorg=C3=A4nger"
+msgstr "Kein Vorg=C3=A4nger"
=20
 #: gitk:4187
 msgid "Local changes checked in to index but not committed"
@@ -693,7 +694,7 @@ msgstr "Kurzer SHA1-Hashwert =C2=BB%s=C2=AB ist mehrdeu=
tig"
 #: gitk:7146
 #, tcl-format
 msgid "SHA1 id %s is not known"
=2Dmsgstr "SHA1-Hashwert =C2=BB%s=C2=AB unbekannt"
+msgstr "SHA1-Hashwert =C2=BB%s=C2=AB ist unbekannt"
=20
 #: gitk:7148
 #, tcl-format
@@ -751,7 +752,7 @@ msgstr "Erzeugen"
=20
 #: gitk:7474
 msgid "Error creating patch:"
=2Dmsgstr "Fehler beim Patch erzeugen:"
+msgstr "Fehler beim Erzeugen des Patches:"
=20
 #: gitk:7496 gitk:7595 gitk:7649
 msgid "ID:"
@@ -776,7 +777,7 @@ msgstr "Markierung =C2=BB%s=C2=AB existiert bereits."
=20
 #: gitk:7534
 msgid "Error creating tag:"
=2Dmsgstr "Fehler bei Markierung erstellen:"
+msgstr "Fehler beim Erstellen der Markierung:"
=20
 #: gitk:7604
 msgid "Command:"
@@ -822,7 +823,7 @@ msgid ""
 msgstr ""
 "Pfl=C3=BCcken fehlgeschlagen, da noch lokale =C3=84nderungen in Datei =C2=
=BB%s=C2=AB\n"
 "vorliegen. Bitte diese =C3=84nderungen eintragen, zur=C3=BCcksetzen oder\=
n"
=2D"zwischenspeichern (=C2=BBgit stash=C2=BB) und dann erneut versuchen."
+"zwischenspeichern (=C2=BBgit stash=C2=AB) und dann erneut versuchen."
=20
 #: gitk:8414
 msgid ""
@@ -830,7 +831,7 @@ msgid ""
 "Do you wish to run git citool to resolve it?"
 msgstr ""
 "Pfl=C3=BCcken fehlgeschlagen, da ein Zusammenf=C3=BChrungs-Konflikt aufge=
treten\n"
=2D"ist. Soll das =C2=BBgit citool=C2=AB (Zusammenf=C3=BChrungs-Werkzeug) a=
ufgerufen\n"
+"ist. Soll das Zusammenf=C3=BChrungs-Werkzeug (=C2=BBgit citool=C2=AB) auf=
gerufen\n"
 "werden, um diesen Konflikt aufzul=C3=B6sen?"
=20
 #: gitk:8430
@@ -905,8 +906,8 @@ msgid ""
 "Error reading commit topology information; branch and preceding/following=
 "
 "tag information will be incomplete."
 msgstr ""
=2D"Fehler beim Lesen der Strukturinformationen; Zweige und Vorg=C3=A4nger/=
Nachfolger "
=2D"Informationen werden unvollst=C3=A4ndig sein."
+"Fehler beim Lesen der Strukturinformationen; Zweige und Informationen "
+"zu Vorg=C3=A4nger/Nachfolger werden unvollst=C3=A4ndig sein."
=20
 #: gitk:9216
 msgid "Tag"
@@ -918,7 +919,7 @@ msgstr "Id"
=20
 #: gitk:9262
 msgid "Gitk font chooser"
=2Dmsgstr "Gitk Schriften w=C3=A4hlen"
+msgstr "Gitk-Schriften w=C3=A4hlen"
=20
 #: gitk:9279
 msgid "B"
@@ -930,11 +931,11 @@ msgstr "K"
=20
 #: gitk:9375
 msgid "Gitk preferences"
=2Dmsgstr "Gitk Einstellungen"
+msgstr "Gitk-Einstellungen"
=20
 #: gitk:9376
 msgid "Commit list display options"
=2Dmsgstr "Anzeige Versionsliste"
+msgstr "Anzeige der Versionsliste"
=20
 #: gitk:9379
 msgid "Maximum graph width (lines)"
@@ -951,11 +952,11 @@ msgstr "Lokale =C3=84nderungen anzeigen"
=20
 #: gitk:9393
 msgid "Auto-select SHA1"
=2Dmsgstr "SHA1-Hashwert automatisch markieren"
+msgstr "SHA1-Hashwert automatisch ausw=C3=A4hlen"
=20
 #: gitk:9398
 msgid "Diff display options"
=2Dmsgstr "Anzeige Vergleich"
+msgstr "Anzeige des Vergleichs"
=20
 #: gitk:9400
 msgid "Tab spacing"
@@ -963,7 +964,7 @@ msgstr "Tabulatorbreite"
=20
 #: gitk:9404
 msgid "Display nearby tags"
=2Dmsgstr "Naheliegende =C3=9Cberschriften anzeigen"
+msgstr "Naheliegende Markierungen anzeigen"
=20
 #: gitk:9409
 msgid "Limit diffs to listed paths"
@@ -975,11 +976,11 @@ msgstr "Zeichenkodierung pro Datei ermitteln"
=20
 #: gitk:9421
 msgid "External diff tool"
=2Dmsgstr "Externes Vergleich-(Diff-)Programm"
+msgstr "Externes Diff-Programm"
=20
 #: gitk:9423
 msgid "Choose..."
=2Dmsgstr "W=C3=A4hlen..."
+msgstr "W=C3=A4hlen ..."
=20
 #: gitk:9428
 msgid "Colors: press to choose"
@@ -1027,15 +1028,15 @@ msgstr "Vergleich - =C3=84nderungstitel"
=20
 #: gitk:10176
 msgid "Marked line bg"
=2Dmsgstr "Markierte Zeile Hintergrund"
+msgstr "Hintergrund f=C3=BCr markierte Zeile"
=20
 #: gitk:10178
 msgid "marked line background"
=2Dmsgstr "markierte Zeile Hintergrund"
+msgstr "Hintergrund f=C3=BCr markierte Zeile"
=20
 #: gitk:10182
 msgid "Select bg"
=2Dmsgstr "Hintergrundfarbe Ausw=C3=A4hlen"
+msgstr "Hintergrundfarbe ausw=C3=A4hlen"
=20
 #: gitk:9459
 msgid "Fonts: press to choose"
@@ -1047,7 +1048,7 @@ msgstr "Programmschriftart"
=20
 #: gitk:9462
 msgid "Diff display font"
=2Dmsgstr "Vergleich"
+msgstr "Schriftart f=C3=BCr Vergleich"
=20
 #: gitk:9463
 msgid "User interface font"
=2D-=20
1.6.1.rc3.51.g5832d


--Boundary-00=_IodCK9HvJNql491
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0002-gitk-Updated-German-translation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-gitk-Updated-German-translation.patch"

=46rom 9c9230e9447c2032a65446342107afe59d4d63a2 Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Tue, 12 May 2009 22:18:39 +0200
Subject: [PATCH 2/2] gitk: Updated German translation.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
=2D--
 po/de.po |  573 ++++++++++++++++++++++++++++++++++------------------------=
=2D--
 1 files changed, 319 insertions(+), 254 deletions(-)

diff --git a/po/de.po b/po/de.po
index 9e8e2ba..53ef0d6 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -8,8 +8,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2008-12-06 20:40+0100\n"
=2D"PO-Revision-Date: 2008-12-06 20:45+0100\n"
+"POT-Creation-Date: 2009-05-12 21:55+0200\n"
+"PO-Revision-Date: 2009-05-12 22:18+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -20,21 +20,21 @@ msgstr ""
 msgid "Couldn't get list of unmerged files:"
 msgstr "Liste der nicht zusammengef=C3=BChrten Dateien nicht gefunden:"
=20
=2D#: gitk:272
+#: gitk:268
 msgid "Error parsing revisions:"
 msgstr "Fehler beim Laden der Versionen:"
=20
=2D#: gitk:327
+#: gitk:323
 msgid "Error executing --argscmd command:"
 msgstr "Fehler beim Ausf=C3=BChren des --argscmd-Kommandos:"
=20
=2D#: gitk:340
+#: gitk:336
 msgid "No files selected: --merge specified but no files are unmerged."
 msgstr ""
 "Keine Dateien ausgew=C3=A4hlt: Es wurde --merge angegeben, aber es existi=
eren "
 "keine nicht zusammengef=C3=BChrten Dateien."
=20
=2D#: gitk:343
+#: gitk:339
 msgid ""
 "No files selected: --merge specified but no unmerged files are within fil=
e "
 "limit."
@@ -42,273 +42,290 @@ msgstr ""
 "Keine Dateien ausgew=C3=A4hlt: Es wurde --merge angegeben, aber es sind k=
eine "
 "nicht zusammengef=C3=BChrten Dateien in der Dateiauswahl."
=20
=2D#: gitk:365 gitk:503
+#: gitk:361 gitk:508
 msgid "Error executing git log:"
 msgstr "Fehler beim Ausf=C3=BChren von =C2=BBgit log=C2=AB:"
=20
=2D#: gitk:378
+#: gitk:379 gitk:524
 msgid "Reading"
 msgstr "Lesen"
=20
=2D#: gitk:438 gitk:3462
+#: gitk:439 gitk:4061
 msgid "Reading commits..."
 msgstr "Versionen werden gelesen ..."
=20
=2D#: gitk:441 gitk:1528 gitk:3465
+#: gitk:442 gitk:1560 gitk:4064
 msgid "No commits selected"
 msgstr "Keine Versionen ausgew=C3=A4hlt"
=20
=2D#: gitk:1399
+#: gitk:1436
 msgid "Can't parse git log output:"
 msgstr "Ausgabe von =C2=BBgit log=C2=AB kann nicht erkannt werden:"
=20
=2D#: gitk:1605
+#: gitk:1656
 msgid "No commit information available"
 msgstr "Keine Versionsinformation verf=C3=BCgbar"
=20
=2D#: gitk:1709 gitk:1731 gitk:3259 gitk:7764 gitk:9293 gitk:9466
+#: gitk:1791 gitk:1815 gitk:3854 gitk:8714 gitk:10250 gitk:10422
 msgid "OK"
 msgstr "Ok"
=20
=2D#: gitk:1733 gitk:3260 gitk:7439 gitk:7510 gitk:7613 gitk:7660 gitk:7766
=2D#: gitk:9294 gitk:9467
+#: gitk:1817 gitk:3856 gitk:8311 gitk:8385 gitk:8495 gitk:8544 gitk:8716
+#: gitk:10251 gitk:10423
 msgid "Cancel"
 msgstr "Abbrechen"
=20
=2D#: gitk:1811
+#: gitk:1917
 msgid "Update"
 msgstr "Aktualisieren"
=20
=2D#: gitk:1812
+#: gitk:1918
 msgid "Reload"
 msgstr "Neu laden"
=20
=2D#: gitk:1813
+#: gitk:1919
 msgid "Reread references"
 msgstr "Zweige neu laden"
=20
=2D#: gitk:1814
+#: gitk:1920
 msgid "List references"
 msgstr "Zweige/Markierungen auflisten"
=20
=2D#: gitk:1915
+#: gitk:1922
 msgid "Start git gui"
 msgstr "=C2=BBgit gui=C2=AB starten"
=20
=2D#: gitk:1917
+#: gitk:1924
 msgid "Quit"
 msgstr "Beenden"
=20
=2D#: gitk:1810
+#: gitk:1916
 msgid "File"
 msgstr "Datei"
=20
=2D#: gitk:1818
+#: gitk:1928
 msgid "Preferences"
 msgstr "Einstellungen"
=20
=2D#: gitk:1817
+#: gitk:1927
 msgid "Edit"
 msgstr "Bearbeiten"
=20
=2D#: gitk:1821
+#: gitk:1932
 msgid "New view..."
 msgstr "Neue Ansicht ..."
=20
=2D#: gitk:1822
+#: gitk:1933
 msgid "Edit view..."
 msgstr "Ansicht bearbeiten ..."
=20
=2D#: gitk:1823
+#: gitk:1934
 msgid "Delete view"
 msgstr "Ansicht entfernen"
=20
=2D#: gitk:1825
+#: gitk:1936
 msgid "All files"
 msgstr "Alle Dateien"
=20
=2D#: gitk:1820 gitk:3196
+#: gitk:1931 gitk:3666
 msgid "View"
 msgstr "Ansicht"
=20
=2D#: gitk:1828 gitk:2487
+#: gitk:1941 gitk:1951 gitk:2650
 msgid "About gitk"
 msgstr "=C3=9Cber gitk"
=20
=2D#: gitk:1829
+#: gitk:1942 gitk:1956
 msgid "Key bindings"
 msgstr "Tastenk=C3=BCrzel"
=20
=2D#: gitk:1827
+#: gitk:1940 gitk:1955
 msgid "Help"
 msgstr "Hilfe"
=20
=2D#: gitk:1887
+#: gitk:2016
 msgid "SHA1 ID: "
 msgstr "SHA1:"
=20
=2D#: gitk:1918
+#: gitk:2047
 msgid "Row"
 msgstr "Zeile"
=20
=2D#: gitk:1949
+#: gitk:2078
 msgid "Find"
 msgstr "Suche"
=20
=2D#: gitk:1950
+#: gitk:2079
 msgid "next"
 msgstr "n=C3=A4chste"
=20
=2D#: gitk:1951
+#: gitk:2080
 msgid "prev"
 msgstr "vorige"
=20
=2D#: gitk:1952
+#: gitk:2081
 msgid "commit"
 msgstr "Version nach"
=20
=2D#: gitk:1955 gitk:1957 gitk:3617 gitk:3640 gitk:3664 gitk:5550 gitk:5621
+#: gitk:2084 gitk:2086 gitk:4222 gitk:4245 gitk:4269 gitk:6210 gitk:6282
+#: gitk:6366
 msgid "containing:"
 msgstr "Beschreibung:"
=20
=2D#: gitk:1958 gitk:2954 gitk:2959 gitk:3692
+#: gitk:2087 gitk:3158 gitk:3163 gitk:4297
 msgid "touching paths:"
 msgstr "Dateien:"
=20
=2D#: gitk:1959 gitk:3697
+#: gitk:2088 gitk:4302
 msgid "adding/removing string:"
 msgstr "=C3=84nderungen:"
=20
=2D#: gitk:1968 gitk:1970
+#: gitk:2097 gitk:2099
 msgid "Exact"
 msgstr "Exakt"
=20
=2D#: gitk:1970 gitk:3773 gitk:5518
+#: gitk:2099 gitk:4377 gitk:6178
 msgid "IgnCase"
 msgstr "Kein Gro=C3=9F/Klein"
=20
=2D#: gitk:1970 gitk:3666 gitk:3771 gitk:5514
+#: gitk:2099 gitk:4271 gitk:4375 gitk:6174
 msgid "Regexp"
 msgstr "Regexp"
=20
=2D#: gitk:1972 gitk:1973 gitk:3792 gitk:3822 gitk:3829 gitk:5641 gitk:5708
+#: gitk:2101 gitk:2102 gitk:4396 gitk:4426 gitk:4433 gitk:6302 gitk:6370
 msgid "All fields"
 msgstr "Alle Felder"
=20
=2D#: gitk:1973 gitk:3790 gitk:3822 gitk:5580
+#: gitk:2102 gitk:4394 gitk:4426 gitk:6241
 msgid "Headline"
 msgstr "=C3=9Cberschrift"
=20
=2D#: gitk:1974 gitk:3790 gitk:5580 gitk:5708 gitk:6109
+#: gitk:2103 gitk:4394 gitk:6241 gitk:6370 gitk:6804
 msgid "Comments"
 msgstr "Beschreibung"
=20
=2D#: gitk:1974 gitk:3790 gitk:3794 gitk:3829 gitk:5580 gitk:6045 gitk:7285
=2D#: gitk:7300
+#: gitk:2103 gitk:4394 gitk:4398 gitk:4433 gitk:6241 gitk:6739 gitk:7991
+#: gitk:8006
 msgid "Author"
 msgstr "Autor"
=20
=2D#: gitk:1974 gitk:3790 gitk:5580 gitk:6047
+#: gitk:2103 gitk:4394 gitk:6241 gitk:6741
 msgid "Committer"
 msgstr "Eintragender"
=20
=2D#: gitk:2003
+#: gitk:2132
 msgid "Search"
 msgstr "Suchen"
=20
=2D#: gitk:2010
+#: gitk:2139
 msgid "Diff"
 msgstr "Vergleich"
=20
=2D#: gitk:2012
+#: gitk:2141
 msgid "Old version"
 msgstr "Alte Version"
=20
=2D#: gitk:2014
+#: gitk:2143
 msgid "New version"
 msgstr "Neue Version"
=20
=2D#: gitk:2016
+#: gitk:2145
 msgid "Lines of context"
 msgstr "Kontextzeilen"
=20
=2D#: gitk:2026
+#: gitk:2155
 msgid "Ignore space change"
 msgstr "Leerzeichen=C3=A4nderungen ignorieren"
=20
=2D#: gitk:2084
+#: gitk:2213
 msgid "Patch"
 msgstr "Patch"
=20
=2D#: gitk:2086
+#: gitk:2215
 msgid "Tree"
 msgstr "Baum"
=20
=2D#: gitk:2213 gitk:2226
+#: gitk:2359 gitk:2376
 msgid "Diff this -> selected"
 msgstr "Vergleich: diese -> gew=C3=A4hlte"
=20
=2D#: gitk:2214 gitk:2227
+#: gitk:2360 gitk:2377
 msgid "Diff selected -> this"
 msgstr "Vergleich: gew=C3=A4hlte -> diese"
=20
=2D#: gitk:2215 gitk:2228
+#: gitk:2361 gitk:2378
 msgid "Make patch"
 msgstr "Patch erstellen"
=20
=2D#: gitk:2216 gitk:7494
+#: gitk:2362 gitk:8369
 msgid "Create tag"
 msgstr "Markierung erstellen"
=20
=2D#: gitk:2217 gitk:7593
+#: gitk:2363 gitk:8475
 msgid "Write commit to file"
 msgstr "Version in Datei schreiben"
=20
=2D#: gitk:2218 gitk:7647
+#: gitk:2364 gitk:8532
 msgid "Create new branch"
 msgstr "Neuen Zweig erstellen"
=20
=2D#: gitk:2219
+#: gitk:2365
 msgid "Cherry-pick this commit"
 msgstr "Diese Version pfl=C3=BCcken"
=20
=2D#: gitk:2220
+#: gitk:2366
 msgid "Reset HEAD branch to here"
 msgstr "HEAD-Zweig auf diese Version zur=C3=BCcksetzen"
=20
=2D#: gitk:2234
+#: gitk:2367
+msgid "Mark this commit"
+msgstr "Lesezeichen setzen"
+
+#: gitk:2368
+msgid "Return to mark"
+msgstr "Zum Lesezeichen"
+
+#: gitk:2369
+msgid "Find descendant of this and mark"
+msgstr "Abk=C3=B6mmling von Lesezeichen und dieser Version finden"
+
+#: gitk:2370
+msgid "Compare with marked commit"
+msgstr "Mit Lesezeichen vergleichen"
+
+#: gitk:2384
 msgid "Check out this branch"
 msgstr "Auf diesen Zweig umstellen"
=20
=2D#: gitk:2235
+#: gitk:2385
 msgid "Remove this branch"
 msgstr "Zweig l=C3=B6schen"
=20
=2D#: gitk:2242
+#: gitk:2392
 msgid "Highlight this too"
 msgstr "Diesen auch hervorheben"
=20
=2D#: gitk:2243
+#: gitk:2393
 msgid "Highlight this only"
 msgstr "Nur diesen hervorheben"
=20
=2D#: gitk:2244
+#: gitk:2394
 msgid "External diff"
 msgstr "Externes Diff-Programm"
=20
=2D#: gitk:2255
+#: gitk:2395
 msgid "Blame parent commit"
 msgstr "Annotieren der Elternversion"
=20
=2D#: gitk:2360
+#: gitk:2402
 msgid "Show origin of this line"
 msgstr "Herkunft dieser Zeile anzeigen"
=20
=2D#: gitk:2361
+#: gitk:2403
 msgid "Run git gui blame on this line"
 msgstr "Diese Zeile annotieren (=C2=BBgit gui blame=C2=AB)"
=20
=2D#: gitk:2606
+#: gitk:2652
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -325,497 +342,545 @@ msgstr ""
 "Benutzung und Weiterverbreitung gem=C3=A4=C3=9F den Bedingungen der GNU G=
eneral Public "
 "License"
=20
=2D#: gitk:2496 gitk:2557 gitk:7943
+#: gitk:2660 gitk:2722 gitk:8897
 msgid "Close"
 msgstr "Schlie=C3=9Fen"
=20
=2D#: gitk:2515
+#: gitk:2679
 msgid "Gitk key bindings"
 msgstr "Gitk-Tastaturbelegung"
=20
=2D#: gitk:2517
+#: gitk:2682
 msgid "Gitk key bindings:"
 msgstr "Gitk-Tastaturbelegung:"
=20
=2D#: gitk:2519
+#: gitk:2684
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tBeenden"
=20
=2D#: gitk:2520
+#: gitk:2685
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Pos1>\t\tZur neuesten Version springen"
=20
=2D#: gitk:2521
+#: gitk:2686
 msgid "<End>\t\tMove to last commit"
 msgstr "<Ende>\t\tZur =C3=A4ltesten Version springen"
=20
=2D#: gitk:2522
+#: gitk:2687
 msgid "<Up>, p, i\tMove up one commit"
 msgstr "<Hoch>, p, i\tN=C3=A4chste neuere Version"
=20
=2D#: gitk:2523
+#: gitk:2688
 msgid "<Down>, n, k\tMove down one commit"
 msgstr "<Runter>, n, k\tN=C3=A4chste =C3=A4ltere Version"
=20
=2D#: gitk:2524
+#: gitk:2689
 msgid "<Left>, z, j\tGo back in history list"
 msgstr "<Links>, z, j\tEine Version zur=C3=BCckgehen"
=20
=2D#: gitk:2525
+#: gitk:2690
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Rechts>, x, l\tEine Version weitergehen"
=20
=2D#: gitk:2526
+#: gitk:2691
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<BildHoch>\tEine Seite nach oben bl=C3=A4ttern"
=20
=2D#: gitk:2527
+#: gitk:2692
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<BildRunter>\tEine Seite nach unten bl=C3=A4ttern"
=20
=2D#: gitk:2528
+#: gitk:2693
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Pos1>\tZum oberen Ende der Versionsliste bl=C3=A4ttern"
=20
=2D#: gitk:2529
+#: gitk:2694
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-Ende>\tZum unteren Ende der Versionsliste bl=C3=A4ttern"
=20
=2D#: gitk:2530
+#: gitk:2695
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Hoch>\tVersionsliste eine Zeile nach oben bl=C3=A4ttern"
=20
=2D#: gitk:2531
+#: gitk:2696
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Runter>\tVersionsliste eine Zeile nach unten bl=C3=A4ttern"
=20
=2D#: gitk:2532
+#: gitk:2697
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-BildHoch>\tVersionsliste eine Seite nach oben bl=C3=A4ttern"
=20
=2D#: gitk:2533
+#: gitk:2698
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-BildRunter>\tVersionsliste eine Seite nach unten bl=C3=A4ttern"
=20
=2D#: gitk:2534
+#: gitk:2699
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Umschalt-Hoch>\tR=C3=BCckw=C3=A4rts suchen (nach oben; neuere Ver=
sionen)"
=20
=2D#: gitk:2535
+#: gitk:2700
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Umschalt-Runter> Suchen (nach unten; =C3=A4ltere Versionen)"
=20
=2D#: gitk:2536
+#: gitk:2701
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Entf>, b\t\tVergleich eine Seite nach oben bl=C3=A4ttern"
=20
=2D#: gitk:2537
+#: gitk:2702
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<L=C3=B6schtaste>\tVergleich eine Seite nach oben bl=C3=A4ttern"
=20
=2D#: gitk:2538
+#: gitk:2703
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Leertaste>\tVergleich eine Seite nach unten bl=C3=A4ttern"
=20
=2D#: gitk:2539
+#: gitk:2704
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tVergleich um 18 Zeilen nach oben bl=C3=A4ttern"
=20
=2D#: gitk:2540
+#: gitk:2705
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tVergleich um 18 Zeilen nach unten bl=C3=A4ttern"
=20
=2D#: gitk:2541
+#: gitk:2706
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tSuchen"
=20
=2D#: gitk:2542
+#: gitk:2707
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tWeitersuchen"
=20
=2D#: gitk:2543
+#: gitk:2708
 msgid "<Return>\tMove to next find hit"
 msgstr "<Eingabetaste>\tWeitersuchen"
=20
=2D#: gitk:2544
=2Dmsgid "/\t\tMove to next find hit, or redo find"
=2Dmsgstr "/\t\tWeitersuchen oder neue Suche beginnen"
+#: gitk:2709
+msgid "/\t\tFocus the search box"
+msgstr "/\t\tTastaturfokus ins Suchfeld"
=20
=2D#: gitk:2545
+#: gitk:2710
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tR=C3=BCckw=C3=A4rts weitersuchen"
=20
=2D#: gitk:2546
+#: gitk:2711
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tVergleich zur n=C3=A4chsten Datei bl=C3=A4ttern"
=20
=2D#: gitk:2547
+#: gitk:2712
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tWeitersuchen im Vergleich"
=20
=2D#: gitk:2548
+#: gitk:2713
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tR=C3=BCckw=C3=A4rts weitersuchen im Vergleich"
=20
=2D#: gitk:2549
+#: gitk:2714
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-Nummerblock-Plus>\tSchrift vergr=C3=B6=C3=9Fern"
=20
=2D#: gitk:2550
+#: gitk:2715
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-Plus>\tSchrift vergr=C3=B6=C3=9Fern"
=20
=2D#: gitk:2551
+#: gitk:2716
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-Nummernblock-Minus> Schrift verkleinern"
=20
=2D#: gitk:2552
+#: gitk:2717
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-Minus>\tSchrift verkleinern"
=20
=2D#: gitk:2553
+#: gitk:2718
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tAktualisieren"
=20
=2D#: gitk:2979
+#: gitk:3173
 #, tcl-format
 msgid "Error getting \"%s\" from %s:"
 msgstr "Fehler beim Holen von =C2=BB%s=C2=AB von =C2=BB%s=C2=AB:"
=20
=2D#: gitk:3036 gitk:3045
+#: gitk:3230 gitk:3239
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "Fehler beim Erzeugen des tempor=C3=A4ren Verzeichnisses =C2=BB%s=
=C2=AB:"
=20
=2D#: gitk:3058
+#: gitk:3251
 msgid "command failed:"
 msgstr "Kommando fehlgeschlagen:"
=20
=2D#: gitk:3078
+#: gitk:3397
 msgid "No such commit"
 msgstr "Version nicht gefunden"
=20
=2D#: gitk:3083
+#: gitk:3411
 msgid "git gui blame: command failed:"
 msgstr "git gui blame: Kommando fehlgeschlagen:"
=20
=2D#: gitk:3398
+#: gitk:3442
 #, tcl-format
 msgid "Couldn't read merge head: %s"
 msgstr "Zusammenf=C3=BChrungs-Spitze konnte nicht gelesen werden: %s"
=20
=2D#: gitk:3406
+#: gitk:3450
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "Fehler beim Lesen der Bereitstellung (=C2=BBindex=C2=AB): %s"
=20
=2D#: gitk:3431
+#: gitk:3475
 #, tcl-format
 msgid "Couldn't start git blame: %s"
 msgstr "=C2=BBgit blame=C2=AB konnte nicht gestartet werden: %s"
=20
=2D#: gitk:3434 gitk:6160
+#: gitk:3478 gitk:6209
 msgid "Searching"
 msgstr "Suchen"
=20
=2D#: gitk:3466
+#: gitk:3510
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "Fehler beim Ausf=C3=BChren von =C2=BBgit blame=C2=AB: %s"
=20
=2D#: gitk:3494
+#: gitk:3538
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr ""
=2D"Diese Zeile stammt aus Version %s, die nicht in dieser Ansicht gezeigt "
=2D"wird"
+"Diese Zeile stammt aus Version %s, die nicht in dieser Ansicht gezeigt wi=
rd"
=20
=2D#: gitk:3508
+#: gitk:3552
 msgid "External diff viewer failed:"
 msgstr "Externes Diff-Programm fehlgeschlagen:"
=20
=2D#: gitk:3210
+#: gitk:3670
 msgid "Gitk view definition"
 msgstr "Gitk-Ansichten"
=20
=2D#: gitk:3630
+#: gitk:3674
 msgid "Remember this view"
 msgstr "Diese Ansicht speichern"
=20
=2D#: gitk:3232
+#: gitk:3675
 msgid "Commits to include (arguments to git log):"
 msgstr "Versionen anzeigen (Argumente von git log):"
=20
=2D#: gitk:3632
+#: gitk:3676
 msgid "Use all refs"
 msgstr "Alle Zweige verwenden"
=20
=2D#: gitk:3633
+#: gitk:3677
 msgid "Strictly sort by date"
 msgstr "Streng nach Datum sortieren"
=20
=2D#: gitk:3634
+#: gitk:3678
 msgid "Mark branch sides"
 msgstr "Zweig-Seiten markieren"
=20
=2D#: gitk:3635
+#: gitk:3679
 msgid "Since date:"
 msgstr "Von Datum:"
=20
=2D#: gitk:3636
+#: gitk:3680
 msgid "Until date:"
 msgstr "Bis Datum:"
=20
=2D#: gitk:3637
+#: gitk:3681
 msgid "Max count:"
 msgstr "Max. Anzahl:"
=20
=2D#: gitk:3638
+#: gitk:3682
 msgid "Skip:"
 msgstr "=C3=9Cberspringen:"
=20
=2D#: gitk:3639
+#: gitk:3683
 msgid "Limit to first parent"
 msgstr "Auf erste Elternversion beschr=C3=A4nken"
=20
=2D#: gitk:3640
+#: gitk:3684
 msgid "Command to generate more commits to include:"
 msgstr "Versionsliste durch folgendes Kommando erzeugen lassen:"
=20
=2D#: gitk:3749
+#: gitk:3780
+msgid "Gitk: edit view"
+msgstr "Gitk: Ansicht bearbeiten"
+
+#: gitk:3793
 msgid "Name"
 msgstr "Name"
=20
=2D#: gitk:3797
+#: gitk:3841
 msgid "Enter files and directories to include, one per line:"
 msgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
=20
=2D#: gitk:3811
+#: gitk:3855
 msgid "Apply (F5)"
 msgstr "Anwenden (F5)"
=20
=2D#: gitk:3849
+#: gitk:3893
 msgid "Error in commit selection arguments:"
 msgstr "Fehler in den ausgew=C3=A4hlten Versionen:"
=20
=2D#: gitk:3347 gitk:3399 gitk:3842 gitk:3856 gitk:5060 gitk:10141 gitk:101=
42
+#: gitk:3946 gitk:3998 gitk:4446 gitk:4460 gitk:5721 gitk:11114 gitk:11115
 msgid "None"
 msgstr "Keine"
=20
=2D#: gitk:3790 gitk:5580 gitk:7287 gitk:7302
+#: gitk:4394 gitk:6241 gitk:7993 gitk:8008
 msgid "Date"
 msgstr "Datum"
=20
=2D#: gitk:3790 gitk:5580
+#: gitk:4394 gitk:6241
 msgid "CDate"
 msgstr "Eintragedatum"
=20
=2D#: gitk:3939 gitk:3944
+#: gitk:4543 gitk:4548
 msgid "Descendant"
 msgstr "Abk=C3=B6mmling"
=20
=2D#: gitk:3940
+#: gitk:4544
 msgid "Not descendant"
 msgstr "Kein Abk=C3=B6mmling"
=20
=2D#: gitk:3947 gitk:3952
+#: gitk:4551 gitk:4556
 msgid "Ancestor"
 msgstr "Vorg=C3=A4nger"
=20
=2D#: gitk:3948
+#: gitk:4552
 msgid "Not ancestor"
 msgstr "Kein Vorg=C3=A4nger"
=20
=2D#: gitk:4187
+#: gitk:4842
 msgid "Local changes checked in to index but not committed"
 msgstr "Lokale =C3=84nderungen bereitgestellt, aber nicht eingetragen"
=20
=2D#: gitk:4220
+#: gitk:4878
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokale =C3=84nderungen, nicht bereitgestellt"
=20
=2D#: gitk:6673
+#: gitk:6559
+msgid "many"
+msgstr "viele"
+
+#: gitk:6743
 msgid "Tags:"
 msgstr "Markierungen:"
=20
=2D#: gitk:6066 gitk:6072 gitk:7280
+#: gitk:6760 gitk:6766 gitk:7986
 msgid "Parent"
 msgstr "Eltern"
=20
=2D#: gitk:6077
+#: gitk:6771
 msgid "Child"
 msgstr "Kind"
=20
=2D#: gitk:6086
+#: gitk:6780
 msgid "Branch"
 msgstr "Zweig"
=20
=2D#: gitk:6089
+#: gitk:6783
 msgid "Follows"
 msgstr "Folgt auf"
=20
=2D#: gitk:6092
+#: gitk:6786
 msgid "Precedes"
 msgstr "Vorg=C3=A4nger von"
=20
=2D#: gitk:7209
+#: gitk:7279
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Fehler beim Laden des Vergleichs: %s"
=20
=2D#: gitk:7748
+#: gitk:7819
 msgid "Goto:"
 msgstr "Gehe zu:"
=20
=2D#: gitk:7115
+#: gitk:7821
 msgid "SHA1 ID:"
 msgstr "SHA1-Hashwert:"
=20
=2D#: gitk:7134
+#: gitk:7840
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Kurzer SHA1-Hashwert =C2=BB%s=C2=AB ist mehrdeutig"
=20
=2D#: gitk:7146
+#: gitk:7852
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA1-Hashwert =C2=BB%s=C2=AB ist unbekannt"
=20
=2D#: gitk:7148
+#: gitk:7854
 #, tcl-format
 msgid "Tag/Head %s is not known"
 msgstr "Markierung/Zweig =C2=BB%s=C2=AB ist unbekannt"
=20
=2D#: gitk:7290
+#: gitk:7996
 msgid "Children"
 msgstr "Kinder"
=20
=2D#: gitk:7347
+#: gitk:8053
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Zweig =C2=BB%s=C2=AB hierher zur=C3=BCcksetzen"
=20
=2D#: gitk:7349
+#: gitk:8055
 msgid "Detached head: can't reset"
 msgstr "Zweigspitze ist abgetrennt: Zur=C3=BCcksetzen nicht m=C3=B6glich"
=20
=2D#: gitk:7381
+#: gitk:8164 gitk:8170
+msgid "Skipping merge commit "
+msgstr "=C3=9Cberspringe Zusammenf=C3=BChrungs-Version "
+
+#: gitk:8179 gitk:8184
+msgid "Error getting patch ID for "
+msgstr "Fehler beim Holen der Patch-ID f=C3=BCr "
+
+#: gitk:8180 gitk:8185
+msgid " - stopping\n"
+msgstr " - Abbruch.\n"
+
+#: gitk:8190 gitk:8193 gitk:8201 gitk:8211 gitk:8220
+msgid "Commit "
+msgstr "Version "
+
+#: gitk:8194
+msgid ""
+" is the same patch as\n"
+"       "
+msgstr ""
+" ist das gleiche Patch wie\n"
+"       "
+
+#: gitk:8202
+msgid ""
+" differs from\n"
+"       "
+msgstr ""
+" ist unterschiedlich von\n"
+"       "
+
+#: gitk:8204
+msgid "- stopping\n"
+msgstr "- Abbruch.\n"
+
+#: gitk:8212 gitk:8221
+#, tcl-format
+msgid " has %s children - stopping\n"
+msgstr " hat %s Kinder. Abbruch\n"
+
+#: gitk:8252
 msgid "Top"
 msgstr "Oben"
=20
=2D#: gitk:7382
+#: gitk:8253
 msgid "From"
 msgstr "Von"
=20
=2D#: gitk:7387
+#: gitk:8258
 msgid "To"
 msgstr "bis"
=20
=2D#: gitk:7410
+#: gitk:8282
 msgid "Generate patch"
 msgstr "Patch erstellen"
=20
=2D#: gitk:7412
+#: gitk:8284
 msgid "From:"
 msgstr "Von:"
=20
=2D#: gitk:7421
+#: gitk:8293
 msgid "To:"
 msgstr "bis:"
=20
=2D#: gitk:7430
+#: gitk:8302
 msgid "Reverse"
 msgstr "Umgekehrt"
=20
=2D#: gitk:7432 gitk:7607
+#: gitk:8304 gitk:8489
 msgid "Output file:"
 msgstr "Ausgabedatei:"
=20
=2D#: gitk:7438
+#: gitk:8310
 msgid "Generate"
 msgstr "Erzeugen"
=20
=2D#: gitk:7474
+#: gitk:8348
 msgid "Error creating patch:"
 msgstr "Fehler beim Erzeugen des Patches:"
=20
=2D#: gitk:7496 gitk:7595 gitk:7649
+#: gitk:8371 gitk:8477 gitk:8534
 msgid "ID:"
 msgstr "ID:"
=20
=2D#: gitk:7505
+#: gitk:8380
 msgid "Tag name:"
 msgstr "Markierungsname:"
=20
=2D#: gitk:7509 gitk:7659
+#: gitk:8384 gitk:8543
 msgid "Create"
 msgstr "Erstellen"
=20
=2D#: gitk:7524
+#: gitk:8401
 msgid "No tag name specified"
 msgstr "Kein Markierungsname angegeben"
=20
=2D#: gitk:7528
+#: gitk:8405
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Markierung =C2=BB%s=C2=AB existiert bereits."
=20
=2D#: gitk:7534
+#: gitk:8411
 msgid "Error creating tag:"
 msgstr "Fehler beim Erstellen der Markierung:"
=20
=2D#: gitk:7604
+#: gitk:8486
 msgid "Command:"
 msgstr "Kommando:"
=20
=2D#: gitk:7612
+#: gitk:8494
 msgid "Write"
 msgstr "Schreiben"
=20
=2D#: gitk:7628
+#: gitk:8512
 msgid "Error writing commit:"
 msgstr "Fehler beim Schreiben der Version:"
=20
=2D#: gitk:7654
+#: gitk:8539
 msgid "Name:"
 msgstr "Name:"
=20
=2D#: gitk:7674
+#: gitk:8562
 msgid "Please specify a name for the new branch"
 msgstr "Bitte geben Sie einen Namen f=C3=BCr den neuen Zweig an."
=20
=2D#: gitk:8328
+#: gitk:8567
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "Zweig =C2=BB%s=C2=AB existiert bereits. Soll er =C3=BCberschrieben=
 werden?"
=20
=2D#: gitk:8394
+#: gitk:8633
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
 "Version =C2=BB%s=C2=AB ist bereits im Zweig =C2=BB%s=C2=AB enthalten -- t=
rotzdem erneut "
 "eintragen?"
=20
=2D#: gitk:7718
+#: gitk:8638
 msgid "Cherry-picking"
 msgstr "Version pfl=C3=BCcken"
=20
=2D#: gitk:8408
+#: gitk:8647
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -825,7 +890,7 @@ msgstr ""
 "vorliegen. Bitte diese =C3=84nderungen eintragen, zur=C3=BCcksetzen oder\=
n"
 "zwischenspeichern (=C2=BBgit stash=C2=AB) und dann erneut versuchen."
=20
=2D#: gitk:8414
+#: gitk:8653
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -834,34 +899,34 @@ msgstr ""
 "ist. Soll das Zusammenf=C3=BChrungs-Werkzeug (=C2=BBgit citool=C2=AB) auf=
gerufen\n"
 "werden, um diesen Konflikt aufzul=C3=B6sen?"
=20
=2D#: gitk:8430
+#: gitk:8669
 msgid "No changes committed"
 msgstr "Keine =C3=84nderungen eingetragen"
=20
=2D#: gitk:7745
+#: gitk:8695
 msgid "Confirm reset"
 msgstr "Zur=C3=BCcksetzen best=C3=A4tigen"
=20
=2D#: gitk:7747
+#: gitk:8697
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Zweig =C2=BB%s=C2=AB auf =C2=BB%s=C2=AB zur=C3=BCcksetzen?"
=20
=2D#: gitk:7751
+#: gitk:8701
 msgid "Reset type:"
 msgstr "Art des Zur=C3=BCcksetzens:"
=20
=2D#: gitk:7755
+#: gitk:8705
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Harmlos: Arbeitskopie und Bereitstellung unver=C3=A4ndert"
=20
=2D#: gitk:7758
+#: gitk:8708
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr ""
 "Gemischt: Arbeitskopie unver=C3=A4ndert,\n"
 "Bereitstellung zur=C3=BCckgesetzt"
=20
=2D#: gitk:7761
+#: gitk:8711
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -869,21 +934,21 @@ msgstr ""
 "Hart: Arbeitskopie und Bereitstellung\n"
 "(Alle lokalen =C3=84nderungen werden gel=C3=B6scht)"
=20
=2D#: gitk:7777
+#: gitk:8728
 msgid "Resetting"
 msgstr "Zur=C3=BCcksetzen"
=20
=2D#: gitk:7834
+#: gitk:8785
 msgid "Checking out"
 msgstr "Umstellen"
=20
=2D#: gitk:7885
+#: gitk:8838
 msgid "Cannot delete the currently checked-out branch"
 msgstr ""
 "Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kann nicht "
 "gel=C3=B6scht werden."
=20
=2D#: gitk:7891
+#: gitk:8844
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -892,174 +957,174 @@ msgstr ""
 "Die Versionen auf Zweig =C2=BB%s=C2=AB existieren auf keinem anderen Zwei=
g.\n"
 "Zweig =C2=BB%s=C2=AB trotzdem l=C3=B6schen?"
=20
=2D#: gitk:7922
+#: gitk:8875
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Markierungen und Zweige: %s"
=20
=2D#: gitk:7936
+#: gitk:8890
 msgid "Filter"
 msgstr "Filtern"
=20
=2D#: gitk:8230
+#: gitk:9185
 msgid ""
 "Error reading commit topology information; branch and preceding/following=
 "
 "tag information will be incomplete."
 msgstr ""
=2D"Fehler beim Lesen der Strukturinformationen; Zweige und Informationen "
=2D"zu Vorg=C3=A4nger/Nachfolger werden unvollst=C3=A4ndig sein."
+"Fehler beim Lesen der Strukturinformationen; Zweige und Informationen zu "
+"Vorg=C3=A4nger/Nachfolger werden unvollst=C3=A4ndig sein."
=20
=2D#: gitk:9216
+#: gitk:10171
 msgid "Tag"
 msgstr "Markierung"
=20
=2D#: gitk:9216
+#: gitk:10171
 msgid "Id"
 msgstr "Id"
=20
=2D#: gitk:9262
+#: gitk:10219
 msgid "Gitk font chooser"
 msgstr "Gitk-Schriften w=C3=A4hlen"
=20
=2D#: gitk:9279
+#: gitk:10236
 msgid "B"
 msgstr "F"
=20
=2D#: gitk:9282
+#: gitk:10239
 msgid "I"
 msgstr "K"
=20
=2D#: gitk:9375
+#: gitk:10334
 msgid "Gitk preferences"
 msgstr "Gitk-Einstellungen"
=20
=2D#: gitk:9376
+#: gitk:10336
 msgid "Commit list display options"
 msgstr "Anzeige der Versionsliste"
=20
=2D#: gitk:9379
+#: gitk:10339
 msgid "Maximum graph width (lines)"
 msgstr "Maximale Graphenbreite (Zeilen)"
=20
=2D#: gitk:9383
+#: gitk:10343
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximale Graphenbreite (% des Fensters)"
=20
=2D#: gitk:9388
+#: gitk:10347
 msgid "Show local changes"
 msgstr "Lokale =C3=84nderungen anzeigen"
=20
=2D#: gitk:9393
+#: gitk:10350
 msgid "Auto-select SHA1"
 msgstr "SHA1-Hashwert automatisch ausw=C3=A4hlen"
=20
=2D#: gitk:9398
+#: gitk:10354
 msgid "Diff display options"
 msgstr "Anzeige des Vergleichs"
=20
=2D#: gitk:9400
+#: gitk:10356
 msgid "Tab spacing"
 msgstr "Tabulatorbreite"
=20
=2D#: gitk:9404
+#: gitk:10359
 msgid "Display nearby tags"
 msgstr "Naheliegende Markierungen anzeigen"
=20
=2D#: gitk:9409
+#: gitk:10362
 msgid "Limit diffs to listed paths"
 msgstr "Vergleich nur f=C3=BCr angezeigte Pfade"
=20
=2D#: gitk:9414
+#: gitk:10365
 msgid "Support per-file encodings"
 msgstr "Zeichenkodierung pro Datei ermitteln"
=20
=2D#: gitk:9421
+#: gitk:10371 gitk:10436
 msgid "External diff tool"
 msgstr "Externes Diff-Programm"
=20
=2D#: gitk:9423
+#: gitk:10373
 msgid "Choose..."
 msgstr "W=C3=A4hlen ..."
=20
=2D#: gitk:9428
+#: gitk:10378
 msgid "Colors: press to choose"
 msgstr "Farben: Klicken zum W=C3=A4hlen"
=20
=2D#: gitk:9431
+#: gitk:10381
 msgid "Background"
 msgstr "Hintergrund"
=20
=2D#: gitk:10153 gitk:10183
+#: gitk:10382 gitk:10412
 msgid "background"
 msgstr "Hintergrund"
=20
=2D#: gitk:10156
+#: gitk:10385
 msgid "Foreground"
 msgstr "Vordergrund"
=20
=2D#: gitk:10157
+#: gitk:10386
 msgid "foreground"
 msgstr "Vordergrund"
=20
=2D#: gitk:10160
+#: gitk:10389
 msgid "Diff: old lines"
 msgstr "Vergleich: Alte Zeilen"
=20
=2D#: gitk:10161
+#: gitk:10390
 msgid "diff old lines"
 msgstr "Vergleich - Alte Zeilen"
=20
=2D#: gitk:10165
+#: gitk:10394
 msgid "Diff: new lines"
 msgstr "Vergleich: Neue Zeilen"
=20
=2D#: gitk:10166
+#: gitk:10395
 msgid "diff new lines"
 msgstr "Vergleich - Neue Zeilen"
=20
=2D#: gitk:10170
+#: gitk:10399
 msgid "Diff: hunk header"
 msgstr "Vergleich: =C3=84nderungstitel"
=20
=2D#: gitk:10172
+#: gitk:10401
 msgid "diff hunk header"
 msgstr "Vergleich - =C3=84nderungstitel"
=20
=2D#: gitk:10176
+#: gitk:10405
 msgid "Marked line bg"
 msgstr "Hintergrund f=C3=BCr markierte Zeile"
=20
=2D#: gitk:10178
+#: gitk:10407
 msgid "marked line background"
 msgstr "Hintergrund f=C3=BCr markierte Zeile"
=20
=2D#: gitk:10182
+#: gitk:10411
 msgid "Select bg"
 msgstr "Hintergrundfarbe ausw=C3=A4hlen"
=20
=2D#: gitk:9459
+#: gitk:10415
 msgid "Fonts: press to choose"
 msgstr "Schriftart: Klicken zum W=C3=A4hlen"
=20
=2D#: gitk:9461
+#: gitk:10417
 msgid "Main font"
 msgstr "Programmschriftart"
=20
=2D#: gitk:9462
+#: gitk:10418
 msgid "Diff display font"
 msgstr "Schriftart f=C3=BCr Vergleich"
=20
=2D#: gitk:9463
+#: gitk:10419
 msgid "User interface font"
 msgstr "Beschriftungen"
=20
=2D#: gitk:9488
+#: gitk:10446
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: Farbe w=C3=A4hlen f=C3=BCr %s"
=20
=2D#: gitk:9934
+#: gitk:10893
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -1067,24 +1132,24 @@ msgstr ""
 "Gitk l=C3=A4uft nicht mit dieser Version von Tcl/Tk.\n"
 "Gitk ben=C3=B6tigt mindestens Tcl/Tk 8.4."
=20
=2D#: gitk:10047
+#: gitk:11020
 msgid "Cannot find a git repository here."
 msgstr "Kein Git-Projektarchiv gefunden."
=20
=2D#: gitk:10051
+#: gitk:11024
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
 msgstr "Git-Verzeichnis =C2=BB%s=C2=AB wurde nicht gefunden."
=20
=2D#: gitk:10098
+#: gitk:11071
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Mehrdeutige Angabe =C2=BB%s=C2=AB: Sowohl Version als auch Dateina=
me existiert."
=20
=2D#: gitk:10110
+#: gitk:11083
 msgid "Bad arguments to gitk:"
 msgstr "Falsche Kommandozeilen-Parameter f=C3=BCr gitk:"
=20
=2D#: gitk:10170
+#: gitk:11167
 msgid "Command line"
 msgstr "Kommandozeile"
=2D-=20
1.6.1.rc3.51.g5832d


--Boundary-00=_IodCK9HvJNql491--
