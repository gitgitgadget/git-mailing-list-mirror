From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk: Update German translation.
Date: Wed, 9 Jan 2008 22:24:21 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200801092224.21680.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FuThHVvrVgOzSzF"
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 22:26:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCiRa-0001jD-Vk
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 22:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbYAIV0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 16:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbYAIV0I
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 16:26:08 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:51876 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbYAIV0F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 16:26:05 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m09LQ0kT002309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 9 Jan 2008 22:26:01 +0100
Received: from [192.168.2.102] (p54900E53.dip0.t-ipconnect.de [84.144.14.83])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m09LPwY0019539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 Jan 2008 22:26:00 +0100
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70017>

--Boundary-00=_FuThHVvrVgOzSzF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Now 100% complete (163 strings).

Signed-off-by: Christian Stimming <stimming@tuhh.de>
=2D--
Additionally attached in gzip'd form to avoid encoding=20
or whitespace problems.

 po/de.po |  418 +++++++++++++++++++++++++++++++++-------------------------=
=2D---
 1 files changed, 220 insertions(+), 198 deletions(-)

diff --git a/po/de.po b/po/de.po
index d7881dd..5ee2fca 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -7,8 +7,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2007-12-21 12:04+0100\n"
=2D"PO-Revision-Date: 2008-01-08 21:48+0100\n"
+"POT-Creation-Date: 2008-01-09 22:20+0100\n"
+"PO-Revision-Date: 2008-01-09 22:21+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -17,13 +17,13 @@ msgstr ""
=20
 #: gitk:101
 msgid "Error executing git rev-list:"
=2Dmsgstr ""
+msgstr "Fehler beim Ausf=FChren von git-rev-list:"
=20
 #: gitk:114
 msgid "Reading"
 msgstr "Lesen"
=20
=2D#: gitk:141 gitk:2151
+#: gitk:141 gitk:2143
 msgid "Reading commits..."
 msgstr "Versionen lesen..."
=20
@@ -31,197 +31,197 @@ msgstr "Versionen lesen..."
 msgid "Can't parse git log output:"
 msgstr "Git log Ausgabe kann nicht erkannt werden:"
=20
=2D#: gitk:375 gitk:2155
+#: gitk:375 gitk:2147
 msgid "No commits selected"
 msgstr "Keine Versionen ausgew=E4hlt."
=20
 #: gitk:486
 msgid "No commit information available"
=2Dmsgstr ""
+msgstr "Keine Versionsinformation verf=FCgbar"
=20
=2D#: gitk:585 gitk:607 gitk:1914 gitk:6374 gitk:7875 gitk:8035
+#: gitk:585 gitk:607 gitk:1908 gitk:6366 gitk:7866 gitk:8020
 msgid "OK"
 msgstr "Ok"
=20
=2D#: gitk:609 gitk:1916 gitk:6054 gitk:6125 gitk:6226 gitk:6272 gitk:6376
=2D#: gitk:7877 gitk:8037
+#: gitk:609 gitk:1909 gitk:6046 gitk:6117 gitk:6218 gitk:6264 gitk:6368
+#: gitk:7867 gitk:8021
 msgid "Cancel"
 msgstr "Abbrechen"
=20
=2D#: gitk:633
+#: gitk:646
 msgid "File"
 msgstr "Datei"
=20
=2D#: gitk:636
+#: gitk:648
 msgid "Update"
 msgstr "Aktualisieren"
=20
=2D#: gitk:637
+#: gitk:649
 msgid "Reread references"
 msgstr "Zweige neu laden"
=20
=2D#: gitk:638
+#: gitk:650
 msgid "List references"
 msgstr "Zweige auflisten"
=20
=2D#: gitk:639
+#: gitk:651
 msgid "Quit"
 msgstr "Beenden"
=20
=2D#: gitk:642
+#: gitk:653
 msgid "Edit"
 msgstr "Bearbeiten"
=20
=2D#: gitk:643
+#: gitk:654
 msgid "Preferences"
 msgstr "Einstellungen"
=20
=2D#: gitk:647
+#: gitk:657
 msgid "View"
 msgstr "Ansicht"
=20
=2D#: gitk:648
+#: gitk:658
 msgid "New view..."
 msgstr "Neue Ansicht..."
