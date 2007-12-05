From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: [PATCH] Update ja.po for git-gui
Date: Wed, 5 Dec 2007 18:24:26 +0900
Message-ID: <200712050925.lB59PRp9020442@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 05 10:25:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzqVs-0003df-Am
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 10:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbXLEJZa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 04:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbXLEJZa
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 04:25:30 -0500
Received: from mi1.bluebottle.com ([206.188.25.14]:36251 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbXLEJZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 04:25:27 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id lB59PRp9020442
	for <git@vger.kernel.org>; Wed, 5 Dec 2007 01:25:27 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=sRNhn0SaJtyLorncZ3gLGrOHFDuXO5QVo6juRTwwC4f8WATwBvBYho6ideKrWdsb7
	++SDE8jDjSLYS30spxHk0f4Dwdxg73xqz7+R+11Yj5ttofunhtMYD872lOnt7cb
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id lB59OuiP003497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Dec 2007 01:25:01 -0800
X-Trusted-Delivery: <a201f267d30f2e37770e8e723bc6c234>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67128>

---
 po/ja.po |  418 ++++++++++++++++++++++++++++++++++--------------------=
--------
 1 files changed, 229 insertions(+), 189 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index f3a547b..e2cf5bd 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -8,41 +8,41 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2007-10-10 04:04-0400\n"
-"PO-Revision-Date: 2007-10-31 16:23+0900\n"
+"POT-Creation-Date: 2007-11-24 10:36+0100\n"
+"PO-Revision-Date: 2007-12-05 06:12+0900\n"
 "Last-Translator: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=
=AA=E3=81=93 <nanako3@bluebottle.com>\n"
 "Language-Team: Japanese\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.=
sh:744
-#: git-gui.sh:763
+#: git-gui.sh:41 git-gui.sh:604 git-gui.sh:618 git-gui.sh:631 git-gui.=
sh:714
+#: git-gui.sh:733
 msgid "git-gui: fatal error"
 msgstr "git-gui: =E8=87=B4=E5=91=BD=E7=9A=84=E3=81=AA=E3=82=A8=E3=83=A9=
=E3=83=BC"
=20
-#: git-gui.sh:595
+#: git-gui.sh:565
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "%s =E3=81=AB=E7=84=A1=E5=8A=B9=E3=81=AA=E3=83=95=E3=82=A9=E3=83=
=B3=E3=83=88=E3=81=8C=E6=8C=87=E5=AE=9A=E3=81=95=E3=82=8C=E3=81=A6=E3=81=
=84=E3=81=BE=E3=81=99:"
=20
-#: git-gui.sh:620
+#: git-gui.sh:590
 msgid "Main Font"
 msgstr "=E4=B8=BB=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88"
=20
-#: git-gui.sh:621
+#: git-gui.sh:591
 msgid "Diff/Console Font"
 msgstr "diff/=E3=82=B3=E3=83=B3=E3=82=BD=E3=83=BC=E3=83=AB=E3=83=BB=E3=
=83=95=E3=82=A9=E3=83=B3=E3=83=88"
=20
-#: git-gui.sh:635
+#: git-gui.sh:605
 msgid "Cannot find git in PATH."
 msgstr "PATH =E4=B8=AD=E3=81=AB git =E3=81=8C=E8=A6=8B=E3=81=A4=E3=81=8B=
=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:662
+#: git-gui.sh:632
 msgid "Cannot parse Git version string:"
 msgstr "Git =E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3=E5=90=8D=E3=81=
=8C=E7=90=86=E8=A7=A3=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93:"
=20
-#: git-gui.sh:680
+#: git-gui.sh:650
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -61,79 +61,79 @@ msgstr ""
 "\n"
 "'%s' =E3=81=AF=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3 1.5.0 =E3=
=81=A8=E6=80=9D=E3=81=A3=E3=81=A6=E8=89=AF=E3=81=84=E3=81=A7=E3=81=99=E3=
=81=8B=EF=BC=9F\n"
=20
-#: git-gui.sh:853
+#: git-gui.sh:888
 msgid "Git directory not found:"
 msgstr "Git =E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA=E3=81=
=8C=E8=A6=8B=E3=81=A4=E3=81=8B=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93:"
=20
-#: git-gui.sh:860
+#: git-gui.sh:895
 msgid "Cannot move to top of working directory:"
 msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=81=AE=E6=9C=80=E4=B8=8A=E4=BD=8D=E3=81=AB=E7=A7=BB=E5=8B=95=
=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:867
+#: git-gui.sh:902
 msgid "Cannot use funny .git directory:"
 msgstr "=E5=A4=89=E3=81=AA .git =E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=
=83=88=E3=83=AA=E3=81=AF=E4=BD=BF=E3=81=88=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:872
+#: git-gui.sh:907
 msgid "No working directory"
 msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:1019
+#: git-gui.sh:1054
 msgid "Refreshing file status..."
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E7=8A=B6=E6=85=8B=E3=82=92=
=E6=9B=B4=E6=96=B0=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6=
"
=20
-#: git-gui.sh:1084
+#: git-gui.sh:1119
 msgid "Scanning for modified files ..."
 msgstr "=E5=A4=89=E6=9B=B4=E3=81=95=E3=82=8C=E3=81=9F=E3=83=95=E3=82=A1=
=E3=82=A4=E3=83=AB=E3=82=92=E3=82=B9=E3=82=AD=E3=83=A3=E3=83=B3=E3=81=97=
=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
-#: git-gui.sh:1259 lib/browser.tcl:245
+#: git-gui.sh:1294 lib/browser.tcl:245
 msgid "Ready."
 msgstr "=E6=BA=96=E5=82=99=E5=AE=8C=E4=BA=86"
=20
-#: git-gui.sh:1525
+#: git-gui.sh:1560
 msgid "Unmodified"
 msgstr "=E5=A4=89=E6=9B=B4=E7=84=A1=E3=81=97"
=20
-#: git-gui.sh:1527
+#: git-gui.sh:1562
 msgid "Modified, not staged"
 msgstr "=E5=A4=89=E6=9B=B4=E3=81=82=E3=82=8A=E3=80=81=E3=82=B3=E3=83=9F=
=E3=83=83=E3=83=88=E6=9C=AA=E4=BA=88=E5=AE=9A"
=20
-#: git-gui.sh:1528 git-gui.sh:1533
+#: git-gui.sh:1563 git-gui.sh:1568
 msgid "Staged for commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E6=B8=88=
"
=20
-#: git-gui.sh:1529 git-gui.sh:1534
+#: git-gui.sh:1564 git-gui.sh:1569
 msgid "Portions staged for commit"
 msgstr "=E9=83=A8=E5=88=86=E7=9A=84=E3=81=AB=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E4=BA=88=E5=AE=9A=E6=B8=88"
=20
-#: git-gui.sh:1530 git-gui.sh:1535
+#: git-gui.sh:1565 git-gui.sh:1570
 msgid "Staged for commit, missing"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E6=B8=88=
=E3=80=81=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E7=84=A1=E3=81=97"
=20
-#: git-gui.sh:1532
+#: git-gui.sh:1567
 msgid "Untracked, not staged"
 msgstr "=E7=AE=A1=E7=90=86=E5=A4=96=E3=80=81=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E6=9C=AA=E4=BA=88=E5=AE=9A"
=20
-#: git-gui.sh:1537
+#: git-gui.sh:1572
 msgid "Missing"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E7=84=A1=E3=81=97"
=20
-#: git-gui.sh:1538
+#: git-gui.sh:1573
 msgid "Staged for removal"
 msgstr "=E5=89=8A=E9=99=A4=E4=BA=88=E5=AE=9A=E6=B8=88"
=20
-#: git-gui.sh:1539
+#: git-gui.sh:1574
 msgid "Staged for removal, still present"
 msgstr "=E5=89=8A=E9=99=A4=E4=BA=88=E5=AE=9A=E6=B8=88=E3=80=81=E3=83=95=
=E3=82=A1=E3=82=A4=E3=83=AB=E6=9C=AA=E5=89=8A=E9=99=A4"
=20
-#: git-gui.sh:1541 git-gui.sh:1542 git-gui.sh:1543 git-gui.sh:1544
+#: git-gui.sh:1576 git-gui.sh:1577 git-gui.sh:1578 git-gui.sh:1579
 msgid "Requires merge resolution"
 msgstr "=E8=A6=81=E3=83=9E=E3=83=BC=E3=82=B8=E8=A7=A3=E6=B1=BA"
=20
-#: git-gui.sh:1579
+#: git-gui.sh:1614
 msgid "Starting gitk... please wait..."
 msgstr "gitk =E3=82=92=E8=B5=B7=E5=8B=95=E4=B8=AD=E2=80=A6=E3=81=8A=E5=
=BE=85=E3=81=A1=E4=B8=8B=E3=81=95=E3=81=84=E2=80=A6"
=20
-#: git-gui.sh:1588
+#: git-gui.sh:1623
 #, tcl-format
 msgid ""
 "Unable to start gitk:\n"
@@ -144,295 +144,297 @@ msgstr ""
 "\n"
 "%s =E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:1788 lib/choose_repository.tcl:32
+#: git-gui.sh:1823 lib/choose_repository.tcl:35
 msgid "Repository"
 msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA"
=20
-#: git-gui.sh:1789
+#: git-gui.sh:1824
 msgid "Edit"
 msgstr "=E7=B7=A8=E9=9B=86"
=20
-#: git-gui.sh:1791 lib/choose_rev.tcl:560
+#: git-gui.sh:1826 lib/choose_rev.tcl:560
 msgid "Branch"
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81"
=20
-#: git-gui.sh:1794 lib/choose_rev.tcl:547
+#: git-gui.sh:1829 lib/choose_rev.tcl:547
 msgid "Commit@@noun"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88"
=20
-#: git-gui.sh:1797 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
+#: git-gui.sh:1832 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8"
=20
-#: git-gui.sh:1798 lib/choose_rev.tcl:556
+#: git-gui.sh:1833 lib/choose_rev.tcl:556
 msgid "Remote"
 msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88"
=20
-#: git-gui.sh:1807
+#: git-gui.sh:1842
 msgid "Browse Current Branch's Files"
 msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=92=E8=A6=8B=E3=82=8B=
"
=20
-#: git-gui.sh:1811
+#: git-gui.sh:1846
 msgid "Browse Branch Files..."
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=AE=E3=83=95=E3=82=A1=
=E3=82=A4=E3=83=AB=E3=82=92=E8=A6=8B=E3=82=8B=E2=80=A6"
=20
-#: git-gui.sh:1816
+#: git-gui.sh:1851
 msgid "Visualize Current Branch's History"
 msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AE=E5=B1=A5=E6=AD=B4=E3=82=92=E8=A6=8B=E3=82=8B"
=20
-#: git-gui.sh:1820
+#: git-gui.sh:1855
 msgid "Visualize All Branch History"
 msgstr "=E5=85=A8=E3=81=A6=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AE=E5=B1=A5=E6=AD=B4=E3=82=92=E8=A6=8B=E3=82=8B"
=20
-#: git-gui.sh:1827
+#: git-gui.sh:1862
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81 %s =E3=81=AE=E3=83=95=E3=82=
=A1=E3=82=A4=E3=83=AB=E3=82=92=E8=A6=8B=E3=82=8B"
=20
-#: git-gui.sh:1829
+#: git-gui.sh:1864
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81 %s =E3=81=AE=E5=B1=A5=E6=AD=
=B4=E3=82=92=E8=A6=8B=E3=82=8B"
=20
-#: git-gui.sh:1834 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:1869 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E7=B5=B1=
=E8=A8=88"
=20
-#: git-gui.sh:1837 lib/database.tcl:34
+#: git-gui.sh:1872 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E5=9C=A7=
=E7=B8=AE"
=20
-#: git-gui.sh:1840
+#: git-gui.sh:1875
 msgid "Verify Database"
 msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E6=A4=9C=
=E8=A8=BC"
=20
-#: git-gui.sh:1847 git-gui.sh:1851 git-gui.sh:1855 lib/shortcut.tcl:9
-#: lib/shortcut.tcl:45 lib/shortcut.tcl:84
+#: git-gui.sh:1882 git-gui.sh:1886 git-gui.sh:1890 lib/shortcut.tcl:7
+#: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
 msgstr "=E3=83=87=E3=82=B9=E3=82=AF=E3=83=88=E3=83=83=E3=83=97=E3=83=BB=
=E3=82=A2=E3=82=A4=E3=82=B3=E3=83=B3=E3=82=92=E4=BD=9C=E3=82=8B"
=20
-#: git-gui.sh:1860 lib/choose_repository.tcl:36 lib/choose_repository.=
tcl:95
+#: git-gui.sh:1895 lib/choose_repository.tcl:176 lib/choose_repository=
=2Etcl:184
 msgid "Quit"
 msgstr "=E7=B5=82=E4=BA=86"
=20
-#: git-gui.sh:1867
+#: git-gui.sh:1902
 msgid "Undo"
 msgstr "=E5=85=83=E3=81=AB=E6=88=BB=E3=81=99"
=20
-#: git-gui.sh:1870
+#: git-gui.sh:1905
 msgid "Redo"
 msgstr "=E3=82=84=E3=82=8A=E7=9B=B4=E3=81=97"
=20
-#: git-gui.sh:1874 git-gui.sh:2366
+#: git-gui.sh:1909 git-gui.sh:2403
 msgid "Cut"
 msgstr "=E5=88=87=E3=82=8A=E5=8F=96=E3=82=8A"
=20
-#: git-gui.sh:1877 git-gui.sh:2369 git-gui.sh:2440 git-gui.sh:2512
+#: git-gui.sh:1912 git-gui.sh:2406 git-gui.sh:2477 git-gui.sh:2549
 #: lib/console.tcl:67
 msgid "Copy"
 msgstr "=E3=82=B3=E3=83=94=E3=83=BC"
=20
-#: git-gui.sh:1880 git-gui.sh:2372
+#: git-gui.sh:1915 git-gui.sh:2409
 msgid "Paste"
 msgstr "=E8=B2=BC=E3=82=8A=E4=BB=98=E3=81=91"
=20
-#: git-gui.sh:1883 git-gui.sh:2375 lib/branch_delete.tcl:26
+#: git-gui.sh:1918 git-gui.sh:2412 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "=E5=89=8A=E9=99=A4"
=20
-#: git-gui.sh:1887 git-gui.sh:2379 git-gui.sh:2516 lib/console.tcl:69
+#: git-gui.sh:1922 git-gui.sh:2416 git-gui.sh:2553 lib/console.tcl:69
 msgid "Select All"
 msgstr "=E5=85=A8=E3=81=A6=E9=81=B8=E6=8A=9E"
=20
-#: git-gui.sh:1896
+#: git-gui.sh:1931
 msgid "Create..."
 msgstr "=E4=BD=9C=E6=88=90=E2=80=A6"
=20
-#: git-gui.sh:1902
+#: git-gui.sh:1937
 msgid "Checkout..."
 msgstr "=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=E3=82=A6=E3=83=88=
"
=20
-#: git-gui.sh:1908
+#: git-gui.sh:1943
 msgid "Rename..."
 msgstr "=E5=90=8D=E5=89=8D=E5=A4=89=E6=9B=B4=E2=80=A6"
=20
-#: git-gui.sh:1913 git-gui.sh:2012
+#: git-gui.sh:1948 git-gui.sh:2048
 msgid "Delete..."
 msgstr "=E5=89=8A=E9=99=A4=E2=80=A6"
=20
-#: git-gui.sh:1918
+#: git-gui.sh:1953
 msgid "Reset..."
 msgstr "=E3=83=AA=E3=82=BB=E3=83=83=E3=83=88=E2=80=A6"
=20
-#: git-gui.sh:1930 git-gui.sh:2313
+#: git-gui.sh:1965 git-gui.sh:2350
 msgid "New Commit"
 msgstr "=E6=96=B0=E8=A6=8F=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88"
=20
-#: git-gui.sh:1938 git-gui.sh:2320
+#: git-gui.sh:1973 git-gui.sh:2357
 msgid "Amend Last Commit"
 msgstr "=E6=9C=80=E6=96=B0=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=
=E8=A8=82=E6=AD=A3"
=20
-#: git-gui.sh:1947 git-gui.sh:2280 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:1982 git-gui.sh:2317 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "=E5=86=8D=E3=82=B9=E3=82=AD=E3=83=A3=E3=83=B3"
=20
-#: git-gui.sh:1953
+#: git-gui.sh:1988
 msgid "Stage To Commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=99=
=E3=82=8B"
=20
-#: git-gui.sh:1958
+#: git-gui.sh:1994
 msgid "Stage Changed Files To Commit"
 msgstr "=E5=A4=89=E6=9B=B4=E3=81=95=E3=82=8C=E3=81=9F=E3=83=95=E3=82=A1=
=E3=82=A4=E3=83=AB=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=
=E5=AE=9A"
=20
-#: git-gui.sh:1964
+#: git-gui.sh:2000
 msgid "Unstage From Commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=8B=E3=82=89=E9=99=8D=
=E3=82=8D=E3=81=99"
=20
-#: git-gui.sh:1969 lib/index.tcl:352
+#: git-gui.sh:2005 lib/index.tcl:393
 msgid "Revert Changes"
 msgstr "=E5=A4=89=E6=9B=B4=E3=82=92=E5=85=83=E3=81=AB=E6=88=BB=E3=81=99=
"
=20
-#: git-gui.sh:1976 git-gui.sh:2292 git-gui.sh:2390
+#: git-gui.sh:2012 git-gui.sh:2329 git-gui.sh:2427
 msgid "Sign Off"
 msgstr "=E7=BD=B2=E5=90=8D"
=20
-#: git-gui.sh:1980 git-gui.sh:2296
+#: git-gui.sh:2016 git-gui.sh:2333
 msgid "Commit@@verb"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88"
=20
-#: git-gui.sh:1991
+#: git-gui.sh:2027
 msgid "Local Merge..."
 msgstr "=E3=83=AD=E3=83=BC=E3=82=AB=E3=83=AB=E3=83=BB=E3=83=9E=E3=83=BC=
=E3=82=B8=E2=80=A6"
=20
-#: git-gui.sh:1996
+#: git-gui.sh:2032
 msgid "Abort Merge..."
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E4=B8=AD=E6=AD=A2=E2=80=A6"
=20
-#: git-gui.sh:2008
+#: git-gui.sh:2044
 msgid "Push..."
 msgstr "=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5=E2=80=A6"
=20
-#: git-gui.sh:2019 lib/choose_repository.tcl:41
+#: git-gui.sh:2055 lib/choose_repository.tcl:40
 msgid "Apple"
 msgstr "=E3=82=8A=E3=82=93=E3=81=94"
=20
-#: git-gui.sh:2022 git-gui.sh:2044 lib/about.tcl:13
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
+#: git-gui.sh:2058 git-gui.sh:2080 lib/about.tcl:13
+#: lib/choose_repository.tcl:43 lib/choose_repository.tcl:49
 #, tcl-format
 msgid "About %s"
 msgstr "%s =E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6"
=20
-#: git-gui.sh:2026
+#: git-gui.sh:2062
 msgid "Preferences..."
 msgstr "=E8=A8=AD=E5=AE=9A=E2=80=A6"
=20
-#: git-gui.sh:2034 git-gui.sh:2558
+#: git-gui.sh:2070 git-gui.sh:2595
 msgid "Options..."
 msgstr "=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=E3=83=B3=E2=80=A6"
=20
-#: git-gui.sh:2040 lib/choose_repository.tcl:47
+#: git-gui.sh:2076 lib/choose_repository.tcl:46
 msgid "Help"
 msgstr "=E3=83=98=E3=83=AB=E3=83=97"
=20
-#: git-gui.sh:2081
+#: git-gui.sh:2117
 msgid "Online Documentation"
 msgstr "=E3=82=AA=E3=83=B3=E3=83=A9=E3=82=A4=E3=83=B3=E3=83=BB=E3=83=89=
=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=88"
=20
-#: git-gui.sh:2165
+#: git-gui.sh:2201
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
-msgstr "=E8=87=B4=E5=91=BD=E7=9A=84: =E3=83=91=E3=82=B9 %s =E3=81=8C s=
tat =E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=E3=81=9D=E3=81=
=AE=E3=82=88=E3=81=86=E3=81=AA=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=
=84=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA=E3=81=AF=E3=81=
=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
+msgstr ""
+"=E8=87=B4=E5=91=BD=E7=9A=84: =E3=83=91=E3=82=B9 %s =E3=81=8C stat =E3=
=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=E3=81=9D=E3=81=AE=E3=
=82=88=E3=81=86=E3=81=AA=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=84=E3=
=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA=E3=81=AF=E3=81=82=E3=
=82=8A=E3=81=BE"
+"=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:2198
+#: git-gui.sh:2234
 msgid "Current Branch:"
 msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
"
=20
-#: git-gui.sh:2219
+#: git-gui.sh:2255
 msgid "Staged Changes (Will Commit)"
 msgstr "=E3=82=B9=E3=83=86=E3=83=BC=E3=82=B8=E3=83=B3=E3=82=B0=E3=81=95=
=E3=82=8C=E3=81=9F=EF=BC=88=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=
=E5=AE=9A=E6=B8=88=E3=81=AE=EF=BC=89=E5=A4=89=E6=9B=B4"
=20
-#: git-gui.sh:2239
+#: git-gui.sh:2274
 msgid "Unstaged Changes"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=AB=
=E5=85=A5=E3=81=A3=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=E5=A4=89=E6=9B=B4=
"
=20
-#: git-gui.sh:2286
+#: git-gui.sh:2323
 msgid "Stage Changed"
 msgstr "=E5=A4=89=E6=9B=B4=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=
=E4=BA=88=E5=AE=9A=E3=81=AB=E5=85=A5=E3=82=8C=E3=82=8B"
=20
-#: git-gui.sh:2302 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2339 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
 msgstr "=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5"
=20
-#: git-gui.sh:2332
+#: git-gui.sh:2369
 msgid "Initial Commit Message:"
 msgstr "=E6=9C=80=E5=88=9D=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=
=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=E3=82=B8:"
=20
-#: git-gui.sh:2333
+#: git-gui.sh:2370
 msgid "Amended Commit Message:"
 msgstr "=E8=A8=82=E6=AD=A3=E3=81=97=E3=81=9F=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=E3=82=B8:"
=20
-#: git-gui.sh:2334
+#: git-gui.sh:2371
 msgid "Amended Initial Commit Message:"
 msgstr "=E8=A8=82=E6=AD=A3=E3=81=97=E3=81=9F=E6=9C=80=E5=88=9D=E3=81=AE=
=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=
=E3=82=B8:"
=20
-#: git-gui.sh:2335
+#: git-gui.sh:2372
 msgid "Amended Merge Commit Message:"
 msgstr "=E8=A8=82=E6=AD=A3=E3=81=97=E3=81=9F=E3=83=9E=E3=83=BC=E3=82=B8=
=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=
=E3=82=B8:"
=20
-#: git-gui.sh:2336
+#: git-gui.sh:2373
 msgid "Merge Commit Message:"
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=
=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=E3=82=B8:"
=20
-#: git-gui.sh:2337
+#: git-gui.sh:2374
 msgid "Commit Message:"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=
=E3=83=BC=E3=82=B8:"
=20
-#: git-gui.sh:2382 git-gui.sh:2520 lib/console.tcl:71
+#: git-gui.sh:2419 git-gui.sh:2557 lib/console.tcl:71
 msgid "Copy All"
 msgstr "=E5=85=A8=E3=81=A6=E3=82=B3=E3=83=94=E3=83=BC"
=20
-#: git-gui.sh:2406 lib/blame.tcl:104
+#: git-gui.sh:2443 lib/blame.tcl:104
 msgid "File:"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB:"
=20
-#: git-gui.sh:2508
+#: git-gui.sh:2545
 msgid "Refresh"
 msgstr "=E5=86=8D=E8=AA=AD=E3=81=BF=E8=BE=BC=E3=81=BF"
=20
-#: git-gui.sh:2529
+#: git-gui.sh:2566
 msgid "Apply/Reverse Hunk"
 msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E9=81=A9=E7=94=A8/=E5=8F=96=
=E3=82=8A=E6=B6=88=E3=81=99"
=20
-#: git-gui.sh:2535
+#: git-gui.sh:2572
 msgid "Decrease Font Size"
 msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=B0=8F=E3=81=95=
=E3=81=8F"
=20
-#: git-gui.sh:2539
+#: git-gui.sh:2576
 msgid "Increase Font Size"
 msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=A4=A7=E3=81=8D=
=E3=81=8F"
=20
-#: git-gui.sh:2544
+#: git-gui.sh:2581
 msgid "Show Less Context"
 msgstr "=E6=96=87=E8=84=88=E3=82=92=E5=B0=91=E3=81=AA=E3=81=8F"
=20
-#: git-gui.sh:2551
+#: git-gui.sh:2588
 msgid "Show More Context"
 msgstr "=E6=96=87=E8=84=88=E3=82=92=E5=A4=9A=E3=81=8F"
=20
-#: git-gui.sh:2565
+#: git-gui.sh:2602
 msgid "Unstage Hunk From Commit"
 msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=8B=E3=82=89=E5=A4=96=E3=81=99"
=20
-#: git-gui.sh:2567
+#: git-gui.sh:2604
 msgid "Stage Hunk For Commit"
 msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=AB=E5=8A=A0=E3=81=88=E3=82=8B"
=20
-#: git-gui.sh:2586
+#: git-gui.sh:2623
 msgid "Initializing..."
 msgstr "=E5=88=9D=E6=9C=9F=E5=8C=96=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=
=E3=81=99=E2=80=A6"
=20
-#: git-gui.sh:2677
+#: git-gui.sh:2718
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -447,7 +449,7 @@ msgstr ""
 "=E4=BB=A5=E4=B8=8B=E3=81=AE=E7=92=B0=E5=A2=83=E5=A4=89=E6=95=B0=E3=81=
=AF %s =E3=81=8C=E8=B5=B7=E5=8B=95=E3=81=99=E3=82=8B Git =E3=82=B5=E3=83=
=96=E3=83=97=E3=83=AD=E3=82=BB=E3=82=B9=E3=81=AB=E3=82=88=E3=81=A3=E3=81=
=A6=E7=84=A1=E8=A6=96=E3=81=95=E3=82=8C=E3=82=8B=E3=81=A7=E3=81=97=E3=82=
=87=E3=81=86:\n"
 "\n"
=20
-#: git-gui.sh:2707
+#: git-gui.sh:2748
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -457,7 +459,7 @@ msgstr ""
 "=E3=81=93=E3=82=8C=E3=81=AF Cygwin =E3=81=A7=E9=85=8D=E5=B8=83=E3=81=95=
=E3=82=8C=E3=81=A6=E3=81=84=E3=82=8B Tcl =E3=83=90=E3=82=A4=E3=83=8A=E3=
=83=AA=E3=81=AB\n"
 "=E9=96=A2=E3=81=97=E3=81=A6=E3=81=AE=E6=97=A2=E7=9F=A5=E3=81=AE=E5=95=
=8F=E9=A1=8C=E3=81=AB=E3=82=88=E3=82=8A=E3=81=BE=E3=81=99"
=20
-#: git-gui.sh:2712
+#: git-gui.sh:2753
 #, tcl-format
 msgid ""
 "\n"
@@ -576,7 +578,7 @@ msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=82=92=
=E4=BD=9C=E6=88=90"
 msgid "Create New Branch"
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=82=92=E6=96=B0=E8=A6=8F=
=E4=BD=9C=E6=88=90"
=20
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:199
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:375
 msgid "Create"
 msgstr "=E4=BD=9C=E6=88=90"
=20
@@ -729,9 +731,9 @@ msgstr "[=E4=B8=8A=E4=BD=8D=E3=83=95=E3=82=A9=E3=83=
=AB=E3=83=80=E3=81=B8]"
 msgid "Browse Branch Files"
 msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=92=E8=A6=8B=E3=82=8B=
