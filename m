From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 3/3] git-gui: update russian translation
Date: Mon, 17 Jan 2011 22:08:55 +0100
Message-ID: <20110117210855.GD27029@blimp.localdomain>
References: <cover.1295295897.git.raa.lkml@gmail.com> <1c96343bbf6fb30e7453c3df7b49ea31667e0469.1295295897.git.raa.lkml@gmail.com> <eeaaba6d48de958b374cb06f1b12db3b8e0550ea.1295295897.git.raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Serge Ziryukin <ftrvxmtrx@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 17 22:09:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PewK9-00032E-5i
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 22:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab1AQVJF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jan 2011 16:09:05 -0500
Received: from mout7.freenet.de ([195.4.92.97]:34313 "EHLO mout7.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752131Ab1AQVJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jan 2011 16:09:04 -0500
Received: from [195.4.92.26] (helo=16.mx.freenet.de)
	by mout7.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #3)
	id 1PewJv-0001Ef-QW; Mon, 17 Jan 2011 22:08:59 +0100
Received: from krlh-5f7212ec.pool.mediaways.net ([95.114.18.236]:59879 helo=tigra.home)
	by 16.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1PewJs-0003ex-5p; Mon, 17 Jan 2011 22:08:59 +0100
Received: from blimp.localdomain (unknown [192.168.0.94])
	by tigra.home (Postfix) with ESMTP id 62D779FE26;
	Mon, 17 Jan 2011 22:08:55 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 4E47D36D28; Mon, 17 Jan 2011 22:08:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <eeaaba6d48de958b374cb06f1b12db3b8e0550ea.1295295897.git.raa.lkml@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165183>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 po/ru.po |  595 ++++++++++++++++++++++++++++++++----------------------=
--------
 1 files changed, 307 insertions(+), 288 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index 304bb3a..7071a8c 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -7,7 +7,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-12-08 08:31-0800\n"
+"POT-Creation-Date: 2010-01-26 15:47-0800\n"
 "PO-Revision-Date: 2007-10-22 22:30-0200\n"
 "Last-Translator: Alex Riesen <raa.lkml@gmail.com>\n"
 "Language-Team: Russian Translation <git@vger.kernel.org>\n"
@@ -15,33 +15,33 @@ msgstr ""
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: git-gui.sh:41 git-gui.sh:737 git-gui.sh:751 git-gui.sh:764 git-gui.=
sh:847
-#: git-gui.sh:866
+#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.=
sh:903
+#: git-gui.sh:922
 msgid "git-gui: fatal error"
 msgstr "git-gui: =D0=BA=D1=80=D0=B8=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=
=D0=B0=D1=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0"
=20
-#: git-gui.sh:689
+#: git-gui.sh:743
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "=D0=92 %s =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=
=D0=BD =D0=BD=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D1=8B=D0=B9 =D1=88=D1=80=D0=
=B8=D1=84=D1=82:"
=20
-#: git-gui.sh:723
+#: git-gui.sh:779
 msgid "Main Font"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D1=
=84=D0=B5=D0=B9=D1=81=D0=B0"
=20
-#: git-gui.sh:724
+#: git-gui.sh:780
 msgid "Diff/Console Font"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=BA=D0=BE=D0=BD=D1=81=D0=BE=D0=
=BB=D0=B8 =D0=B8 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9=
 (diff)"
=20
-#: git-gui.sh:738
+#: git-gui.sh:794
 msgid "Cannot find git in PATH."
 msgstr "git =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD =D0=B2 P=
ATH."
=20
-#: git-gui.sh:765
+#: git-gui.sh:821
 msgid "Cannot parse Git version string:"
 msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D1=
=80=D0=B0=D1=81=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D1=8C =D1=81=D1=82=D1=
=80=D0=BE=D0=BA=D1=83 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D0=B8 Git: "
=20
-#: git-gui.sh:783
+#: git-gui.sh:839
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -60,450 +60,474 @@ msgstr ""
 "\n"
 "=D0=9F=D1=80=D0=B8=D0=BD=D1=8F=D1=82=D1=8C '%s' =D0=BA=D0=B0=D0=BA =D0=
=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E 1.5.0?\n"
=20
-#: git-gui.sh:1062
+#: git-gui.sh:1128
 msgid "Git directory not found:"
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 Git =D0=BD=D0=B5 =D0=
=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD:"
=20
-#: git-gui.sh:1069
+#: git-gui.sh:1146
 msgid "Cannot move to top of working directory:"
 msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=BF=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BA=D0=BE=D1=80=D0=BD=
=D1=8E =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=
=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B0 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D1=8F: "
=20
-#: git-gui.sh:1076
-msgid "Cannot use funny .git directory:"
-msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 .git =D0=B8=D1=81=D0=
=BF=D0=BE=D1=80=D1=87=D0=B5=D0=BD: "
+#: git-gui.sh:1154
+msgid "Cannot use bare repository:"
+msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=
=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =
=D0=B1=D0=B5=D0=B7 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=
=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B0:"
=20
-#: git-gui.sh:1081
+#: git-gui.sh:1162
 msgid "No working directory"
 msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=
=82 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=
=D0=BB=D0=BE=D0=B3"
=20
-#: git-gui.sh:1247 lib/checkout_op.tcl:305
+#: git-gui.sh:1334 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D0=B8 =D0=BE =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=BE=D0=B2..."
=20
-#: git-gui.sh:1303
+#: git-gui.sh:1390
 msgid "Scanning for modified files ..."
 msgstr "=D0=9F=D0=BE=D0=B8=D1=81=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=
=B5=D0=BD=D0=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2..."
=20
-#: git-gui.sh:1367
+#: git-gui.sh:1454
 msgid "Calling prepare-commit-msg hook..."
 msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D1=8B =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=
=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =
prepare-commit-msg..."
=20
-#: git-gui.sh:1384
+#: git-gui.sh:1471
 msgid "Commit declined by prepare-commit-msg hook."
 msgstr ""
 "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=
=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=
=8F prepare-commit-msg"
=20
-#: git-gui.sh:1542 lib/browser.tcl:246
+#: git-gui.sh:1629 lib/browser.tcl:246
 msgid "Ready."
 msgstr "=D0=93=D0=BE=D1=82=D0=BE=D0=B2=D0=BE."
=20
-#: git-gui.sh:1726
+#: git-gui.sh:1787
 #, tcl-format
 msgid "Displaying only %s of %s files."
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE %s =D0=B8=D0=B7=
 %s =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2."
=20
-#: git-gui.sh:1819
+#: git-gui.sh:1913
 msgid "Unmodified"
 msgstr "=D0=9D=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE"
=20
-#: git-gui.sh:1821
+#: git-gui.sh:1915
 msgid "Modified, not staged"
 msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE, =D0=BD=D0=B5=
 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE=
"
=20
-#: git-gui.sh:1822 git-gui.sh:1830
+#: git-gui.sh:1916 git-gui.sh:1924
 msgid "Staged for commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:1823 git-gui.sh:1831
+#: git-gui.sh:1917 git-gui.sh:1925
 msgid "Portions staged for commit"
 msgstr "=D0=A7=D0=B0=D1=81=D1=82=D0=B8, =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=
=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B4=D0=BB=D1=8F=
 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:1824 git-gui.sh:1832
+#: git-gui.sh:1918 git-gui.sh:1926
 msgid "Staged for commit, missing"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8F, =D0=BE=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=
=83=D0=B5=D1=82"
=20
-#: git-gui.sh:1826
+#: git-gui.sh:1920
 msgid "File type changed, not staged"
 msgstr "=D0=A2=D0=B8=D0=BF =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D1=91=D0=BD, =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B3=D0=
=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE"
=20
-#: git-gui.sh:1827
+#: git-gui.sh:1921
 msgid "File type changed, staged"
 msgstr "=D0=A2=D0=B8=D0=BF =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D1=91=D0=BD, =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=
=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE"
=20
-#: git-gui.sh:1829
+#: git-gui.sh:1923
 msgid "Untracked, not staged"
 msgstr "=D0=9D=D0=B5 =D0=BE=D1=82=D1=81=D0=BB=D0=B5=D0=B6=D0=B8=D0=B2=D0=
=B0=D0=B5=D1=82=D1=81=D1=8F, =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=
=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE"
=20
-#: git-gui.sh:1834
+#: git-gui.sh:1928
 msgid "Missing"
 msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=
=82"
=20
-#: git-gui.sh:1835
+#: git-gui.sh:1929
 msgid "Staged for removal"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=
=D1=8F"
=20
-#: git-gui.sh:1836
+#: git-gui.sh:1930
 msgid "Staged for removal, still present"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=
=D1=8F, =D0=B5=D1=89=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=
=BD=D0=BE"
=20
-#: git-gui.sh:1838 git-gui.sh:1839 git-gui.sh:1840 git-gui.sh:1841
-#: git-gui.sh:1842 git-gui.sh:1843
+#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
+#: git-gui.sh:1936 git-gui.sh:1937
 msgid "Requires merge resolution"
 msgstr "=D0=A2=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=D1=8F =D1=80=D0=
=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BA=D0=BE=D0=BD=D1=
=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B0 =D0=BF=D1=80=D0=B8 =D1=81=D0=BB=D0=B8=
=D1=8F=D0=BD=D0=B8=D0=B8"
=20
-#: git-gui.sh:1878
+#: git-gui.sh:1972
 msgid "Starting gitk... please wait..."
 msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=BA=D0=B0=D0=B5=D1=82=D1=81=D1=
=8F gitk... =D0=9F=D0=BE=D0=B4=D0=BE=D0=B6=D0=B4=D0=B8=D1=82=D0=B5, =D0=
=BF=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0..."
=20
-#: git-gui.sh:1887
+#: git-gui.sh:1984
 msgid "Couldn't find gitk in PATH"
 msgstr "gitk =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD =D0=B2 =
PATH."
=20
-#: git-gui.sh:2280 lib/choose_repository.tcl:36
+#: git-gui.sh:2043
+msgid "Couldn't find git gui in PATH"
+msgstr "git gui =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD =D0=B2=
 PATH."
+
+#: git-gui.sh:2455 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
-#: git-gui.sh:2281
+#: git-gui.sh:2456
 msgid "Edit"
 msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C"
=20
-#: git-gui.sh:2283 lib/choose_rev.tcl:561
+#: git-gui.sh:2458 lib/choose_rev.tcl:561
 msgid "Branch"
 msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C"
=20
-#: git-gui.sh:2286 lib/choose_rev.tcl:548
+#: git-gui.sh:2461 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
 msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
=20
-#: git-gui.sh:2289 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
+#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "=D0=A1=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5"
=20
-#: git-gui.sh:2290 lib/choose_rev.tcl:557
+#: git-gui.sh:2465 lib/choose_rev.tcl:557
 msgid "Remote"
 msgstr "=D0=92=D0=BD=D0=B5=D1=88=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8"
=20
-#: git-gui.sh:2293
+#: git-gui.sh:2468
 msgid "Tools"
 msgstr "=D0=92=D1=81=D0=BF=D0=BE=D0=BC=D0=BE=D0=B3=D0=B0=D1=82=D0=B5=D0=
=BB=D1=8C=D0=BD=D1=8B=D0=B5 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=
=B8"
=20
-#: git-gui.sh:2302
+#: git-gui.sh:2477
 msgid "Explore Working Copy"
 msgstr "=D0=9F=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80 =D1=80=D0=B0=D0=
=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=
=B3=D0=B0"
=20
-#: git-gui.sh:2307
+#: git-gui.sh:2483
 msgid "Browse Current Branch's Files"
 msgstr "=D0=9F=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B5=D1=82=D1=
=8C =D1=84=D0=B0=D0=B9=D0=BB=D1=8B =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=
=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
=20
-#: git-gui.sh:2311
+#: git-gui.sh:2487
 msgid "Browse Branch Files..."
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8..."
=20
-#: git-gui.sh:2316
+#: git-gui.sh:2492
 msgid "Visualize Current Branch's History"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9 =
=D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
=20
-#: git-gui.sh:2320
+#: git-gui.sh:2496
 msgid "Visualize All Branch History"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D0=B2=D1=81=D0=B5=D1=85 =D0=B2=D0=B5=D1=82=
=D0=B2=D0=B5=D0=B9"
=20
-#: git-gui.sh:2327
+#: git-gui.sh:2503
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 %s"
=20
-#: git-gui.sh:2329
+#: git-gui.sh:2505
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 %s"
=20
-#: git-gui.sh:2334 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "=D0=A1=D1=82=D0=B0=D1=82=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B0 =D0=
=B1=D0=B0=D0=B7=D1=8B =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
=20
-#: git-gui.sh:2337 lib/database.tcl:34
+#: git-gui.sh:2513 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "=D0=A1=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=D0=B7=D1=83 =D0=B4=
=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
=20
-#: git-gui.sh:2340
+#: git-gui.sh:2516
 msgid "Verify Database"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D1=8C =D0=B1=D0=
=B0=D0=B7=D1=83 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
=20
-#: git-gui.sh:2347 git-gui.sh:2351 git-gui.sh:2355 lib/shortcut.tcl:7
-#: lib/shortcut.tcl:39 lib/shortcut.tcl:71
+#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
+#: lib/shortcut.tcl:40 lib/shortcut.tcl:72
 msgid "Create Desktop Icon"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D1=8F=D1=80=D0=BB=D1=
=8B=D0=BA =D0=BD=D0=B0 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D1=81=
=D1=82=D0=BE=D0=BB=D0=B5"
=20
-#: git-gui.sh:2363 lib/choose_repository.tcl:183 lib/choose_repository=
=2Etcl:191
+#: git-gui.sh:2539 lib/choose_repository.tcl:183 lib/choose_repository=
=2Etcl:191
 msgid "Quit"
 msgstr "=D0=92=D1=8B=D1=85=D0=BE=D0=B4"
=20
-#: git-gui.sh:2371
+#: git-gui.sh:2547
 msgid "Undo"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:2374
+#: git-gui.sh:2550
 msgid "Redo"
 msgstr "=D0=9F=D0=BE=D0=B2=D1=82=D0=BE=D1=80=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:2378 git-gui.sh:2937
+#: git-gui.sh:2554 git-gui.sh:3109
 msgid "Cut"
 msgstr "=D0=92=D1=8B=D1=80=D0=B5=D0=B7=D0=B0=D1=82=D1=8C"
=20
-#: git-gui.sh:2381 git-gui.sh:2940 git-gui.sh:3014 git-gui.sh:3096
+#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C"
=20
-#: git-gui.sh:2384 git-gui.sh:2943
+#: git-gui.sh:2560 git-gui.sh:3115
 msgid "Paste"
 msgstr "=D0=92=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:2387 git-gui.sh:2946 lib/branch_delete.tcl:26
+#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:2391 git-gui.sh:2950 git-gui.sh:3100 lib/console.tcl:71
+#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
 msgid "Select All"
 msgstr "=D0=92=D1=8B=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D1=81=D0=
=B5"
=20
-#: git-gui.sh:2400
+#: git-gui.sh:2576
 msgid "Create..."
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C..."
=20
-#: git-gui.sh:2406
+#: git-gui.sh:2582
 msgid "Checkout..."
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8..."
=20
-#: git-gui.sh:2412
+#: git-gui.sh:2588
 msgid "Rename..."
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C..."
=20
-#: git-gui.sh:2417
+#: git-gui.sh:2593
 msgid "Delete..."
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C..."
=20
-#: git-gui.sh:2422
+#: git-gui.sh:2598
 msgid "Reset..."
 msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C..."
=20
-#: git-gui.sh:2432
+#: git-gui.sh:2608
 msgid "Done"
 msgstr "=D0=97=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=BE"
=20
-#: git-gui.sh:2434
+#: git-gui.sh:2610
 msgid "Commit@@verb"
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:2443 git-gui.sh:2878
+#: git-gui.sh:2619 git-gui.sh:3050
 msgid "New Commit"
 msgstr "=D0=9D=D0=BE=D0=B2=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D0=B5"
=20
-#: git-gui.sh:2451 git-gui.sh:2885
+#: git-gui.sh:2627 git-gui.sh:3057
 msgid "Amend Last Commit"
 msgstr "=D0=98=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=BF=D0=
=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B5"
=20
-#: git-gui.sh:2461 git-gui.sh:2839 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C"
=20
-#: git-gui.sh:2467
+#: git-gui.sh:2643
 msgid "Stage To Commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=
=D0=B8=D1=8F"
=20
-#: git-gui.sh:2473
+#: git-gui.sh:2649
 msgid "Stage Changed Files To Commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D1=84=
=D0=B0=D0=B9=D0=BB=D1=8B =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=
=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:2479
+#: git-gui.sh:2655
 msgid "Unstage From Commit"
 msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=B8=D0=B7 =D0=BF=D0=BE=
=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=
=D0=BE"
=20
-#: git-gui.sh:2484 lib/index.tcl:410
+#: git-gui.sh:2661 lib/index.tcl:412
 msgid "Revert Changes"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:2491 git-gui.sh:3083
+#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
 msgid "Show Less Context"
 msgstr "=D0=9C=D0=B5=D0=BD=D1=8C=D1=88=D0=B5 =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0"
=20
-#: git-gui.sh:2495 git-gui.sh:3087
+#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
 msgid "Show More Context"
 msgstr "=D0=91=D0=BE=D0=BB=D1=8C=D1=88=D0=B5 =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0"
=20
-#: git-gui.sh:2502 git-gui.sh:2852 git-gui.sh:2961
+#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
 msgid "Sign Off"
 msgstr "=D0=92=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D1=82=D1=8C Signed-off-by=
"
=20
-#: git-gui.sh:2518
+#: git-gui.sh:2696
 msgid "Local Merge..."
 msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B5 =D1=81=D0=
=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5..."
=20
-#: git-gui.sh:2523
+#: git-gui.sh:2701
 msgid "Abort Merge..."
 msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D1=81=D0=BB=D0=
=B8=D1=8F=D0=BD=D0=B8=D0=B5..."
=20
-#: git-gui.sh:2535 git-gui.sh:2575
+#: git-gui.sh:2713 git-gui.sh:2741
 msgid "Add..."
 msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C..."
=20
-#: git-gui.sh:2539
+#: git-gui.sh:2717
 msgid "Push..."
 msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C..."
=20
-#: git-gui.sh:2543
+#: git-gui.sh:2721
 msgid "Delete Branch..."
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C..."
=20
-#: git-gui.sh:2553 git-gui.sh:2589 lib/about.tcl:14
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
-#, tcl-format
-msgid "About %s"
-msgstr "=D0=9E %s"
-
-#: git-gui.sh:2557
-msgid "Preferences..."
-msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8..."
-
-#: git-gui.sh:2565 git-gui.sh:3129
+#: git-gui.sh:2731 git-gui.sh:3292
 msgid "Options..."
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8..."
=20
-#: git-gui.sh:2576
+#: git-gui.sh:2742
 msgid "Remove..."
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C..."
=20
-#: git-gui.sh:2585 lib/choose_repository.tcl:50
+#: git-gui.sh:2751 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr "=D0=9F=D0=BE=D0=BC=D0=BE=D1=89=D1=8C"
=20
-#: git-gui.sh:2611
+#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
+#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
+#, tcl-format
+msgid "About %s"
+msgstr "=D0=9E %s"
+
+#: git-gui.sh:2783
 msgid "Online Documentation"
 msgstr "=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=
=B8=D1=8F =D0=B2 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D0=BD=D0=B5=D1=82=D0=B5=
"
=20
-#: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
+#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
 msgid "Show SSH Key"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=BA=D0=BB=D1=
=8E=D1=87 SSH"
=20
-#: git-gui.sh:2721
+#: git-gui.sh:2893
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr "=D0=BA=D1=80=D0=B8=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B0=D1=
=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0: %s: =D0=BD=D0=B5=D1=82 =D1=82=
=D0=B0=D0=BA=D0=BE=D0=B3=D0=BE =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=
=BB=D0=B8 =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B0"
=20
-#: git-gui.sh:2754
+#: git-gui.sh:2926
 msgid "Current Branch:"
 msgstr "=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B0=D1=8F =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C:"
=20
-#: git-gui.sh:2775
+#: git-gui.sh:2947
 msgid "Staged Changes (Will Commit)"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE (=D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=BE=D1=85=D1=80=D0=B0=
=D0=BD=D0=B5=D0=BD=D0=BE)"
=20
-#: git-gui.sh:2795
+#: git-gui.sh:2967
 msgid "Unstaged Changes"
 msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE (=D0=BD=D0=B5=
 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=
=B5=D0=BD=D0=BE)"
=20
-#: git-gui.sh:2845
+#: git-gui.sh:3017
 msgid "Stage Changed"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B2=D1=81=D0=B5"
=20
-#: git-gui.sh:2864 lib/transport.tcl:104 lib/transport.tcl:193
+#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
 msgid "Push"
 msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:2899
+#: git-gui.sh:3071
 msgid "Initial Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=
=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E:"
=20
-#: git-gui.sh:2900
+#: git-gui.sh:3072
 msgid "Amended Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E=
:"
=20
-#: git-gui.sh:2901
+#: git-gui.sh:3073
 msgid "Amended Initial Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=
=D0=BB=D1=8C=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=
=D0=BD=D0=B8=D1=8E:"
=20
-#: git-gui.sh:2902
+#: git-gui.sh:3074
 msgid "Amended Merge Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8E:"
=20
-#: git-gui.sh:2903
+#: git-gui.sh:3075
 msgid "Merge Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8E:"
=20
-#: git-gui.sh:2904
+#: git-gui.sh:3076
 msgid "Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E:"
=20
-#: git-gui.sh:2953 git-gui.sh:3104 lib/console.tcl:73
+#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
 msgid "Copy All"
 msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=
=B2=D1=81=D0=B5"
=20
-#: git-gui.sh:2977 lib/blame.tcl:104
+#: git-gui.sh:3149 lib/blame.tcl:104
 msgid "File:"
 msgstr "=D0=A4=D0=B0=D0=B9=D0=BB:"
=20
-#: git-gui.sh:3092
+#: git-gui.sh:3255
 msgid "Refresh"
 msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:3113
+#: git-gui.sh:3276
 msgid "Decrease Font Size"
 msgstr "=D0=A3=D0=BC=D0=B5=D0=BD=D1=8C=D1=88=D0=B8=D1=82=D1=8C =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=82=D0=B0"
=20
-#: git-gui.sh:3117
+#: git-gui.sh:3280
 msgid "Increase Font Size"
 msgstr "=D0=A3=D0=B2=D0=B5=D0=BB=D0=B8=D1=87=D0=B8=D1=82=D1=8C =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=82=D0=B0"
=20
-#: git-gui.sh:3125 lib/blame.tcl:281
+#: git-gui.sh:3288 lib/blame.tcl:281
 msgid "Encoding"
 msgstr "=D0=9A=D0=BE=D0=B4=D0=B8=D1=80=D0=BE=D0=B2=D0=BA=D0=B0"
=20
-#: git-gui.sh:3136
+#: git-gui.sh:3299
 msgid "Apply/Reverse Hunk"
 msgstr "=D0=9F=D1=80=D0=B8=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C/=D0=A3=D0=
=B1=D1=80=D0=B0=D1=82=D1=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B5"
=20
-#: git-gui.sh:3141
+#: git-gui.sh:3304
 msgid "Apply/Reverse Line"
 msgstr "=D0=9F=D1=80=D0=B8=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C/=D0=A3=D0=
=B1=D1=80=D0=B0=D1=82=D1=8C =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=83"
=20
-#: git-gui.sh:3151
+#: git-gui.sh:3323
 msgid "Run Merge Tool"
 msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C =D0=BF=D1=
=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=83 =D1=81=D0=BB=D0=B8=D1=8F=D0=
=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:3156
+#: git-gui.sh:3328
 msgid "Use Remote Version"
 msgstr "=D0=92=D0=B7=D1=8F=D1=82=D1=8C =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D1=
=8E=D1=8E =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E"
=20
-#: git-gui.sh:3160
+#: git-gui.sh:3332
 msgid "Use Local Version"
 msgstr "=D0=92=D0=B7=D1=8F=D1=82=D1=8C =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=
=8C=D0=BD=D1=83=D1=8E =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E"
=20
-#: git-gui.sh:3164
+#: git-gui.sh:3336
 msgid "Revert To Base"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:3183
+#: git-gui.sh:3354
+msgid "Visualize These Changes In The Submodule"
+msgstr ""
+
+#: git-gui.sh:3358
+msgid "Visualize Current Branch History In The Submodule"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9 =
=D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=BF=D0=BE=D0=B4=D0=BC=D0=BE=D0=B4=D1=83=
=D0=BB=D1=8F"
+
+#: git-gui.sh:3362
+msgid "Visualize All Branch History In The Submodule"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=8E =D0=B2=D1=81=D0=B5=D1=85 =D0=B2=D0=B5=D1=82=
=D0=B2=D0=B5=D0=B9 =D0=BF=D0=BE=D0=B4=D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F=
"
+
+#: git-gui.sh:3367
+msgid "Start git gui In The Submodule"
+msgstr ""
+
+#: git-gui.sh:3389
 msgid "Unstage Hunk From Commit"
 msgstr "=D0=9D=D0=B5 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D1=8F=D1=82=D1=
=8C =D1=87=D0=B0=D1=81=D1=82=D1=8C"
=20
-#: git-gui.sh:3184
+#: git-gui.sh:3391
+msgid "Unstage Lines From Commit"
+msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D1=81=D1=82=D1=80=D0=BE=D0=
=BA=D0=B8 =D0=B8=D0=B7 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=
=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE"
+
+#: git-gui.sh:3393
 msgid "Unstage Line From Commit"
 msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D1=81=D1=82=D1=80=D0=BE=D0=
=BA=D1=83 =D0=B8=D0=B7 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=
=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE"
=20
-#: git-gui.sh:3186
+#: git-gui.sh:3396
 msgid "Stage Hunk For Commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D1=87=D0=B0=D1=81=D1=82=D1=8C =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=
=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:3187
+#: git-gui.sh:3398
+msgid "Stage Lines For Commit"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B8 =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=
=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+
+#: git-gui.sh:3400
 msgid "Stage Line For Commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=83 =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=
=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:3210
+#: git-gui.sh:3424
 msgid "Initializing..."
 msgstr "=D0=98=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=B7=D0=B0=D1=
=86=D0=B8=D1=8F..."
=20
-#: git-gui.sh:3315
+#: git-gui.sh:3541
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -520,7 +544,7 @@ msgstr ""
 "=D0=B7=D0=B0=D0=BF=D1=83=D1=89=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC=D0=B8 =D0=
=B8=D0=B7 %s\n"
 "\n"
=20
-#: git-gui.sh:3345
+#: git-gui.sh:3570
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -530,7 +554,7 @@ msgstr ""
 "=D0=AD=D1=82=D0=BE =D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=D0=B0=D1=
=8F =D0=BF=D1=80=D0=BE=D0=B1=D0=BB=D0=B5=D0=BC=D0=B0 =D1=81 Tcl,\n"
 "=D1=80=D0=B0=D1=81=D0=BF=D1=80=D0=BE=D1=81=D1=82=D1=80=D0=B0=D0=BD=D1=
=8F=D0=B5=D0=BC=D1=8B=D0=BC Cygwin."
=20
-#: git-gui.sh:3350
+#: git-gui.sh:3575
 #, tcl-format
 msgid ""
 "\n"
@@ -640,7 +664,7 @@ msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=
=B6=D0=BD=D0=BE =D0=BD=D0=B0=D0=B9=D1=82=D0=B8 =D1=81=D0=BE=D1=81=D1=82=
=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BF=D1=80=D0=B5=D0=B4=D0=BA=D0=B0:"
 msgid "Unable to display parent"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BA=D0=B0=
=D0=B7=D0=B0=D1=82=D1=8C =D0=BF=D1=80=D0=B5=D0=B4=D0=BA=D0=B0"
=20
-#: lib/blame.tcl:1091 lib/diff.tcl:297
+#: lib/blame.tcl:1091 lib/diff.tcl:320
 msgid "Error loading diff:"
 msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=D0=B0=D0=B3=D1=80=D1=
=83=D0=B7=D0=BA=D0=B8 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=
=B9:"
=20
@@ -666,7 +690,7 @@ msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8"
=20
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
-#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:172
+#: lib/checkout_op.tcl:579 lib/choose_font.tcl:43 lib/merge.tcl:172
 #: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.t=
cl:42
 #: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
 #: lib/transport.tcl:108
@@ -697,7 +721,7 @@ msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D0=
=B5 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
 msgid "Create New Branch"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BD=D0=BE=D0=B2=D1=
=83=D1=8E =D0=B2=D0=B5=D1=82=D0=B2=D1=8C"
=20
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:377
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
 msgid "Create"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C"
=20
@@ -729,7 +753,7 @@ msgstr "=D0=9D=D0=B5=D1=82"
 msgid "Fast Forward Only"
 msgstr "=D0=A2=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE Fast Forward"
=20
-#: lib/branch_create.tcl:85 lib/checkout_op.tcl:536
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:571
 msgid "Reset"
 msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81"
=20
@@ -771,8 +795,8 @@ msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D1=
=8B=D0=B5 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
 msgid "Delete Only If Merged Into"
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D1=82=D0=BE=D0=BB=D1=
=8C=D0=BA=D0=BE =D0=B2 =D1=81=D0=BB=D1=83=D1=87=D0=B0=D0=B5, =D0=B5=D1=81=
=D0=BB=D0=B8 =D0=B1=D1=8B=D0=BB=D0=BE =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=
=B8=D0=B5 =D1=81"
=20
-#: lib/branch_delete.tcl:54
-msgid "Always (Do not perform merge test.)"
+#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
+msgid "Always (Do not perform merge checks)"
 msgstr "=D0=92=D1=81=D0=B5=D0=B3=D0=B4=D0=B0 (=D0=BD=D0=B5 =D0=B2=D1=8B=
=D0=BF=D0=BE=D0=BB=D0=BD=D1=8F=D1=82=D1=8C =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=
=D1=80=D0=BA=D1=83 =D0=BD=D0=B0 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=
=B5)"
=20
 #: lib/branch_delete.tcl:103
