From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] git-gui: update russian translation
Date: Fri, 14 Mar 2008 23:25:57 +0100
Message-ID: <20080314222557.GC5914@steel.home>
References: <200803141303.m2ED3nUj016918@mi1.bluebottle.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Mar 14 23:26:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaIMQ-0003tC-4K
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 23:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbYCNW0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 18:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754366AbYCNW0F
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 18:26:05 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:56539 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbYCNW0E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 18:26:04 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolN9Q==
Received: from tigra.home (Faa12.f.strato-dslnet.de [195.4.170.18])
	by post.webmailer.de (klopstock mo50) (RZmta 16.10)
	with ESMTP id z011fek2ELZG8r ; Fri, 14 Mar 2008 23:26:00 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 98F2C277BD;
	Sat, 15 Mar 2008 07:25:32 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 7E11256D28; Fri, 14 Mar 2008 23:25:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200803141303.m2ED3nUj016918@mi1.bluebottle.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77294>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 po/ru.po |   48 +++++++++++++++++++++---------------------------
 1 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index 849dc5c..db55b3e 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -806,7 +806,7 @@ msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=B8=D0=B5 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=
=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B0 =D0=B8=D0=B7 '%s'..."
=20
 #: lib/checkout_op.tcl:323
 msgid "files checked out"
-msgstr ""
+msgstr "=D1=84=D0=B0=D0=B9=D0=BB=D1=8B =D0=B8=D0=B7=D0=B2=D0=BB=D0=B5=D1=
=87=D0=B5=D0=BD=D1=8B"
=20
 #: lib/checkout_op.tcl:353
 #, tcl-format
@@ -1250,7 +1250,6 @@ msgstr ""
 "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D1=8C=D1=82=D0=B5 =D1=
=85=D0=BE=D1=82=D1=8F =D0=B1=D1=8B =D0=BE=D0=B4=D0=B8=D0=BD =D1=84=D0=B0=
=D0=B9=D0=BB =D0=B4=D0=BE =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D1=
=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=
=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F.\n"
=20
 #: lib/commit.tcl:183
-#, fuzzy
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1275,32 +1274,31 @@ msgstr "=D0=BF=D1=80=D0=B5=D0=B4=D1=83=D0=BF=D1=
=80=D0=B5=D0=B6=D0=B4=D0=B5=D0=BD=D0=B8=D0=B5: Tcl =D0=BD=D0=B5 =D0=BF=D0=
=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D1=82 =D0=BA=D0=
=BE=D0=B4=D0=B8
=20
 #: lib/commit.tcl:221
 msgid "Calling pre-commit hook..."
-msgstr ""
+msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D1=8B =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=
=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =
pre-commit..."
=20
 #: lib/commit.tcl:236
 msgid "Commit declined by pre-commit hook."
-msgstr ""
+msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=
=B6=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F pre-commit"
=20
 #: lib/commit.tcl:259
 msgid "Calling commit-msg hook..."
-msgstr ""
+msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D1=8B =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=
=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =
commit-msg..."
=20
 #: lib/commit.tcl:274
 msgid "Commit declined by commit-msg hook."
-msgstr ""
+msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=
=B6=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F commit-msg"
=20
 #: lib/commit.tcl:287
 msgid "Committing changes..."
-msgstr ""
+msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9..."
=20
 #: lib/commit.tcl:303
 msgid "write-tree failed:"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 write-t=
ree =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D0=BB=D0=B0=D1=81=D1=8C =
=D1=81 =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=BE=D0=B9:"
=20
 #: lib/commit.tcl:304 lib/commit.tcl:348 lib/commit.tcl:368
-#, fuzzy
 msgid "Commit failed."
-msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=B8=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C."
+msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D1=81=D0=
=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=
=D0=B0=D0=BB=D0=BE=D1=81=D1=8C."
=20
 #: lib/commit.tcl:321
 #, tcl-format
@@ -1506,7 +1504,6 @@ msgid "Unstaging %s from commit"
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 %s =D0=B8=D0=B7=
 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=B3=D0=BE"
=20
 #: lib/index.tcl:313
-#, fuzzy
 msgid "Ready to commit."
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8F"
=20
@@ -1602,9 +1599,8 @@ msgid "%s of %s"
 msgstr "%s =D0=B8=D0=B7 %s"
=20
 #: lib/merge.tcl:119
-#, fuzzy, tcl-format
 msgid "Merging %s and %s..."
-msgstr "=D0=9E=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=
=B5 %s =D0=B8 %s"
+msgstr "=D0=9E=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=
=B5 %s =D0=B8 %s..."
=20
 #: lib/merge.tcl:130
 msgid "Merge completed successfully."
@@ -1666,9 +1662,8 @@ msgid "Aborting"
 msgstr "=D0=9F=D1=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D1=8E"
=20
 #: lib/merge.tcl:238
-#, fuzzy
 msgid "files reset"
-msgstr "=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2"
+msgstr "=D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =
=D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D1=85 =D0=BE=D1=82=D0=BC=D0=B5=D0=BD=D0=B5=
=D0=BD=D1=8B"
=20
 #: lib/merge.tcl:265
 msgid "Abort failed."