"
=20
-#: lib/browser.tcl:277 lib/choose_repository.tcl:215
-#: lib/choose_repository.tcl:305 lib/choose_repository.tcl:315
-#: lib/choose_repository.tcl:811
+#: lib/browser.tcl:277 lib/choose_repository.tcl:391
+#: lib/choose_repository.tcl:482 lib/choose_repository.tcl:492
+#: lib/choose_repository.tcl:989
 msgid "Browse"
 msgstr "=E3=83=96=E3=83=A9=E3=82=A6=E3=82=BA"
=20
@@ -891,209 +893,225 @@ msgstr ""
 "=E3=81=93=E3=82=8C=E3=81=AF=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB=E6=96=
=87=E3=81=A7=E3=81=99=E3=80=82\n"
 "=E3=81=93=E3=81=AE=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=81=8C=E6=B0=
=97=E3=81=AB=E5=85=A5=E3=82=8C=E3=81=B0=E3=81=8A=E4=BD=BF=E3=81=84=E3=81=
=AB=E3=81=AA=E3=82=8C=E3=81=BE=E3=81=99=E3=80=82"
=20
-#: lib/choose_repository.tcl:25
+#: lib/choose_repository.tcl:27
 msgid "Git Gui"
 msgstr "Git GUI"
=20
-#: lib/choose_repository.tcl:69 lib/choose_repository.tcl:204
+#: lib/choose_repository.tcl:80 lib/choose_repository.tcl:380
 msgid "Create New Repository"
 msgstr "=E6=96=B0=E3=81=97=E3=81=84=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=