@@ -780,6 +804,16 @@ msgstr "=D0=92=D1=81=D0=B5=D0=B3=D0=B4=D0=B0 (=D0=BD=
=D0=B5 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D1=8F=D1=82=D1=8C =D0=BF=D1=
=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D1=83 =D0=BD=D0=B0 =D1=81=D0=BB=D0=B8=
=D1=8F=D0=BD=D0=B8
 msgid "The following branches are not completely merged into %s:"
 msgstr "=D0=92=D0=B5=D1=82=D0=B2=D0=B8, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=
=D1=8B=D0=B5 =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=82=D1=
=8C=D1=8E =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D1=8E=D1=82=D1=81=D1=8F =D1=81=
 %s:"
=20
+#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"=D0=92=D0=BE=D1=81=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B2=D0=B5=
=D1=82=D0=B2=D0=B8 =D1=81=D0=BB=D0=BE=D0=B6=D0=BD=D0=BE.\n"
+"\n"
+"=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C?"
+
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
@@ -809,7 +843,7 @@ msgstr "=D0=9D=D0=BE=D0=B2=D0=BE=D0=B5 =D0=BD=D0=B0=
=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5:"
 msgid "Please select a branch to rename."
 msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C =D0=B4=D0=BB=D1=8F =D0=BF=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=
