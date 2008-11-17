From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Update Hungarian translation. 100% completed.
Date: Mon, 17 Nov 2008 23:11:43 +0100
Message-ID: <1226959903-12327-1-git-send-email-vmiklos@frugalware.org>
References: <20081116215822.GF2932@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 17 23:12:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2CKA-0007Qk-KC
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 23:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbYKQWKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 17:10:45 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbYKQWKo
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 17:10:44 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36169 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbYKQWKl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 17:10:41 -0500
Received: from vmobile.example.net (dsl5401C78D.pool.t-online.hu [84.1.199.141])
	by yugo.frugalware.org (Postfix) with ESMTPA id 972F9446CCF;
	Mon, 17 Nov 2008 23:10:37 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D705713E2C; Mon, 17 Nov 2008 23:11:43 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <20081116215822.GF2932@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101250>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 po/hu.po | 1255 +++++++++++++++++++++++++++++++++++++++++++++---------=
--------
 1 files changed, 918 insertions(+), 337 deletions(-)

diff --git a/po/hu.po b/po/hu.po
index 28760ed..8ec4339 100644
--- a/po/hu.po
+++ b/po/hu.po
@@ -7,8 +7,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui-i 18n\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-03-14 07:18+0100\n"
-"PO-Revision-Date: 2008-03-14 17:24+0100\n"
+"POT-Creation-Date: 2008-11-16 13:56-0800\n"
+"PO-Revision-Date: 2008-11-17 23:03+0100\n"
 "Last-Translator: Miklos Vajna <vmiklos@frugalware.org>\n"
 "Language-Team: Hungarian\n"
 "MIME-Version: 1.0\n"
@@ -16,33 +16,33 @@ msgstr ""
 "Content-Transfer-Encoding: 8bit\n"
 "Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
=20
-#: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.=
sh:744
-#: git-gui.sh:763
+#: git-gui.sh:41 git-gui.sh:737 git-gui.sh:751 git-gui.sh:764 git-gui.=
sh:847
+#: git-gui.sh:866
 msgid "git-gui: fatal error"
 msgstr "git-gui: v=C3=A9gzetes hiba"
=20
-#: git-gui.sh:593
+#: git-gui.sh:689
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "=C3=89rv=C3=A9nytelen font lett megadva itt: %s:"
=20
-#: git-gui.sh:620
+#: git-gui.sh:723
 msgid "Main Font"
 msgstr "F=C5=91 bet=C5=B1t=C3=ADpus"
=20
-#: git-gui.sh:621
+#: git-gui.sh:724
 msgid "Diff/Console Font"
 msgstr "Diff/konzol bet=C5=B1t=C3=ADpus"
=20
-#: git-gui.sh:635
+#: git-gui.sh:738
 msgid "Cannot find git in PATH."
 msgstr "A git nem tal=C3=A1lhat=C3=B3 a PATH-ban."
=20
-#: git-gui.sh:662
+#: git-gui.sh:765
 msgid "Cannot parse Git version string:"
 msgstr "Nem =C3=A9rtelmezhet=C5=91 a Git verzi=C3=B3 sztring:"
=20
-#: git-gui.sh:680
+#: git-gui.sh:783
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -61,379 +61,445 @@ msgstr ""
 "\n"
 "Felt=C3=A9telezhetj=C3=BCk, hogy a(z) '%s' verzi=C3=B3ja legal=C3=A1b=
b 1.5.0?\n"
=20
-#: git-gui.sh:918
+#: git-gui.sh:1062
 msgid "Git directory not found:"
 msgstr "A Git k=C3=B6nyvt=C3=A1r nem tal=C3=A1lhat=C3=B3:"
=20
-#: git-gui.sh:925
+#: git-gui.sh:1069
 msgid "Cannot move to top of working directory:"
 msgstr "Nem lehet a munkak=C3=B6nyvt=C3=A1r tetej=C3=A9re l=C3=A9pni:"
=20
-#: git-gui.sh:932
+#: git-gui.sh:1076
 msgid "Cannot use funny .git directory:"
 msgstr "Nem haszn=C3=A1lhat=C3=B3 vicces .git k=C3=B6nyvt=C3=A1r:"
=20
-#: git-gui.sh:937
+#: git-gui.sh:1081
 msgid "No working directory"
 msgstr "Nincs munkak=C3=B6nyvt=C3=A1r"
=20
-#: git-gui.sh:1084 lib/checkout_op.tcl:283
+#: git-gui.sh:1247 lib/checkout_op.tcl:305
 msgid "Refreshing file status..."
 msgstr "A f=C3=A1jlok st=C3=A1tusz=C3=A1nak friss=C3=ADt=C3=A9se..."
=20
-#: git-gui.sh:1149
+#: git-gui.sh:1303
 msgid "Scanning for modified files ..."
 msgstr "M=C3=B3dos=C3=ADtott f=C3=A1jlok keres=C3=A9se ..."
=20
-#: git-gui.sh:1324 lib/browser.tcl:246
+#: git-gui.sh:1367
+msgid "Calling prepare-commit-msg hook..."
+msgstr "A prepare-commit-msg hurok megh=C3=ADv=C3=A1sa..."
+
+#: git-gui.sh:1384
+msgid "Commit declined by prepare-commit-msg hook."
+msgstr "A commitot megakad=C3=A1lyozta a prepare-commit-msg hurok."
+
+#: git-gui.sh:1542 lib/browser.tcl:246
 msgid "Ready."
 msgstr "K=C3=A9sz."
=20
-#: git-gui.sh:1590
+#: git-gui.sh:1819
 msgid "Unmodified"
 msgstr "Nem m=C3=B3dos=C3=ADtott"
=20
-#: git-gui.sh:1592
+#: git-gui.sh:1821
 msgid "Modified, not staged"
 msgstr "M=C3=B3dos=C3=ADtott, de nem kiv=C3=A1lasztott"
=20
-#: git-gui.sh:1593 git-gui.sh:1598
+#: git-gui.sh:1822 git-gui.sh:1830
 msgid "Staged for commit"
 msgstr "Kiv=C3=A1lasztva commitol=C3=A1sra"
=20
-#: git-gui.sh:1594 git-gui.sh:1599
+#: git-gui.sh:1823 git-gui.sh:1831
 msgid "Portions staged for commit"
 msgstr "R=C3=A9szek kiv=C3=A1lasztva commitol=C3=A1sra"
=20
-#: git-gui.sh:1595 git-gui.sh:1600
+#: git-gui.sh:1824 git-gui.sh:1832
 msgid "Staged for commit, missing"
 msgstr "Kiv=C3=A1lasztva commitol=C3=A1sra, hi=C3=A1nyz=C3=B3"
=20
-#: git-gui.sh:1597
+#: git-gui.sh:1826
+msgid "File type changed, not staged"
+msgstr "F=C3=A1jl t=C3=ADpus megv=C3=A1ltozott, nem kiv=C3=A1lasztott"
+
+#: git-gui.sh:1827
+msgid "File type changed, staged"
+msgstr "A f=C3=A1jlt=C3=ADpus megv=C3=A1ltozott, kiv=C3=A1lasztott"
+
+#: git-gui.sh:1829
 msgid "Untracked, not staged"
 msgstr "Nem k=C3=B6vetett, nem kiv=C3=A1lasztott"
=20
-#: git-gui.sh:1602
+#: git-gui.sh:1834
 msgid "Missing"
 msgstr "Hi=C3=A1nyz=C3=B3"
=20
-#: git-gui.sh:1603
+#: git-gui.sh:1835
 msgid "Staged for removal"
 msgstr "Kiv=C3=A1lasztva elt=C3=A1vol=C3=ADt=C3=A1sra"
=20
-#: git-gui.sh:1604
+#: git-gui.sh:1836
 msgid "Staged for removal, still present"
 msgstr "Kiv=C3=A1lasztva elt=C3=A1vol=C3=ADt=C3=A1sra, jelenleg is el=C3=
=A9rhet=C5=91"
=20
-#: git-gui.sh:1606 git-gui.sh:1607 git-gui.sh:1608 git-gui.sh:1609
+#: git-gui.sh:1838 git-gui.sh:1839 git-gui.sh:1840 git-gui.sh:1841
+#: git-gui.sh:1842 git-gui.sh:1843
 msgid "Requires merge resolution"
 msgstr "Merge felold=C3=A1s sz=C3=BCks=C3=A9ges"
=20
-#: git-gui.sh:1644
+#: git-gui.sh:1878
 msgid "Starting gitk... please wait..."
 msgstr "A gitk ind=C3=ADt=C3=A1sa... v=C3=A1rjunk..."
=20
-#: git-gui.sh:1653
-#, tcl-format
-msgid ""
-"Unable to start gitk:\n"
-"\n"
-"%s does not exist"
-msgstr ""
-"A gitk ind=C3=ADt=C3=A1sa sikertelen:\n"
-"\n"
-"A(z) %s nem l=C3=A9tezik"
+#: git-gui.sh:1887
+msgid "Couldn't find gitk in PATH"
+msgstr "A gitk nem tal=C3=A1lhat=C3=B3 a PATH-ban."
=20
-#: git-gui.sh:1860 lib/choose_repository.tcl:36
+#: git-gui.sh:2280 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "Rep=C3=B3"
=20
-#: git-gui.sh:1861
+#: git-gui.sh:2281
 msgid "Edit"
 msgstr "Szerkeszt=C3=A9s"
=20
-#: git-gui.sh:1863 lib/choose_rev.tcl:561
+#: git-gui.sh:2283 lib/choose_rev.tcl:561
 msgid "Branch"
 msgstr "Branch"
=20
-#: git-gui.sh:1866 lib/choose_rev.tcl:548
+#: git-gui.sh:2286 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
 msgstr "Commit@@f=C5=91n=C3=A9v"
=20
-#: git-gui.sh:1869 lib/merge.tcl:120 lib/merge.tcl:149 lib/merge.tcl:1=
67
+#: git-gui.sh:2289 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "Merge"
=20
-#: git-gui.sh:1870 lib/choose_rev.tcl:557
+#: git-gui.sh:2290 lib/choose_rev.tcl:557
 msgid "Remote"
 msgstr "T=C3=A1voli"
=20
-#: git-gui.sh:1879
+#: git-gui.sh:2293
+msgid "Tools"
+msgstr "Eszk=C3=B6z=C3=B6k"
+
+#: git-gui.sh:2302
+msgid "Explore Working Copy"
+msgstr "Munkam=C3=A1solat felfedez=C3=A9se"
+
+#: git-gui.sh:2307
 msgid "Browse Current Branch's Files"
 msgstr "A jelenlegi branch f=C3=A1jljainak b=C3=B6ng=C3=A9sz=C3=A9se"
=20
-#: git-gui.sh:1883
+#: git-gui.sh:2311
 msgid "Browse Branch Files..."
 msgstr "A branch f=C3=A1jljainak b=C3=B6ng=C3=A9sz=C3=A9se..."
=20
-#: git-gui.sh:1888
+#: git-gui.sh:2316
 msgid "Visualize Current Branch's History"
 msgstr "A jelenlegi branch t=C3=B6rt=C3=A9net=C3=A9nek vizualiz=C3=A1l=
=C3=A1sa"
=20
-#: git-gui.sh:1892
+#: git-gui.sh:2320
 msgid "Visualize All Branch History"
 msgstr "Az =C3=B6sszes branch t=C3=B6rt=C3=A9net=C3=A9nek vizualiz=C3=A1=