=E3=83=AA=E3=82=92=E4=BD=9C=E3=82=8B"
=20
-#: lib/choose_repository.tcl:74 lib/choose_repository.tcl:291
+#: lib/choose_repository.tcl:86
+msgid "New..."
+msgstr "=E6=96=B0=E8=A6=8F=E2=80=A6"
+
+#: lib/choose_repository.tcl:93 lib/choose_repository.tcl:468
 msgid "Clone Existing Repository"
 msgstr "=E6=97=A2=E5=AD=98=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=
=E3=82=92=E8=A4=87=E8=A3=BD=E3=81=99=E3=82=8B"
=20
-#: lib/choose_repository.tcl:79 lib/choose_repository.tcl:800
+#: lib/choose_repository.tcl:99
+msgid "Clone..."
+msgstr "=E8=A4=87=E8=A3=BD=E2=80=A6"
+
+#: lib/choose_repository.tcl:106 lib/choose_repository.tcl:978
 msgid "Open Existing Repository"
 msgstr "=E6=97=A2=E5=AD=98=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=
=E3=82=92=E9=96=8B=E3=81=8F"
=20
-#: lib/choose_repository.tcl:91
-msgid "Next >"
-msgstr "=E6=AC=A1 >"
+#: lib/choose_repository.tcl:112
+msgid "Open..."
+msgstr "=E9=96=8B=E3=81=8F=E2=80=A6"
+
+#: lib/choose_repository.tcl:125
+msgid "Recent Repositories"
+msgstr "=E6=9C=80=E8=BF=91=E4=BD=BF=E3=81=A3=E3=81=9F=E3=83=AA=E3=83=9D=
=E3=82=B8=E3=83=88=E3=83=AA"
+
+#: lib/choose_repository.tcl:131
+msgid "Open Recent Repository:"
+msgstr "=E6=9C=80=E8=BF=91=E4=BD=BF=E3=81=A3=E3=81=9F=E3=83=AA=E3=83=9D=
=E3=82=B8=E3=83=88=E3=83=AA=E3=82=92=E9=96=8B=E3=81=8F"
=20
-#: lib/choose_repository.tcl:152
+#: lib/choose_repository.tcl:294
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "'%s' =E3=81=AF=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=
=81=BE=E3=81=99=E3=80=82"
=20
-#: lib/choose_repository.tcl:158 lib/choose_repository.tcl:165
-#: lib/choose_repository.tcl:172
+#: lib/choose_repository.tcl:300 lib/choose_repository.tcl:307
+#: lib/choose_repository.tcl:314
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA %s =E3=82=92=E4=BD=
=9C=E8=A3=BD=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93:"
=20
-#: lib/choose_repository.tcl:209 lib/choose_repository.tcl:309
+#: lib/choose_repository.tcl:385 lib/choose_repository.tcl:486
 msgid "Directory:"
 msgstr "=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA:"
