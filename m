From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: [PATCH] git-gui: Update Japanese strings
Date: Wed, 31 Oct 2007 23:12:12 +0900
Message-ID: <200710311412.l9VECpnI002616@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 31 15:32:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InEcK-0005n9-OS
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 15:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895AbXJaOcK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 10:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755564AbXJaOcJ
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 10:32:09 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:41694 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412AbXJaOcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 10:32:07 -0400
X-Greylist: delayed 1154 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Oct 2007 10:32:07 EDT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l9VECpnI002616
	for <git@vger.kernel.org>; Wed, 31 Oct 2007 07:12:51 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=HvNI6QFxX7nieNi1k++ZQr9kCtnNQX1dglf1GbWlCzPgXxW6KOwva4LYc0gIRGqNK
	2WU3aXcXKGbawEzzFyeDYoyLJNmrtdFqxU53bCtqr2IFxwqoMPXklBZvpIBuDd/
Received: from nanako3.mail.bluebottle.com ([212.62.97.23])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l9VECXrQ027457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 31 Oct 2007 07:12:44 -0700
X-Trusted-Delivery: <c0ce05e153ba136d512579fb0720a6aa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62838>

This updates the Japanese translation file.

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@bluebottle.com>
---
 po/ja.po |  277 ++++++++++++++++++++++++++++++------------------------=
--------
 1 files changed, 133 insertions(+), 144 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index f65e460..e4491f7 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -9,7 +9,7 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2007-10-10 04:04-0400\n"
-"PO-Revision-Date: 2007-08-14 18:49+0900\n"
+"PO-Revision-Date: 2007-10-31 16:23+0900\n"
 "Last-Translator: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=
=AA=E3=81=93 <nanako3@bluebottle.com>\n"
 "Language-Team: Japanese\n"
 "MIME-Version: 1.0\n"
@@ -19,12 +19,12 @@ msgstr ""
 #: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.=
sh:744
 #: git-gui.sh:763
 msgid "git-gui: fatal error"
-msgstr ""
+msgstr "git-gui: =E8=87=B4=E5=91=BD=E7=9A=84=E3=81=AA=E3=82=A8=E3=83=A9=
=E3=83=BC"
=20
 #: git-gui.sh:595
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Invalid font specified in %s:"
-msgstr "gui.%s =E3=81=AB=E7=84=A1=E5=8A=B9=E3=81=AA=E3=83=95=E3=82=A9=E3=
=83=B3=E3=83=88=E3=81=8C=E6=8C=87=E5=AE=9A=E3=81=95=E3=82=8C=E3=81=A6=E3=
=81=84=E3=81=BE=E3=81=99:"
+msgstr "%s =E3=81=AB=E7=84=A1=E5=8A=B9=E3=81=AA=E3=83=95=E3=82=A9=E3=83=
=B3=E3=83=88=E3=81=8C=E6=8C=87=E5=AE=9A=E3=81=95=E3=82=8C=E3=81=A6=E3=81=
=84=E3=81=BE=E3=81=99:"
=20
 #: git-gui.sh:620
 msgid "Main Font"
@@ -66,9 +66,8 @@ msgid "Git directory not found:"
 msgstr "Git =E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA=E3=81=
=8C=E8=A6=8B=E3=81=A4=E3=81=8B=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93:"
=20
 #: git-gui.sh:860
-#, fuzzy
 msgid "Cannot move to top of working directory:"
-msgstr "=E5=A4=89=E3=81=AA .git =E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=
=83=88=E3=83=AA=E3=81=AF=E4=BD=BF=E3=81=88=E3=81=BE=E3=81=9B=E3=82=93"
+msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=81=AE=E6=9C=80=E4=B8=8A=E4=BD=8D=E3=81=AB=E7=A7=BB=E5=8B=95=
=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93"
=20
 #: git-gui.sh:867
 msgid "Cannot use funny .git directory:"
@@ -158,7 +157,6 @@ msgid "Branch"
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81"
=20
 #: git-gui.sh:1794 lib/choose_rev.tcl:547
-#, fuzzy
 msgid "Commit@@noun"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88"
=20
@@ -167,9 +165,8 @@ msgid "Merge"
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8"
=20
 #: git-gui.sh:1798 lib/choose_rev.tcl:556
-#, fuzzy
 msgid "Remote"
-msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88:"
+msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88"
=20
 #: git-gui.sh:1807
 msgid "Browse Current Branch's Files"
@@ -301,7 +298,6 @@ msgid "Sign Off"
 msgstr "=E7=BD=B2=E5=90=8D"
=20
 #: git-gui.sh:1980 git-gui.sh:2296
-#, fuzzy
 msgid "Commit@@verb"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88"
=20
@@ -329,7 +325,7 @@ msgstr "%s =E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6"
=20
 #: git-gui.sh:2026
 msgid "Preferences..."
-msgstr ""
+msgstr "=E8=A8=AD=E5=AE=9A=E2=80=A6"
=20
 #: git-gui.sh:2034 git-gui.sh:2558
 msgid "Options..."
@@ -346,21 +342,19 @@ msgstr "=E3=82=AA=E3=83=B3=E3=83=A9=E3=82=A4=E3=83=
=B3=E3=83=BB=E3=83=89=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=88"
 #: git-gui.sh:2165
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
-msgstr ""
+msgstr "=E8=87=B4=E5=91=BD=E7=9A=84: =E3=83=91=E3=82=B9 %s =E3=81=8C s=
tat =E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=E3=81=9D=E3=81=
=AE=E3=82=88=E3=81=86=E3=81=AA=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=
=84=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA=E3=81=AF=E3=81=
=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
 #: git-gui.sh:2198
 msgid "Current Branch:"
 msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
"
=20
 #: git-gui.sh:2219
-#, fuzzy
 msgid "Staged Changes (Will Commit)"
 msgstr "=E3=82=B9=E3=83=86=E3=83=BC=E3=82=B8=E3=83=B3=E3=82=B0=E3=81=95=