l=C3=A1sa"
=20
-#: git-gui.sh:1899
+#: git-gui.sh:2327
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "A(z) %s branch f=C3=A1jljainak b=C3=B6ng=C3=A9sz=C3=A9se"
=20
-#: git-gui.sh:1901
+#: git-gui.sh:2329
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "A(z) %s branch t=C3=B6rt=C3=A9net=C3=A9nek vizualiz=C3=A1l=C3=A1=
sa"
=20
-#: git-gui.sh:1906 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2334 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Adatb=C3=A1zis statisztik=C3=A1k"
=20
-#: git-gui.sh:1909 lib/database.tcl:34
+#: git-gui.sh:2337 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "Adatb=C3=A1zis t=C3=B6m=C3=B6r=C3=ADt=C3=A9se"
=20
-#: git-gui.sh:1912
+#: git-gui.sh:2340
 msgid "Verify Database"
 msgstr "Adatb=C3=A1zis ellen=C5=91rz=C3=A9se"
=20
-#: git-gui.sh:1919 git-gui.sh:1923 git-gui.sh:1927 lib/shortcut.tcl:7
+#: git-gui.sh:2347 git-gui.sh:2351 git-gui.sh:2355 lib/shortcut.tcl:7
 #: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
 msgstr "Asztal ikon l=C3=A9trehoz=C3=A1sa"
=20
-#: git-gui.sh:1932 lib/choose_repository.tcl:177 lib/choose_repository=
=2Etcl:185
+#: git-gui.sh:2363 lib/choose_repository.tcl:183 lib/choose_repository=
=2Etcl:191
 msgid "Quit"
 msgstr "Kil=C3=A9p=C3=A9s"
=20
-#: git-gui.sh:1939
+#: git-gui.sh:2371
 msgid "Undo"
 msgstr "Visszavon=C3=A1s"
=20
-#: git-gui.sh:1942
+#: git-gui.sh:2374
 msgid "Redo"
 msgstr "M=C3=A9gis"
=20
-#: git-gui.sh:1946 git-gui.sh:2443
+#: git-gui.sh:2378 git-gui.sh:2923
 msgid "Cut"
 msgstr "Kiv=C3=A1g=C3=A1s"
=20
-#: git-gui.sh:1949 git-gui.sh:2446 git-gui.sh:2520 git-gui.sh:2614
+#: git-gui.sh:2381 git-gui.sh:2926 git-gui.sh:3000 git-gui.sh:3082
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "M=C3=A1sol=C3=A1s"
=20
-#: git-gui.sh:1952 git-gui.sh:2449
+#: git-gui.sh:2384 git-gui.sh:2929
 msgid "Paste"
 msgstr "Beilleszt=C3=A9s"
=20
-#: git-gui.sh:1955 git-gui.sh:2452 lib/branch_delete.tcl:26
+#: git-gui.sh:2387 git-gui.sh:2932 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "T=C3=B6rl=C3=A9s"
=20
-#: git-gui.sh:1959 git-gui.sh:2456 git-gui.sh:2618 lib/console.tcl:71
+#: git-gui.sh:2391 git-gui.sh:2936 git-gui.sh:3086 lib/console.tcl:71
 msgid "Select All"
 msgstr "Mindent kiv=C3=A1laszt"
=20
-#: git-gui.sh:1968
+#: git-gui.sh:2400
 msgid "Create..."
 msgstr "L=C3=A9trehoz=C3=A1s..."
=20
-#: git-gui.sh:1974
+#: git-gui.sh:2406
 msgid "Checkout..."
 msgstr "Checkout..."
=20
-#: git-gui.sh:1980
+#: git-gui.sh:2412
 msgid "Rename..."
 msgstr "=C3=81tnevez=C3=A9s..."
=20
-#: git-gui.sh:1985 git-gui.sh:2085
+#: git-gui.sh:2417
 msgid "Delete..."
 msgstr "T=C3=B6rl=C3=A9s..."
=20
-#: git-gui.sh:1990
+#: git-gui.sh:2422
 msgid "Reset..."
 msgstr "Vissza=C3=A1ll=C3=ADt=C3=A1s..."
=20
-#: git-gui.sh:2002 git-gui.sh:2389
+#: git-gui.sh:2432
+msgid "Done"
+msgstr "K=C3=A9sz"
+
+#: git-gui.sh:2434
+msgid "Commit@@verb"
+msgstr "Commit@@ige"
+
+#: git-gui.sh:2443 git-gui.sh:2864
 msgid "New Commit"
 msgstr "=C3=9Aj commit"
=20
-#: git-gui.sh:2010 git-gui.sh:2396
+#: git-gui.sh:2451 git-gui.sh:2871
 msgid "Amend Last Commit"
 msgstr "Utols=C3=B3 commit jav=C3=ADt=C3=A1sa"
=20
-#: git-gui.sh:2019 git-gui.sh:2356 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2461 git-gui.sh:2825 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "Keres=C3=A9s =C3=BAjra"
=20
-#: git-gui.sh:2025
+#: git-gui.sh:2467
 msgid "Stage To Commit"
 msgstr "Kiv=C3=A1laszt=C3=A1s commitol=C3=A1sra"
=20
-#: git-gui.sh:2031
+#: git-gui.sh:2473
 msgid "Stage Changed Files To Commit"
 msgstr "M=C3=B3dos=C3=ADtott f=C3=A1jlok kiv=C3=A1laszt=C3=A1sa commit=
ol=C3=A1sra"
=20
-#: git-gui.sh:2037
+#: git-gui.sh:2479
 msgid "Unstage From Commit"
 msgstr "Commitba val=C3=B3 kiv=C3=A1laszt=C3=A1s visszavon=C3=A1sa"
=20
-#: git-gui.sh:2042 lib/index.tcl:395
+#: git-gui.sh:2484 lib/index.tcl:410
 msgid "Revert Changes"
 msgstr "V=C3=A1ltoztat=C3=A1sok vissza=C3=A1ll=C3=ADt=C3=A1sa"
=20
-#: git-gui.sh:2049 git-gui.sh:2368 git-gui.sh:2467
+#: git-gui.sh:2491 git-gui.sh:3069
+msgid "Show Less Context"
+msgstr "Kevesebb k=C3=B6rnyezet mutat=C3=A1sa"
+
+#: git-gui.sh:2495 git-gui.sh:3073
+msgid "Show More Context"
+msgstr "T=C3=B6bb k=C3=B6rnyezet mutat=C3=A1sa"
+
+#: git-gui.sh:2502 git-gui.sh:2838 git-gui.sh:2947
 msgid "Sign Off"
 msgstr "Al=C3=A1=C3=ADr"
=20
-#: git-gui.sh:2053 git-gui.sh:2372
-msgid "Commit@@verb"
-msgstr "Commit@@ige"
-
-#: git-gui.sh:2064
+#: git-gui.sh:2518
 msgid "Local Merge..."
 msgstr "Helyi merge..."
=20
-#: git-gui.sh:2069
+#: git-gui.sh:2523
 msgid "Abort Merge..."
 msgstr "Merge megszak=C3=ADt=C3=A1sa..."
=20
-#: git-gui.sh:2081
+#: git-gui.sh:2535 git-gui.sh:2575
+msgid "Add..."
+msgstr "Hozz=C3=A1ad=C3=A1s..."
+
+#: git-gui.sh:2539
 msgid "Push..."
 msgstr "Push..."
=20
-#: git-gui.sh:2092 lib/choose_repository.tcl:41
-msgid "Apple"
-msgstr "Apple"
+#: git-gui.sh:2543
+msgid "Delete Branch..."
+msgstr "Branch t=C3=B6rl=C3=A9se..."
=20
-#: git-gui.sh:2095 git-gui.sh:2117 lib/about.tcl:14
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
+#: git-gui.sh:2553 git-gui.sh:2589 lib/about.tcl:14
+#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
 #, tcl-format
 msgid "About %s"
 msgstr "N=C3=A9vjegy: %s"
=20
-#: git-gui.sh:2099
+#: git-gui.sh:2557
 msgid "Preferences..."
 msgstr "Be=C3=A1ll=C3=ADt=C3=A1sok..."
=20
-#: git-gui.sh:2107 git-gui.sh:2639
+#: git-gui.sh:2565 git-gui.sh:3115
 msgid "Options..."
 msgstr "Opci=C3=B3k..."
=20
-#: git-gui.sh:2113 lib/choose_repository.tcl:47
+#: git-gui.sh:2576
+msgid "Remove..."
+msgstr "Elt=C3=A1vol=C3=ADt=C3=A1s..."
+
+#: git-gui.sh:2585 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr "Seg=C3=ADts=C3=A9g"
=20
-#: git-gui.sh:2154
+#: git-gui.sh:2611
 msgid "Online Documentation"
 msgstr "Online dokument=C3=A1ci=C3=B3"
=20
-#: git-gui.sh:2238
+#: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
+msgid "Show SSH Key"
+msgstr "SSH kulcs mutat=C3=A1sa"
+
+#: git-gui.sh:2707
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 "v=C3=A9gzetes hiba: nem =C3=A9rhet=C5=91 el a(z) %s =C3=BAtvonal: Nin=
cs ilyen f=C3=A1jl vagy k=C3=B6nyvt=C3=A1r"
=20
-#: git-gui.sh:2271
+#: git-gui.sh:2740
 msgid "Current Branch:"
 msgstr "Jelenlegi branch:"
=20
-#: git-gui.sh:2292
+#: git-gui.sh:2761
 msgid "Staged Changes (Will Commit)"
 msgstr "Kiv=C3=A1lasztott v=C3=A1ltoztat=C3=A1sok (commitolva lesz)"
=20
-#: git-gui.sh:2312
+#: git-gui.sh:2781
 msgid "Unstaged Changes"
 msgstr "Kiv=C3=A1lasztatlan v=C3=A1ltoztat=C3=A1sok"
=20
-#: git-gui.sh:2362
+#: git-gui.sh:2831
 msgid "Stage Changed"
 msgstr "V=C3=A1ltoztat=C3=A1sok kiv=C3=A1laszt=C3=A1sa"
=20
-#: git-gui.sh:2378 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2850 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
 msgstr "Push"
=20
-#: git-gui.sh:2408
+#: git-gui.sh:2885
 msgid "Initial Commit Message:"
 msgstr "Kezdeti commit =C3=BCzenet:"
=20
-#: git-gui.sh:2409
+#: git-gui.sh:2886
 msgid "Amended Commit Message:"
 msgstr "Jav=C3=ADt=C3=B3 commit =C3=BCzenet:"
=20
-#: git-gui.sh:2410
+#: git-gui.sh:2887
 msgid "Amended Initial Commit Message:"
 msgstr "Kezdeti jav=C3=ADt=C3=B3 commit =C3=BCzenet:"
=20
-#: git-gui.sh:2411
+#: git-gui.sh:2888
 msgid "Amended Merge Commit Message:"
 msgstr "Jav=C3=ADt=C3=B3 merge commit =C3=BCzenet:"
=20
-#: git-gui.sh:2412
+#: git-gui.sh:2889
 msgid "Merge Commit Message:"
 msgstr "Merge commit =C3=BCzenet:"
=20
-#: git-gui.sh:2413
+#: git-gui.sh:2890
 msgid "Commit Message:"
 msgstr "Commit =C3=BCzenet:"
=20
-#: git-gui.sh:2459 git-gui.sh:2622 lib/console.tcl:73
+#: git-gui.sh:2939 git-gui.sh:3090 lib/console.tcl:73
 msgid "Copy All"
 msgstr "=C3=96sszes m=C3=A1sol=C3=A1sa"
=20
-#: git-gui.sh:2483 lib/blame.tcl:107
+#: git-gui.sh:2963 lib/blame.tcl:104
 msgid "File:"
 msgstr "F=C3=A1jl:"