=20
=2D#: gitk:649 gitk:2093 gitk:8666
+#: gitk:659 gitk:2085 gitk:8651
 msgid "Edit view..."
 msgstr "Ansicht bearbeiten..."
=20
=2D#: gitk:651 gitk:2094 gitk:8667
+#: gitk:661 gitk:2086 gitk:8652
 msgid "Delete view"
 msgstr "Ansicht l=F6schen"
=20
=2D#: gitk:653
+#: gitk:663
 msgid "All files"
 msgstr "Alle Dateien"
=20
=2D#: gitk:657
+#: gitk:667
 msgid "Help"
 msgstr "Hilfe"
=20
=2D#: gitk:658 gitk:1280
+#: gitk:668 gitk:1280
 msgid "About gitk"
 msgstr "=DCber gitk"
=20
=2D#: gitk:659
+#: gitk:669
 msgid "Key bindings"
 msgstr "Tastenk=FCrzel"
=20
=2D#: gitk:716
+#: gitk:726
 msgid "SHA1 ID: "
=2Dmsgstr ""
+msgstr "SHA1:"
=20
=2D#: gitk:766
+#: gitk:776
 msgid "Find"
 msgstr "Suche"
=20
=2D#: gitk:767
+#: gitk:777
 msgid "next"
 msgstr "n=E4chste"
=20
=2D#: gitk:768
+#: gitk:778
 msgid "prev"
 msgstr "vorige"
=20
=2D#: gitk:769
+#: gitk:779
 msgid "commit"
 msgstr "Version"
=20
=2D#: gitk:772 gitk:774 gitk:2316 gitk:2339 gitk:2363 gitk:4265 gitk:4328
+#: gitk:782 gitk:784 gitk:2308 gitk:2331 gitk:2355 gitk:4257 gitk:4320
 msgid "containing:"
 msgstr "enthaltend:"
=20
=2D#: gitk:775 gitk:1746 gitk:1751 gitk:2391
+#: gitk:785 gitk:1741 gitk:1746 gitk:2383
 msgid "touching paths:"
 msgstr "Pfad betreffend:"
=20
=2D#: gitk:776 gitk:2396
+#: gitk:786 gitk:2388
 msgid "adding/removing string:"
 msgstr "String dazu/l=F6schen:"
=20
=2D#: gitk:787 gitk:789
+#: gitk:795 gitk:797
 msgid "Exact"
 msgstr "Exakt"
=20
=2D#: gitk:789 gitk:2474 gitk:4233
+#: gitk:797 gitk:2466 gitk:4225
 msgid "IgnCase"
 msgstr "Kein Gro=DF/Klein"
=20
=2D#: gitk:789 gitk:2365 gitk:2472 gitk:4229
+#: gitk:797 gitk:2357 gitk:2464 gitk:4221
 msgid "Regexp"
 msgstr "Regexp"
=20
=2D#: gitk:793 gitk:794 gitk:2493 gitk:2523 gitk:2530 gitk:4339 gitk:4395
+#: gitk:799 gitk:800 gitk:2485 gitk:2515 gitk:2522 gitk:4331 gitk:4387
 msgid "All fields"
 msgstr "Alle Felder"
=20
=2D#: gitk:794 gitk:2491 gitk:2523 gitk:4295
+#: gitk:800 gitk:2483 gitk:2515 gitk:4287
 msgid "Headline"
 msgstr "=DCberschrift"
=20
=2D#: gitk:795 gitk:2491 gitk:4295 gitk:4395 gitk:4783
+#: gitk:801 gitk:2483 gitk:4287 gitk:4387 gitk:4775
 msgid "Comments"
 msgstr "Beschreibung"
=20
=2D#: gitk:795 gitk:2491 gitk:2495 gitk:2530 gitk:4295 gitk:4719 gitk:5903
=2D#: gitk:5918
+#: gitk:801 gitk:2483 gitk:2487 gitk:2522 gitk:4287 gitk:4711 gitk:5895
+#: gitk:5910
 msgid "Author"
 msgstr "Autor"
=20
=2D#: gitk:795 gitk:2491 gitk:4295 gitk:4721
+#: gitk:801 gitk:2483 gitk:4287 gitk:4713
 msgid "Committer"
 msgstr "Eintragender"
