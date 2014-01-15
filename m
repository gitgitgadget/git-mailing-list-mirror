From: al_shopov@yahoo.com
Subject: [PATCH 1/3] git-gui i18n: Initial glossary in Bulgarian
Date: Wed, 15 Jan 2014 13:27:28 +0200
Message-ID: <1389785251-8472-2-git-send-email-lists@kambanaria.org>
References: <1389785251-8472-1-git-send-email-lists@kambanaria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 15 12:27:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3OdP-0002SY-AE
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 12:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbaAOL1m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jan 2014 06:27:42 -0500
Received: from nm15.bullet.mail.ird.yahoo.com ([77.238.189.68]:20031 "EHLO
	nm15.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750928AbaAOL1l (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 06:27:41 -0500
Received: from [77.238.189.49] by nm15.bullet.mail.ird.yahoo.com with NNFMP; 15 Jan 2014 11:27:39 -0000
Received: from [46.228.39.69] by tm2.bullet.mail.ird.yahoo.com with NNFMP; 15 Jan 2014 11:27:39 -0000
Received: from [127.0.0.1] by smtp106.mail.ir2.yahoo.com with NNFMP; 15 Jan 2014 11:27:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1389785259; bh=pXsEoUMhSa4m5VhncLKtV8WDsrbtjY9+EwyB/uauMzU=; h=X-Yahoo-Newman-Id:X-Rocket-Received:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=MlhwGb3VzsW6hhxLHc8boQOqTlth3AOLI59Vi2Z52u8hML3suLZNSD8mxICAX4F2LP621ede/3kPnMECvsUvirgZIvK+zCww4Pbk8LobhfT3kw9ywZG+ufJp3hpNVAW2JPt/gq3XVeLDWkN3jFN9nB1hvIAkzpfWFw+FEg2zjsU=
X-Yahoo-Newman-Id: 64309.90545.bm@smtp106.mail.ir2.yahoo.com
X-Rocket-Received: from localhost.lan (al_shopov@78.83.52.173 with plain [188.125.69.59])
        by smtp106.mail.ir2.yahoo.com with SMTP; 15 Jan 2014 11:27:38 +0000 UTC
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: nToNry8VM1m6MbkajlSNwCvO0wzxKPFC25bizN..beBWbkY
 p6HDlYJ.OYHgu4GZu17bF08CipR.MQu3MaRFEVnt975HKsuUe8ULTwfswIke
 rDnGqkyV5N1zWExMe.glhRYn5tJP4avCF061Nws0WVcBRQHt42BDh7AD4D4D
 F98x1N7fHTvd4Ffv0rd5m.ysoyURCFc4KbmyNX1chdfluDwOzvwomfcJWJ_J
 w4mp4aDUDNHnyLnKT50sN0R.NobROsVWtlxJ4ky2bvhFkG13aM1izXDWFfWK
 OxM4rpg7jDY4iudpSbZMlA84OYWZcw4SagLkdRe1WR_Xr3VYnwD7pkJ83krM
 edi17plb0SG1wXsbhdWhX7BzJFGJwB0p2xZ4syr75p87X7JWRqPQzpgmc9Ei
 Nl_1cY8TBh.mZAoEzZdbf.629QYIvnUx5B294vhtTsZk9xppfxyJwO9SQaB2
 QcUoD0ppAiAGTswuaWuaRAd70cn3Il4xgJrqalX0_3GMPg_CBtO_82ofv0xL
 l7FiAoD7GF7ulZRQXv4G2xB95nQRUy7k11lt5Q1bqoFCQ
X-Yahoo-SMTP: yRWQ8BGswBDCUSC0.xLhuVo_zCa4SQ--
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1389785251-8472-1-git-send-email-lists@kambanaria.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240461>

=46rom: Alexander Shopov <ash@kambanaria.org>

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 po/glossary/bg.po | 287 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 287 insertions(+)
 create mode 100644 po/glossary/bg.po

diff --git a/po/glossary/bg.po b/po/glossary/bg.po
new file mode 100644
index 0000000..8b71fad
--- /dev/null
+++ b/po/glossary/bg.po
@@ -0,0 +1,287 @@
+# Bulgarian translation of git-gui-glossary po-file.
+# Copyright (C) 2012, 2013, 2014 Alexander Shopov <ash@kambanaria.org>=
=2E
+# This file is distributed under the same license as the git package.
+# Alexander Shopov <ash@kambanaria.org>, 2012, 2013, 2014.
+#
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui-glossary master\n"
+"POT-Creation-Date: 2014-01-13 21:39+0200\n"
+"PO-Revision-Date: 2014-01-13 21:39+0200\n"
+"Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
+"Language-Team: Bulgarian <dict@fsa-bg.org>\n"
+"Language: bg\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
+
+#. "English Definition (Dear translator: This file will never be visib=
le to the user! It should only serve as a tool for you, the translator.=
 Nothing more.)"
+msgid ""
+"English Term (Dear translator: This file will never be visible to the=
 user!)"