=20
-#: git-gui.sh:2589
-msgid "Apply/Reverse Hunk"
-msgstr "Hunk alkalmaz=C3=A1sa/vissza=C3=A1ll=C3=ADt=C3=A1sa"
-
-#: git-gui.sh:2595
-msgid "Show Less Context"
-msgstr "Kevesebb k=C3=B6rnyezet mutat=C3=A1sa"
-
-#: git-gui.sh:2602
-msgid "Show More Context"
-msgstr "T=C3=B6bb k=C3=B6rnyezet mutat=C3=A1sa"
-
-#: git-gui.sh:2610
+#: git-gui.sh:3078
 msgid "Refresh"
 msgstr "Friss=C3=ADt=C3=A9s"
=20
-#: git-gui.sh:2631
+#: git-gui.sh:3099
 msgid "Decrease Font Size"
 msgstr "Font m=C3=A9ret cs=C3=B6kkent=C3=A9se"
=20
-#: git-gui.sh:2635
+#: git-gui.sh:3103
 msgid "Increase Font Size"
 msgstr "F=C3=B6nt m=C3=A9ret n=C3=B6vel=C3=A9se"
=20
-#: git-gui.sh:2646
+#: git-gui.sh:3111 lib/blame.tcl:281
+msgid "Encoding"
+msgstr "K=C3=B3dol=C3=A1s"
+
+#: git-gui.sh:3122
+msgid "Apply/Reverse Hunk"
+msgstr "Hunk alkalmaz=C3=A1sa/vissza=C3=A1ll=C3=ADt=C3=A1sa"
+
+#: git-gui.sh:3127
+msgid "Apply/Reverse Line"
+msgstr "Sor alkalmaz=C3=A1sa/vissza=C3=A1ll=C3=ADt=C3=A1sa"
+
+#: git-gui.sh:3137
+msgid "Run Merge Tool"
+msgstr "Merge eszk=C3=B6z futtat=C3=A1sa"
+
+#: git-gui.sh:3142
+msgid "Use Remote Version"
+msgstr "T=C3=A1voli verzi=C3=B3 haszn=C3=A1lata"
+
+#: git-gui.sh:3146
+msgid "Use Local Version"
+msgstr "Helyi verzi=C3=B3 haszn=C3=A1lata"
+
+#: git-gui.sh:3150
+msgid "Revert To Base"
+msgstr "Vissza=C3=A1ll=C3=ADt=C3=A1s az alaphoz"
+
+#: git-gui.sh:3169
 msgid "Unstage Hunk From Commit"
 msgstr "Hunk t=C3=B6rl=C3=A9se commitb=C3=B3l"
=20
-#: git-gui.sh:2648
+#: git-gui.sh:3170
+msgid "Unstage Line From Commit"
+msgstr "A sor kiv=C3=A1laszt=C3=A1s=C3=A1nak t=C3=B6rl=C3=A9se"
+
+#: git-gui.sh:3172
 msgid "Stage Hunk For Commit"
 msgstr "Hunk kiv=C3=A1laszt=C3=A1sa commitba"
=20
-#: git-gui.sh:2667
+#: git-gui.sh:3173
+msgid "Stage Line For Commit"
+msgstr "Sor kiv=C3=A1laszt=C3=A1sa commitba"
+
+#: git-gui.sh:3196
 msgid "Initializing..."
 msgstr "Inicializ=C3=A1l=C3=A1s..."
=20
-#: git-gui.sh:2762
+#: git-gui.sh:3301
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -450,7 +516,7 @@ msgstr ""
 "ind=C3=ADtott folyamatok =C3=A1ltal:\n"
 "\n"
=20
-#: git-gui.sh:2792
+#: git-gui.sh:3331
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -460,7 +526,7 @@ msgstr ""
 "Ez a Cygwin =C3=A1ltal terjesztett Tcl bin=C3=A1risban\n"
 "l=C3=A9v=C5=91 ismert hiba miatt van."
=20
-#: git-gui.sh:2797
+#: git-gui.sh:3336
 #, tcl-format
 msgid ""
 "\n"
@@ -481,64 +547,108 @@ msgstr ""
 msgid "git-gui - a graphical user interface for Git."
 msgstr "git-gui - egy grafikus fel=C3=BClet a Githez."
=20
-#: lib/blame.tcl:77
+#: lib/blame.tcl:72
 msgid "File Viewer"
 msgstr "F=C3=A1jl n=C3=A9z=C5=91"
=20
-#: lib/blame.tcl:81
+#: lib/blame.tcl:78
 msgid "Commit:"
 msgstr "Commit:"
=20
-#: lib/blame.tcl:264
+#: lib/blame.tcl:271
 msgid "Copy Commit"
 msgstr "Commit m=C3=A1sol=C3=A1sa"
=20
-#: lib/blame.tcl:384
+#: lib/blame.tcl:275
+msgid "Find Text..."
+msgstr "Sz=C3=B6veg keres=C3=A9se..."
+
+#: lib/blame.tcl:284
+msgid "Do Full Copy Detection"
+msgstr "Teljes m=C3=A1solat-=C3=A9rz=C3=A9kel=C3=A9s bekapcsol=C3=A1sa=
"
+
+#: lib/blame.tcl:288
+msgid "Show History Context"
+msgstr "T=C3=B6rt=C3=A9neti k=C3=B6rnyezet mutat=C3=A1sa"
+
+#: lib/blame.tcl:291
+msgid "Blame Parent Commit"
+msgstr "Sz=C3=BCl=C5=91 commit vizsg=C3=A1lata"
+
+#: lib/blame.tcl:450
 #, tcl-format
 msgid "Reading %s..."
 msgstr "A(z) %s olvas=C3=A1sa..."
=20
-#: lib/blame.tcl:488
+#: lib/blame.tcl:557
 msgid "Loading copy/move tracking annotations..."
 msgstr "A m=C3=A1sol=C3=A1st/=C3=A1tnevez=C3=A9st k=C3=B6vet=C5=91 ann=
ot=C3=A1ci=C3=B3k bet=C3=B6lt=C3=A9se..."
=20
-#: lib/blame.tcl:508
+#: lib/blame.tcl:577
 msgid "lines annotated"
 msgstr "sor annot=C3=A1lva"
=20
-#: lib/blame.tcl:689
+#: lib/blame.tcl:769
 msgid "Loading original location annotations..."
 msgstr "Az eredeti hely annot=C3=A1ci=C3=B3k bet=C3=B6lt=C3=A9se..."
=20
-#: lib/blame.tcl:692
+#: lib/blame.tcl:772
 msgid "Annotation complete."
 msgstr "Az annot=C3=A1ci=C3=B3 k=C3=A9sz."
=20
-#: lib/blame.tcl:746
+#: lib/blame.tcl:802
+msgid "Busy"
+msgstr "Elfoglalt"
+
+#: lib/blame.tcl:803
+msgid "Annotation process is already running."
+msgstr "Az annot=C3=A1ci=C3=B3s folyamat m=C3=A1r fut."
+
+#: lib/blame.tcl:842
+msgid "Running thorough copy detection..."
+msgstr "Futtat=C3=A1s m=C3=A1sol=C3=A1s-=C3=A9rz=C3=A9kel=C3=A9sen ker=
eszt=C3=BCl..."
+
+#: lib/blame.tcl:910
 msgid "Loading annotation..."
 msgstr "Az annot=C3=A1ci=C3=B3 bet=C3=B6lt=C3=A9se..."
=20
-#: lib/blame.tcl:802
+#: lib/blame.tcl:964
 msgid "Author:"
 msgstr "Szerz=C5=91:"
=20
-#: lib/blame.tcl:806
+#: lib/blame.tcl:968
 msgid "Committer:"
 msgstr "Commiter:"
=20
-#: lib/blame.tcl:811
+#: lib/blame.tcl:973
 msgid "Original File:"
 msgstr "Eredeti f=C3=A1jl:"
=20
-#: lib/blame.tcl:925
+#: lib/blame.tcl:1021
+msgid "Cannot find HEAD commit:"
+msgstr "Nem tal=C3=A1lhat=C3=B3 a HEAD commit:"
+
+#: lib/blame.tcl:1076
+msgid "Cannot find parent commit:"
+msgstr "Nem tal=C3=A1lhat=C3=B3 a sz=C3=BCl=C5=91 commit:"
+
+#: lib/blame.tcl:1091
+msgid "Unable to display parent"
+msgstr "Nem lehet megjelen=C3=ADteni a sz=C3=BCl=C5=91t"
+
+#: lib/blame.tcl:1092 lib/diff.tcl:297
+msgid "Error loading diff:"
+msgstr "Hiba a diff bet=C3=B6lt=C3=A9se k=C3=B6zben:"
+
+#: lib/blame.tcl:1232
 msgid "Originally By:"
 msgstr "Eredeti szerz=C5=91:"
=20
-#: lib/blame.tcl:931
+#: lib/blame.tcl:1238
 msgid "In File:"
 msgstr "Ebben a f=C3=A1jlban:"
=20
-#: lib/blame.tcl:936
+#: lib/blame.tcl:1243
 msgid "Copied Or Moved Here By:"
 msgstr "Ide m=C3=A1solta vagy helyezte:"
=20
@@ -552,16 +662,18 @@ msgstr "Checkout"
=20
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
-#: lib/checkout_op.tcl:522 lib/choose_font.tcl:43 lib/merge.tcl:171
-#: lib/option.tcl:103 lib/remote_branch_delete.tcl:42 lib/transport.tc=
l:97
+#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:172
+#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.t=
cl:42
+#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
+#: lib/transport.tcl:97
 msgid "Cancel"
 msgstr "M=C3=A9gsem"
=20
-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:32=
8
 msgid "Revision"
 msgstr "Rev=C3=ADzi=C3=B3"
=20
-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
242
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
280
 msgid "Options"
 msgstr "Opci=C3=B3k"
=20
@@ -581,7 +693,7 @@ msgstr "Branch l=C3=A9trehoz=C3=A1sa"
 msgid "Create New Branch"
 msgstr "=C3=9Aj branch l=C3=A9trehoz=C3=A1sa"
=20
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:371
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:377
 msgid "Create"
 msgstr "L=C3=A9trehoz=C3=A1s"
=20
@@ -589,7 +701,7 @@ msgstr "L=C3=A9trehoz=C3=A1s"
 msgid "Branch Name"
 msgstr "Branch neve"
=20
-#: lib/branch_create.tcl:43
+#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
 msgid "Name:"
 msgstr "N=C3=A9v:"
=20
@@ -613,7 +725,7 @@ msgstr "Nem"
 msgid "Fast Forward Only"
 msgstr "Csak fast forward"
=20
-#: lib/branch_create.tcl:85 lib/checkout_op.tcl:514
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:536
 msgid "Reset"
 msgstr "Vissza=C3=A1ll=C3=ADt=C3=A1s"
=20
@@ -703,7 +815,7 @@ msgstr "=C3=9Aj n=C3=A9v:"
 msgid "Please select a branch to rename."
 msgstr "V=C3=A1lasszunk ki egy =C3=A1tnevezend=C5=91 branchet."
=20
-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:201
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr "A(z) '%s' branch m=C3=A1r l=C3=A9tezik."
@@ -734,32 +846,39 @@ msgstr "[Fel a sz=C3=BCl=C5=91h=C3=B6z]"
 msgid "Browse Branch Files"
 msgstr "A branch f=C3=A1jljainak b=C3=B6ng=C3=A9sz=C3=A9se"
=20
-#: lib/browser.tcl:278 lib/choose_repository.tcl:387
-#: lib/choose_repository.tcl:474 lib/choose_repository.tcl:484
-#: lib/choose_repository.tcl:987
+#: lib/browser.tcl:278 lib/choose_repository.tcl:394
+#: lib/choose_repository.tcl:480 lib/choose_repository.tcl:491
+#: lib/choose_repository.tcl:995
 msgid "Browse"
 msgstr "B=C3=B6ng=C3=A9sz=C3=A9s"