=20
=2D#: gitk:825
+#: gitk:829
 msgid "Search"
 msgstr "Suche"
=20
=2D#: gitk:833
+#: gitk:836
 msgid "Diff"
 msgstr "Vergleich"
=20
=2D#: gitk:835
+#: gitk:838
 msgid "Old version"
 msgstr "Alte Version"
=20
=2D#: gitk:837
+#: gitk:840
 msgid "New version"
 msgstr "Neue Version"
=20
=2D#: gitk:839
+#: gitk:842
 msgid "Lines of context"
 msgstr "Kontextzeilen"
=20
=2D#: gitk:898
+#: gitk:900
 msgid "Patch"
=2Dmsgstr ""
+msgstr "Patch"
=20
=2D#: gitk:901
+#: gitk:902
 msgid "Tree"
 msgstr "Baum"
=20
=2D#: gitk:1018 gitk:1033 gitk:5969
+#: gitk:1018 gitk:1033 gitk:5961
 msgid "Diff this -> selected"
 msgstr "Vergleich diese -> gew=E4hlte"
=20
=2D#: gitk:1020 gitk:1035 gitk:5970
+#: gitk:1020 gitk:1035 gitk:5962
 msgid "Diff selected -> this"
 msgstr "Vergleich gew=E4hlte -> diese"
=20
=2D#: gitk:1022 gitk:1037 gitk:5971
+#: gitk:1022 gitk:1037 gitk:5963
 msgid "Make patch"
 msgstr "Patch erstellen"
=20
=2D#: gitk:1023 gitk:6109
+#: gitk:1023 gitk:6101
 msgid "Create tag"
 msgstr "Markierung erstellen"
=20
=2D#: gitk:1024 gitk:6206
+#: gitk:1024 gitk:6198
 msgid "Write commit to file"
 msgstr "Version in Datei schreiben"
=20
=2D#: gitk:1025 gitk:6260
+#: gitk:1025 gitk:6252
 msgid "Create new branch"
 msgstr "Neuen Zweig erstellen"
=20
@@ -243,11 +243,11 @@ msgstr "Zweig l=F6schen"
=20
 #: gitk:1052
 msgid "Highlight this too"
=2Dmsgstr ""
+msgstr "Diesen auch hervorheben"
=20
 #: gitk:1054
 msgid "Highlight this only"
=2Dmsgstr ""
+msgstr "Nur diesen hervorheben"
=20
 #: gitk:1281
 msgid ""
@@ -258,261 +258,271 @@ msgid ""
 "\n"
 "Use and redistribute under the terms of the GNU General Public License"
 msgstr ""
+"\n"
+"Gitk - eine Visualisierung der Git Historie\n"
+"\n"
+"Copyright =A9 2005-2006 Paul Mackerras\n"
+"\n"
+"Benutzung und Weiterverbreitung gem=E4=DF den Bedingungen der GNU General=
 Public "
+"License\n"
+"        "
=20
=2D#: gitk:1290 gitk:1354 gitk:6532
+#: gitk:1289 gitk:1350 gitk:6524
 msgid "Close"
 msgstr "Schlie=DFen"
=20
=2D#: gitk:1311
+#: gitk:1308
 msgid "Gitk key bindings"
=2Dmsgstr ""
+msgstr "Gitk Tastaturbelegung"
=20
=2D#: gitk:1863
+#: gitk:1858
 msgid "Gitk view definition"
=2Dmsgstr ""
+msgstr "Gitk Ansichten"
=20
=2D#: gitk:1888
+#: gitk:1882
 msgid "Name"
 msgstr "Name"
=20
=2D#: gitk:1891
+#: gitk:1885
 msgid "Remember this view"
 msgstr "Diese Ansicht speichern"
=20
=2D#: gitk:1895
+#: gitk:1889
 msgid "Commits to include (arguments to git rev-list):"
=2Dmsgstr ""
+msgstr "Versionen anzeigen (Argumente von git-rev-list):"
=20
=2D#: gitk:1901
+#: gitk:1895
 msgid "Enter files and directories to include, one per line:"
