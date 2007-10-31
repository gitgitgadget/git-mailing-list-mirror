From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Updated russian translation of git-gui
Date: Wed, 31 Oct 2007 22:16:17 +0100
Message-ID: <20071031211617.GA4255@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 22:18:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InKxL-0003J0-Cf
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760639AbXJaVQb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 17:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756415AbXJaVQa
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:16:30 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:32045 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760239AbXJaVQX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:16:23 -0400
Received: from tigra.home (Fadfc.f.strato-dslnet.de [195.4.173.252])
	by post.webmailer.de (fruni mo41) (RZmta 14.0)
	with ESMTP id i06adbj9VIiRXs ; Wed, 31 Oct 2007 22:16:19 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 7F6BA277AE;
	Wed, 31 Oct 2007 22:16:18 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 13E5056D22; Wed, 31 Oct 2007 22:16:18 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClJwDS0=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62874>

=46ixed some spelling mistakes.
---
 po/ru.po |  516 +++++++++++++++++++++++++++++++++++-------------------=
--------
 1 files changed, 292 insertions(+), 224 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index b8e9447..6727a83 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -7,7 +7,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2007-10-10 04:04-0400\n"
+"POT-Creation-Date: 2007-10-31 21:23+0100\n"
 "PO-Revision-Date: 2007-10-22 22:30-0200\n"
 "Last-Translator: Alex Riesen <raa.lkml@gmail.com>\n"
 "Language-Team: Russian Translation <git@vger.kernel.org>\n"
@@ -15,33 +15,33 @@ msgstr ""
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.=
sh:744
-#: git-gui.sh:763
+#: git-gui.sh:41 git-gui.sh:597 git-gui.sh:611 git-gui.sh:624 git-gui.=
sh:707
+#: git-gui.sh:726
 msgid "git-gui: fatal error"
 msgstr "git-gui: =D0=BA=D1=80=D0=B8=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=
=D0=B0=D1=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0"
=20
-#: git-gui.sh:595
+#: git-gui.sh:558
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "=D0=92 %s =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=
=D0=BD =D0=BD=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D1=8B=D0=B9 =D1=88=D1=80=D0=
=B8=D1=84=D1=82:"
=20
-#: git-gui.sh:620
+#: git-gui.sh:583
 msgid "Main Font"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D1=
=84=D0=B5=D0=B9=D1=81=D0=B0"
=20
-#: git-gui.sh:621
+#: git-gui.sh:584
 msgid "Diff/Console Font"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=BA=D0=BE=D0=BD=D1=81=D0=BE=D0=
=BB=D0=B8 =D0=B8 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9=
 (diff)"
=20
-#: git-gui.sh:635
+#: git-gui.sh:598
 msgid "Cannot find git in PATH."
 msgstr "git =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD =D0=B2 P=
ATH."
=20
-#: git-gui.sh:662
+#: git-gui.sh:625
 msgid "Cannot parse Git version string:"
 msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D1=
=80=D0=B0=D1=81=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D1=8C =D1=81=D1=82=D1=
=80=D0=BE=D0=BA=D1=83 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D0=B8 Git: "
=20
-#: git-gui.sh:680
+#: git-gui.sh:643
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -59,79 +59,79 @@ msgstr ""
 "\n"
 "=D0=9F=D1=80=D0=B8=D0=BD=D1=8F=D1=82=D1=8C '%s' =D0=BA=D0=B0=D0=BA =D0=
=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E 1.5.0?\n"
=20
-#: git-gui.sh:853
+#: git-gui.sh:881
 msgid "Git directory not found:"
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 Git =D0=BD=D0=B5 =D0=
=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD:"
=20
-#: git-gui.sh:860
+#: git-gui.sh:888
 msgid "Cannot move to top of working directory:"
 msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=BF=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BA=D0=BE=D1=80=D0=BD=
=D1=8E =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=
=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B0 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D1=8F: "
=20
-#: git-gui.sh:867
+#: git-gui.sh:895
 msgid "Cannot use funny .git directory:"
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3.git =D0=B8=D1=81=D0=
=BF=D0=BE=D1=80=D1=87=D0=B5=D0=BD: "
=20
-#: git-gui.sh:872
+#: git-gui.sh:900
 msgid "No working directory"
 msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=
=82 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=
=D0=BB=D0=BE=D0=B3"
=20
-#: git-gui.sh:1019
+#: git-gui.sh:1047
 msgid "Refreshing file status..."
 msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D0=B8 =D0=BE =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=BE=D0=B2..."
=20
-#: git-gui.sh:1084
+#: git-gui.sh:1112
 msgid "Scanning for modified files ..."
 msgstr "=D0=9F=D0=BE=D0=B8=D1=81=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=
=B5=D0=BD=D0=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2..."
=20
-#: git-gui.sh:1259 lib/browser.tcl:245
+#: git-gui.sh:1287 lib/browser.tcl:245
 msgid "Ready."
 msgstr "=D0=93=D0=BE=D1=82=D0=BE=D0=B2=D0=BE."
=20
-#: git-gui.sh:1525
+#: git-gui.sh:1553
 msgid "Unmodified"
 msgstr "=D0=9D=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE"
=20
-#: git-gui.sh:1527
+#: git-gui.sh:1555
 msgid "Modified, not staged"
 msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE, =D0=BD=D0=B5=
 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE=
"
=20
-#: git-gui.sh:1528 git-gui.sh:1533
+#: git-gui.sh:1556 git-gui.sh:1561
 msgid "Staged for commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:1529 git-gui.sh:1534
+#: git-gui.sh:1557 git-gui.sh:1562
 msgid "Portions staged for commit"
 msgstr "=D0=A7=D0=B0=D1=81=D1=82=D0=B8, =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=
=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B4=D0=BB=D1=8F=
 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:1530 git-gui.sh:1535
+#: git-gui.sh:1558 git-gui.sh:1563
 msgid "Staged for commit, missing"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8F, =D0=BE=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=
=83=D0=B5=D1=82"
=20
-#: git-gui.sh:1532
+#: git-gui.sh:1560
 msgid "Untracked, not staged"
 msgstr "=D0=9D=D0=B5 =D0=BE=D1=82=D1=81=D0=BB=D0=B5=D0=B6=D0=B8=D0=B2=D0=
=B0=D0=B5=D1=82=D1=81=D1=8F, =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=
=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE"
=20
-#: git-gui.sh:1537
+#: git-gui.sh:1565
 msgid "Missing"
 msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=
=82"
=20
-#: git-gui.sh:1538
+#: git-gui.sh:1566
 msgid "Staged for removal"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=
=D1=8F"
=20
-#: git-gui.sh:1539
+#: git-gui.sh:1567
 msgid "Staged for removal, still present"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=
=D1=8F, =D0=B5=D1=89=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=
=BD=D0=BE"
=20
-#: git-gui.sh:1541 git-gui.sh:1542 git-gui.sh:1543 git-gui.sh:1544
+#: git-gui.sh:1569 git-gui.sh:1570 git-gui.sh:1571 git-gui.sh:1572
 msgid "Requires merge resolution"
 msgstr "=D0=A2=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=D1=8F =D1=80=D0=
=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BA=D0=BE=D0=BD=D1=
=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BE=D0=B1=D1=8A=
=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B8"
=20
-#: git-gui.sh:1579
+#: git-gui.sh:1607
 msgid "Starting gitk... please wait..."
 msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=BA=D0=B0=D0=B5=D1=82=D1=81=D1=
=8F gitk... =D0=BF=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0=
, =D0=B6=D0=B4=D0=B8=D1=82=D0=B5..."
=20
-#: git-gui.sh:1588
+#: git-gui.sh:1616
 #, tcl-format
 msgid ""
 "Unable to start gitk:\n"
@@ -142,296 +142,295 @@ msgstr ""
 "\n"
 "%s =D0=BD=D0=B5 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=
=D1=82"
=20
-#: git-gui.sh:1788 lib/choose_repository.tcl:32
+#: git-gui.sh:1816 lib/choose_repository.tcl:35
 msgid "Repository"
 msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
-#: git-gui.sh:1789
+#: git-gui.sh:1817
 msgid "Edit"
 msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C"
=20
-#: git-gui.sh:1791 lib/choose_rev.tcl:560
+#: git-gui.sh:1819 lib/choose_rev.tcl:560
 msgid "Branch"
 msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C"
=20
-#: git-gui.sh:1794 lib/choose_rev.tcl:547
+#: git-gui.sh:1822 lib/choose_rev.tcl:547
 msgid "Commit@@noun"
 msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
=20
-#: git-gui.sh:1797 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
+#: git-gui.sh:1825 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "=D0=9E=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:1798 lib/choose_rev.tcl:556
+#: git-gui.sh:1826 lib/choose_rev.tcl:556
 msgid "Remote"
 msgstr "=D0=92=D0=BD=D0=B5=D1=88=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8"
=20
-#: git-gui.sh:1807
+#: git-gui.sh:1835
 msgid "Browse Current Branch's Files"
 msgstr "=D0=9F=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B5=D1=82=D1=
