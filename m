From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 09/15] Initial Chinese translation for git-gui
Date: Sun, 2 Sep 2007 17:34:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021734370.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-2108066760-1188750888=:28586"
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:35:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsQC-0005dl-6d
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933190AbXIBQfb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933051AbXIBQfb
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:35:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:45252 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932614AbXIBQf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:35:29 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:35:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 02 Sep 2007 18:35:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+uahXugF+dciHtzuvewzHMIOJwY99NMqF3/YNHy
	Cl4sfX60/H1HKr
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57357>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-2108066760-1188750888=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


From: Xudong Guan <xudong.guan@gmail.com>

Simplified Chinese, in UTF-8 encoding.

Signed-off-by: Xudong Guan <xudong.guan@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/zh_cn.po | 1284 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1284 insertions(+), 0 deletions(-)
 create mode 100644 po/zh_cn.po

diff --git a/po/zh_cn.po b/po/zh_cn.po
new file mode 100644
index 0000000..45eb5b5
--- /dev/null
+++ b/po/zh_cn.po
@@ -0,0 +1,1284 @@
+# Translation of git-gui to Chinese
+# Copyright (C) 2007 Shawn Pearce
+# This file is distributed under the same license as the git-gui package.
+# Xudong Guan <xudong.guan@gmail.com>, 2007.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-07-27 19:33+0200\n"
+"PO-Revision-Date: 2007-07-21 01:23-0700\n"
+"Last-Translator: Xudong Guan <xudong.guan@gmail.com>\n"
+"Language-Team: Chinese\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: git-gui.sh:531
+msgid "Cannot find git in PATH."
+msgstr ""
+
+#: git-gui.sh:550
+msgid "Cannot parse Git version string:"
+msgstr ""
+
+#: git-gui.sh:567
+#, tcl-format
+msgid ""
+"Git version cannot be determined.\n"
+"\n"
+"%s claims it is version '%s'.\n"
+"\n"
+"%s requires at least Git 1.5.0 or later.\n"
+"\n"
+"Assume '%s' is version 1.5.0?\n"
+msgstr ""
+
+#: git-gui.sh:689
+msgid "Cannot find the git directory:"
+msgstr ""
+
+#: git-gui.sh:697
+msgid "Git directory not found:"
+msgstr ""
+
+#: git-gui.sh:703
+msgid "Cannot use funny .git directory:"
+msgstr ""
+
+#: git-gui.sh:708
+msgid "No working directory"
+msgstr ""
+
+#: git-gui.sh:853
+msgid "Refreshing file status..."
+msgstr ""
+
+#: git-gui.sh:886
+msgid "Scanning for modified files ..."
+msgstr ""
+
+#: git-gui.sh:1052 lib/browser.tcl:233
+#, fuzzy
+msgid "Ready."
+msgstr "重做"
+
+#: git-gui.sh:1343
+msgid "Unmodified"
+msgstr ""
+
+#: git-gui.sh:1345
+msgid "Modified, not staged"
+msgstr ""
+
+#: git-gui.sh:1346 git-gui.sh:1351
+#, fuzzy
+msgid "Staged for commit"
+msgstr "从本次提交移除"
+
+#: git-gui.sh:1347 git-gui.sh:1352
+#, fuzzy
+msgid "Portions staged for commit"
+msgstr "从本次提交移除"
+
+#: git-gui.sh:1348 git-gui.sh:1353
+msgid "Staged for commit, missing"
+msgstr ""
+
+#: git-gui.sh:1350
+msgid "Untracked, not staged"
+msgstr ""
+
+#: git-gui.sh:1355
+msgid "Missing"
+msgstr ""
+
+#: git-gui.sh:1356
+msgid "Staged for removal"
+msgstr ""
+
+#: git-gui.sh:1357
+msgid "Staged for removal, still present"
+msgstr ""
+
+#: git-gui.sh:1359 git-gui.sh:1360 git-gui.sh:1361 git-gui.sh:1362
+msgid "Requires merge resolution"
+msgstr ""
+
+#: git-gui.sh:1404
+msgid "Starting gitk... please wait..."
+msgstr ""
+
+#: git-gui.sh:1413
+#, tcl-format
+msgid ""
+"Unable to start gitk:\n"
+"\n"
+"%s does not exist"
+msgstr ""
+
+#: git-gui.sh:1630
+#, tcl-format
+msgid "Invalid font specified in gui.%s:"
+msgstr ""
+
+#: git-gui.sh:1655
+msgid "Main Font"
+msgstr ""
+
+#: git-gui.sh:1656
+msgid "Diff/Console Font"
+msgstr ""
+
+#: git-gui.sh:1670
+msgid "Repository"
+msgstr "版本树"
+
+#: git-gui.sh:1671
+msgid "Edit"
+msgstr "编辑"
+
+#: git-gui.sh:1673
+msgid "Branch"
+msgstr "分支"
+
+#: git-gui.sh:1676 git-gui.sh:1854 git-gui.sh:2193
+msgid "Commit"
+msgstr "提交"
+
+#: git-gui.sh:1679 lib/merge.tcl:96 lib/merge.tcl:157 lib/merge.tcl:173
+msgid "Merge"
+msgstr "合并"
+
+#: git-gui.sh:1680
+msgid "Fetch"
+msgstr "导入"
+
+#: git-gui.sh:1681 git-gui.sh:2199 lib/transport.tcl:88 lib/transport.tcl:172
+msgid "Push"
+msgstr "上传"
+
+#: git-gui.sh:1690
+msgid "Browse Current Branch's Files"
+msgstr "浏览当前分支文件"
+
+#: git-gui.sh:1692
+#, fuzzy, tcl-format
+msgid "Browse %s's Files"
+msgstr "浏览当前分支文件"
+
+#: git-gui.sh:1694
+#, fuzzy
+msgid "Browse Branch Files..."
+msgstr "浏览当前分支文件"
+
+#: git-gui.sh:1699
+msgid "Visualize Current Branch's History"
+msgstr "调用gitk显示当前分支"
+
+#: git-gui.sh:1701
+#, fuzzy, tcl-format
+msgid "Visualize %s's History"
+msgstr "调用gitk显示所有分支"
+
+#: git-gui.sh:1703
+msgid "Visualize All Branch History"
+msgstr "调用gitk显示所有分支"
+
+#: git-gui.sh:1708 lib/database.tcl:27 lib/database.tcl:67
+msgid "Database Statistics"
+msgstr "数据库统计数据"
+
+#: git-gui.sh:1711 lib/database.tcl:34
+msgid "Compress Database"
+msgstr "压缩数据库"
+
+#: git-gui.sh:1714
+msgid "Verify Database"
+msgstr "验证数据库"
+
+#: git-gui.sh:1721 git-gui.sh:1725 git-gui.sh:1729 lib/shortcut.tcl:9
+#: lib/shortcut.tcl:45 lib/shortcut.tcl:84
+msgid "Create Desktop Icon"
+msgstr "创建桌面图标"
+
+#: git-gui.sh:1734
+msgid "Quit"
+msgstr "退出"
+
+#: git-gui.sh:1741
+msgid "Undo"
+msgstr "撤销"
+
+#: git-gui.sh:1744
+msgid "Redo"
+msgstr "重做"
+
+#: git-gui.sh:1748 git-gui.sh:2263
+msgid "Cut"
+msgstr "剪切"
+
+#: git-gui.sh:1751 git-gui.sh:2266 git-gui.sh:2337 git-gui.sh:2409
+#: lib/console.tcl:69
+msgid "Copy"
+msgstr "复制"
+
+#: git-gui.sh:1754 git-gui.sh:2269
+msgid "Paste"
+msgstr "粘贴"
+
+#: git-gui.sh:1757 git-gui.sh:2272 lib/branch_delete.tcl:26
+#: lib/remote_branch_delete.tcl:38
+msgid "Delete"
+msgstr "删除"
+
+#: git-gui.sh:1761 git-gui.sh:2276 git-gui.sh:2413 lib/console.tcl:71
+msgid "Select All"
+msgstr "全选"
+
+#: git-gui.sh:1770
+msgid "Create..."
+msgstr "新建..."
+
+#: git-gui.sh:1776
+msgid "Checkout..."
+msgstr "切换..."
+
+#: git-gui.sh:1782
+msgid "Rename..."
+msgstr "改名..."
+
+#: git-gui.sh:1787 git-gui.sh:1885
+msgid "Delete..."
+msgstr "删除..."
+
+#: git-gui.sh:1792
+msgid "Reset..."
+msgstr "重置所有修动..."
+
+#: git-gui.sh:1804 git-gui.sh:2210
+msgid "New Commit"
+msgstr "新提交"
+
+#: git-gui.sh:1812 git-gui.sh:2217
+msgid "Amend Last Commit"
+msgstr "修订上次提交"
+
+#: git-gui.sh:1821 git-gui.sh:2177 lib/remote_branch_delete.tcl:99
+msgid "Rescan"
+msgstr "重新扫描"
+
+#: git-gui.sh:1827
+msgid "Add To Commit"
+msgstr "添加到本次提交"
+
+#: git-gui.sh:1832
+msgid "Add Existing To Commit"
+msgstr "添加默认修改文件"
+
+#: git-gui.sh:1838
+msgid "Unstage From Commit"
+msgstr "从本次提交移除"
+
+#: git-gui.sh:1843 lib/index.tcl:376
+msgid "Revert Changes"
+msgstr "恢复修改"
+
+#: git-gui.sh:1850 git-gui.sh:2189 git-gui.sh:2287
+msgid "Sign Off"
+msgstr "签名"
+
+#: git-gui.sh:1865
+msgid "Local Merge..."
+msgstr "本地合并..."
+
+#: git-gui.sh:1870
+msgid "Abort Merge..."
+msgstr "取消合并..."
+
+#: git-gui.sh:1882
+msgid "Push..."
+msgstr "上传..."
+
+#: git-gui.sh:1892
+msgid "Apple"
+msgstr "苹果"
+
+#: git-gui.sh:1895 git-gui.sh:1942 lib/option.tcl:65
+#, tcl-format
+msgid "About %s"
+msgstr "关于%s"
+
+#: git-gui.sh:1897 git-gui.sh:1903 git-gui.sh:2455
+msgid "Options..."
+msgstr "选项..."
+
+#: git-gui.sh:1917
+msgid "Running miga..."
+msgstr ""
+
+#: git-gui.sh:1938
+msgid "Help"
+msgstr "帮助"
+
+#: git-gui.sh:1979
+msgid "Online Documentation"
+msgstr "在线文档"
+
+#: git-gui.sh:2095
+msgid "Current Branch:"
+msgstr "当前分支:"
+
+#: git-gui.sh:2116
+msgid "Staged Changes (Will Be Committed)"
+msgstr "将被提交的修改"
+
+#: git-gui.sh:2136
+msgid "Unstaged Changes (Will Not Be Committed)"
+msgstr "不被提交的修改"
+
+#: git-gui.sh:2183
+msgid "Add Existing"
+msgstr "添加默认修改文件"
+
+#: git-gui.sh:2229
+msgid "Initial Commit Message:"
+msgstr "初始提交描述:"
+
+#: git-gui.sh:2230
+msgid "Amended Commit Message:"
+msgstr "修订提交描述:"
+
+#: git-gui.sh:2231
+msgid "Amended Initial Commit Message:"
+msgstr "修订初始提交描述:"
+
+#: git-gui.sh:2232
+msgid "Amended Merge Commit Message:"
+msgstr "修订合并提交描述:"
+
+#: git-gui.sh:2233
+msgid "Merge Commit Message:"
+msgstr "合并提交描述:"
+
+#: git-gui.sh:2234
+msgid "Commit Message:"
+msgstr "提交描述:"
+
+#: git-gui.sh:2279 git-gui.sh:2417 lib/console.tcl:73
+msgid "Copy All"
+msgstr "全部复制"
+
+#: git-gui.sh:2303 lib/blame.tcl:104
+msgid "File:"
+msgstr ""
+
+#: git-gui.sh:2405
+msgid "Refresh"
+msgstr "刷新"
+
+#: git-gui.sh:2426
+msgid "Apply/Reverse Hunk"
+msgstr "应用/撤消此修改块"
+
+#: git-gui.sh:2432
+msgid "Decrease Font Size"
+msgstr "缩小字体"
+
+#: git-gui.sh:2436
+msgid "Increase Font Size"
+msgstr "放大字体"
+
+#: git-gui.sh:2441
+msgid "Show Less Context"
+msgstr "显示更多diff上下文"
+
+#: git-gui.sh:2448
+msgid "Show More Context"
+msgstr "显示更少diff上下文"
+
+#: git-gui.sh:2461
+#, fuzzy
+msgid "Unstage Hunk From Commit"
+msgstr "从本次提交移除"
+
+#: git-gui.sh:2463
+#, fuzzy
+msgid "Stage Hunk For Commit"
+msgstr "从本次提交移除"
+
+#: git-gui.sh:2473
+msgid "Initializing..."
+msgstr ""
+
+#: lib/blame.tcl:77
+msgid "File Viewer"
+msgstr ""
+
+#: lib/blame.tcl:81
+#, fuzzy
+msgid "Commit:"
+msgstr "提交"
+
+#: lib/blame.tcl:249
+#, fuzzy
+msgid "Copy Commit"
+msgstr "提交"
+
+#: lib/blame.tcl:369
+#, tcl-format
+msgid "Reading %s..."
+msgstr ""
+
+#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+#, fuzzy
+msgid "Checkout Branch"
+msgstr "当前分支:"
+
+#: lib/branch_checkout.tcl:23
+#, fuzzy
+msgid "Checkout"
+msgstr "切换..."
+
+#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
+#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:269
+#: lib/checkout_op.tcl:519 lib/merge.tcl:176 lib/option.tcl:172
+#: lib/remote_branch_delete.tcl:42 lib/transport.tcl:92
+msgid "Cancel"
+msgstr ""
+
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:274
+msgid "Revision"
+msgstr ""
+
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:159
+#: lib/option.tcl:274
+#, fuzzy
+msgid "Options"
+msgstr "选项..."
+
+#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr ""
+
+#: lib/branch_checkout.tcl:44
+msgid "Detach From Local Branch"
+msgstr ""
+
+#: lib/branch_create.tcl:22
+#, fuzzy
+msgid "Create Branch"
+msgstr "当前分支:"
+
+#: lib/branch_create.tcl:27
+#, fuzzy
+msgid "Create New Branch"
+msgstr "当前分支:"
+
+#: lib/branch_create.tcl:31
+#, fuzzy
+msgid "Create"
+msgstr "新建..."
+
+#: lib/branch_create.tcl:40
+#, fuzzy
+msgid "Branch Name"
+msgstr "分支"
+
+#: lib/branch_create.tcl:43
+msgid "Name:"
+msgstr ""
+
+#: lib/branch_create.tcl:58
+msgid "Match Tracking Branch Name"
+msgstr ""
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr ""
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr ""
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr ""
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr ""
+
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:511
+#, fuzzy
+msgid "Reset"
+msgstr "重置所有修动..."
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr ""
+
+#: lib/branch_create.tcl:131
+msgid "Please select a tracking branch."
+msgstr ""
+
+#: lib/branch_create.tcl:140
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr ""
+
+#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
+msgid "Please supply a branch name."
+msgstr ""
+
+#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr ""
+
+#: lib/branch_delete.tcl:15
+#, fuzzy
+msgid "Delete Branch"
+msgstr "当前分支:"
+
+#: lib/branch_delete.tcl:20
+msgid "Delete Local Branch"
+msgstr ""
+
+#: lib/branch_delete.tcl:37
+#, fuzzy
+msgid "Local Branches"
+msgstr "分支"
+
+#: lib/branch_delete.tcl:52
+msgid "Delete Only If Merged Into"
+msgstr ""
+
+#: lib/branch_delete.tcl:54
+msgid "Always (Do not perform merge test.)"
+msgstr ""
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr ""
+
+#: lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult. \n"
+"\n"
+" Delete the selected branches?"
+msgstr ""
+
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+
+#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
+#, fuzzy
+msgid "Rename Branch"
+msgstr "当前分支:"
+
+#: lib/branch_rename.tcl:26
+#, fuzzy
+msgid "Rename"
+msgstr "改名..."
+
+#: lib/branch_rename.tcl:36
+#, fuzzy
+msgid "Branch:"
+msgstr "分支"
+
+#: lib/branch_rename.tcl:39
+msgid "New Name:"
+msgstr ""
+
+#: lib/branch_rename.tcl:75
+msgid "Please select a branch to rename."
+msgstr ""
+
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr ""
+
+#: lib/branch_rename.tcl:117
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr ""
+
+#: lib/browser.tcl:10
+msgid "Starting..."
+msgstr ""
+
+#: lib/browser.tcl:19
+msgid "File Browser"
+msgstr ""
+
+#: lib/browser.tcl:120 lib/browser.tcl:137
+#, tcl-format
+msgid "Loading %s..."
+msgstr ""
+
+#: lib/browser.tcl:254 lib/browser.tcl:260
+#, fuzzy
+msgid "Browse Branch Files"
+msgstr "浏览当前分支文件"
+
+#: lib/browser.tcl:265
+msgid "Browse"
+msgstr ""
+
+#: lib/checkout_op.tcl:79
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr ""
+
+#: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
+msgid "Close"
+msgstr ""
+
+#: lib/checkout_op.tcl:169
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr ""
+
+#: lib/checkout_op.tcl:205
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr ""
+
+#: lib/checkout_op.tcl:219
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr ""
+
+#: lib/checkout_op.tcl:238
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr ""
+
+#: lib/checkout_op.tcl:250
+msgid "Index is already locked."
+msgstr ""
+
+#: lib/checkout_op.tcl:265
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before the current branch can be changed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+
+#: lib/checkout_op.tcl:352
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
+msgstr ""
+
+#: lib/checkout_op.tcl:353
+msgid "File level merge required."
+msgstr ""
+
+#: lib/checkout_op.tcl:357
+#, tcl-format
+msgid "Staying on branch '%s'."
+msgstr ""
+
+#: lib/checkout_op.tcl:426
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This Detached "
+"Checkout'."
+msgstr ""
+
+#: lib/checkout_op.tcl:475
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgstr ""
+
+#: lib/checkout_op.tcl:497
+msgid "Recovering lost commits may not be easy."
+msgstr ""
+
+#: lib/checkout_op.tcl:502
+#, tcl-format
+msgid "Reset '%s'?"
+msgstr ""
+
+#: lib/checkout_op.tcl:507 lib/merge.tcl:171
+msgid "Visualize"
+msgstr ""
+
+#: lib/checkout_op.tcl:575
+#, tcl-format
+msgid ""
+"Failed to set current branch.\n"
+"\n"
+"This working directory is only partially switched.  We successfully updated "
+"your files, but failed to update an internal Git file.\n"
+"\n"
+"This should not have occurred.  %s will now close and give up."
+msgstr ""
+
+#: lib/choose_rev.tcl:35
+msgid "This Detached Checkout"
+msgstr ""
+
+#: lib/choose_rev.tcl:42
+msgid "Revision Expression:"
+msgstr ""
+
+#: lib/choose_rev.tcl:56
+#, fuzzy
+msgid "Local Branch"
+msgstr "分支"
+
+#: lib/choose_rev.tcl:61
+#, fuzzy
+msgid "Tracking Branch"
+msgstr "当前分支:"
+
+#: lib/choose_rev.tcl:66
+msgid "Tag"
+msgstr ""
+
+#: lib/choose_rev.tcl:227
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr ""
+
+#: lib/choose_rev.tcl:248
+msgid "No revision selected."
+msgstr ""
+
+#: lib/choose_rev.tcl:256
+msgid "Revision expression is empty."
+msgstr ""
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit before this "
+"to amend.\n"
+msgstr ""
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort the "
+"current merge activity.\n"
+msgstr ""
+
+#: lib/commit.tcl:49
+msgid "Error loading commit data for amend:"
+msgstr ""
+
+#: lib/commit.tcl:76
+msgid "Unable to obtain your identity:"
+msgstr ""
+
+#: lib/commit.tcl:81
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr ""
+
+#: lib/commit.tcl:133
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+
+#: lib/commit.tcl:154
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and add the file before "
+"committing.\n"
+msgstr ""
+
+#: lib/commit.tcl:162
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+
+#: lib/commit.tcl:170
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must add at least 1 file before you can commit.\n"
+msgstr ""
+
+#: lib/commit.tcl:183
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentance what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
+msgstr ""
+
+#: lib/commit.tcl:257
+msgid "write-tree failed:"
+msgstr ""
+
+#: lib/commit.tcl:279
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+
+#: lib/commit.tcl:286
+msgid "No changes to commit."
+msgstr ""
+
+#: lib/commit.tcl:317
+msgid "commit-tree failed:"
+msgstr ""
+
+#: lib/commit.tcl:339
+msgid "update-ref failed:"
+msgstr ""
+
+#: lib/commit.tcl:430
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr ""
+
+#: lib/console.tcl:55
+msgid "Working... please wait..."
+msgstr ""
+
+#: lib/console.tcl:184
+msgid "Success"
+msgstr ""
+
+#: lib/console.tcl:194
+msgid "Error: Command Failed"
+msgstr ""
+
+#: lib/database.tcl:43
+msgid "Number of loose objects"
+msgstr ""
+
+#: lib/database.tcl:44
+msgid "Disk space used by loose objects"
+msgstr ""
+
+#: lib/database.tcl:45
+msgid "Number of packed objects"
+msgstr ""
+
+#: lib/database.tcl:46
+msgid "Number of packs"
+msgstr ""
+
+#: lib/database.tcl:47
+msgid "Disk space used by packed objects"
+msgstr ""
+
+#: lib/database.tcl:48
+msgid "Packed objects waiting for pruning"
+msgstr ""
+
+#: lib/database.tcl:49
+msgid "Garbage files"
+msgstr ""
+
+#: lib/database.tcl:72
+#, fuzzy
+msgid "Compressing the object database"
+msgstr "压缩数据库"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr ""
+
+#: lib/diff.tcl:42
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may have "
+"the same state."
+msgstr ""
+
+#: lib/diff.tcl:97
+msgid "Error loading file:"
+msgstr ""
+
+#: lib/diff.tcl:162
+msgid "Error loading diff:"
+msgstr ""
+
+#: lib/diff.tcl:278
+msgid "Failed to unstage selected hunk."
+msgstr ""
+
+#: lib/diff.tcl:285
+msgid "Failed to stage selected hunk."
+msgstr ""
+
+#: lib/error.tcl:12 lib/error.tcl:102
+msgid "error"
+msgstr ""
+
+#: lib/error.tcl:28
+msgid "warning"
+msgstr ""
+
+#: lib/error.tcl:81
+msgid "You must correct the above errors before committing."
+msgstr ""
+
+#: lib/index.tcl:364
+#, fuzzy, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "恢复修改"
+
+#: lib/index.tcl:366
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr ""
+
+#: lib/index.tcl:372
+msgid "Any unadded changes will be permanently lost by the revert."
+msgstr ""
+
+#: lib/index.tcl:375
+msgid "Do Nothing"
+msgstr ""
+
+#: lib/merge.tcl:14
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
+msgstr ""
+
+#: lib/merge.tcl:28
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+
+#: lib/merge.tcl:45
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, add the file, and commit to complete the current "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+
+#: lib/merge.tcl:55
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doing so "
+"will help you abort a failed merge, should the need arise.\n"
+msgstr ""
+
+#: lib/merge.tcl:94
+#, tcl-format
+msgid "Merging %s and %s"
+msgstr ""
+
+#: lib/merge.tcl:106
+msgid "Merge completed successfully."
+msgstr ""
+
+#: lib/merge.tcl:108
+msgid "Merge failed.  Conflict resolution is required."
+msgstr ""
+
+#: lib/merge.tcl:166
+#, tcl-format
+msgid "Merge Into %s"
+msgstr ""
+
+#: lib/merge.tcl:181 lib/transport.tcl:98
+#, fuzzy
+msgid "Source Branches"
+msgstr "当前分支:"
+
+#: lib/merge.tcl:240
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+
+#: lib/merge.tcl:250
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+
+#: lib/merge.tcl:256
+msgid ""
+"Abort commit?\n"
+"\n"
+"Aborting the current commit will cause *ALL* uncommitted changes to be "
+"lost.\n"
+"\n"
+"Continue with aborting the current commit?"
+msgstr ""
+
+#: lib/merge.tcl:267
+msgid "Aborting... please wait..."
+msgstr ""
+
+#: lib/merge.tcl:290
+msgid "Abort completed.  Ready."
+msgstr ""
+
+#: lib/option.tcl:77
+msgid "git-gui - a graphical user interface for Git."
+msgstr ""
+
+#: lib/option.tcl:164
+msgid "Restore Defaults"
+msgstr ""
+
+#: lib/option.tcl:168
+msgid "Save"
+msgstr ""
+
+#: lib/option.tcl:178
+#, fuzzy, tcl-format
+msgid "%s Repository"
+msgstr "版本树"
+
+#: lib/option.tcl:179
+msgid "Global (All Repositories)"
+msgstr ""
+
+#: lib/option.tcl:185
+msgid "User Name"
+msgstr ""
+
+#: lib/option.tcl:186
+msgid "Email Address"
+msgstr ""
+
+#: lib/option.tcl:188
+#, fuzzy
+msgid "Summarize Merge Commits"
+msgstr "修订合并提交描述:"
+
+#: lib/option.tcl:189
+msgid "Merge Verbosity"
+msgstr ""
+
+#: lib/option.tcl:190
+msgid "Show Diffstat After Merge"
+msgstr ""
+
+#: lib/option.tcl:192
+msgid "Trust File Modification Timestamps"
+msgstr ""
+
+#: lib/option.tcl:193
+msgid "Prune Tracking Branches During Fetch"
+msgstr ""
+
+#: lib/option.tcl:194
+msgid "Match Tracking Branches"
+msgstr ""
+
+#: lib/option.tcl:195
+msgid "Number of Diff Context Lines"
+msgstr ""
+
+#: lib/option.tcl:196
+msgid "New Branch Name Template"
+msgstr ""
+
+#: lib/option.tcl:305
+msgid "Failed to completely save options:"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
+msgid "Delete Remote Branch"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:47
+#, fuzzy
+msgid "From Repository"
+msgstr "版本树"
+
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:118
+msgid "Remote:"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:133
+msgid "Arbitrary URL:"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:84
+#, fuzzy
+msgid "Branches"
+msgstr "分支"
+
+#: lib/remote_branch_delete.tcl:109
+#, fuzzy
+msgid "Delete Only If"
+msgstr "删除"
+
+#: lib/remote_branch_delete.tcl:111
+msgid "Merged Into:"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:119
+msgid "Always (Do not perform merge checks)"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:152
+msgid "A branch is required for 'Merged Into'."
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:189
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched the "
+"necessary commits.  Try fetching from %s first."
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:207
+msgid "Please select one or more branches to delete."
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:216
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:226
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:286
+msgid "No repository selected."
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:291
+#, tcl-format
+msgid "Scanning %s..."
+msgstr ""
+
+#: lib/remote.tcl:156
+#, tcl-format
+msgid "Fetch from %s..."
+msgstr ""
+
+#: lib/remote.tcl:166
+#, tcl-format
+msgid "Prune from %s..."
+msgstr ""
+
+#: lib/remote.tcl:200
+#, fuzzy, tcl-format
+msgid "Push to %s..."
+msgstr "上传..."
+
+#: lib/shortcut.tcl:26 lib/shortcut.tcl:74
+msgid "Cannot write script:"
+msgstr ""
+
+#: lib/shortcut.tcl:149
+msgid "Cannot write icon:"
+msgstr ""
+
+#: lib/status_bar.tcl:58
+#, tcl-format
+msgid "%s ... %i of %i %s (%2i%%)"
+msgstr ""
+
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr ""
+
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr ""
+
+#: lib/transport.tcl:26
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr ""
+
+#: lib/transport.tcl:68
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr ""
+
+#: lib/transport.tcl:84
+#, fuzzy
+msgid "Push Branches"
+msgstr "分支"
+
+#: lib/transport.tcl:115
+#, fuzzy
+msgid "Destination Repository"
+msgstr "版本树"
+
+#: lib/transport.tcl:153
+msgid "Transfer Options"
+msgstr ""
+
+#: lib/transport.tcl:155
+msgid "Use thin pack (for slow network connections)"
+msgstr ""
+
+#: lib/transport.tcl:159
+msgid "Include tags"
+msgstr ""
-- 
1.5.3.2.g46909


--8323584-2108066760-1188750888=:28586--