=E3=82=8C=E3=81=9F=EF=BC=88=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=
=E5=AE=9A=E6=B8=88=E3=81=AE=EF=BC=89=E5=A4=89=E6=9B=B4"
=20
 #: git-gui.sh:2239
-#, fuzzy
 msgid "Unstaged Changes"
-msgstr "=E5=A4=89=E6=9B=B4=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=
=E4=BA=88=E5=AE=9A=E3=81=AB=E5=85=A5=E3=82=8C=E3=82=8B"
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=AB=
=E5=85=A5=E3=81=A3=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=E5=A4=89=E6=9B=B4=
"
=20
 #: git-gui.sh:2286
 msgid "Stage Changed"
@@ -448,6 +442,10 @@ msgid ""
 "by %s:\n"
 "\n"
 msgstr ""
+"=E7=92=B0=E5=A2=83=E3=81=AB=E5=95=8F=E9=A1=8C=E3=81=8C=E3=81=82=E3=82=
=8B=E5=8F=AF=E8=83=BD=E6=80=A7=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=
=99\n"
+"\n"
+"=E4=BB=A5=E4=B8=8B=E3=81=AE=E7=92=B0=E5=A2=83=E5=A4=89=E6=95=B0=E3=81=
=AF %s =E3=81=8C=E8=B5=B7=E5=8B=95=E3=81=99=E3=82=8B Git =E3=82=B5=E3=83=
=96=E3=83=97=E3=83=AD=E3=82=BB=E3=82=B9=E3=81=AB=E3=82=88=E3=81=A3=E3=81=
=A6=E7=84=A1=E8=A6=96=E3=81=95=E3=82=8C=E3=82=8B=E3=81=A7=E3=81=97=E3=82=
=87=E3=81=86:\n"
+"\n"
=20
 #: git-gui.sh:2707
 msgid ""
@@ -455,6 +453,9 @@ msgid ""
 "This is due to a known issue with the\n"
 "Tcl binary distributed by Cygwin."
 msgstr ""
+"\n"
+"=E3=81=93=E3=82=8C=E3=81=AF Cygwin =E3=81=A7=E9=85=8D=E5=B8=83=E3=81=95=
=E3=82=8C=E3=81=A6=E3=81=84=E3=82=8B Tcl =E3=83=90=E3=82=A4=E3=83=8A=E3=
=83=AA=E3=81=AB\n"
+"=E9=96=A2=E3=81=97=E3=81=A6=E3=81=AE=E6=97=A2=E7=9F=A5=E3=81=AE=E5=95=
=8F=E9=A1=8C=E3=81=AB=E3=82=88=E3=82=8A=E3=81=BE=E3=81=99"
=20
 #: git-gui.sh:2712
 #, tcl-format
@@ -466,6 +467,10 @@ msgid ""
 "user.email settings into your personal\n"
 "~/.gitconfig file.\n"
 msgstr ""
+"\n"
+"\n"
+"=E5=80=8B=E4=BA=BA=E7=9A=84=E3=81=AA ~/.gitconfig =E3=83=95=E3=82=A1=E3=
=82=A4=E3=83=AB=E5=86=85=E3=81=A7 user.name =E3=81=A8 user.email =E3=81=
=AE=E5=80=A4=E3=82=92=E8=A8=AD=E5=AE=9A\n"
+"=E3=81=99=E3=82=8B=E3=81=AE=E3=81=8C=E3=80=81%s =E3=81=AE=E8=89=AF=E3=
=81=84=E4=BB=A3=E7=94=A8=E3=81=A8=E3=81=AA=E3=82=8A=E3=81=BE=E3=81=99\n=
"
=20
 #: lib/about.tcl:25
 msgid "git-gui - a graphical user interface for Git."
@@ -490,50 +495,47 @@ msgstr "%s =E3=82=92=E8=AA=AD=E3=82=93=E3=81=A7=E3=
=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
 #: lib/blame.tcl:473
 msgid "Loading copy/move tracking annotations..."
-msgstr ""
+msgstr "=E3=82=B3=E3=83=94=E3=83=BC=E3=83=BB=E7=A7=BB=E5=8B=95=E8=BF=BD=
=E8=B7=A1=E3=83=87=E3=83=BC=E3=82=BF=E3=82=92=E8=AA=AD=E3=82=93=E3=81=A7=
=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
 #: lib/blame.tcl:493
 msgid "lines annotated"
-msgstr ""
+msgstr "=E8=A1=8C=E3=82=92=E6=B3=A8=E9=87=88=E3=81=97=E3=81=BE=E3=81=97=
=E3=81=9F"
=20
 #: lib/blame.tcl:674
 msgid "Loading original location annotations..."
-msgstr ""
+msgstr "=E5=85=83=E4=BD=8D=E7=BD=AE=E8=A1=8C=E3=81=AE=E6=B3=A8=E9=87=88=
=E3=83=87=E3=83=BC=E3=82=BF=E3=82=92=E8=AA=AD=E3=82=93=E3=81=A7=E3=81=84=
=E3=81=BE=E3=81=99=E2=80=A6"
=20
 #: lib/blame.tcl:677
 msgid "Annotation complete."
-msgstr ""
+msgstr "=E6=B3=A8=E9=87=88=E5=AE=8C=E4=BA=86=E3=81=97=E3=81=BE=E3=81=97=
=E3=81=9F"
=20
 #: lib/blame.tcl:731
-#, fuzzy
 msgid "Loading annotation..."
-msgstr "%s =E3=82=92=E3=83=AD=E3=83=BC=E3=83=89=E4=B8=AD=E2=80=A6"
+msgstr "=E6=B3=A8=E9=87=88=E3=82=92=E8=AA=AD=E3=81=BF=E8=BE=BC=E3=82=93=
=E3=81=A7=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
 #: lib/blame.tcl:787
 msgid "Author:"
-msgstr ""
+msgstr "=E4=BD=9C=E8=80=85:"
=20
 #: lib/blame.tcl:791
-#, fuzzy
 msgid "Committer:"
-msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88:"
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E8=80=85:"
=20
 #: lib/blame.tcl:796
 msgid "Original File:"
-msgstr ""
+msgstr "=E5=85=83=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB"
=20
 #: lib/blame.tcl:910
 msgid "Originally By:"
-msgstr ""
+msgstr "=E5=8E=9F=E4=BD=9C=E8=80=85:"
=20
 #: lib/blame.tcl:916
-#, fuzzy
 msgid "In File:"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB:"
=20
 #: lib/blame.tcl:921
 msgid "Copied Or Moved Here By:"
-msgstr ""
+msgstr "=E8=A4=87=E5=86=99=E3=83=BB=E7=A7=BB=E5=8B=95=E8=80=85:"
=20
 #: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
 msgid "Checkout Branch"
@@ -741,7 +743,7 @@ msgstr "%s =E3=81=8B=E3=82=89 %s =E3=82=92=E3=83=95=
=E3=82=A7=E3=83=83=E3=83=81=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=
"
 #: lib/checkout_op.tcl:127
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
-msgstr ""
+msgstr "=E8=87=B4=E5=91=BD=E7=9A=84=E3=82=A8=E3=83=A9=E3=83=BC: %s =E3=
=82=92=E8=A7=A3=E6=B1=BA=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93"
=20
 #: lib/checkout_op.tcl:140 lib/console.tcl:79 lib/database.tcl:31
 msgid "Close"
@@ -796,9 +798,9 @@ msgstr ""
 "=E8=87=AA=E5=8B=95=E7=9A=84=E3=81=AB=E5=86=8D=E3=82=B9=E3=82=AD=E3=83=
=A3=E3=83=B3=E3=82=92=E9=96=8B=E5=A7=8B=E3=81=97=E3=81=BE=E3=81=99=E3=80=
=82\n"
=20
 #: lib/checkout_op.tcl:322
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Updating working directory to '%s'..."
-msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
+msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=82=92 '%s' =E3=81=AB=E6=9B=B4=E6=96=B0=E3=81=97=E3=81=A6=E3=
=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
 #: lib/checkout_op.tcl:353
 #, tcl-format
@@ -827,9 +829,9 @@ msgstr ""
 "=E3=83=81=E3=82=92=E9=96=8B=E5=A7=8B=E3=81=97=E3=81=A6=E3=81=8F=E3=81=
=A0=E3=81=95=E3=81=84=E3=80=82"
=20
 #: lib/checkout_op.tcl:446
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Checked out '%s'."
-msgstr "=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=E3=82=A6=E3=83=88=
"
+msgstr "'%s' =E3=82=92=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=E3=
=82=A6=E3=83=88=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F"
=20
 #: lib/checkout_op.tcl:478
 #, tcl-format
@@ -866,244 +868,235 @@ msgstr ""
 "=E8=B5=B7=E3=81=93=E3=82=8B=E3=81=AF=E3=81=9A=E3=81=AE=E3=81=AA=E3=81=
=84=E3=82=A8=E3=83=A9=E3=83=BC=E3=81=A7=E3=81=99=E3=80=82=E3=81=82=E3=81=
=8D=E3=82=89=E3=82=81=E3=81=A6 %s =E3=82=92=E7=B5=82=E4=BA=86=E3=81=97=E3=
=81=BE=E3=81=99=E3=80=82"
=20
 #: lib/choose_font.tcl:39
-#, fuzzy
 msgid "Select"
-msgstr "=E5=85=A8=E3=81=A6=E9=81=B8=E6=8A=9E"
+msgstr "=E9=81=B8=E6=8A=9E"
=20
 #: lib/choose_font.tcl:53
 msgid "Font Family"
-msgstr ""
+msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=83=BB=E3=83=95=E3=82=A1=
=E3=83=9F=E3=83=AA=E3=83=BC"
=20
 #: lib/choose_font.tcl:73
-#, fuzzy
 msgid "Font Size"
-msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=B0=8F=E3=81=95=
=E3=81=8F"
+msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=81=AE=E5=A4=A7=E3=81=8D=
=E3=81=95"
=20
 #: lib/choose_font.tcl:90
 msgid "Font Example"
-msgstr ""
+msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=83=BB=E3=82=B5=E3=83=B3=
=E3=83=97=E3=83=AB"
=20
 #: lib/choose_font.tcl:101
 msgid ""
 "This is example text.\n"
 "If you like this text, it can be your font."
 msgstr ""
+"=E3=81=93=E3=82=8C=E3=81=AF=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB=E6=96=
=87=E3=81=A7=E3=81=99=E3=80=82\n"
+"=E3=81=93=E3=81=AE=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=81=8C=E6=B0=
=97=E3=81=AB=E5=85=A5=E3=82=8C=E3=81=B0=E3=81=8A=E4=BD=BF=E3=81=84=E3=81=
=AB=E3=81=AA=E3=82=8C=E3=81=BE=E3=81=99=E3=80=82"
=20
 #: lib/choose_repository.tcl:25
 msgid "Git Gui"
-msgstr ""
+msgstr "Git GUI"
=20
 #: lib/choose_repository.tcl:69 lib/choose_repository.tcl:204
-#, fuzzy
 msgid "Create New Repository"
-msgstr "=E5=85=83=E3=81=AE=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=
"
+msgstr "=E6=96=B0=E3=81=97=E3=81=84=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=
=E3=83=AA=E3=82=92=E4=BD=9C=E3=82=8B"
=20
 #: lib/choose_repository.tcl:74 lib/choose_repository.tcl:291
-#, fuzzy
 msgid "Clone Existing Repository"
-msgstr "=E9=80=81=E3=82=8A=E5=85=88=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=
=E3=83=AA"
+msgstr "=E6=97=A2=E5=AD=98=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=
=E3=82=92=E8=A4=87=E8=A3=BD=E3=81=99=E3=82=8B"
=20
 #: lib/choose_repository.tcl:79 lib/choose_repository.tcl:800