=20
-#: lib/choose_repository.tcl:238 lib/choose_repository.tcl:363
-#: lib/choose_repository.tcl:834
+#: lib/choose_repository.tcl:415 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1013
 msgid "Git Repository"
 msgstr "GIT =E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA"
=20
-#: lib/choose_repository.tcl:253 lib/choose_repository.tcl:260
+#: lib/choose_repository.tcl:430 lib/choose_repository.tcl:437
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA '%s' =E3=
=81=AF=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=99=E3=
=80=82"
=20
-#: lib/choose_repository.tcl:265
+#: lib/choose_repository.tcl:442
 #, tcl-format
 msgid "File %s already exists."
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB '%s' =E3=81=AF=E6=97=A2=E3=
=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=99=E3=80=82"
=20
-#: lib/choose_repository.tcl:286
+#: lib/choose_repository.tcl:463
 msgid "Clone"
 msgstr "=E8=A4=87=E8=A3=BD"
=20
-#: lib/choose_repository.tcl:299
+#: lib/choose_repository.tcl:476
 msgid "URL:"
 msgstr "URL:"
=20
-#: lib/choose_repository.tcl:319
+#: lib/choose_repository.tcl:496
 msgid "Clone Type:"
 msgstr "=E8=A4=87=E8=A3=BD=E6=96=B9=E5=BC=8F:"