=20
-#: lib/checkout_op.tcl:79
+#: lib/checkout_op.tcl:84
 #, tcl-format
 msgid "Fetching %s from %s"
 msgstr "A(z) %s let=C3=B6lt=C3=A9se innen: %s"
=20
-#: lib/checkout_op.tcl:127
+#: lib/checkout_op.tcl:132
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
 msgstr "v=C3=A9gzetes: Nem lehet feloldani a k=C3=B6vetkez=C5=91t: %s"
=20
-#: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
+#: lib/checkout_op.tcl:145 lib/console.tcl:81 lib/database.tcl:31
+#: lib/sshkey.tcl:53
 msgid "Close"
 msgstr "Bez=C3=A1r=C3=A1s"
=20
-#: lib/checkout_op.tcl:169
+#: lib/checkout_op.tcl:174
 #, tcl-format
 msgid "Branch '%s' does not exist."
 msgstr "A(z) '%s' branch nem l=C3=A9tezik."
=20
-#: lib/checkout_op.tcl:206
+#: lib/checkout_op.tcl:193
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr ""
+"Nem siker=C3=BClt be=C3=A1ll=C3=ADtani az egyszer=C5=B1s=C3=ADtett gi=
t-pull-t a(z) '%s' sz=C3=A1m=C3=A1ra."
+
+#: lib/checkout_op.tcl:228
 #, tcl-format
 msgid ""
 "Branch '%s' already exists.\n"
@@ -772,21 +891,21 @@ msgstr ""
 "Nem lehet fast-forwardolni a k=C3=B6vetkez=C5=91h=C3=B6z: %s.\n"
 "Egy merge sz=C3=BCks=C3=A9ges."
=20
-#: lib/checkout_op.tcl:220
+#: lib/checkout_op.tcl:242
 #, tcl-format
 msgid "Merge strategy '%s' not supported."
 msgstr "A(z) '%s' merge strategy nem t=C3=A1mogatott."
=20
-#: lib/checkout_op.tcl:239
+#: lib/checkout_op.tcl:261
 #, tcl-format
 msgid "Failed to update '%s'."
 msgstr "Nem siker=C3=BClt friss=C3=ADteni a k=C3=B6vetkez=C5=91t: '%s'=
=2E"
=20
-#: lib/checkout_op.tcl:251
+#: lib/checkout_op.tcl:273
 msgid "Staging area (index) is already locked."
 msgstr "A kiv=C3=A1laszt=C3=A1si ter=C3=BClet (index) m=C3=A1r z=C3=A1=
rolva van."
=20
-#: lib/checkout_op.tcl:266
+#: lib/checkout_op.tcl:288
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -803,30 +922,30 @@ msgstr ""
 "\n"
 "Az =C3=BAjrakeres=C3=A9s most automatikusan el fog indulni.\n"
=20
-#: lib/checkout_op.tcl:322
+#: lib/checkout_op.tcl:344
 #, tcl-format
 msgid "Updating working directory to '%s'..."
 msgstr "A munkk=C3=B6nyvt=C3=A1r frissi=C3=ADt=C3=A9se a k=C3=B6vetkez=
=C5=91re: '%s'..."
=20
-#: lib/checkout_op.tcl:323
+#: lib/checkout_op.tcl:345
 msgid "files checked out"
 msgstr "f=C3=A1jl friss=C3=ADtve"
=20
-#: lib/checkout_op.tcl:353
+#: lib/checkout_op.tcl:375
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr "A(z) '%s' checkoutja megszak=C3=ADtva (f=C3=A1jlszint=C5=B1 me=
rge-=C3=B6l=C3=A9s sz=C3=BCks=C3=A9ges)."
=20
-#: lib/checkout_op.tcl:354
+#: lib/checkout_op.tcl:376
 msgid "File level merge required."
 msgstr "F=C3=A1jlszint=C5=B1 merge-=C3=B6l=C3=A9s sz=C3=BCks=C3=A9ges.=
"
=20
-#: lib/checkout_op.tcl:358
+#: lib/checkout_op.tcl:380
 #, tcl-format
 msgid "Staying on branch '%s'."
 msgstr "Jelenleg a(z) '%s' branchen."
=20
-#: lib/checkout_op.tcl:429
+#: lib/checkout_op.tcl:451
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
@@ -838,31 +957,31 @@ msgstr ""
 "Ha egy branchen szeretn=C3=A9nk lenni, hozzunk l=C3=A9tre egyet az 'E=
z a lev=C3=A1lasztott "
 "checkout'-b=C3=B3l."
=20
-#: lib/checkout_op.tcl:446 lib/checkout_op.tcl:450
+#: lib/checkout_op.tcl:468 lib/checkout_op.tcl:472
 #, tcl-format
 msgid "Checked out '%s'."
 msgstr "'%s' kifejtve."
=20
-#: lib/checkout_op.tcl:478
+#: lib/checkout_op.tcl:500
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
 msgstr ""
 "A(z) '%s' -> '%s' vissza=C3=A1ll=C3=ADt=C3=A1s a k=C3=B6vetkez=C5=91 =
commitok elveszt=C3=A9s=C3=A9t jelenti:"
=20
-#: lib/checkout_op.tcl:500
+#: lib/checkout_op.tcl:522
 msgid "Recovering lost commits may not be easy."
 msgstr "Az elveszett commitok helyre=C3=A1ll=C3=ADt=C3=A1sa nem biztos=
, hogy egyszer=C5=B1."
=20
-#: lib/checkout_op.tcl:505
+#: lib/checkout_op.tcl:527
 #, tcl-format
 msgid "Reset '%s'?"
 msgstr "Vissza=C3=A1ll=C3=ADtjuk a k=C3=B6vetkez=C5=91t: '%s'?"
=20
-#: lib/checkout_op.tcl:510 lib/merge.tcl:163
+#: lib/checkout_op.tcl:532 lib/merge.tcl:164 lib/tools_dlg.tcl:343
 msgid "Visualize"
 msgstr "Vizualiz=C3=A1l=C3=A1s"
=20
-#: lib/checkout_op.tcl:578
+#: lib/checkout_op.tcl:600
 #, tcl-format
 msgid ""
 "Failed to set current branch.\n"
@@ -907,223 +1026,227 @@ msgstr ""
 msgid "Git Gui"
 msgstr "Git Gui"
=20
-#: lib/choose_repository.tcl:81 lib/choose_repository.tcl:376
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:382
 msgid "Create New Repository"
 msgstr "=C3=9Aj rep=C3=B3 l=C3=A9trehoz=C3=A1sa"
=20
-#: lib/choose_repository.tcl:87
+#: lib/choose_repository.tcl:93
 msgid "New..."
 msgstr "=C3=9Aj..."
=20
-#: lib/choose_repository.tcl:94 lib/choose_repository.tcl:460
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:465
 msgid "Clone Existing Repository"
 msgstr "L=C3=A9tez=C5=91 rep=C3=B3 m=C3=A1sol=C3=A1sa"
=20
-#: lib/choose_repository.tcl:100
+#: lib/choose_repository.tcl:106
 msgid "Clone..."
 msgstr "M=C3=A1sol=C3=A1s..."
=20
-#: lib/choose_repository.tcl:107 lib/choose_repository.tcl:976
+#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:983
 msgid "Open Existing Repository"
 msgstr "L=C3=A9tez=C5=91 k=C3=B6nyvt=C3=A1r megnyit=C3=A1sa"
=20
-#: lib/choose_repository.tcl:113
+#: lib/choose_repository.tcl:119
 msgid "Open..."
 msgstr "Meggyit=C3=A1s..."
=20
-#: lib/choose_repository.tcl:126
+#: lib/choose_repository.tcl:132
 msgid "Recent Repositories"
 msgstr "Legut=C3=B3bbi rep=C3=B3k"
=20
-#: lib/choose_repository.tcl:132
+#: lib/choose_repository.tcl:138
 msgid "Open Recent Repository:"
 msgstr "Legut=C3=B3bbi rep=C3=B3k megnyit=C3=A1sa:"
=20
-#: lib/choose_repository.tcl:296 lib/choose_repository.tcl:303
-#: lib/choose_repository.tcl:310
+#: lib/choose_repository.tcl:302 lib/choose_repository.tcl:309
+#: lib/choose_repository.tcl:316
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "Nem siker=C3=BClt letrehozni a(z) %s rep=C3=B3t:"
=20
-#: lib/choose_repository.tcl:381 lib/choose_repository.tcl:478
+#: lib/choose_repository.tcl:387
 msgid "Directory:"
 msgstr "K=C3=B6nyvt=C3=A1r:"
=20
-#: lib/choose_repository.tcl:412 lib/choose_repository.tcl:537
-#: lib/choose_repository.tcl:1011
+#: lib/choose_repository.tcl:417 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1017
 msgid "Git Repository"
 msgstr "Git rep=C3=B3"
=20
-#: lib/choose_repository.tcl:437
+#: lib/choose_repository.tcl:442
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "A(z) '%s' k=C3=B6nyvt=C3=A1r m=C3=A1r l=C3=A9tezik."
=20
-#: lib/choose_repository.tcl:441
+#: lib/choose_repository.tcl:446
 #, tcl-format
 msgid "File %s already exists."
 msgstr "A(z) '%s' f=C3=A1jl m=C3=A1r l=C3=A9tezik."
=20
-#: lib/choose_repository.tcl:455
+#: lib/choose_repository.tcl:460
 msgid "Clone"
 msgstr "Bez=C3=A1r=C3=A1s"
=20
-#: lib/choose_repository.tcl:468
-msgid "URL:"
-msgstr "URL:"
+#: lib/choose_repository.tcl:473
+msgid "Source Location:"
+msgstr "Forr=C3=A1s helye:"
=20
-#: lib/choose_repository.tcl:489
+#: lib/choose_repository.tcl:484
+msgid "Target Directory:"
+msgstr "C=C3=A9l k=C3=B6nyvt=C3=A1r:"
+
+#: lib/choose_repository.tcl:496
 msgid "Clone Type:"
 msgstr "M=C3=A1sol=C3=A1s t=C3=ADpusa:"
=20
-#: lib/choose_repository.tcl:495
+#: lib/choose_repository.tcl:502
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "=C3=81ltal=C3=A1nos (Gyors, f=C3=A9lig-redund=C3=A1ns, hardlin=
kek)"
=20
-#: lib/choose_repository.tcl:501
+#: lib/choose_repository.tcl:508
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "Teljes m=C3=A1sol=C3=A1s (Lassabb, redund=C3=A1ns biztons=C3=A1=
gi ment=C3=A9s)"
=20
-#: lib/choose_repository.tcl:507
+#: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "Megosztott (Leggyorsabb, nem aj=C3=A1nlott, nincs ment=C3=A9s)=
"
=20
-#: lib/choose_repository.tcl:543 lib/choose_repository.tcl:590
-#: lib/choose_repository.tcl:736 lib/choose_repository.tcl:806
-#: lib/choose_repository.tcl:1017 lib/choose_repository.tcl:1025
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:743 lib/choose_repository.tcl:813
+#: lib/choose_repository.tcl:1023 lib/choose_repository.tcl:1031
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "Nem Git rep=C3=B3: %s"
=20
-#: lib/choose_repository.tcl:579
+#: lib/choose_repository.tcl:586
 msgid "Standard only available for local repository."
 msgstr "A standard csak helyi rep=C3=B3kra =C3=A9rhet=C5=91 el."
=20
-#: lib/choose_repository.tcl:583
+#: lib/choose_repository.tcl:590
 msgid "Shared only available for local repository."
 msgstr "A megosztott csak helyi rep=C3=B3kra =C3=A9rhet=C5=91 el."
