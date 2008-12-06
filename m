From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 2/2] gitk: Update German translation.
Date: Sat, 6 Dec 2008 20:49:24 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200812062049.24884.stimming@tuhh.de>
References: <200812062048.30412.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EdtOJyEZLgJ0Ie1"
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Dec 06 20:55:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L93Fo-0006V2-51
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 20:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbYLFTyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 14:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbYLFTyJ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 14:54:09 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:37058 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbYLFTyH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 14:54:07 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id mB6Js34g032732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 6 Dec 2008 20:54:03 +0100
Received: from [192.168.0.101] (e176221017.adsl.alicedsl.de [85.176.221.17])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id mB6Js2N1029099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Dec 2008 20:54:03 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <200812062048.30412.stimming@tuhh.de>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102473>

--Boundary-00=_EdtOJyEZLgJ0Ie1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached to avoid whitespace problems.

Regards,

Christian

--Boundary-00=_EdtOJyEZLgJ0Ie1
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0002-gitk-Update-German-translation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-gitk-Update-German-translation.patch"

=46rom 282060ac531fee722142f9d39c4ff29570723cbb Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Sat, 6 Dec 2008 20:47:15 +0100
Subject: [PATCH 2/2] gitk: Update German translation.

Merged with most recent "make update-po" result.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
=2D--
 po/de.po |  186 ++++++++++++++++++++++++++++++++++++++++++++++++++++------=
=2D---
 1 files changed, 157 insertions(+), 29 deletions(-)

diff --git a/po/de.po b/po/de.po
index e0a6dee..825dc98 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -7,8 +7,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2008-10-25 13:18+0200\n"
=2D"PO-Revision-Date: 2008-10-25 13:23+0200\n"
+"POT-Creation-Date: 2008-12-06 20:40+0100\n"
+"PO-Revision-Date: 2008-12-06 20:45+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -90,7 +90,11 @@ msgstr "Zweige neu laden"
 msgid "List references"
 msgstr "Zweige/Markierungen auflisten"
=20
=2D#: gitk:1815
+#: gitk:1915
+msgid "Start git gui"
+msgstr "=C2=BBgit gui=C2=AB starten"
+
+#: gitk:1917
 msgid "Quit"
 msgstr "Beenden"
=20
@@ -295,7 +299,15 @@ msgstr "Externer Vergleich"
 msgid "Blame parent commit"
 msgstr "Annotieren der Elternversion"
=20
=2D#: gitk:2488
+#: gitk:2360
+msgid "Show origin of this line"
+msgstr "Herkunft dieser Zeile anzeigen"
+
+#: gitk:2361
+msgid "Run git gui blame on this line"
+msgstr "Annotieren (=C2=BBgit gui blame=C2=AB) von dieser Zeile"
+
+#: gitk:2606
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -501,7 +513,38 @@ msgstr "Version nicht gefunden"
 msgid "git gui blame: command failed:"
 msgstr "git gui blame: Kommando fehlgeschlagen:"
=20
=2D#: gitk:3092
+#: gitk:3398
+#, tcl-format
+msgid "Couldn't read merge head: %s"
+msgstr "Zusammenf=C3=BChrungs-Spitze konnte nicht gelesen werden: %s"
+
+#: gitk:3406
+#, tcl-format
+msgid "Error reading index: %s"
+msgstr "Fehler beim Lesen der Bereitstellung (=C2=BBindex=C2=AB): %s"
+
+#: gitk:3431
+#, tcl-format
+msgid "Couldn't start git blame: %s"
+msgstr "=C2=BBgit blame=C2=AB konnte nicht gestartet werden: %s"
+
+#: gitk:3434 gitk:6160
+msgid "Searching"
+msgstr "Suchen"
+
+#: gitk:3466
+#, tcl-format
+msgid "Error running git blame: %s"
+msgstr "Fehler beim Ausf=C3=BChren von =C2=BBgit blame=C2=AB: %s"
+
+#: gitk:3494
+#, tcl-format
+msgid "That line comes from commit %s,  which is not in this view"
+msgstr ""
+"Diese Zeile stammt aus Version %s, welche nicht in dieser Ansicht gezeigt=
 "
+"wird."
+
+#: gitk:3508
 msgid "External diff viewer failed:"
 msgstr "Externes Vergleich-(Diff-)Programm fehlgeschlagen:"
=20
@@ -509,11 +552,7 @@ msgstr "Externes Vergleich-(Diff-)Programm fehlgeschla=
gen:"
 msgid "Gitk view definition"
 msgstr "Gitk Ansichten"
=20
=2D#: gitk:3225
=2Dmsgid "Name"
=2Dmsgstr "Name"
=2D
=2D#: gitk:3228
+#: gitk:3630
 msgid "Remember this view"
 msgstr "Diese Ansicht speichern"
=20
@@ -521,15 +560,55 @@ msgstr "Diese Ansicht speichern"
 msgid "Commits to include (arguments to git log):"
 msgstr "Versionen anzeigen (Argumente von git-log):"
=20
=2D#: gitk:3239
+#: gitk:3632
+msgid "Use all refs"
+msgstr "Alle Zweige verwenden"
+
+#: gitk:3633
+msgid "Strictly sort by date"
+msgstr "Streng nach Datum sortieren"
+
+#: gitk:3634
+msgid "Mark branch sides"
+msgstr "Zweig-Seiten markieren"
+
+#: gitk:3635
+msgid "Since date:"
+msgstr "Von Datum:"
+
+#: gitk:3636
+msgid "Until date:"
+msgstr "Bis Datum:"
+
+#: gitk:3637
+msgid "Max count:"
+msgstr "Max. Anzahl:"
+
+#: gitk:3638
+msgid "Skip:"
+msgstr "=C3=9Cberspringen:"
+
+#: gitk:3639
+msgid "Limit to first parent"
+msgstr "Auf erste Elternversion beschr=C3=A4nken"
+
+#: gitk:3640
 msgid "Command to generate more commits to include:"
 msgstr "Versionsliste durch folgendes Kommando erzeugen lassen:"