=2Dmsgstr ""
+msgstr "Folgende Dateien und Verzeichnisse anzeigen (eine pro Zeile):"
=20
=2D#: gitk:1950
+#: gitk:1942
 msgid "Error in commit selection arguments:"
=2Dmsgstr ""
+msgstr "Fehler in den ausgew=E4hlten Versionen:"
=20
=2D#: gitk:2001 gitk:2087 gitk:2543 gitk:2557 gitk:3740 gitk:8635 gitk:8636
+#: gitk:1993 gitk:2079 gitk:2535 gitk:2549 gitk:3732 gitk:8620 gitk:8621
 msgid "None"
 msgstr "Keine"
=20
=2D#: gitk:2491 gitk:4295 gitk:5905 gitk:5920
+#: gitk:2483 gitk:4287 gitk:5897 gitk:5912
 msgid "Date"
 msgstr "Datum"
=20
=2D#: gitk:2491 gitk:4295
+#: gitk:2483 gitk:4287
 msgid "CDate"
 msgstr "Eintragedatum"
=20
=2D#: gitk:2640 gitk:2645
=2Dmsgid "Descendent"
=2Dmsgstr ""
+#: gitk:2632 gitk:2637
+msgid "Descendant"
+msgstr "Abk=F6mmling"
=20
=2D#: gitk:2641
=2Dmsgid "Not descendent"
=2Dmsgstr ""
+#: gitk:2633
+msgid "Not descendant"
+msgstr "Nicht Abk=F6mmling"
=20
=2D#: gitk:2648 gitk:2653
+#: gitk:2640 gitk:2645
 msgid "Ancestor"
=2Dmsgstr ""
+msgstr "Vorg=E4nger"
=20
=2D#: gitk:2649
+#: gitk:2641
 msgid "Not ancestor"
=2Dmsgstr ""
+msgstr "Nicht Vorg=E4nger"
=20
=2D#: gitk:2883
+#: gitk:2875
 msgid "Local changes checked in to index but not committed"
 msgstr "Lokale =C4nderungen bereitgestellt, aber nicht eingetragen"
=20
=2D#: gitk:2913
+#: gitk:2905
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokale =C4nderungen, nicht bereitgestellt"
=20
=2D#: gitk:4264
+#: gitk:4256
 msgid "Searching"
 msgstr "Suchen"
=20
=2D#: gitk:4723
+#: gitk:4715
 msgid "Tags:"
 msgstr "Markierungen:"
=20
=2D#: gitk:4740 gitk:4746 gitk:5898
+#: gitk:4732 gitk:4738 gitk:5890
 msgid "Parent"
 msgstr "Eltern"
=20
=2D#: gitk:4751
+#: gitk:4743
 msgid "Child"
 msgstr "Kind"
=20
=2D#: gitk:4760
+#: gitk:4752
 msgid "Branch"
 msgstr "Zweig"
=20
=2D#: gitk:4763
+#: gitk:4755
 msgid "Follows"
=2Dmsgstr ""
+msgstr "Folgt auf"
=20
=2D#: gitk:4766
+#: gitk:4758
 msgid "Precedes"
=2Dmsgstr ""
+msgstr "Vorg=E4nger von"
=20
=2D#: gitk:5048
+#: gitk:5040
 msgid "Error getting merge diffs:"
 msgstr "Fehler beim Laden des Vergleichs:"
=20
=2D#: gitk:5725
+#: gitk:5717
 msgid "Goto:"
=2Dmsgstr ""
+msgstr "Gehe zu:"
=20
=2D#: gitk:5727
+#: gitk:5719
 msgid "SHA1 ID:"
=2Dmsgstr ""
+msgstr "SHA1 Kennung:"
=20
=2D#: gitk:5752
+#: gitk:5744
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
=2Dmsgstr ""
+msgstr "Kurze SHA1-Kennung =BB%s=AB ist mehrdeutig"
=20
=2D#: gitk:5764
+#: gitk:5756
 #, tcl-format
 msgid "SHA1 id %s is not known"
=2Dmsgstr ""
+msgstr "SHA1-Kennung =BB%s=AB unbekannt"
=20
=2D#: gitk:5766
+#: gitk:5758
 #, tcl-format
 msgid "Tag/Head %s is not known"