+msgstr "=D0=A2=D0=B5=D1=80=D0=BC=D0=B8=D0=BD"
+
+#. ""
+msgid "amend"
+msgstr "=D0=BF=D0=BE=D0=BF=D1=80=D0=B0=D0=B2=D1=8F=D0=BC"
+
+#. ""
+msgid "annotate"
+msgstr "=D0=B0=D0=BD=D0=BE=D1=82=D0=B8=D1=80=D0=B0=D0=BC"
+
+#. "A 'branch' is an active line of development."
+msgid "branch [noun]"
+msgstr "=D0=BA=D0=BB=D0=BE=D0=BD, =D1=80=D0=B0=D0=B7=D0=BA=D0=BB=D0=BE=
=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 [=D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=
=B2=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=BE]"
+
+#. ""
+msgid "branch [verb]"
+msgstr "=D1=80=D0=B0=D0=B7=D0=BA=D0=BB=D0=BE=D0=BD=D1=8F=D0=B2=D0=B0=D0=
=BC [=D0=B3=D0=BB=D0=B0=D0=B3=D0=BE=D0=BB]"
+
+#. ""
+msgid "checkout [noun]"
+msgstr "=D0=B8=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5 [=D1=81=
=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=BE=
]"
+
+#. "The action of updating the working tree to a revision which was st=
ored in the object database."
+msgid "checkout [verb]"
+msgstr "=D0=B8=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5 [=D0=B3=
=D0=BB=D0=B0=D0=B3=D0=BE=D0=BB]"
+
+#. ""
+msgid "clone [verb]"
+msgstr "=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=B0=D0=BC [=D0=B3=D0=BB=
=D0=B0=D0=B3=D0=BE=D0=BB]"
+
+#. "A single point in the git history."
+msgid "commit [noun]"
+msgstr "=D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5 [=D1=81=D1=8A=
=D1=89=D0=B5=D1=81=D1=82=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=BE]"
+
+#. "The action of storing a new snapshot of the project's state in the=
 git history."
+msgid "commit [verb]"
+msgstr "=D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BC [=D1=81=D1=8A=D1=89=
=D0=B5=D1=81=D1=82=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=BE]"
+
+#. ""
+msgid "diff [noun]"
+msgstr "=D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0/=D0=BF=D1=80=D0=BE=D0=
=BC=D0=B5=D0=BD=D0=B8 [=D1=81=D1=8A=D1=89=D0=B5=D1=81=D1=82=D0=B2=D0=B8=
=D1=82=D0=B5=D0=BB=D0=BD=D0=BE]"
+
+#. ""
+msgid "diff [verb]"
+msgstr "=D0=B8=D0=B7=D1=87=D0=B8=D1=81=D0=BB=D1=8F=D0=B2=D0=B0=D0=BC =D1=
=80=D0=B0=D0=B7=D0=BB=D0=B8=D0=BA=D0=B0/=D0=BF=D1=80=D0=BE=D0=BC=D0=B5=D0=
=BD=D0=B8 [=D0=B3=D0=BB=D0=B0=D0=B3=D0=BE=D0=BB]"
+
+#. "A fast-forward is a special type of merge where you have a revisio=
n and you are merging another branch's changes that happen to be a desc=
endant of what you have."
+msgid "fast forward merge"
+msgstr "=D0=BF=D1=80=D0=B5=D0=B2=D1=8A=D1=80=D1=82=D0=B0=D1=89=D0=BE/=D0=
=B4=D0=B8=D1=80=D0=B5=D0=BA=D1=82=D0=BD=D0=BE/=D1=82=D1=80=D0=B8=D0=B2=D0=
=B8=D0=B0=D0=BB=D0=BD=D0=BE =D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#. "Fetching a branch means to get the branch's head from a remote rep=
ository, to find out which objects are missing from the local object da=
tabase, and to get them, too."
+msgid "fetch"
+msgstr "=D0=B4=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5"
+
+#. "One context of consecutive lines in a whole patch, which consists =
of many such hunks"
+msgid "hunk"
+msgstr "=D0=BF=D0=B0=D1=80=D1=87=D0=B5"
+
+#. "A collection of files. The index is a stored version of your worki=
ng tree."
+msgid "index (in git-gui: staging area)"
+msgstr "=D1=81=D0=BA=D0=B5=D0=BB=D0=B5/=D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=
=81/=D0=B8=D0=B7=D0=B1=D0=B0"
+
+#. "A successful merge results in the creation of a new commit represe=
nting the result of the merge."
+msgid "merge [noun]"
+msgstr "=D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5/=D0=BE=D0=B1=D0=B5=D0=
=B4=D0=B8=D0=BD=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 [=D1=81=D1=8A=D1=89=D0=B5=
=D1=81=D1=82=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=BE]"
+
+#. "To bring the contents of another branch into the current branch."
+msgid "merge [verb]"
+msgstr "=D1=81=D0=BB=D0=B8=D0=B2=D0=B0=D0=BC/=D0=BE=D0=B1=D0=B5=D0=B4=D0=
=B8=D0=BD=D1=8F=D0=B2=D0=B0=D0=BC [=D0=B3=D0=BB=D0=B0=D0=B3=D0=BE=D0=BB=
]"
+
+#. ""
+msgid "message"
+msgstr "=D1=81=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5"
+
+#. "Deletes all stale tracking branches under <name>. These stale bran=
ches have already been removed from the remote repository referenced by=
 <name>, but are still locally available in 'remotes/<name>'."