-#, fuzzy
 msgid "Open Existing Repository"
-msgstr "=E9=80=81=E3=82=8A=E5=85=88=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=
=E3=83=AA"
+msgstr "=E6=97=A2=E5=AD=98=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=
=E3=82=92=E9=96=8B=E3=81=8F"
=20
 #: lib/choose_repository.tcl:91
 msgid "Next >"
-msgstr ""
+msgstr "=E6=AC=A1 >"
=20
 #: lib/choose_repository.tcl:152
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Location %s already exists."
-msgstr "'%s'=E3=81=A8=E3=81=84=E3=81=86=E3=83=96=E3=83=A9=E3=83=B3=E3=83=
=81=E3=81=AF=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=
=99=E3=80=82"
+msgstr "'%s' =E3=81=AF=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=
=81=BE=E3=81=99=E3=80=82"
=20
 #: lib/choose_repository.tcl:158 lib/choose_repository.tcl:165
 #: lib/choose_repository.tcl:172
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Failed to create repository %s:"
-msgstr "=E5=AE=8C=E5=85=A8=E3=81=AB=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=
=E3=83=B3=E3=82=92=E4=BF=9D=E5=AD=98=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=
=E3=82=93:"
+msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA %s =E3=82=92=E4=BD=
=9C=E8=A3=BD=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93:"
=20
 #: lib/choose_repository.tcl:209 lib/choose_repository.tcl:309
 msgid "Directory:"
-msgstr ""
+msgstr "=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA:"
=20
 #: lib/choose_repository.tcl:238 lib/choose_repository.tcl:363
 #: lib/choose_repository.tcl:834
-#, fuzzy
 msgid "Git Repository"
-msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA"
+msgstr "GIT =E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA"
=20
 #: lib/choose_repository.tcl:253 lib/choose_repository.tcl:260
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Directory %s already exists."
-msgstr "'%s'=E3=81=A8=E3=81=84=E3=81=86=E3=83=96=E3=83=A9=E3=83=B3=E3=83=
=81=E3=81=AF=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=
=99=E3=80=82"
+msgstr "=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA '%s' =E3=
=81=AF=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=99=E3=
=80=82"
=20
 #: lib/choose_repository.tcl:265
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "File %s already exists."
-msgstr "'%s'=E3=81=A8=E3=81=84=E3=81=86=E3=83=96=E3=83=A9=E3=83=B3=E3=83=
=81=E3=81=AF=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=
=99=E3=80=82"
+msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB '%s' =E3=81=AF=E6=97=A2=E3=
=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=99=E3=80=82"
=20
 #: lib/choose_repository.tcl:286
-#, fuzzy
 msgid "Clone"
-msgstr "=E9=96=89=E3=81=98=E3=82=8B"
+msgstr "=E8=A4=87=E8=A3=BD"
=20
 #: lib/choose_repository.tcl:299
 msgid "URL:"
-msgstr ""
+msgstr "URL:"
=20
 #: lib/choose_repository.tcl:319
 msgid "Clone Type:"
-msgstr ""
+msgstr "=E8=A4=87=E8=A3=BD=E6=96=B9=E5=BC=8F:"
=20
 #: lib/choose_repository.tcl:325
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
-msgstr ""
+msgstr "=E6=A8=99=E6=BA=96(=E9=AB=98=E9=80=9F=E3=83=BB=E4=B8=AD=E5=86=97=
=E9=95=B7=E5=BA=A6=E3=83=BB=E3=83=8F=E3=83=BC=E3=83=89=E3=83=AA=E3=83=B3=
=E3=82=AF)"
=20
 #: lib/choose_repository.tcl:331
 msgid "Full Copy (Slower, Redundant Backup)"
-msgstr ""
+msgstr "=E5=85=A8=E8=A4=87=E5=86=99(=E4=BD=8E=E9=80=9F=E3=83=BB=E5=86=97=
=E9=95=B7=E3=83=90=E3=83=83=E3=82=AF=E3=82=A2=E3=83=83=E3=83=97)"
=20
 #: lib/choose_repository.tcl:337
 msgid "Shared (Fastest, Not Recommended, No Backup)"
-msgstr ""
+msgstr "=E5=85=B1=E6=9C=89(=E6=9C=80=E9=AB=98=E9=80=9F=E3=83=BB=E9=9D=9E=
=E6=8E=A8=E5=A5=A8=E3=83=BB=E3=83=90=E3=83=83=E3=82=AF=E3=82=A2=E3=83=83=
=E3=83=97=E7=84=A1=E3=81=97)"
=20
 #: lib/choose_repository.tcl:369 lib/choose_repository.tcl:418
 #: lib/choose_repository.tcl:560 lib/choose_repository.tcl:630
 #: lib/choose_repository.tcl:840 lib/choose_repository.tcl:848
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Not a Git repository: %s"
-msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=E3=81=8C=E9=81=B8=
=E6=8A=9E=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=E3=82=93=
=E3=80=82"
+msgstr "Git =E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=E3=81=A7=E3=81=
=AF=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
 #: lib/choose_repository.tcl:405
 msgid "Standard only available for local repository."
-msgstr ""
+msgstr "=E6=A8=99=E6=BA=96=E6=96=B9=E5=BC=8F=E3=81=AF=E5=90=8C=E4=B8=80=
=E8=A8=88=E7=AE=97=E6=A9=9F=E4=B8=8A=E3=81=AE=E3=83=AA=E3=83=9D=E3=82=B8=
=E3=83=88=E3=83=AA=E3=81=AB=E3=81=AE=E3=81=BF=E4=BD=BF=E3=81=88=E3=81=BE=
=E3=81=99=E3=80=82"
=20
 #: lib/choose_repository.tcl:409
 msgid "Shared only available for local repository."
