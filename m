From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 14/15] German glossary for translation
Date: Sun, 2 Sep 2007 17:37:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021737390.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1184710891-1188751066=:28586"
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:38:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsSY-00067p-T4
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbXIBQh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbXIBQh6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:37:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:39626 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964871AbXIBQh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:37:58 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:37:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 02 Sep 2007 18:37:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sRlteE9esPidheIqdhLby8WSR080GCqhhfWsu6p
	2bqyVYWpk8k1Ni
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57362>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1184710891-1188751066=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


From: Christian Stimming <stimming@tuhh.de>

Signed-off-by: Christian Stimming <christian.stimming@ibeo-as.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/glossary/de.po |  158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 158 insertions(+), 0 deletions(-)
 create mode 100644 po/glossary/de.po

diff --git a/po/glossary/de.po b/po/glossary/de.po
new file mode 100644
index 0000000..aab3b22
--- /dev/null
+++ b/po/glossary/de.po
@@ -0,0 +1,158 @@
+# Translation of git-gui glossary to German
+# Copyright (C) 2007 Shawn Pearce, et al.
+# This file is distributed under the same license as the git package.
+# Christian Stimming <stimming@tuhh.de>, 2007
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui glossary\n"
+"PO-Revision-Date: 2007-07-26 14:45+0200\n"
+"Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
+"Language-Team: German \n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#. "English Definition (Dear translator: This file will never be visible to the user! It should only serve as a tool for you, the translator. Nothing more.)"
+msgid ""
+"English Term (Dear translator: This file will never be visible to the user!)"
+msgstr ""
+"Deutsche Übersetzung.\n"
+"Andere deutsche SCM:\n"
+"  http://tortoisesvn.net/docs/release/TortoiseSVN_de/index.html und http://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/Languages/Tortoise_de.po (username=guest, password empty, gut),\n"
+"  http://msdn.microsoft.com/de-de/library/ms181038(vs.80).aspx (MS Visual Source Safe, kommerziell),\n"
+"  http://cvsbook.red-bean.com/translations/german/Kap_06.html (mittelmäßig),\n"
+"  http://tortoisecvs.cvs.sourceforge.net/tortoisecvs/po/TortoiseCVS/de_DE.po?view=markup (mittelmäßig),\n"
+"  http://rapidsvn.tigris.org/svn/rapidsvn/trunk/src/locale/de/rapidsvn.po (username=guest, password empty, schlecht)"
+
+#. ""
+msgid "amend"
+msgstr "nachbessern (ergänzen)"
+
+#. ""
+msgid "annotate"
+msgstr "annotieren"
+
+#. "A 'branch' is an active line of development."
+msgid "branch [noun]"
+msgstr "Zweig"
+
+#. ""
+msgid "branch [verb]"
+msgstr "verzweigen"
+
+#. ""
+msgid "checkout [noun]"
+msgstr "Auscheck? Ausspielung? Abruf? (Source Safe: Auscheckvorgang)"
+
+#. "The action of updating the working tree to a revision which was stored in the object database."
+msgid "checkout [verb]"
+msgstr "auschecken? ausspielen? abrufen? (Source Safe: auschecken)"
+
+#. "A single point in the git history."
+msgid "commit [noun]"
+msgstr "Übertragung (Sendung?, Übergabe?, Einspielung?, Ablagevorgang?)"
+
+#. "The action of storing a new snapshot of the project's state in the git history."
+msgid "commit [verb]"
+msgstr "übertragen (TortoiseSVN: übertragen; Source Safe: einchecken; senden?, übergeben?, einspielen?, einpflegen?, ablegen?)"
+
+#. ""
+msgid "diff [noun]"
+msgstr "Vergleich (Source Safe: Unterschiede)"
+
+#. ""
+msgid "diff [verb]"
+msgstr "vergleichen"
+
+#. "A fast-forward is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
+msgid "fast forward merge"
+msgstr "Schnellzusammenführung"
+
+#. "Fetching a branch means to get the branch's head from a remote repository, to find out which objects are missing from the local object database, and to get them, too."
+msgid "fetch"
+msgstr "anfordern (holen?)"
+
+#. "A collection of files. The index is a stored version of your working tree."
+msgid "index (in git-gui: staging area)"
+msgstr "Bereitstellung"
+
+#. "A successful merge results in the creation of a new commit representing the result of the merge."
+msgid "merge [noun]"
+msgstr "Zusammenführung"
+
+#. "To bring the contents of another branch into the current branch."
+msgid "merge [verb]"
+msgstr "zusammenführen"
+
+#. ""
+msgid "message"
+msgstr "Meldung (Nachricht?; Source Safe: Kommentar)"
+
+#. "Pulling a branch means to fetch it and merge it."
+msgid "pull"
+msgstr "übernehmen (ziehen?)"
+
+#. "Pushing a branch means to get the branch's head ref from a remote repository, and ... (well, can someone please explain it for mere mortals?)"
+msgid "push"
+msgstr "ausliefern (hochladen? verschicken? schieben?)"
+
+#. ""
+msgid "redo"
+msgstr "wiederholen"
+
+#. "A collection of refs (?) together with an object database containing all objects which are reachable from the refs... (oops, you've lost me here. Again, please an explanation for mere mortals?)"
+msgid "repository"
+msgstr "Projektarchiv"
+
+#. ""
+msgid "reset"
+msgstr "zurücksetzen (zurückkehren?)"
+
+#. ""
+msgid "revert"
+msgstr "revidieren"
+
+#. "A particular state of files and directories which was stored in the object database."
+msgid "revision"
+msgstr "Version (TortoiseSVN: Revision; Source Safe: Version)"
+
+#. ""
+msgid "sign off"
+msgstr "abzeichnen (gegenzeichnen?, freizeichnen?, absegnen?)"
+
+#. ""
+msgid "staging area"
+msgstr "Bereitstellung"
+
+#. ""
+msgid "status"
+msgstr "Status"
+
+#. "A ref pointing to a tag or commit object"
+msgid "tag [noun]"
+msgstr "Markierung"
+
+#. ""
+msgid "tag [verb]"
+msgstr "markieren"
+
+#. "A regular git branch that is used to follow changes from another repository."
+msgid "tracking branch"
+msgstr "Übernahmezweig"
+
+#. ""
+msgid "undo"
+msgstr "rückgängig"
+
+#. ""
+msgid "update"
+msgstr "aktualisieren"
+
+#. ""
+msgid "verify"
+msgstr "überprüfen"
+
+#. "The tree of actual checked out files."
+msgid "working copy, working tree"
+msgstr "Arbeitskopie"
-- 
1.5.3.2.g46909


--8323584-1184710891-1188751066=:28586--