=20
-#: lib/choose_repository.tcl:325
+#: lib/choose_repository.tcl:502
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "=E6=A8=99=E6=BA=96(=E9=AB=98=E9=80=9F=E3=83=BB=E4=B8=AD=E5=86=97=
=E9=95=B7=E5=BA=A6=E3=83=BB=E3=83=8F=E3=83=BC=E3=83=89=E3=83=AA=E3=83=B3=
=E3=82=AF)"
=20
-#: lib/choose_repository.tcl:331
+#: lib/choose_repository.tcl:508
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "=E5=85=A8=E8=A4=87=E5=86=99(=E4=BD=8E=E9=80=9F=E3=83=BB=E5=86=97=
=E9=95=B7=E3=83=90=E3=83=83=E3=82=AF=E3=82=A2=E3=83=83=E3=83=97)"
=20
-#: lib/choose_repository.tcl:337
+#: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "=E5=85=B1=E6=9C=89(=E6=9C=80=E9=AB=98=E9=80=9F=E3=83=BB=E9=9D=9E=
=E6=8E=A8=E5=A5=A8=E3=83=BB=E3=83=90=E3=83=83=E3=82=AF=E3=82=A2=E3=83=83=
=E3=83=97=E7=84=A1=E3=81=97)"
=20
-#: lib/choose_repository.tcl:369 lib/choose_repository.tcl:418
-#: lib/choose_repository.tcl:560 lib/choose_repository.tcl:630
-#: lib/choose_repository.tcl:840 lib/choose_repository.tcl:848
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:738 lib/choose_repository.tcl:808
+#: lib/choose_repository.tcl:1019 lib/choose_repository.tcl:1027
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "Git =E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=E3=81=A7=E3=81=
=AF=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
-#: lib/choose_repository.tcl:405
+#: lib/choose_repository.tcl:586
 msgid "Standard only available for local repository."
 msgstr "=E6=A8=99=E6=BA=96=E6=96=B9=E5=BC=8F=E3=81=AF=E5=90=8C=E4=B8=80=