=20
-#: lib/choose_repository.tcl:604
+#: lib/choose_repository.tcl:611
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "A(z) '%s' hely m=C3=A1r l=C3=A9tezik."
=20
-#: lib/choose_repository.tcl:615
+#: lib/choose_repository.tcl:622
 msgid "Failed to configure origin"
 msgstr "Nem siker=C3=BClt be=C3=A1ll=C3=ADtani az origint"
=20
-#: lib/choose_repository.tcl:627
+#: lib/choose_repository.tcl:634
 msgid "Counting objects"
 msgstr "Objektumok sz=C3=A1mol=C3=A1sa"
=20
-#: lib/choose_repository.tcl:628
+#: lib/choose_repository.tcl:635
 msgid "buckets"
 msgstr "v=C3=B6dr=C3=B6k"
=20
-#: lib/choose_repository.tcl:652
+#: lib/choose_repository.tcl:659
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "Nem siker=C3=BClt m=C3=A1solni az objects/info/alternates-t: %=
s"
=20
-#: lib/choose_repository.tcl:688
+#: lib/choose_repository.tcl:695
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "Semmi m=C3=A1solni val=C3=B3 nincs innen: %s"
=20
-#: lib/choose_repository.tcl:690 lib/choose_repository.tcl:904
-#: lib/choose_repository.tcl:916
+#: lib/choose_repository.tcl:697 lib/choose_repository.tcl:911
+#: lib/choose_repository.tcl:923
 msgid "The 'master' branch has not been initialized."
 msgstr "A 'master' branch nincs inicializ=C3=A1lva."
=20
-#: lib/choose_repository.tcl:703
+#: lib/choose_repository.tcl:710
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "Nem =C3=A9rhet=C5=91ek el hardlinkek.  M=C3=A1sol=C3=A1s haszn=
=C3=A1lata."
=20
-#: lib/choose_repository.tcl:715
+#: lib/choose_repository.tcl:722
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "M=C3=A1sol=C3=A1s innen: %s"
=20
-#: lib/choose_repository.tcl:746
+#: lib/choose_repository.tcl:753
 msgid "Copying objects"
 msgstr "Objektumok m=C3=A1sol=C3=A1sa"
=20
-#: lib/choose_repository.tcl:747
+#: lib/choose_repository.tcl:754
 msgid "KiB"
 msgstr "KiB"
=20
-#: lib/choose_repository.tcl:771
+#: lib/choose_repository.tcl:778
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "Nem siker=C3=BClt m=C3=A1solni az objektumot: %s"
=20
-#: lib/choose_repository.tcl:781
+#: lib/choose_repository.tcl:788
 msgid "Linking objects"
 msgstr "Objektumok =C3=B6sszef=C5=B1z=C3=A9se"
=20
-#: lib/choose_repository.tcl:782
+#: lib/choose_repository.tcl:789
 msgid "objects"
 msgstr "objektum"
=20
-#: lib/choose_repository.tcl:790
+#: lib/choose_repository.tcl:797
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "Nem siker=C3=BClt hardlinkelni az objektumot: %s"
=20
-#: lib/choose_repository.tcl:845
+#: lib/choose_repository.tcl:852
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
 msgstr ""
 "Nem siker=C3=BClt let=C3=B6lteni a branch-eket =C3=A9s az objektumoka=
t.  B=C5=91vebben a "
 "konzolos kimenetben."
=20
-#: lib/choose_repository.tcl:856
+#: lib/choose_repository.tcl:863
 msgid "Cannot fetch tags.  See console output for details."
 msgstr "Nem siker=C3=BClt let=C3=B6lteni a tageket.  B=C5=91vebben a k=
onzolos kimenetben."
=20
-#: lib/choose_repository.tcl:880
+#: lib/choose_repository.tcl:887
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr "Nem siker=C3=BClt meg=C3=A1llap=C3=ADtani a HEAD-et.  B=C5=91v=
ebben a konzolos kimenetben."
=20
-#: lib/choose_repository.tcl:889
+#: lib/choose_repository.tcl:896
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "Nem siker=C3=BClt tisz=C3=ADtani: %s."
=20
-#: lib/choose_repository.tcl:895
+#: lib/choose_repository.tcl:902
 msgid "Clone failed."
 msgstr "A m=C3=A1sol=C3=A1s nem siker=C3=BClt."
=20
-#: lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:909
 msgid "No default branch obtained."
 msgstr "Nincs alap=C3=A9rtelmezett branch."
=20
-#: lib/choose_repository.tcl:913
+#: lib/choose_repository.tcl:920
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "Nem siker=C3=BClt fel=C3=B6ldani a(z) %s objektumot commitk=C3=
=A9nt."
=20
-#: lib/choose_repository.tcl:925
+#: lib/choose_repository.tcl:932
 msgid "Creating working directory"
 msgstr "Munkak=C3=B6nyvt=C3=A1r l=C3=A9trehoz=C3=A1sa"
=20
-#: lib/choose_repository.tcl:926 lib/index.tcl:65 lib/index.tcl:127
-#: lib/index.tcl:193
+#: lib/choose_repository.tcl:933 lib/index.tcl:65 lib/index.tcl:128
+#: lib/index.tcl:196
 msgid "files"
 msgstr "f=C3=A1jl"
=20
-#: lib/choose_repository.tcl:955
+#: lib/choose_repository.tcl:962
 msgid "Initial file checkout failed."
 msgstr "A kezdeti f=C3=A1jl-kibont=C3=A1s sikertelen."
=20
-#: lib/choose_repository.tcl:971
+#: lib/choose_repository.tcl:978
 msgid "Open"
 msgstr "Megnyit=C3=A1s"
=20
-#: lib/choose_repository.tcl:981
+#: lib/choose_repository.tcl:988
 msgid "Repository:"
 msgstr "Rep=C3=B3:"
=20
-#: lib/choose_repository.tcl:1031
+#: lib/choose_repository.tcl:1037
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "Nem siker=C3=BClt megnyitni a(z) %s rep=C3=B3t:"
@@ -1223,7 +1346,7 @@ msgstr ""
 "\n"
 "Az =C3=BAjrakeres=C3=A9s most automatikusan el fog indulni.\n"
=20
-#: lib/commit.tcl:154
+#: lib/commit.tcl:156
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1236,7 +1359,7 @@ msgstr ""
 "A(z) %s f=C3=A1jlban =C3=BCtk=C3=B6z=C3=A9sek vannak. Egyszer azokat =
ki kell jav=C3=ADtani, majd "
 "hozz=C3=A1 ki kell v=C3=A1lasztani a f=C3=A1jlt miel=C5=91tt commitol=
ni lehetne.\n"
=20
-#: lib/commit.tcl:162
+#: lib/commit.tcl:164
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1247,7 +1370,7 @@ msgstr ""
 "\n"
 "A(z) %s f=C3=A1jlt nem tudja ez a program commitolni.\n"
=20
-#: lib/commit.tcl:170
+#: lib/commit.tcl:172
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1257,7 +1380,7 @@ msgstr ""
 "\n"
 "Legal=C3=A1bb egy f=C3=A1jl ki kell v=C3=A1lasztani, hogy commitolni =
lehessen.\n"
=20
-#: lib/commit.tcl:183
+#: lib/commit.tcl:187
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1275,45 +1398,45 @@ msgstr ""
 "- M=C3=A1sodik sor: =C3=9Cres\n"
 "- A t=C3=B6bbi sor: Le=C3=ADrja, hogy mi=C3=A9rt j=C3=B3 ez a v=C3=A1=
ltoztat=C3=A1s.\n"
=20
-#: lib/commit.tcl:207
+#: lib/commit.tcl:211
 #, tcl-format
 msgid "warning: Tcl does not support encoding '%s'."
 msgstr "figyelmeztet=C3=A9s: a Tcl nem t=C3=A1mogatja a(z) '%s' k=C3=B3=
dol=C3=A1st."
=20
-#: lib/commit.tcl:221
+#: lib/commit.tcl:227
 msgid "Calling pre-commit hook..."
 msgstr "A pre-commit hurok megh=C3=ADv=C3=A1sa..."
=20
-#: lib/commit.tcl:236
+#: lib/commit.tcl:242
 msgid "Commit declined by pre-commit hook."
 msgstr "A commitot megakad=C3=A1lyozta a pre-commit hurok. "
=20
-#: lib/commit.tcl:259
+#: lib/commit.tcl:265
 msgid "Calling commit-msg hook..."
 msgstr "A commit-msg hurok megh=C3=ADv=C3=A1sa..."
=20
-#: lib/commit.tcl:274
+#: lib/commit.tcl:280
 msgid "Commit declined by commit-msg hook."
 msgstr "A commiot megakad=C3=A1lyozta a commit-msg hurok."
=20
-#: lib/commit.tcl:287
+#: lib/commit.tcl:293
 msgid "Committing changes..."
 msgstr "A v=C3=A1ltoztat=C3=A1sok commitol=C3=A1sa..."
=20
-#: lib/commit.tcl:303
+#: lib/commit.tcl:309
 msgid "write-tree failed:"
 msgstr "a write-tree sikertelen:"
=20
-#: lib/commit.tcl:304 lib/commit.tcl:348 lib/commit.tcl:368
+#: lib/commit.tcl:310 lib/commit.tcl:354 lib/commit.tcl:374
 msgid "Commit failed."
 msgstr "A commit nem siker=C3=BClt."
=20
-#: lib/commit.tcl:321
+#: lib/commit.tcl:327
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "A(z) %s commit s=C3=A9r=C3=BCltnek t=C5=B1nik"
=20
-#: lib/commit.tcl:326
+#: lib/commit.tcl:332
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1327,19 +1450,19 @@ msgstr ""
 "\n"
 "Az =C3=BAjrakeres=C3=A9s most automatikusan el fog indulni.\n"
=20
-#: lib/commit.tcl:333
+#: lib/commit.tcl:339
 msgid "No changes to commit."
 msgstr "Nincs commitoland=C3=B3 v=C3=A1ltoztat=C3=A1s."
=20
-#: lib/commit.tcl:347
+#: lib/commit.tcl:353
 msgid "commit-tree failed:"
 msgstr "a commit-tree sikertelen:"
=20
-#: lib/commit.tcl:367
+#: lib/commit.tcl:373
 msgid "update-ref failed:"
 msgstr "az update-ref sikertelen:"
=20
-#: lib/commit.tcl:454
+#: lib/commit.tcl:461
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr "L=C3=A9trej=C3=B6tt a %s commit: %s"
@@ -1414,7 +1537,7 @@ msgstr ""
 msgid "Invalid date from Git: %s"
 msgstr "=C3=89rv=C3=A9nytelen d=C3=A1tum a Git-t=C5=91l: %s"
=20
-#: lib/diff.tcl:42
+#: lib/diff.tcl:59
 #, tcl-format
 msgid ""
 "No differences detected.\n"
@@ -1436,40 +1559,101 @@ msgstr ""
 "\n"
 "Egy =C3=BAjrakeres=C3=A9s fog indulni a hasonl=C3=B3 =C3=A1llapot=C3=BA=
 f=C3=A1jlok megtal=C3=A1l=C3=A1sa =C3=A9rdek=C3=A9ben."
=20
-#: lib/diff.tcl:81
+#: lib/diff.tcl:99
 #, tcl-format
 msgid "Loading diff of %s..."
 msgstr "A(z) %s diff-j=C3=A9nek bet=C3=B6lt=C3=A9se..."