=D0=BD=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F."
=20
-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:201
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=
=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
@@ -840,38 +874,38 @@ msgstr "[=D0=9D=D0=B0 =D1=83=D1=80=D0=BE=D0=B2=D0=
=B5=D0=BD=D1=8C =D0=B2=D1=8B=D1=88=D0=B5]"
 msgid "Browse Branch Files"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
=20
-#: lib/browser.tcl:278 lib/choose_repository.tcl:394
-#: lib/choose_repository.tcl:480 lib/choose_repository.tcl:491
-#: lib/choose_repository.tcl:995
+#: lib/browser.tcl:278 lib/choose_repository.tcl:398
+#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
+#: lib/choose_repository.tcl:1028
 msgid "Browse"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C"
=20
-#: lib/checkout_op.tcl:84
+#: lib/checkout_op.tcl:85
 #, tcl-format
 msgid "Fetching %s from %s"
 msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 %s =D0=B8=
=D0=B7 %s "
=20
-#: lib/checkout_op.tcl:132
+#: lib/checkout_op.tcl:133
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
 msgstr "=D0=BA=D1=80=D0=B8=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B0=D1=
=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0: =D0=BD=D0=B5=D0=B2=D0=BE=D0=B7=
=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D1=80=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B8=
=D1=82=D1=8C %s"
=20
-#: lib/checkout_op.tcl:145 lib/console.tcl:81 lib/database.tcl:31
+#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
 #: lib/sshkey.tcl:53
 msgid "Close"
 msgstr "=D0=97=D0=B0=D0=BA=D1=80=D1=8B=D1=82=D1=8C"
