From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 3/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 14:37:43 +0200
Message-ID: <200707211437.43524.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <200707211434.56622.stimming@tuhh.de> <200707211436.44672.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 14:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICEDL-00008J-3Y
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 14:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762420AbXGUMhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Jul 2007 08:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761875AbXGUMhg
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 08:37:36 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:36450 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321AbXGUMhf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 08:37:35 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6LCbSu2031270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 21 Jul 2007 14:37:28 +0200
Received: from [192.168.2.102] (p549012DA.dip0.t-ipconnect.de [84.144.18.218])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6LCbQJv007320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jul 2007 14:37:28 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <200707211436.44672.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53163>

=46rom 37241c4142c6bfe18e94a1891dbf1a9d1ee2953d Mon Sep 17 00:00:00 200=
1
=46rom: Christian Stimming <chs@ckiste.goetheallee>
Date: Sat, 21 Jul 2007 14:18:14 +0200
Subject: [PATCH] Initial German translation for testing of i18n.


Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
And a new German translation, so far 100% but many more strings are to =
come.

 po/de.po |  265 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 265 insertions(+), 0 deletions(-)
 create mode 100644 po/de.po

diff --git a/po/de.po b/po/de.po
new file mode 100644
index 0000000..0592836
--- /dev/null
+++ b/po/de.po
@@ -0,0 +1,265 @@
+# Translation of git-gui to German.
+# Copyright (C) 2007 Linux Torvalds
+# This file is distributed under the same license as the git package.
+# Christian Stimming <stimming@tuhh.de>, 2007
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-07-19 15:10+0200\n"
+"PO-Revision-Date: 2007-07-19 15:11+0200\n"
+"Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
+"Language-Team: German\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: git-gui.sh:1621
+msgid "Repository"
+msgstr "Projektarchiv"
+
+#: git-gui.sh:1622
+msgid "Edit"
+msgstr "Bearbeiten"
+
+#: git-gui.sh:1624
+msgid "Branch"
+msgstr "Zweig"
+
+#: git-gui.sh:1627 git-gui.sh:1802 git-gui.sh:2134
+msgid "Commit"
+msgstr "=DCbertragen"
+
+#: git-gui.sh:1630
+msgid "Merge"
+msgstr "Zusammenf=FChren"
+
+#: git-gui.sh:1631
+msgid "Fetch"
+msgstr "Holen"
+
+#: git-gui.sh:1632 git-gui.sh:2140
+msgid "Push"
+msgstr "Schieben"
+
+#: git-gui.sh:1641
+msgid "Browse Current Branch"
+msgstr "Aktuellen Zweig durchbl=E4ttern"
+
+#: git-gui.sh:1647
+msgid "Visualize Current Branch"
+msgstr "Aktuellen Zweig darstellen"
+
+#: git-gui.sh:1651
+msgid "Visualize All Branches"
+msgstr "Alle Zweige darstellen"
+
+#: git-gui.sh:1656
+msgid "Database Statistics"
+msgstr "Datenbankstatistik"
+
+#: git-gui.sh:1659
+msgid "Compress Database"
+msgstr "Datenbank komprimieren"
+
+#: git-gui.sh:1662
+msgid "Verify Database"
+msgstr "Datenbank pr=FCfen"
+
+#: git-gui.sh:1669 git-gui.sh:1673 git-gui.sh:1677
+msgid "Create Desktop Icon"
+msgstr "Desktop-Icon erstellen"
+
+#: git-gui.sh:1682
+msgid "Quit"
+msgstr "Beenden"
+
+#: git-gui.sh:1689
+msgid "Undo"
+msgstr "R=FCckg=E4ngig"
+
+#: git-gui.sh:1692
+msgid "Redo"
+msgstr "Wiederholen"
+
+#: git-gui.sh:1696 git-gui.sh:2204
+msgid "Cut"
+msgstr "Ausschneiden"
+
+#: git-gui.sh:1699 git-gui.sh:2207 git-gui.sh:2278 git-gui.sh:2350
+msgid "Copy"
+msgstr "Kopieren"
+
+#: git-gui.sh:1702 git-gui.sh:2210
+msgid "Paste"
+msgstr "Einf=FCgen"
+
+#: git-gui.sh:1705 git-gui.sh:2213
+msgid "Delete"
+msgstr "L=F6schen"
+
+#: git-gui.sh:1709 git-gui.sh:2217 git-gui.sh:2354
+msgid "Select All"
+msgstr "Alle ausw=E4hlen"
+
+#: git-gui.sh:1718
+msgid "Create..."
+msgstr "Erstellen..."
+
+#: git-gui.sh:1724
+msgid "Checkout..."
+msgstr "Auschecken..."
+
+#: git-gui.sh:1730
+msgid "Rename..."
+msgstr "Umbenennen..."
+
+#: git-gui.sh:1735 git-gui.sh:1833
+msgid "Delete..."
+msgstr "L=F6schen..."
+
+#: git-gui.sh:1740
+msgid "Reset..."
+msgstr "Zur=FCcksetzen..."
+
+#: git-gui.sh:1752 git-gui.sh:2151
+msgid "New Commit"
+msgstr "Neu =FCbertragen"
+
+#: git-gui.sh:1760 git-gui.sh:2158
+msgid "Amend Last Commit"
+msgstr "Letzte =DCbertragung erg=E4nzen"
+
+#: git-gui.sh:1769 git-gui.sh:2118
+msgid "Rescan"
+msgstr "Neu laden"
+
+#: git-gui.sh:1775
+msgid "Add To Commit"
+msgstr "Zur Bereitstellung hinzuf=FCgen"
+
+#: git-gui.sh:1780
+msgid "Add Existing To Commit"
+msgstr "Existierendes zur Bereitstellung hinzuf=FCgen"
+
+#: git-gui.sh:1786
+msgid "Unstage From Commit"
+msgstr "Aus der Bereitstellung herausnehmen"
+
+#: git-gui.sh:1791
+msgid "Revert Changes"
+msgstr "=C4nderungen verwerfen"
+
+#: git-gui.sh:1798 git-gui.sh:2130 git-gui.sh:2228
+msgid "Sign Off"
+msgstr "Freizeichnen"
+
+#: git-gui.sh:1813
+msgid "Local Merge..."
+msgstr "Lokales Zusammenf=FChren..."
+
+#: git-gui.sh:1817
+msgid "Abort Merge..."
+msgstr "Zusammenf=FChren abbrechen..."
+
+#: git-gui.sh:1830
+msgid "Push..."
+msgstr "Schieben..."
+
+#: git-gui.sh:1840
+msgid "Apple"
+msgstr "Apple"
+
+#: git-gui.sh:1843 git-gui.sh:1888
+#, tcl-format
+msgid "About %s"
+msgstr "=DCber %s"
+
+#: git-gui.sh:1845 git-gui.sh:1851 git-gui.sh:2396
+msgid "Options..."
+msgstr "Optionen..."
+
+#: git-gui.sh:1873
+msgid "Tools"
+msgstr "Werkzeuge"
+
+#: git-gui.sh:1875
+msgid "Migrate"
+msgstr "Migrieren"
+
+#: git-gui.sh:1884
+msgid "Help"
+msgstr "Hilfe"
+
+#: git-gui.sh:1925
+msgid "Online Documentation"
+msgstr "Online-Dokumentation"
+
+#: git-gui.sh:2036
+msgid "Current Branch:"
+msgstr "Aktueller Zweig:"
+
+#: git-gui.sh:2057
+msgid "Staged Changes (Will Be Committed)"
+msgstr "Bereitgestellte =C4nderungen (werden =FCbertragen)"
+
+#: git-gui.sh:2077
+msgid "Unstaged Changes (Will Not Be Committed)"
+msgstr "Nicht bereitgestellte =C4nderungen (werden nicht =FCbertragen)=
"
+
+#: git-gui.sh:2124
+msgid "Add Existing"
+msgstr "Existierendes hinzuf=FCgen"
+
+#: git-gui.sh:2170
+msgid "Initial Commit Message:"
+msgstr "Erstmalige =DCbertragungsmeldung"
+
+#: git-gui.sh:2171
+msgid "Amended Commit Message:"
+msgstr "Zur =DCbertragungsmeldung hinzuf=FCgen:"
+
+#: git-gui.sh:2172
+msgid "Amended Initial Commit Message:"
+msgstr "Zur erstmaligen =DCbertragungsmeldung hinzuf=FCgen:"
+
+#: git-gui.sh:2173
+msgid "Amended Merge Commit Message:"
+msgstr "Zur Zusammenf=FChrungs-=DCbertragungsmeldung hinzuf=FCgen:"
+
+#: git-gui.sh:2174
+msgid "Merge Commit Message:"
+msgstr "=DCbertragungsmeldung Zusammenf=FChrung:"
+
+#: git-gui.sh:2175
+msgid "Commit Message:"
+msgstr "=DCbertragungsmeldung:"
+
+#: git-gui.sh:2220 git-gui.sh:2358
+msgid "Copy All"
+msgstr "Alle kopieren"
+
+#: git-gui.sh:2346
+msgid "Refresh"
+msgstr "Aktualisieren"
+
+#: git-gui.sh:2367
+msgid "Apply/Reverse Hunk"
+msgstr "=C4nderung anwenden/umkehren"
+
+#: git-gui.sh:2373
+msgid "Decrease Font Size"
+msgstr "Schriftgr=F6=DFe verkleinern"
+
+#: git-gui.sh:2377
+msgid "Increase Font Size"
+msgstr "Schriftgr=F6=DFe vergr=F6=DFern"
+
+#: git-gui.sh:2382
+msgid "Show Less Context"
+msgstr "Weniger Kontext anzeigen"
+
+#: git-gui.sh:2389
+msgid "Show More Context"
+msgstr "Mehr Kontext anzeigen"
--=20
1.5.2
