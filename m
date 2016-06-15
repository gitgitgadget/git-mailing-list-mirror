From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 13/15] Hungarian translation of git-gui
Date: Sun, 2 Sep 2007 17:37:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021737120.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-704432622-1188751042=:28586"
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:37:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsSD-00063u-R5
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbXIBQhg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbXIBQhf
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:37:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:40067 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964810AbXIBQhe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:37:34 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:37:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 02 Sep 2007 18:37:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lwoMYZmllspxVYLEE0vjNku56CXms6xyutX67fI
	/iRUqCMoC71IWt
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57361>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-704432622-1188751042=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


From: Miklos Vajna <vmiklos@frugalware.org>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/hu.po | 1422 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1422 insertions(+), 0 deletions(-)
 create mode 100644 po/hu.po

diff --git a/po/hu.po b/po/hu.po
new file mode 100644
index 0000000..faac58f
--- /dev/null
+++ b/po/hu.po
@@ -0,0 +1,1422 @@
+# Hungarian translations for git-gui-i package.
+# Copyright (C) 2007 THE git-gui-i'S COPYRIGHT HOLDER
+# This file is distributed under the same license as the git-gui-i package.
+# Miklos Vajna <vmiklos@frugalware.org>, 2007.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui-i 18n\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-08-11 17:28+0200\n"
+"PO-Revision-Date: 2007-07-27 13:15+0200\n"
+"Last-Translator: Miklos Vajna <vmiklos@frugalware.org>\n"
+"Language-Team: Hungarian\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=2; plural=(n != 1);\n"
+
+#: git-gui.sh:531
+msgid "Cannot find git in PATH."
+msgstr "A git nem található a PATH-ban."
+
+#: git-gui.sh:550
+msgid "Cannot parse Git version string:"
+msgstr "Nem értelmezhető a Git verzió sztring:"
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
+"Nem állípítható meg a Git verziója.\n"
+"\n"
+"A(z) %s szerint a verzió '%s'.\n"
+"\n"
+"A(z) %s a Git 1.5.0 vagy későbbi verzióját igényli.\n"
+"\n"
+"Feltételezhetjük, hogy a(z) '%s' verziója legalább 1.5.0?\n"
+
+#: git-gui.sh:689
+msgid "Cannot find the git directory:"
+msgstr "Nem található a git könyvtár:"
+
+#: git-gui.sh:697
+msgid "Git directory not found:"
+msgstr "A Git könyvtár nem található:"
+
+#: git-gui.sh:703
+msgid "Cannot use funny .git directory:"
+msgstr "Nem használható vicces .git könyvtár:"
+
+#: git-gui.sh:708
+msgid "No working directory"
+msgstr "Nincs munkakönyvtár"
+
+#: git-gui.sh:854
+msgid "Refreshing file status..."
+msgstr "A fájlok státuszának frissítése..."
+
+#: git-gui.sh:891
+msgid "Scanning for modified files ..."
+msgstr "Módosított fájlok keresése ..."
+
+#: git-gui.sh:1057 lib/browser.tcl:247
+msgid "Ready."
+msgstr "Kész."
+
+#: git-gui.sh:1322
+msgid "Unmodified"
+msgstr "Nem módosított"
+
+#: git-gui.sh:1324
+msgid "Modified, not staged"
+msgstr "Módosított, de nem kiválasztott"
+
+#: git-gui.sh:1325 git-gui.sh:1330
+msgid "Staged for commit"
+msgstr "Kiválasztva commitolásra"
+
+#: git-gui.sh:1326 git-gui.sh:1331
+msgid "Portions staged for commit"
+msgstr "Részek kiválasztva commitolásra"
+
+#: git-gui.sh:1327 git-gui.sh:1332
+msgid "Staged for commit, missing"
+msgstr "Kiválasztva commitolásra, hiányzó"
+
+#: git-gui.sh:1329
+msgid "Untracked, not staged"
+msgstr "Nem követett, nem kiválasztott"
+
+#: git-gui.sh:1334
+msgid "Missing"
+msgstr "Hiányzó"
+
+#: git-gui.sh:1335
+msgid "Staged for removal"
+msgstr "Kiválasztva eltávolításra"
+
+#: git-gui.sh:1336
+msgid "Staged for removal, still present"
+msgstr "Kiválasztva eltávolításra, jelenleg is elérhető"
+
+#: git-gui.sh:1338 git-gui.sh:1339 git-gui.sh:1340 git-gui.sh:1341
+msgid "Requires merge resolution"
+msgstr "Merge feloldás szükséges"
+
+#: git-gui.sh:1383
+msgid "Starting gitk... please wait..."
+msgstr "A gitk indítása... várjunk..."
+
+#: git-gui.sh:1392
+#, tcl-format
+msgid ""
+"Unable to start gitk:\n"
+"\n"
+"%s does not exist"
+msgstr ""
+"A gitk indítása sikertelen:\n"
+"\n"
+"A(z) %s nem létezik"
+
+#: git-gui.sh:1609
+#, tcl-format
+msgid "Invalid font specified in gui.%s:"
+msgstr "Érvénytelen font lett megadva a grafikus felületben.%s:"
+
+#: git-gui.sh:1634
+msgid "Main Font"
+msgstr "Fő betűtípus"
+
+#: git-gui.sh:1635
+msgid "Diff/Console Font"
+msgstr "Diff/konzol betűtípus"
+
+#: git-gui.sh:1649
+msgid "Repository"
+msgstr "Repó"
+
+#: git-gui.sh:1650
+msgid "Edit"
+msgstr "Szerkesztés"
+
+#: git-gui.sh:1652
+msgid "Branch"
+msgstr "Branch"
+
+#: git-gui.sh:1655 git-gui.sh:1842 git-gui.sh:2152
+msgid "Commit"
+msgstr "Commit"
+
+#: git-gui.sh:1658 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+msgid "Merge"
+msgstr "Merge"
+
+#: git-gui.sh:1659
+msgid "Fetch"
+msgstr "Letöltés"
+
+#: git-gui.sh:1660 git-gui.sh:2158 lib/transport.tcl:88 lib/transport.tcl:172
+msgid "Push"
+msgstr "Push"
+
+#: git-gui.sh:1669
+msgid "Browse Current Branch's Files"
+msgstr "A jelenlegi branch fájljainak böngészése"
+
+#: git-gui.sh:1673
+msgid "Browse Branch Files..."
+msgstr "A branch fájljainak böngészése..."
+
+#: git-gui.sh:1678
+msgid "Visualize Current Branch's History"
+msgstr "A jelenlegi branch történetének vizualizálása"
+
+#: git-gui.sh:1682
+msgid "Visualize All Branch History"
+msgstr "Az összes branch történetének vizualizálása"
+
+#: git-gui.sh:1689
+#, tcl-format
+msgid "Browse %s's Files"
+msgstr "A(z) %s branch fájljainak böngészése"
+
+#: git-gui.sh:1691
+#, tcl-format
+msgid "Visualize %s's History"
+msgstr "A(z) %s branch történetének vizualizálása"
+
+#: git-gui.sh:1696 lib/database.tcl:27 lib/database.tcl:67
+msgid "Database Statistics"
+msgstr "Adatbázis statisztikák"
+
+#: git-gui.sh:1699 lib/database.tcl:34
+msgid "Compress Database"
+msgstr "Adatbázis tömörítése"
+
+#: git-gui.sh:1702
+msgid "Verify Database"
+msgstr "Adatbázis ellenőrzése"
+
+#: git-gui.sh:1709 git-gui.sh:1713 git-gui.sh:1717 lib/shortcut.tcl:9
+#: lib/shortcut.tcl:45 lib/shortcut.tcl:84
+msgid "Create Desktop Icon"
+msgstr "Asztal ikon létrehozása"
+
+#: git-gui.sh:1722
+msgid "Quit"
+msgstr "Kilépés"
+
+#: git-gui.sh:1729
+msgid "Undo"
+msgstr "Visszavonás"
+
+#: git-gui.sh:1732
+msgid "Redo"
+msgstr "Mégis"
+
+#: git-gui.sh:1736 git-gui.sh:2222
+msgid "Cut"
+msgstr "Kivágás"
+
+#: git-gui.sh:1739 git-gui.sh:2225 git-gui.sh:2296 git-gui.sh:2368
+#: lib/console.tcl:69
+msgid "Copy"
+msgstr "Másolás"
+
+#: git-gui.sh:1742 git-gui.sh:2228
+msgid "Paste"
+msgstr "Beillesztés"
+
+#: git-gui.sh:1745 git-gui.sh:2231 lib/branch_delete.tcl:26
+#: lib/remote_branch_delete.tcl:38
+msgid "Delete"
+msgstr "Törlés"
+
+#: git-gui.sh:1749 git-gui.sh:2235 git-gui.sh:2372 lib/console.tcl:71
+msgid "Select All"
+msgstr "Mindent kiválaszt"
+
+#: git-gui.sh:1758
+msgid "Create..."
+msgstr "Létrehozás..."
+
+#: git-gui.sh:1764
+msgid "Checkout..."
+msgstr "Checkout..."
+
+#: git-gui.sh:1770
+msgid "Rename..."
+msgstr "Átnevezés..."
+
+#: git-gui.sh:1775 git-gui.sh:1873
+msgid "Delete..."
+msgstr "Törlés..."
+
+#: git-gui.sh:1780
+msgid "Reset..."
+msgstr "Visszaállítás..."
+
+#: git-gui.sh:1792 git-gui.sh:2169
+msgid "New Commit"
+msgstr "Új commit"
+
+#: git-gui.sh:1800 git-gui.sh:2176
+msgid "Amend Last Commit"
+msgstr "Utolsó commit javítása"
+
+#: git-gui.sh:1809 git-gui.sh:2136 lib/remote_branch_delete.tcl:99
+msgid "Rescan"
+msgstr "Keresés újra"
+
+#: git-gui.sh:1815
+msgid "Stage To Commit"
+msgstr "Kiválasztás commitolásra"
+
+#: git-gui.sh:1820
+msgid "Stage Changed Files To Commit"
+msgstr "Módosított fájlok kiválasztása commitolásra"
+
+#: git-gui.sh:1826
+msgid "Unstage From Commit"
+msgstr "Commitba való kiválasztás visszavonása"
+
+#: git-gui.sh:1831 lib/index.tcl:376
+msgid "Revert Changes"
+msgstr "Változtatások visszaállítása"
+
+#: git-gui.sh:1838 git-gui.sh:2148 git-gui.sh:2246
+msgid "Sign Off"
+msgstr "Aláír"
+
+#: git-gui.sh:1853
+msgid "Local Merge..."
+msgstr "Helyi merge..."
+
+#: git-gui.sh:1858
+msgid "Abort Merge..."
+msgstr "Merge megszakítása..."
+
+#: git-gui.sh:1870
+msgid "Push..."
+msgstr "Push..."
+
+#: git-gui.sh:1880
+msgid "Apple"
+msgstr "Apple"
+
+#: git-gui.sh:1883 git-gui.sh:1901 lib/option.tcl:65
+#, tcl-format
+msgid "About %s"
+msgstr "Névjegy: %s"
+
+#: git-gui.sh:1885 git-gui.sh:1891 git-gui.sh:2414
+msgid "Options..."
+msgstr "Opciók..."
+
+#: git-gui.sh:1897
+msgid "Help"
+msgstr "Segítség"
+
+#: git-gui.sh:1938
+msgid "Online Documentation"
+msgstr "Online dokumentáció"
+
+#: git-gui.sh:2054
+msgid "Current Branch:"
+msgstr "Jelenlegi branch:"
+
+#: git-gui.sh:2075
+msgid "Staged Changes (Will Be Committed)"
+msgstr "Kiválasztott változtatások (commitolva lesz)"
+
+#: git-gui.sh:2095
+msgid "Unstaged Changes (Will Not Be Committed)"
+msgstr "Nem kiválasztott változtatások (nem lesz commitolva)"
+
+#: git-gui.sh:2142
+msgid "Stage Changed"
+msgstr "Változtatások kiválasztása"
+
+#: git-gui.sh:2188
+msgid "Initial Commit Message:"
+msgstr "Kezdeti commit üzenet:"
+
+#: git-gui.sh:2189
+msgid "Amended Commit Message:"
+msgstr "Javító commit üzenet:"
+
+#: git-gui.sh:2190
+msgid "Amended Initial Commit Message:"
+msgstr "Kezdeti javító commit üzenet:"
+
+#: git-gui.sh:2191
+msgid "Amended Merge Commit Message:"
+msgstr "Javító merge commit üzenet:"
+
+#: git-gui.sh:2192
+msgid "Merge Commit Message:"
+msgstr "Merge commit üzenet:"
+
+#: git-gui.sh:2193
+msgid "Commit Message:"
+msgstr "Commit üzenet:"
+
+#: git-gui.sh:2238 git-gui.sh:2376 lib/console.tcl:73
+msgid "Copy All"
+msgstr "Összes másolása"
+
+#: git-gui.sh:2262 lib/blame.tcl:104
+msgid "File:"
+msgstr "Fájl:"
+
+#: git-gui.sh:2364
+msgid "Refresh"
+msgstr "Frissítés"
+
+#: git-gui.sh:2385
+msgid "Apply/Reverse Hunk"
+msgstr "Hunk alkalmazása/visszaállítása"
+
+#: git-gui.sh:2391
+msgid "Decrease Font Size"
+msgstr "Font méret csökkentése"
+
+#: git-gui.sh:2395
+msgid "Increase Font Size"
+msgstr "Fönt méret növelése"
+
+#: git-gui.sh:2400
+msgid "Show Less Context"
+msgstr "Kevesebb környezet mutatása"
+
+#: git-gui.sh:2407
+msgid "Show More Context"
+msgstr "Több környezet mutatása"
+
+#: git-gui.sh:2422
+msgid "Unstage Hunk From Commit"
+msgstr "Hunk törlése commitból"
+
+#: git-gui.sh:2426 git-gui.sh:2430
+msgid "Stage Hunk For Commit"
+msgstr "Hunk kiválasztása commitba"
+
+#: git-gui.sh:2440
+msgid "Initializing..."
+msgstr "Inicializálás..."
+
+#: lib/blame.tcl:77
+msgid "File Viewer"
+msgstr "Fájl néző"
+
+#: lib/blame.tcl:81
+msgid "Commit:"
+msgstr "Commit:"
+
+#: lib/blame.tcl:249
+msgid "Copy Commit"
+msgstr "Commit másolása"
+
+#: lib/blame.tcl:369
+#, tcl-format
+msgid "Reading %s..."
+msgstr "A(z) %s olvasása..."
+
+#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+msgid "Checkout Branch"
+msgstr "Branch checkoutolása"
+
+#: lib/branch_checkout.tcl:23
+msgid "Checkout"
+msgstr "Checkout"
+
+#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
+#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:283
+#: lib/checkout_op.tcl:522 lib/merge.tcl:172 lib/option.tcl:172
+#: lib/remote_branch_delete.tcl:42 lib/transport.tcl:92
+msgid "Cancel"
+msgstr "Mégsem"
+
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:288
+msgid "Revision"
+msgstr "Revízió"
+
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:159
+#: lib/option.tcl:274
+msgid "Options"
+msgstr "Opciók"
+
+#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "Követő branch letöltése"
+
+#: lib/branch_checkout.tcl:44
+msgid "Detach From Local Branch"
+msgstr "Helyi branch leválasztása"
+
+#: lib/branch_create.tcl:22
+msgid "Create Branch"
+msgstr "Branch létrehozása"
+
+#: lib/branch_create.tcl:27
+msgid "Create New Branch"
+msgstr "Új branch létrehozása"
+
+#: lib/branch_create.tcl:31
+msgid "Create"
+msgstr "Létrehozás"
+
+#: lib/branch_create.tcl:40
+msgid "Branch Name"
+msgstr "Branch neve"
+
+#: lib/branch_create.tcl:43
+msgid "Name:"
+msgstr "Név:"
+
+#: lib/branch_create.tcl:58
+msgid "Match Tracking Branch Name"
+msgstr "Egyeztetendő követési branch név"
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "A következő revíziótól"
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "Létező branch frissítése"
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "Nem"
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "Csak fast forward"
+
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:514
+msgid "Reset"
+msgstr "Visszaállítás"
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "Checkout létrehozás után"
+
+#: lib/branch_create.tcl:131
+msgid "Please select a tracking branch."
+msgstr "Válasszunk ki egy követő branchet."
+
+#: lib/branch_create.tcl:140
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "A(z) %s követő branch nem branch a távoli repóban."
+
+#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
+msgid "Please supply a branch name."
+msgstr "Adjunk megy egy branch nevet."
+
+#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "A(z) '%s' nem egy elfogadható branch név."
+
+#: lib/branch_delete.tcl:15
+msgid "Delete Branch"
+msgstr "Branch törlése"
+
+#: lib/branch_delete.tcl:20
+msgid "Delete Local Branch"
+msgstr "Helyi branch törlése"
+
+#: lib/branch_delete.tcl:37
+msgid "Local Branches"
+msgstr "Helyi branchek"
+
+#: lib/branch_delete.tcl:52
+msgid "Delete Only If Merged Into"
+msgstr "Csak már merge-ölt törlése"
+
+#: lib/branch_delete.tcl:54
+msgid "Always (Do not perform merge test.)"
+msgstr "Mindig (Ne legyen merge teszt.)"
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr "A következő branchek nem teljesen lettek merge-ölve ebbe: %s:"
+
+#: lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult. \n"
+"\n"
+" Delete the selected branches?"
+msgstr ""
+"A törölt branchek visszaállítása bonyolult. \n"
+"\n"
+" Biztosan törli a kiválasztott brancheket?"
+
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"Nem sikerült törölni a következő brancheket:\n"
+"%s"
+
+#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
+msgid "Rename Branch"
+msgstr "Branch átnevezése"
+
+#: lib/branch_rename.tcl:26
+msgid "Rename"
+msgstr "Átnevezés"
+
+#: lib/branch_rename.tcl:36
+msgid "Branch:"
+msgstr "Branch:"
+
+#: lib/branch_rename.tcl:39
+msgid "New Name:"
+msgstr "Új név:"
+
+#: lib/branch_rename.tcl:75
+msgid "Please select a branch to rename."
+msgstr "Válasszunk ki egy átnevezendő branchet."
+
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "A(z) '%s' branch már létezik."
+
+#: lib/branch_rename.tcl:117
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "Nem sikerült átnevezni: '%s'."
+
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "Indítás..."
+
+#: lib/browser.tcl:26
+msgid "File Browser"
+msgstr "Fájl böngésző"
+
+#: lib/browser.tcl:127 lib/browser.tcl:144
+#, tcl-format
+msgid "Loading %s..."
+msgstr "A(z) %s betöltése..."
+
+#: lib/browser.tcl:188
+msgid "[Up To Parent]"
+msgstr "[Fel a szülőhöz]"
+
+#: lib/browser.tcl:268 lib/browser.tcl:274
+msgid "Browse Branch Files"
+msgstr "A branch fájljainak böngészése"
+
+#: lib/browser.tcl:279
+msgid "Browse"
+msgstr "Böngészés"
+
+#: lib/checkout_op.tcl:79
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "A(z) %s letöltése innen: %s"
+
+#: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
+msgid "Close"
+msgstr "Bezárás"
+
+#: lib/checkout_op.tcl:169
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr "A(z) '%s' branch nem létezik."
+
+#: lib/checkout_op.tcl:206
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr ""
+"A(z) '%s' branch már létezik.\n"
+"\n"
+"Nem lehet fast-forwardolni a következőhöz: %s.\n"
+"Egy merge szükséges."
+
+#: lib/checkout_op.tcl:220
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr "A(z) '%s' merge strategy nem támogatott."
+
+#: lib/checkout_op.tcl:239
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr "Nem sikerült frissíteni a következőt: '%s'."
+
+#: lib/checkout_op.tcl:251
+msgid "Staging area (index) is already locked."
+msgstr "A kiválasztási terület (index) már zárolva van."
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
+"Az utolsó keresési állapot nem egyezik meg a repó állpotával.\n"
+"\n"
+"Egy másik Git program módosította ezt a repót az utolsó keresés óta. Egy "
+"újrakeresés mindenképpen szükséges mielőtt a jelenlegi branchet módosítani "
+"lehetne.\n"
+"\n"
+"Az újrakeresés most automatikusan el fog indulni.\n"
+
+#: lib/checkout_op.tcl:353
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
+msgstr "A(z) '%s' checkoutja megszakítva (fájlszintű merge-ölés szükséges)."
+
+#: lib/checkout_op.tcl:354
+msgid "File level merge required."
+msgstr "Fájlszintű merge-ölés szükséges."
+
+#: lib/checkout_op.tcl:358
+#, tcl-format
+msgid "Staying on branch '%s'."
+msgstr "Jelenleg a(z) '%s' branchen."
+
+#: lib/checkout_op.tcl:429
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This Detached "
+"Checkout'."
+msgstr ""
+"Már nem egy helyi branchen vagyunk.\n"
+"\n"
+"Ha egy branchen szeretnénk lenni, hozzunk létre egyet az 'Ez a leválasztott "
+"checkout'-ból."
+
+#: lib/checkout_op.tcl:478
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgstr ""
+"A(z) '%s' -> '%s' visszaállítás a következő commitok elvesztését jelenti:"
+
+#: lib/checkout_op.tcl:500
+msgid "Recovering lost commits may not be easy."
+msgstr "Az elveszett commitok helyreállítása nem biztos, hogy egyszerű."
+
+#: lib/checkout_op.tcl:505
+#, tcl-format
+msgid "Reset '%s'?"
+msgstr "Visszaállítjuk a következőt: '%s'?"
+
+#: lib/checkout_op.tcl:510 lib/merge.tcl:164
+msgid "Visualize"
+msgstr "Vizualizálás"
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
+"Nem sikerült beállítani a jelenlegi branchet.\n"
+"\n"
+"A munkakönyvtár csak részben váltott át.  A fájlok sikeresen frissítve "
+"lettek, de nem sikerült frissíteni egy belső Git fájlt.\n"
+"\n"
+"Ennek nem szabad megtörténnie.  A(z) %s most kilép és feladja."
+
+#: lib/choose_rev.tcl:53
+msgid "This Detached Checkout"
+msgstr "Ez a leválasztott checkout"
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "Revízió kifejezés:"
+
+#: lib/choose_rev.tcl:74
+msgid "Local Branch"
+msgstr "Helyi branch"
+
+#: lib/choose_rev.tcl:79
+msgid "Tracking Branch"
+msgstr "Követő branch"
+
+#: lib/choose_rev.tcl:84
+msgid "Tag"
+msgstr "Tag"
+
+#: lib/choose_rev.tcl:317
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Érvénytelen revízió: %s"
+
+#: lib/choose_rev.tcl:338
+msgid "No revision selected."
+msgstr "Nincs kiválasztva revízió."
+
+#: lib/choose_rev.tcl:346
+msgid "Revision expression is empty."
+msgstr "A revízió kifejezés üres."
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit before this "
+"to amend.\n"
+msgstr ""
+"Nincs semmi javítanivaló.\n"
+"\n"
+"Az első commit létrehozása előtt nincs semmilyen commit amit javitani "
+"lehetne.\n"
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort the "
+"current merge activity.\n"
+msgstr ""
+"Nem lehet javítani merge alatt.\n"
+"\n"
+"A jelenlegi merge még nem teljesen fejeződött be. Csak akkor javíthat egy "
+"előbbi commitot, hogyha megszakítja a jelenlegi merge folyamatot.\n"
+
+#: lib/commit.tcl:49
+msgid "Error loading commit data for amend:"
+msgstr "Hiba a javítandó commit adat betöltése közben:"
+
+#: lib/commit.tcl:76
+msgid "Unable to obtain your identity:"
+msgstr "Nem sikerült megállapítani az azonosítót:"
+
+#: lib/commit.tcl:81
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "Érvénytelen GIT_COMMITTER_IDENT:"
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
+"Az utolsó keresési állapot nem egyezik meg a repó állapotával.\n"
+"\n"
+"Egy másik Git program módosította ezt a repót az utolsó keresés óta. Egy "
+"újrakeresés mindenképpen szükséges mielőtt a jelenlegi branchet módosítani "
+"lehetne.\n"
+"\n"
+"Az újrakeresés most automatikusan el fog indulni.\n"
+
+#: lib/commit.tcl:154
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the file "
+"before committing.\n"
+msgstr ""
+"Nem commitolhatunk fájlokat merge előtt.\n"
+"\n"
+"A(z) %s fájlban ütközések vannak. Egyszer azokat ki kell javítani, majd "
+"hozzá ki kell választani a fájlt mielőtt commitolni lehetne.\n"
+
+#: lib/commit.tcl:162
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"Ismeretlen fájl típus %s érzékelve.\n"
+"\n"
+"A(z) %s fájlt nem tudja ez a program commitolni.\n"
+
+#: lib/commit.tcl:170
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"Nincs commitolandó változtatás.\n"
+"\n"
+"Legalább egy fájl ki kell választani, hogy commitolni lehessen.\n"
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
+"Adjunk megy egy commit üzenetet.\n"
+"\n"
+"Egy jó commit üzenetnek a következő a formátuma:\n"
+"\n"
+"- Első sor: Egy mondatban leírja, hogy mit csináltunk.\n"
+"- Második sor: Üres\n"
+"- A többi sor: Leírja, hogy miért jó ez a változtatás.\n"
+
+#: lib/commit.tcl:257
+msgid "write-tree failed:"
+msgstr "a write-tree sikertelen:"
+
+#: lib/commit.tcl:279
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"Nincs commitolandó változtatás.\n"
+"\n"
+"Egyetlen fájlt se módosított ez a commit és merge commit se volt.\n"
+"\n"
+"Az újrakeresés most automatikusan el fog indulni.\n"
+
+#: lib/commit.tcl:286
+msgid "No changes to commit."
+msgstr "Nincs commitolandó változtatás."
+
+#: lib/commit.tcl:317
+msgid "commit-tree failed:"
+msgstr "a commit-tree sikertelen:"
+
+#: lib/commit.tcl:339
+msgid "update-ref failed:"
+msgstr "az update-ref sikertelen:"
+
+#: lib/commit.tcl:430
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "Létrejött a %s commit: %s"
+
+#: lib/console.tcl:55
+msgid "Working... please wait..."
+msgstr "Munka folyamatban.. Várjunk..."
+
+#: lib/console.tcl:184
+msgid "Success"
+msgstr "Siker"
+
+#: lib/console.tcl:194
+msgid "Error: Command Failed"
+msgstr "Hiba: a parancs sikertelen"
+
+#: lib/database.tcl:43
+msgid "Number of loose objects"
+msgstr "Elvesztett objektumok száma"
+
+#: lib/database.tcl:44
+msgid "Disk space used by loose objects"
+msgstr "Elveszett objektumok által elfoglalt lemezterület"
+
+#: lib/database.tcl:45
+msgid "Number of packed objects"
+msgstr "Csomagolt objektumok számra"
+
+#: lib/database.tcl:46
+msgid "Number of packs"
+msgstr "Csomagok száma"
+
+#: lib/database.tcl:47
+msgid "Disk space used by packed objects"
+msgstr "A csomagolt objektumok által használt lemezterület"
+
+#: lib/database.tcl:48
+msgid "Packed objects waiting for pruning"
+msgstr "Eltávolításra váró csomagolt objektumok számra"
+
+#: lib/database.tcl:49
+msgid "Garbage files"
+msgstr "Hulladék fájlok"
+
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "Az objektum adatbázis tömörítése"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "Az objektum adatbázis ellenőrzése az fsck-objects használatával"
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
+"Nincsenek változások.\n"
+"\n"
+"A(z) %s módosítatlan.\n"
+"\n"
+"A fájl módosítási dátumát frissítette egy másik alkalmazás, de a fájl "
+"tartalma változatlan.\n"
+"\n"
+"Egy újrakeresés fog indulni a hasonló állapotú fájlok megtalálása érdekében."
+
+#: lib/diff.tcl:97
+msgid "Error loading file:"
+msgstr "Hiba a fájl betöltése közben:"
+
+#: lib/diff.tcl:162
+msgid "Error loading diff:"
+msgstr "Hiba a diff betöltése közben:"
+
+#: lib/diff.tcl:278
+msgid "Failed to unstage selected hunk."
+msgstr "Nem visszavonni a hunk kiválasztását."
+
+#: lib/diff.tcl:285
+msgid "Failed to stage selected hunk."
+msgstr "Nem sikerült kiválasztani a hunkot."
+
+#: lib/error.tcl:12 lib/error.tcl:102
+msgid "error"
+msgstr "hiba"
+
+#: lib/error.tcl:28
+msgid "warning"
+msgstr "figyelmeztetés"
+
+#: lib/error.tcl:81
+msgid "You must correct the above errors before committing."
+msgstr "Ki kell javítanunk a fenti hibákat commit előtt."
+
+#: lib/index.tcl:364
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "Visszaállítja a változtatásokat a(z) %s fájlban?"
+
+#: lib/index.tcl:366
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr "Visszaállítja a változtatásokat ebben e %i fájlban?"
+
+#: lib/index.tcl:372
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr ""
+"Minden nem kiválasztott változtatás el fog veszni ezáltal a visszaállítás "
+"által."
+
+#: lib/index.tcl:375
+msgid "Do Nothing"
+msgstr "Ne csináljunk semmit"
+
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
+msgstr ""
+"Javítás közben nem lehetséges a merge.\n"
+"\n"
+"Egyszer be kell fejezni ennek a commitnak a javítását, majd kezdődhet egy "
+"merge.\n"
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
+"Az utolsó keresési állapot nem egyezik meg a repó állapotával.\n"
+"\n"
+"Egy másik Git program módosította ezt a repót az utolsó keresés óta. Egy "
+"újrakeresés mindenképpen szükséges mielőtt a jelenlegi branchet módosítani "
+"lehetne.\n"
+"\n"
+"Az újrakeresés most automatikusan el fog indulni.\n"
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
+"Jelenleg egy ütközés feloldása közben vagyunk.\n"
+"\n"
+"A(z) %s fájlban ütközések vannak.\n"
+"\n"
+"Fel kell oldanunk őket, kiválasztani a fájlt, és commitolni hogy befejezzük "
+"a jelenlegi merge-t. Csak ezután kezdhetünk el egy újabbat.\n"
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
+"Jelenleg egy változtatás közben vagyunk.\n"
+"\n"
+"A(z) %s fájl megváltozott.\n"
+"\n"
+"Először be kell fejeznünk a jelenlegi commitot, hogy elkezdhessünk egy merge-"
+"t. Ez segíteni fog, hogy félbeszakíthassunk egy merge-t.\n"
+
+#: lib/merge.tcl:106
+#, tcl-format
+msgid "%s of %s"
+msgstr "%s / %s"
+
+#: lib/merge.tcl:119
+#, tcl-format
+msgid "Merging %s and %s"
+msgstr "A(z) %s és a(z) %s merge-ölése"
+
+#: lib/merge.tcl:131
+msgid "Merge completed successfully."
+msgstr "A merge sikeresen befejeződött."
+
+#: lib/merge.tcl:133
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "A merge sikertelen. Fel kell oldanunk az ütközéseket."
+
+#: lib/merge.tcl:158
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "Merge-ölés a következőbe: %s"
+
+#: lib/merge.tcl:177
+msgid "Revision To Merge"
+msgstr "Merge-ölni szándékozott revízió"
+
+#: lib/merge.tcl:212
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"A commit javítás közben megszakítva.\n"
+"\n"
+"Be kell fejeznünk ennek a commitnak a javítását.\n"
+
+#: lib/merge.tcl:222
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"Megszakítjuk a merge-t?\n"
+"\n"
+"A jelenlegi merge megszakítása *MINDEN* nem commitolt változtatás "
+"elvesztését jelenti.\n"
+"\n"
+"Folytatjuk a jelenlegi merge megszakítását?"
+
+#: lib/merge.tcl:228
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr ""
+"Visszavonjuk a módosításokat?\n"
+"\n"
+"A módosítások visszavonása *MINDEN* nem commitolt változtatás elvesztését "
+"jelenti.\n"
+"\n"
+"Folytatjuk a jelenlegi módosítások visszavonását?"
+
+#: lib/merge.tcl:239
+msgid "Aborting"
+msgstr "Félbeszakítás"
+
+#: lib/merge.tcl:266
+msgid "Abort failed."
+msgstr "A félbeszakítás nem sikerült."
+
+#: lib/merge.tcl:268
+msgid "Abort completed.  Ready."
+msgstr "A megkeszakítás befejeződött. Kész."
+
+#: lib/option.tcl:77
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui - egy grafikus felület a Githez."
+
+#: lib/option.tcl:164
+msgid "Restore Defaults"
+msgstr "Alapértelmezés visszaállítása"
+
+#: lib/option.tcl:168
+msgid "Save"
+msgstr "Mentés"
+
+#: lib/option.tcl:178
+#, tcl-format
+msgid "%s Repository"
+msgstr "%s Repó"
+
+#: lib/option.tcl:179
+msgid "Global (All Repositories)"
+msgstr "Globális (minden repó)"
+
+#: lib/option.tcl:185
+msgid "User Name"
+msgstr "Felhasználónév"
+
+#: lib/option.tcl:186
+msgid "Email Address"
+msgstr "Email cím"
+
+#: lib/option.tcl:188
+msgid "Summarize Merge Commits"
+msgstr "A merge commitok összegzése"
+
+#: lib/option.tcl:189
+msgid "Merge Verbosity"
+msgstr "Merge beszédesség"
+
+#: lib/option.tcl:190
+msgid "Show Diffstat After Merge"
+msgstr "Diffstat mutatása merge után"
+
+#: lib/option.tcl:192
+msgid "Trust File Modification Timestamps"
+msgstr "A fájl módosítási dátumok megbízhatóak"
+
+#: lib/option.tcl:193
+msgid "Prune Tracking Branches During Fetch"
+msgstr "A követő branchek eltávolítása letöltés alatt"
+
+#: lib/option.tcl:194
+msgid "Match Tracking Branches"
+msgstr "A követő branchek egyeztetése"
+
+#: lib/option.tcl:195
+msgid "Number of Diff Context Lines"
+msgstr "A diff környezeti sorok száma"
+
+#: lib/option.tcl:196
+msgid "New Branch Name Template"
+msgstr "Új branch név sablon"
+
+#: lib/option.tcl:305
+msgid "Failed to completely save options:"
+msgstr "Nem sikerült teljesen elmenteni a beállításokat:"
+
+#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
+msgid "Delete Remote Branch"
+msgstr "Távoli branch törlése"
+
+#: lib/remote_branch_delete.tcl:47
+msgid "From Repository"
+msgstr "Forrás repó"
+
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:118
+msgid "Remote:"
+msgstr "Távoli:"
+
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:133
+msgid "Arbitrary URL:"
+msgstr "Tetszőleges URL:"
+
+#: lib/remote_branch_delete.tcl:84
+msgid "Branches"
+msgstr "Branchek"
+
+#: lib/remote_branch_delete.tcl:109
+msgid "Delete Only If"
+msgstr "Törlés csak akkor ha"
+
+#: lib/remote_branch_delete.tcl:111
+msgid "Merged Into:"
+msgstr "Merge-ölt a következőbe:"
+
+#: lib/remote_branch_delete.tcl:119
+msgid "Always (Do not perform merge checks)"
+msgstr "Mindig (Ne végezzen merge vizsgálatokat)"
+
+#: lib/remote_branch_delete.tcl:152
+msgid "A branch is required for 'Merged Into'."
+msgstr "Egy branch szükséges a 'Merge-ölt a következőbe'-hez."
+
+#: lib/remote_branch_delete.tcl:189
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched the "
+"necessary commits.  Try fetching from %s first."
+msgstr ""
+"Egy vagy több merge teszt hibát jelzett, mivel nem töltöttük le a megfelelő "
+"commitokat. Próbáljunk meg letölteni a következőből: %s először."
+
+#: lib/remote_branch_delete.tcl:207
+msgid "Please select one or more branches to delete."
+msgstr "Válasszunk ki egy vagy több branchet törlésre."
+
+#: lib/remote_branch_delete.tcl:216
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"A törölt branchek visszaállítása nehéz.\n"
+"\n"
+"Töröljük a kiválasztott brancheket?"
+
+#: lib/remote_branch_delete.tcl:226
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr "Brancek törlése innen: %s"
+
+#: lib/remote_branch_delete.tcl:286
+msgid "No repository selected."
+msgstr "Nincs kiválasztott repó."
+
+#: lib/remote_branch_delete.tcl:291
+#, tcl-format
+msgid "Scanning %s..."
+msgstr "Keresés itt: %s..."
+
+# tcl-format
+#: lib/remote.tcl:162
+#, tcl-format
+msgid "Fetch from %s..."
+msgstr "Letöltés innen: %s..."
+
+#: lib/remote.tcl:172
+#, tcl-format
+msgid "Prune from %s..."
+msgstr "Törlés innen: %s..."
+
+#: lib/remote.tcl:206
+#, tcl-format
+msgid "Push to %s..."
+msgstr "Pusholás ide: %s..."
+
+#: lib/shortcut.tcl:26 lib/shortcut.tcl:74
+msgid "Cannot write script:"
+msgstr "Nem sikerült írni a scriptet:"
+
+#: lib/shortcut.tcl:149
+msgid "Cannot write icon:"
+msgstr "Nem sikerült írni az ikont:"
+
+#: lib/status_bar.tcl:58
+#, tcl-format
+msgid "%s ... %i of %i %s (%2i%%)"
+msgstr "%s ... %i / %i %s (%2i%%)"
+
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "Új változások letöltése innen: %s"
+
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "A %s repóból törölt követő branchek törlése"
+
+#: lib/transport.tcl:26
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "Változások pusholása ide: %s"
+
+#: lib/transport.tcl:68
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "Pusholás: %s %s, ide: %s"
+
+#: lib/transport.tcl:84
+msgid "Push Branches"
+msgstr "Branchek pusholása"
+
+#: lib/transport.tcl:98
+msgid "Source Branches"
+msgstr "Forrás branchek"
+
+#: lib/transport.tcl:115
+msgid "Destination Repository"
+msgstr "Cél repó"
+
+#: lib/transport.tcl:153
+msgid "Transfer Options"
+msgstr "Átviteli opciók"
+
+#: lib/transport.tcl:155
+msgid "Use thin pack (for slow network connections)"
+msgstr "Vékony csomagok használata (lassú hálózati kapcsolatok számára)"
+
+#: lib/transport.tcl:159
+msgid "Include tags"
+msgstr "Tageket is"
+
+#~ msgid "Add To Commit"
+#~ msgstr "Hozzáadás a commithoz"
+
+#~ msgid "Add Existing To Commit"
+#~ msgstr "Hozzáadás létező commithoz"
+
+#~ msgid "Running miga..."
+#~ msgstr "A miga futtatása..."
+
+#~ msgid "Add Existing"
+#~ msgstr "Létező hozzáadása"
+
+#~ msgid ""
+#~ "Abort commit?\n"
+#~ "\n"
+#~ "Aborting the current commit will cause *ALL* uncommitted changes to be "
+#~ "lost.\n"
+#~ "\n"
+#~ "Continue with aborting the current commit?"
+#~ msgstr ""
+#~ "Megszakítjuk a commitot?\n"
+#~ "\n"
+#~ "A jelenlegi commit megszakítása *MINDEN* nem commitolt változtatás "
+#~ "elvesztését jelenti.\n"
+#~ "\n"
+#~ "Folytatjuk a jelenlegi commit megszakítását?"
+
+#~ msgid "Aborting... please wait..."
+#~ msgstr "Megszakítás... várjunk..."
-- 
1.5.3.2.g46909


--8323584-704432622-1188751042=:28586--