-msgstr ""
+msgstr "=E5=85=B1=E6=9C=89=E6=96=B9=E5=BC=8F=E3=81=AF=E5=90=8C=E4=B8=80=
=E8=A8=88=E7=AE=97=E6=A9=9F=E4=B8=8A=E3=81=AE=E3=83=AA=E3=83=9D=E3=82=B8=
=E3=83=88=E3=83=AA=E3=81=AB=E3=81=AE=E3=81=BF=E4=BD=BF=E3=81=88=E3=81=BE=
=E3=81=99=E3=80=82"
=20
 #: lib/choose_repository.tcl:439
 msgid "Failed to configure origin"
-msgstr ""
+msgstr "origin =E3=82=92=E8=A8=AD=E5=AE=9A=E3=81=A7=E3=81=8D=E3=81=BE=E3=
=81=9B=E3=82=93=E3=81=A7=E3=81=97=E3=81=9F"
=20
 #: lib/choose_repository.tcl:451
 msgid "Counting objects"
-msgstr ""
+msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E6=95=B0=E3=81=88=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
 #: lib/choose_repository.tcl:452
 msgid "buckets"
-msgstr ""
+msgstr "=E3=83=90=E3=82=B1=E3=83=84"
=20
 #: lib/choose_repository.tcl:476
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
-msgstr ""
+msgstr "objects/info/alternates =E3=82=92=E8=A4=87=E5=86=99=E3=81=A7=E3=
=81=8D=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
 #: lib/choose_repository.tcl:512
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Nothing to clone from %s."
-msgstr "%s =E3=81=8B=E3=82=89=E6=96=B0=E3=81=97=E3=81=84=E5=A4=89=E6=9B=
=B4=E3=82=92=E3=83=95=E3=82=A7=E3=83=83=E3=83=81=E3=81=97=E3=81=A6=E3=81=
=84=E3=81=BE=E3=81=99"
+msgstr "%s =E3=81=8B=E3=82=89=E8=A4=87=E8=A3=BD=E3=81=99=E3=82=8B=E5=86=
=85=E5=AE=B9=E3=81=AF=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
 #: lib/choose_repository.tcl:514 lib/choose_repository.tcl:728
 #: lib/choose_repository.tcl:740
 msgid "The 'master' branch has not been initialized."
-msgstr ""
+msgstr "'master' =E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=8C=E5=88=9D=
=E6=9C=9F=E5=8C=96=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=
=E3=82=93"
=20
 #: lib/choose_repository.tcl:527
 msgid "Hardlinks are unavailable.  Falling back to copying."
-msgstr ""
+msgstr "=E3=83=8F=E3=83=BC=E3=83=89=E3=83=AA=E3=83=B3=E3=82=AF=E3=81=8C=
=E4=BD=9C=E3=82=8C=E3=81=AA=E3=81=84=E3=81=AE=E3=81=A7=E3=80=81=E3=82=B3=
=E3=83=94=E3=83=BC=E3=81=97=E3=81=BE=E3=81=99"
=20
 #: lib/choose_repository.tcl:539
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Cloning from %s"
-msgstr "%s =E3=81=8B=E3=82=89 %s =E3=82=92=E3=83=95=E3=82=A7=E3=83=83=E3=
=83=81=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
+msgstr "%s =E3=81=8B=E3=82=89=E8=A4=87=E8=A3=BD=E3=81=97=E3=81=A6=E3=81=
=84=E3=81=BE=E3=81=99"
=20
 #: lib/choose_repository.tcl:570
-#, fuzzy
 msgid "Copying objects"
-msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E5=9C=A7=
=E7=B8=AE"
+msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E8=A4=87=E5=86=99=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
 #: lib/choose_repository.tcl:571
 msgid "KiB"
-msgstr ""
+msgstr "KiB"
=20
 #: lib/choose_repository.tcl:595
 #, tcl-format
 msgid "Unable to copy object: %s"
-msgstr ""
+msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E8=A4=87=E5=86=99=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
 #: lib/choose_repository.tcl:605
 msgid "Linking objects"
-msgstr ""
+msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E9=80=A3=E7=B5=90=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
 #: lib/choose_repository.tcl:606
 msgid "objects"
-msgstr ""
+msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88"
=20
 #: lib/choose_repository.tcl:614
 #, tcl-format
 msgid "Unable to hardlink object: %s"
-msgstr ""
+msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E3=83=8F=E3=83=BC=E3=83=89=E3=83=AA=E3=83=B3=E3=82=AF=E3=81=A7=E3=81=8D=
=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
 #: lib/choose_repository.tcl:669
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
-msgstr ""
+msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=82=84=E3=82=AA=E3=83=96=
=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=E5=8F=96=E5=BE=97=E3=81=A7=
=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=E3=82=B3=E3=83=B3=E3=82=BD=
=E3=83=BC=E3=83=AB=E5=87=BA=E5=8A=9B=E3=82=92=E8=A6=8B=E3=81=A6=E4=B8=8B=
=E3=81=95=E3=81=84"
=20
 #: lib/choose_repository.tcl:680
 msgid "Cannot fetch tags.  See console output for details."
-msgstr ""
+msgstr "=E3=82=BF=E3=82=B0=E3=82=92=E5=8F=96=E5=BE=97=E3=81=A7=E3=81=8D=
=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=E3=82=B3=E3=83=B3=E3=82=BD=E3=83=BC=
=E3=83=AB=E5=87=BA=E5=8A=9B=E3=82=92=E8=A6=8B=E3=81=A6=E4=B8=8B=E3=81=95=
=E3=81=84"
=20
 #: lib/choose_repository.tcl:704
 msgid "Cannot determine HEAD.  See console output for details."
-msgstr ""
+msgstr "HEAD =E3=82=92=E7=A2=BA=E5=AE=9A=E3=81=A7=E3=81=8D=E3=81=BE=E3=
=81=9B=E3=82=93=E3=80=82=E3=82=B3=E3=83=B3=E3=82=BD=E3=83=BC=E3=83=AB=E5=
=87=BA=E5=8A=9B=E3=82=92=E8=A6=8B=E3=81=A6=E4=B8=8B=E3=81=95=E3=81=84"
=20
 #: lib/choose_repository.tcl:713
 #, tcl-format
 msgid "Unable to cleanup %s"