=E8=A8=88=E7=AE=97=E6=A9=9F=E4=B8=8A=E3=81=AE=E3=83=AA=E3=83=9D=E3=82=B8=
=E3=83=88=E3=83=AA=E3=81=AB=E3=81=AE=E3=81=BF=E4=BD=BF=E3=81=88=E3=81=BE=
=E3=81=99=E3=80=82"
=20
-#: lib/choose_repository.tcl:409
+#: lib/choose_repository.tcl:590
 msgid "Shared only available for local repository."
 msgstr "=E5=85=B1=E6=9C=89=E6=96=B9=E5=BC=8F=E3=81=AF=E5=90=8C=E4=B8=80=
=E8=A8=88=E7=AE=97=E6=A9=9F=E4=B8=8A=E3=81=AE=E3=83=AA=E3=83=9D=E3=82=B8=
=E3=83=88=E3=83=AA=E3=81=AB=E3=81=AE=E3=81=BF=E4=BD=BF=E3=81=88=E3=81=BE=
=E3=81=99=E3=80=82"
=20
-#: lib/choose_repository.tcl:439
+#: lib/choose_repository.tcl:617
 msgid "Failed to configure origin"
 msgstr "origin =E3=82=92=E8=A8=AD=E5=AE=9A=E3=81=A7=E3=81=8D=E3=81=BE=E3=
=81=9B=E3=82=93=E3=81=A7=E3=81=97=E3=81=9F"
=20
-#: lib/choose_repository.tcl:451
+#: lib/choose_repository.tcl:629
 msgid "Counting objects"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E6=95=B0=E3=81=88=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:452
+#: lib/choose_repository.tcl:630
 msgid "buckets"
 msgstr "=E3=83=90=E3=82=B1=E3=83=84"
=20
-#: lib/choose_repository.tcl:476
+#: lib/choose_repository.tcl:654
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "objects/info/alternates =E3=82=92=E8=A4=87=E5=86=99=E3=81=A7=E3=
=81=8D=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
-#: lib/choose_repository.tcl:512
+#: lib/choose_repository.tcl:690
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "%s =E3=81=8B=E3=82=89=E8=A4=87=E8=A3=BD=E3=81=99=E3=82=8B=E5=86=
=85=E5=AE=B9=E3=81=AF=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: lib/choose_repository.tcl:514 lib/choose_repository.tcl:728
-#: lib/choose_repository.tcl:740
+#: lib/choose_repository.tcl:692 lib/choose_repository.tcl:906
+#: lib/choose_repository.tcl:918
 msgid "The 'master' branch has not been initialized."
 msgstr "'master' =E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=8C=E5=88=9D=
=E6=9C=9F=E5=8C=96=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=
=E3=82=93"
=20
-#: lib/choose_repository.tcl:527
+#: lib/choose_repository.tcl:705
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "=E3=83=8F=E3=83=BC=E3=83=89=E3=83=AA=E3=83=B3=E3=82=AF=E3=81=8C=
=E4=BD=9C=E3=82=8C=E3=81=AA=E3=81=84=E3=81=AE=E3=81=A7=E3=80=81=E3=82=B3=
=E3=83=94=E3=83=BC=E3=81=97=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:539
+#: lib/choose_repository.tcl:717
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "%s =E3=81=8B=E3=82=89=E8=A4=87=E8=A3=BD=E3=81=97=E3=81=A6=E3=81=
=84=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:570
+#: lib/choose_repository.tcl:748
 msgid "Copying objects"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E8=A4=87=E5=86=99=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:571
+#: lib/choose_repository.tcl:749
 msgid "KiB"
 msgstr "KiB"
=20
-#: lib/choose_repository.tcl:595
+#: lib/choose_repository.tcl:773
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E8=A4=87=E5=86=99=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
-#: lib/choose_repository.tcl:605
+#: lib/choose_repository.tcl:783
 msgid "Linking objects"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E9=80=A3=E7=B5=90=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:606
+#: lib/choose_repository.tcl:784
 msgid "objects"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88"
=20
-#: lib/choose_repository.tcl:614
+#: lib/choose_repository.tcl:792
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E3=83=8F=E3=83=BC=E3=83=89=E3=83=AA=E3=83=B3=E3=82=AF=E3=81=A7=E3=81=8D=
=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
-#: lib/choose_repository.tcl:669
+#: lib/choose_repository.tcl:847
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=82=84=E3=82=AA=E3=83=96=
=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=E5=8F=96=E5=BE=97=E3=81=A7=
=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=E3=82=B3=E3=83=B3=E3=82=BD=
=E3=83=BC=E3=83=AB=E5=87=BA=E5=8A=9B=E3=82=92=E8=A6=8B=E3=81=A6=E4=B8=8B=
=E3=81=95=E3=81=84"
=20
-#: lib/choose_repository.tcl:680
+#: lib/choose_repository.tcl:858
 msgid "Cannot fetch tags.  See console output for details."
 msgstr "=E3=82=BF=E3=82=B0=E3=82=92=E5=8F=96=E5=BE=97=E3=81=A7=E3=81=8D=