=8C =D1=84=D0=B0=D0=B9=D0=BB=D1=8B =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=
=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
=20
-#: git-gui.sh:1811
+#: git-gui.sh:1839
 msgid "Browse Branch Files..."
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8..."
=20
-#: git-gui.sh:1816
+#: git-gui.sh:1844
 msgid "Visualize Current Branch's History"
 msgstr "=D0=98=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D1=82=D0=B5=D0=BA=D1=
=83=D1=89=D0=B5=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=BD=D0=B0=D0=B3=
=D0=BB=D1=8F=D0=B4=D0=BD=D0=BE"
=20
-#: git-gui.sh:1820
+#: git-gui.sh:1848
 msgid "Visualize All Branch History"
 msgstr "=D0=98=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=B2=D1=81=D0=B5=D1=
=85 =D0=B2=D0=B5=D1=82=D0=B2=D0=B5=D0=B9 =D0=BD=D0=B0=D0=B3=D0=BB=D1=8F=
=D0=B4=D0=BD=D0=BE"
=20
-#: git-gui.sh:1827
+#: git-gui.sh:1855
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 %s"
=20
-#: git-gui.sh:1829
+#: git-gui.sh:1857
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "=D0=98=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=B2=D0=B5=D1=82=D0=
=B2=D0=B8 %s =D0=BD=D0=B0=D0=B3=D0=BB=D1=8F=D0=B4=D0=BD=D0=BE"
=20
-#: git-gui.sh:1834 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:1862 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "=D0=A1=D1=82=D0=B0=D1=82=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B0 =D0=
=B1=D0=B0=D0=B7=D1=8B =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
=20
-#: git-gui.sh:1837 lib/database.tcl:34
+#: git-gui.sh:1865 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "=D0=A1=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=D0=B7=D1=83 =D0=B4=
=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
=20
-#: git-gui.sh:1840
+#: git-gui.sh:1868
 msgid "Verify Database"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D1=8C =D0=B1=D0=
=B0=D0=B7=D1=83 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
=20
-#: git-gui.sh:1847 git-gui.sh:1851 git-gui.sh:1855 lib/shortcut.tcl:9
-#: lib/shortcut.tcl:45 lib/shortcut.tcl:84
+#: git-gui.sh:1875 git-gui.sh:1879 git-gui.sh:1883 lib/shortcut.tcl:7
+#: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D1=8F=D1=80=D0=BB=D1=
=8B=D0=BA =D0=BD=D0=B0 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D1=81=
=D1=82=D0=BE=D0=BB=D0=B5"
=20
-#: git-gui.sh:1860 lib/choose_repository.tcl:36 lib/choose_repository.=
tcl:95
+#: git-gui.sh:1888 lib/choose_repository.tcl:176 lib/choose_repository=
=2Etcl:184
 msgid "Quit"
 msgstr "=D0=92=D1=8B=D1=85=D0=BE=D0=B4"
=20
-#: git-gui.sh:1867
+#: git-gui.sh:1895
 msgid "Undo"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:1870
+#: git-gui.sh:1898
 msgid "Redo"
 msgstr "=D0=9F=D0=BE=D0=B2=D1=82=D0=BE=D1=80=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:1874 git-gui.sh:2366
+#: git-gui.sh:1902 git-gui.sh:2395
 msgid "Cut"
 msgstr "=D0=92=D1=8B=D1=80=D0=B5=D0=B7=D0=B0=D1=82=D1=8C"
=20
-#: git-gui.sh:1877 git-gui.sh:2369 git-gui.sh:2440 git-gui.sh:2512
+#: git-gui.sh:1905 git-gui.sh:2398 git-gui.sh:2469 git-gui.sh:2541
 #: lib/console.tcl:67
 msgid "Copy"
 msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C"
=20
-#: git-gui.sh:1880 git-gui.sh:2372
+#: git-gui.sh:1908 git-gui.sh:2401
 msgid "Paste"
 msgstr "=D0=92=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:1883 git-gui.sh:2375 lib/branch_delete.tcl:26
+#: git-gui.sh:1911 git-gui.sh:2404 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:1887 git-gui.sh:2379 git-gui.sh:2516 lib/console.tcl:69
+#: git-gui.sh:1915 git-gui.sh:2408 git-gui.sh:2545 lib/console.tcl:69
 msgid "Select All"
 msgstr "=D0=92=D1=8B=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D1=81=D0=
=B5"
=20
-#: git-gui.sh:1896
+#: git-gui.sh:1924
 msgid "Create..."
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C..."
=20
-#: git-gui.sh:1902
+#: git-gui.sh:1930
 msgid "Checkout..."
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8..."
=20
-#: git-gui.sh:1908
+#: git-gui.sh:1936
 msgid "Rename..."
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C..."
=20
-#: git-gui.sh:1913 git-gui.sh:2012
+#: git-gui.sh:1941 git-gui.sh:2040
 msgid "Delete..."
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C..."
=20
-#: git-gui.sh:1918
+#: git-gui.sh:1946
 msgid "Reset..."
 msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C..."
=20
-#: git-gui.sh:1930 git-gui.sh:2313
+#: git-gui.sh:1958 git-gui.sh:2342
 msgid "New Commit"
 msgstr "=D0=9D=D0=BE=D0=B2=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D0=B5"
=20
-#: git-gui.sh:1938 git-gui.sh:2320
+#: git-gui.sh:1966 git-gui.sh:2349
 msgid "Amend Last Commit"
 msgstr "=D0=98=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=BF=D0=
=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B5"
=20
-#: git-gui.sh:1947 git-gui.sh:2280 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:1975 git-gui.sh:2309 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C"
=20
-#: git-gui.sh:1953
+#: git-gui.sh:1981
 msgid "Stage To Commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=
=D0=B8=D1=8F"
=20
-#: git-gui.sh:1958
+#: git-gui.sh:1986
 msgid "Stage Changed Files To Commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D1=84=
=D0=B0=D0=B9=D0=BB=D1=8B =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=
=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:1964
+#: git-gui.sh:1992
 msgid "Unstage From Commit"
 msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=B8=D0=B7 =D0=BF=D0=BE=
=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=
=D0=BE"
=20
-#: git-gui.sh:1969 lib/index.tcl:352
+#: git-gui.sh:1997 lib/index.tcl:393
 msgid "Revert Changes"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:1976 git-gui.sh:2292 git-gui.sh:2390
+#: git-gui.sh:2004 git-gui.sh:2321 git-gui.sh:2419
 msgid "Sign Off"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C"
=20
-#: git-gui.sh:1980 git-gui.sh:2296
+#: git-gui.sh:2008 git-gui.sh:2325
 msgid "Commit@@verb"
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:1991
+#: git-gui.sh:2019
 msgid "Local Merge..."
 msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B5 =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5..."
=20
-#: git-gui.sh:1996
+#: git-gui.sh:2024
 msgid "Abort Merge..."
 msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=B1=D1=
=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5..."
=20
-#: git-gui.sh:2008
+#: git-gui.sh:2036
 msgid "Push..."
 msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C..."
=20
-#: git-gui.sh:2019 lib/choose_repository.tcl:41
-#, fuzzy
+#: git-gui.sh:2047 lib/choose_repository.tcl:40
 msgid "Apple"
 msgstr ""
=20
-#: git-gui.sh:2022 git-gui.sh:2044 lib/about.tcl:13
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
+#: git-gui.sh:2050 git-gui.sh:2072 lib/about.tcl:13
+#: lib/choose_repository.tcl:43 lib/choose_repository.tcl:49
 #, tcl-format
 msgid "About %s"
 msgstr "=D0=9E %s"
=20
-#: git-gui.sh:2026
+#: git-gui.sh:2054
 msgid "Preferences..."
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8..."
=20
-#: git-gui.sh:2034 git-gui.sh:2558
+#: git-gui.sh:2062 git-gui.sh:2587
 msgid "Options..."
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8..."
=20
-#: git-gui.sh:2040 lib/choose_repository.tcl:47
+#: git-gui.sh:2068 lib/choose_repository.tcl:46
 msgid "Help"
 msgstr "=D0=9F=D0=BE=D0=BC=D0=BE=D1=89=D1=8C"
=20
-#: git-gui.sh:2081
+#: git-gui.sh:2109
 msgid "Online Documentation"
 msgstr "=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=
=B8=D1=8F =D0=B2 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D0=BD=D0=B5=D1=82=D0=B5=
"
=20
-#: git-gui.sh:2165
+#: git-gui.sh:2193
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr "=D0=BA=D1=80=D0=B8=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B0=D1=
=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0: %s: =D0=BD=D0=B5=D1=82 =D1=82=
=D0=B0=D0=BA=D0=BE=D0=B3=D0=BE =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=
=BB=D0=B8 =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B0"
=20
-#: git-gui.sh:2198
+#: git-gui.sh:2226
 msgid "Current Branch:"
 msgstr "=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B0=D1=8F =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C:"