-msgstr ""
+msgstr "%s =E3=82=92=E6=8E=83=E9=99=A4=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=
=9B=E3=82=93"
=20
 #: lib/choose_repository.tcl:719
-#, fuzzy
 msgid "Clone failed."
-msgstr "=E4=B8=AD=E6=96=AD=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=
=E3=81=97=E3=81=9F=E3=80=82"
+msgstr "=E8=A4=87=E5=86=99=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=
=E3=81=97=E3=81=9F=E3=80=82"
=20
 #: lib/choose_repository.tcl:726
 msgid "No default branch obtained."
-msgstr ""
+msgstr "=E3=83=87=E3=83=95=E3=82=A9=E3=83=BC=E3=83=AB=E3=83=88=E3=83=BB=
=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=8C=E5=8F=96=E5=BE=97=E3=81=95=
=E3=82=8C=E3=81=BE=E3=81=9B=E3=82=93=E3=81=A7=E3=81=97=E3=81=9F"
=20
 #: lib/choose_repository.tcl:737
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
-msgstr ""
+msgstr "%s =E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=A8=E3=81=
=97=E3=81=A6=E8=A7=A3=E9=87=88=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=
=93"
=20
 #: lib/choose_repository.tcl:749
-#, fuzzy
 msgid "Creating working directory"
-msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
+msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=82=92=E4=BD=9C=E6=88=90=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=
=E3=81=99"
=20
 #: lib/choose_repository.tcl:750 lib/index.tcl:15 lib/index.tcl:80
 #: lib/index.tcl:149
 msgid "files"
-msgstr ""
+msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB"
=20
 #: lib/choose_repository.tcl:779
 msgid "Initial file checkout failed."
-msgstr ""
+msgstr "=E5=88=9D=E6=9C=9F=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=
=E3=82=A6=E3=83=88=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=97=
=E3=81=9F"
=20
 #: lib/choose_repository.tcl:795
 msgid "Open"
-msgstr ""
+msgstr "=E9=96=8B=E3=81=8F"
=20
 #: lib/choose_repository.tcl:805
-#, fuzzy
 msgid "Repository:"
-msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA"
+msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA:"
=20
 #: lib/choose_repository.tcl:854
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Failed to open repository %s:"
-msgstr "=E5=AE=8C=E5=85=A8=E3=81=AB=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=
=E3=83=B3=E3=82=92=E4=BF=9D=E5=AD=98=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=
=E3=82=93:"
+msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA %s =E3=82=92=E9=96=
=8B=E3=81=91=E3=81=BE=E3=81=9B=E3=82=93:"
=20
 #: lib/choose_rev.tcl:53
 msgid "This Detached Checkout"
@@ -1140,11 +1133,11 @@ msgstr "=E3=83=AA=E3=83=93=E3=82=B8=E3=83=A7=E3=
=83=B3=E5=BC=8F=E3=81=8C=E7=A9=BA=E3=81=A7=E3=81=99=E3=80=82"
=20
 #: lib/choose_rev.tcl:530
 msgid "Updated"
-msgstr ""
+msgstr "=E6=9B=B4=E6=96=B0=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F"
=20
 #: lib/choose_rev.tcl:558
 msgid "URL"
-msgstr ""
+msgstr "URL"
=20
 #: lib/commit.tcl:9
 msgid ""
@@ -1258,7 +1251,7 @@ msgstr "write-tree =E3=81=8C=E5=A4=B1=E6=95=97=E3=
=81=97=E3=81=BE=E3=81=97=E3=81=9F:"
 #: lib/commit.tcl:275
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
-msgstr ""
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88 %s =E3=81=AF=E5=A3=8A=E3=82=
=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
 #: lib/commit.tcl:279
 msgid ""
@@ -1281,7 +1274,7 @@ msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=
=99=E3=82=8B=E5=A4=89=E6=9B=B4=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=
=9B=E3=82=93=E3=80=82"
 #: lib/commit.tcl:303
 #, tcl-format
 msgid "warning: Tcl does not support encoding '%s'."
-msgstr ""
+msgstr "=E8=AD=A6=E5=91=8A: Tcl =E3=81=AF=E3=82=A8=E3=83=B3=E3=82=B3=E3=
=83=BC=E3=83=87=E3=82=A3=E3=83=B3=E3=82=B0 '%s' =E3=82=92=E3=82=B5=E3=83=
=9D=E3=83=BC=E3=83=88=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=E3=82=
=93"
=20
 #: lib/commit.tcl:317
 msgid "commit-tree failed:"
@@ -1354,11 +1347,16 @@ msgid ""
 "\n"
 "Compress the database now?"
 msgstr ""
+"=E3=81=93=E3=81=AE=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=E3=81=
=AB=E3=81=AF=E3=81=8A=E3=81=8A=E3=82=88=E3=81=9D %i =E5=80=8B=E3=81=AE=E5=
=80=8B=E5=88=A5=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=
=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=99\n"
+"\n"
+"=E6=9C=80=E9=81=A9=E3=81=AA=E6=80=A7=E8=83=BD=E3=82=92=E4=BF=9D=E3=81=
=A4=E3=81=9F=E3=82=81=E3=81=AB=E3=80=81%i =E5=80=8B=E4=BB=A5=E4=B8=8A=E3=
=81=AE=E5=80=8B=E5=88=A5=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=
=83=88=E3=82=92=E4=BD=9C=E3=82=8B=E6=AF=8E=E3=81=AB=E3=83=87=E3=83=BC=E3=
=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E3=82=92=E5=9C=A7=E7=B8=AE=E3=81=99=E3=
=82=8B=E3=81=93=E3=81=A8=E3=82=92=E6=8E=A8=E5=A5=A8=E3=81=97=E3=81=BE=E3=
=81=99\n"
+"\n"
+"=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E3=82=92=E5=9C=
=A7=E7=B8=AE=E3=81=97=E3=81=BE=E3=81=99=E3=81=8B=EF=BC=9F"
=20
 #: lib/date.tcl:25
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Invalid date from Git: %s"
-msgstr "=E7=84=A1=E5=8A=B9=E3=81=AA=E3=83=AA=E3=83=93=E3=82=B8=E3=83=A7=
=E3=83=B3: %s"
+msgstr "Git =E3=81=8B=E3=82=89=E5=87=BA=E3=81=9F=E7=84=A1=E5=8A=B9=E3=81=
=AA=E6=97=A5=E4=BB=98: %s"
=20
 #: lib/diff.tcl:42
 #, tcl-format