=2Dmsgstr ""
+msgstr "Markierung/Zweig =BB%s=AB ist unbekannt"
=20
=2D#: gitk:5908
+#: gitk:5900
 msgid "Children"
 msgstr "Kinder"
=20
=2D#: gitk:5965
+#: gitk:5957
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Zweig =BB%s=AB hierher zur=FCcksetzen"
=20
=2D#: gitk:5996
+#: gitk:5988
 msgid "Top"
 msgstr "Oben"
=20
=2D#: gitk:5997
+#: gitk:5989
 msgid "From"
 msgstr "Von"
=20
=2D#: gitk:6002
+#: gitk:5994
 msgid "To"
 msgstr "bis"
=20
=2D#: gitk:6025
+#: gitk:6017
 msgid "Generate patch"
 msgstr "Patch erstellen"
=20
=2D#: gitk:6027
+#: gitk:6019
 msgid "From:"
 msgstr "Von:"
=20
=2D#: gitk:6036
+#: gitk:6028
 msgid "To:"
 msgstr "bis:"
=20
=2D#: gitk:6045
+#: gitk:6037
 msgid "Reverse"
 msgstr "Umgekehrt"
=20
=2D#: gitk:6047 gitk:6220
+#: gitk:6039 gitk:6212
 msgid "Output file:"
=2Dmsgstr ""
+msgstr "Ausgabedatei:"
=20
=2D#: gitk:6053
+#: gitk:6045
 msgid "Generate"
 msgstr "Erzeugen"
=20
=2D#: gitk:6089
+#: gitk:6081
 msgid "Error creating patch:"
=2Dmsgstr ""
+msgstr "Fehler beim Patch erzeugen:"
=20
=2D#: gitk:6111 gitk:6208 gitk:6262
+#: gitk:6103 gitk:6200 gitk:6254
 msgid "ID:"
=2Dmsgstr ""
+msgstr "ID:"
=20
=2D#: gitk:6120
+#: gitk:6112
 msgid "Tag name:"
 msgstr "Markierungsname:"
=20
=2D#: gitk:6124 gitk:6271
+#: gitk:6116 gitk:6263
 msgid "Create"
 msgstr "Erstellen"
=20
=2D#: gitk:6139
+#: gitk:6131
 msgid "No tag name specified"
=2Dmsgstr ""
+msgstr "Kein Markierungsname angegeben"
=20
=2D#: gitk:6143
+#: gitk:6135
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Markierung =BB%s=AB existiert bereits."
=20
=2D#: gitk:6153
+#: gitk:6145
 msgid "Error creating tag:"
=2Dmsgstr ""
+msgstr "Fehler bei Markierung erstellen:"
=20
=2D#: gitk:6217
+#: gitk:6209
 msgid "Command:"
=2Dmsgstr ""
+msgstr "Kommando:"
=20
=2D#: gitk:6225
+#: gitk:6217
 msgid "Write"
 msgstr "Schreiben"
=20
=2D#: gitk:6241
+#: gitk:6233
 msgid "Error writing commit:"
=2Dmsgstr ""
+msgstr "Fehler beim Version eintragen:"
=20
=2D#: gitk:6267
+#: gitk:6259
 msgid "Name:"
 msgstr "Name:"
=20
=2D#: gitk:6286
+#: gitk:6278
 msgid "Please specify a name for the new branch"
=2Dmsgstr ""
+msgstr "Bitte geben Sie einen Namen f=FCr den neuen Zweig an."
=20
=2D#: gitk:6315
+#: gitk:6307
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
+"Version =BB%s=AB ist bereits im Zweig =BB%s=AB enthalten -- trotzdem erne=
ut "
+"eintragen?"
=20
=2D#: gitk:6320
+#: gitk:6312
 msgid "Cherry-picking"
 msgstr "Version pfl=FCcken"
=20
=2D#: gitk:6332
+#: gitk:6324
 msgid "No changes committed"
 msgstr "Keine =C4nderungen eingetragen"
=20
=2D#: gitk:6355
+#: gitk:6347
 msgid "Confirm reset"
 msgstr "Zur=FCcksetzen best=E4tigen"
=20
=2D#: gitk:6357
+#: gitk:6349
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Zweig =BB%s=AB auf =BB%s=AB zur=FCcksetzen?"
=20
=2D#: gitk:6361
+#: gitk:6353
 msgid "Reset type:"
 msgstr "Art des Zur=FCcksetzens:"
