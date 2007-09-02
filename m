From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 15/15] git-gui: Added initial version of po/glossary/zh_cn.po
Date: Sun, 2 Sep 2007 17:38:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021737510.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1908090830-1188751080=:28586"
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:38:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsSn-0006A6-4v
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbXIBQiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbXIBQiM
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:38:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:39654 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964861AbXIBQiL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:38:11 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:38:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 02 Sep 2007 18:38:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PTXRPRGwPxYjsoO88msvAKgUM9pihBRLvPgrnUe
	ahJKl97zkxDlOy
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57363>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1908090830-1188751080=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


From: Xudong Guan <xudong.guan@gmail.com>

with contributions from LI Yang, WANG Cong, ZHANG Le, and rae l
from the zh-kernel.org mailing list.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/glossary/zh_cn.po |  170 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 170 insertions(+), 0 deletions(-)
 create mode 100644 po/glossary/zh_cn.po

diff --git a/po/glossary/zh_cn.po b/po/glossary/zh_cn.po
new file mode 100644
index 0000000..158835b
--- /dev/null
+++ b/po/glossary/zh_cn.po
@@ -0,0 +1,170 @@
+# Translation of git-gui glossary to Simplified Chinese
+# Copyright (C) 2007 Shawn Pearce, et al.
+# This file is distributed under the same license as the git package.
+# Xudong Guan <xudong.guan@gmail.com> and the zh-kernel.org mailing list, 2007
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui glossary\n"
+"PO-Revision-Date: 2007-07-23 22:07+0200\n"
+"Last-Translator: Xudong Guan <xudong.guan@gmail.com>\n"
+"Language-Team: Simplified Chinese \n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#. "English Definition (Dear translator: This file will never be visible to the user! It should only serve as a tool for you, the translator. Nothing more.)"
+msgid ""
+"English Term (Dear translator: This file will never be visible to the user!)"
+msgstr "注：这个文件是为了帮助翻译人员统一名词术语。最终用户不会关心这个文件。"
+
+#. ""
+#. amend指用户修改最近一次commit的操作，修订？修改？修正？
+#. [WANG Cong]: 根据我的了解，这个词似乎翻译成“修订”多一些。“修正”也可以，“修改”再次之。
+#. [ZHANG Le]: 修订，感觉一般指对一些大型出版物的大规模升级，比如修订新华字典
+#              修正，其实每次amend的结果也不一定就是最后结果，说不定还需要修改。所以不
+#              如就叫修改
+msgid "amend"
+msgstr "修订"
+
+#. ""
+#. git annotate 文件名：用来标注文件的每一行在什么时候被谁最后修改。
+#. [WANG Cong]: "标记"一般是mark。;)
+#. [ZHANG Le]: 标注，或者干脆用原意：注解，或注释
+msgid "annotate"
+msgstr "标注"
+
+#. "A 'branch' is an active line of development."
+msgid "branch [noun]"
+msgstr "分支"
+
+#. ""
+msgid "branch [verb]"
+msgstr "建立分支"
+
+#. ""
+#. [WANG Cong]: 网上有人翻译成“检出”，我感觉更好一些，毕竟把check的意思翻译出来了。
+#. [ZHNAG Le]: 提取吧，提取分支／版本
+#. [rae l]: 签出。subversion软件中的大多词汇已有翻译，既然git与subversion同是SCM管理，可以参考同类软件的翻译也不错。
+msgid "checkout [noun]"
+msgstr "签出"
+
+#. "The action of updating the working tree to a revision which was stored in the object database."
+msgid "checkout [verb]"
+msgstr "签出"
+
+#. "A single point in the git history."
+msgid "commit [noun]"
+msgstr "提交"
+
+#. "The action of storing a new snapshot of the project's state in the git history."
+msgid "commit [verb]"
+msgstr "提交"
+
+#. ""
+#. 差异？差别？
+#. [ZHANG Le]: 个人感觉差别更加中性一些
+msgid "diff [noun]"
+msgstr "差别"
+
+#. ""
+msgid "diff [verb]"
+msgstr "比较"
+
+#. "A fast-forward is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
+msgid "fast forward merge"
+msgstr "快进式合并"
+
+#. "Fetching a branch means to get the branch's head from a remote repository, to find out which objects are missing from the local object database, and to get them, too."
+#. 获取？取得？下载？更新？注意和update的区分
+msgid "fetch"
+msgstr "获取"
+
+#. "A collection of files. The index is a stored version of your working tree."
+#. index是working tree和repository之间的缓存
+msgid "index (in git-gui: staging area)"
+msgstr "工作缓存？"
+
+#. "A successful merge results in the creation of a new commit representing the result of the merge."
+msgid "merge [noun]"
+msgstr "合并"
+
+#. "To bring the contents of another branch into the current branch."
+msgid "merge [verb]"
+msgstr "合并"
+
+#. ""
+#. message是指commit中的文字信息
+msgid "message"
+msgstr "描述"
+
+#. "Pulling a branch means to fetch it and merge it."
+msgid "pull"
+msgstr "获取＋合并"
+
+#. "Pushing a branch means to get the branch's head ref from a remote repository, and ... (well, can someone please explain it for mere mortals?)"
+msgid "push"
+msgstr "推入"
+
+#. ""
+msgid "redo"
+msgstr "重做"
+
+#. "A collection of refs (?) together with an object database containing all objects which are reachable from the refs... (oops, you've lost me here. Again, please an explanation for mere mortals?)"
+msgid "repository"
+msgstr "仓库"
+
+#. ""
+msgid "reset"
+msgstr "重置"
+
+#. ""
+msgid "revert"
+msgstr "恢复"
+
+#. "A particular state of files and directories which was stored in the object database."
+msgid "revision"
+msgstr "版本"
+
+#. ""
+msgid "sign off"
+msgstr "签名"
+
+#. ""
+#. 似乎是git-gui里面显示的本次提交的文件清单区域
+msgid "staging area"
+msgstr "提交暂存区"
+
+#. ""
+msgid "status"
+msgstr "状态"
+
+#. "A ref pointing to a tag or commit object"
+msgid "tag [noun]"
+msgstr "标签"
+
+#. ""
+msgid "tag [verb]"
+msgstr "添加标签"
+
+#. "A regular git branch that is used to follow changes from another repository."
+msgid "tracking branch"
+msgstr "跟踪分支"
+
+#. ""
+msgid "undo"
+msgstr "撤销"
+
+#. ""
+msgid "update"
+msgstr "更新。注意和fetch的区分"
+
+#. ""
+msgid "verify"
+msgstr "验证"
+
+#. "The tree of actual checked out files."
+#. "工作副本？工作区域？工作目录"
+#. [LI Yang]: 当前副本， 当前源码树？
+msgid "working copy, working tree"
+msgstr "工作副本，工作源码树"
-- 
1.5.3.2.g46909


--8323584-1908090830-1188751080=:28586--