+msgid "prune"
+msgstr "=D0=BE=D0=BA=D0=B0=D1=81=D1=82=D1=80=D1=8F=D0=BC"
+
+#. "Pulling a branch means to fetch it and merge it."
+msgid "pull"
+msgstr "=D0=B8=D0=B7=D0=B4=D1=8A=D1=80=D0=BF=D0=B2=D0=B0=D0=BC"
+
+#. "Pushing a branch means to get the branch's head ref from a remote =
repository, and ... (well, can someone please explain it for mere morta=
ls?)"
+msgid "push"
+msgstr "=D0=B8=D0=B7=D1=82=D0=BB=D0=B0=D1=81=D0=BA=D0=B2=D0=B0=D0=BC"
+
+#. ""
+msgid "redo"
+msgstr "=D0=BF=D0=BE=D0=B2=D1=82=D0=B0=D1=80=D1=8F=D0=BC/=D0=BF=D1=80=D0=
=B0=D0=B2=D1=8F =D0=BD=D0=B0=D0=BD=D0=BE=D0=B2=D0=BE"
+
+#. "An other repository ('remote'). One might have a set of remotes wh=
ose branches one tracks."
+msgid "remote"
+msgstr "=D0=BE=D1=82=D0=B4=D0=B0=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=BE =D1=
=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5"
+
+#. "A collection of refs (?) together with an object database containi=
ng all objects which are reachable from the refs... (oops, you've lost =
me here. Again, please an explanation for mere mortals?)"
+msgid "repository"
+msgstr "=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5"
+
+#. ""
+msgid "reset"
+msgstr "=D0=B7=D0=B0=D0=BD=D1=83=D0=BB=D1=8F=D0=B2=D0=B0=D0=BC/=D0=BE=D1=
=82=D0=BC=D0=B5=D0=BD=D1=8F=D0=BC"
+
+#. ""
+msgid "revert"
+msgstr "=D0=B2=D1=80=D1=8A=D1=89=D0=B0=D0=BC/=D0=BE=D1=82=D0=BC=D0=B5=D0=
=BD=D1=8F=D0=BC"
+
+#. "A particular state of files and directories which was stored in th=
e object database."
+msgid "revision"
+msgstr "=D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F"
+
+#. ""
+msgid "sign off"
+msgstr "=D0=BF=D0=BE=D0=B4=D0=BF=D0=B8=D1=81=D0=B2=D0=B0=D0=BC"
+
+#. ""
+msgid "staging area"
+msgstr "=D1=81=D0=BA=D0=B5=D0=BB=D0=B5/=D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=
=81/=D0=B8=D0=B7=D0=B1=D0=B0"
+
+#. ""
+msgid "status"
+msgstr "=D1=81=D1=8A=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+
+#. "A ref pointing to a tag or commit object"
+msgid "tag [noun]"
+msgstr "=D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82 [=D1=81=D1=8A=D1=89=D0=B5=
=D1=81=D1=82=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=BE]"
+
+#. ""
+msgid "tag [verb]"
+msgstr "=D0=B7=D0=B0=D0=B4=D0=B0=D0=B2=D0=B0=D0=BC =D0=B5=D1=82=D0=B8=D0=
=BA=D0=B5=D1=82 [=D0=B3=D0=BB=D0=B0=D0=B3=D0=BE=D0=BB]"
+
+#. "A regular git branch that is used to follow changes from another r=
epository."
+msgid "tracking branch"
+msgstr "=D1=81=D0=BB=D0=B5=D0=B4=D1=8F=D1=89 =D0=BA=D0=BB=D0=BE=D0=BD"
+
+#. ""
+msgid "undo"
+msgstr "=D0=BE=D1=82=D0=BC=D0=B5=D0=BD=D1=8F=D0=BC"
+
+#. ""
+msgid "update"
+msgstr "=D0=BE=D0=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BC"
+
+#. ""
+msgid "verify"
+msgstr "=D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D1=8F=D0=B2=D0=B0=D0=BC"
+
+#. "The tree of actual checked out files."
+msgid "working copy, working tree"
+msgstr "=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BD=D0=BE =D0=BA=D0=BE=D0=BF=D0=
=B8=D0=B5/=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BD=D0=BE =D0=B4=D1=8A=D1=80=
=D0=B2=D0=BE"
+
+#. "a commit that succeeds the current one in git's graph of commits (=
not necessarily directly)"
+msgid "ancestor"
+msgstr "=D0=BF=D1=80=D0=B5=D0=B4=D1=88=D0=B5=D1=81=D1=82=D0=B2=D0=B5=D0=
=BD=D0=B8=D0=BA"
+
+#. "prematurely stop and abandon an operation"
+msgid "abort"
+msgstr "=D0=BF=D1=80=D0=B5=D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D1=
=8F=D0=B2=D0=B0=D0=BC"
+
+#. "a repository with only .git directory, without working directory"
+msgid "bare repository"
+msgstr "=D0=B3=D0=BE=D0=BB=D0=BE =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=
=B8=D1=89=D0=B5"
+
+#. "a parent version of the current file"
+msgid "base"
+msgstr "=D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=81=D0=BA=D0=B0 =D0=
=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F"
+
+#. "get the authors responsible for each line in a file"
+msgid "blame"
+msgstr "=D0=B0=D0=BD=D0=BE=D1=82=D0=B8=D1=80=D0=B0=D0=BC/=D0=B0=D0=BD=D0=
=BE=D1=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B5"
+
+#. "to select and apply a single commit without merging"
+msgid "cherry-pick"
+msgstr "=D0=BE=D1=82=D0=B1=D0=B8=D1=80=D0=B0=D0=BC"
+
+#. "a commit that directly succeeds the current one in git's graph of =
commits"
+msgid "child"
+msgstr "=D0=B4=D0=B5=D1=82=D0=B5"
+
+#. "clean the state of the git repository, often after manually stoppe=
d operation"
+msgid "cleanup"
+msgstr "=D0=B7=D0=B0=D1=87=D0=B8=D1=81=D1=82=D0=B2=D0=B0=D0=BC"
+
+#. "a message that gets attached with any commit"
+msgid "commit message"
+msgstr "=D1=81=D1=8A=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BF=D1=
=80=D0=B8 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#. "a commit that precedes the current one in git's graph of commits (=
not necessarily directly)"
+msgid "descendant"
+msgstr "=D0=BD=D0=B0=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B8=D0=BA"
+
+#. "checkout of a revision rather than a some head"
+msgid "detached checkout"
+msgstr "=D0=BD=D0=B5=D1=81=D0=B2=D1=8A=D1=80=D0=B7=D0=B0=D0=BD=D0=BE =D0=
=B8=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5"
+
+#. "any merge strategy that works on a file by file basis"
+msgid "file level merging"
+msgstr "=D0=BF=D0=BE=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=D0=BE =D1=81=D0=
=BB=D0=B8=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#. "the last revision in a branch"
+msgid "head"
+msgstr "=D0=B3=D0=BB=D0=B0=D0=B2=D0=B0/=D0=B2=D1=80=D1=8A=D1=85 (=D0=BD=
=D0=B0 =D0=BA=D0=BB=D0=BE=D0=BD, =D1=80=D0=B0=D0=B7=D1=80=D0=B0=D0=B1=D0=
=BE=D1=82=D0=BA=D0=B0)"
+
+#. "script that gets executed automatically on some event"
+msgid "hook"
+msgstr "=D0=BA=D1=83=D0=BA=D0=B0/=D0=B0=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=
=82=D0=B8=D1=87=D0=B5=D0=BD =D1=81=D0=BA=D1=80=D0=B8=D0=BF=D1=82"
+
+#. "the first checkout during a clone operation"
+msgid "initial checkout"
+msgstr "=D0=BF=D1=8A=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=
=BD=D0=BE =D0=B8=D0=B7=D1=82=D0=B5=D0=B3=D0=BB=D1=8F=D0=BD=D0=B5"
+
+#. "a branch that resides in the local git repository"
+msgid "local branch"
+msgstr "=D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D0=B5=D0=BD =D0=BA=D0=BB=D0=BE=D0=
=BD"
+
+#. "a Git object that is not part of any pack"
+msgid "loose object"
+msgstr "=D0=BD=D0=B5=D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B8=D1=80=D0=B0=D0=
=BD =D0=BE=D0=B1=D0=B5=D0=BA=D1=82"
+
+#. "a branch called by convention 'master' that exists in a newly crea=
ted git repository"
+msgid "master branch"
+msgstr "=D0=BE=D1=81=D0=BD=D0=BE=D0=B2=D0=B5=D0=BD =D0=BA=D0=BB=D0=BE=D0=
=BD"
+
+#. "a remote called by convention 'origin' that the current git reposi=
tory has been cloned from"
+msgid "origin"
+msgstr "=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B5-=D0=B8=D0=
=B7=D1=82=D0=BE=D1=87=D0=BD=D0=B8=D0=BA"
+
+#. "a file containing many git objects packed together"
+msgid "pack [noun]"
+msgstr "=D0=B5=D1=82=D0=B8=D0=BA=D0=B5=D1=82"
+
+#. "a Git object part of some pack"
+msgid "packed object"
+msgstr "=D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B8=D1=80=D0=B0=D0=BD =D0=BE=D0=
=B1=D0=B5=D0=BA=D1=82"
+
+#. "a commit that directly precedes the current one in git's graph of =
commits"
+msgid "parent"
+msgstr "=D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB"
+
+#. "the log file containing all states of the HEAD reference (in other=
 words past pristine states of the working copy)"