@@ -1701,7 +1696,7 @@ msgstr "=D0=98=D0=BC=D1=8F =D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8F"
=20
 #: lib/option.tcl:117
 msgid "Email Address"
-msgstr "=D0=90=D0=B4=D0=B5=D1=81 =D1=8D=D0=BB=D0=B5=D0=BA=D1=82=D1=80=D0=
=BE=D0=BD=D0=BD=D0=BE=D0=B9 =D0=BF=D0=BE=D1=87=D1=82=D1=8B"
+msgstr "=D0=90=D0=B4=D1=80=D0=B5=D1=81 =D1=8D=D0=BB=D0=B5=D0=BA=D1=82=D1=
=80=D0=BE=D0=BD=D0=BD=D0=BE=D0=B9 =D0=BF=D0=BE=D1=87=D1=82=D1=8B"
=20
 #: lib/option.tcl:119
 msgid "Summarize Merge Commits"
@@ -1732,9 +1727,8 @@ msgid "Number of Diff Context Lines"
 msgstr "=D0=A7=D0=B8=D1=81=D0=BB=D0=BE =D1=81=D1=82=D1=80=D0=BE=D0=BA =
=D0=B2 =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82=D0=B5 diff"
=20
 #: lib/option.tcl:127
-#, fuzzy
 msgid "Commit Message Text Width"
-msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E:"
+msgstr "=D0=A8=D0=B8=D1=80=D0=B8=D0=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=BC=D0=
=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D1=8F =D0=BA =D1=81=D0=BE=D1=81=D1=82=
=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E:"
=20
 #: lib/option.tcl:128
 msgid "New Branch Name Template"
@@ -1742,7 +1736,7 @@ msgstr "=D0=A8=D0=B0=D0=B1=D0=BB=D0=BE=D0=BD =D0=B4=
=D0=BB=D1=8F =D0=B8=D0=BC=D0=B5=D0=BD=D0=B8 =D0=BD=D0=BE=D0=B2=D0=BE=D0=
=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
=20
 #: lib/option.tcl:192
 msgid "Spelling Dictionary:"
-msgstr ""
+msgstr "=D0=A1=D0=BB=D0=BE=D0=B2=D0=B0=D1=80=D1=8C =D0=B4=D0=BB=D1=8F =
=D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=
=D0=BE=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F:"
=20
 #: lib/option.tcl:216
 msgid "Change Font"
@@ -1871,40 +1865,40 @@ msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=
=BE=D0=B6=D0=BD=D0=BE =D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =
=D0=B7=D0=BD=D0=B0=D1=87=D0=BE=D0=BA:"
=20
 #: lib/spellcheck.tcl:57
 msgid "Unsupported spell checker"
-msgstr ""
+msgstr "=D0=9D=D0=B5=D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=
=B2=D0=B0=D0=B5=D0=BC=D0=B0=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=
=BC=D0=BC=D0=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=
=D1=80=D0=B0=D0=B2=D0=BE=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F"
=20
 #: lib/spellcheck.tcl:65
 msgid "Spell checking is unavailable"
-msgstr ""
+msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=BF=D1=80=D0=
=B0=D0=B2=D0=BE=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =
=D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=BD=D0=B0"
=20
 #: lib/spellcheck.tcl:68
 msgid "Invalid spell checking configuration"
-msgstr ""
+msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D1=8C=D0=BD=D0=
=B0=D1=8F =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=
=B8=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=8B =D0=BF=
=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=
=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F"
=20
 #: lib/spellcheck.tcl:70
 #, tcl-format
 msgid "Reverting dictionary to %s."
-msgstr ""
+msgstr "=D0=A1=D0=BB=D0=BE=D0=B2=D0=B0=D1=80=D1=8C =D0=B2=D0=B5=D1=80=D0=
=BD=D1=83=D1=82 =D0=BA %s."
=20
 #: lib/spellcheck.tcl:73
 msgid "Spell checker silently failed on startup"
-msgstr ""
+msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=BF=D1=
=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BC=D0=BE=
=D0=B3=D0=BB=D0=B0 =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=81=
=D1=8F"
=20
 #: lib/spellcheck.tcl:80
 msgid "Unrecognized spell checker"
-msgstr ""
+msgstr "=D0=9D=D0=B5=D1=80=D0=B0=D1=81=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D0=
=BD=D0=B0=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =
=D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=
=D0=BE=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F"
=20
 #: lib/spellcheck.tcl:180
 msgid "No Suggestions"
-msgstr ""
+msgstr "=D0=98=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=
=B9 =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD=D0=BE"
=20
 #: lib/spellcheck.tcl:381
 msgid "Unexpected EOF from spell checker"
-msgstr ""
+msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=BF=D1=
=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=D0=B5=D1=80=D0=B2=D0=
=B0=D0=BB=D0=B0 =D0=BF=D0=B5=D1=80=D0=B5=D0=B4=D0=B0=D1=87=D1=83 =D0=B4=
=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
=20
 #: lib/spellcheck.tcl:385
 msgid "Spell Checker Failed"
-msgstr ""
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=
=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BD=D0=B8=D1=8F"
=20
 #: lib/status_bar.tcl:83
 #, tcl-format
--=20
1.5.4.4.578.g182d