=20
-#: lib/checkout_op.tcl:174
+#: lib/checkout_op.tcl:175
 #, tcl-format
 msgid "Branch '%s' does not exist."
 msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D0=BD=D0=B5 =D1=81=D1=83=D1=
=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 "
=20
-#: lib/checkout_op.tcl:193
+#: lib/checkout_op.tcl:194
 #, tcl-format
 msgid "Failed to configure simplified git-pull for '%s'."
 msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=81=D0=BE=D0=B7=D0=B4=D0=
=B0=D0=BD=D0=B8=D1=8F =D1=83=D0=BF=D1=80=D0=BE=D1=89=D1=91=D0=BD=D0=BD=D0=
=BE=D0=B9 =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=
=B8=D0=B8 git pull =D0=B4=D0=BB=D1=8F '%s'."
=20
-#: lib/checkout_op.tcl:228
+#: lib/checkout_op.tcl:229
 #, tcl-format
 msgid ""
 "Branch '%s' already exists.\n"
@@ -884,21 +918,21 @@ msgstr ""
 "=D0=9E=D0=BD=D0=B0 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B1=
=D1=8B=D1=82=D1=8C =D0=BF=D1=80=D0=BE=D0=BA=D1=80=D1=83=D1=87=D0=B5=D0=BD=
=D0=B0(fast-forward) =D0=BA %s.\n"
 "=D0=A2=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=D1=8F =D1=81=D0=BB=D0=
=B8=D1=8F=D0=BD=D0=B8=D0=B5."
=20
-#: lib/checkout_op.tcl:242
+#: lib/checkout_op.tcl:243
 #, tcl-format
 msgid "Merge strategy '%s' not supported."
 msgstr "=D0=9D=D0=B5=D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=D0=B0=D1=
=8F =D1=81=D1=82=D1=80=D0=B0=D1=82=D0=B5=D0=B3=D0=B8=D1=8F =D1=81=D0=BB=
=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F: '%s'."
=20
-#: lib/checkout_op.tcl:261
+#: lib/checkout_op.tcl:262
 #, tcl-format
 msgid "Failed to update '%s'."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BE=
=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C '%s'."
=20
-#: lib/checkout_op.tcl:273
+#: lib/checkout_op.tcl:274
 msgid "Staging area (index) is already locked."
 msgstr "=D0=A0=D0=B0=D0=B1=D0=BE=D1=87=D0=B0=D1=8F =D0=BE=D0=B1=D0=BB=D0=
=B0=D1=81=D1=82=D1=8C =D0=B7=D0=B0=D0=B1=D0=BB=D0=BE=D0=BA=D0=B8=D1=80=D0=
=BE=D0=B2=D0=B0=D0=BD=D0=B0 =D0=B4=D1=80=D1=83=D0=B3=D0=B8=D0=BC =D0=BF=
=D1=80=D0=BE=D1=86=D0=B5=D1=81=D1=81=D0=BE=D0=BC."
=20
-#: lib/checkout_op.tcl:288
+#: lib/checkout_op.tcl:289
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -914,30 +948,30 @@ msgstr ""
 "\n"
 "=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=
=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
=20
-#: lib/checkout_op.tcl:344
+#: lib/checkout_op.tcl:345
 #, tcl-format
 msgid "Updating working directory to '%s'..."
 msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D1=
=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=82=D0=B0=D0=
=BB=D0=BE=D0=B3=D0=B0 =D0=B8=D0=B7 '%s'..."
=20
-#: lib/checkout_op.tcl:345
+#: lib/checkout_op.tcl:346
 msgid "files checked out"
 msgstr "=D1=84=D0=B0=D0=B9=D0=BB=D1=8B =D0=B8=D0=B7=D0=B2=D0=BB=D0=B5=D1=
=87=D0=B5=D0=BD=D1=8B"
=20
-#: lib/checkout_op.tcl:375
+#: lib/checkout_op.tcl:376
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD =D0=BF=D0=B5=D1=80=D0=
=B5=D1=85=D0=BE=D0=B4 =D0=BD=D0=B0 '%s' (=D1=82=D1=80=D0=B5=D0=B1=D1=83=
=D0=B5=D1=82=D1=81=D1=8F =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 =D1=
=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B0=D0=BD=D0=B8=D1=8F =D1=84=D0=B0=D0=
=B9=D0=BB=D0=BE=D0=B2)"
=20
-#: lib/checkout_op.tcl:376
+#: lib/checkout_op.tcl:377
 msgid "File level merge required."
 msgstr "=D0=A2=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=D1=8F =D1=81=D0=
=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=
=B0=D0=BD=D0=B8=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2."
=20
-#: lib/checkout_op.tcl:380
+#: lib/checkout_op.tcl:381
 #, tcl-format
 msgid "Staying on branch '%s'."
 msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D0=BE=D1=81=D1=82=D0=B0=D0=
=B5=D1=82=D1=81=D1=8F =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9."
=20
-#: lib/checkout_op.tcl:451
+#: lib/checkout_op.tcl:452
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
@@ -949,30 +983,30 @@ msgstr ""
 "=D0=95=D1=81=D0=BB=D0=B8 =D0=B2=D1=8B =D1=85=D0=BE=D1=82=D0=B8=D1=82=D0=