+msgid "reflog"
+msgstr "=D0=B6=D1=83=D1=80=D0=BD=D0=B0=D0=BB =D0=BD=D0=B0 =D1=83=D0=BA=
=D0=B0=D0=B7=D0=B0=D1=82=D0=B5=D0=BB=D0=B8=D1=82=D0=B5"
+
+#. "decide which changes from alternative versions of a file should pe=
rsist in Git"
+msgid "resolve (a conflict)"
+msgstr "=D0=BA=D0=BE=D1=80=D0=B8=D0=B3=D0=B8=D1=80=D0=B0=D0=BC (=D0=BA=
=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82)"
+
+#. "abandon changes and go to pristine version"
+msgid "revert changes"
+msgstr "=D0=B2=D1=80=D1=8A=D1=89=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=BE=
=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=B0"
+
+#. "expression that signifies a revision in git"
+msgid "revision expression"
+msgstr "=D0=B8=D0=B7=D1=80=D0=B0=D0=B7 =D0=B7=D0=B0 =D0=B2=D0=B5=D1=80=
=D1=81=D0=B8=D1=8F"
+
+#. "add some content of files and directories to the staging area in p=
reparation for a commit"
+msgid "stage/unstage"
+msgstr "(=D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D1=8F=D0=BD=D0=B5) =D0=BA=D1=8A=
=D0=BC =D1=81=D0=BA=D0=B5=D0=BB=D0=B5=D1=82=D0=BE =D0=B7=D0=B0 =D0=BF=D0=
=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5/=D0=B8=D0=B7=D0=B2=D0=B0=D0=B6=D0=
=B4=D0=B0=D0=BD=D0=B5 =D0=BE=D1=82 =D1=81=D0=BA=D0=B5=D0=BB=D0=B5=D1=82=
=D0=BE =D0=B7=D0=B0 =D0=BF=D0=BE=D0=B4=D0=B0=D0=B2=D0=B0=D0=BD=D0=B5"
+
+#. "temporarily save changes in a stack without committing"
+msgid "stash"
+msgstr "=D1=81=D0=BA=D0=B0=D1=82=D0=B0=D0=B2=D0=B0=D0=BC =D0=BF=D1=80=D0=
=BE=D0=BC=D0=B5=D0=BD=D0=B8"
+
+#. "file whose content is tracked/not tracked by git"
+msgid "tracked/untracked"
+msgstr "=D1=81=D0=BB=D0=B5=D0=B4=D0=B5=D0=BD/=D0=BD=D0=B5=D1=81=D0=BB=D0=
=B5=D0=B4=D0=B5=D0=BD"
--=20
1.8.4.2
