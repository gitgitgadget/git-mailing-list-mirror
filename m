From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: [PATCH] Update Japanese translation
Date: Fri, 14 Mar 2008 22:03:21 +0900
Message-ID: <200803141303.m2ED3nUj016918@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Mar 14 14:05:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja9aH-0006tl-Rd
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 14:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbYCNNDv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 09:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbYCNNDv
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 09:03:51 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:41548 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYCNNDu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 09:03:50 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m2ED3nUj016918
	for <git@vger.kernel.org>; Fri, 14 Mar 2008 06:03:49 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=CRDNM+3kgUvsC593VuueYvwTwAk4phGpXvUUZYgnnYZU9KShJUlr53gA3TJMzUw51
	kXfU1r6yEiKEDQNhnWjzQy+zCvOzKvfXPnCkdaZ9p181UcxwQ1QRkHawLO24Zlf
Received: from nanako3.mail.bluebottle.com ([212.62.97.23])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m2ED3f54019895
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Mar 2008 06:03:46 -0700
X-Trusted-Delivery: <b44447df923e369c11698f2bec9a30c6>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77218>

I updated Japanese translation for the latest git-gui.

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@bluebottle.com>
---
 po/ja.po |  126 ++++++++++++++++++++++++++++++++++++++++++++++--------=
--------
 1 files changed, 94 insertions(+), 32 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index e2cf5bd..189b726 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -8,8 +8,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2007-11-24 10:36+0100\n"
-"PO-Revision-Date: 2007-12-05 06:12+0900\n"
+"POT-Creation-Date: 2008-02-16 21:24+0100\n"
+"PO-Revision-Date: 2008-03-14 20:32+0900\n"
 "Last-Translator: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=
=AA=E3=81=93 <nanako3@bluebottle.com>\n"
 "Language-Team: Japanese\n"
 "MIME-Version: 1.0\n"
@@ -398,31 +398,31 @@ msgstr "=E5=85=A8=E3=81=A6=E3=82=B3=E3=83=94=E3=83=
=BC"
 msgid "File:"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB:"
=20
-#: git-gui.sh:2545
-msgid "Refresh"
-msgstr "=E5=86=8D=E8=AA=AD=E3=81=BF=E8=BE=BC=E3=81=BF"
-
-#: git-gui.sh:2566
+#: git-gui.sh:2573
 msgid "Apply/Reverse Hunk"
 msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E9=81=A9=E7=94=A8/=E5=8F=96=
=E3=82=8A=E6=B6=88=E3=81=99"
=20
-#: git-gui.sh:2572
-msgid "Decrease Font Size"
-msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=B0=8F=E3=81=95=
=E3=81=8F"
-
-#: git-gui.sh:2576
-msgid "Increase Font Size"
-msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=A4=A7=E3=81=8D=
=E3=81=8F"
-
-#: git-gui.sh:2581
+#: git-gui.sh:2579
 msgid "Show Less Context"
 msgstr "=E6=96=87=E8=84=88=E3=82=92=E5=B0=91=E3=81=AA=E3=81=8F"
=20
-#: git-gui.sh:2588
+#: git-gui.sh:2586
 msgid "Show More Context"
 msgstr "=E6=96=87=E8=84=88=E3=82=92=E5=A4=9A=E3=81=8F"
=20
-#: git-gui.sh:2602
+#: git-gui.sh:2594
+msgid "Refresh"
+msgstr "=E5=86=8D=E8=AA=AD=E3=81=BF=E8=BE=BC=E3=81=BF"
+
+#: git-gui.sh:2615
+msgid "Decrease Font Size"
+msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=B0=8F=E3=81=95=
=E3=81=8F"
+
+#: git-gui.sh:2619
+msgid "Increase Font Size"
+msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=A4=A7=E3=81=8D=
=E3=81=8F"
+
+#: git-gui.sh:2630
 msgid "Unstage Hunk From Commit"
 msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=8B=E3=82=89=E5=A4=96=E3=81=99"
=20
@@ -804,6 +804,10 @@ msgstr ""
 msgid "Updating working directory to '%s'..."
 msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=82=92 '%s' =E3=81=AB=E6=9B=B4=E6=96=B0=E3=81=97=E3=81=A6=E3=
=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
+#: lib/checkout_op.tcl:323
+msgid "files checked out"
+msgstr "=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=E3=82=A6=E3=83=88=
=E3=81=95=E3=82=8C=E3=81=9F=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB"
+
 #: lib/checkout_op.tcl:353
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
@@ -1262,11 +1266,40 @@ msgstr ""
 "- =E7=AC=AC=EF=BC=92=E8=A1=8C: =E7=A9=BA=E7=99=BD\n"
 "- =E6=AE=8B=E3=82=8A=E3=81=AE=E8=A1=8C: =E3=81=AA=E3=81=9C=E3=80=81=E3=