=20
-#: git-gui.sh:2219
+#: git-gui.sh:2247
 msgid "Staged Changes (Will Commit)"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE (=D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=BE=D1=85=D1=80=D0=B0=
=D0=BD=D0=B5=D0=BD=D0=BE)"
=20
-#: git-gui.sh:2239
+#: git-gui.sh:2266
 msgid "Unstaged Changes"
 msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE (=D0=BD=D0=B5=
 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=
=B5=D0=BD=D0=BE)"
=20
-#: git-gui.sh:2286
+#: git-gui.sh:2315
 msgid "Stage Changed"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B2=D1=81=D0=B5"
=20
-#: git-gui.sh:2302 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2331 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
 msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:2332
+#: git-gui.sh:2361
 msgid "Initial Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=
=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E:"
=20
-#: git-gui.sh:2333
+#: git-gui.sh:2362
 msgid "Amended Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E=
:"
=20
-#: git-gui.sh:2334
+#: git-gui.sh:2363
 msgid "Amended Initial Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=
=D0=BB=D1=8C=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=
=D0=BD=D0=B8=D1=8E:"
=20
-#: git-gui.sh:2335
+#: git-gui.sh:2364
 msgid "Amended Merge Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=
=D0=B8=D1=8E:"
=20
-#: git-gui.sh:2336
+#: git-gui.sh:2365
 msgid "Merge Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=
=D1=8E:"
=20
-#: git-gui.sh:2337
+#: git-gui.sh:2366
 msgid "Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E:"
=20
-#: git-gui.sh:2382 git-gui.sh:2520 lib/console.tcl:71
+#: git-gui.sh:2411 git-gui.sh:2549 lib/console.tcl:71
 msgid "Copy All"
 msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=
=B2=D1=81=D0=B5"
=20
-#: git-gui.sh:2406 lib/blame.tcl:104
+#: git-gui.sh:2435 lib/blame.tcl:104
 msgid "File:"
 msgstr "=D0=A4=D0=B0=D0=B9=D0=BB:"
=20
-#: git-gui.sh:2508
+#: git-gui.sh:2537
 msgid "Refresh"
 msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:2529
+#: git-gui.sh:2558
 msgid "Apply/Reverse Hunk"
 msgstr "=D0=9F=D1=80=D0=B8=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C/=D0=A3=D0=
=B1=D1=80=D0=B0=D1=82=D1=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B5"
=20
-#: git-gui.sh:2535
+#: git-gui.sh:2564
 msgid "Decrease Font Size"
 msgstr "=D0=A3=D0=BC=D0=B5=D0=BD=D1=8C=D1=88=D0=B8=D1=82=D1=8C =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=82=D0=B0"
=20
-#: git-gui.sh:2539
+#: git-gui.sh:2568
 msgid "Increase Font Size"
 msgstr "=D0=A3=D0=B2=D0=B5=D0=BB=D0=B8=D1=87=D0=B8=D1=82=D1=8C =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=82=D0=B0"
=20
-#: git-gui.sh:2544
+#: git-gui.sh:2573
 msgid "Show Less Context"
 msgstr "=D0=9C=D0=B5=D0=BD=D1=8C=D1=88=D0=B5 =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0"
=20
-#: git-gui.sh:2551
+#: git-gui.sh:2580
 msgid "Show More Context"
 msgstr "=D0=91=D0=BE=D0=BB=D1=8C=D1=88=D0=B5 =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0"
=20
-#: git-gui.sh:2565
+#: git-gui.sh:2594
 msgid "Unstage Hunk From Commit"
 msgstr "=D0=9D=D0=B5 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D1=8F=D1=82=D1=
=8C =D1=87=D0=B0=D1=81=D1=82=D1=8C"
=20
-#: git-gui.sh:2567
+#: git-gui.sh:2596
 msgid "Stage Hunk For Commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D1=87=D0=B0=D1=81=D1=82=D1=8C =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=
=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:2586
+#: git-gui.sh:2615
 msgid "Initializing..."
 msgstr "=D0=98=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=B7=D0=B0=D1=
=86=D0=B8=D1=8F..."
=20
-#: git-gui.sh:2677
+#: git-gui.sh:2706
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -448,7 +447,7 @@ msgstr ""
 "=D0=B7=D0=B0=D0=BF=D1=83=D1=89=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC=D0=B8 =D0=
=B8=D0=B7 %s\n"
 "\n"
=20
-#: git-gui.sh:2707
+#: git-gui.sh:2736
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -458,7 +457,7 @@ msgstr ""
 "=D0=AD=D1=82=D0=BE =D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=D0=B0=D1=
=8F =D0=BF=D1=80=D0=BE=D0=B1=D0=BB=D0=B5=D0=BC=D0=B0 =D1=81 Tcl,\n"
 "=D1=80=D0=B0=D1=81=D0=BF=D1=80=D0=BE=D1=81=D1=82=D1=80=D0=B0=D0=BD=D1=
=8F=D0=B5=D0=BC=D1=8B=D0=BC Cygwin."
=20
-#: git-gui.sh:2712
+#: git-gui.sh:2741
 #, tcl-format
 msgid ""
 "\n"
@@ -579,7 +578,7 @@ msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D0=
=B5 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
 msgid "Create New Branch"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BD=D0=BE=D0=B2=D1=
=83=D1=8E =D0=B2=D0=B5=D1=82=D0=B2=D1=8C"
=20
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:199
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:375
 msgid "Create"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C"
=20
@@ -732,9 +731,9 @@ msgstr "[=D0=9D=D0=B0 =D1=83=D1=80=D0=BE=D0=B2=D0=B5=
=D0=BD=D1=8C =D0=B2=D1=8B=D1=88=D0=B5]"
 msgid "Browse Branch Files"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
=20
-#: lib/browser.tcl:277 lib/choose_repository.tcl:215
-#: lib/choose_repository.tcl:305 lib/choose_repository.tcl:315
-#: lib/choose_repository.tcl:811
+#: lib/browser.tcl:277 lib/choose_repository.tcl:391
+#: lib/choose_repository.tcl:482 lib/choose_repository.tcl:492
+#: lib/choose_repository.tcl:989
 msgid "Browse"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C"
=20
@@ -788,7 +787,8 @@ msgstr "=D0=A0=D0=B0=D0=B1=D0=BE=D1=87=D0=B0=D1=8F =
=D0=BE=D0=B1=D0=BB=D0=B0=D1=81=D1=82=D1=8C =D0=B7=D0=B0=D0=B1=D0=BB=D0=BE=
=D0=BA=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B0 =D0=B4=D1=80=D1=83=D0=B3=
=D0=B8=D0=BC =D0=BF
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
-"Another Git program has modified this repository since the last scan.=
  A rescan must be performed before the current branch can be changed.\=
n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before the current branch can be changed.\n"
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
@@ -822,11 +822,13 @@ msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D0=BE=
=D1=81=D1=82=D0=B0=D0=B5=D1=82=D1=81=D1=8F =D1=82=D0=B5=D0=BA=D1=83=D1=89=
=D0=B5=D0=B9."
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
-"If you wanted to be on a branch, create one now starting from 'This D=
etached Checkout'."
+"If you wanted to be on a branch, create one now starting from 'This D=
etached "
+"Checkout'."
 msgstr ""
 "=D0=92=D1=8B =D0=BD=D0=B0=D1=85=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D1=81=D1=
=8C =D0=BD=D0=B5 =D0=B2 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=
=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8.\n"
 "\n"
-"=D0=95=D1=81=D0=BB=D0=B8 =D0=B2=D1=8B =D1=85=D0=BE=D1=82=D0=B8=D1=82=D0=
=B5 =D1=81=D0=BD=D0=BE=D0=B2=D0=B0 =D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=82=
=D1=8C=D1=81=D1=8F =D0=BA =D0=BA=D0=B0=D0=BA=D0=BE=D0=B9-=D0=BD=D0=B8=D0=
=B1=D1=83=D0=B4=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8, =D1=81=D0=BE=D0=B7=
=D0=B4=D0=B0=D0=B9=D1=82=D0=B5 =D0=B5=D0=B5 =D1=81=D0=B5=D0=B9=D1=87=D0=
=B0=D1=81, =D0=BD=D0=B0=D1=87=D0=B8=D0=BD=D0=B0=D1=8F =D1=81 '=D0=A2=D0=
=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B3=D0=BE =D0=BE=D1=82=D1=81=D0=BE=D0=B5=D0=
=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F'."
+"=D0=95=D1=81=D0=BB=D0=B8 =D0=B2=D1=8B =D1=85=D0=BE=D1=82=D0=B8=D1=82=D0=
=B5 =D1=81=D0=BD=D0=BE=D0=B2=D0=B0 =D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=82=
=D1=8C=D1=81=D1=8F =D0=BA =D0=BA=D0=B0=D0=BA=D0=BE=D0=B9-=D0=BD=D0=B8=D0=
=B1=D1=83=D0=B4=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8, =D1=81=D0=BE=D0=B7=
=D0=B4=D0=B0=D0=B9=D1=82=D0=B5 =D0=B5=D0=B5 =D1=81=D0=B5=D0=B9=D1=87=D0=
=B0=D1=81, "
+"=D0=BD=D0=B0=D1=87=D0=B8=D0=BD=D0=B0=D1=8F =D1=81 '=D0=A2=D0=B5=D0=BA=
=D1=83=D1=89=D0=B5=D0=B3=D0=BE =D0=BE=D1=82=D1=81=D0=BE=D0=B5=D0=B4=D0=B8=
=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=
=D1=8F=D0=BD=D0=B8=D1=8F'."
=20
 #: lib/checkout_op.tcl:446
 #, tcl-format
