From: Irina Riesen <irina.riesen@gmail.com>
Subject: [PATCH] git-gui: initial version of russian translation
Date: Sun, 22 Jul 2007 13:57:12 +0200
Message-ID: <20070722115712.GD3408@steel.home>
Reply-To: Irina Riesen <irina.riesen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	spearce@steel.home
X-From: git-owner@vger.kernel.org Sun Jul 22 13:57:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICa44-0000zu-0o
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 13:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267AbXGVL5R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Jul 2007 07:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755276AbXGVL5R
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 07:57:17 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:59705 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbXGVL5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 07:57:16 -0400
Received: from tigra.home (Fc8c3.f.strato-dslnet.de [195.4.200.195])
	by post.webmailer.de (fruni mo32) (RZmta 9.1)
	with ESMTP id V047a4j6M5WXqL ; Sun, 22 Jul 2007 13:57:14 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 426A7277BD;
	Sun, 22 Jul 2007 13:57:13 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 90D55BDD0; Sun, 22 Jul 2007 13:57:12 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+WOJg=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53252>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
Signed-off-by: Irina Riesen <irina.riesen@gmail.com>
---
 po/ru.po |  258 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 258 insertions(+), 0 deletions(-)
 create mode 100644 po/ru.po

diff --git a/po/ru.po b/po/ru.po
new file mode 100644
index 0000000..e73b8d0
--- /dev/null
+++ b/po/ru.po
@@ -0,0 +1,258 @@
+# Translation of git-gui to russian
+# Copyright (C) 2007 Shawn Pearce
+# This file is distributed under the same license as the git-gui packa=
ge.
+# Irina Riesen <irina.riesen@gmail.com>, 2007.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-07-21 20:31+0100\n"
+"PO-Revision-Date: 2007-07-22 12:00+0200\n"
+"Last-Translator: Irina Riesen <irina.riesen@gmail.com>\n"
+"Language-Team: Russian Translation <git@vger.kernel.org>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: git-gui.sh:1669
+msgid "Repository"
+msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
+
+#: git-gui.sh:1670
+msgid "Edit"
+msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C"
+
+#: git-gui.sh:1672
+msgid "Branch"
+msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C"
+
+#: git-gui.sh:1675 git-gui.sh:1853 git-gui.sh:2192
+msgid "Commit"
+msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C"
+
+#: git-gui.sh:1678
+msgid "Merge"
+msgstr "=D0=9E=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B8=D1=82=D1=8C"
+
+#: git-gui.sh:1679
+msgid "Fetch"
+msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C"
+
+#: git-gui.sh:1680 git-gui.sh:2198
+msgid "Push"
+msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
+
+#: git-gui.sh:1689
+msgid "Browse Current Branch's Files"
+msgstr "=D0=9F=D1=80=D0=BE=D0=BB=D0=B8=D1=81=D1=82=D0=B0=D1=82=D1=8C =D1=
=84=D0=B0=D0=B9=D0=BB=D1=8B =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B8=D0=B5=D0=
=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
+
+#: git-gui.sh:1698
+msgid "Visualize Current Branch's History"
+msgstr "=D0=98=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D1=82=D0=B5=D0=BA=D1=
=83=D1=89=D0=B5=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=BD=D0=B0=D0=B3=
=D0=BB=D1=8F=D0=B4=D0=BD=D0=BE"
+
+#: git-gui.sh:1702
+msgid "Visualize All Branch History"
+msgstr "=D0=98=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=B2=D1=81=D0=B5=D1=
=85 =D0=B2=D0=B5=D1=82=D0=B2=D0=B5=D0=B9 =D0=BD=D0=B0=D0=B3=D0=BB=D1=8F=
=D0=B4=D0=BD=D0=BE"
+
+#: git-gui.sh:1707
+msgid "Database Statistics"
+msgstr "=D0=A1=D1=82=D0=B0=D1=82=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B0 =D0=
=B1=D0=B0=D0=B7=D1=8B =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
+
+#: git-gui.sh:1710
+msgid "Compress Database"
+msgstr "=D0=A1=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=D0=B7=D1=83 =D0=B4=
=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
+
+#: git-gui.sh:1713
+msgid "Verify Database"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D1=8C =D0=B1=D0=
=B0=D0=B7=D1=83 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
+
+#: git-gui.sh:1720 git-gui.sh:1724 git-gui.sh:1728
+msgid "Create Desktop Icon"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D1=8F=D1=80=D0=BB=D1=
=8B=D0=BA =D0=BD=D0=B0 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D1=81=
=D1=82=D0=BE=D0=BB=D0=B5"
+
+#: git-gui.sh:1733
+msgid "Quit"
+msgstr "=D0=92=D1=8B=D1=85=D0=BE=D0=B4"
+
+#: git-gui.sh:1740
+msgid "Undo"
+msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C"
+
+#: git-gui.sh:1743
+msgid "Redo"
+msgstr "=D0=9F=D0=BE=D0=B2=D1=82=D0=BE=D1=80=D0=B8=D1=82=D1=8C"
+
+#: git-gui.sh:1747 git-gui.sh:2262
+msgid "Cut"
+msgstr "=D0=92=D1=8B=D1=80=D0=B5=D0=B7=D0=B0=D1=82=D1=8C"
+
+#: git-gui.sh:1750 git-gui.sh:2265 git-gui.sh:2336 git-gui.sh:2408
+msgid "Copy"
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C"
+
+#: git-gui.sh:1753 git-gui.sh:2268
+msgid "Paste"
+msgstr "=D0=92=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
+
+#: git-gui.sh:1756 git-gui.sh:2271
+msgid "Delete"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C"
+
+#: git-gui.sh:1760 git-gui.sh:2275 git-gui.sh:2412
+msgid "Select All"
+msgstr "=D0=92=D1=8B=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D1=81=D0=
=B5"
+
+#: git-gui.sh:1769
+msgid "Create..."
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C..."
+
+#: git-gui.sh:1775
+msgid "Checkout..."
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8..."
+
+#: git-gui.sh:1781
+msgid "Rename..."
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C..."
+
+#: git-gui.sh:1786 git-gui.sh:1884
+msgid "Delete..."
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C..."
+
+#: git-gui.sh:1791
+msgid "Reset..."
+msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C..."
+
+#: git-gui.sh:1803 git-gui.sh:2209
+msgid "New Commit"
+msgstr "=D0=9D=D0=BE=D0=B2=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D0=B5"
+
+#: git-gui.sh:1811 git-gui.sh:2216
+msgid "Amend Last Commit"
+msgstr "=D0=98=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=BF=D0=
=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+
+#: git-gui.sh:1820 git-gui.sh:2176
+msgid "Rescan"
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C"
+
+#: git-gui.sh:1826
+msgid "Add To Commit"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=BA =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+
+#: git-gui.sh:1831
+msgid "Add Existing To Commit"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=BC=D0=
=B5=D1=8E=D1=89=D0=B5=D0=B5=D1=81=D1=8F =D0=BA =D1=81=D0=BE=D1=81=D1=82=
=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+
+#: git-gui.sh:1837
+msgid "Unstage From Commit"
+msgstr "=D0=98=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=B8=D0=
=B7 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F"
+
+#: git-gui.sh:1842
+msgid "Revert Changes"
+msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+
+#: git-gui.sh:1849 git-gui.sh:2188 git-gui.sh:2286
+msgid "Sign Off"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C"
+
+#: git-gui.sh:1864
+msgid "Local Merge..."
+msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B5 =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5..."
+
+#: git-gui.sh:1869
+msgid "Abort Merge..."
+msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=B1=D1=
=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5..."
+
+#: git-gui.sh:1881
+msgid "Push..."
+msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C..."
+
+#: git-gui.sh:1891
+msgid "Apple"
+msgstr ""
+
+#: git-gui.sh:1894 git-gui.sh:1941
+#, tcl-format
+msgid "About %s"
+msgstr "=D0=9E %s"
+
+#: git-gui.sh:1896 git-gui.sh:1902 git-gui.sh:2454
+msgid "Options..."
+msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8..."
+
+#: git-gui.sh:1937
+msgid "Help"
+msgstr "=D0=9F=D0=BE=D0=BC=D0=BE=D1=89=D1=8C"
+
+#: git-gui.sh:1978
+msgid "Online Documentation"
+msgstr "=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=
=B8=D1=8F =D0=B2 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D0=BD=D0=B5=D1=82=D0=B5=
"
+
+#: git-gui.sh:2094
+msgid "Current Branch:"
+msgstr "=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B0=D1=8F =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C:"
+
+#: git-gui.sh:2115
+msgid "Staged Changes (Will Be Committed)"
+msgstr "=D0=92=D0=BA=D0=BB=D1=8E=D1=87=D0=B5=D0=BD=D0=BE (=D0=B1=D1=83=
=D0=B4=D0=B5=D1=82 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BE=
)"
+
+#: git-gui.sh:2135
+msgid "Unstaged Changes (Will Not Be Committed)"
+msgstr "=D0=98=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B5=D0=BD=D0=BE (=D0=BD=
=D0=B5 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=
=BD=D0=B5=D0=BD=D0=BE)"
+
+#: git-gui.sh:2182
+msgid "Add Existing"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=BC=D0=
=B5=D1=8E=D1=89=D0=B5=D0=B5=D1=81=D1=8F"
+
+#: git-gui.sh:2228
+msgid "Initial Commit Message:"
+msgstr "=D0=98=D0=B7=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=
=B9 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=B9 =
=D0=BA =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+
+#: git-gui.sh:2229
+msgid "Amended Commit Message:"
+msgstr "=D0=98=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=
=8B=D0=B9 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+
+#: git-gui.sh:2230
+msgid "Amended Initial Commit Message:"
+msgstr "=D0=98=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=
=8B=D0=B9 =D0=B8=D0=B7=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=
=B9 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=B9 =
=D0=BA =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+
+#: git-gui.sh:2231
+msgid "Amended Merge Commit Message:"
+msgstr "=D0=98=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=
=8B=D0=B9 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=
=D1=8E"
+
+#: git-gui.sh:2232
+msgid "Merge Commit Message:"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=
=D1=8E"
+
+#: git-gui.sh:2233
+msgid "Commit Message:"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+
+#: git-gui.sh:2278 git-gui.sh:2416
+msgid "Copy All"
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=
=B2=D1=81=D0=B5"
+
+#: git-gui.sh:2404
+msgid "Refresh"
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C"
+
+#: git-gui.sh:2425
+msgid "Apply/Reverse Hunk"
+msgstr "=D0=9F=D1=80=D0=B8=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C/=D0=9E=D1=
=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D1=87=D0=B0=D1=81=D1=82=D1=8C"
+
+#: git-gui.sh:2431
+msgid "Decrease Font Size"
+msgstr "=D0=A3=D0=BC=D0=B5=D0=BD=D1=8C=D1=88=D0=B8=D1=82=D1=8C =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=82=D0=B0"
+
+#: git-gui.sh:2435
+msgid "Increase Font Size"
+msgstr "=D0=A3=D0=B2=D0=B5=D0=BB=D0=B8=D1=87=D0=B8=D1=82=D1=8C =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=82=D0=B0"
+
+#: git-gui.sh:2440
+msgid "Show Less Context"
+msgstr "=D0=9C=D0=B5=D0=BD=D1=8C=D1=88=D0=B5 =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0"
+
+#: git-gui.sh:2447
+msgid "Show More Context"
+msgstr "=D0=91=D0=BE=D0=BB=D1=8C=D1=88=D0=B5 =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0"
--=20
1.5.3.rc2.37.g67fa
