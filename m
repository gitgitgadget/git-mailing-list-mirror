From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 07/15] Add glossary translation template into git.
Date: Sun, 2 Sep 2007 17:32:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021732380.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:33:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsOC-0005D6-CF
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932930AbXIBQd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbXIBQd2
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:33:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:40044 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932773AbXIBQd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:33:27 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:33:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 02 Sep 2007 18:33:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SwYJPeBOSOc/ErDNDwQmGnSIfzxObiwGt36dakt
	xkNThAI8Bua76S
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57354>


From: Christian Stimming <stimming@tuhh.de>

This way, it should be easier for new translators to actually find out
about the glossary.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/glossary/git-gui-glossary.pot |  152 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 152 insertions(+), 0 deletions(-)
 create mode 100644 po/glossary/git-gui-glossary.pot

diff --git a/po/glossary/git-gui-glossary.pot b/po/glossary/git-gui-glossary.pot
new file mode 100644
index 0000000..c955b46
--- /dev/null
+++ b/po/glossary/git-gui-glossary.pot
@@ -0,0 +1,152 @@
+# SOME DESCRIPTIVE TITLE.
+# Copyright (C) YEAR Free Software Foundation, Inc.
+# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: PACKAGE VERSION\n"
+"POT-Creation-Date: 2007-07-27 19:21+0200\n"
+"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
+"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
+"Language-Team: LANGUAGE <LL@li.org>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: ENCODING\n"
+
+#. "English Definition (Dear translator: This file will never be visible to the user! It should only serve as a tool for you, the translator. Nothing more.)"
+msgid "English Term (Dear translator: This file will never be visible to the user!)"
+msgstr ""
+
+#. ""
+msgid "amend"
+msgstr ""
+
+#. ""
+msgid "annotate"
+msgstr ""
+
+#. "A 'branch' is an active line of development."
+msgid "branch [noun]"
+msgstr ""
+
+#. ""
+msgid "branch [verb]"
+msgstr ""
+
+#. ""
+msgid "checkout [noun]"
+msgstr ""
+
+#. "The action of updating the working tree to a revision which was stored in the object database."
+msgid "checkout [verb]"
+msgstr ""
+
+#. "A single point in the git history."
+msgid "commit [noun]"
+msgstr ""
+
+#. "The action of storing a new snapshot of the project's state in the git history."
+msgid "commit [verb]"
+msgstr ""
+
+#. ""
+msgid "diff [noun]"
+msgstr ""
+
+#. ""
+msgid "diff [verb]"
+msgstr ""
+
+#. "A fast-forward is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
+msgid "fast forward merge"
+msgstr ""
+
+#. "Fetching a branch means to get the branch's head from a remote repository, to find out which objects are missing from the local object database, and to get them, too."
+msgid "fetch"
+msgstr ""
+
+#. "A collection of files. The index is a stored version of your working tree."
+msgid "index (in git-gui: staging area)"
+msgstr ""
+
+#. "A successful merge results in the creation of a new commit representing the result of the merge."
+msgid "merge [noun]"
+msgstr ""
+
+#. "To bring the contents of another branch into the current branch."
+msgid "merge [verb]"
+msgstr ""
+
+#. ""
+msgid "message"
+msgstr ""
+
+#. "Pulling a branch means to fetch it and merge it."
+msgid "pull"
+msgstr ""
+
+#. "Pushing a branch means to get the branch's head ref from a remote repository, and ... (well, can someone please explain it for mere mortals?)"
+msgid "push"
+msgstr ""
+
+#. ""
+msgid "redo"
+msgstr ""
+
+#. "A collection of refs (?) together with an object database containing all objects which are reachable from the refs... (oops, you've lost me here. Again, please an explanation for mere mortals?)"
+msgid "repository"
+msgstr ""
+
+#. ""
+msgid "reset"
+msgstr ""
+
+#. ""
+msgid "revert"
+msgstr ""
+
+#. "A particular state of files and directories which was stored in the object database."
+msgid "revision"
+msgstr ""
+
+#. ""
+msgid "sign off"
+msgstr ""
+
+#. ""
+msgid "staging area"
+msgstr ""
+
+#. ""
+msgid "status"
+msgstr ""
+
+#. "A ref pointing to a tag or commit object"
+msgid "tag [noun]"
+msgstr ""
+
+#. ""
+msgid "tag [verb]"
+msgstr ""
+
+#. "A regular git branch that is used to follow changes from another repository."
+msgid "tracking branch"
+msgstr ""
+
+#. ""
+msgid "undo"
+msgstr ""
+
+#. ""
+msgid "update"
+msgstr ""
+
+#. ""
+msgid "verify"
+msgstr ""
+
+#. "The tree of actual checked out files."
+msgid "working copy, working tree"
+msgstr ""
+
-- 
1.5.3.2.g46909
