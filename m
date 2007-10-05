From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 1/4] git-gui i18n: Add more words to glossary.
Date: Fri, 5 Oct 2007 22:39:01 +0200
Message-ID: <200710052239.02492.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 22:16:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idtaq-000122-Jb
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 22:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759471AbXJEUQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 16:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759415AbXJEUQG
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 16:16:06 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:35466 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759353AbXJEUQF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 16:16:05 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l95KFud4019816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 5 Oct 2007 22:15:57 +0200
Received: from [192.168.2.102] (p54900D20.dip0.t-ipconnect.de [84.144.13.32])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l95KFtoB021018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 22:15:56 +0200
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60125>

Signed-off-by: Christian Stimming <stimming@tuhh.de>

---
 po/glossary/git-gui-glossary.pot |   12 ++++++++++--
 po/glossary/git-gui-glossary.txt |    2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/po/glossary/git-gui-glossary.pot b/po/glossary/git-gui-glossary.pot
index c955b46..a2e5c73 100644
--- a/po/glossary/git-gui-glossary.pot
+++ b/po/glossary/git-gui-glossary.pot
@@ -6,12 +6,12 @@
 msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
-"POT-Creation-Date: 2007-07-27 19:21+0200\n"
+"POT-Creation-Date: 2007-10-05 22:30+0200\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
 "MIME-Version: 1.0\n"
-"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Type: text/plain; charset=CHARSET\n"
 "Content-Transfer-Encoding: ENCODING\n"
 
 #. "English Definition (Dear translator: This file will never be visible to the user! It should only serve as a tool for you, the translator. Nothing more.)"
@@ -42,6 +42,10 @@ msgstr ""
 msgid "checkout [verb]"
 msgstr ""
 
+#. ""
+msgid "clone [verb]"
+msgstr ""
+
 #. "A single point in the git history."
 msgid "commit [noun]"
 msgstr ""
@@ -82,6 +86,10 @@ msgstr ""
 msgid "message"
 msgstr ""
 
+#. ""
+msgid "prune"
+msgstr ""
+
 #. "Pulling a branch means to fetch it and merge it."
 msgid "pull"
 msgstr ""
diff --git a/po/glossary/git-gui-glossary.txt b/po/glossary/git-gui-glossary.txt
index bb55aa8..b53740d 100644
--- a/po/glossary/git-gui-glossary.txt
+++ b/po/glossary/git-gui-glossary.txt
@@ -5,6 +5,7 @@
 "branch [verb]"	""
 "checkout [noun]"	""
 "checkout [verb]"	"The action of updating the working tree to a revision which was stored in the object database."
+"clone [verb]"	""
 "commit [noun]"	"A single point in the git history."
 "commit [verb]"	"The action of storing a new snapshot of the project's state in the git history."
 "diff [noun]"	""
@@ -15,6 +16,7 @@
 "merge [noun]"	"A successful merge results in the creation of a new commit representing the result of the merge."
 "merge [verb]"	"To bring the contents of another branch into the current branch."
 "message"	""
+"prune"	""
 "pull"	"Pulling a branch means to fetch it and merge it."
 "push"	"Pushing a branch means to get the branch's head ref from a remote repository, and ... (well, can someone please explain it for mere mortals?)"
 "redo"	""
-- 
1.5.3.rc2.6.g40240
