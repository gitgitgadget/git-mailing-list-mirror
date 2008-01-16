From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Git Gui: add french glossary: glossary/fr.po
Date: Wed, 16 Jan 2008 08:19:34 +0100
Message-ID: <20080116081934.d77f188f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio Hamano <junkio@cox.net>,
	Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 08:14:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF2Ta-0000Ll-9l
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 08:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759104AbYAPHNX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 02:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759101AbYAPHNX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 02:13:23 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:34551 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759100AbYAPHNW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 02:13:22 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id ACB921AB2B5;
	Wed, 16 Jan 2008 08:13:20 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 5A2171AB2C3;
	Wed, 16 Jan 2008 08:13:20 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70644>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 po/glossary/fr.po |  166 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 166 insertions(+), 0 deletions(-)
 create mode 100644 po/glossary/fr.po

	Here is another patch I pushed to the mob branch of git-gui-i18n.git.

	Thanks.

diff --git a/po/glossary/fr.po b/po/glossary/fr.po
new file mode 100644
index 0000000..27c006a
--- /dev/null
+++ b/po/glossary/fr.po
@@ -0,0 +1,166 @@
+# translation of fr.po to French
+# Translation of git-gui glossary to French
+# Copyright (C) 2008 Shawn Pearce, et al.
+#
+# Christian Couder <chriscool@tuxfamily.org>, 2008.
+msgid ""
+msgstr ""
+"Project-Id-Version: fr\n"
+"POT-Creation-Date: 2008-01-15 21:04+0100\n"
+"PO-Revision-Date: 2008-01-15 21:17+0100\n"
+"Last-Translator: Christian Couder <chriscool@tuxfamily.org>\n"
+"Language-Team: French\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"X-Generator: KBabel 1.11.4\n"
+"Plural-Forms:  nplurals=3D2; plural=3D(n > 1);\n"
+
+#. "English Definition (Dear translator: This file will never be visib=
le to the user! It should only serve as a tool for you, the translator.=
 Nothing more.)"
+msgid "English Term (Dear translator: This file will never be visible =
to the user!)"
+msgstr ""
+
+#. ""
+msgid "amend"
+msgstr "corriger"
+
+#. ""
+msgid "annotate"
+msgstr "annoter"
+
+#. "A 'branch' is an active line of development."
+msgid "branch [noun]"
+msgstr "branche"
+
+#. ""
+msgid "branch [verb]"
+msgstr "cr=E9er une branche"
+
+#. ""
+msgid "checkout [noun]"
+msgstr "emprunt"
+
+#. "The action of updating the working tree to a revision which was st=
ored in the object database."
+msgid "checkout [verb]"
+msgstr "emprunter"
+
+#. ""
+msgid "clone [verb]"
+msgstr "cloner"
+
+#. "A single point in the git history."
+msgid "commit [noun]"
+msgstr "commit"
+
+#. "The action of storing a new snapshot of the project's state in the=
 git history."
+msgid "commit [verb]"
+msgstr "commiter"
+
+#. ""
+msgid "diff [noun]"
+msgstr "diff=E9rence"
+
+#. ""
+msgid "diff [verb]"
+msgstr "comparer"
+
+#. "A fast-forward is a special type of merge where you have a revisio=
n and you are merging another branch's changes that happen to be a desc=
endant of what you have."
+msgid "fast forward merge"
+msgstr "fusion par avance rapide"
+
+#. "Fetching a branch means to get the branch's head from a remote rep=
ository, to find out which objects are missing from the local object da=
tabase, and to get them, too."
+msgid "fetch"
+msgstr "r=E9cup=E9rer"
+
+#. "A collection of files. The index is a stored version of your worki=
ng tree."
+msgid "index (in git-gui: staging area)"
+msgstr "pr=E9-commit"
+
+#. "A successful merge results in the creation of a new commit represe=
nting the result of the merge."
+msgid "merge [noun]"
+msgstr "fusion"
+
+#. "To bring the contents of another branch into the current branch."
+msgid "merge [verb]"
+msgstr "fusionner"
+
+#. ""
+msgid "message"
+msgstr "message"
+
+#. "Deletes all stale tracking branches under <name>. These stale bran=
ches have already been removed from the remote repository referenced by=
 <name>, but are still locally available in 'remotes/<name>'."
+msgid "prune"
+msgstr "nettoyer"
+
+#. "Pulling a branch means to fetch it and merge it."
+msgid "pull"
+msgstr "tirer"
+
+#. "Pushing a branch means to get the branch's head ref from a remote =
repository, and ... (well, can someone please explain it for mere morta=
ls?)"
+msgid "push"
+msgstr "pousser"
+
+#. ""
+msgid "redo"
+msgstr "refaire"
+
+#. "An other repository ('remote'). One might have a set of remotes wh=
ose branches one tracks."
+msgid "remote"
+msgstr "r=E9f=E9rentiel distant"
+
+#. "A collection of refs (?) together with an object database containi=
ng all objects which are reachable from the refs... (oops, you've lost =
me here. Again, please an explanation for mere mortals?)"
+msgid "repository"
+msgstr "r=E9f=E9rentiel"
+
+#. ""
+msgid "reset"
+msgstr "r=E9initialiser"
+
+#. ""
+msgid "revert"
+msgstr "inverser"
+
+#. "A particular state of files and directories which was stored in th=
e object database."
+msgid "revision"
+msgstr "r=E9vision"
+
+#. ""
+msgid "sign off"
+msgstr "signer"
+
+#. ""
+msgid "staging area"
+msgstr "pr=E9-commit"
+
+#. ""
+msgid "status"
+msgstr "=E9tat"
+
+#. "A ref pointing to a tag or commit object"
+msgid "tag [noun]"
+msgstr "marque"
+
+#. ""
+msgid "tag [verb]"
+msgstr "marquer"
+
+#. "A regular git branch that is used to follow changes from another r=
epository."
+msgid "tracking branch"
+msgstr "branche de suivi"
+
+#. ""
+msgid "undo"
+msgstr "d=E9faire"
+
+#. ""
+msgid "update"
+msgstr "mise =E0 jour"
+
+#. ""
+msgid "verify"
+msgstr "v=E9rifier"
+
+#. "The tree of actual checked out files."
+msgid "working copy, working tree"
+msgstr "copie de travail, arborescence de travail"
+
--=20
1.5.4.rc2.38.gd6da3