=20
=2D#: gitk:6365
+#: gitk:6357
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Harmlos: Arbeitskopie und Bereitstellung unver=E4ndert"
=20
=2D#: gitk:6368
+#: gitk:6360
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr ""
 "Gemischt: Arbeitskopie unver=E4ndert,\n"
 "Bereitstellung zur=FCckgesetzt"
=20
=2D#: gitk:6371
+#: gitk:6363
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -520,184 +530,196 @@ msgstr ""
 "Hart: Arbeitskopie und Bereitstellung\n"
 "(Alle lokalen =C4nderungen werden gel=F6scht)"
=20
=2D#: gitk:6387
+#: gitk:6379
 msgid "Resetting"
 msgstr "Zur=FCcksetzen"
=20
=2D#: gitk:6444
+#: gitk:6436
 msgid "Checking out"
 msgstr "Umstellen"
=20
=2D#: gitk:6474
+#: gitk:6466
 msgid "Cannot delete the currently checked-out branch"
=2Dmsgstr "Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kan=
n nicht gel=F6scht werden."
+msgstr ""
+"Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kann nicht "
+"gel=F6scht werden."
=20
=2D#: gitk:6480
+#: gitk:6472
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
 "Really delete branch %s?"
 msgstr ""
+"Die Versionen auf Zweig =BB%s=AB existieren auf keinem anderen Zweig.\n"
+"Zweig =BB%s=AB trotzdem l=F6schen?"
=20
=2D#: gitk:6511
+#: gitk:6503
 #, tcl-format
 msgid "Tags and heads: %s"
=2Dmsgstr ""
+msgstr "Markierungen und Zweige: %s"
=20
=2D#: gitk:6525
+#: gitk:6517
 msgid "Filter"
=2Dmsgstr ""
+msgstr "Filtern"
=20
=2D#: gitk:6820
+#: gitk:6811
 msgid ""
 "Error reading commit topology information; branch and preceding/following=
 "
 "tag information will be incomplete."
 msgstr ""
+"Fehler beim Lesen der Strukturinformationen; Zweige und Vorg=E4nger/Nachf=
olger "
+"Informationen werden unvollst=E4ndig sein."
=20
=2D#: gitk:7804
+#: gitk:7795
 msgid "Tag"
 msgstr "Markierung"
=20
=2D#: gitk:7804
+#: gitk:7795
 msgid "Id"
=2Dmsgstr ""
+msgstr "Id"
=20
=2D#: gitk:7844
+#: gitk:7835
 msgid "Gitk font chooser"
=2Dmsgstr ""
+msgstr "Gitk Schriften w=E4hlen"
=20
=2D#: gitk:7861
+#: gitk:7852
 msgid "B"
 msgstr "F"
=20
=2D#: gitk:7864
+#: gitk:7855
 msgid "I"
 msgstr "K"
=20
=2D#: gitk:7959
+#: gitk:7948
 msgid "Gitk preferences"
 msgstr "Gitk Einstellungen"
=20
=2D#: gitk:7960
+#: gitk:7949
 msgid "Commit list display options"
 msgstr "Anzeige Versionsliste"
=20
=2D#: gitk:7964
+#: gitk:7952
 msgid "Maximum graph width (lines)"
 msgstr "Maximale Graphenbreite (Zeilen)"
=20
=2D#: gitk:7968
+#: gitk:7956
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximale Graphenbreite (% des Fensters)"
=20
=2D#: gitk:7973
+#: gitk:7961
 msgid "Show local changes"
 msgstr "Lokale =C4nderungen anzeigen"
=20
=2D#: gitk:7978
+#: gitk:7966
 msgid "Diff display options"
 msgstr "Anzeige Vergleich"
=20
=2D#: gitk:7981
+#: gitk:7968
 msgid "Tab spacing"
 msgstr "Tabulatorbreite"
=20
=2D#: gitk:7985
+#: gitk:7972
 msgid "Display nearby tags"
=2Dmsgstr ""
+msgstr "Naheliegende =DCberschriften anzeigen"
=20
=2D#: gitk:7990
+#: gitk:7977
 msgid "Limit diffs to listed paths"
 msgstr "Vergleich nur f=FCr angezeigte Pfade"
