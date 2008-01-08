From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk: Update German translation
Date: Tue, 8 Jan 2008 21:56:36 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200801082156.36737.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EO+gHixDxSQbLXD"
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 21:58:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCLWy-0001a1-4i
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 21:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbYAHU6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 15:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbYAHU6L
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 15:58:11 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:56389 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbYAHU6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 15:58:09 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m08Kw7iH012502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 8 Jan 2008 21:58:07 +0100
Received: from [192.168.2.102] (p54900B03.dip0.t-ipconnect.de [84.144.11.3])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m08Kw5T8006871
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 8 Jan 2008 21:58:06 +0100
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69922>

--Boundary-00=_EO+gHixDxSQbLXD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Christian Stimming <stimming@tuhh.de>
=2D--
@Paul: Ignore my previous patch - this one is even more improved.

Just in case any mailer messes up whitespace or character=20
encodings, I've also attached that patch and the previous (Makefile)=20
one as a tarball.

 po/de.po |   54 +++++++++++++++++++++++++++---------------------------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/po/de.po b/po/de.po
index 19d048b..d7881dd 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -1,14 +1,14 @@
 # Translation of gitk to German.
=2D# Copyright (C) 2007 Paul Mackerras and Christian Stimming.
=2D# This file is distributed under the same license as the git package.
+# Copyright (C) 2007 Paul Mackerras.
+# This file is distributed under the same license as the gitk package.
 # Christian Stimming <stimming@tuhh.de>, 2007
 #
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
=2D"POT-Creation-Date: 2007-11-07 12:27+0100\n"
=2D"PO-Revision-Date: 2007-11-07 12:36+0100\n"
+"POT-Creation-Date: 2007-12-21 12:04+0100\n"
+"PO-Revision-Date: 2008-01-08 21:48+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -321,11 +321,11 @@ msgstr ""
=20
 #: gitk:2883
 msgid "Local changes checked in to index but not committed"
=2Dmsgstr ""
+msgstr "Lokale =C4nderungen bereitgestellt, aber nicht eingetragen"
=20
 #: gitk:2913
 msgid "Local uncommitted changes, not checked in to index"
=2Dmsgstr ""
+msgstr "Lokale =C4nderungen, nicht bereitgestellt"
=20
 #: gitk:4264
 msgid "Searching"
@@ -496,7 +496,7 @@ msgstr "Zur=FCcksetzen best=E4tigen"
 #: gitk:6357
 #, tcl-format
 msgid "Reset branch %s to %s?"
=2Dmsgstr ""
+msgstr "Zweig =BB%s=AB auf =BB%s=AB zur=FCcksetzen?"
=20
 #: gitk:6361
 msgid "Reset type:"
@@ -504,7 +504,7 @@ msgstr "Art des Zur=FCcksetzens:"
=20
 #: gitk:6365
 msgid "Soft: Leave working tree and index untouched"
=2Dmsgstr "Weich: Arbeitskopie und Bereitstellung unver=E4ndert"
+msgstr "Harmlos: Arbeitskopie und Bereitstellung unver=E4ndert"
=20
 #: gitk:6368
 msgid "Mixed: Leave working tree untouched, reset index"
@@ -526,11 +526,11 @@ msgstr "Zur=FCcksetzen"
=20
 #: gitk:6444
 msgid "Checking out"
=2Dmsgstr ""
+msgstr "Umstellen"
=20
 #: gitk:6474
 msgid "Cannot delete the currently checked-out branch"
=2Dmsgstr ""
+msgstr "Der Zweig, auf den die Arbeitskopie momentan umgestellt ist, kann =
nicht gel=F6scht werden."
=20
 #: gitk:6480
 #, tcl-format
@@ -580,28 +580,28 @@ msgstr "Gitk Einstellungen"
=20
 #: gitk:7960
 msgid "Commit list display options"
=2Dmsgstr ""
+msgstr "Anzeige Versionsliste"
=20
 #: gitk:7964
 msgid "Maximum graph width (lines)"
=2Dmsgstr ""
+msgstr "Maximale Graphenbreite (Zeilen)"
=20
 #: gitk:7968
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
=2Dmsgstr ""
+msgstr "Maximale Graphenbreite (% des Fensters)"
=20
 #: gitk:7973
 msgid "Show local changes"
=2Dmsgstr ""
+msgstr "Lokale =C4nderungen anzeigen"
=20
 #: gitk:7978
 msgid "Diff display options"
=2Dmsgstr ""
+msgstr "Anzeige Vergleich"
=20
 #: gitk:7981
 msgid "Tab spacing"
=2Dmsgstr ""
+msgstr "Tabulatorbreite"
=20
 #: gitk:7985
 msgid "Display nearby tags"
@@ -609,11 +609,11 @@ msgstr ""
=20
 #: gitk:7990
 msgid "Limit diffs to listed paths"
=2Dmsgstr ""
+msgstr "Vergleich nur f=FCr angezeigte Pfade"
=20
 #: gitk:7995
 msgid "Colors: press to choose"
=2Dmsgstr ""
+msgstr "Farben: Klicken zum W=E4hlen"
=20
 #: gitk:7999
 msgid "Background"
@@ -625,15 +625,15 @@ msgstr "Hintergrund"
=20
 #: gitk:8007
 msgid "Diff: old lines"
=2Dmsgstr ""
+msgstr "Vergleich: Alte Zeilen"
=20
 #: gitk:8012
 msgid "Diff: new lines"
=2Dmsgstr ""
+msgstr "Vergleich: Neue Zeilen"
=20
 #: gitk:8017
 msgid "Diff: hunk header"
=2Dmsgstr ""
+msgstr "Vergleich: =C4nderungstitel"
=20
 #: gitk:8023
 msgid "Select bg"
@@ -641,24 +641,24 @@ msgstr "Hintergrundfarbe Ausw=E4hlen"
=20
 #: gitk:8027
 msgid "Fonts: press to choose"
=2Dmsgstr ""
+msgstr "Schriftart: Klicken zum W=E4hlen"
=20
 #: gitk:8030
 msgid "Main font"
=2Dmsgstr ""
+msgstr "Programmschriftart"
=20
 #: gitk:8031
 msgid "Diff display font"
=2Dmsgstr ""
+msgstr "Vergleich"
=20
 #: gitk:8032
 msgid "User interface font"
=2Dmsgstr ""
+msgstr "Beschriftungen"
=20
 #: gitk:8050
 #, tcl-format
 msgid "Gitk: choose color for %s"
=2Dmsgstr ""
+msgstr "Gitk: Farbe w=E4hlen f=FCr %s"
=20
 #: gitk:8431
 msgid ""
@@ -668,7 +668,7 @@ msgstr ""
=20
 #: gitk:8516
 msgid "Cannot find a git repository here."
=2Dmsgstr ""
+msgstr "Kein Git-Projektarchiv gefunden."
=20
 #: gitk:8520
 #, tcl-format
=2D-=20
1.5.3.4.206.g58ba4


--Boundary-00=_EO+gHixDxSQbLXD
Content-Type: application/x-tgz;
  name="gitk-Update-German-translation.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="gitk-Update-German-translation.tgz"

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

--Boundary-00=_EO+gHixDxSQbLXD--