@@ -1383,14 +1381,14 @@ msgstr ""
 "=E5=90=8C=E6=A7=98=E3=81=AA=E7=8A=B6=E6=85=8B=E3=81=AE=E3=83=95=E3=82=
=A1=E3=82=A4=E3=83=AB=E3=82=92=E6=8E=A2=E3=81=99=E3=81=9F=E3=82=81=E3=81=
=AB=E3=80=81=E8=87=AA=E5=8B=95=E7=9A=84=E3=81=AB=E5=86=8D=E3=82=B9=E3=82=
=AD=E3=83=A3=E3=83=B3=E3=82=92=E9=96=8B=E5=A7=8B=E3=81=97=E3=81=BE=E3=81=
=99=E3=80=82"
=20
 #: lib/diff.tcl:81
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Loading diff of %s..."
-msgstr "%s =E3=82=92=E3=83=AD=E3=83=BC=E3=83=89=E4=B8=AD=E2=80=A6"
+msgstr "%s =E3=81=AE=E5=A4=89=E6=9B=B4=E7=82=B9=E3=82=92=E3=83=AD=E3=83=
=BC=E3=83=89=E4=B8=AD=E2=80=A6"
=20
 #: lib/diff.tcl:114 lib/diff.tcl:184
 #, tcl-format
 msgid "Unable to display %s"
-msgstr ""
+msgstr "%s =E3=82=92=E8=A1=A8=E7=A4=BA=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=
=9B=E3=82=93"
=20
 #: lib/diff.tcl:115
 msgid "Error loading file:"
@@ -1398,11 +1396,11 @@ msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=
=82=92=E8=AA=AD=E3=82=80=E9=9A=9B=E3=81=AE=E3=82=A8=E3=83=A9=E3=83=BC=E3=
=81=A7=E3=81=99:"
=20
 #: lib/diff.tcl:122
 msgid "Git Repository (subproject)"
-msgstr ""
+msgstr "Git =E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA(=E3=82=B5=E3=
=83=96=E3=83=97=E3=83=AD=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88)"
=20
 #: lib/diff.tcl:134
 msgid "* Binary file (not showing content)."
-msgstr ""
+msgstr "* =E3=83=90=E3=82=A4=E3=83=8A=E3=83=AA=E3=83=95=E3=82=A1=E3=82=
=A4=E3=83=AB(=E5=86=85=E5=AE=B9=E3=81=AF=E8=A1=A8=E7=A4=BA=E3=81=97=E3=81=
=BE=E3=81=9B=E3=82=93)"
=20
 #: lib/diff.tcl:185
 msgid "Error loading diff:"
@@ -1429,14 +1427,14 @@ msgid "You must correct the above errors before=
 committing."
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=99=E3=82=8B=E5=89=8D=
=E3=81=AB=E3=80=81=E4=BB=A5=E4=B8=8A=E3=81=AE=E3=82=A8=E3=83=A9=E3=83=BC=
=E3=82=92=E4=BF=AE=E6=AD=A3=E3=81=97=E3=81=A6=E4=B8=8B=E3=81=95=E3=81=84=
"
=20
 #: lib/index.tcl:241
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Unstaging %s from commit"
-msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=8B=E3=82=89=E9=99=8D=
=E3=82=8D=E3=81=99"
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=8B=E3=82=89 '%s' =E3=
=82=92=E9=99=8D=E3=82=8D=E3=81=99"
=20
 #: lib/index.tcl:285
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Adding %s"
-msgstr "%s =E3=82=92=E8=AA=AD=E3=82=93=E3=81=A7=E3=81=84=E3=81=BE=E3=81=
=99=E2=80=A6"
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AB %s =E3=82=92=E5=8A=
=A0=E3=81=88=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
 #: lib/index.tcl:340
 #, tcl-format
@@ -1651,41 +1649,37 @@ msgid "New Branch Name Template"
 msgstr "=E6=96=B0=E3=81=97=E3=81=84=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E5=90=8D=E3=81=AE=E3=83=86=E3=83=B3=E3=83=97=E3=83=AC=E3=83=BC=E3=83=88=
"
=20
 #: lib/option.tcl:176
-#, fuzzy
 msgid "Change Font"
-msgstr "=E4=B8=BB=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88"
+msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=A4=89=E6=9B=B4=
"
=20
 #: lib/option.tcl:180
 #, tcl-format
 msgid "Choose %s"
-msgstr ""
+msgstr "%s =E3=82=92=E9=81=B8=E6=8A=9E"
=20
 #: lib/option.tcl:186
 msgid "pt."
-msgstr ""
+msgstr "=E3=83=9D=E3=82=A4=E3=83=B3=E3=83=88"
=20
 #: lib/option.tcl:200
 msgid "Preferences"
-msgstr ""
+msgstr "=E8=A8=AD=E5=AE=9A"
=20
 #: lib/option.tcl:235
 msgid "Failed to completely save options:"
 msgstr "=E5=AE=8C=E5=85=A8=E3=81=AB=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=
=E3=83=B3=E3=82=92=E4=BF=9D=E5=AD=98=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=
=E3=82=93:"
=20
 #: lib/remote.tcl:165
-#, fuzzy
 msgid "Prune from"
-msgstr "%s =E3=81=8B=E3=82=89=E5=88=88=E3=82=8B=E2=80=A6"
+msgstr "=E3=81=8B=E3=82=89=E5=88=88=E8=BE=BC=E3=82=80=E2=80=A6"
=20
 #: lib/remote.tcl:170
