From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 4/9] gitk i18n: Initial German translation.
Date: Wed, 7 Nov 2007 18:44:02 +0100
Message-ID: <200711071844.03106.stimming@tuhh.de>
References: <200711071839.08570.stimming@tuhh.de> <200711071840.59972.stimming@tuhh.de> <200711071842.55975.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 18:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpoXG-0003Zp-41
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 18:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841AbXKGRQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 12:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755639AbXKGRQe
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 12:16:34 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:45995 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755461AbXKGRQc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 12:16:32 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HFQ4a018543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 7 Nov 2007 18:15:29 +0100
Received: from [192.168.2.102] (p549012B6.dip0.t-ipconnect.de [84.144.18.182])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HFPTG005147
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Nov 2007 18:15:26 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <200711071842.55975.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63837>

---
In order to test the i18n code, I prepared half-completed=20
German translation.

 po/de.po |  703 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 703 insertions(+), 0 deletions(-)
 create mode 100644 po/de.po

diff --git a/po/de.po b/po/de.po
new file mode 100644
index 0000000..8c41069
--- /dev/null
+++ b/po/de.po
@@ -0,0 +1,703 @@
+# Translation of git-gui to German.
+# Copyright (C) 2007 Shawn Pearce, et al.
+# This file is distributed under the same license as the git package.
+# Christian Stimming <stimming@tuhh.de>, 2007
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-11-07 12:27+0100\n"
+"PO-Revision-Date: 2007-11-07 12:36+0100\n"
+"Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
+"Language-Team: German\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: gitk:101
+msgid "Error executing git rev-list:"
+msgstr ""
+
+#: gitk:114
+msgid "Reading"
+msgstr "Lesen"
+
+#: gitk:141 gitk:2151
+msgid "Reading commits..."
+msgstr "Versionen lesen..."
+
+#: gitk:264
+msgid "Can't parse git log output:"
+msgstr "Git log Ausgabe kann nicht erkannt werden:"
+
+#: gitk:375 gitk:2155
+msgid "No commits selected"
+msgstr "Keine Versionen ausgew=C3=A4hlt."
+
+#: gitk:486
+msgid "No commit information available"
+msgstr ""
+
+#: gitk:585 gitk:607 gitk:1914 gitk:6374 gitk:7875 gitk:8035
+msgid "OK"
+msgstr "Ok"
+
+#: gitk:609 gitk:1916 gitk:6054 gitk:6125 gitk:6226 gitk:6272 gitk:637=
6
+#: gitk:7877 gitk:8037
+msgid "Cancel"
+msgstr "Abbrechen"
+
+#: gitk:633
+msgid "File"
+msgstr "Datei"
+
+#: gitk:636
+msgid "Update"
+msgstr "Aktualisieren"
+
+#: gitk:637
+msgid "Reread references"
+msgstr "Zweige neu laden"
+
+#: gitk:638
+msgid "List references"
+msgstr "Zweige auflisten"
+
+#: gitk:639
+msgid "Quit"
+msgstr "Beenden"
+
+#: gitk:642
+msgid "Edit"
+msgstr "Bearbeiten"
+
+#: gitk:643
+msgid "Preferences"
+msgstr "Einstellungen"
+
+#: gitk:647
+msgid "View"
+msgstr "Ansicht"
+
+#: gitk:648
+msgid "New view..."
+msgstr "Neue Ansicht..."
+
+#: gitk:649 gitk:2093 gitk:8666
+msgid "Edit view..."
+msgstr "Ansicht bearbeiten..."
+
+#: gitk:651 gitk:2094 gitk:8667
+msgid "Delete view"
+msgstr "Ansicht l=C3=B6schen"
+
+#: gitk:653
+msgid "All files"
+msgstr "Alle Dateien"
+
+#: gitk:657
+msgid "Help"
+msgstr "Hilfe"
+
+#: gitk:658 gitk:1280
+msgid "About gitk"
+msgstr "=C3=9Cber gitk"
+
+#: gitk:659
+msgid "Key bindings"
+msgstr "Tastenk=C3=BCrzel"
+
+#: gitk:716
+msgid "SHA1 ID: "
+msgstr ""
+
+#: gitk:766
+msgid "Find"
+msgstr "Suche"
+
+#: gitk:767
+msgid "next"
+msgstr "n=C3=A4chste"
+
+#: gitk:768
+msgid "prev"
+msgstr "vorige"
+
+#: gitk:769
+msgid "commit"
+msgstr "Version"
+
+#: gitk:772 gitk:774 gitk:2316 gitk:2339 gitk:2363 gitk:4265 gitk:4328
+msgid "containing:"
+msgstr "enthaltend:"
+
+#: gitk:775 gitk:1746 gitk:1751 gitk:2391
+msgid "touching paths:"
+msgstr "Pfad betreffend:"
+
+#: gitk:776 gitk:2396
+msgid "adding/removing string:"
+msgstr "String dazu/l=C3=B6schen:"
+
+#: gitk:787 gitk:789
+msgid "Exact"
+msgstr "Exakt"
+
+#: gitk:789 gitk:2474 gitk:4233
+msgid "IgnCase"
+msgstr "Kein Gro=C3=9F/Klein"
+
+#: gitk:789 gitk:2365 gitk:2472 gitk:4229
+msgid "Regexp"
+msgstr "Regexp"
+
+#: gitk:793 gitk:794 gitk:2493 gitk:2523 gitk:2530 gitk:4339 gitk:4395
+msgid "All fields"
+msgstr "Alle Felder"
+
+#: gitk:794 gitk:2491 gitk:2523 gitk:4295
+msgid "Headline"
+msgstr "=C3=9Cberschrift"
+
+#: gitk:795 gitk:2491 gitk:4295 gitk:4395 gitk:4783
+msgid "Comments"
+msgstr "Beschreibung"
+
+#: gitk:795 gitk:2491 gitk:2495 gitk:2530 gitk:4295 gitk:4719 gitk:590=
3
+#: gitk:5918
+msgid "Author"
+msgstr "Autor"
+
+#: gitk:795 gitk:2491 gitk:4295 gitk:4721
+msgid "Committer"
+msgstr "Eintragender"
+
+#: gitk:825
+msgid "Search"
+msgstr "Suche"
+
+#: gitk:833
+msgid "Diff"
+msgstr "Vergleich"
+
+#: gitk:835
+msgid "Old version"
+msgstr "Alte Version"
+
+#: gitk:837
+msgid "New version"
+msgstr "Neue Version"
+
+#: gitk:839
+msgid "Lines of context"
+msgstr "Kontextzeilen"
+
+#: gitk:898
+msgid "Patch"
+msgstr ""
+
+#: gitk:901
+msgid "Tree"
+msgstr "Baum"
+
+#: gitk:1018 gitk:1033 gitk:5969
+msgid "Diff this -> selected"
+msgstr "Vergleich diese -> gew=C3=A4hlte"
+
+#: gitk:1020 gitk:1035 gitk:5970
+msgid "Diff selected -> this"
+msgstr "Vergleich gew=C3=A4hlte -> diese"
+
+#: gitk:1022 gitk:1037 gitk:5971
+msgid "Make patch"
+msgstr "Patch erstellen"
+
+#: gitk:1023 gitk:6109
+msgid "Create tag"
+msgstr "Markierung erstellen"
+
+#: gitk:1024 gitk:6206
+msgid "Write commit to file"
+msgstr "Version in Datei schreiben"
+
+#: gitk:1025 gitk:6260
+msgid "Create new branch"
+msgstr "Neuen Zweig erstellen"
+
+#: gitk:1026
+msgid "Cherry-pick this commit"
+msgstr "Diese Version pfl=C3=BCcken"
+
+#: gitk:1028
+msgid "Reset HEAD branch to here"
+msgstr "HEAD-Zweig auf diese Version zur=C3=BCcksetzen"
+
+#: gitk:1044
+msgid "Check out this branch"
+msgstr "Auf diesen Zweig umstellen"
+
+#: gitk:1046
+msgid "Remove this branch"
+msgstr "Zweig l=C3=B6schen"
+
+#: gitk:1052
+msgid "Highlight this too"
+msgstr ""
+
+#: gitk:1054
+msgid "Highlight this only"
+msgstr ""
+
+#: gitk:1281
+msgid ""
+"\n"
+"Gitk - a commit viewer for git\n"
+"\n"
+"Copyright =C2=A9 2005-2006 Paul Mackerras\n"
+"\n"
+"Use and redistribute under the terms of the GNU General Public Licens=
e"
+msgstr ""
+
+#: gitk:1290 gitk:1354 gitk:6532
+msgid "Close"
+msgstr "Schlie=C3=9Fen"
+
+#: gitk:1311
+msgid "Gitk key bindings"
+msgstr ""
+
+#: gitk:1863
+msgid "Gitk view definition"
+msgstr ""
+
+#: gitk:1888
+msgid "Name"
+msgstr "Name"
+
+#: gitk:1891
+msgid "Remember this view"
+msgstr "Diese Ansicht speichern"
+
+#: gitk:1895
+msgid "Commits to include (arguments to git rev-list):"
+msgstr ""
+
+#: gitk:1901
+msgid "Enter files and directories to include, one per line:"
+msgstr ""
+
+#: gitk:1950
+msgid "Error in commit selection arguments:"
+msgstr ""
+
+#: gitk:2001 gitk:2087 gitk:2543 gitk:2557 gitk:3740 gitk:8635 gitk:86=
36
+msgid "None"
+msgstr "Keine"
+
+#: gitk:2491 gitk:4295 gitk:5905 gitk:5920
+msgid "Date"
+msgstr "Datum"
+
+#: gitk:2491 gitk:4295
+msgid "CDate"
+msgstr "Eintragedatum"
+
+#: gitk:2640 gitk:2645
+msgid "Descendent"
+msgstr ""
+
+#: gitk:2641
+msgid "Not descendent"
+msgstr ""
+
+#: gitk:2648 gitk:2653
+msgid "Ancestor"
+msgstr ""
+
+#: gitk:2649
+msgid "Not ancestor"
+msgstr ""
+
+#: gitk:2883
+msgid "Local changes checked in to index but not committed"
+msgstr ""
+
+#: gitk:2913
+msgid "Local uncommitted changes, not checked in to index"
+msgstr ""
+
+#: gitk:4264
+msgid "Searching"
+msgstr "Suchen"
+
+#: gitk:4723
+msgid "Tags:"
+msgstr "Markierungen:"
+
+#: gitk:4740 gitk:4746 gitk:5898
+msgid "Parent"
+msgstr "Eltern"
+
+#: gitk:4751
+msgid "Child"
+msgstr "Kind"
+
+#: gitk:4760
+msgid "Branch"
+msgstr "Zweig"
+
+#: gitk:4763
+msgid "Follows"
+msgstr ""
+
+#: gitk:4766
+msgid "Precedes"
+msgstr ""
+
+#: gitk:5048
+msgid "Error getting merge diffs:"
+msgstr "Fehler beim Laden des Vergleichs:"
+
+#: gitk:5725
+msgid "Goto:"
+msgstr ""
+
+#: gitk:5727
+msgid "SHA1 ID:"
+msgstr ""
+
+#: gitk:5752
+#, tcl-format
+msgid "Short SHA1 id %s is ambiguous"
+msgstr ""
+
+#: gitk:5764
+#, tcl-format
+msgid "SHA1 id %s is not known"
+msgstr ""
+
+#: gitk:5766
+#, tcl-format
+msgid "Tag/Head %s is not known"
+msgstr ""
+
+#: gitk:5908
+msgid "Children"
+msgstr "Kinder"
+
+#: gitk:5965
+#, tcl-format
+msgid "Reset %s branch to here"
+msgstr "Zweig =C2=BB%s=C2=AB hierher zur=C3=BCcksetzen"
+
+#: gitk:5996
+msgid "Top"
+msgstr "Oben"
+
+#: gitk:5997
+msgid "From"
+msgstr "Von"
+
+#: gitk:6002
+msgid "To"
+msgstr "bis"
+
+#: gitk:6025
+msgid "Generate patch"
+msgstr "Patch erstellen"
+
+#: gitk:6027
+msgid "From:"
+msgstr "Von:"
+
+#: gitk:6036
+msgid "To:"
+msgstr "bis:"
+
+#: gitk:6045
+msgid "Reverse"
+msgstr "Umgekehrt"
+
+#: gitk:6047 gitk:6220
+msgid "Output file:"
+msgstr ""
+
+#: gitk:6053
+msgid "Generate"
+msgstr "Erzeugen"
+
+#: gitk:6089
+msgid "Error creating patch:"
+msgstr ""
+
+#: gitk:6111 gitk:6208 gitk:6262
+msgid "ID:"
+msgstr ""
+
+#: gitk:6120
+msgid "Tag name:"
+msgstr "Markierungsname:"
+
+#: gitk:6124 gitk:6271
+msgid "Create"
+msgstr "Erstellen"
+
+#: gitk:6139
+msgid "No tag name specified"
+msgstr ""
+
+#: gitk:6143
+#, tcl-format
+msgid "Tag \"%s\" already exists"
+msgstr "Markierung =C2=BB%s=C2=AB existiert bereits."
+
+#: gitk:6153
+msgid "Error creating tag:"
+msgstr ""
+
+#: gitk:6217
+msgid "Command:"
+msgstr ""
+
+#: gitk:6225
+msgid "Write"
+msgstr "Schreiben"
+
+#: gitk:6241
+msgid "Error writing commit:"
+msgstr ""
+
+#: gitk:6267
+msgid "Name:"
+msgstr "Name:"
+
+#: gitk:6286
+msgid "Please specify a name for the new branch"
+msgstr ""
+
+#: gitk:6315
+#, tcl-format
+msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
+msgstr ""
+
+#: gitk:6320
+msgid "Cherry-picking"
+msgstr "Version pfl=C3=BCcken"
+
+#: gitk:6332
+msgid "No changes committed"
+msgstr "Keine =C3=84nderungen eingetragen"
+
+#: gitk:6355
+msgid "Confirm reset"
+msgstr "Zur=C3=BCcksetzen best=C3=A4tigen"
+
+#: gitk:6357
+#, tcl-format
+msgid "Reset branch %s to %s?"
+msgstr ""
+
+#: gitk:6361
+msgid "Reset type:"
+msgstr "Art des Zur=C3=BCcksetzens:"
+
+#: gitk:6365
+msgid "Soft: Leave working tree and index untouched"
+msgstr "Weich: Arbeitskopie und Bereitstellung unver=C3=A4ndert"
+
+#: gitk:6368
+msgid "Mixed: Leave working tree untouched, reset index"
+msgstr ""
+"Gemischt: Arbeitskopie unver=C3=A4ndert,\n"
+"Bereitstellung zur=C3=BCckgesetzt"
+
+#: gitk:6371
+msgid ""
+"Hard: Reset working tree and index\n"
+"(discard ALL local changes)"
+msgstr ""
+"Hart: Arbeitskopie und Bereitstellung\n"
+"(Alle lokalen =C3=84nderungen werden gel=C3=B6scht)"
+
+#: gitk:6387
+msgid "Resetting"
+msgstr "Zur=C3=BCcksetzen"
+
+#: gitk:6444
+msgid "Checking out"
+msgstr ""
+
+#: gitk:6474
+msgid "Cannot delete the currently checked-out branch"
+msgstr ""
+
+#: gitk:6480
+#, tcl-format
+msgid ""
+"The commits on branch %s aren't on any other branch.\n"
+"Really delete branch %s?"
+msgstr ""
+
+#: gitk:6511
+#, tcl-format
+msgid "Tags and heads: %s"
+msgstr ""
+
+#: gitk:6525
+msgid "Filter"
+msgstr ""
+
+#: gitk:6820
+msgid ""
+"Error reading commit topology information; branch and preceding/follo=
wing "
+"tag information will be incomplete."
+msgstr ""
+
+#: gitk:7804
+msgid "Tag"
+msgstr "Markierung"
+
+#: gitk:7804
+msgid "Id"
+msgstr ""
+
+#: gitk:7844
+msgid "Gitk font chooser"
+msgstr ""
+
+#: gitk:7861
+msgid "B"
+msgstr "F"
+
+#: gitk:7864
+msgid "I"
+msgstr "K"
+
+#: gitk:7959
+msgid "Gitk preferences"
+msgstr "Gitk Einstellungen"
+
+#: gitk:7960
+msgid "Commit list display options"
+msgstr ""
+
+#: gitk:7964
+msgid "Maximum graph width (lines)"
+msgstr ""
+
+#: gitk:7968
+#, tcl-format
+msgid "Maximum graph width (% of pane)"
+msgstr ""
+
+#: gitk:7973
+msgid "Show local changes"
+msgstr ""
+
+#: gitk:7978
+msgid "Diff display options"
+msgstr ""
+
+#: gitk:7981
+msgid "Tab spacing"
+msgstr ""
+
+#: gitk:7985
+msgid "Display nearby tags"
+msgstr ""
+
+#: gitk:7990
+msgid "Limit diffs to listed paths"
+msgstr ""
+
+#: gitk:7995
+msgid "Colors: press to choose"
+msgstr ""
+
+#: gitk:7999
+msgid "Background"
+msgstr "Vordergrund"
+
+#: gitk:8003
+msgid "Foreground"
+msgstr "Hintergrund"
+
+#: gitk:8007
+msgid "Diff: old lines"
+msgstr ""
+
+#: gitk:8012
+msgid "Diff: new lines"
+msgstr ""
+
+#: gitk:8017
+msgid "Diff: hunk header"
+msgstr ""
+
+#: gitk:8023
+msgid "Select bg"
+msgstr "Hintergrundfarbe Ausw=C3=A4hlen"
+
+#: gitk:8027
+msgid "Fonts: press to choose"
+msgstr ""
+
+#: gitk:8030
+msgid "Main font"
+msgstr ""
+
+#: gitk:8031
+msgid "Diff display font"
+msgstr ""
+
+#: gitk:8032
+msgid "User interface font"
+msgstr ""
+
+#: gitk:8050
+#, tcl-format
+msgid "Gitk: choose color for %s"
+msgstr ""
+
+#: gitk:8431
+msgid ""
+"Sorry, gitk cannot run with this version of Tcl/Tk.\n"
+" Gitk requires at least Tcl/Tk 8.4."
+msgstr ""
+
+#: gitk:8516
+msgid "Cannot find a git repository here."
+msgstr ""
+
+#: gitk:8520
+#, tcl-format
+msgid "Cannot find the git directory \"%s\"."
+msgstr ""
+
+#: gitk:8559
+#, tcl-format
+msgid "Ambiguous argument '%s': both revision and filename"
+msgstr ""
+
+#: gitk:8571
+msgid "Bad arguments to gitk:"
+msgstr ""
+
+#: gitk:8583
+msgid "Couldn't get list of unmerged files:"
+msgstr ""
+
+#: gitk:8599
+msgid "No files selected: --merge specified but no files are unmerged.=
"
+msgstr ""
+
+#: gitk:8602
+msgid ""
+"No files selected: --merge specified but no unmerged files are within=
 file "
+"limit."
+msgstr ""
+
+#: gitk:8661
+msgid "Command line"
+msgstr "Kommandozeile"
--=20
1.5.3.4.206.g58ba4