@@ -856,19 +858,21 @@ msgstr "=D0=9D=D0=B0=D0=B3=D0=BB=D1=8F=D0=B4=D0=BD=
=D0=BE"
 msgid ""
 "Failed to set current branch.\n"
 "\n"
-"This working directory is only partially switched.  We successfully u=
pdated your files, but failed to update an internal Git file.\n"
+"This working directory is only partially switched.  We successfully u=
pdated "
+"your files, but failed to update an internal Git file.\n"
 "\n"
 "This should not have occurred.  %s will now close and give up."
 msgstr ""
 "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D1=83=D1=81=D1=
=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=
=89=D1=83=D1=8E =D0=B2=D0=B5=D1=82=D0=B2=D1=8C.\n"
 "\n"
-"=D0=92=D0=B0=D1=88 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=
=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BE=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=
=B5=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D1=87=D0=B0=D1=81=D1=82=
=D0=B8=D1=87=D0=BD=D0=BE. =D0=91=D1=8B=D0=BB=D0=B8 =D0=BE=D0=B1=D0=BD=D0=
=BE=D0=B2=D0=BB=D0=B5=D0=BD=D1=8B =D0=B2=D1=81=D0=B5 =D1=84=D0=B0=D0=B9=
=D0=BB=D1=8B =D0=BA=D1=80=D0=BE=D0=BC=D0=B5 =D1=81=D0=BB=D1=83=D0=B6=D0=
=B5=D0=B1=D0=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 Git. \=
n"
+"=D0=92=D0=B0=D1=88 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=
=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BE=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=
=B5=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D1=87=D0=B0=D1=81=D1=82=
=D0=B8=D1=87=D0=BD=D0=BE. =D0=91=D1=8B=D0=BB=D0=B8 =D0=BE=D0=B1=D0=BD=D0=
=BE=D0=B2=D0=BB=D0=B5=D0=BD=D1=8B =D0=B2=D1=81=D0=B5 =D1=84=D0=B0=D0=B9=
=D0=BB=D1=8B =D0=BA=D1=80=D0=BE=D0=BC=D0=B5 "
+"=D1=81=D0=BB=D1=83=D0=B6=D0=B5=D0=B1=D0=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=
=B9=D0=BB=D0=BE=D0=B2 Git. \n"
 "\n"
 "=D0=AD=D1=82=D0=BE=D0=B3=D0=BE =D0=BD=D0=B5 =D0=B4=D0=BE=D0=BB=D0=B6=D0=
=BD=D0=BE =D0=B1=D1=8B=D0=BB=D0=BE =D0=BF=D1=80=D0=BE=D0=B8=D0=B7=D0=BE=
=D0=B9=D1=82=D0=B8. %s =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B0=D0=B5=
=D1=82=D1=81=D1=8F."
=20
 #: lib/choose_font.tcl:39
 msgid "Select"
-msgstr "=D0=92=D1=8B=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D1=81=D0=
=B5"
+msgstr "=D0=92=D1=8B=D0=B1=D1=80=D0=B0=D1=82=D1=8C"
=20
 #: lib/choose_font.tcl:53
 msgid "Font Family"
@@ -890,210 +894,226 @@ msgstr ""
 "=D0=AD=D1=82=D0=BE =D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80 =D1=82=D0=B5=D0=
=BA=D1=81=D1=82=D0=B0.\n"
 "=D0=95=D1=81=D0=BB=D0=B8 =D0=92=D0=B0=D0=BC =D0=BD=D1=80=D0=B0=D0=B2=D0=
=B8=D1=82=D1=81=D1=8F =D1=8D=D1=82=D0=BE=D1=82 =D1=82=D0=B5=D0=BA=D1=81=
=D1=82, =D1=8D=D1=82=D0=BE =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B1=D1=8B=D1=
=82=D1=8C =D0=92=D0=B0=D1=88 =D1=88=D1=80=D0=B8=D1=84=D1=82."
=20
-#: lib/choose_repository.tcl:25
+#: lib/choose_repository.tcl:27
 msgid "Git Gui"
 msgstr ""
=20
-#: lib/choose_repository.tcl:69 lib/choose_repository.tcl:204
+#: lib/choose_repository.tcl:80 lib/choose_repository.tcl:380
 msgid "Create New Repository"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BD=D0=BE=D0=B2=D1=
=8B=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
-#: lib/choose_repository.tcl:74 lib/choose_repository.tcl:291
+#: lib/choose_repository.tcl:86
+msgid "New..."
+msgstr "=D0=9D=D0=BE=D0=B2=D1=8B=D0=B9..."
+
+#: lib/choose_repository.tcl:93 lib/choose_repository.tcl:468
 msgid "Clone Existing Repository"
 msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=89=D0=
=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
-#: lib/choose_repository.tcl:79 lib/choose_repository.tcl:800
+#: lib/choose_repository.tcl:99
+msgid "Clone..."
+msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C..."
+
+#: lib/choose_repository.tcl:106 lib/choose_repository.tcl:978
 msgid "Open Existing Repository"
 msgstr "=D0=92=D1=8B=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D1=81=D1=83=D1=89=D0=
=B5=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=89=D0=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9"
=20
-#: lib/choose_repository.tcl:91
-msgid "Next >"
-msgstr "=D0=94=D0=B0=D0=BB=D1=8C=D1=88=D0=B5 >"
+#: lib/choose_repository.tcl:112
+msgid "Open..."
+msgstr "=D0=9E=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C..."
=20
-#: lib/choose_repository.tcl:152
+#: lib/choose_repository.tcl:125
+msgid "Recent Repositories"
+msgstr "=D0=9D=D0=B5=D0=B4=D0=B0=D0=B2=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=
=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8"
+
+#: lib/choose_repository.tcl:131
+msgid "Open Recent Repository:"
+msgstr "=D0=9E=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D0=B9"
+
+#: lib/choose_repository.tcl:294
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "=D0=9F=D1=83=D1=82=D1=8C '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=83=D1=
=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
-#: lib/choose_repository.tcl:158 lib/choose_repository.tcl:165
-#: lib/choose_repository.tcl:172
+#: lib/choose_repository.tcl:300 lib/choose_repository.tcl:307
+#: lib/choose_repository.tcl:314
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D1=81=
=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=
=D1=82=D0=BE=D1=80=D0=B8=D0=B9 %s:"
=20
-#: lib/choose_repository.tcl:209 lib/choose_repository.tcl:309
+#: lib/choose_repository.tcl:385 lib/choose_repository.tcl:486
 msgid "Directory:"
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3:"
=20
-#: lib/choose_repository.tcl:238 lib/choose_repository.tcl:363
-#: lib/choose_repository.tcl:834
+#: lib/choose_repository.tcl:415 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1013
 msgid "Git Repository"
 msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
-#: lib/choose_repository.tcl:253 lib/choose_repository.tcl:260
+#: lib/choose_repository.tcl:430 lib/choose_repository.tcl:437
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 '%s' =D1=83=D0=B6=D0=
=B5 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
-#: lib/choose_repository.tcl:265
+#: lib/choose_repository.tcl:442
 #, tcl-format
 msgid "File %s already exists."
 msgstr "=D0=A4=D0=B0=D0=B9=D0=BB '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=83=D1=
=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
-#: lib/choose_repository.tcl:286
+#: lib/choose_repository.tcl:463
 msgid "Clone"
 msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C"
=20
-#: lib/choose_repository.tcl:299
+#: lib/choose_repository.tcl:476
 msgid "URL:"
 msgstr "=D0=A1=D1=81=D1=8B=D0=BB=D0=BA=D0=B0:"
=20
-#: lib/choose_repository.tcl:319
+#: lib/choose_repository.tcl:496
 msgid "Clone Type:"
 msgstr "=D0=A2=D0=B8=D0=BF =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0:"