=81=93=E3=81=AE=E5=A4=89=E6=9B=B4=E3=81=8C=E8=89=AF=E3=81=84=E5=A4=89=E6=
=9B=B4=E3=81=8B=E3=80=81=E3=81=AE=E8=AA=AC=E6=98=8E=E3=80=82\n"
=20
-#: lib/commit.tcl:257
+#: lib/commit.tcl:207
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "=E8=AD=A6=E5=91=8A: Tcl =E3=81=AF=E3=82=A8=E3=83=B3=E3=82=B3=E3=
=83=BC=E3=83=87=E3=82=A3=E3=83=B3=E3=82=B0 '%s' =E3=82=92=E3=82=B5=E3=83=
=9D=E3=83=BC=E3=83=88=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=E3=82=
=93"
+
+#: lib/commit.tcl:221
+msgid "Calling pre-commit hook..."
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E5=89=8D=E3=83=95=E3=83=83=
=E3=82=AF=E3=82=92=E5=AE=9F=E8=A1=8C=E4=B8=AD=E3=83=BB=E3=83=BB=E3=83=BB=
"
+
+#: lib/commit.tcl:236
+msgid "Commit declined by pre-commit hook."
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E5=89=8D=E3=83=95=E3=83=83=
=E3=82=AF=E3=81=8C=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=E6=8B=92=
=E5=90=A6=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F"
+
+#: lib/commit.tcl:259
+msgid "Calling commit-msg hook..."
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=BB=E3=83=A1=E3=83=83=
=E3=82=BB=E3=83=BC=E3=82=B8=E3=83=BB=E3=83=95=E3=83=83=E3=82=AF=E3=82=92=
=E5=AE=9F=E8=A1=8C=E4=B8=AD=E3=83=BB=E3=83=BB=E3=83=BB"
+
+#: lib/commit.tcl:274
+msgid "Commit declined by commit-msg hook."
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=BB=E3=83=A1=E3=83=83=
=E3=82=BB=E3=83=BC=E3=82=B8=E3=83=BB=E3=83=95=E3=83=83=E3=82=AF=E3=81=8C=
=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=E6=8B=92=E5=90=A6=E3=81=97=
=E3=81=BE=E3=81=97=E3=81=9F"
+
+#: lib/commit.tcl:287
+msgid "Committing changes..."
+msgstr "=E5=A4=89=E6=9B=B4=E7=82=B9=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E4=B8=AD=E3=83=BB=E3=83=BB=E3=83=BB"
+
+#: lib/commit.tcl:303
 msgid "write-tree failed:"
 msgstr "write-tree =E3=81=8C=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=
=97=E3=81=9F:"
=20
-#: lib/commit.tcl:275
+#: lib/commit.tcl:304 lib/commit.tcl:348 lib/commit.tcl:368
+msgid "Commit failed."
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AB=E5=A4=B1=E6=95=97=
=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F=E3=80=82"
+
+#: lib/commit.tcl:321
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88 %s =E3=81=AF=E5=A3=8A=E3=82=
=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
@@ -1289,12 +1322,7 @@ msgstr ""
 msgid "No changes to commit."
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=99=E3=82=8B=E5=A4=89=
=E6=9B=B4=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=
"
=20
-#: lib/commit.tcl:303
-#, tcl-format
-msgid "warning: Tcl does not support encoding '%s'."
-msgstr "=E8=AD=A6=E5=91=8A: Tcl =E3=81=AF=E3=82=A8=E3=83=B3=E3=82=B3=E3=
=83=BC=E3=83=87=E3=82=A3=E3=83=B3=E3=82=B0 '%s' =E3=82=92=E3=82=B5=E3=83=
=9D=E3=83=BC=E3=83=88=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=E3=82=
=93"
-
-#: lib/commit.tcl:317
+#: lib/commit.tcl:347
 msgid "commit-tree failed:"
 msgstr "commit-tree =E3=81=8C=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=
=97=E3=81=9F:"
=20
@@ -1457,7 +1485,9 @@ msgstr "=E7=B4=A2=E5=BC=95=E3=82=A8=E3=83=A9=E3=83=
=BC"
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically starte=
d to "
 "resynchronize git-gui."
-msgstr "GIT =E3=82=A4=E3=83=B3=E3=83=87=E3=83=83=E3=82=AF=E3=82=B9=E3=81=
=AE=E6=9B=B4=E6=96=B0=E3=81=8C=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=
=97=E3=81=9F=E3=80=82git-gui =E3=81=A8=E5=90=8C=E6=9C=9F=E3=82=92=E3=81=
=A8=E3=82=8B=E3=81=9F=E3=82=81=E3=81=AB=E5=86=8D=E3=82=B9=E3=82=AD=E3=83=
=A3=E3=83=B3=E3=81=97=E3=81=BE=E3=81=99=E3=80=82"
+msgstr ""
+"GIT =E3=82=A4=E3=83=B3=E3=83=87=E3=83=83=E3=82=AF=E3=82=B9=E3=81=AE=E6=
=9B=B4=E6=96=B0=E3=81=8C=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=97=E3=
=81=9F=E3=80=82git-gui =E3=81=A8=E5=90=8C=E6=9C=9F=E3=82=92=E3=81=A8=E3=
=82=8B=E3=81=9F=E3=82=81=E3=81=AB=E5=86=8D=E3=82=B9=E3=82=AD=E3=83=A3=E3=
=83=B3=E3=81=97"
+"=E3=81=BE=E3=81=99=E3=80=82"
=20
 #: lib/index.tcl:27
 msgid "Continue"
