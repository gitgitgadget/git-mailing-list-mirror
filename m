From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 04/15] Add po/git-gui.pot
Date: Sun, 2 Sep 2007 17:31:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021730490.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:32:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsMZ-0004s1-5n
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757257AbXIBQbq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757237AbXIBQbq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:31:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:46974 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755673AbXIBQbo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:31:44 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:31:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 02 Sep 2007 18:31:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7EvVipSb7hlpWkOtFHg+Ndz7xp5nRFLtXNV1Ubx
	otfcUWxuttdTif
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57351>


Usually, generated files are not part of the tracked content in
a project.  However, translators may lack the tools to generate
git-gui.pot.  Besides, it is possible that a contributor does
not even check out the repository, but gets this file via gitweb.

Pointed out by Junio.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/git-gui.pot | 1264 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1264 insertions(+), 0 deletions(-)
 create mode 100644 po/git-gui.pot

diff --git a/po/git-gui.pot b/po/git-gui.pot
new file mode 100644
index 0000000..991efea
--- /dev/null
+++ b/po/git-gui.pot
@@ -0,0 +1,1264 @@
+# SOME DESCRIPTIVE TITLE.
+# Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
+# This file is distributed under the same license as the PACKAGE package.
+# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: PACKAGE VERSION\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-08-11 17:28+0200\n"
+"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
+"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
+"Language-Team: LANGUAGE <LL@li.org>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=CHARSET\n"
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
+#: git-gui.sh:854
+msgid "Refreshing file status..."
+msgstr ""
+
+#: git-gui.sh:891
+msgid "Scanning for modified files ..."
+msgstr ""
+
+#: git-gui.sh:1057 lib/browser.tcl:247
+msgid "Ready."
+msgstr ""
+
+#: git-gui.sh:1322
+msgid "Unmodified"
+msgstr ""
+
+#: git-gui.sh:1324
+msgid "Modified, not staged"
+msgstr ""
+
+#: git-gui.sh:1325 git-gui.sh:1330
+msgid "Staged for commit"
+msgstr ""
+
+#: git-gui.sh:1326 git-gui.sh:1331
+msgid "Portions staged for commit"
+msgstr ""
+
+#: git-gui.sh:1327 git-gui.sh:1332
+msgid "Staged for commit, missing"
+msgstr ""
+
+#: git-gui.sh:1329
+msgid "Untracked, not staged"
+msgstr ""
+
+#: git-gui.sh:1334
+msgid "Missing"
+msgstr ""
+
+#: git-gui.sh:1335
+msgid "Staged for removal"
+msgstr ""
+
+#: git-gui.sh:1336
+msgid "Staged for removal, still present"
+msgstr ""
+
+#: git-gui.sh:1338 git-gui.sh:1339 git-gui.sh:1340 git-gui.sh:1341
+msgid "Requires merge resolution"
+msgstr ""
+
+#: git-gui.sh:1383
+msgid "Starting gitk... please wait..."
+msgstr ""
+
+#: git-gui.sh:1392
+#, tcl-format
+msgid ""
+"Unable to start gitk:\n"
+"\n"
+"%s does not exist"
+msgstr ""
+
+#: git-gui.sh:1609
+#, tcl-format
+msgid "Invalid font specified in gui.%s:"
+msgstr ""
+
+#: git-gui.sh:1634
+msgid "Main Font"
+msgstr ""
+
+#: git-gui.sh:1635
+msgid "Diff/Console Font"
+msgstr ""
+
+#: git-gui.sh:1649
+msgid "Repository"
+msgstr ""
+
+#: git-gui.sh:1650
+msgid "Edit"
+msgstr ""
+
+#: git-gui.sh:1652
+msgid "Branch"
+msgstr ""
+
+#: git-gui.sh:1655 git-gui.sh:1842 git-gui.sh:2152
+msgid "Commit"
+msgstr ""
+
+#: git-gui.sh:1658 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+msgid "Merge"
+msgstr ""
+
+#: git-gui.sh:1659
+msgid "Fetch"
+msgstr ""
+
+#: git-gui.sh:1660 git-gui.sh:2158 lib/transport.tcl:88 lib/transport.tcl:172
+msgid "Push"
+msgstr ""
+
+#: git-gui.sh:1669
+msgid "Browse Current Branch's Files"
+msgstr ""
+
+#: git-gui.sh:1673
+msgid "Browse Branch Files..."
+msgstr ""
+
+#: git-gui.sh:1678
+msgid "Visualize Current Branch's History"
+msgstr ""
+
+#: git-gui.sh:1682
+msgid "Visualize All Branch History"
+msgstr ""
+
+#: git-gui.sh:1689
+#, tcl-format
+msgid "Browse %s's Files"
+msgstr ""
+
+#: git-gui.sh:1691
+#, tcl-format
+msgid "Visualize %s's History"
+msgstr ""
+
+#: git-gui.sh:1696 lib/database.tcl:27 lib/database.tcl:67
+msgid "Database Statistics"
+msgstr ""
+
+#: git-gui.sh:1699 lib/database.tcl:34
+msgid "Compress Database"
+msgstr ""
+
+#: git-gui.sh:1702
+msgid "Verify Database"
+msgstr ""
+
+#: git-gui.sh:1709 git-gui.sh:1713 git-gui.sh:1717 lib/shortcut.tcl:9
+#: lib/shortcut.tcl:45 lib/shortcut.tcl:84
+msgid "Create Desktop Icon"
+msgstr ""
+
+#: git-gui.sh:1722
+msgid "Quit"
+msgstr ""
+
+#: git-gui.sh:1729
+msgid "Undo"
+msgstr ""
+
+#: git-gui.sh:1732
+msgid "Redo"
+msgstr ""
+
+#: git-gui.sh:1736 git-gui.sh:2222
+msgid "Cut"
+msgstr ""
+
+#: git-gui.sh:1739 git-gui.sh:2225 git-gui.sh:2296 git-gui.sh:2368
+#: lib/console.tcl:69
+msgid "Copy"
+msgstr ""
+
+#: git-gui.sh:1742 git-gui.sh:2228
+msgid "Paste"
+msgstr ""
+
+#: git-gui.sh:1745 git-gui.sh:2231 lib/branch_delete.tcl:26
+#: lib/remote_branch_delete.tcl:38
+msgid "Delete"
+msgstr ""
+
+#: git-gui.sh:1749 git-gui.sh:2235 git-gui.sh:2372 lib/console.tcl:71
+msgid "Select All"
+msgstr ""
+
+#: git-gui.sh:1758
+msgid "Create..."
+msgstr ""
+
+#: git-gui.sh:1764
+msgid "Checkout..."
+msgstr ""
+
+#: git-gui.sh:1770
+msgid "Rename..."
+msgstr ""
+
+#: git-gui.sh:1775 git-gui.sh:1873
+msgid "Delete..."
+msgstr ""
+
+#: git-gui.sh:1780
+msgid "Reset..."
+msgstr ""
+
+#: git-gui.sh:1792 git-gui.sh:2169
+msgid "New Commit"
+msgstr ""
+
+#: git-gui.sh:1800 git-gui.sh:2176
+msgid "Amend Last Commit"
+msgstr ""
+
+#: git-gui.sh:1809 git-gui.sh:2136 lib/remote_branch_delete.tcl:99
+msgid "Rescan"
+msgstr ""
+
+#: git-gui.sh:1815
+msgid "Stage To Commit"
+msgstr ""
+
+#: git-gui.sh:1820
+msgid "Stage Changed Files To Commit"
+msgstr ""
+
+#: git-gui.sh:1826
+msgid "Unstage From Commit"
+msgstr ""
+
+#: git-gui.sh:1831 lib/index.tcl:376
+msgid "Revert Changes"
+msgstr ""
+
+#: git-gui.sh:1838 git-gui.sh:2148 git-gui.sh:2246
+msgid "Sign Off"
+msgstr ""
+
+#: git-gui.sh:1853
+msgid "Local Merge..."
+msgstr ""
+
+#: git-gui.sh:1858
+msgid "Abort Merge..."
+msgstr ""
+
+#: git-gui.sh:1870
+msgid "Push..."
+msgstr ""
+
+#: git-gui.sh:1880
+msgid "Apple"
+msgstr ""
+
+#: git-gui.sh:1883 git-gui.sh:1901 lib/option.tcl:65
+#, tcl-format
+msgid "About %s"
+msgstr ""
+
+#: git-gui.sh:1885 git-gui.sh:1891 git-gui.sh:2414
+msgid "Options..."
+msgstr ""
+
+#: git-gui.sh:1897
+msgid "Help"
+msgstr ""
+
+#: git-gui.sh:1938
+msgid "Online Documentation"
+msgstr ""
+
+#: git-gui.sh:2054
+msgid "Current Branch:"
+msgstr ""
+
+#: git-gui.sh:2075
+msgid "Staged Changes (Will Be Committed)"
+msgstr ""
+
+#: git-gui.sh:2095
+msgid "Unstaged Changes (Will Not Be Committed)"
+msgstr ""
+
+#: git-gui.sh:2142
+msgid "Stage Changed"
+msgstr ""
+
+#: git-gui.sh:2188
+msgid "Initial Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2189
+msgid "Amended Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2190
+msgid "Amended Initial Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2191
+msgid "Amended Merge Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2192
+msgid "Merge Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2193
+msgid "Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2238 git-gui.sh:2376 lib/console.tcl:73
+msgid "Copy All"
+msgstr ""
+
+#: git-gui.sh:2262 lib/blame.tcl:104
+msgid "File:"
+msgstr ""
+
+#: git-gui.sh:2364
+msgid "Refresh"
+msgstr ""
+
+#: git-gui.sh:2385
+msgid "Apply/Reverse Hunk"
+msgstr ""
+
+#: git-gui.sh:2391
+msgid "Decrease Font Size"
+msgstr ""
+
+#: git-gui.sh:2395
+msgid "Increase Font Size"
+msgstr ""
+
+#: git-gui.sh:2400
+msgid "Show Less Context"
+msgstr ""
+
+#: git-gui.sh:2407
+msgid "Show More Context"
+msgstr ""
+
+#: git-gui.sh:2422
+msgid "Unstage Hunk From Commit"
+msgstr ""
+
+#: git-gui.sh:2426 git-gui.sh:2430
+msgid "Stage Hunk For Commit"
+msgstr ""
+
+#: git-gui.sh:2440
+msgid "Initializing..."
+msgstr ""
+
+#: lib/blame.tcl:77
+msgid "File Viewer"
+msgstr ""
+
+#: lib/blame.tcl:81
+msgid "Commit:"
+msgstr ""
+
+#: lib/blame.tcl:249
+msgid "Copy Commit"
+msgstr ""
+
+#: lib/blame.tcl:369
+#, tcl-format
+msgid "Reading %s..."
+msgstr ""
+
+#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+msgid "Checkout Branch"
+msgstr ""
+
+#: lib/branch_checkout.tcl:23
+msgid "Checkout"
+msgstr ""
+
+#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
+#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:283
+#: lib/checkout_op.tcl:522 lib/merge.tcl:172 lib/option.tcl:172
+#: lib/remote_branch_delete.tcl:42 lib/transport.tcl:92
+msgid "Cancel"
+msgstr ""
+
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:288
+msgid "Revision"
+msgstr ""
+
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:159
+#: lib/option.tcl:274
+msgid "Options"
+msgstr ""
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
+msgid "Create Branch"
+msgstr ""
+
+#: lib/branch_create.tcl:27
+msgid "Create New Branch"
+msgstr ""
+
+#: lib/branch_create.tcl:31
+msgid "Create"
+msgstr ""
+
+#: lib/branch_create.tcl:40
+msgid "Branch Name"
+msgstr ""
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
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:514
+msgid "Reset"
+msgstr ""
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
+msgid "Delete Branch"
+msgstr ""
+
+#: lib/branch_delete.tcl:20
+msgid "Delete Local Branch"
+msgstr ""
+
+#: lib/branch_delete.tcl:37
+msgid "Local Branches"
+msgstr ""
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
+msgid "Rename Branch"
+msgstr ""
+
+#: lib/branch_rename.tcl:26
+msgid "Rename"
+msgstr ""
+
+#: lib/branch_rename.tcl:36
+msgid "Branch:"
+msgstr ""
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
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr ""
+
+#: lib/browser.tcl:26
+msgid "File Browser"
+msgstr ""
+
+#: lib/browser.tcl:127 lib/browser.tcl:144
+#, tcl-format
+msgid "Loading %s..."
+msgstr ""
+
+#: lib/browser.tcl:188
+msgid "[Up To Parent]"
+msgstr ""
+
+#: lib/browser.tcl:268 lib/browser.tcl:274
+msgid "Browse Branch Files"
+msgstr ""
+
+#: lib/browser.tcl:279
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
+#: lib/checkout_op.tcl:206
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr ""
+
+#: lib/checkout_op.tcl:220
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr ""
+
+#: lib/checkout_op.tcl:239
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr ""
+
+#: lib/checkout_op.tcl:251
+msgid "Staging area (index) is already locked."
+msgstr ""
+
+#: lib/checkout_op.tcl:266
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before the current branch can be changed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+
+#: lib/checkout_op.tcl:353
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
+msgstr ""
+
+#: lib/checkout_op.tcl:354
+msgid "File level merge required."
+msgstr ""
+
+#: lib/checkout_op.tcl:358
+#, tcl-format
+msgid "Staying on branch '%s'."
+msgstr ""
+
+#: lib/checkout_op.tcl:429
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This Detached "
+"Checkout'."
+msgstr ""
+
+#: lib/checkout_op.tcl:478
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgstr ""
+
+#: lib/checkout_op.tcl:500
+msgid "Recovering lost commits may not be easy."
+msgstr ""
+
+#: lib/checkout_op.tcl:505
+#, tcl-format
+msgid "Reset '%s'?"
+msgstr ""
+
+#: lib/checkout_op.tcl:510 lib/merge.tcl:164
+msgid "Visualize"
+msgstr ""
+
+#: lib/checkout_op.tcl:578
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
+#: lib/choose_rev.tcl:53
+msgid "This Detached Checkout"
+msgstr ""
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr ""
+
+#: lib/choose_rev.tcl:74
+msgid "Local Branch"
+msgstr ""
+
+#: lib/choose_rev.tcl:79
+msgid "Tracking Branch"
+msgstr ""
+
+#: lib/choose_rev.tcl:84
+msgid "Tag"
+msgstr ""
+
+#: lib/choose_rev.tcl:317
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr ""
+
+#: lib/choose_rev.tcl:338
+msgid "No revision selected."
+msgstr ""
+
+#: lib/choose_rev.tcl:346
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
+"File %s has merge conflicts.  You must resolve them and stage the file "
+"before committing.\n"
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
+"You must stage at least 1 file before you can commit.\n"
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
+msgid "Compressing the object database"
+msgstr ""
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
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr ""
+
+#: lib/index.tcl:366
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr ""
+
+#: lib/index.tcl:372
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr ""
+
+#: lib/index.tcl:375
+msgid "Do Nothing"
+msgstr ""
+
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
+msgstr ""
+
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+
+#: lib/merge.tcl:44
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the current "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+
+#: lib/merge.tcl:54
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
+#: lib/merge.tcl:106
+#, tcl-format
+msgid "%s of %s"
+msgstr ""
+
+#: lib/merge.tcl:119
+#, tcl-format
+msgid "Merging %s and %s"
+msgstr ""
+
+#: lib/merge.tcl:131
+msgid "Merge completed successfully."
+msgstr ""
+
+#: lib/merge.tcl:133
+msgid "Merge failed.  Conflict resolution is required."
+msgstr ""
+
+#: lib/merge.tcl:158
+#, tcl-format
+msgid "Merge Into %s"
+msgstr ""
+
+#: lib/merge.tcl:177
+msgid "Revision To Merge"
+msgstr ""
+
+#: lib/merge.tcl:212
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+
+#: lib/merge.tcl:222
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+
+#: lib/merge.tcl:228
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr ""
+
+#: lib/merge.tcl:239
+msgid "Aborting"
+msgstr ""
+
+#: lib/merge.tcl:266
+msgid "Abort failed."
+msgstr ""
+
+#: lib/merge.tcl:268
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
+#, tcl-format
+msgid "%s Repository"
+msgstr ""
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
+msgid "Summarize Merge Commits"
+msgstr ""
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
+msgid "From Repository"
+msgstr ""
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
+msgid "Branches"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:109
+msgid "Delete Only If"
+msgstr ""
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
+#: lib/remote.tcl:162
+#, tcl-format
+msgid "Fetch from %s..."
+msgstr ""
+
+#: lib/remote.tcl:172
+#, tcl-format
+msgid "Prune from %s..."
+msgstr ""
+
+#: lib/remote.tcl:206
+#, tcl-format
+msgid "Push to %s..."
+msgstr ""
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
+msgid "Push Branches"
+msgstr ""
+
+#: lib/transport.tcl:98
+msgid "Source Branches"
+msgstr ""
+
+#: lib/transport.tcl:115
+msgid "Destination Repository"
+msgstr ""
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