=20
-#: lib/choose_repository.tcl:325
+#: lib/choose_repository.tcl:502
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D1=8B=D0=
=B9 (=D0=91=D1=8B=D1=81=D1=82=D1=80=D1=8B=D0=B9, =D0=BF=D0=BE=D0=BB=D1=83=
=D0=B8=D0=B7=D0=B1=D1=8B=D1=82=D0=BE=D1=87=D0=BD=D1=8B=D0=B9, \"=D0=B6=D0=
=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B5\" =D1=81=D1=81=D1=8B=D0=BB=D0=BA=D0=B8=
)"
=20
-#: lib/choose_repository.tcl:331
+#: lib/choose_repository.tcl:508
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "=D0=9F=D0=BE=D0=BB=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=BF=D0=B8=D1=
=8F (=D0=9C=D0=B5=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B9, =D1=81=D0=BE=
=D0=B7=D0=B4=D0=B0=D0=B5=D1=82 =D1=80=D0=B5=D0=B7=D0=B5=D1=80=D0=B2=D0=BD=
=D1=83=D1=8E =D0=BA=D0=BE=D0=BF=D0=B8=D1=8E)"
=20
-#: lib/choose_repository.tcl:337
+#: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "=D0=9E=D0=B1=D1=89=D0=B8=D0=B9 (=D0=A1=D0=B0=D0=BC=D1=8B=D0=B9=
 =D0=B1=D1=8B=D1=81=D1=82=D1=80=D1=8B=D0=B9, =D0=BD=D0=B5 =D1=80=D0=B5=D0=
=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=83=D0=B5=D1=82=D1=81=D1=8F, =D0=B1=
=D0=B5=D0=B7 =D1=80=D0=B5=D0=B7=D0=B5=D1=80=D0=B2=D0=BD=D0=BE=D0=B9 =D0=
=BA=D0=BE=D0=BF=D0=B8=D0=B8)"
=20
-#: lib/choose_repository.tcl:369 lib/choose_repository.tcl:418
-#: lib/choose_repository.tcl:560 lib/choose_repository.tcl:630
-#: lib/choose_repository.tcl:840 lib/choose_repository.tcl:848
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:738 lib/choose_repository.tcl:808
+#: lib/choose_repository.tcl:1019 lib/choose_repository.tcl:1027
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BD=D0=B5 =D1=8F=
=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=8F =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=
=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B5=D0=BC: %s"
=20
-#: lib/choose_repository.tcl:405
+#: lib/choose_repository.tcl:586
 msgid "Standard only available for local repository."
 msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D1=8B=D0=
=B9 =D0=BA=D0=BB=D0=BE=D0=BD =D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=B5=
=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=B4=D0=BB=D1=8F =D0=BB=D0=
=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B3=D0=BE =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F."
=20
-#: lib/choose_repository.tcl:409
+#: lib/choose_repository.tcl:590
 msgid "Shared only available for local repository."
 msgstr "=D0=9E=D0=B1=D1=89=D0=B8=D0=B9 =D0=BA=D0=BB=D0=BE=D0=BD =D0=B2=
=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=B5=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=
=D0=BE =D0=B4=D0=BB=D1=8F =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=
=BE=D0=B3=D0=BE =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F."
=20
-#: lib/choose_repository.tcl:439
+#: lib/choose_repository.tcl:617
 msgid "Failed to configure origin"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BA=D0=BE=D0=BD=
=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C=
 =D0=B8=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D1=8B=D0=B9 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9."
=20
-#: lib/choose_repository.tcl:451
+#: lib/choose_repository.tcl:629
 msgid "Counting objects"
 msgstr "=D0=A1=D1=87=D0=B8=D1=82=D0=B0=D1=8E =D0=BE=D0=B1=D1=8A=D0=B5=D0=
=BA=D1=82=D1=8B"
=20
-#: lib/choose_repository.tcl:452
-#, fuzzy
+#: lib/choose_repository.tcl:630
 msgid "buckets"
 msgstr ""
=20
-#: lib/choose_repository.tcl:476
+#: lib/choose_repository.tcl:654
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BA=D0=BE=D0=BF=
=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C objects/info/alternates: %s"
=20
-#: lib/choose_repository.tcl:512
+#: lib/choose_repository.tcl:690
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "=D0=9D=D0=B5=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=BB=D0=BE=D0=BD=D0=
=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D1=81 %s."
=20
-#: lib/choose_repository.tcl:514 lib/choose_repository.tcl:728
-#: lib/choose_repository.tcl:740
+#: lib/choose_repository.tcl:692 lib/choose_repository.tcl:906
+#: lib/choose_repository.tcl:918
 msgid "The 'master' branch has not been initialized."
 msgstr "=D0=9D=D0=B5 =D0=B8=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=
=B7=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B0 =D0=B2=D0=B5=D1=82=D0=B2=D1=
=8C 'master'."
=20
-#: lib/choose_repository.tcl:527
+#: lib/choose_repository.tcl:705
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "\"=D0=96=D0=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B5 =D1=81=D1=81=D1=8B=
=D0=BB=D0=BA=D0=B8\" =D0=BD=D0=B5 =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=
=BD=D1=8B. =D0=91=D1=83=D0=B4=D1=83 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=
=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5."
=20
-#: lib/choose_repository.tcl:539
+#: lib/choose_repository.tcl:717
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=B8=D0=B5 %s"
=20
-#: lib/choose_repository.tcl:570
+#: lib/choose_repository.tcl:748
 msgid "Copying objects"
 msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=
=B5 objects"
=20
-#: lib/choose_repository.tcl:571
+#: lib/choose_repository.tcl:749
 msgid "KiB"
 msgstr "=D0=9A=D0=91"
=20
-#: lib/choose_repository.tcl:595
+#: lib/choose_repository.tcl:773
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BA=D0=BE=D0=BF=
=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=
=D1=82: %s"
=20
-#: lib/choose_repository.tcl:605
+#: lib/choose_repository.tcl:783
 msgid "Linking objects"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D0=B5 =D1=81=D1=81=D1=
=8B=D0=BB=D0=BE=D0=BA =D0=BD=D0=B0 objects"
=20
-#: lib/choose_repository.tcl:606
+#: lib/choose_repository.tcl:784
 msgid "objects"
 msgstr "=D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D1=8B"
=20
-#: lib/choose_repository.tcl:614
+#: lib/choose_repository.tcl:792
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 \"=D0=B6=D0=B5=D1=81=D1=82=
=D0=BA=D0=BE =D1=81=D0=B2=D1=8F=D0=B7=D0=B0=D1=82=D1=8C\" =D0=BE=D0=B1=D1=
=8A=D0=B5=D0=BA=D1=82: %s"
=20
-#: lib/choose_repository.tcl:669
+#: lib/choose_repository.tcl:847
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
-msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=B8 =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=BA=D1=82=D1=8B. =D0=94=D0=BE=D0=BF=D0=BE=D0=BB=D0=BD=
=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B8=D0=BD=D1=84=D0=BE=
=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=
=81=D0=BE=D0=BB=D0=B8."
+msgstr ""
+"=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=
=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=B8 =D0=BE=D0=B1=D1=8A=
=D0=B5=D0=BA=D1=82=D1=8B. =D0=94=D0=BE=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=
=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=
=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=81=D0=BE=
=D0=BB=D0=B8."
=20
-#: lib/choose_repository.tcl:680
+#: lib/choose_repository.tcl:858
 msgid "Cannot fetch tags.  See console output for details."
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B8=D1=82=D1=8C =D0=BC=D0=B5=D1=82=D0=BA=D0=B8. =D0=94=D0=BE=D0=
=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=
=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =
=D0=BA=D0=BE=D0=BD=D1=81=D0=BE=D0=BB=D0=B8."
=20
-#: lib/choose_repository.tcl:704
+#: lib/choose_repository.tcl:882
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BE=D0=BF=D1=80=D0=B5=
=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C HEAD. =D0=94=D0=BE=D0=BF=D0=BE=D0=BB=
=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B8=D0=BD=D1=84=
=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BA=D0=BE=D0=
=BD=D1=81=D0=BE=D0=BB=D0=B8."
=20
-#: lib/choose_repository.tcl:713
+#: lib/choose_repository.tcl:891
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BE=D1=87=D0=B8=D1=81=
=D1=82=D0=B8=D1=82=D1=8C %s"
=20
-#: lib/choose_repository.tcl:719
+#: lib/choose_repository.tcl:897
 msgid "Clone failed."
 msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=B8=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C."
=20
-#: lib/choose_repository.tcl:726
+#: lib/choose_repository.tcl:904
 msgid "No default branch obtained."
 msgstr "=D0=9D=D0=B5 =D0=B1=D1=8B=D0=BB=D0=BE =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B5=D0=BD=D0=BE =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=BF=D0=BE =D1=
=83=D0=BC=D0=BE=D0=BB=D1=87=D0=B0=D0=BD=D0=B8=D1=8E."
=20
-#: lib/choose_repository.tcl:737
+#: lib/choose_repository.tcl:915
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=80=D0=B0=D1=81=D0=BF=
=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D1=8C %s =D0=BA=D0=B0=D0=BA =D1=81=D0=BE=
=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5."
=20
-#: lib/choose_repository.tcl:749
+#: lib/choose_repository.tcl:927
 msgid "Creating working directory"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=8E =D1=80=D0=B0=D0=B1=D0=BE=D1=
=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3"
=20
-#: lib/choose_repository.tcl:750 lib/index.tcl:15 lib/index.tcl:80
-#: lib/index.tcl:149
+#: lib/choose_repository.tcl:928 lib/index.tcl:65 lib/index.tcl:127
+#: lib/index.tcl:193
 msgid "files"
 msgstr "=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2"