@@ -1472,6 +1502,10 @@ msgstr "=E3=82=A4=E3=83=B3=E3=83=87=E3=83=83=E3=82=
=AF=E3=82=B9=E3=81=AE=E3=83=AD=E3=83=83=E3=82=AF=E8=A7=A3=E9=99=A4"
 msgid "Unstaging %s from commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=8B=E3=82=89 '%s' =E3=
=82=92=E9=99=8D=E3=82=8D=E3=81=99"
=20
+#: lib/index.tcl:313
+msgid "Ready to commit."
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E6=BA=96=E5=82=99=E5=AE=8C=
=E4=BA=86"
+
 #: lib/index.tcl:326
 #, tcl-format
 msgid "Adding %s"
@@ -1562,10 +1596,10 @@ msgstr "%s =E3=81=AE %s =E3=83=96=E3=83=A9=E3=83=
=B3=E3=83=81"
=20
 #: lib/merge.tcl:119
 #, tcl-format
-msgid "Merging %s and %s"
-msgstr "%s =E3=81=A8 %s =E3=82=92=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=97=E3=
=81=BE=E3=81=99"
+msgid "Merging %s and %s..."
+msgstr "%s =E3=81=A8 %s =E3=82=92=E3=83=9E=E3=83=BC=E3=82=B8=E4=B8=AD=E3=
=83=BB=E3=83=BB=E3=83=BB"
=20
-#: lib/merge.tcl:131
+#: lib/merge.tcl:130
 msgid "Merge completed successfully."
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=8C=E5=AE=8C=E4=BA=86=E3=81=97=
=E3=81=BE=E3=81=97=E3=81=9F"
=20
@@ -1624,7 +1658,11 @@ msgstr ""
 msgid "Aborting"
 msgstr "=E4=B8=AD=E6=96=AD=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=
"
=20
-#: lib/merge.tcl:266
+#: lib/merge.tcl:238
+msgid "files reset"
+msgstr "=E3=83=AA=E3=82=BB=E3=83=83=E3=83=88=E3=81=97=E3=81=9F=E3=83=95=
=E3=82=A1=E3=82=A4=E3=83=AB"
+
+#: lib/merge.tcl:265
 msgid "Abort failed."
 msgstr "=E4=B8=AD=E6=96=AD=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=
=E3=81=97=E3=81=9F=E3=80=82"
=20
@@ -1689,7 +1727,11 @@ msgstr "diff =E3=81=AE=E6=96=87=E8=84=88=E8=A1=8C=
=E6=95=B0"
 msgid "New Branch Name Template"
 msgstr "=E6=96=B0=E3=81=97=E3=81=84=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E5=90=8D=E3=81=AE=E3=83=86=E3=83=B3=E3=83=97=E3=83=AC=E3=83=BC=E3=83=88=
"
=20
-#: lib/option.tcl:176
+#: lib/option.tcl:191
+msgid "Spelling Dictionary:"
+msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=
=E8=BE=9E=E6=9B=B8"
+
+#: lib/option.tcl:215
 msgid "Change Font"
 msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=A4=89=E6=9B=B4=
"
=20
@@ -1814,6 +1856,26 @@ msgstr "=E3=82=B7=E3=83=A7=E3=83=BC=E3=83=88=E3=82=
=AB=E3=83=83=E3=83=88=E3=81=8C=E6=9B=B8=E3=81=91=E3=81=BE=E3=81=9B=E3=82=
=93:"
 msgid "Cannot write icon:"
 msgstr "=E3=82=A2=E3=82=A4=E3=82=B3=E3=83=B3=E3=81=8C=E6=9B=B8=E3=81=91=
=E3=81=BE=E3=81=9B=E3=82=93:"
=20
+#: lib/spellcheck.tcl:37
+msgid "Not connected to aspell"
+msgstr "aspell =E3=81=AB=E6=8E=A5=E7=B6=9A=E3=81=97=E3=81=A6=E3=81=84=E3=
=81=BE=E3=81=9B=E3=82=93"
+
+#: lib/spellcheck.tcl:41
+msgid "Unrecognized aspell version"
+msgstr "aspell =E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3=E3=81=8C=E5=
=88=A4=E5=88=A5=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93"
+
+#: lib/spellcheck.tcl:135
+msgid "No Suggestions"
+msgstr "=E6=8F=90=E6=A1=88=E3=81=AA=E3=81=97"
+
+#: lib/spellcheck.tcl:336
+msgid "Unexpected EOF from aspell"
+msgstr "aspell =E3=81=8C=E4=BA=88=E6=83=B3=E5=A4=96=E3=81=AE EOF =E3=82=
=92=E8=BF=94=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F"
+
+#: lib/spellcheck.tcl:340
+msgid "Spell Checker Failed"
+msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=
=E5=A4=B1=E6=95=97"
+
 #: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
--=20
1.5.4.3

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
=46ree pop3 email with a spam filter.
http://www.bluebottle.com/tag/5