=20
-#: lib/diff.tcl:114 lib/diff.tcl:184
+#: lib/diff.tcl:120
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+"HELYI: t=C3=B6r=C3=B6lve\n"
+"T=C3=81VOLI:\n"
+
+#: lib/diff.tcl:125
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+"T=C3=81VOLI: t=C3=B6r=C3=B6lve\n"
+"HELYI:\n"
+
+#: lib/diff.tcl:132
+msgid "LOCAL:\n"
+msgstr "HELYI:\n"
+
+#: lib/diff.tcl:135
+msgid "REMOTE:\n"
+msgstr "T=C3=81VOLI:\n"
+
+#: lib/diff.tcl:197 lib/diff.tcl:296
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "Nem lehet megjelen=C3=ADteni a k=C3=B6vetkez=C5=91t: %s"
=20
-#: lib/diff.tcl:115
+#: lib/diff.tcl:198
 msgid "Error loading file:"
 msgstr "Hiba a f=C3=A1jl bet=C3=B6lt=C3=A9se k=C3=B6zben:"
=20
-#: lib/diff.tcl:122
+#: lib/diff.tcl:205
 msgid "Git Repository (subproject)"
 msgstr "Git rep=C3=B3 (alprojekt)"
=20
-#: lib/diff.tcl:134
+#: lib/diff.tcl:217
 msgid "* Binary file (not showing content)."
 msgstr "* Bin=C3=A1ris f=C3=A1jl (tartalom elrejt=C3=A9se)."
=20
-#: lib/diff.tcl:185
-msgid "Error loading diff:"
-msgstr "Hiba a diff bet=C3=B6lt=C3=A9se k=C3=B6zben:"
+#: lib/diff.tcl:222
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"* Nem k=C3=B6vetett f=C3=A1jl %d b=C3=A1jttal.\n"
+"* Csak az els=C5=91 %d b=C3=A1jt mutat=C3=A1sa.\n"
=20
-#: lib/diff.tcl:303
+#: lib/diff.tcl:228
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"* Nem k=C3=B6vetett f=C3=A1jlt lev=C3=A1gta a(z) %s.\n"
+"* A teljes tartalom megjelen=C3=ADt=C3=A9s=C3=A9hez haszn=C3=A1ljunk =
k=C3=BCls=C5=91 sz=C3=B6vegszerkeszt=C5=91t.\n"
+
+#: lib/diff.tcl:436
 msgid "Failed to unstage selected hunk."
 msgstr "Nem visszavonni a hunk kiv=C3=A1laszt=C3=A1s=C3=A1t."
=20
-#: lib/diff.tcl:310
+#: lib/diff.tcl:443
 msgid "Failed to stage selected hunk."
 msgstr "Nem siker=C3=BClt kiv=C3=A1lasztani a hunkot."
=20
+#: lib/diff.tcl:509
+msgid "Failed to unstage selected line."
+msgstr "Nem siker=C3=BClt visszavonni a sor kiv=C3=A1laszt=C3=A1s=C3=A1=
t."
+
+#: lib/diff.tcl:517
+msgid "Failed to stage selected line."
+msgstr "Nem siker=C3=BClt kiv=C3=A1lasztani a sort."
+
+#: lib/encoding.tcl:443
+msgid "Default"
+msgstr "Alap=C3=A9rtelmez=C3=A9s"
+
+#: lib/encoding.tcl:448
+#, tcl-format
+msgid "System (%s)"
+msgstr "Rendszer (%s)"
+
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
+msgstr "M=C3=A1s"
+
 #: lib/error.tcl:20 lib/error.tcl:114
 msgid "error"
 msgstr "hiba"
@@ -1506,40 +1690,49 @@ msgstr "Folytat=C3=A1s"
 msgid "Unlock Index"
 msgstr "Index z=C3=A1rol=C3=A1s=C3=A1nak felold=C3=A1sa"
=20
-#: lib/index.tcl:282
+#: lib/index.tcl:287
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "A(z) %s commitba val=C3=B3 kiv=C3=A1laszt=C3=A1s=C3=A1nak viss=
zavon=C3=A1sa"
=20
-#: lib/index.tcl:313
+#: lib/index.tcl:326
 msgid "Ready to commit."
 msgstr "Commitol=C3=A1sra k=C3=A9sz."
=20
-#: lib/index.tcl:326
+#: lib/index.tcl:339
 #, tcl-format
 msgid "Adding %s"
 msgstr "A(z) %s hozz=C3=A1ad=C3=A1sa..."
=20
-#: lib/index.tcl:381
+#: lib/index.tcl:396
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "Vissza=C3=A1ll=C3=ADtja a v=C3=A1ltoztat=C3=A1sokat a(z) %s f=C3=
=A1jlban?"
=20
-#: lib/index.tcl:383
+#: lib/index.tcl:398
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "Vissza=C3=A1ll=C3=ADtja a v=C3=A1ltoztat=C3=A1sokat ebben e %i=
 f=C3=A1jlban?"
=20
-#: lib/index.tcl:391
+#: lib/index.tcl:406
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 "Minden nem kiv=C3=A1lasztott v=C3=A1ltoztat=C3=A1s el fog veszni ez=C3=
=A1ltal a vissza=C3=A1ll=C3=ADt=C3=A1s "
 "=C3=A1ltal."
=20
-#: lib/index.tcl:394
+#: lib/index.tcl:409
 msgid "Do Nothing"
 msgstr "Ne csin=C3=A1ljunk semmit"
=20
+#: lib/index.tcl:427
+msgid "Reverting selected files"
+msgstr "A kiv=C3=A1lasztott f=C3=A1jlok vissza=C3=A1ll=C3=ADt=C3=A1sa"
+
+#: lib/index.tcl:431
+#, tcl-format
+msgid "Reverting %s"
+msgstr "%s vissza=C3=A1ll=C3=ADt=C3=A1sa"
+
 #: lib/merge.tcl:13
 msgid ""
 "Cannot merge while amending.\n"
@@ -1568,7 +1761,7 @@ msgstr ""
 "\n"
 "Az =C3=BAjrakeres=C3=A9s most automatikusan el fog indulni.\n"
=20
-#: lib/merge.tcl:44
+#: lib/merge.tcl:45
 #, tcl-format
 msgid ""
 "You are in the middle of a conflicted merge.\n"
@@ -1585,7 +1778,7 @@ msgstr ""
 "Fel kell oldanunk =C5=91ket, kiv=C3=A1lasztani a f=C3=A1jlt, =C3=A9s =
commitolni hogy befejezz=C3=BCk "
 "a jelenlegi merge-t. Csak ezut=C3=A1n kezdhet=C3=BCnk el egy =C3=BAja=
bbat.\n"
=20
-#: lib/merge.tcl:54
+#: lib/merge.tcl:55
 #, tcl-format
 msgid ""
 "You are in the middle of a change.\n"
@@ -1602,34 +1795,34 @@ msgstr ""
 "El=C5=91sz=C3=B6r be kell fejezn=C3=BCnk a jelenlegi commitot, hogy e=
lkezdhess=C3=BCnk egy merge-"
 "t. Ez seg=C3=ADteni fog, hogy f=C3=A9lbeszak=C3=ADthassunk egy merge-=
t.\n"
=20
-#: lib/merge.tcl:106
+#: lib/merge.tcl:107
 #, tcl-format
 msgid "%s of %s"
 msgstr "%s / %s"
=20
-#: lib/merge.tcl:119
+#: lib/merge.tcl:120
 #, tcl-format
 msgid "Merging %s and %s..."
 msgstr "A(z) %s =C3=A9s a(z) %s merge-=C3=B6l=C3=A9se..."
=20
-#: lib/merge.tcl:130
+#: lib/merge.tcl:131
 msgid "Merge completed successfully."
 msgstr "A merge sikeresen befejez=C5=91d=C3=B6tt."
=20
-#: lib/merge.tcl:132
+#: lib/merge.tcl:133
 msgid "Merge failed.  Conflict resolution is required."
 msgstr "A merge sikertelen. Fel kell oldanunk az =C3=BCtk=C3=B6z=C3=A9=
seket."
=20
-#: lib/merge.tcl:157
+#: lib/merge.tcl:158
 #, tcl-format
 msgid "Merge Into %s"
 msgstr "Merge-=C3=B6l=C3=A9s a k=C3=B6vetkez=C5=91be: %s"
=20
-#: lib/merge.tcl:176
+#: lib/merge.tcl:177
 msgid "Revision To Merge"
 msgstr "Merge-=C3=B6lni sz=C3=A1nd=C3=A9kozott rev=C3=ADzi=C3=B3"
=20
-#: lib/merge.tcl:211
+#: lib/merge.tcl:212
 msgid ""
 "Cannot abort while amending.\n"
 "\n"
@@ -1639,7 +1832,7 @@ msgstr ""
 "\n"
 "Be kell fejezn=C3=BCnk ennek a commitnak a jav=C3=ADt=C3=A1s=C3=A1t.\=
n"
=20
-#: lib/merge.tcl:221
+#: lib/merge.tcl:222
 msgid ""
 "Abort merge?\n"
 "\n"
@@ -1654,7 +1847,7 @@ msgstr ""
 "\n"
 "Folytatjuk a jelenlegi merge megszak=C3=ADt=C3=A1s=C3=A1t?"
=20
-#: lib/merge.tcl:227
+#: lib/merge.tcl:228
 msgid ""
 "Reset changes?\n"
 "\n"
@@ -1669,111 +1862,325 @@ msgstr ""
 "\n"
 "Folytatjuk a jelenlegi m=C3=B3dos=C3=ADt=C3=A1sok visszavon=C3=A1s=C3=
=A1t?"
=20
-#: lib/merge.tcl:238
+#: lib/merge.tcl:239
 msgid "Aborting"
 msgstr "F=C3=A9lbeszak=C3=ADt=C3=A1s"
=20
-#: lib/merge.tcl:238
+#: lib/merge.tcl:239
 msgid "files reset"
 msgstr "f=C3=A1jl vissza=C3=A1ll=C3=ADtva"
=20
-#: lib/merge.tcl:265
+#: lib/merge.tcl:267
 msgid "Abort failed."
 msgstr "A f=C3=A9lbeszak=C3=ADt=C3=A1s nem siker=C3=BClt."
=20
-#: lib/merge.tcl:267
+#: lib/merge.tcl:269
 msgid "Abort completed.  Ready."
 msgstr "A megkeszak=C3=ADt=C3=A1s befejez=C5=91d=C3=B6tt. K=C3=A9sz."
=20
-#: lib/option.tcl:95
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
+msgstr "Felold=C3=A1s er=C5=91ltet=C3=A9se az alap verzi=C3=B3hoz?"
+
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
+msgstr "Felold=C3=A1s er=C5=91ltet=C3=A9se ehhez a branch-hez?"
+
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
+msgstr "Felold=C3=A1s er=C5=91ltet=C3=A9se a m=C3=A1sik branch-hez?"
+
+#: lib/mergetool.tcl:14
+#, tcl-format
+msgid ""
+"Note that the diff shows only conflicting changes.\n"
+"\n"
+"%s will be overwritten.\n"
+"\n"
+"This operation can be undone only by restarting the merge."
+msgstr ""
+"Megjegyz=C3=A9s: csak az =C3=BCtk=C3=B6z=C5=91 k=C3=BCl=C3=B6nbs=C3=A9=
gek l=C3=A1tszanak.\n"
+"\n"
+"A(z) %s fel=C3=BCl lesz =C3=ADrva.\n"
+"\n"
+"Ez a m=C5=B1velet csak a merge =C3=BAjraind=C3=ADt=C3=A1s=C3=A1val le=
sz visszavonhat=C3=B3."
+
+#: lib/mergetool.tcl:45
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
+msgstr ""
+"A(z) %s f=C3=A1jl nem feloldott =C3=BCtk=C3=B6z=C3=A9seket tartalmaz,=
 m=C3=A9gis legyen kiv=C3=A1lasztva?"