=20
=2D#: gitk:3246
+#: gitk:3749
+msgid "Name"
+msgstr "Name"
+
+#: gitk:3797
 msgid "Enter files and directories to include, one per line:"
 msgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
=20
=2D#: gitk:3293
+#: gitk:3811
+msgid "Apply (F5)"
+msgstr "Anwenden (F5)"
+
+#: gitk:3849
 msgid "Error in commit selection arguments:"
 msgstr "Fehler in den ausgew=C3=A4hlten Versionen:"
=20
@@ -569,11 +648,7 @@ msgstr "Lokale =C3=84nderungen bereitgestellt, aber ni=
cht eingetragen"
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokale =C3=84nderungen, nicht bereitgestellt"
=20
=2D#: gitk:5549
=2Dmsgid "Searching"
=2Dmsgstr "Suchen"
=2D
=2D#: gitk:6049
+#: gitk:6673
 msgid "Tags:"
 msgstr "Markierungen:"
=20
@@ -597,11 +672,12 @@ msgstr "Folgt auf"
 msgid "Precedes"
 msgstr "Vorg=C3=A4nger von"
=20
=2D#: gitk:6378
=2Dmsgid "Error getting merge diffs:"
=2Dmsgstr "Fehler beim Laden des Vergleichs:"
+#: gitk:7209
+#, tcl-format
+msgid "Error getting diffs: %s"
+msgstr "Fehler beim Laden des Vergleichs: %s"
=20
=2D#: gitk:7113
+#: gitk:7748
 msgid "Goto:"
 msgstr "Gehe zu:"
=20
@@ -722,7 +798,12 @@ msgstr "Name:"
 msgid "Please specify a name for the new branch"
 msgstr "Bitte geben Sie einen Namen f=C3=BCr den neuen Zweig an."
=20
=2D#: gitk:7703
+#: gitk:8328
+#, tcl-format
+msgid "Branch '%s' already exists. Overwrite?"
+msgstr "Zweig =C2=BB%s=C2=AB existiert bereits. Soll er =C3=BCberschrieben=
 werden?"
+
+#: gitk:8394
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
@@ -733,7 +814,26 @@ msgstr ""
 msgid "Cherry-picking"
 msgstr "Version pfl=C3=BCcken"
=20
=2D#: gitk:7720
+#: gitk:8408
+#, tcl-format
+msgid ""
+"Cherry-pick failed because of local changes to file '%s'.\n"
+"Please commit, reset or stash your changes and try again."
+msgstr ""
+"Pfl=C3=BCcken fehlgeschlagen, da noch lokale =C3=84nderungen in Datei =C2=
=BB%s=C2=AB\n"
+"vorliegen. Bitte diese =C3=84nderungen eintragen, zur=C3=BCcksetzen oder\=
n"
+"zwischenspeichern (=C2=BBgit stash=C2=BB) und dann erneut versuchen."
+
+#: gitk:8414
+msgid ""
+"Cherry-pick failed because of merge conflict.\n"
+"Do you wish to run git citool to resolve it?"
+msgstr ""
+"Pfl=C3=BCcken fehlgeschlagen, da ein Zusammenf=C3=BChrungs-Konflikt aufge=
treten\n"
+"ist. Soll das =C2=BBgit citool=C2=AB (Zusammenf=C3=BChrungs-Werkzeug) auf=
gerufen\n"
+"werden, um diesen Konflikt aufzul=C3=B6sen?"
+
+#: gitk:8430
 msgid "No changes committed"
 msgstr "Keine =C3=84nderungen eingetragen"
=20
@@ -889,23 +989,51 @@ msgstr "Farben: Klicken zum W=C3=A4hlen"
 msgid "Background"
 msgstr "Hintergrund"
=20
=2D#: gitk:9435
+#: gitk:10153 gitk:10183
+msgid "background"
+msgstr "Hintergrund"
+
+#: gitk:10156
 msgid "Foreground"
 msgstr "Vordergrund"
=20
=2D#: gitk:9439
+#: gitk:10157
+msgid "foreground"
+msgstr "Vordergrund"
+
+#: gitk:10160
 msgid "Diff: old lines"
 msgstr "Vergleich: Alte Zeilen"
=20
=2D#: gitk:9444
+#: gitk:10161
+msgid "diff old lines"
+msgstr "Vergleich - Alte Zeilen"
+
+#: gitk:10165
 msgid "Diff: new lines"
 msgstr "Vergleich: Neue Zeilen"
=20
=2D#: gitk:9449
+#: gitk:10166
+msgid "diff new lines"
+msgstr "Vergleich - Neue Zeilen"
+
+#: gitk:10170
 msgid "Diff: hunk header"
 msgstr "Vergleich: =C3=84nderungstitel"
=20
=2D#: gitk:9455
+#: gitk:10172
+msgid "diff hunk header"
+msgstr "Vergleich - =C3=84nderungstitel"
+
+#: gitk:10176
+msgid "Marked line bg"
+msgstr "Markierte Zeile Hintergrund"
+
+#: gitk:10178
+msgid "marked line background"
+msgstr "markierte Zeile Hintergrund"
+
+#: gitk:10182
 msgid "Select bg"
 msgstr "Hintergrundfarbe Ausw=C3=A4hlen"
=20
=2D-=20
1.6.0.3.517.g759a


--Boundary-00=_EdtOJyEZLgJ0Ie1--
