From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] git-gui: Update glossary; update German translation
Date: Mon, 7 Jan 2008 22:08:50 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200801072208.51943.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jTpgHbqMHNpGQbh"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 22:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBzFs-00025d-K0
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 22:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbYAGVLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 16:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbYAGVLD
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 16:11:03 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:47849 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbYAGVLB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 16:11:01 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m07LArSr010203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 7 Jan 2008 22:10:53 +0100
Received: from [192.168.2.102] (p54900BDF.dip0.t-ipconnect.de [84.144.11.223])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m07LAGaB004833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 Jan 2008 22:10:21 +0100
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69810>

--Boundary-00=_jTpgHbqMHNpGQbh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---
 po/glossary/git-gui-glossary.pot |    6 +++++-
 po/glossary/git-gui-glossary.txt |    1 +
 2 files changed, 6 insertions(+), 1 deletions(-)

Additionally, I've updated the German translation, but due to fear of whitespace
mangling I'm just adding that patch and this one in the attached tarball. Hope that's ok.

Thanks a lot! - Christian


diff --git a/po/glossary/git-gui-glossary.pot b/po/glossary/git-gui-glossary.pot
index 48af803..40eb3e9 100644
--- a/po/glossary/git-gui-glossary.pot
+++ b/po/glossary/git-gui-glossary.pot
@@ -6,7 +6,7 @@
 msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
-"POT-Creation-Date: 2007-10-19 21:43+0200\n"
+"POT-Creation-Date: 2008-01-07 21:20+0100\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
@@ -70,6 +70,10 @@ msgstr ""
 msgid "fetch"
 msgstr ""
 
+#. "One context of consecutive lines in a whole patch, which consists of many such hunks"
+msgid "hunk"
+msgstr ""
+
 #. "A collection of files. The index is a stored version of your working tree."
 msgid "index (in git-gui: staging area)"
 msgstr ""
diff --git a/po/glossary/git-gui-glossary.txt b/po/glossary/git-gui-glossary.txt
index 500d0a0..9b31f69 100644
--- a/po/glossary/git-gui-glossary.txt
+++ b/po/glossary/git-gui-glossary.txt
@@ -12,6 +12,7 @@
 "diff [verb]"	""
 "fast forward merge"	"A fast-forward is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
 "fetch"	"Fetching a branch means to get the branch's head from a remote repository, to find out which objects are missing from the local object database, and to get them, too."
+"hunk"	"One context of consecutive lines in a whole patch, which consists of many such hunks"
 "index (in git-gui: staging area)"	"A collection of files. The index is a stored version of your working tree."
 "merge [noun]"	"A successful merge results in the creation of a new commit representing the result of the merge."
 "merge [verb]"	"To bring the contents of another branch into the current branch."
-- 
1.5.3.4.206.g58ba4


--Boundary-00=_jTpgHbqMHNpGQbh
Content-Type: application/x-tgz;
  name="git-gui-Update-German-translation.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="git-gui-Update-German-translation.tgz"

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

--Boundary-00=_jTpgHbqMHNpGQbh--