+
+#: lib/mergetool.tcl:60
+#, tcl-format
+msgid "Adding resolution for %s"
+msgstr "Felold=C3=A1s hozz=C3=A1ad=C3=A1sa a(z) %s sz=C3=A1m=C3=A1ra"
+
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr "Nem lehet feloldani t=C3=B6rl=C3=A9si vagy link =C3=BCtk=C3=B6=
z=C3=A9st egy eszk=C3=B6zzel"
+
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
+msgstr "A konfiklus-f=C3=A1jl nem l=C3=A9tezik."
+
+#: lib/mergetool.tcl:264
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "Nem GUI merge eszk=C3=B6z: %s"
+
+#: lib/mergetool.tcl:268
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr "A(z) '%s' merge eszk=C3=B6z nem t=C3=A1mogatott"
+
+#: lib/mergetool.tcl:303
+msgid "Merge tool is already running, terminate it?"
+msgstr "A merge eszk=C3=B6z m=C3=A1r fut, le legyen =C3=A1ll=C3=ADtva?=
"
+
+#: lib/mergetool.tcl:323
+#, tcl-format
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr ""
+"Hiba a verzi=C3=B3k kinyer=C3=A9se k=C3=B6zben:\n"
+"%s"
+
+#: lib/mergetool.tcl:343
+#, tcl-format
+msgid ""
+"Could not start the merge tool:\n"
+"\n"
+"%s"
+msgstr ""
+"A merge eszk=C3=B6z ind=C3=ADt=C3=A1sa sikertelen:\n"
+"\n"
+"%s"
+
+#: lib/mergetool.tcl:347
+msgid "Running merge tool..."
+msgstr "A merge eszk=C3=B6z futtat=C3=A1sa..."
+
+#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
+msgid "Merge tool failed."
+msgstr "A merge eszk=C3=B6z nem siker=C3=BClt."
+
+#: lib/option.tcl:11
+#, tcl-format
+msgid "Invalid global encoding '%s'"
+msgstr "=C3=89rv=C3=A9nytelen glob=C3=A1lis k=C3=B3dol=C3=A1s '%s'"
+
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
+msgstr "=C3=89rv=C3=A9nytelen rep=C3=B3 k=C3=B3dol=C3=A1s '%s'"
+
+#: lib/option.tcl:117
 msgid "Restore Defaults"
 msgstr "Alap=C3=A9rtelmez=C3=A9s vissza=C3=A1ll=C3=ADt=C3=A1sa"
=20
-#: lib/option.tcl:99
+#: lib/option.tcl:121
 msgid "Save"
 msgstr "Ment=C3=A9s"
=20
-#: lib/option.tcl:109
+#: lib/option.tcl:131
 #, tcl-format
 msgid "%s Repository"
 msgstr "%s Rep=C3=B3"
=20
-#: lib/option.tcl:110
+#: lib/option.tcl:132
 msgid "Global (All Repositories)"
 msgstr "Glob=C3=A1lis (minden rep=C3=B3)"
=20
-#: lib/option.tcl:116
+#: lib/option.tcl:138
 msgid "User Name"
 msgstr "Felhaszn=C3=A1l=C3=B3n=C3=A9v"
=20
-#: lib/option.tcl:117
+#: lib/option.tcl:139
 msgid "Email Address"
 msgstr "Email c=C3=ADm"
=20
-#: lib/option.tcl:119
+#: lib/option.tcl:141
 msgid "Summarize Merge Commits"
 msgstr "A merge commitok =C3=B6sszegz=C3=A9se"
=20
-#: lib/option.tcl:120
+#: lib/option.tcl:142
 msgid "Merge Verbosity"
 msgstr "Merge besz=C3=A9dess=C3=A9g"
=20
-#: lib/option.tcl:121
+#: lib/option.tcl:143
 msgid "Show Diffstat After Merge"
 msgstr "Diffstat mutat=C3=A1sa merge ut=C3=A1n"
=20
-#: lib/option.tcl:123
+#: lib/option.tcl:144
+msgid "Use Merge Tool"
+msgstr "Merge eszk=C3=B6z haszn=C3=A1lata"
+
+#: lib/option.tcl:146
 msgid "Trust File Modification Timestamps"
 msgstr "A f=C3=A1jl m=C3=B3dos=C3=ADt=C3=A1si d=C3=A1tumok megb=C3=ADz=
hat=C3=B3ak"
=20
-#: lib/option.tcl:124
+#: lib/option.tcl:147
 msgid "Prune Tracking Branches During Fetch"
 msgstr "A k=C3=B6vet=C5=91 branchek elt=C3=A1vol=C3=ADt=C3=A1sa let=C3=
=B6lt=C3=A9s alatt"
=20
-#: lib/option.tcl:125
+#: lib/option.tcl:148
 msgid "Match Tracking Branches"
 msgstr "A k=C3=B6vet=C5=91 branchek egyeztet=C3=A9se"
=20
-#: lib/option.tcl:126
+#: lib/option.tcl:149
+msgid "Blame Copy Only On Changed Files"
+msgstr "A blame m=C3=A1sol=C3=A1s bekapcsol=C3=A1sa csak megv=C3=A1lto=
zott f=C3=A1jlokra"
+
+#: lib/option.tcl:150
+msgid "Minimum Letters To Blame Copy On"
+msgstr "Minimum bet=C5=B1sz=C3=A1m blame m=C3=A1sol=C3=A1s-=C3=A9rz=C3=
=A9kel=C3=A9shez"
+
+#: lib/option.tcl:151
+msgid "Blame History Context Radius (days)"
+msgstr "Blame t=C3=B6rt=C3=A9net k=C3=B6rnyezet sug=C3=A1r (napokban)"
+
+#: lib/option.tcl:152
 msgid "Number of Diff Context Lines"
 msgstr "A diff k=C3=B6rnyezeti sorok sz=C3=A1ma"
=20
-#: lib/option.tcl:127
+#: lib/option.tcl:153
 msgid "Commit Message Text Width"
 msgstr "Commit =C3=BCzenet sz=C3=B6veg=C3=A9nek sz=C3=A9less=C3=A9ge"
=20
-#: lib/option.tcl:128
+#: lib/option.tcl:154
 msgid "New Branch Name Template"
 msgstr "=C3=9Aj branch n=C3=A9v sablon"
=20
-#: lib/option.tcl:192
+#: lib/option.tcl:155
+msgid "Default File Contents Encoding"
+msgstr "Alap=C3=A9rtelmezett f=C3=A1jltartalom-k=C3=B3dol=C3=A1s"
+
+#: lib/option.tcl:203
+msgid "Change"
+msgstr "Megv=C3=A1ltoztat=C3=A1s"
+
+#: lib/option.tcl:230
 msgid "Spelling Dictionary:"
 msgstr "Helyes=C3=ADr=C3=A1s-ellen=C5=91rz=C5=91 sz=C3=B3t=C3=A1r:"
=20
-#: lib/option.tcl:216
+#: lib/option.tcl:254
 msgid "Change Font"
 msgstr "Bet=C5=B1t=C3=ADpus megv=C3=A1ltoztat=C3=A1sa"
=20
-#: lib/option.tcl:220
+#: lib/option.tcl:258
 #, tcl-format
 msgid "Choose %s"
 msgstr "%s v=C3=A1laszt=C3=A1sa"
=20
-#: lib/option.tcl:226
+#: lib/option.tcl:264
 msgid "pt."
 msgstr "pt."
=20
-#: lib/option.tcl:240
+#: lib/option.tcl:278
 msgid "Preferences"
 msgstr "Be=C3=A1ll=C3=ADt=C3=A1sok"
=20
-#: lib/option.tcl:275
+#: lib/option.tcl:314
 msgid "Failed to completely save options:"
 msgstr "Nem siker=C3=BClt teljesen elmenteni a be=C3=A1ll=C3=ADt=C3=A1=
sokat:"
=20
+#: lib/remote.tcl:163
+msgid "Remove Remote"
+msgstr "Remote elt=C3=A1vol=C3=ADt=C3=A1sa"
+
+#: lib/remote.tcl:168
+msgid "Prune from"
+msgstr "T=C3=B6rl=C3=A9s innen"
+
+# tcl-format
+#: lib/remote.tcl:173
+msgid "Fetch from"
+msgstr "Let=C3=B6lt=C3=A9s innen"
+
+#: lib/remote.tcl:215
+msgid "Push to"
+msgstr "Push ide"
+
+#: lib/remote_add.tcl:19
+msgid "Add Remote"
+msgstr "Remote hozz=C3=A1ad=C3=A1sa"
+
+#: lib/remote_add.tcl:24
+msgid "Add New Remote"
+msgstr "=C3=9Aj remote hozz=C3=A1ad=C3=A1sa"
+
+#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
+msgid "Add"
+msgstr "Hozz=C3=A1ad=C3=A1s"
+
+#: lib/remote_add.tcl:37
+msgid "Remote Details"
+msgstr "Remote r=C3=A9szletei"
+
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "Hely:"
+
+#: lib/remote_add.tcl:62
+msgid "Further Action"
+msgstr "K=C3=B6vetkez=C5=91 m=C5=B1velet"
+
+#: lib/remote_add.tcl:65
+msgid "Fetch Immediately"
+msgstr "Let=C3=B6lt=C3=A9s most"
+
+#: lib/remote_add.tcl:71
+msgid "Initialize Remote Repository and Push"
+msgstr "T=C3=A1voli rep=C3=B3 inicializ=C3=A1l=C3=A1sa =C3=A9s push"
+
+#: lib/remote_add.tcl:77
+msgid "Do Nothing Else Now"
+msgstr "Ne csin=C3=A1ljunk semmit"
+
+#: lib/remote_add.tcl:101
+msgid "Please supply a remote name."
+msgstr "Adjunk megy egy remote nevet."
+
+#: lib/remote_add.tcl:114
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "A(z) '%s' nem egy elfogadhat=C3=B3 remote n=C3=A9v."
+
+#: lib/remote_add.tcl:125
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "Nem siker=C3=BClt a(t) '%s' remote hozz=C3=A1ad=C3=A1sa innen:=
 '%s'."
+
+#: lib/remote_add.tcl:133 lib/transport.tcl:6
+#, tcl-format
+msgid "fetch %s"
+msgstr "a(z) %s let=C3=B6lt=C3=A9se"
+
+#: lib/remote_add.tcl:134
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "A(z) %s let=C3=B6lt=C3=A9se"
+
+#: lib/remote_add.tcl:157
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "Nem tudni, hogy hogy kell a(z) '%s' helyen rep=C3=B3t iniciali=
z=C3=A1lni."
+
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:71
+#, tcl-format
+msgid "push %s"
+msgstr "%s push-ol=C3=A1sa"
+
+#: lib/remote_add.tcl:164
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "A(z) %s be=C3=A1ll=C3=ADt=C3=A1sa itt: %s"
+
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
-msgid "Delete Remote Branch"
-msgstr "T=C3=A1voli branch t=C3=B6rl=C3=A9se"
+msgid "Delete Branch Remotely"
+msgstr "T=C3=A1voli Branch t=C3=B6rl=C3=A9se"
=20
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
@@ -1784,8 +2191,8 @@ msgid "Remote:"
 msgstr "T=C3=A1voli:"
=20
 #: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
-msgid "Arbitrary URL:"
-msgstr "Tetsz=C5=91leges URL:"
+msgid "Arbitrary Location:"
+msgstr "=C3=96nk=C3=A9nyes hely:"
=20
 #: lib/remote_branch_delete.tcl:84
 msgid "Branches"