=B5 =D1=81=D0=BD=D0=BE=D0=B2=D0=B0 =D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=82=
=D1=8C=D1=81=D1=8F =D0=BA =D0=BA=D0=B0=D0=BA=D0=BE=D0=B9-=D0=BD=D0=B8=D0=
=B1=D1=83=D0=B4=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8, =D1=81=D0=BE=D0=B7=
=D0=B4=D0=B0=D0=B9=D1=82=D0=B5 =D0=B5=D0=B5 =D1=81=D0=B5=D0=B9=D1=87=D0=
=B0=D1=81, "
 "=D0=BD=D0=B0=D1=87=D0=B8=D0=BD=D0=B0=D1=8F =D1=81 '=D0=A2=D0=B5=D0=BA=
=D1=83=D1=89=D0=B5=D0=B3=D0=BE =D0=BE=D1=82=D1=81=D0=BE=D0=B5=D0=B4=D0=B8=
=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=
=D1=8F=D0=BD=D0=B8=D1=8F'."
=20
-#: lib/checkout_op.tcl:468 lib/checkout_op.tcl:472
+#: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
 #, tcl-format
 msgid "Checked out '%s'."
 msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D1=81=D0=B4=D0=B5=D0=BB=D0=
=B0=D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9."
=20
-#: lib/checkout_op.tcl:500
+#: lib/checkout_op.tcl:535
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
 msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81 '%s' =D0=B2 '%s' =D0=BF=D1=80=D0=
=B8=D0=B2=D0=B5=D0=B4=D0=B5=D1=82 =D0=BA =D0=BF=D0=BE=D1=82=D0=B5=D1=80=
=D0=B5 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D1=85 =D1=81=D0=
=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D1=85 =D1=81=D0=BE=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9: "
=20
-#: lib/checkout_op.tcl:522
+#: lib/checkout_op.tcl:557
 msgid "Recovering lost commits may not be easy."
 msgstr "=D0=92=D0=BE=D1=81=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=
=82=D1=8C =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D0=BD=D1=8B=D0=B5 =
=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F =D0=B1=D1=83=D0=B4=D0=B5=
=D1=82 =D1=81=D0=BB=D0=BE=D0=B6=D0=BD=D0=BE."
=20
-#: lib/checkout_op.tcl:527
+#: lib/checkout_op.tcl:562
 #, tcl-format
 msgid "Reset '%s'?"
 msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C '%s'?"
=20
-#: lib/checkout_op.tcl:532 lib/merge.tcl:164 lib/tools_dlg.tcl:343
+#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
 msgid "Visualize"
 msgstr "=D0=9D=D0=B0=D0=B3=D0=BB=D1=8F=D0=B4=D0=BD=D0=BE"
=20
-#: lib/checkout_op.tcl:600
+#: lib/checkout_op.tcl:635
 #, tcl-format
 msgid ""
 "Failed to set current branch.\n"
@@ -1017,7 +1051,7 @@ msgstr ""
 msgid "Git Gui"
 msgstr "Git Gui"
=20
-#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:382
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
 msgid "Create New Repository"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BD=D0=BE=D0=B2=D1=
=8B=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
@@ -1025,7 +1059,7 @@ msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C=
 =D0=BD=D0=BE=D0=B2=D1=8B=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D0=B9"
 msgid "New..."
 msgstr "=D0=9D=D0=BE=D0=B2=D1=8B=D0=B9..."
=20
-#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:465
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
 msgid "Clone Existing Repository"
 msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=89=D0=
=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
@@ -1033,7 +1067,7 @@ msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=
=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=
=D1=83=D1=8E=D1=89=D0=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=
=D0=BE=D1=80=D0=B8=D0=B9
 msgid "Clone..."
 msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C..."
=20
-#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:983
+#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
 msgid "Open Existing Repository"
 msgstr "=D0=92=D1=8B=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D1=81=D1=83=D1=89=D0=
=B5=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=89=D0=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9"
=20
@@ -1049,194 +1083,194 @@ msgstr "=D0=9D=D0=B5=D0=B4=D0=B0=D0=B2=D0=BD=D0=
=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B8"
 msgid "Open Recent Repository:"
 msgstr "=D0=9E=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D0=B9"
=20
-#: lib/choose_repository.tcl:302 lib/choose_repository.tcl:309
-#: lib/choose_repository.tcl:316
+#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
+#: lib/choose_repository.tcl:320
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D1=81=
=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=
=D1=82=D0=BE=D1=80=D0=B8=D0=B9 %s:"
=20
-#: lib/choose_repository.tcl:387
+#: lib/choose_repository.tcl:391
 msgid "Directory:"
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3:"
=20
-#: lib/choose_repository.tcl:417 lib/choose_repository.tcl:544
-#: lib/choose_repository.tcl:1017
+#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
+#: lib/choose_repository.tcl:1052
 msgid "Git Repository"
 msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
-#: lib/choose_repository.tcl:442
+#: lib/choose_repository.tcl:448
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 '%s' =D1=83=D0=B6=D0=
=B5 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
-#: lib/choose_repository.tcl:446
+#: lib/choose_repository.tcl:452
 #, tcl-format
 msgid "File %s already exists."
 msgstr "=D0=A4=D0=B0=D0=B9=D0=BB '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=83=D1=
=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
-#: lib/choose_repository.tcl:460
+#: lib/choose_repository.tcl:466
 msgid "Clone"
 msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C"
=20
-#: lib/choose_repository.tcl:473
+#: lib/choose_repository.tcl:479
 msgid "Source Location:"
 msgstr "=D0=98=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D0=BE=D0=B5 =D0=BF=D0=BE=D0=
=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5:"
=20
-#: lib/choose_repository.tcl:484
+#: lib/choose_repository.tcl:490
 msgid "Target Directory:"
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BD=D0=B0=D0=B7=D0=
=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B8=D1=8F:"
=20
-#: lib/choose_repository.tcl:496
+#: lib/choose_repository.tcl:502
 msgid "Clone Type:"
 msgstr "=D0=A2=D0=B8=D0=BF =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0:"
=20
-#: lib/choose_repository.tcl:502
+#: lib/choose_repository.tcl:508
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D1=8B=D0=
=B9 (=D0=91=D1=8B=D1=81=D1=82=D1=80=D1=8B=D0=B9, =D0=BF=D0=BE=D0=BB=D1=83=
=D0=B8=D0=B7=D0=B1=D1=8B=D1=82=D0=BE=D1=87=D0=BD=D1=8B=D0=B9, \"=D0=B6=D0=
=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B5\" =D1=81=D1=81=D1=8B=D0=BB=D0=BA=D0=B8=
)"
=20
-#: lib/choose_repository.tcl:508
+#: lib/choose_repository.tcl:514
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "=D0=9F=D0=BE=D0=BB=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=BF=D0=B8=D1=
=8F (=D0=9C=D0=B5=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B9, =D1=81=D0=BE=
=D0=B7=D0=B4=D0=B0=D0=B5=D1=82 =D1=80=D0=B5=D0=B7=D0=B5=D1=80=D0=B2=D0=BD=
=D1=83=D1=8E =D0=BA=D0=BE=D0=BF=D0=B8=D1=8E)"
=20
-#: lib/choose_repository.tcl:514
+#: lib/choose_repository.tcl:520
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "=D0=9E=D0=B1=D1=89=D0=B8=D0=B9 (=D0=A1=D0=B0=D0=BC=D1=8B=D0=B9=
 =D0=B1=D1=8B=D1=81=D1=82=D1=80=D1=8B=D0=B9, =D0=BD=D0=B5 =D1=80=D0=B5=D0=
=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=83=D0=B5=D1=82=D1=81=D1=8F, =D0=B1=
=D0=B5=D0=B7 =D1=80=D0=B5=D0=B7=D0=B5=D1=80=D0=B2=D0=BD=D0=BE=D0=B9 =D0=
=BA=D0=BE=D0=BF=D0=B8=D0=B8)"
=20
-#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
-#: lib/choose_repository.tcl:743 lib/choose_repository.tcl:813
-#: lib/choose_repository.tcl:1023 lib/choose_repository.tcl:1031
+#: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
+#: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
+#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BD=D0=B5 =D1=8F=
=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=8F =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=
=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B5=D0=BC: %s"
=20
-#: lib/choose_repository.tcl:586
+#: lib/choose_repository.tcl:592
 msgid "Standard only available for local repository."
 msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D1=8B=D0=
=B9 =D0=BA=D0=BB=D0=BE=D0=BD =D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=B5=
=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=B4=D0=BB=D1=8F =D0=BB=D0=
=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B3=D0=BE =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F."
=20
-#: lib/choose_repository.tcl:590
+#: lib/choose_repository.tcl:596
 msgid "Shared only available for local repository."
 msgstr "=D0=9E=D0=B1=D1=89=D0=B8=D0=B9 =D0=BA=D0=BB=D0=BE=D0=BD =D0=B2=
=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=B5=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=
=D0=BE =D0=B4=D0=BB=D1=8F =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=
=BE=D0=B3=D0=BE =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F."
=20
-#: lib/choose_repository.tcl:611
+#: lib/choose_repository.tcl:617
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "=D0=9F=D1=83=D1=82=D1=8C '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=83=D1=
=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
-#: lib/choose_repository.tcl:622
+#: lib/choose_repository.tcl:628
 msgid "Failed to configure origin"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BA=D0=BE=D0=BD=
=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C=
 =D0=B8=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D1=8B=D0=B9 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9."
=20
-#: lib/choose_repository.tcl:634
+#: lib/choose_repository.tcl:640
 msgid "Counting objects"
 msgstr "=D0=A1=D1=87=D0=B8=D1=82=D0=B0=D1=8E =D0=BE=D0=B1=D1=8A=D0=B5=D0=