-#, fuzzy
 msgid "Fetch from"
-msgstr "%s =E3=81=8B=E3=82=89=E3=83=95=E3=82=A7=E3=83=83=E3=83=81=E2=80=
=A6"
+msgstr "=E5=8F=96=E5=BE=97=E5=85=83"
=20
 #: lib/remote.tcl:213
-#, fuzzy
 msgid "Push to"
-msgstr "=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5"
+msgstr "=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5=E5=85=88"
=20
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Remote Branch"
@@ -1724,12 +1718,15 @@ msgid "A branch is required for 'Merged Into'."
 msgstr "'=E3=83=9E=E3=83=BC=E3=82=B8=E5=85=88' =E3=81=AB=E3=81=AF=E3=83=
=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=8C=E5=BF=85=E8=A6=81=E3=81=A7=E3=81=
=99=E3=80=82"
=20
 #: lib/remote_branch_delete.tcl:184
-#, fuzzy, tcl-format
+#, tcl-format
 msgid ""
 "The following branches are not completely merged into %s:\n"
 "\n"
 " - %s"
-msgstr "=E4=BB=A5=E4=B8=8B=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AF %s =E3=81=AB=E5=AE=8C=E5=85=A8=E3=81=AB=E3=83=9E=E3=83=BC=E3=82=
=B8=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=E3=82=93:"
+msgstr ""
+"=E4=BB=A5=E4=B8=8B=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=
=AF %s =E3=81=AB=E5=AE=8C=E5=85=A8=E3=81=AB=E3=83=9E=E3=83=BC=E3=82=B8=E3=
=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=E3=82=93:\n"
+"\n"
+" - %s"
=20
 #: lib/remote_branch_delete.tcl:189
 #, tcl-format
@@ -1782,9 +1779,9 @@ msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%1$s ... %3$*i %4$s =E4=B8=AD=E3=81=AE %$2*i (%5$3i%%)"
=20
 #: lib/transport.tcl:6
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "fetch %s"
-msgstr "=E3=83=95=E3=82=A7=E3=83=83=E3=83=81"
+msgstr "%s =E3=82=92=E5=8F=96=E5=BE=97"
=20
 #: lib/transport.tcl:7
 #, tcl-format
@@ -1794,7 +1791,7 @@ msgstr "%s =E3=81=8B=E3=82=89=E6=96=B0=E3=81=97=E3=
=81=84=E5=A4=89=E6=9B=B4=E3=82=92=E3=83=95=E3=82=A7=E3=83=83=E3=83=81=E3=
=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
 #: lib/transport.tcl:18
 #, tcl-format
 msgid "remote prune %s"
-msgstr ""
+msgstr "=E9=81=A0=E9=9A=94=E5=88=88=E8=BE=BC %s"
=20
 #: lib/transport.tcl:19
 #, tcl-format
@@ -1804,7 +1801,7 @@ msgstr "%s =E3=81=8B=E3=82=89=E5=89=8A=E9=99=A4=E3=
=81=95=E3=82=8C=E3=81=9F=E3=83=88=E3=83=A9=E3=83=83=E3=82=AD=E3=83=B3=E3=
=82=B0=E3=83=BB=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=82=92=E5=88=88=E3=
=81=A3=E3=81=A6=E3=81=84
 #: lib/transport.tcl:25 lib/transport.tcl:71
 #, tcl-format
 msgid "push %s"
-msgstr ""
+msgstr "%s =E3=82=92=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5"
=20
 #: lib/transport.tcl:26
 #, tcl-format
@@ -1834,7 +1831,7 @@ msgstr "=E9=80=9A=E4=BF=A1=E3=82=AA=E3=83=97=E3=82=
=B7=E3=83=A7=E3=83=B3"
=20
 #: lib/transport.tcl:160
 msgid "Force overwrite existing branch (may discard changes)"
-msgstr ""
+msgstr "=E6=97=A2=E5=AD=98=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=82=92=
=E4=B8=8A=E6=9B=B8=E3=81=8D(=E5=A4=89=E6=9B=B4=E3=82=92=E7=A0=B4=E6=A3=84=
=E3=81=99=E3=82=8B=E5=8F=AF=E8=83=BD=E6=80=A7=E3=81=8C=E3=81=82=E3=82=8A=
=E3=81=BE=E3=81=99)"
=20
 #: lib/transport.tcl:164
 msgid "Use thin pack (for slow network connections)"
@@ -1844,11 +1841,3 @@ msgstr "Thin Pack =E3=82=92=E4=BD=BF=E3=81=86=EF=
=BC=88=E9=81=85=E3=81=84=E3=83=8D=E3=83=83=E3=83=88=E3=83=AF=E3=83=BC=E3=
=82=AF=E6=8E=A5=E7=B6=9A=EF=BC=89"
 msgid "Include tags"
 msgstr "=E3=82=BF=E3=82=B0=E3=82=92=E5=90=AB=E3=82=81=E3=82=8B"
=20
-#~ msgid "Cannot find the git directory:"
-#~ msgstr "git =E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA=E3=
=81=8C=E8=A6=8B=E3=81=A4=E3=81=8B=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93:"
-
-#~ msgid "Unstaged Changes (Will Not Be Committed)"
-#~ msgstr "=E3=82=B9=E3=83=86=E3=83=BC=E3=82=B8=E3=83=B3=E3=82=B0=E3=81=
=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=EF=BC=88=E3=82=B3=E3=83=
=9F=E3=83=83=E3=83=88=E6=9C=AA=E4=BA=88=E5=AE=9A=E3=81=AE=EF=BC=89=E5=A4=
=89=E6=9B=B4"
-
-#~ msgid "Push to %s..."
-#~ msgstr "%s =E3=81=B8=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5=E2=80=A6"


--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
=46ree pop3 email with a spam filter.
http://www.bluebottle.com/tag/5