=20
-#: lib/choose_repository.tcl:779
+#: lib/choose_repository.tcl:957
 msgid "Initial file checkout failed."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D0=BD=D0=B0=D1=87=D0=B0=D0=BB=
=D1=8C=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D1=80=D0=B5=D0=BF=D0=BE=D0=
=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F."
=20
-#: lib/choose_repository.tcl:795
+#: lib/choose_repository.tcl:973
 msgid "Open"
 msgstr "=D0=9E=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C"
=20
-#: lib/choose_repository.tcl:805
+#: lib/choose_repository.tcl:983
 msgid "Repository:"
 msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9:"
=20
-#: lib/choose_repository.tcl:854
+#: lib/choose_repository.tcl:1033
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BE=
=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=
=D1=82=D0=BE=D1=80=D0=B8=D0=B9 %s:"
@@ -1116,7 +1136,7 @@ msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C =D1=81=D0=BB=
=D0=B5=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F"
=20
 #: lib/choose_rev.tcl:84 lib/choose_rev.tcl:537
 msgid "Tag"
-msgstr "=D0=9C=D0=B5=D1=82=D0=BA=D0=B0"
+msgstr "=D0=A2=D0=B0=D0=B3"
=20
 #: lib/choose_rev.tcl:317
 #, tcl-format
@@ -1143,7 +1163,8 @@ msgstr "=D0=A1=D1=81=D1=8B=D0=BB=D0=BA=D0=B0"
 msgid ""
 "There is nothing to amend.\n"
 "\n"
-"You are about to create the initial commit.  There is no commit befor=
e this to amend.\n"
+"You are about to create the initial commit.  There is no commit befor=
e this "
+"to amend.\n"
 msgstr ""
 "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=B4=D0=BB=D1=8F =
=D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F.\n"
 "\n"
@@ -1153,11 +1174,14 @@ msgstr ""
 msgid ""
 "Cannot amend while merging.\n"
 "\n"
-"You are currently in the middle of a merge that has not been fully co=
mpleted.  You cannot amend the prior commit unless you first abort the =
current merge activity.\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort =
the "
+"current merge activity.\n"
 msgstr ""
 "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D1=
=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=B2=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D1=8F=
 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n"
 "\n"
-"=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B5 =D0=BE=D0=B1=D1=8A=D0=B5=D0=
=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D0=B7=D0=B0=D0=B2=
=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=BE. =D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=
=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=
=82=D1=8C =D0=BF=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=B5 =
=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D0=BF=D1=
=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D1=8F =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=
=B5=D0=B5 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=
=B5.\n"
+"=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B5 =D0=BE=D0=B1=D1=8A=D0=B5=D0=
=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D0=B7=D0=B0=D0=B2=
=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=BE. =D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=
=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=
=82=D1=8C =D0=BF=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=B5 =
"
+"=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D0=BF=
=D1=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D1=8F =D1=82=D0=B5=D0=BA=D1=83=D1=89=
=D0=B5=D0=B5 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=
=D0=B5.\n"
=20
 #: lib/commit.tcl:49
 msgid "Error loading commit data for amend:"
@@ -1169,19 +1193,21 @@ msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=
=BE=D0=B6=D0=BD=D0=BE =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =
=D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BE=D0=B1=
 =D0=B0=D0=B2=D1=82=D0=BE
=20
 #: lib/commit.tcl:81
 msgid "Invalid GIT_COMMITTER_IDENT:"
-msgstr "=D0=9D=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D0=B0=D1=8F GIT_COMMITTER=
_IDENT:"
+msgstr "=D0=9D=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D1=8B=D0=B9 GIT_COMMITTER=
_IDENT:"
=20
 #: lib/commit.tcl:133
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
-"Another Git program has modified this repository since the last scan.=
  A rescan must be performed before another commit can be created.\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before another commit can be created.\n"
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
 "=D0=9F=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D0=BF=D1=80=D0=
=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BE=D0=BE=D1=82=D0=B2=
=D0=B5=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=82=D0=B5=D0=BA=D1=83=
=D1=89=D0=B5=D0=BC=D1=83.\n"
 "\n"
-"=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=
=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=BE=D0=B9 Git. =D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=
=D0=BC=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C=
 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=
=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D1=8F=D1=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E=
 =D0=B2=D0=B5=D1=82=D0=B2=D1=8C. \n"
+"=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=
=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=BE=D0=B9 Git. "
+"=D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =D0=BF=D0=
=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=BF=D1=80=D0=B5=D0=B6=
=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D1=8F=D1=
=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E =D0=B2=D0=B5=D1=82=
=D0=B2=D1=8C. \n"
 "\n"
 "=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=
=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
=20
@@ -1190,11 +1216,13 @@ msgstr ""
 msgid ""
 "Unmerged files cannot be committed.\n"
 "\n"
-"File %s has merge conflicts.  You must resolve them and stage the fil=
e before committing.\n"
+"File %s has merge conflicts.  You must resolve them and stage the fil=
e "
+"before committing.\n"
 msgstr ""
 "=D0=9D=D0=B5=D0=BB=D1=8C=D0=B7=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=
=BD=D0=B8=D1=82=D1=8C =D0=BD=D0=B5=D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=
=BD=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D1=8B.\n"
 "\n"
-"=D0=94=D0=BB=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 %s =D0=B2=D0=BE=D0=B7=
=D0=BD=D0=B8=D0=BA =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82 =D0=
=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F. =D0=A0=
=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B8=D1=82=D0=B5 =D0=BA=D0=BE=D0=BD=D1=84=
=D0=BB=D0=B8=D0=BA=D1=82 =D0=B8 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D1=8C=D1=
=82=D0=B5 =D0=BA =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=
=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D0=BC =D0=
=BF=D0=B5=D1=80=D0=B5=D0=B4 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=
=BD=D0=B8=D0=B5=D0=BC.\n"
+"=D0=94=D0=BB=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 %s =D0=B2=D0=BE=D0=B7=
=D0=BD=D0=B8=D0=BA =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82 =D0=
=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F. =D0=A0=
=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B8=D1=82=D0=B5 =D0=BA=D0=BE=D0=BD=D1=84=
=D0=BB=D0=B8=D0=BA=D1=82 =D0=B8 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D1=8C=D1=
=82=D0=B5 =D0=BA "
+"=D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=
=BD=D1=8B=D0=BC =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D0=BC =D0=BF=D0=B5=D1=80=
=D0=B5=D0=B4 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=
=D0=BC.\n"
=20
 #: lib/commit.tcl:162
 #, tcl-format
@@ -1333,13 +1361,15 @@ msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B0 =D0=B1=D0=B0=D0=B7=D1=8B =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=
=D0=BE=D0=B2 =D0=BF=D1=80=D0=B8 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D0=B8 fs=
ck"
 msgid ""
 "This repository currently has approximately %i loose objects.\n"
 "\n"
-"To maintain optimal performance it is strongly recommended that you c=
ompress the database when more than %i loose objects exist.\n"
+"To maintain optimal performance it is strongly recommended that you c=
ompress "
+"the database when more than %i loose objects exist.\n"
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
=B4=D0=B0 =D0=B5=D1=81=D1=82=D1=8C =D0=B1=D0=BE=D0=BB=D0=B5=D0=B5 %i =D0=
=BD=D0=B5=D1=81=D0=B2=D1=8F=D0=B7=D0=B0=D0=BD=D0=BD=D1=8B=D1=85 =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2.\n"
+"=D0=94=D0=BB=D1=8F =D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=B9 =D0=BF=D1=80=D0=
=BE=D0=B8=D0=B7=D0=B2=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=
=BE=D1=81=D1=82=D0=B8 =D1=80=D0=B5=D0=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=
=83=D0=B5=D1=82=D1=81=D1=8F =D1=81=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=
=D0=B7=D1=83 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85, =D0=BA=D0=BE=D0=B3=D0=
=B4=D0=B0 =D0=B5=D1=81=D1=82=D1=8C "
+"=D0=B1=D0=BE=D0=BB=D0=B5=D0=B5 %i =D0=BD=D0=B5=D1=81=D0=B2=D1=8F=D0=B7=
=D0=B0=D0=BD=D0=BD=D1=8B=D1=85 =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=
=D0=B2.\n"
 "\n"
 "=D0=A1=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=D0=B7=D1=83 =D0=B4=D0=B0=D0=
=BD=D0=BD=D1=8B=D1=85 =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81?"
=20
@@ -1355,15 +1385,18 @@ msgid ""
 "\n"
 "%s has no changes.\n"
 "\n"
-"The modification date of this file was updated by another application=
, but the content within the file was not changed.\n"
+"The modification date of this file was updated by another application=
, but "
+"the content within the file was not changed.\n"
 "\n"
-"A rescan will be automatically started to find other files which may =
have the same state."
+"A rescan will be automatically started to find other files which may =
have "
+"the same state."
 msgstr ""
 "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B5 =D0=