=BA=D1=82=D1=8B"
=20
-#: lib/choose_repository.tcl:635
+#: lib/choose_repository.tcl:641
 msgid "buckets"
 msgstr ""
=20
-#: lib/choose_repository.tcl:659
+#: lib/choose_repository.tcl:665
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BA=D0=BE=D0=BF=
=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C objects/info/alternates: %s"
=20
-#: lib/choose_repository.tcl:695
+#: lib/choose_repository.tcl:701
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "=D0=9D=D0=B5=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=BB=D0=BE=D0=BD=D0=
=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D1=81 %s."
=20
-#: lib/choose_repository.tcl:697 lib/choose_repository.tcl:911
-#: lib/choose_repository.tcl:923
+#: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
+#: lib/choose_repository.tcl:929
 msgid "The 'master' branch has not been initialized."
 msgstr "=D0=9D=D0=B5 =D0=B8=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=
=B7=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B0 =D0=B2=D0=B5=D1=82=D0=B2=D1=
=8C 'master'."
=20
-#: lib/choose_repository.tcl:710
+#: lib/choose_repository.tcl:716
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "\"=D0=96=D0=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B5 =D1=81=D1=81=D1=8B=
=D0=BB=D0=BA=D0=B8\" =D0=BD=D0=B5=D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=
=BD=D1=8B. =D0=91=D1=83=D0=B4=D0=B5=D1=82 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=
=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=BE =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=
=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5."
=20
-#: lib/choose_repository.tcl:722
+#: lib/choose_repository.tcl:728
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=B8=D0=B5 %s"
=20
-#: lib/choose_repository.tcl:753
+#: lib/choose_repository.tcl:759
 msgid "Copying objects"
 msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=
=B5 objects"
=20
-#: lib/choose_repository.tcl:754
+#: lib/choose_repository.tcl:760
 msgid "KiB"
 msgstr "=D0=9A=D0=91"
=20
-#: lib/choose_repository.tcl:778
+#: lib/choose_repository.tcl:784
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BA=D0=BE=D0=BF=
=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=
=D1=82: %s"
=20
-#: lib/choose_repository.tcl:788
+#: lib/choose_repository.tcl:794
 msgid "Linking objects"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D0=B5 =D1=81=D1=81=D1=
=8B=D0=BB=D0=BE=D0=BA =D0=BD=D0=B0 objects"
=20
-#: lib/choose_repository.tcl:789
+#: lib/choose_repository.tcl:795
 msgid "objects"
 msgstr "=D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D1=8B"
=20
-#: lib/choose_repository.tcl:797
+#: lib/choose_repository.tcl:803
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 \"=D0=B6=D0=B5=D1=81=D1=82=
=D0=BA=D0=BE =D1=81=D0=B2=D1=8F=D0=B7=D0=B0=D1=82=D1=8C\" =D0=BE=D0=B1=D1=
=8A=D0=B5=D0=BA=D1=82: %s"
=20
-#: lib/choose_repository.tcl:852
+#: lib/choose_repository.tcl:858
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
 msgstr ""
 "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=
=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=B8 =D0=BE=D0=B1=D1=8A=
=D0=B5=D0=BA=D1=82=D1=8B. =D0=94=D0=BE=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=
=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=
=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=81=D0=BE=
=D0=BB=D0=B8."
=20
-#: lib/choose_repository.tcl:863
+#: lib/choose_repository.tcl:869
 msgid "Cannot fetch tags.  See console output for details."
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B8=D1=82=D1=8C =D0=BC=D0=B5=D1=82=D0=BA=D0=B8. =D0=94=D0=BE=D0=
=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=
=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =
=D0=BA=D0=BE=D0=BD=D1=81=D0=BE=D0=BB=D0=B8."
=20
-#: lib/choose_repository.tcl:887
+#: lib/choose_repository.tcl:893
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BE=D0=BF=D1=80=D0=B5=
=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C HEAD. =D0=94=D0=BE=D0=BF=D0=BE=D0=BB=
=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B8=D0=BD=D1=84=
=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BA=D0=BE=D0=
=BD=D1=81=D0=BE=D0=BB=D0=B8."
=20
-#: lib/choose_repository.tcl:896
+#: lib/choose_repository.tcl:902
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BE=D1=87=D0=B8=D1=81=
=D1=82=D0=B8=D1=82=D1=8C %s"
=20
-#: lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:908
 msgid "Clone failed."
 msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=B8=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C."
=20
-#: lib/choose_repository.tcl:909
+#: lib/choose_repository.tcl:915
 msgid "No default branch obtained."
 msgstr "=D0=9D=D0=B5 =D0=B1=D1=8B=D0=BB=D0=BE =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B5=D0=BD=D0=BE =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=BF=D0=BE =D1=
=83=D0=BC=D0=BE=D0=BB=D1=87=D0=B0=D0=BD=D0=B8=D1=8E."
=20
-#: lib/choose_repository.tcl:920
+#: lib/choose_repository.tcl:926
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=80=D0=B0=D1=81=D0=BF=
=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D1=8C %s =D0=BA=D0=B0=D0=BA =D1=81=D0=BE=
=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5."
=20
-#: lib/choose_repository.tcl:932
+#: lib/choose_repository.tcl:938
 msgid "Creating working directory"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=8E =D1=80=D0=B0=D0=B1=D0=BE=D1=
=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3"
=20
-#: lib/choose_repository.tcl:933 lib/index.tcl:65 lib/index.tcl:128
-#: lib/index.tcl:196
+#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
+#: lib/index.tcl:198
 msgid "files"
 msgstr "=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2"
=20
-#: lib/choose_repository.tcl:962
+#: lib/choose_repository.tcl:968
 msgid "Initial file checkout failed."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D0=BD=D0=B0=D1=87=D0=B0=D0=BB=
=D1=8C=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D1=80=D0=B5=D0=BF=D0=BE=D0=
=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F."
=20
-#: lib/choose_repository.tcl:978
+#: lib/choose_repository.tcl:1011
 msgid "Open"
 msgstr "=D0=9E=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C"
=20
-#: lib/choose_repository.tcl:988
+#: lib/choose_repository.tcl:1021
 msgid "Repository:"
 msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9:"
=20
-#: lib/choose_repository.tcl:1037
+#: lib/choose_repository.tcl:1072
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BE=
=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=
=D1=82=D0=BE=D1=80=D0=B8=D0=B9 %s:"
@@ -1318,7 +1352,12 @@ msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=
=D0=B6=D0=BD=D0=BE =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D0=
=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BE=D0=B1 =
=D0=B0=D0=B2=D1=82=D0=BE
 msgid "Invalid GIT_COMMITTER_IDENT:"
 msgstr "=D0=9D=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D1=8B=D0=B9 GIT_COMMITTER=
_IDENT:"
=20
-#: lib/commit.tcl:132
+#: lib/commit.tcl:129
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "=D0=BF=D1=80=D0=B5=D0=B4=D1=83=D0=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=
=B5=D0=BD=D0=B8=D0=B5: Tcl =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=
=80=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D1=82 =D0=BA=D0=BE=D0=B4=D0=B8=D1=80=D0=
=BE=D0=B2=D0=BA=D1=83 '%s'."
+
+#: lib/commit.tcl:149
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -1334,7 +1373,7 @@ msgstr ""
 "\n"
 "=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=
=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
=20
-#: lib/commit.tcl:155
+#: lib/commit.tcl:172
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1347,7 +1386,7 @@ msgstr ""
 "=D0=94=D0=BB=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 %s =D0=B2=D0=BE=D0=B7=
=D0=BD=D0=B8=D0=BA =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82 =D1=
=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F. =D0=A0=D0=B0=D0=B7=D1=80=D0=B5=
=D1=88=D0=B8=D1=82=D0=B5 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=
 =D0=B8 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D1=8C=D1=82=D0=B5 =D0=BA "
 "=D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=
=BD=D1=8B=D0=BC =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D0=BC =D0=BF=D0=B5=D1=80=
=D0=B5=D0=B4 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=
=D0=BC.\n"
=20
-#: lib/commit.tcl:163
+#: lib/commit.tcl:180
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1358,7 +1397,7 @@ msgstr ""
 "\n"
 "=D0=A4=D0=B0=D0=B9=D0=BB %s =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82=
 =D0=B1=D1=8B=D1=82=D1=8C =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=
=BD =D0=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=
=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9.\n"
=20
-#: lib/commit.tcl:171
+#: lib/commit.tcl:188
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1368,7 +1407,7 @@ msgstr ""
 "\n"
 "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D1=8C=D1=82=D0=B5 =D1=
=85=D0=BE=D1=82=D1=8F =D0=B1=D1=8B =D0=BE=D0=B4=D0=B8=D0=BD =D1=84=D0=B0=
=D0=B9=D0=BB =D0=B4=D0=BE =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D1=
=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=
=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F.\n"
=20
-#: lib/commit.tcl:186
+#: lib/commit.tcl:203
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1386,45 +1425,40 @@ msgstr ""
 "- =D0=B2=D1=82=D0=BE=D1=80=D0=B0=D1=8F =D1=81=D1=82=D1=80=D0=BE=D0=BA=
=D0=B0 =D0=BF=D1=83=D1=81=D1=82=D0=B0=D1=8F\n"
 "- =D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=88=D0=B8=D0=B5=D1=81=D1=8F =D1=81=
=D1=82=D1=80=D0=BE=D0=BA=D0=B8: =D0=BE=D0=BF=D0=B8=D1=88=D0=B8=D1=82=D0=
=B5, =D1=87=D1=82=D0=BE =D0=B4=D0=B0=D1=8E=D1=82 =D0=B2=D0=B0=D1=88=D0=B8=
 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n"