=20
=2D#: gitk:7995
+#: gitk:7982
 msgid "Colors: press to choose"
 msgstr "Farben: Klicken zum W=E4hlen"
=20
=2D#: gitk:7999
+#: gitk:7985
 msgid "Background"
 msgstr "Vordergrund"
=20
=2D#: gitk:8003
+#: gitk:7989
 msgid "Foreground"
 msgstr "Hintergrund"
=20
=2D#: gitk:8007
+#: gitk:7993
 msgid "Diff: old lines"
 msgstr "Vergleich: Alte Zeilen"
=20
=2D#: gitk:8012
+#: gitk:7998
 msgid "Diff: new lines"
 msgstr "Vergleich: Neue Zeilen"
=20
=2D#: gitk:8017
+#: gitk:8003
 msgid "Diff: hunk header"
 msgstr "Vergleich: =C4nderungstitel"
=20
=2D#: gitk:8023
+#: gitk:8009
 msgid "Select bg"
 msgstr "Hintergrundfarbe Ausw=E4hlen"
=20
=2D#: gitk:8027
+#: gitk:8013
 msgid "Fonts: press to choose"
 msgstr "Schriftart: Klicken zum W=E4hlen"
=20
=2D#: gitk:8030
+#: gitk:8015
 msgid "Main font"
 msgstr "Programmschriftart"
=20
=2D#: gitk:8031
+#: gitk:8016
 msgid "Diff display font"
 msgstr "Vergleich"
=20
=2D#: gitk:8032
+#: gitk:8017
 msgid "User interface font"
 msgstr "Beschriftungen"
=20
=2D#: gitk:8050
+#: gitk:8033
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: Farbe w=E4hlen f=FCr %s"
=20
=2D#: gitk:8431
+#: gitk:8414
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
 msgstr ""
+"Gitk l=E4uft nicht mit dieser Version von Tcl/Tk.\n"
+"Gitk ben=F6tigt mindestens Tcl/Tk 8.4."
=20
=2D#: gitk:8516
+#: gitk:8501
 msgid "Cannot find a git repository here."
 msgstr "Kein Git-Projektarchiv gefunden."
=20
=2D#: gitk:8520
+#: gitk:8505
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
=2Dmsgstr ""
+msgstr "Git-Verzeichnis =BB%s=AB wurde nicht gefunden."
=20
=2D#: gitk:8559
+#: gitk:8544
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
=2Dmsgstr ""
+msgstr "Mehrdeutige Angabe =BB%s=AB: Sowohl Version als auch Dateiname exi=
stiert."
=20
=2D#: gitk:8571
+#: gitk:8556
 msgid "Bad arguments to gitk:"
=2Dmsgstr ""
+msgstr "Falsche Kommandozeilen-Parameter f=FCr gitk:"
=20
=2D#: gitk:8583
+#: gitk:8568
 msgid "Couldn't get list of unmerged files:"
=2Dmsgstr ""
+msgstr "Liste der nicht-zusammengef=FChrten Dateien nicht gefunden:"
=20
=2D#: gitk:8599
+#: gitk:8584
 msgid "No files selected: --merge specified but no files are unmerged."
 msgstr ""
+"Keine Dateien ausgew=E4hle: --merge angegeben, es existieren aber keine n=
icht-"
+"zusammengef=FChrten Dateien."
=20
=2D#: gitk:8602
+#: gitk:8587
 msgid ""
 "No files selected: --merge specified but no unmerged files are within fil=
e "
 "limit."
 msgstr ""
+"Keine Dateien ausgew=E4hle: --merge angegeben, aber keine nicht-"
+"zusammengef=FChrten Dateien sind in der Dateiauswahl."
=20
=2D#: gitk:8661
+#: gitk:8646
 msgid "Command line"
 msgstr "Kommandozeile"
=2D-=20
1.5.3.4.206.g58ba4


--Boundary-00=_FuThHVvrVgOzSzF
Content-Type: application/x-gzip;
  name="0002-gitk-Update-German-translation.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0002-gitk-Update-German-translation.patch.gz"

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

--Boundary-00=_FuThHVvrVgOzSzF--