=BE=D0=B1=D0=BD=D0=B0=D1=80=D1=83=D0=B6=D0=B5=D0=BD=D0=BE.\n"
 "\n"
 "=D0=B2 %s =D0=BE=D1=82=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=82=
 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n"
 "\n"
-"=D0=94=D0=B0=D1=82=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B1=D1=8B=D0=BB=D0=B0 =D0=BE=
=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B0 =D0=B4=D1=80=D1=83=D0=B3=
=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9=
, =D0=BD=D0=BE =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=BC=D0=BE=D0=
=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=BE=D1=81=D1=82=D0=B0=D0=BB=D0=BE=
=D1=81=D1=8C =D0=BF=D1=80=D0=B5=D0=B6=D0=BD=D0=B8=D0=BC.\n"
+"=D0=94=D0=B0=D1=82=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B1=D1=8B=D0=BB=D0=B0 =D0=BE=
=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B0 =D0=B4=D1=80=D1=83=D0=B3=
=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9=
, =D0=BD=D0=BE =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=BC=D0=BE=D0=
=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 "
+"=D0=BE=D1=81=D1=82=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=D1=80=D0=B5=D0=
=B6=D0=BD=D0=B8=D0=BC.\n"
 "\n"
 "=D0=A1=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=
=B7=D0=B0=D0=BF=D1=83=D1=89=D0=B5=D0=BD=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D1=
=87=D0=B8=D1=82=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F, =D1=87=D1=82=D0=BE=D0=B1=
=D1=8B =D0=BD=D0=B0=D0=B9=D1=82=D0=B8 =D0=BF=D0=BE=D0=B4=D0=BE=D0=B1=D0=
=BD=D1=8B=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D1=8B."
=20
@@ -1413,32 +1446,57 @@ msgstr "=D0=BF=D1=80=D0=B5=D0=B4=D1=83=D0=BF=D1=
=80=D0=B5=D0=B6=D0=B4=D0=B5=D0=BD=D0=B8=D0=B5"
 msgid "You must correct the above errors before committing."
 msgstr "=D0=9F=D1=80=D0=B5=D0=B6=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D1=81=
=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C, =D0=B8=D1=81=D0=BF=D1=
=80=D0=B0=D0=B2=D1=8C=D1=82=D0=B5 =D0=B2=D1=8B=D1=88=D0=B5=D1=83=D0=BA=D0=
=B0=D0=B7=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=
=B8."
=20
-#: lib/index.tcl:241
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D1=80=
=D0=B0=D0=B7=D0=B1=D0=BB=D0=BE=D0=BA=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=
=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
+
+#: lib/index.tcl:15
+msgid "Index Error"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B8=D0=BD=D0=B4=D0=B5=D0=
=BA=D1=81=D0=B0"
+
+#: lib/index.tcl:21
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically starte=
d to "
+"resynchronize git-gui."
+msgstr ""
+"=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BE=D0=B1=D0=
=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81 =
Git. =D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=B1=D1=83=D0=B4=
=D0=B5=D1=82"
+"=D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BE =D0=B0=D0=
=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8."
+
+#: lib/index.tcl:27
+msgid "Continue"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C"
+
+#: lib/index.tcl:31
+msgid "Unlock Index"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=B1=D0=BB=D0=BE=D0=BA=D0=B8=D1=80=D0=BE=D0=
=B2=D0=B0=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
+
+#: lib/index.tcl:282
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 %s =D0=B8=D0=B7=
 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=B3=D0=BE"
=20
-#: lib/index.tcl:285
+#: lib/index.tcl:326
 #, tcl-format
 msgid "Adding %s"
 msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 %=
s..."
=20
-#: lib/index.tcl:340
+#: lib/index.tcl:381
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=B5 %s?"
=20
-#: lib/index.tcl:342
+#: lib/index.tcl:383
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 %i =D1=84=D0=B0=D0=B9=D0=
=BB=D0=B5(-=D0=B0=D1=85)?"
=20
-#: lib/index.tcl:348
+#: lib/index.tcl:389
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
-"=D0=9B=D1=8E=D0=B1=D1=8B=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=
=BD=D0=B8=D1=8F, =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=
=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA =D1=81=D0=BE=D1=85=D1=
=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E, =D0=B1=D1=83=D0=B4=D1=83=D1=82=
 =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B =D0=BF=D1=80=D0=B8 =D0=
=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=
=B8=D0=B8."
+"=D0=9B=D1=8E=D0=B1=D1=8B=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=
=BD=D0=B8=D1=8F, =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=
=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA =D1=81=D0=BE=D1=85=D1=
=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E, =D0=B1=D1=83=D0=B4=D1=83=D1=82=
 =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B =D0=BF=D1=80=D0=B8 =D0=
=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9 "
+"=D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8."
=20
-#: lib/index.tcl:351
+#: lib/index.tcl:392
 msgid "Do Nothing"
 msgstr "=D0=9D=D0=B8=D1=87=D0=B5=D0=B3=D0=BE =D0=BD=D0=B5 =D0=B4=D0=B5=
=D0=BB=D0=B0=D1=82=D1=8C"
=20
@@ -1450,19 +1508,22 @@ msgid ""
 msgstr ""
 "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B2=D1=
=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D1=8C =D0=BE=D0=B1=D1=8A=D0=B5=D0=
=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B2=D0=BE =D0=B2=D1=80=D0=B5=
=D0=BC=D1=8F =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=
=D1=8F.\n"
 "\n"
-"=D0=97=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D1=82=D0=B5 =D0=B8=D1=81=D0=
=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B4=D0=B0=D0=BD=D0=
=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=
=8F =D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=
=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=
=D0=B8 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F=
=2E\n"
+"=D0=97=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D1=82=D0=B5 =D0=B8=D1=81=D0=
=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B4=D0=B0=D0=BD=D0=
=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=
=8F =D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=
=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=
=D0=B8 "
+"=D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n=
"
=20
 #: lib/merge.tcl:27
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
-"Another Git program has modified this repository since the last scan.=
  A rescan must be performed before a merge can be performed.\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before a merge can be performed.\n"
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
 "=D0=9F=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D0=BF=D1=80=D0=
=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BE=D0=BE=D1=82=D0=B2=
=D0=B5=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=82=D0=B5=D0=BA=D1=83=
=D1=89=D0=B5=D0=BC=D1=83.\n"
 "\n"
-"=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=
=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=BE=D0=B9 Git. =D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=
=D0=BC=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C=
 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=
=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D1=8F=D1=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E=
 =D0=B2=D0=B5=D1=82=D0=B2=D1=8C.\n"
+"=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=
=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=BE=D0=B9 Git. "
+"=D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =D0=BF=D0=
=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=BF=D1=80=D0=B5=D0=B6=
=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D1=8F=D1=
=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E =D0=B2=D0=B5=D1=82=
=D0=B2=D1=8C.\n"
 "\n"
 "=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=
=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
=20
@@ -1473,12 +1534,15 @@ msgid ""
 "\n"
 "File %s has merge conflicts.\n"
 "\n"
-"You must resolve them, stage the file, and commit to complete the cur=
rent merge.  Only then can you begin another merge.\n"
+"You must resolve them, stage the file, and commit to complete the cur=
rent "
+"merge.  Only then can you begin another merge.\n"
 msgstr ""
 "=D0=9F=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=B5 =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =
=D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=BE =D0=B8=D0=B7-=D0=
=B7=D0=B0 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B0.\n"
 "\n"
 "=D0=94=D0=BB=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 %s =D0=B2=D0=BE=D0=B7=
=D0=BD=D0=B8=D0=BA =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82 =D0=
=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n"
-"=D0=A0=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B8=D1=82=D0=B5 =D0=BA=D0=BE=D0=
=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82, =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=
=D0=BE=D0=B2=D1=8C=D1=82=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB =D0=B8 =D1=81=D0=
=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5. =D0=A2=D0=BE=D0=BB=D1=8C=
=D0=BA=D0=BE =D0=BF=D0=BE=D1=81=D0=BB=D0=B5 =D1=8D=D1=82=D0=BE=D0=B3=D0=
=BE =D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=BD=D0=B0=D1=87=D0=B0=D1=82=D1=8C=
 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=B5 =D0=BE=D0=B1=D1=
=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5.\n"
+"\n"
+"=D0=A0=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B8=D1=82=D0=B5 =D0=BA=D0=BE=D0=
=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82, =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=
=D0=BE=D0=B2=D1=8C=D1=82=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB =D0=B8 =D1=81=D0=
=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5. =D0=A2=D0=BE=D0=BB=D1=8C=
=D0=BA=D0=BE =D0=BF=D0=BE=D1=81=D0=BB=D0=B5 =D1=8D=D1=82=D0=BE=D0=B3=D0=
=BE =D0=BC=D0=BE=D0=B6=D0=BD=D0=BE "
+"=D0=BD=D0=B0=D1=87=D0=B0=D1=82=D1=8C =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=
=8E=D1=89=D0=B5=D0=B5 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=
=BD=D0=B8=D0=B5.\n"
=20
 #: lib/merge.tcl:54
 #, tcl-format