=20
-#: lib/commit.tcl:210
-#, tcl-format
-msgid "warning: Tcl does not support encoding '%s'."
-msgstr "=D0=BF=D1=80=D0=B5=D0=B4=D1=83=D0=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=
=B5=D0=BD=D0=B8=D0=B5: Tcl =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=
=80=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D1=82 =D0=BA=D0=BE=D0=B4=D0=B8=D1=80=D0=
=BE=D0=B2=D0=BA=D1=83 '%s'."
-
-#: lib/commit.tcl:226
+#: lib/commit.tcl:234
 msgid "Calling pre-commit hook..."
 msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D1=8B =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=
=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =
pre-commit..."
=20
-#: lib/commit.tcl:241
+#: lib/commit.tcl:249
 msgid "Commit declined by pre-commit hook."
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=
=B6=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F pre-commit"
=20
-#: lib/commit.tcl:264
+#: lib/commit.tcl:272
 msgid "Calling commit-msg hook..."
 msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D1=8B =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=
=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =
commit-msg..."
=20
-#: lib/commit.tcl:279
+#: lib/commit.tcl:287
 msgid "Commit declined by commit-msg hook."
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=
=B6=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F commit-msg"
=20
-#: lib/commit.tcl:292
+#: lib/commit.tcl:300
 msgid "Committing changes..."
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9..."
=20
-#: lib/commit.tcl:308
+#: lib/commit.tcl:316
 msgid "write-tree failed:"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 write-t=
ree =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D0=BB=D0=B0=D1=81=D1=8C =
=D1=81 =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=BE=D0=B9:"
=20
-#: lib/commit.tcl:309 lib/commit.tcl:353 lib/commit.tcl:373
+#: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
 msgid "Commit failed."
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D1=81=D0=
=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=
=D0=B0=D0=BB=D0=BE=D1=81=D1=8C."
=20
-#: lib/commit.tcl:326
+#: lib/commit.tcl:334
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 %s =D0=B2=
=D1=8B=D0=B3=D0=BB=D1=8F=D0=B4=D0=B8=D1=82 =D0=BF=D0=BE=D0=B2=D1=80=D0=B5=
=D0=B6=D0=B4=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC"
=20
-#: lib/commit.tcl:331
+#: lib/commit.tcl:339
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1438,19 +1472,19 @@ msgstr ""
 "\n"
 "=D0=A1=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=D1=82=D0=BE=D0=BC=D0=
=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8 =D0=B7=D0=B0=D0=BF=D1=83=D1=
=81=D1=82=D0=B8=D1=82=D1=81=D1=8F =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=
=82=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=
=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F.\n"
=20
-#: lib/commit.tcl:338
+#: lib/commit.tcl:346
 msgid "No changes to commit."
 msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=
=82 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=BB=
=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F."
=20
-#: lib/commit.tcl:352
+#: lib/commit.tcl:360
 msgid "commit-tree failed:"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 commit-=
tree =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D0=BB=D0=B0=D1=81=D1=8C=
 =D1=81 =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=BE=D0=B9:"
=20
-#: lib/commit.tcl:372
+#: lib/commit.tcl:381
 msgid "update-ref failed:"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 update-=
ref =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D0=BB=D0=B0=D1=81=D1=8C =
=D1=81 =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=BE=D0=B9:"
=20
-#: lib/commit.tcl:460
+#: lib/commit.tcl:469
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=BE =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 %s: %s "
@@ -1503,20 +1537,19 @@ msgstr "=D0=A1=D0=B6=D0=B0=D1=82=D0=B8=D0=B5 =D0=
=B1=D0=B0=D0=B7=D1=8B =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2"
 msgid "Verifying the object database with fsck-objects"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=B1=D0=B0=D0=
=B7=D1=8B =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2 =D0=BF=D1=80=
=D0=B8 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D0=B8 fsck"
=20
-#: lib/database.tcl:108
+#: lib/database.tcl:107
 #, tcl-format
 msgid ""
 "This repository currently has approximately %i loose objects.\n"
 "\n"
 "To maintain optimal performance it is strongly recommended that you c=
ompress "
-"the database when more than %i loose objects exist.\n"
+"the database.\n"
 "\n"
 "Compress the database now?"
 msgstr ""
 "=D0=AD=D1=82=D0=BE=D1=82 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=
=BE=D1=80=D0=B8=D0=B9 =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D1=81=D0=BE=
=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80=
=D0=BD=D0=BE %i =D1=81=D0=B2=D0=BE=D0=B1=D0=BE=D0=B4=D0=BD=D1=8B=D1=85 =
=D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2\n"
 "\n"
-"=D0=94=D0=BB=D1=8F =D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=B9 =D0=BF=D1=80=D0=
=BE=D0=B8=D0=B7=D0=B2=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=
=BE=D1=81=D1=82=D0=B8 =D1=80=D0=B5=D0=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=
=83=D0=B5=D1=82=D1=81=D1=8F =D1=81=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=
=D0=B7=D1=83 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85, =D0=BA=D0=BE=D0=B3=D0=
=B4=D0=B0 =D0=B5=D1=81=D1=82=D1=8C "
-"=D0=B1=D0=BE=D0=BB=D0=B5=D0=B5 %i =D0=BD=D0=B5=D1=81=D0=B2=D1=8F=D0=B7=
=D0=B0=D0=BD=D0=BD=D1=8B=D1=85 =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=
=D0=B2.\n"
+"=D0=94=D0=BB=D1=8F =D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=B9 =D0=BF=D1=80=D0=
=BE=D0=B8=D0=B7=D0=B2=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=
=BE=D1=81=D1=82=D0=B8 =D1=80=D0=B5=D0=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=
=83=D0=B5=D1=82=D1=81=D1=8F =D1=81=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=
=D0=B7=D1=83 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85.\n"
 "\n"
 "=D0=A1=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=D0=B7=D1=83 =D0=B4=D0=B0=D0=
=BD=D0=BD=D1=8B=D1=85 =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81?"
=20
@@ -1525,7 +1558,7 @@ msgstr ""
 msgid "Invalid date from Git: %s"
 msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D1=8C=D0=BD=D0=
=B0=D1=8F =D0=B4=D0=B0=D1=82=D0=B0 =D0=B2 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=
=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8: %s"
=20
-#: lib/diff.tcl:59
+#: lib/diff.tcl:64
 #, tcl-format
 msgid ""
 "No differences detected.\n"
@@ -1547,12 +1580,12 @@ msgstr ""
 "\n"
 "=D0=A1=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=
=B7=D0=B0=D0=BF=D1=83=D1=89=D0=B5=D0=BD=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D1=
=87=D0=B8=D1=82=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F, =D1=87=D1=82=D0=BE=D0=B1=
=D1=8B =D0=BD=D0=B0=D0=B9=D1=82=D0=B8 =D0=BF=D0=BE=D0=B4=D0=BE=D0=B1=D0=
=BD=D1=8B=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D1=8B."
=20
-#: lib/diff.tcl:99
+#: lib/diff.tcl:104
 #, tcl-format
 msgid "Loading diff of %s..."
 msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B2 %s..."
=20
-#: lib/diff.tcl:120
+#: lib/diff.tcl:125
 msgid ""
 "LOCAL: deleted\n"
 "REMOTE:\n"
@@ -1560,7 +1593,7 @@ msgstr ""
 "=D0=9B=D0=9E=D0=9A=D0=90=D0=9B=D0=AC=D0=9D=D0=9E: =D1=83=D0=B4=D0=B0=D0=
=BB=D1=91=D0=BD\n"
 "=D0=92=D0=9D=D0=95=D0=A8=D0=9D=D0=98=D0=99:\n"
=20
-#: lib/diff.tcl:125
+#: lib/diff.tcl:130
 msgid ""
 "REMOTE: deleted\n"
 "LOCAL:\n"
@@ -1568,32 +1601,32 @@ msgstr ""
 "=D0=92=D0=9D=D0=95=D0=A8=D0=9D=D0=98=D0=99: =D1=83=D0=B4=D0=B0=D0=BB=D1=
=91=D0=BD\n"
 "=D0=9B=D0=9E=D0=9A=D0=90=D0=9B=D0=AC=D0=9D=D0=9E:\n"
=20
-#: lib/diff.tcl:132
+#: lib/diff.tcl:137
 msgid "LOCAL:\n"
 msgstr "=D0=9B=D0=9E=D0=9A=D0=90=D0=9B=D0=AC=D0=9D=D0=9E:\n"
=20
-#: lib/diff.tcl:135
+#: lib/diff.tcl:140
 msgid "REMOTE:\n"
 msgstr "=D0=92=D0=9D=D0=95=D0=A8=D0=9D=D0=98=D0=99:\n"
=20
-#: lib/diff.tcl:197 lib/diff.tcl:296
+#: lib/diff.tcl:202 lib/diff.tcl:319
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BA=D0=B0=
=D0=B7=D0=B0=D1=82=D1=8C %s"
=20
-#: lib/diff.tcl:198
+#: lib/diff.tcl:203
 msgid "Error loading file:"
 msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=D0=B0=D0=B3=D1=80=D1=
=83=D0=B7=D0=BA=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0:"
=20
-#: lib/diff.tcl:205
+#: lib/diff.tcl:210
 msgid "Git Repository (subproject)"
 msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 Git (=D0=BF=D0=BE=D0=B4=D0=BF=D1=80=D0=BE=D0=B5=D0=BA=D1=82)"
=20
-#: lib/diff.tcl:217
+#: lib/diff.tcl:222
 msgid "* Binary file (not showing content)."
 msgstr "* =D0=94=D0=B2=D0=BE=D0=B8=D1=87=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=