@@ -1854,18 +2261,21 @@ msgstr "Nincs kiv=C3=A1lasztott rep=C3=B3."
 msgid "Scanning %s..."
 msgstr "Keres=C3=A9s itt: %s..."
=20
-#: lib/remote.tcl:165
-msgid "Prune from"
-msgstr "T=C3=B6rl=C3=A9s innen"
+#: lib/search.tcl:21
+msgid "Find:"
+msgstr "Keres=C3=A9s:"
=20
-# tcl-format
-#: lib/remote.tcl:170
-msgid "Fetch from"
-msgstr "Let=C3=B6lt=C3=A9s innen"
+#: lib/search.tcl:23
+msgid "Next"
+msgstr "K=C3=B6vetkez=C5=91"
=20
-#: lib/remote.tcl:213
-msgid "Push to"
-msgstr "Push ide"
+#: lib/search.tcl:24
+msgid "Prev"
+msgstr "El=C5=91z=C5=91"
+
+#: lib/search.tcl:25
+msgid "Case-Sensitive"
+msgstr "Kisbet=C5=B1-nagybet=C5=B1 sz=C3=A1m=C3=ADt"
=20
 #: lib/shortcut.tcl:20 lib/shortcut.tcl:61
 msgid "Cannot write shortcut:"
@@ -1900,27 +2310,194 @@ msgstr "A helyes=C3=ADr=C3=A1s-ellen=C5=91r=C5=
=91 ind=C3=ADt=C3=A1sa sikertelen"
 msgid "Unrecognized spell checker"
 msgstr "Ismeretlen helyes=C3=ADr=C3=A1s-ellen=C5=91rz=C5=91"
=20
-#: lib/spellcheck.tcl:180
+#: lib/spellcheck.tcl:186
 msgid "No Suggestions"
 msgstr "Nincs javaslat"
=20
-#: lib/spellcheck.tcl:381
+#: lib/spellcheck.tcl:388
 msgid "Unexpected EOF from spell checker"
 msgstr "Nem v=C3=A1rt EOF a helyes=C3=ADr=C3=A1s-ellen=C5=91rz=C5=91t=C5=
=91l"
=20
-#: lib/spellcheck.tcl:385
+#: lib/spellcheck.tcl:392
 msgid "Spell Checker Failed"
 msgstr "A helyes=C3=ADr=C3=A1s-ellen=C5=91rz=C3=A9s sikertelen"
=20
+#: lib/sshkey.tcl:31
+msgid "No keys found."
+msgstr "Nincsenek kulcsok."
+
+#: lib/sshkey.tcl:34
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "Nyilv=C3=A1nos kulcs tal=C3=A1lhat=C3=B3 ebben: %s"
+
+#: lib/sshkey.tcl:40
+msgid "Generate Key"
+msgstr "Kulcs gener=C3=A1l=C3=A1sa"
+
+#: lib/sshkey.tcl:56
+msgid "Copy To Clipboard"
+msgstr "M=C3=A1sol=C3=A1s v=C3=A1g=C3=B3lapra"
+
+#: lib/sshkey.tcl:70
+msgid "Your OpenSSH Public Key"
+msgstr "Az OpenSSH publikus kulcsunk"
+
+#: lib/sshkey.tcl:78
+msgid "Generating..."
+msgstr "Gener=C3=A1l=C3=A1s..."
+
+#: lib/sshkey.tcl:84
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"Az ssh-keygen ind=C3=ADt=C3=A1sa sikertelen:\n"
+"\n"
+"%s"
+
+#: lib/sshkey.tcl:111
+msgid "Generation failed."
+msgstr "A gener=C3=A1l=C3=A1s nem siker=C3=BClt."
+
+#: lib/sshkey.tcl:118
+msgid "Generation succeded, but no keys found."
+msgstr "A gener=C3=A1l=C3=A1s sikeres, de egy kulcs se tal=C3=A1lhat=C3=
=B3."
+
+#: lib/sshkey.tcl:121
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "A kulcsunk itt van: %s"
+
 #: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%s ... %*i / %*i %s (%3i%%)"
=20
-#: lib/transport.tcl:6
+#: lib/tools.tcl:75
 #, tcl-format
-msgid "fetch %s"
-msgstr "a(z) %s let=C3=B6lt=C3=A9se"
+msgid "Running %s requires a selected file."
+msgstr "A(z) %s futtat=C3=A1sa egy kiv=C3=A1lasztott f=C3=A1jlt ig=C3=A9=
nyel."
+
+#: lib/tools.tcl:90
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "Biztos benne, hogy futtatni k=C3=ADv=C3=A1nja: %s?"
+
+#: lib/tools.tcl:110
+#, tcl-format
+msgid "Tool: %s"
+msgstr "Eszk=C3=B6z: %s"
+
+#: lib/tools.tcl:111
+#, tcl-format
+msgid "Running: %s"
+msgstr "Futtat=C3=A1s: %s..."
+
+#: lib/tools.tcl:149
+#, tcl-format
+msgid "Tool completed succesfully: %s"
+msgstr "Az eszk=C3=B6z sikeresen befejez=C5=91d=C3=B6tt: %s"
+
+#: lib/tools.tcl:151
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "Az eszk=C3=B6z sikertelen: %s"
+
+#: lib/tools_dlg.tcl:22
+msgid "Add Tool"
+msgstr "Eszk=C3=B6z hozz=C3=A1ad=C3=A1sa"
+
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "=C3=9Aj eszk=C3=B6z-parancs hozz=C3=A1ad=C3=A1sa"
+
+#: lib/tools_dlg.tcl:33
+msgid "Add globally"
+msgstr "Glob=C3=A1lis hozz=C3=A1ad=C3=A1s"
+
+#: lib/tools_dlg.tcl:45
+msgid "Tool Details"
+msgstr "Eszk=C3=B6z r=C3=A9szletei"
+
+#: lib/tools_dlg.tcl:48
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "Haszn=C3=A1ljunk '/' szepar=C3=A1torokat almen=C3=BC-fa l=C3=A9=
trehoz=C3=A1s=C3=A1hoz:"
+
+#: lib/tools_dlg.tcl:61
+msgid "Command:"
+msgstr "Parancs:"
+
+#: lib/tools_dlg.tcl:74
+msgid "Show a dialog before running"
+msgstr "Parancsablak mutat=C3=A1sa futtat=C3=A1s el=C5=91tt"
+
+#: lib/tools_dlg.tcl:80
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr ""
+"Megk=C3=A9ri a felhaszn=C3=A1l=C3=B3t, hogy v=C3=A1lasszon ki egy rev=
=C3=ADzi=C3=B3t (a $REVISION-t "
+"=C3=A1ll=C3=ADtja)"
+
+#: lib/tools_dlg.tcl:85
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "Megk=C3=A9rdezi a felhaszn=C3=A1l=C3=B3t tov=C3=A1bbi argument=
umok=C3=A9rt (a $ARGS-ot =C3=A1ll=C3=ADtja)"
+
+#: lib/tools_dlg.tcl:92
+msgid "Don't show the command output window"
+msgstr "Ne mutassa a parancs kimeneti ablak=C3=A1t"
+
+#: lib/tools_dlg.tcl:97
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "Futtat=C3=A1s csak ha egy diff ki van v=C3=A1lasztva (a $FILEN=
AME nem =C3=BCres)"
+
+#: lib/tools_dlg.tcl:121
+msgid "Please supply a name for the tool."
+msgstr "Adjunk meg egy eszk=C3=B6z nevet."
+
+#: lib/tools_dlg.tcl:129
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "A(z) '%s' eszk=C3=B6z m=C3=A1r l=C3=A9tezik."
+
+#: lib/tools_dlg.tcl:151
+#, tcl-format
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr ""
+"Az eszk=C3=B6z nem hozz=C3=A1adhat=C3=B3:\n"
+"%s"
+
+#: lib/tools_dlg.tcl:190
+msgid "Remove Tool"
+msgstr "Eszk=C3=B6z elt=C3=A1vol=C3=ADt=C3=A1sa"
+
+#: lib/tools_dlg.tcl:196
+msgid "Remove Tool Commands"
+msgstr "Eszk=C3=B6z parancsok elt=C3=A1vol=C3=ADt=C3=A1sa"
+
+#: lib/tools_dlg.tcl:200
+msgid "Remove"
+msgstr "Elt=C3=A1vol=C3=ADt=C3=A1s"
+
+#: lib/tools_dlg.tcl:236
+msgid "(Blue denotes repository-local tools)"
+msgstr "(K=C3=A9k jelzi a rep=C3=B3-specifikus eszk=C3=B6z=C3=B6ket)"
+
+#: lib/tools_dlg.tcl:297
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "Parancs futtat=C3=A1sa: %s"
+
+#: lib/tools_dlg.tcl:311
+msgid "Arguments"
+msgstr "Argumentumok"
+
+#: lib/tools_dlg.tcl:348
+msgid "OK"
+msgstr "OK"
=20
 #: lib/transport.tcl:7
 #, tcl-format
@@ -1937,11 +2514,6 @@ msgstr "a(z) %s t=C3=A1voli t=C3=B6rl=C3=A9se"
 msgid "Pruning tracking branches deleted from %s"
 msgstr "A %s rep=C3=B3b=C3=B3l t=C3=B6r=C3=B6lt k=C3=B6vet=C5=91 branc=
hek t=C3=B6rl=C3=A9se"
=20
-#: lib/transport.tcl:25 lib/transport.tcl:71
-#, tcl-format
-msgid "push %s"
-msgstr "%s push-ol=C3=A1sa"
-
 #: lib/transport.tcl:26
 #, tcl-format
 msgid "Pushing changes to %s"
@@ -1982,27 +2554,36 @@ msgstr "V=C3=A9kony csomagok haszn=C3=A1lata (l=
ass=C3=BA h=C3=A1l=C3=B3zati kapcsolatok sz=C3=A1m=C3=A1ra)"
 msgid "Include tags"
 msgstr "Tageket is"
=20
+#~ msgid ""
+#~ "Unable to start gitk:\n"
+#~ "\n"
+#~ "%s does not exist"
+#~ msgstr ""
+#~ "A gitk ind=C3=ADt=C3=A1sa sikertelen:\n"
+#~ "\n"
+#~ "A(z) %s nem l=C3=A9tezik"
+
+#~ msgid "Apple"
+#~ msgstr "Apple"
+
+#~ msgid "URL:"
+#~ msgstr "URL:"
+
+#~ msgid "Delete Remote Branch"
+#~ msgstr "T=C3=A1voli branch t=C3=B6rl=C3=A9se"
+
 #~ msgid "Not connected to aspell"
 #~ msgstr "Nincs kapcsolat az aspellhez"
=20
-#~ msgid "Cannot find the git directory:"
-#~ msgstr "Nem tal=C3=A1lhat=C3=B3 a git k=C3=B6nyvt=C3=A1r:"
-
 #~ msgid "Unstaged Changes (Will Not Be Committed)"
 #~ msgstr "Nem kiv=C3=A1lasztott v=C3=A1ltoztat=C3=A1sok (nem lesz com=
mitolva)"
=20
 #~ msgid "Push to %s..."
 #~ msgstr "Pushol=C3=A1s ide: %s..."
=20
-#~ msgid "Add To Commit"
-#~ msgstr "Hozz=C3=A1ad=C3=A1s a commithoz"
-
 #~ msgid "Add Existing To Commit"
 #~ msgstr "Hozz=C3=A1ad=C3=A1s l=C3=A9tez=C5=91 commithoz"
=20
-#~ msgid "Running miga..."
-#~ msgstr "A miga futtat=C3=A1sa..."
-
 #~ msgid "Add Existing"
 #~ msgstr "L=C3=A9tez=C5=91 hozz=C3=A1ad=C3=A1sa"
=20
--=20
1.6.0.4
