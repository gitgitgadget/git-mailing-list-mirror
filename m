From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 10/15] Japanese translation of git-gui
Date: Sun, 2 Sep 2007 17:35:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021735210.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1067707744-1188750933=:28586"
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:36:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsQS-0005ib-4q
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933260AbXIBQfq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933229AbXIBQfq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:35:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:55569 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933051AbXIBQfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:35:45 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:35:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 02 Sep 2007 18:35:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/c1IYBVRDc/JYjphvIGPHGfLoDd8xBrdpOyfQ+mg
	fbl/LQVL4nmwI/
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57358>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1067707744-1188750933=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= <nanako3@bluebottle.com>

[jes: Also includes work from Junio Hamano]

Signed-off-by: しらいしななこ <nanako3@bluebottle.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/ja.po | 1381 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1381 insertions(+), 0 deletions(-)
 create mode 100644 po/ja.po

diff --git a/po/ja.po b/po/ja.po
new file mode 100644
index 0000000..1713908
--- /dev/null
+++ b/po/ja.po
@@ -0,0 +1,1381 @@
+# Translation of git-gui to Japanese
+# Copyright (C) 2007 Shawn Pearce
+# This file is distributed under the same license as the git-gui package.
+# しらいし ななこ <nanako3@bluebottle.com>, 2007.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-08-11 17:28+0200\n"
+"PO-Revision-Date: 2007-08-14 18:49+0900\n"
+"Last-Translator: しらいし ななこ <nanako3@bluebottle.com>\n"
+"Language-Team: Japanese\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: git-gui.sh:531
+msgid "Cannot find git in PATH."
+msgstr "PATH 中に git が見つかりません"
+
+#: git-gui.sh:550
+msgid "Cannot parse Git version string:"
+msgstr "Git バージョン名が理解できません:"
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
+"Git のバージョンが確認できません。\n"
+"\n"
+"%s はバージョン '%s' とのことです。\n"
+"\n"
+"%s は最低でも 1.5.0 かそれ以降の Git が必要です\n"
+"\n"
+"'%s' はバージョン 1.5.0 と思って良いですか？\n"
+
+#: git-gui.sh:689
+msgid "Cannot find the git directory:"
+msgstr "git ディレクトリが見つかりません:"
+
+#: git-gui.sh:697
+msgid "Git directory not found:"
+msgstr "Git ディレクトリが見つかりません:"
+
+#: git-gui.sh:703
+msgid "Cannot use funny .git directory:"
+msgstr "変な .git ディレクトリは使えません"
+
+#: git-gui.sh:708
+msgid "No working directory"
+msgstr "作業ディレクトリがありません"
+
+#: git-gui.sh:854
+msgid "Refreshing file status..."
+msgstr "ファイル状態を更新しています…"
+
+#: git-gui.sh:891
+msgid "Scanning for modified files ..."
+msgstr "変更されたファイルをスキャンしています…"
+
+#: git-gui.sh:1057 lib/browser.tcl:247
+msgid "Ready."
+msgstr "準備完了"
+
+#: git-gui.sh:1322
+msgid "Unmodified"
+msgstr "変更無し"
+
+#: git-gui.sh:1324
+msgid "Modified, not staged"
+msgstr "変更あり、コミット未予定"
+
+#: git-gui.sh:1325 git-gui.sh:1330
+msgid "Staged for commit"
+msgstr "コミット予定済"
+
+#: git-gui.sh:1326 git-gui.sh:1331
+msgid "Portions staged for commit"
+msgstr "部分的にコミット予定済"
+
+#: git-gui.sh:1327 git-gui.sh:1332
+msgid "Staged for commit, missing"
+msgstr "コミット予定済、ファイル無し"
+
+#: git-gui.sh:1329
+msgid "Untracked, not staged"
+msgstr "管理外、コミット未予定"
+
+#: git-gui.sh:1334
+msgid "Missing"
+msgstr "ファイル無し"
+
+#: git-gui.sh:1335
+msgid "Staged for removal"
+msgstr "削除予定済"
+
+#: git-gui.sh:1336
+msgid "Staged for removal, still present"
+msgstr "削除予定済、ファイル未削除"
+
+#: git-gui.sh:1338 git-gui.sh:1339 git-gui.sh:1340 git-gui.sh:1341
+msgid "Requires merge resolution"
+msgstr "要マージ解決"
+
+#: git-gui.sh:1383
+msgid "Starting gitk... please wait..."
+msgstr "gitk を起動中…お待ち下さい…"
+
+#: git-gui.sh:1392
+#, tcl-format
+msgid ""
+"Unable to start gitk:\n"
+"\n"
+"%s does not exist"
+msgstr ""
+"gitk を起動できません:\n"
+"\n"
+"%s がありません"
+
+#: git-gui.sh:1609
+#, tcl-format
+msgid "Invalid font specified in gui.%s:"
+msgstr "gui.%s に無効なフォントが指定されています:"
+
+#: git-gui.sh:1634
+msgid "Main Font"
+msgstr "主フォント"
+
+#: git-gui.sh:1635
+msgid "Diff/Console Font"
+msgstr "diff/コンソール・フォント"
+
+#: git-gui.sh:1649
+msgid "Repository"
+msgstr "リポジトリ"
+
+#: git-gui.sh:1650
+msgid "Edit"
+msgstr "編集"
+
+#: git-gui.sh:1652
+msgid "Branch"
+msgstr "ブランチ"
+
+#: git-gui.sh:1655 git-gui.sh:1842 git-gui.sh:2152
+msgid "Commit"
+msgstr "コミット"
+
+#: git-gui.sh:1658 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+msgid "Merge"
+msgstr "マージ"
+
+#: git-gui.sh:1659
+msgid "Fetch"
+msgstr "フェッチ"
+
+#: git-gui.sh:1660 git-gui.sh:2158 lib/transport.tcl:88 lib/transport.tcl:172
+msgid "Push"
+msgstr "プッシュ"
+
+#: git-gui.sh:1669
+msgid "Browse Current Branch's Files"
+msgstr "現在のブランチのファイルを見る"
+
+#: git-gui.sh:1673
+msgid "Browse Branch Files..."
+msgstr "ブランチのファイルを見る…"
+
+#: git-gui.sh:1678
+msgid "Visualize Current Branch's History"
+msgstr "現在のブランチの履歴を見る"
+
+#: git-gui.sh:1682
+msgid "Visualize All Branch History"
+msgstr "全てのブランチの履歴を見る"
+
+#: git-gui.sh:1689
+#, tcl-format
+msgid "Browse %s's Files"
+msgstr "ブランチ %s のファイルを見る"
+
+#: git-gui.sh:1691
+#, tcl-format
+msgid "Visualize %s's History"
+msgstr "ブランチ %s の履歴を見る"
+
+#: git-gui.sh:1696 lib/database.tcl:27 lib/database.tcl:67
+msgid "Database Statistics"
+msgstr "データベース統計"
+
+#: git-gui.sh:1699 lib/database.tcl:34
+msgid "Compress Database"
+msgstr "データベース圧縮"
+
+#: git-gui.sh:1702
+msgid "Verify Database"
+msgstr "データベース検証"
+
+#: git-gui.sh:1709 git-gui.sh:1713 git-gui.sh:1717 lib/shortcut.tcl:9
+#: lib/shortcut.tcl:45 lib/shortcut.tcl:84
+msgid "Create Desktop Icon"
+msgstr "デスクトップ・アイコンを作る"
+
+#: git-gui.sh:1722
+msgid "Quit"
+msgstr "終了"
+
+#: git-gui.sh:1729
+msgid "Undo"
+msgstr "元に戻す"
+
+#: git-gui.sh:1732
+msgid "Redo"
+msgstr "やり直し"
+
+#: git-gui.sh:1736 git-gui.sh:2222
+msgid "Cut"
+msgstr "切り取り"
+
+#: git-gui.sh:1739 git-gui.sh:2225 git-gui.sh:2296 git-gui.sh:2368
+#: lib/console.tcl:69
+msgid "Copy"
+msgstr "コピー"
+
+#: git-gui.sh:1742 git-gui.sh:2228
+msgid "Paste"
+msgstr "貼り付け"
+
+#: git-gui.sh:1745 git-gui.sh:2231 lib/branch_delete.tcl:26
+#: lib/remote_branch_delete.tcl:38
+msgid "Delete"
+msgstr "削除"
+
+#: git-gui.sh:1749 git-gui.sh:2235 git-gui.sh:2372 lib/console.tcl:71
+msgid "Select All"
+msgstr "全て選択"
+
+#: git-gui.sh:1758
+msgid "Create..."
+msgstr "作成…"
+
+#: git-gui.sh:1764
+msgid "Checkout..."
+msgstr "チェックアウト"
+
+#: git-gui.sh:1770
+msgid "Rename..."
+msgstr "名前変更…"
+
+#: git-gui.sh:1775 git-gui.sh:1873
+msgid "Delete..."
+msgstr "削除…"
+
+#: git-gui.sh:1780
+msgid "Reset..."
+msgstr "リセット…"
+
+#: git-gui.sh:1792 git-gui.sh:2169
+msgid "New Commit"
+msgstr "新規コミット"
+
+#: git-gui.sh:1800 git-gui.sh:2176
+msgid "Amend Last Commit"
+msgstr "最新コミットを訂正"
+
+#: git-gui.sh:1809 git-gui.sh:2136 lib/remote_branch_delete.tcl:99
+msgid "Rescan"
+msgstr "再スキャン"
+
+#: git-gui.sh:1815
+msgid "Stage To Commit"
+msgstr "コミット予定する"
+
+#: git-gui.sh:1820
+msgid "Stage Changed Files To Commit"
+msgstr "変更されたファイルをコミット予定"
+
+#: git-gui.sh:1826
+msgid "Unstage From Commit"
+msgstr "コミットから降ろす"
+
+#: git-gui.sh:1831 lib/index.tcl:376
+msgid "Revert Changes"
+msgstr "変更を元に戻す"
+
+#: git-gui.sh:1838 git-gui.sh:2148 git-gui.sh:2246
+msgid "Sign Off"
+msgstr "署名"
+
+#: git-gui.sh:1853
+msgid "Local Merge..."
+msgstr "ローカル・マージ…"
+
+#: git-gui.sh:1858
+msgid "Abort Merge..."
+msgstr "マージ中止…"
+
+#: git-gui.sh:1870
+msgid "Push..."
+msgstr "プッシュ…"
+
+#: git-gui.sh:1880
+msgid "Apple"
+msgstr "りんご"
+
+#: git-gui.sh:1883 git-gui.sh:1901 lib/option.tcl:65
+#, tcl-format
+msgid "About %s"
+msgstr "%s について"
+
+#: git-gui.sh:1885 git-gui.sh:1891 git-gui.sh:2414
+msgid "Options..."
+msgstr "オプション…"
+
+#: git-gui.sh:1897
+msgid "Help"
+msgstr "ヘルプ"
+
+#: git-gui.sh:1938
+msgid "Online Documentation"
+msgstr "オンライン・ドキュメント"
+
+#: git-gui.sh:2054
+msgid "Current Branch:"
+msgstr "現在のブランチ"
+
+#: git-gui.sh:2075
+msgid "Staged Changes (Will Be Committed)"
+msgstr "ステージングされた（コミット予定済の）変更"
+
+#: git-gui.sh:2095
+msgid "Unstaged Changes (Will Not Be Committed)"
+msgstr "ステージングされていない（コミット未予定の）変更"
+
+#: git-gui.sh:2142
+msgid "Stage Changed"
+msgstr "変更をコミット予定に入れる"
+
+#: git-gui.sh:2188
+msgid "Initial Commit Message:"
+msgstr "最初のコミットメッセージ:"
+
+#: git-gui.sh:2189
+msgid "Amended Commit Message:"
+msgstr "訂正したコミットメッセージ:"
+
+#: git-gui.sh:2190
+msgid "Amended Initial Commit Message:"
+msgstr "訂正した最初のコミットメッセージ:"
+
+#: git-gui.sh:2191
+msgid "Amended Merge Commit Message:"
+msgstr "訂正したマージコミットメッセージ:"
+
+#: git-gui.sh:2192
+msgid "Merge Commit Message:"
+msgstr "マージコミットメッセージ:"
+
+#: git-gui.sh:2193
+msgid "Commit Message:"
+msgstr "コミットメッセージ:"
+
+#: git-gui.sh:2238 git-gui.sh:2376 lib/console.tcl:73
+msgid "Copy All"
+msgstr "全てコピー"
+
+#: git-gui.sh:2262 lib/blame.tcl:104
+msgid "File:"
+msgstr "ファイル:"
+
+#: git-gui.sh:2364
+msgid "Refresh"
+msgstr "再読み込み"
+
+#: git-gui.sh:2385
+msgid "Apply/Reverse Hunk"
+msgstr "パッチを適用/取り消す"
+
+#: git-gui.sh:2391
+msgid "Decrease Font Size"
+msgstr "フォントを小さく"
+
+#: git-gui.sh:2395
+msgid "Increase Font Size"
+msgstr "フォントを大きく"
+
+#: git-gui.sh:2400
+msgid "Show Less Context"
+msgstr "文脈を少なく"
+
+#: git-gui.sh:2407
+msgid "Show More Context"
+msgstr "文脈を多く"
+
+#: git-gui.sh:2422
+msgid "Unstage Hunk From Commit"
+msgstr "パッチをコミット予定から外す"
+
+#: git-gui.sh:2426 git-gui.sh:2430
+msgid "Stage Hunk For Commit"
+msgstr "パッチをコミット予定に加える"
+
+#: git-gui.sh:2440
+msgid "Initializing..."
+msgstr "初期化しています…"
+
+#: lib/blame.tcl:77
+msgid "File Viewer"
+msgstr "ファイルピューワ"
+
+#: lib/blame.tcl:81
+msgid "Commit:"
+msgstr "コミット:"
+
+#: lib/blame.tcl:249
+msgid "Copy Commit"
+msgstr "コミットをコピー"
+
+#: lib/blame.tcl:369
+#, tcl-format
+msgid "Reading %s..."
+msgstr "%s を読んでいます…"
+
+#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+msgid "Checkout Branch"
+msgstr "ブランチをチェックアウト"
+
+#: lib/branch_checkout.tcl:23
+msgid "Checkout"
+msgstr "チェックアウト"
+
+#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
+#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:283
+#: lib/checkout_op.tcl:522 lib/merge.tcl:172 lib/option.tcl:172
+#: lib/remote_branch_delete.tcl:42 lib/transport.tcl:92
+msgid "Cancel"
+msgstr "中止"
+
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:288
+msgid "Revision"
+msgstr "リビジョン"
+
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:159
+#: lib/option.tcl:274
+msgid "Options"
+msgstr "オプション"
+
+#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "トラッキング・ブランチをフェッチ"
+
+#: lib/branch_checkout.tcl:44
+msgid "Detach From Local Branch"
+msgstr "ローカル・ブランチから削除"
+
+#: lib/branch_create.tcl:22
+msgid "Create Branch"
+msgstr "ブランチを作成"
+
+#: lib/branch_create.tcl:27
+msgid "Create New Branch"
+msgstr "ブランチを新規作成"
+
+#: lib/branch_create.tcl:31
+msgid "Create"
+msgstr "作成"
+
+#: lib/branch_create.tcl:40
+msgid "Branch Name"
+msgstr "ブランチ名"
+
+#: lib/branch_create.tcl:43
+msgid "Name:"
+msgstr "名前:"
+
+#: lib/branch_create.tcl:58
+msgid "Match Tracking Branch Name"
+msgstr "トラッキング・ブランチ名を合わせる"
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "初期リビジョン"
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "既存のブランチを更新:"
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "いいえ"
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "早送りのみ"
+
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:514
+msgid "Reset"
+msgstr "リセット"
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "作成してすぐチェックアウト"
+
+#: lib/branch_create.tcl:131
+msgid "Please select a tracking branch."
+msgstr "トラッキング・ブランチを選択して下さい。"
+
+#: lib/branch_create.tcl:140
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "トラッキング・ブランチ %s は遠隔リポジトリのブランチではありません。"
+
+#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
+msgid "Please supply a branch name."
+msgstr "ブランチ名を指定して下さい。"
+
+#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "'%s' はブランチ名に使えません。"
+
+#: lib/branch_delete.tcl:15
+msgid "Delete Branch"
+msgstr "ブランチ削除"
+
+#: lib/branch_delete.tcl:20
+msgid "Delete Local Branch"
+msgstr "ローカル・ブランチを削除"
+
+#: lib/branch_delete.tcl:37
+msgid "Local Branches"
+msgstr "ローカル・ブランチ"
+
+#: lib/branch_delete.tcl:52
+msgid "Delete Only If Merged Into"
+msgstr "マージ済みの時のみ削除"
+
+#: lib/branch_delete.tcl:54
+msgid "Always (Do not perform merge test.)"
+msgstr "無条件(マージテストしない)"
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr "以下のブランチは %s に完全にマージされていません:"
+
+#: lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult. \n"
+"\n"
+" Delete the selected branches?"
+msgstr ""
+"ブランチを削除すると元に戻すのは困難です。 \n"
+"\n"
+" 選択したブランチを削除しますか？"
+
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"以下のブランチを削除できません:\n"
+"%s"
+
+#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
+msgid "Rename Branch"
+msgstr "ブランチの名前変更"
+
+#: lib/branch_rename.tcl:26
+msgid "Rename"
+msgstr "名前変更"
+
+#: lib/branch_rename.tcl:36
+msgid "Branch:"
+msgstr "ブランチ:"
+
+#: lib/branch_rename.tcl:39
+msgid "New Name:"
+msgstr "新しい名前:"
+
+#: lib/branch_rename.tcl:75
+msgid "Please select a branch to rename."
+msgstr "名前を変更するブランチを選んで下さい。"
+
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "'%s'というブランチは既に存在します。"
+
+#: lib/branch_rename.tcl:117
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "'%s'の名前変更に失敗しました。"
+
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "起動中…"
+
+#: lib/browser.tcl:26
+msgid "File Browser"
+msgstr "ファイル・ブラウザ"
+
+#: lib/browser.tcl:127 lib/browser.tcl:144
+#, tcl-format
+msgid "Loading %s..."
+msgstr "%s をロード中…"
+
+#: lib/browser.tcl:188
+msgid "[Up To Parent]"
+msgstr "[上位フォルダへ]"
+
+#: lib/browser.tcl:268 lib/browser.tcl:274
+msgid "Browse Branch Files"
+msgstr "現在のブランチのファイルを見る"
+
+#: lib/browser.tcl:279
+msgid "Browse"
+msgstr "ブラウズ"
+
+#: lib/checkout_op.tcl:79
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "%s から %s をフェッチしています"
+
+#: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
+msgid "Close"
+msgstr "閉じる"
+
+#: lib/checkout_op.tcl:169
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr "ブランチ'%s'は存在しません。"
+
+#: lib/checkout_op.tcl:206
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr ""
+"ブランチ '%s' は既に存在します。\n"
+"\n"
+"%s に早送りできません。\n"
+"マージが必要です。"
+
+#: lib/checkout_op.tcl:220
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr "'%s' マージ戦略はサポートされていません。"
+
+#: lib/checkout_op.tcl:239
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr "'%s' の更新に失敗しました。"
+
+#: lib/checkout_op.tcl:251
+msgid "Staging area (index) is already locked."
+msgstr "インデックスは既にロックされています。"
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
+"最後にスキャンした状態はリポジトリの状態と合致しません。\n"
+"\n"
+"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。現在"
+"のブランチを変更する前に、再スキャンが必要です。\n"
+"\n"
+"自動的に再スキャンを開始します。\n"
+
+#: lib/checkout_op.tcl:353
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
+msgstr "'%s' のチェックアウトを中止しました（ファイル毎のマージが必要です）。"
+
+#: lib/checkout_op.tcl:354
+msgid "File level merge required."
+msgstr "ファイル毎のマージが必要です。"
+
+#: lib/checkout_op.tcl:358
+#, tcl-format
+msgid "Staying on branch '%s'."
+msgstr "ブランチ '%s' に滞まります。"
+
+#: lib/checkout_op.tcl:429
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This Detached "
+"Checkout'."
+msgstr ""
+"ローカル・ブランチから離れます。\n"
+"\n"
+"ブランチ上に滞まりたいときは、この「分離されたチェックアウト」から新規ブラン"
+"チを開始してください。"
+
+#: lib/checkout_op.tcl:478
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgstr "'%s' を '%s' にリセットすると、以下のコミットが失なわれます:"
+
+#: lib/checkout_op.tcl:500
+msgid "Recovering lost commits may not be easy."
+msgstr "失なわれたコミットを回復するのは簡単ではありません。"
+
+#: lib/checkout_op.tcl:505
+#, tcl-format
+msgid "Reset '%s'?"
+msgstr "'%s' をリセットしますか？"
+
+#: lib/checkout_op.tcl:510 lib/merge.tcl:164
+msgid "Visualize"
+msgstr "可視化"
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
+"現在のブランチを設定できません。\n"
+"\n"
+"作業ディレクトリは部分的にしか切り替わっていません。ファイルの更新には成功し"
+"ましたが、 Git の内部データを更新できませんでした。\n"
+"起こるはずのないエラーです。あきらめて %s を終了します。"
+
+#: lib/choose_rev.tcl:53
+msgid "This Detached Checkout"
+msgstr "分離されたチェックアウト"
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "リビジョン式:"
+
+#: lib/choose_rev.tcl:74
+msgid "Local Branch"
+msgstr "ローカル・ブランチ"
+
+#: lib/choose_rev.tcl:79
+msgid "Tracking Branch"
+msgstr "トラッキング・ブランチ"
+
+#: lib/choose_rev.tcl:84
+msgid "Tag"
+msgstr "タグ"
+
+#: lib/choose_rev.tcl:317
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "無効なリビジョン: %s"
+
+#: lib/choose_rev.tcl:338
+msgid "No revision selected."
+msgstr "リビジョンが未選択です。"
+
+#: lib/choose_rev.tcl:346
+msgid "Revision expression is empty."
+msgstr "リビジョン式が空です。"
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit before this "
+"to amend.\n"
+msgstr ""
+"訂正するコミットがそもそもありません。\n"
+"\n"
+"これから作るのは最初のコミットです。その前にはまだ訂正するようなコミットはあ"
+"りません。\n"
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort the "
+"current merge activity.\n"
+msgstr ""
+"マージ中にコミットの訂正はできません。\n"
+"\n"
+"現在はまだマージの途中です。先にこのマージを中止しないと、前のコミットの訂正"
+"はできません\n"
+
+#: lib/commit.tcl:49
+msgid "Error loading commit data for amend:"
+msgstr "訂正するコミットのデータを読めません:"
+
+#: lib/commit.tcl:76
+msgid "Unable to obtain your identity:"
+msgstr "ユーザの正体を確認できません:"
+
+#: lib/commit.tcl:81
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "GIT_COMMITTER_IDENT が無効です:"
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
+"最後にスキャンした状態はリポジトリの状態と合致しません。\n"
+"\n"
+"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。新し"
+"くコミットする前に、再スキャンが必要です。\n"
+"\n"
+"自動的に再スキャンを開始します。\n"
+
+#: lib/commit.tcl:154
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the file "
+"before committing.\n"
+msgstr ""
+"マージしていないファイルはコミットできません。\n"
+"\n"
+"ファイル %s にはマージ衝突が残っています。まず解決してコミット予定に加える必"
+"要があります。\n"
+
+#: lib/commit.tcl:162
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"不明なファイル状態 %s です。\n"
+"\n"
+"ファイル %s は本プログラムではコミットできません。\n"
+
+#: lib/commit.tcl:170
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"コミットする変更がありません。\n"
+"\n"
+"最低一つの変更をコミット予定に加えてからコミットして下さい。\n"
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
+"コミット・メッセージを入力して下さい。\n"
+"\n"
+"正しいコミット・メッセージは:\n"
+"\n"
+"- 第１行: 何をしたか、を１行で要約。\n"
+"- 第２行: 空白\n"
+"- 残りの行: なぜ、この変更が良い変更か、の説明。\n"
+
+#: lib/commit.tcl:257
+msgid "write-tree failed:"
+msgstr "write-tree が失敗しました:"
+
+#: lib/commit.tcl:279
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"コミットする変更がありません。\n"
+"\n"
+"マージでなく、また、一つも変更点がありません。\n"
+"\n"
+"自動的に再スキャンを開始します。\n"
+
+#: lib/commit.tcl:286
+msgid "No changes to commit."
+msgstr "コミットする変更がありません。"
+
+#: lib/commit.tcl:317
+msgid "commit-tree failed:"
+msgstr "commit-tree が失敗しました:"
+
+#: lib/commit.tcl:339
+msgid "update-ref failed:"
+msgstr "update-ref が失敗しました:"
+
+#: lib/commit.tcl:430
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "コミット %s を作成しました: %s"
+
+#: lib/console.tcl:55
+msgid "Working... please wait..."
+msgstr "実行中…お待ち下さい…"
+
+#: lib/console.tcl:184
+msgid "Success"
+msgstr "成功"
+
+#: lib/console.tcl:194
+msgid "Error: Command Failed"
+msgstr "エラー: コマンドが失敗しました"
+
+#: lib/database.tcl:43
+msgid "Number of loose objects"
+msgstr "ばらばらなオブジェクトの数"
+
+#: lib/database.tcl:44
+msgid "Disk space used by loose objects"
+msgstr "ばらばらなオブジェクトの使用するディスク量"
+
+#: lib/database.tcl:45
+msgid "Number of packed objects"
+msgstr "パックされたオブジェクトの数"
+
+#: lib/database.tcl:46
+msgid "Number of packs"
+msgstr "パックの数"
+
+#: lib/database.tcl:47
+msgid "Disk space used by packed objects"
+msgstr "パックされたオブジェクトの使用するディスク量"
+
+#: lib/database.tcl:48
+msgid "Packed objects waiting for pruning"
+msgstr "パックに存在するので捨てて良いオブジェクトの数"
+
+#: lib/database.tcl:49
+msgid "Garbage files"
+msgstr "ゴミファイル"
+
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "データベース圧縮"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "fsck-objects でオブジェクト・データベースを検証しています"
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
+"変更がありません。\n"
+"\n"
+"%s には変更がありません。\n"
+"\n"
+"このファイルの変更時刻は他のアプリケーションによって更新されていますがファイ"
+"ル内容には変更がありません。\n"
+"\n"
+"同様な状態のファイルを探すために、自動的に再スキャンを開始します。"
+
+#: lib/diff.tcl:97
+msgid "Error loading file:"
+msgstr "ファイルを読む際のエラーです:"
+
+#: lib/diff.tcl:162
+msgid "Error loading diff:"
+msgstr "diff を読む際のエラーです:"
+
+#: lib/diff.tcl:278
+msgid "Failed to unstage selected hunk."
+msgstr "選択されたパッチをコミット予定から外せません。"
+
+#: lib/diff.tcl:285
+msgid "Failed to stage selected hunk."
+msgstr "選択されたパッチをコミット予定に加えられません。"
+
+#: lib/error.tcl:12 lib/error.tcl:102
+msgid "error"
+msgstr "エラー"
+
+#: lib/error.tcl:28
+msgid "warning"
+msgstr "警告"
+
+#: lib/error.tcl:81
+msgid "You must correct the above errors before committing."
+msgstr "コミットする前に、以上のエラーを修正して下さい"
+
+#: lib/index.tcl:364
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "ファイル %s にした変更を元に戻しますか？"
+
+#: lib/index.tcl:366
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr "これら %i 個のファイルにした変更を元に戻しますか？"
+
+#: lib/index.tcl:372
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr "変更を元に戻すとコミット予定していない変更は全て失われます。"
+
+#: lib/index.tcl:375
+msgid "Do Nothing"
+msgstr "何もしない"
+
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
+msgstr ""
+"訂正中にはマージできません。\n"
+"\n"
+"訂正処理を完了するまでは新たにマージを開始できません。\n"
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
+"最後にスキャンした状態はリポジトリの状態と合致しません。\n"
+"\n"
+"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。マー"
+"ジを開始する前に、再スキャンが必要です。\n"
+"\n"
+"自動的に再スキャンを開始します。\n"
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
+"衝突のあったマージの途中です。\n"
+"\n"
+"ファイル %s にはマージ中の衝突が残っています。\n"
+"\n"
+"このファイルの衝突を解決し、コミット予定に加えて、コミットすることでマージを"
+"完了します。そうやって始めて、新たなマージを開始できるようになります。\n"
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
+"変更の途中です。\n"
+"\n"
+"ファイル %s は変更中です。\n"
+"\n"
+"現在のコミットを完了してからマージを開始して下さい。そうする方がマージに失敗"
+"したときの回復が楽です。\n"
+
+#: lib/merge.tcl:106
+#, tcl-format
+msgid "%s of %s"
+msgstr "%s の %s ブランチ"
+
+#: lib/merge.tcl:119
+#, tcl-format
+msgid "Merging %s and %s"
+msgstr "%s と %s をマージします"
+
+#: lib/merge.tcl:131
+msgid "Merge completed successfully."
+msgstr "マージが完了しました"
+
+#: lib/merge.tcl:133
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "マージが失敗しました。衝突の解決が必要です。"
+
+#: lib/merge.tcl:158
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "%s にマージ"
+
+#: lib/merge.tcl:177
+msgid "Revision To Merge"
+msgstr "マージするリビジョン"
+
+#: lib/merge.tcl:212
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"訂正中には中止できません。\n"
+"\n"
+"まず今のコミット訂正を完了させて下さい。\n"
+
+#: lib/merge.tcl:222
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"マージを中断しますか？\n"
+"\n"
+"現在のマージを中断すると、コミットしていない全ての変更が失われます。\n"
+"\n"
+"マージを中断してよろしいですか？"
+
+#: lib/merge.tcl:228
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr ""
+"変更点をリセットしますか？\n"
+"\n"
+"変更点をリセットすると、コミットしていない全ての変更が失われます。\n"
+"\n"
+"リセットしてよろしいですか？"
+
+#: lib/merge.tcl:239
+msgid "Aborting"
+msgstr "中断しています"
+
+#: lib/merge.tcl:266
+msgid "Abort failed."
+msgstr "中断に失敗しました。"
+
+#: lib/merge.tcl:268
+msgid "Abort completed.  Ready."
+msgstr "中断完了。"
+
+#: lib/option.tcl:77
+msgid "git-gui - a graphical user interface for Git."
+msgstr "Git のグラフィカルUI git-gui"
+
+#: lib/option.tcl:164
+msgid "Restore Defaults"
+msgstr "既定値に戻す"
+
+#: lib/option.tcl:168
+msgid "Save"
+msgstr "保存"
+
+#: lib/option.tcl:178
+#, tcl-format
+msgid "%s Repository"
+msgstr "%s リポジトリ"
+
+#: lib/option.tcl:179
+msgid "Global (All Repositories)"
+msgstr "大域（全てのリポジトリ）"
+
+#: lib/option.tcl:185
+msgid "User Name"
+msgstr "ユーザ名"
+
+#: lib/option.tcl:186
+msgid "Email Address"
+msgstr "電子メールアドレス"
+
+#: lib/option.tcl:188
+msgid "Summarize Merge Commits"
+msgstr "マージコミットの要約"
+
+#: lib/option.tcl:189
+msgid "Merge Verbosity"
+msgstr "マージの冗長度"
+
+#: lib/option.tcl:190
+msgid "Show Diffstat After Merge"
+msgstr "マージ後に diffstat を表示"
+
+#: lib/option.tcl:192
+msgid "Trust File Modification Timestamps"
+msgstr "ファイル変更時刻を信頼する"
+
+#: lib/option.tcl:193
+msgid "Prune Tracking Branches During Fetch"
+msgstr "フェッチ中にトラッキングブランチを刈る"
+
+#: lib/option.tcl:194
+msgid "Match Tracking Branches"
+msgstr "トラッキングブランチを合わせる"
+
+#: lib/option.tcl:195
+msgid "Number of Diff Context Lines"
+msgstr "diff の文脈行数"
+
+#: lib/option.tcl:196
+msgid "New Branch Name Template"
+msgstr "新しいブランチ名のテンプレート"
+
+#: lib/option.tcl:305
+msgid "Failed to completely save options:"
+msgstr "完全にオプションを保存できません:"
+
+#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
+msgid "Delete Remote Branch"
+msgstr "リモート・ブランチを削除"
+
+#: lib/remote_branch_delete.tcl:47
+msgid "From Repository"
+msgstr "元のリポジトリ"
+
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:118
+msgid "Remote:"
+msgstr "リモート:"
+
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:133
+msgid "Arbitrary URL:"
+msgstr "任意の URL:"
+
+#: lib/remote_branch_delete.tcl:84
+msgid "Branches"
+msgstr "ブランチ"
+
+#: lib/remote_branch_delete.tcl:109
+msgid "Delete Only If"
+msgstr "条件付で削除"
+
+#: lib/remote_branch_delete.tcl:111
+msgid "Merged Into:"
+msgstr "マージ先:"
+
+#: lib/remote_branch_delete.tcl:119
+msgid "Always (Do not perform merge checks)"
+msgstr "無条件（マージ検査をしない）"
+
+#: lib/remote_branch_delete.tcl:152
+msgid "A branch is required for 'Merged Into'."
+msgstr "'マージ先' にはブランチが必要です。"
+
+#: lib/remote_branch_delete.tcl:189
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched the "
+"necessary commits.  Try fetching from %s first."
+msgstr ""
+"必要なコミットが不足しているために、マージ検査が失敗しました。まず %s から"
+"フェッチして下さい。"
+
+#: lib/remote_branch_delete.tcl:207
+msgid "Please select one or more branches to delete."
+msgstr "削除するブランチを選択して下さい。"
+
+#: lib/remote_branch_delete.tcl:216
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"削除したブランチを回復するのは困難です。\n"
+"\n"
+"選択したブランチを削除して良いですか？"
+
+#: lib/remote_branch_delete.tcl:226
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr "%s からブランチを削除しています。"
+
+#: lib/remote_branch_delete.tcl:286
+msgid "No repository selected."
+msgstr "リポジトリが選択されていません。"
+
+#: lib/remote_branch_delete.tcl:291
+#, tcl-format
+msgid "Scanning %s..."
+msgstr "%s をスキャンしています…"
+
+#: lib/remote.tcl:162
+#, tcl-format
+msgid "Fetch from %s..."
+msgstr "%s からフェッチ…"
+
+#: lib/remote.tcl:172
+#, tcl-format
+msgid "Prune from %s..."
+msgstr "%s から刈る…"
+
+#: lib/remote.tcl:206
+#, tcl-format
+msgid "Push to %s..."
+msgstr "%s へプッシュ…"
+
+#: lib/shortcut.tcl:26 lib/shortcut.tcl:74
+msgid "Cannot write script:"
+msgstr "スクリプトが書けません:"
+
+#: lib/shortcut.tcl:149
+msgid "Cannot write icon:"
+msgstr "アイコンが書けません:"
+
+#: lib/status_bar.tcl:58
+#, tcl-format
+msgid "%s ... %i of %i %s (%2i%%)"
+msgstr "%1$s ... %3$i %4$s 中の %$2i (%5$2i%%)"
+
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "%s から新しい変更をフェッチしています"
+
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "%s から削除されたトラッキング・ブランチを刈っています"
+
+#: lib/transport.tcl:26
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "%s へ変更をプッシュしています"
+
+#: lib/transport.tcl:68
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "%3$s へ %1$s %2$s をプッシュしています"
+
+#: lib/transport.tcl:84
+msgid "Push Branches"
+msgstr "ブランチをプッシュ"
+
+#: lib/transport.tcl:98
+msgid "Source Branches"
+msgstr "元のブランチ"
+
+#: lib/transport.tcl:115
+msgid "Destination Repository"
+msgstr "送り先リポジトリ"
+
+#: lib/transport.tcl:153
+msgid "Transfer Options"
+msgstr "通信オプション"
+
+#: lib/transport.tcl:155
+msgid "Use thin pack (for slow network connections)"
+msgstr "Thin Pack を使う（遅いネットワーク接続）"
+
+#: lib/transport.tcl:159
+msgid "Include tags"
+msgstr "タグを含める"
-- 
1.5.3.2.g46909


--8323584-1067707744-1188750933=:28586--