=D0=B9=D0=BB (=D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=BC=D0=BE=D0=
=B5 =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE)"
=20
-#: lib/diff.tcl:222
+#: lib/diff.tcl:227
 #, tcl-format
 msgid ""
 "* Untracked file is %d bytes.\n"
@@ -1602,7 +1635,7 @@ msgstr ""
 "* =D0=A0=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B5=D0=BF=D0=BE=D0=B4=
=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE=
 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 %d =D0=B1=D0=B0=D0=B9=D1=82.\n"
 "* =D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE =D0=BF=D0=B5=D1=80=
=D0=B2=D1=8B=D1=85 %d =D0=B1=D0=B0=D0=B9=D1=82.\n"
=20
-#: lib/diff.tcl:228
+#: lib/diff.tcl:233
 #, tcl-format
 msgid ""
 "\n"
@@ -1613,19 +1646,19 @@ msgstr ""
 "* =D0=9D=D0=B5=D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=
=B5=D0=BD=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB =D0=BE=D0=B1=D1=80=
=D0=B5=D0=B7=D0=B0=D0=BD: %s.\n"
 "* =D0=A7=D1=82=D0=BE=D0=B1=D1=8B =D1=83=D0=B2=D0=B8=D0=B4=D0=B5=D1=82=
=D1=8C =D0=B2=D0=B5=D1=81=D1=8C =D1=84=D0=B0=D0=B9=D0=BB, =D0=B8=D1=81=D0=
=BF=D0=BE=D0=BB=D1=8C=D0=B7=D1=83=D0=B9=D1=82=D0=B5 =D0=BF=D1=80=D0=BE=D0=
=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=83-=D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=
=BE=D1=80.\n"
=20
-#: lib/diff.tcl:436
+#: lib/diff.tcl:482
 msgid "Failed to unstage selected hunk."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B8=
=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=B1=D1=80=
=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=87=D0=B0=D1=81=D1=82=D1=8C."
=20
-#: lib/diff.tcl:443
+#: lib/diff.tcl:489
 msgid "Failed to stage selected hunk."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=BA =D1=
=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E =D0=B2=D1=8B=D0=
=B1=D1=80=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=87=D0=B0=D1=81=D1=82=D1=8C.=
"
=20
-#: lib/diff.tcl:509
+#: lib/diff.tcl:568
 msgid "Failed to unstage selected line."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B8=
=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=B1=D1=80=
=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=83."
=20
-#: lib/diff.tcl:517
+#: lib/diff.tcl:576
 msgid "Failed to stage selected line."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=BA =D1=
=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E =D0=B2=D1=8B=D0=
=B1=D1=80=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=
=83."
=20
@@ -1662,7 +1695,7 @@ msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=
=D1=81=D1=8C =D1=80=D0=B0=D0=B7=D0=B1=D0=BB=D0=BE=D0=BA=D0=B8=D1=80=D0=BE=
=D0=B2=D0=B0=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
 msgid "Index Error"
 msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2 =D0=B8=D0=BD=D0=B4=
=D0=B5=D0=BA=D1=81=D0=B5"
=20
-#: lib/index.tcl:21
+#: lib/index.tcl:17
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically starte=
d to "
 "resynchronize git-gui."
@@ -1670,7 +1703,7 @@ msgstr ""
 "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BE=D0=B1=D0=
=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81 =
Git. =D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=B1=D1=83=D0=B4=
=D0=B5=D1=82 =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BE=
 "
 "=D0=B0=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=
=BA=D0=B8."
=20
-#: lib/index.tcl:27
+#: lib/index.tcl:28
 msgid "Continue"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C"
=20
@@ -1678,45 +1711,45 @@ msgstr "=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=
=B6=D0=B8=D1=82=D1=8C"
 msgid "Unlock Index"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=B1=D0=BB=D0=BE=D0=BA=D0=B8=D1=80=D0=BE=D0=
=B2=D0=B0=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
=20
-#: lib/index.tcl:287
+#: lib/index.tcl:289
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 %s =D0=B8=D0=B7=
 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=B3=D0=BE"
=20
-#: lib/index.tcl:326
+#: lib/index.tcl:328
 msgid "Ready to commit."
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8F"
=20
-#: lib/index.tcl:339
+#: lib/index.tcl:341
 #, tcl-format
 msgid "Adding %s"
 msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 %=
s..."
=20
-#: lib/index.tcl:396
+#: lib/index.tcl:398
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=B5 %s?"
=20
-#: lib/index.tcl:398
+#: lib/index.tcl:400
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 %i =D1=84=D0=B0=D0=B9=D0=
=BB=D0=B5(-=D0=B0=D1=85)?"
=20
-#: lib/index.tcl:406
+#: lib/index.tcl:408
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 "=D0=9B=D1=8E=D0=B1=D1=8B=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=
=BD=D0=B8=D1=8F, =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=
=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA =D1=81=D0=BE=D1=85=D1=
=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E, =D0=B1=D1=83=D0=B4=D1=83=D1=82=
 =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B =D0=BF=D1=80=D0=B8 =D0=
=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9 "
 "=D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8."
=20
-#: lib/index.tcl:409
+#: lib/index.tcl:411
 msgid "Do Nothing"
 msgstr "=D0=9D=D0=B8=D1=87=D0=B5=D0=B3=D0=BE =D0=BD=D0=B5 =D0=B4=D0=B5=
=D0=BB=D0=B0=D1=82=D1=8C"
=20
-#: lib/index.tcl:427
+#: lib/index.tcl:429
 msgid "Reverting selected files"
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B2 =D0=B2=D1=8B=D0=B1=D1=80=
=D0=B0=D0=BD=D0=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D1=85"
=20
-#: lib/index.tcl:431
+#: lib/index.tcl:433
 #, tcl-format
 msgid "Reverting %s"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=D0=
=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B2 %s"
@@ -2193,10 +2226,6 @@ msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C=
 =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=B2 =D1=81=D0=BB=D1=83=D1=87=D0=
=B0=D0=B5, =D0=B5=D1=81=D0=BB=D0=B8"
 msgid "Merged Into:"
 msgstr "=D0=A1=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 =D1=81:"
=20
-#: lib/remote_branch_delete.tcl:119
-msgid "Always (Do not perform merge checks)"
-msgstr "=D0=92=D1=81=D0=B5=D0=B3=D0=B4=D0=B0 (=D0=BD=D0=B5 =D0=B2=D1=8B=
=D0=BF=D0=BE=D0=BB=D0=BD=D1=8F=D1=82=D1=8C =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=
=D1=80=D0=BA=D1=83 =D0=BD=D0=B0 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D0=
=B5)"
-
 #: lib/remote_branch_delete.tcl:152
 msgid "A branch is required for 'Merged Into'."
 msgstr "=D0=94=D0=BB=D1=8F =D0=BE=D0=BF=D1=86=D0=B8=D0=B8 '=D0=A1=D0=BB=
=D0=B8=D1=8F=D0=BD=D0=B8=D0=B5 =D1=81' =D1=82=D1=80=D0=B5=D0=B1=D1=83=D0=
=B5=D1=82=D1=81=D1=8F =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B2=
=D0=B5=D1=82=D0=B2=D1=8C."
@@ -2225,26 +2254,16 @@ msgstr ""
 msgid "Please select one or more branches to delete."
 msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=BE=D0=B4=D0=BD=D1=
=83 =D0=B8=D0=BB=D0=B8 =D0=BD=D0=B5=D1=81=D0=BA=D0=BE=D0=BB=D1=8C=D0=BA=
=D0=BE =D0=B2=D0=B5=D1=82=D0=B2=D0=B5=D0=B9 =D0=B4=D0=BB=D1=8F =D1=83=D0=
=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F."
=20
-#: lib/remote_branch_delete.tcl:216
-msgid ""
-"Recovering deleted branches is difficult.\n"
-"\n"
-"Delete the selected branches?"
-msgstr ""
-"=D0=92=D0=BE=D1=81=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B2=D0=B5=
=D1=82=D0=B2=D0=B8 =D1=81=D0=BB=D0=BE=D0=B6=D0=BD=D0=BE.\n"
-"\n"
-"=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C?"
-
 #: lib/remote_branch_delete.tcl:226
 #, tcl-format
 msgid "Deleting branches from %s"
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B5=D0=B9 =D0=B8=D0=B7 %s"
=20
-#: lib/remote_branch_delete.tcl:286
+#: lib/remote_branch_delete.tcl:292
 msgid "No repository selected."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9."
=20
-#: lib/remote_branch_delete.tcl:291
+#: lib/remote_branch_delete.tcl:297
 #, tcl-format
 msgid "Scanning %s..."
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D1=8B=D0=B2=D0=B0=D0=
=BD=D0=B8=D0=B5 %s... "
@@ -2265,11 +2284,11 @@ msgstr "=D0=9E=D0=B1=D1=80=D0=B0=D1=82=D0=BD=D0=
=BE"
 msgid "Case-Sensitive"
 msgstr "=D0=98=D0=B3=D0=BD. =D0=B1=D0=BE=D0=BB=D1=8C=D1=88=D0=B8=D0=B5=
/=D0=BC=D0=B0=D0=BB=D0=B5=D0=BD=D1=8C=D0=BA=D0=B8=D0=B5"
=20
-#: lib/shortcut.tcl:20 lib/shortcut.tcl:61
+#: lib/shortcut.tcl:21 lib/shortcut.tcl:62
 msgid "Cannot write shortcut:"
 msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D1=81=D1=81=D1=8B=D0=BB=D0=
=BA=D1=83:"
=20
-#: lib/shortcut.tcl:136
+#: lib/shortcut.tcl:137
 msgid "Cannot write icon:"
 msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D0=B7=D0=BD=D0=B0=D1=87=D0=
=BE=D0=BA:"
=20
--=20
1.7.3.4.643.g8fb2b
