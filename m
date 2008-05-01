From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] git-gui: Update German translation
Date: Thu, 1 May 2008 11:54:00 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200805011154.00427.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4MZGItaVN2QW3mD"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 01 12:53:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrWPL-0002AW-G1
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 12:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656AbYEAKwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 06:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbYEAKwJ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 06:52:09 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:51544 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbYEAKwH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 06:52:07 -0400
X-Greylist: delayed 3477 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 May 2008 06:52:06 EDT
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m419s2Kj007031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 1 May 2008 11:54:03 +0200
Received: from [192.168.2.102] (p549025F5.dip0.t-ipconnect.de [84.144.37.245])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m419s1Qb008190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 May 2008 11:54:02 +0200
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80898>

--Boundary-00=_4MZGItaVN2QW3mD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached to avoid whitespace problems. This patch is against current master of 
git-gui.git at repo.or.cz. Thanks a lot.

Christian

--Boundary-00=_4MZGItaVN2QW3mD
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-git-gui-Update-German-translation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-git-gui-Update-German-translation.patch"

=46rom 716be46515adc80cb70dedf25730721311e745c1 Mon Sep 17 00:00:00 2001
=46rom: Christian Stimming <stimming@tuhh.de>
Date: Thu, 1 May 2008 11:51:47 +0200
Subject: [PATCH] git-gui: Update German translation

=2D--
 po/de.po |   26 +++++++++-----------------
 1 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/po/de.po b/po/de.po
index 022b816..f20955c 100644
=2D-- a/po/de.po
+++ b/po/de.po
@@ -8,7 +8,7 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2008-03-14 07:18+0100\n"
=2D"PO-Revision-Date: 2008-02-16 21:52+0100\n"
+"PO-Revision-Date: 2008-05-01 11:51+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -1754,9 +1754,8 @@ msgid "Number of Diff Context Lines"
 msgstr "Anzahl der Kontextzeilen beim Vergleich"
=20
 #: lib/option.tcl:127
=2D#, fuzzy
 msgid "Commit Message Text Width"
=2Dmsgstr "Versionsbeschreibung:"
+msgstr "Textbreite der Versionsbeschreibung"
=20
 #: lib/option.tcl:128
 msgid "New Branch Name Template"
@@ -1895,40 +1894,36 @@ msgstr "Fehler beim Erstellen des Icons:"
=20
 #: lib/spellcheck.tcl:57
 msgid "Unsupported spell checker"
=2Dmsgstr ""
+msgstr "Rechtschreibpr=C3=BCfungsprogramm nicht unterst=C3=BCtzt"
=20
 #: lib/spellcheck.tcl:65
=2D#, fuzzy
 msgid "Spell checking is unavailable"
=2Dmsgstr "Rechtschreibpr=C3=BCfung fehlgeschlagen"
+msgstr "Rechtschreibpr=C3=BCfung nicht verf=C3=BCgbar"
=20
 #: lib/spellcheck.tcl:68
 msgid "Invalid spell checking configuration"
=2Dmsgstr ""
+msgstr "Unbenutzbare Konfiguration der Rechtschreibpr=C3=BCfung"
=20
 #: lib/spellcheck.tcl:70
 #, tcl-format
 msgid "Reverting dictionary to %s."
=2Dmsgstr ""
+msgstr "W=C3=B6rterbuch auf %s zur=C3=BCckgesetzt."
=20
 #: lib/spellcheck.tcl:73
=2D#, fuzzy
 msgid "Spell checker silently failed on startup"
=2Dmsgstr "Rechtschreibpr=C3=BCfung fehlgeschlagen"
+msgstr "Rechtschreibpr=C3=BCfungsprogramm mit Fehler abgebrochen"
=20
 #: lib/spellcheck.tcl:80
=2D#, fuzzy
 msgid "Unrecognized spell checker"
=2Dmsgstr "Unbekannte Version von =C2=BBaspell=C2=AB"
+msgstr "Unbekanntes Rechtschreibpr=C3=BCfungsprogramm"
=20
 #: lib/spellcheck.tcl:180
 msgid "No Suggestions"
 msgstr "Keine Vorschl=C3=A4ge"
=20
 #: lib/spellcheck.tcl:381
=2D#, fuzzy
 msgid "Unexpected EOF from spell checker"
=2Dmsgstr "Unerwartetes EOF von =C2=BBaspell=C2=AB"
+msgstr "Unerwartetes EOF vom Rechtschreibpr=C3=BCfungsprogramm"
=20
 #: lib/spellcheck.tcl:385
 msgid "Spell Checker Failed"
@@ -2002,6 +1997,3 @@ msgstr "Kompaktes Datenformat benutzen (f=C3=BCr lang=
same Netzverbindungen)"
 #: lib/transport.tcl:168
 msgid "Include tags"
 msgstr "Mit Markierungen =C3=BCbertragen"
=2D
=2D#~ msgid "Not connected to aspell"
=2D#~ msgstr "Keine Verbindung zu =C2=BBaspell=C2=AB"
=2D-=20
1.5.4.2.133.g3d51e


--Boundary-00=_4MZGItaVN2QW3mD--