=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=E3=82=B3=E3=83=B3=E3=82=BD=E3=83=BC=
=E3=83=AB=E5=87=BA=E5=8A=9B=E3=82=92=E8=A6=8B=E3=81=A6=E4=B8=8B=E3=81=95=
=E3=81=84"
=20
-#: lib/choose_repository.tcl:704
+#: lib/choose_repository.tcl:882
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr "HEAD =E3=82=92=E7=A2=BA=E5=AE=9A=E3=81=A7=E3=81=8D=E3=81=BE=E3=
=81=9B=E3=82=93=E3=80=82=E3=82=B3=E3=83=B3=E3=82=BD=E3=83=BC=E3=83=AB=E5=
=87=BA=E5=8A=9B=E3=82=92=E8=A6=8B=E3=81=A6=E4=B8=8B=E3=81=95=E3=81=84"
=20
-#: lib/choose_repository.tcl:713
+#: lib/choose_repository.tcl:891
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "%s =E3=82=92=E6=8E=83=E9=99=A4=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=
=9B=E3=82=93"
=20
-#: lib/choose_repository.tcl:719
+#: lib/choose_repository.tcl:897
 msgid "Clone failed."
 msgstr "=E8=A4=87=E5=86=99=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=
=E3=81=97=E3=81=9F=E3=80=82"
=20
-#: lib/choose_repository.tcl:726
+#: lib/choose_repository.tcl:904
 msgid "No default branch obtained."
 msgstr "=E3=83=87=E3=83=95=E3=82=A9=E3=83=BC=E3=83=AB=E3=83=88=E3=83=BB=
=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=8C=E5=8F=96=E5=BE=97=E3=81=95=
=E3=82=8C=E3=81=BE=E3=81=9B=E3=82=93=E3=81=A7=E3=81=97=E3=81=9F"
=20
-#: lib/choose_repository.tcl:737
+#: lib/choose_repository.tcl:915
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "%s =E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=A8=E3=81=
=97=E3=81=A6=E8=A7=A3=E9=87=88=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=
=93"
=20
-#: lib/choose_repository.tcl:749
+#: lib/choose_repository.tcl:927
 msgid "Creating working directory"
 msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=82=92=E4=BD=9C=E6=88=90=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=
=E3=81=99"
=20
-#: lib/choose_repository.tcl:750 lib/index.tcl:15 lib/index.tcl:80
-#: lib/index.tcl:149
+#: lib/choose_repository.tcl:928 lib/index.tcl:65 lib/index.tcl:127
+#: lib/index.tcl:193
 msgid "files"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB"
=20
-#: lib/choose_repository.tcl:779
+#: lib/choose_repository.tcl:957
 msgid "Initial file checkout failed."
 msgstr "=E5=88=9D=E6=9C=9F=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=
=E3=82=A6=E3=83=88=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=97=
=E3=81=9F"
=20
-#: lib/choose_repository.tcl:795
+#: lib/choose_repository.tcl:973
 msgid "Open"
 msgstr "=E9=96=8B=E3=81=8F"
=20
-#: lib/choose_repository.tcl:805
+#: lib/choose_repository.tcl:983
 msgid "Repository:"
 msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA:"
=20
-#: lib/choose_repository.tcl:854
+#: lib/choose_repository.tcl:1033
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA %s =E3=82=92=E9=96=
=8B=E3=81=91=E3=81=BE=E3=81=9B=E3=82=93:"
@@ -1232,7 +1250,7 @@ msgid ""
 "\n"
 "A good commit message has the following format:\n"
 "\n"
-"- First line: Describe in one sentance what you did.\n"
+"- First line: Describe in one sentence what you did.\n"
 "- Second line: Blank\n"
 "- Remaining lines: Describe why this change is good.\n"
 msgstr ""
@@ -1349,7 +1367,8 @@ msgid ""
 msgstr ""
 "=E3=81=93=E3=81=AE=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=E3=81=
=AB=E3=81=AF=E3=81=8A=E3=81=8A=E3=82=88=E3=81=9D %i =E5=80=8B=E3=81=AE=E5=
=80=8B=E5=88=A5=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=
=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=99\n"
 "\n"
-"=E6=9C=80=E9=81=A9=E3=81=AA=E6=80=A7=E8=83=BD=E3=82=92=E4=BF=9D=E3=81=
=A4=E3=81=9F=E3=82=81=E3=81=AB=E3=80=81%i =E5=80=8B=E4=BB=A5=E4=B8=8A=E3=
=81=AE=E5=80=8B=E5=88=A5=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=
=83=88=E3=82=92=E4=BD=9C=E3=82=8B=E6=AF=8E=E3=81=AB=E3=83=87=E3=83=BC=E3=
=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E3=82=92=E5=9C=A7=E7=B8=AE=E3=81=99=E3=
=82=8B=E3=81=93=E3=81=A8=E3=82=92=E6=8E=A8=E5=A5=A8=E3=81=97=E3=81=BE=E3=
=81=99\n"
+"=E6=9C=80=E9=81=A9=E3=81=AA=E6=80=A7=E8=83=BD=E3=82=92=E4=BF=9D=E3=81=
=A4=E3=81=9F=E3=82=81=E3=81=AB=E3=80=81%i =E5=80=8B=E4=BB=A5=E4=B8=8A=E3=
=81=AE=E5=80=8B=E5=88=A5=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=
=83=88=E3=82=92=E4=BD=9C=E3=82=8B=E6=AF=8E=E3=81=AB=E3=83=87=E3=83=BC=E3=
=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E3=82=92=E5=9C=A7"
+"=E7=B8=AE=E3=81=99=E3=82=8B=E3=81=93=E3=81=A8=E3=82=92=E6=8E=A8=E5=A5=
=A8=E3=81=97=E3=81=BE=E3=81=99\n"
 "\n"
 "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E3=82=92=E5=9C=
