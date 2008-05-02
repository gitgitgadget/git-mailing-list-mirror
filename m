From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk: German translation again updated
Date: Fri, 2 May 2008 21:36:32 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200805022136.32372.stimming@tuhh.de>
References: <200805012142.10151.stimming@tuhh.de> <20080501211004.GE7868@leksak.fem-net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_A12GIAI4SxO9SHZ"
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri May 02 22:26:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js1pU-0002QE-0O
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 22:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763634AbYEBUZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 16:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757997AbYEBUZP
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 16:25:15 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:56513 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219AbYEBUZN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 16:25:13 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m42KP9El022385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 2 May 2008 22:25:09 +0200
Received: from [192.168.2.102] (p5490016D.dip0.t-ipconnect.de [84.144.1.109])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m42KP7di020084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 May 2008 22:25:09 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20080501211004.GE7868@leksak.fem-net>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81033>

--Boundary-00=_A12GIAI4SxO9SHZ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This includes the fixed typos and proposals by Stephan Beyer that were easy to 
agree upon.

This patch is to be committed on top of yesterday's German translation patch.

Regards,

Christian

(Attached because of whitespace yadda yadda)

--Boundary-00=_A12GIAI4SxO9SHZ
Content-Type: text/x-diff;
  charset="utf-8";
  name="0001-gitk-German-translation-again-updated.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-gitk-German-translation-again-updated.patch"

=46rom 980528caeee6565fe477e87b90dfde79a4f29416 Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Fri, 2 May 2008 21:33:34 +0200
Subject: [PATCH] gitk: German translation again updated

This includes suggestions by Stephan Beyer.
=2D--
 po/de.po |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/po/de.po b/po/de.po
index 58b342a..b9867bf 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -8,7 +8,7 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2008-05-01 11:54+0200\n"
=2D"PO-Revision-Date: 2008-05-01 21:32+0200\n"
+"PO-Revision-Date: 2008-05-02 21:12+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -29,7 +29,7 @@ msgstr "Versionen lesen..."
=20
 #: gitk:275
 msgid "Can't parse git log output:"
=2Dmsgstr "Git log Ausgabe kann nicht erkannt werden:"
+msgstr "Ausgabe von git-log kann nicht erkannt werden:"
=20
 #: gitk:386 gitk:2195
 msgid "No commits selected"
@@ -62,7 +62,7 @@ msgstr "Zweige neu laden"
=20
 #: gitk:665
 msgid "List references"
=2Dmsgstr "Zweige auflisten"
+msgstr "Zweige/Markierungen auflisten"
=20
 #: gitk:666
 msgid "Quit"
@@ -138,7 +138,7 @@ msgstr "Pfad betreffend:"
=20
 #: gitk:801 gitk:2436
 msgid "adding/removing string:"
=2Dmsgstr "String dazu/l=C3=B6schen:"
+msgstr "Zeichenkette =C3=A4ndernd:"
=20
 #: gitk:810 gitk:812
 msgid "Exact"
@@ -306,11 +306,11 @@ msgstr "<Runter>, n, k\tN=C3=A4chste =C3=A4ltere Vers=
ion"
=20
 #: gitk:1354
 msgid "<Left>, z, j\tGo back in history list"
=2Dmsgstr "<Links>, z, j\tEine Version zur=C3=BCck gehen"
+msgstr "<Links>, z, j\tEine Version zur=C3=BCckgehen"
=20
 #: gitk:1355
 msgid "<Right>, x, l\tGo forward in history list"
=2Dmsgstr "<Rechts>, x, l\tEine Version nach vorne gehen"
+msgstr "<Rechts>, x, l\tEine Version weitergehen"
=20
 #: gitk:1356
 msgid "<PageUp>\tMove up one page in commit list"
@@ -540,17 +540,17 @@ msgstr "Gehe zu:"
=20
 #: gitk:5781
 msgid "SHA1 ID:"
=2Dmsgstr "SHA1 Kennung:"
+msgstr "SHA1-Hashwert:"
=20
 #: gitk:5806
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
=2Dmsgstr "Kurze SHA1-Kennung =C2=BB%s=C2=AB ist mehrdeutig"
+msgstr "Kurzer SHA1-Hashwert =C2=BB%s=C2=AB ist mehrdeutig"
=20
 #: gitk:5818
 #, tcl-format
 msgid "SHA1 id %s is not known"
=2Dmsgstr "SHA1-Kennung =C2=BB%s=C2=AB unbekannt"
+msgstr "SHA1-Hashwert =C2=BB%s=C2=AB unbekannt"
=20
 #: gitk:5820
 #, tcl-format
@@ -641,7 +641,7 @@ msgstr "Schreiben"
=20
 #: gitk:6291
 msgid "Error writing commit:"
=2Dmsgstr "Fehler beim Version eintragen:"
+msgstr "Fehler beim Schreiben der Version:"
=20
 #: gitk:6317
 msgid "Name:"
@@ -780,7 +780,7 @@ msgstr "Lokale =C3=84nderungen anzeigen"
=20
 #: gitk:8024
 msgid "Auto-select SHA1"
=2Dmsgstr "SHA1 Hashwert automatisch markieren"
+msgstr "SHA1-Hashwert automatisch markieren"
=20
 #: gitk:8029
 msgid "Diff display options"
@@ -804,11 +804,11 @@ msgstr "Farben: Klicken zum W=C3=A4hlen"
=20
 #: gitk:8048
 msgid "Background"
=2Dmsgstr "Vordergrund"
+msgstr "Hintergrund"
=20
 #: gitk:8052
 msgid "Foreground"
=2Dmsgstr "Hintergrund"
+msgstr "Vordergrund"
=20
 #: gitk:8056
 msgid "Diff: old lines"
@@ -879,9 +879,7 @@ msgstr "Liste der nicht-zusammengef=C3=BChrten Dateien =
nicht gefunden:"
=20
 #: gitk:8653
 msgid "No files selected: --merge specified but no files are unmerged."
=2Dmsgstr ""
=2D"Keine Dateien ausgew=C3=A4hle: --merge angegeben, es existieren aber ke=
ine nicht-"
=2D"zusammengef=C3=BChrten Dateien."
+msgstr "Keine Dateien ausgew=C3=A4hlt: --merge angegeben, es existieren ab=
er keine nicht-zusammengef=C3=BChrten Dateien."
=20
 #: gitk:8656
 msgid ""
=2D-=20
1.5.4.2.133.g3d51e


--Boundary-00=_A12GIAI4SxO9SHZ--