@@ -1487,13 +1551,15 @@ msgid ""
 "\n"
 "File %s is modified.\n"
 "\n"
-"You should complete the current commit before starting a merge.  Doin=
g so will help you abort a failed merge, should the need arise.\n"
+"You should complete the current commit before starting a merge.  Doin=
g so "
+"will help you abort a failed merge, should the need arise.\n"
 msgstr ""
 "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D1=
=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D1=8B.\n"
 "\n"
-"=D0=A4=D0=B0=D0=B9=D0=BB  %s =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=
=2E\n"
+"=D0=A4=D0=B0=D0=B9=D0=BB %s =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=
=2E\n"
 "\n"
-"=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D1=8C=D1=82=D0=B5 =D0=
=B8 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=BD=D0=
=B0=D1=87=D0=B0=D0=BB=D0=BE=D0=BC =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=
=BD=D0=B5=D0=BD=D0=B8=D1=8F. =D0=92 =D1=81=D0=BB=D1=83=D1=87=D0=B0=D0=B5=
 =D0=BD=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE=D1=81=D1=82=
=D0=B8 =D1=8D=D1=82=D0=BE =D0=BF=D0=BE=D0=B7=D0=B2=D0=BE=D0=BB=D0=B8=D1=
=82 =D0=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=BF=D0=B5=
=D1=80=D0=B0=D1=86=D0=B8=D1=8E =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=
=D0=B5=D0=BD=D0=B8=D1=8F.\n"
+"=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D1=8C=D1=82=D0=B5 =D0=
=B8 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=BD=D0=
=B0=D1=87=D0=B0=D0=BB=D0=BE=D0=BC =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=
=BD=D0=B5=D0=BD=D0=B8=D1=8F. =D0=92 =D1=81=D0=BB=D1=83=D1=87=D0=B0=D0=B5=
 "
+"=D0=BD=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE=D1=81=D1=
=82=D0=B8 =D1=8D=D1=82=D0=BE =D0=BF=D0=BE=D0=B7=D0=B2=D0=BE=D0=BB=D0=B8=
=D1=82 =D0=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=BF=D0=
=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=
=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n"
=20
 #: lib/merge.tcl:106
 #, tcl-format
@@ -1631,7 +1697,7 @@ msgstr "=D0=A8=D0=B0=D0=B1=D0=BB=D0=BE=D0=BD =D0=B4=
=D0=BB=D1=8F =D0=B8=D0=BC=D0=B5=D0=BD=D0=B8 =D0=BD=D0=BE=D0=B2=D0=BE=D0=
=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
=20
 #: lib/option.tcl:176
 msgid "Change Font"
-msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D1=
=84=D0=B5=D0=B9=D1=81=D0=B0"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D1=88=D1=80=D0=
=B8=D1=84=D1=82"
=20
 #: lib/option.tcl:180
 #, tcl-format
@@ -1640,7 +1706,6 @@ msgstr "=D0=92=D1=8B=D0=B1=D0=B5=D1=80=D0=B8=D1=82=
=D0=B5 %s"
=20
 # carbon copy
 #: lib/option.tcl:186
-#, fuzzy
 msgid "pt."
 msgstr ""
=20
@@ -1652,18 +1717,6 @@ msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=
=D0=BA=D0=B8"
 msgid "Failed to completely save options:"
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=82=D1=8C=D1=8E =D1=81=D0=BE=D1=85=D1=80=
=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D0=BD=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=
=D0=BA=D0=B8:"
=20
-#: lib/remote.tcl:165
-msgid "Prune from"
-msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0"
-
-#: lib/remote.tcl:170
-msgid "Fetch from"
-msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D0=
=B7"
-
-#: lib/remote.tcl:213
-msgid "Push to"
-msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
-
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Remote Branch"
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=BD=D0=B5=D1=
=88=D0=BD=D1=8E=D1=8E =D0=B2=D0=B5=D1=82=D0=B2=D1=8C"
@@ -1707,16 +1760,17 @@ msgid ""
 "\n"
 " - %s"
 msgstr ""
-"=D0=A1=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D1=
=8B =D1=81 %s =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=82=D1=
=8C=D1=8E:"
-"\n"
+"=D0=A1=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D1=
=8B =D1=81 %s =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=82=D1=
=8C=D1=8E:\n"
 " - %s"
=20
 #: lib/remote_branch_delete.tcl:189
 #, tcl-format
-msgid "One or more of the merge tests failed because you have not fetc=
hed the necessary commits.  Try fetching from %s first."
+msgid ""
+"One or more of the merge tests failed because you have not fetched th=
e "
+"necessary commits.  Try fetching from %s first."
 msgstr ""
-"=D0=9E=D0=B4=D0=B8=D0=BD =D0=B8=D0=BB=D0=B8 =D0=BD=D0=B5=D1=81=D0=BA=D0=
=BE=D0=BB=D1=8C=D0=BA=D0=BE =D1=82=D0=B5=D1=81=D1=82=D0=BE=D0=B2 =D0=BD=
=D0=B0 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=
 =D0=BD=D0=B5 =D0=BF=D1=80=D0=BE=D1=88=D0=BB=D0=B8, =D0=BF=D0=BE=D1=82=D0=
=BE=D0=BC=D1=83 =D1=87=D1=82=D0=BE "
-"=D0=92=D1=8B =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D0=BB=D0=
=B8 =D0=BD=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D0=B5 =
=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F. =D0=9F=D0=BE=D0=
=BF=D1=80=D0=BE=D0=B1=D1=83=D0=B9=D1=82=D0=B5 =D1=81=D0=BD=D0=B0=D1=87=D0=
=B0=D0=BB=D0=B0 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D0=B8=
=D1=85 =D0=B8=D0=B7 %s."
+"=D0=9E=D0=B4=D0=B8=D0=BD =D0=B8=D0=BB=D0=B8 =D0=BD=D0=B5=D1=81=D0=BA=D0=
=BE=D0=BB=D1=8C=D0=BA=D0=BE =D1=82=D0=B5=D1=81=D1=82=D0=BE=D0=B2 =D0=BD=
=D0=B0 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=
 =D0=BD=D0=B5 =D0=BF=D1=80=D0=BE=D1=88=D0=BB=D0=B8, =D0=BF=D0=BE=D1=82=D0=
=BE=D0=BC=D1=83 =D1=87=D1=82=D0=BE =D0=92=D1=8B =D0=BD=D0=B5 "
+"=D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D0=BB=D0=B8 =D0=BD=D0=B5=D0=BE=D0=
=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D1=8F. =D0=9F=D0=BE=D0=BF=D1=8B=D1=82=D0=B0=D0=B9=
=D1=82=D0=B5=D1=81=D1=8C =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C=
 =D0=B8=D1=85 =D0=B8=D0=B7 %s."
=20
 #: lib/remote_branch_delete.tcl:207
 msgid "Please select one or more branches to delete."
@@ -1746,11 +1800,23 @@ msgstr "=D0=9D=D0=B5 =D1=83=D0=BA=D0=B0=D0=B7=D0=
=B0=D0=BD =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9."
 msgid "Scanning %s..."
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D1=8B=D0=B2=D0=B0=D0=
=BD=D0=B8=D0=B5 %s... "
=20
-#: lib/shortcut.tcl:26 lib/shortcut.tcl:74
-msgid "Cannot write script:"
-msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D1=81=D0=BA=D1=80=D0=B8=D0=
=BF=D1=82:"
+#: lib/remote.tcl:165
+msgid "Prune from"
+msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0"
+
+#: lib/remote.tcl:170
+msgid "Fetch from"
+msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D0=
=B7"
+
+#: lib/remote.tcl:213
+msgid "Push to"
+msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
+
+#: lib/shortcut.tcl:20 lib/shortcut.tcl:61
+msgid "Cannot write shortcut:"
+msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D1=81=D1=81=D1=8B=D0=BB=D0=
=BA=D1=83:"
=20
-#: lib/shortcut.tcl:149
+#: lib/shortcut.tcl:136
 msgid "Cannot write icon:"
 msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D0=B7=D0=BD=D0=B0=D1=87=D0=
=BE=D0=BA:"
=20
@@ -1821,5 +1887,7 @@ msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=
=D0=BE=D0=B2=D0=B0=D1=82=D1=8C thin pack (=D0=B4=D0=BB=D1=8F =D0=BC=D0=B5=
=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D1=85 =D1=81=D0=B5=D1=82=D0=B5=D0=B2
=20
 #: lib/transport.tcl:168
 msgid "Include tags"
-msgstr "=D0=92=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=BC=D0=B5=D1=
=82=D0=BA=D0=B8"
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B4=D0=B0=D1=82=D1=8C =D1=82=D0=B0=D0=
=B3=D0=B8"
=20
+#~ msgid "Next >"
+#~ msgstr "=D0=94=D0=B0=D0=BB=D1=8C=D1=88=D0=B5 >"
--=20
1.5.3.4.500.g3a531f