=A7=E7=B8=AE=E3=81=97=E3=81=BE=E3=81=99=E3=81=8B=EF=BC=9F"
=20
@@ -1426,31 +1445,53 @@ msgstr "=E8=AD=A6=E5=91=8A"
 msgid "You must correct the above errors before committing."
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=99=E3=82=8B=E5=89=8D=
=E3=81=AB=E3=80=81=E4=BB=A5=E4=B8=8A=E3=81=AE=E3=82=A8=E3=83=A9=E3=83=BC=
=E3=82=92=E4=BF=AE=E6=AD=A3=E3=81=97=E3=81=A6=E4=B8=8B=E3=81=95=E3=81=84=
"
=20
-#: lib/index.tcl:241
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "=E3=82=A4=E3=83=B3=E3=83=87=E3=83=83=E3=82=AF=E3=82=B9=E3=82=92=
=E3=83=AD=E3=83=83=E3=82=AF=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93=
"
+
+#: lib/index.tcl:15
+msgid "Index Error"
+msgstr "=E7=B4=A2=E5=BC=95=E3=82=A8=E3=83=A9=E3=83=BC"
+
+#: lib/index.tcl:21
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically starte=
d to "
+"resynchronize git-gui."
+msgstr "GIT =E3=82=A4=E3=83=B3=E3=83=87=E3=83=83=E3=82=AF=E3=82=B9=E3=81=
=AE=E6=9B=B4=E6=96=B0=E3=81=8C=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=
=97=E3=81=9F=E3=80=82git-gui =E3=81=A8=E5=90=8C=E6=9C=9F=E3=82=92=E3=81=
=A8=E3=82=8B=E3=81=9F=E3=82=81=E3=81=AB=E5=86=8D=E3=82=B9=E3=82=AD=E3=83=
=A3=E3=83=B3=E3=81=97=E3=81=BE=E3=81=99=E3=80=82"
+
+#: lib/index.tcl:27
+msgid "Continue"
+msgstr "=E7=B6=9A=E8=A1=8C"
+
+#: lib/index.tcl:31
+msgid "Unlock Index"
+msgstr "=E3=82=A4=E3=83=B3=E3=83=87=E3=83=83=E3=82=AF=E3=82=B9=E3=81=AE=
=E3=83=AD=E3=83=83=E3=82=AF=E8=A7=A3=E9=99=A4"
+
+#: lib/index.tcl:282
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=8B=E3=82=89 '%s' =E3=
=82=92=E9=99=8D=E3=82=8D=E3=81=99"
=20
-#: lib/index.tcl:285
+#: lib/index.tcl:326
 #, tcl-format
 msgid "Adding %s"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AB %s =E3=82=92=E5=8A=
=A0=E3=81=88=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/index.tcl:340
+#: lib/index.tcl:381
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB %s =E3=81=AB=E3=81=97=E3=81=
=9F=E5=A4=89=E6=9B=B4=E3=82=92=E5=85=83=E3=81=AB=E6=88=BB=E3=81=97=E3=81=
=BE=E3=81=99=E3=81=8B=EF=BC=9F"
=20
-#: lib/index.tcl:342
+#: lib/index.tcl:383
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "=E3=81=93=E3=82=8C=E3=82=89 %i =E5=80=8B=E3=81=AE=E3=83=95=E3=82=
=A1=E3=82=A4=E3=83=AB=E3=81=AB=E3=81=97=E3=81=9F=E5=A4=89=E6=9B=B4=E3=82=
=92=E5=85=83=E3=81=AB=E6=88=BB=E3=81=97=E3=81=BE=E3=81=99=E3=81=8B=EF=BC=
=9F"
=20
-#: lib/index.tcl:348
+#: lib/index.tcl:389
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr "=E5=A4=89=E6=9B=B4=E3=82=92=E5=85=83=E3=81=AB=E6=88=BB=E3=81=99=
=E3=81=A8=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=97=
=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=E5=A4=89=E6=9B=B4=E3=81=AF=E5=85=A8=
=E3=81=A6=E5=A4=B1=E3=82=8F=E3=82=8C=E3=81=BE=E3=81=99=E3=80=82"
=20
-#: lib/index.tcl:351
+#: lib/index.tcl:392
 msgid "Do Nothing"
 msgstr "=E4=BD=95=E3=82=82=E3=81=97=E3=81=AA=E3=81=84"
=20
@@ -1669,18 +1710,6 @@ msgstr "=E8=A8=AD=E5=AE=9A"
 msgid "Failed to completely save options:"
 msgstr "=E5=AE=8C=E5=85=A8=E3=81=AB=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=
=E3=83=B3=E3=82=92=E4=BF=9D=E5=AD=98=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=
=E3=82=93:"
=20
-#: lib/remote.tcl:165
-msgid "Prune from"
-msgstr "=E3=81=8B=E3=82=89=E5=88=88=E8=BE=BC=E3=82=80=E2=80=A6"
-
-#: lib/remote.tcl:170
-msgid "Fetch from"
-msgstr "=E5=8F=96=E5=BE=97=E5=85=83"
-
-#: lib/remote.tcl:213
-msgid "Push to"
-msgstr "=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5=E5=85=88"
-
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Remote Branch"
 msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88=E3=83=BB=E3=83=96=E3=83=A9=
=E3=83=B3=E3=83=81=E3=82=92=E5=89=8A=E9=99=A4"
@@ -1765,11 +1794,23 @@ msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=
=83=AA=E3=81=8C=E9=81=B8=E6=8A=9E=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=
=81=BE=E3=81=9B=E3=82=93=E3=80=82"
 msgid "Scanning %s..."
 msgstr "%s =E3=82=92=E3=82=B9=E3=82=AD=E3=83=A3=E3=83=B3=E3=81=97=E3=81=
=A6=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
-#: lib/shortcut.tcl:26 lib/shortcut.tcl:74
-msgid "Cannot write script:"
-msgstr "=E3=82=B9=E3=82=AF=E3=83=AA=E3=83=97=E3=83=88=E3=81=8C=E6=9B=B8=
=E3=81=91=E3=81=BE=E3=81=9B=E3=82=93:"
+#: lib/remote.tcl:165
+msgid "Prune from"
+msgstr "=E3=81=8B=E3=82=89=E5=88=88=E8=BE=BC=E3=82=80=E2=80=A6"
+
+#: lib/remote.tcl:170
+msgid "Fetch from"
+msgstr "=E5=8F=96=E5=BE=97=E5=85=83"
=20
-#: lib/shortcut.tcl:149
+#: lib/remote.tcl:213
+msgid "Push to"
+msgstr "=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5=E5=85=88"
+
+#: lib/shortcut.tcl:20 lib/shortcut.tcl:61
+msgid "Cannot write shortcut:"
+msgstr "=E3=82=B7=E3=83=A7=E3=83=BC=E3=83=88=E3=82=AB=E3=83=83=E3=83=88=
=E3=81=8C=E6=9B=B8=E3=81=91=E3=81=BE=E3=81=9B=E3=82=93:"
+
+#: lib/shortcut.tcl:136
 msgid "Cannot write icon:"
 msgstr "=E3=82=A2=E3=82=A4=E3=82=B3=E3=83=B3=E3=81=8C=E6=9B=B8=E3=81=91=
=E3=81=BE=E3=81=9B=E3=82=93:"
=20
@@ -1840,4 +1881,3 @@ msgstr "Thin Pack =E3=82=92=E4=BD=BF=E3=81=86=EF=BC=
=88=E9=81=85=E3=81=84=E3=83=8D=E3=83=83=E3=83=88=E3=83=AF=E3=83=BC=E3=82=
=AF=E6=8E=A5=E7=B6=9A=EF=BC=89"
 #: lib/transport.tcl:168
 msgid "Include tags"
 msgstr "=E3=82=BF=E3=82=B0=E3=82=92=E5=90=AB=E3=82=81=E3=82=8B"
-
--=20
1.5.3.6

----------------------------------------------------------------------
=46ree pop3 email with a spam filter.
http://www.bluebottle.com/tag/5
