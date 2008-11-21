From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH v3] Updated Swedish translation (514t0f0u).
Date: Fri, 21 Nov 2008 08:35:53 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0811210834440.20905@ds9.cixit.se>
References: <20081116215822.GF2932@spearce.org> <Pine.LNX.4.64.0811201047180.1606@ds9.cixit.se>
 <49254595.7040103@op5.se> <Pine.LNX.4.64.0811201423291.1606@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Mikael Magnusson <mikachu@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 21 08:37:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Qa8-0000dS-7D
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 08:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbYKUHgJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Nov 2008 02:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbYKUHgI
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 02:36:08 -0500
Received: from ds9.cixit.se ([193.15.169.228]:48499 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbYKUHgE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 02:36:04 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mAL7ZsY1028360
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Nov 2008 08:35:54 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mAL7Zr9c028352;
	Fri, 21 Nov 2008 08:35:53 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <Pine.LNX.4.64.0811201423291.1606@ds9.cixit.se>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 21 Nov 2008 08:35:54 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101499>

---
 po/sv.po | 1149 +++++++++++++++++++++++++++++++++++++++++++++---------=
--------
 1 files changed, 839 insertions(+), 310 deletions(-)

=46ound a typo in one of the corrections in the PATCH v2, so here is
version 3...

diff --git a/po/sv.po b/po/sv.po
index 0196ba8..d434220 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -1,48 +1,48 @@
 # Swedish translation of git-gui.
-# Copyright (C) 2007 Shawn Pearce, et al.
+# Copyright (C) 2007-2008 Shawn Pearce, et al.
 # This file is distributed under the same license as the git-gui packa=
ge.
 #
-# Peter Karlsson <peter@softwolves.pp.se>, 2007-2008.
+# Peter Krefting <peter@softwolves.pp.se>, 2007-2008.
 # Mikael Magnusson <mikachu@gmail.com>, 2008.
 msgid ""
 msgstr ""
 "Project-Id-Version: sv\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-08-03 01:34+0200\n"
-"PO-Revision-Date: 2008-08-03 01:45+0200\n"
-"Last-Translator: Mikael Magnusson <mikachu@gmail.com>\n"
+"POT-Creation-Date: 2008-11-16 13:56-0800\n"
+"PO-Revision-Date: 2008-11-21 08:35+0100\n"
+"Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
 "Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: git-gui.sh:41 git-gui.sh:688 git-gui.sh:702 git-gui.sh:715 git-gui.=
sh:798
-#: git-gui.sh:817
+#: git-gui.sh:41 git-gui.sh:737 git-gui.sh:751 git-gui.sh:764 git-gui.=
sh:847
+#: git-gui.sh:866
 msgid "git-gui: fatal error"
 msgstr "git-gui: =C3=B6desdigert fel"
=20
-#: git-gui.sh:644
+#: git-gui.sh:689
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "Ogiltigt teckensnitt angivet i %s:"
=20
-#: git-gui.sh:674
+#: git-gui.sh:723
 msgid "Main Font"
 msgstr "Huvudteckensnitt"
=20
-#: git-gui.sh:675
+#: git-gui.sh:724
 msgid "Diff/Console Font"
 msgstr "Diff/konsolteckensnitt"
=20
-#: git-gui.sh:689
+#: git-gui.sh:738
 msgid "Cannot find git in PATH."
 msgstr "Hittar inte git i PATH."
=20
-#: git-gui.sh:716
+#: git-gui.sh:765
 msgid "Cannot parse Git version string:"
 msgstr "Kan inte tolka versionsstr=C3=A4ng fr=C3=A5n Git:"
=20
-#: git-gui.sh:734
+#: git-gui.sh:783
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -61,380 +61,445 @@ msgstr ""
 "\n"
 "Anta att \"%s\" =C3=A4r version 1.5.0?\n"
=20
-#: git-gui.sh:972
+#: git-gui.sh:1062
 msgid "Git directory not found:"
 msgstr "Git-katalogen hittades inte:"
=20
-#: git-gui.sh:979
+#: git-gui.sh:1069
 msgid "Cannot move to top of working directory:"
 msgstr "Kan inte g=C3=A5 till b=C3=B6rjan p=C3=A5 arbetskatalogen:"
=20
-#: git-gui.sh:986
+#: git-gui.sh:1076
 msgid "Cannot use funny .git directory:"
 msgstr "Kan inte anv=C3=A4nda underlig .git-katalog:"
=20
-#: git-gui.sh:991
+#: git-gui.sh:1081
 msgid "No working directory"
 msgstr "Ingen arbetskatalog"
=20
-#: git-gui.sh:1138 lib/checkout_op.tcl:305
+#: git-gui.sh:1247 lib/checkout_op.tcl:305
 msgid "Refreshing file status..."
 msgstr "Uppdaterar filstatus..."
=20
-#: git-gui.sh:1194
+#: git-gui.sh:1303
 msgid "Scanning for modified files ..."
 msgstr "S=C3=B6ker efter =C3=A4ndrade filer..."
=20
-#: git-gui.sh:1369 lib/browser.tcl:246
+#: git-gui.sh:1367
+msgid "Calling prepare-commit-msg hook..."
+msgstr "Anropar kroken f=C3=B6r f=C3=B6rberedning av incheckningsmedde=
lande (prepare-commit-msg)..."
+
+#: git-gui.sh:1384
+msgid "Commit declined by prepare-commit-msg hook."
+msgstr "Incheckningen avvisades av kroken f=C3=B6r f=C3=B6rberedning a=
v incheckningsmeddelande (prepare-commit-msg)."
+
+#: git-gui.sh:1542 lib/browser.tcl:246
 msgid "Ready."
 msgstr "Klar."
=20
-#: git-gui.sh:1635
+#: git-gui.sh:1819
 msgid "Unmodified"
 msgstr "Of=C3=B6r=C3=A4ndrade"
=20
-#: git-gui.sh:1637
+#: git-gui.sh:1821
 msgid "Modified, not staged"
 msgstr "F=C3=B6r=C3=A4ndrade, ej k=C3=B6ade"
=20
-#: git-gui.sh:1638 git-gui.sh:1643
+#: git-gui.sh:1822 git-gui.sh:1830
 msgid "Staged for commit"
 msgstr "K=C3=B6ade f=C3=B6r incheckning"
=20
-#: git-gui.sh:1639 git-gui.sh:1644
+#: git-gui.sh:1823 git-gui.sh:1831
 msgid "Portions staged for commit"
 msgstr "Delar k=C3=B6ade f=C3=B6r incheckning"
=20
-#: git-gui.sh:1640 git-gui.sh:1645
+#: git-gui.sh:1824 git-gui.sh:1832
 msgid "Staged for commit, missing"
 msgstr "K=C3=B6ade f=C3=B6r incheckning, saknade"
=20
-#: git-gui.sh:1642
+#: git-gui.sh:1826
+msgid "File type changed, not staged"
+msgstr "Filtyp =C3=A4ndrad, ej k=C3=B6ade"
+
+#: git-gui.sh:1827
+msgid "File type changed, staged"
+msgstr "Filtyp =C3=A4ndrad, k=C3=B6ade"
+
+#: git-gui.sh:1829
 msgid "Untracked, not staged"
 msgstr "Ej sp=C3=A5rade, ej k=C3=B6ade"
=20
-#: git-gui.sh:1647
+#: git-gui.sh:1834
 msgid "Missing"
 msgstr "Saknade"
=20
-#: git-gui.sh:1648
+#: git-gui.sh:1835
 msgid "Staged for removal"
 msgstr "K=C3=B6ade f=C3=B6r borttagning"
=20
-#: git-gui.sh:1649
+#: git-gui.sh:1836
 msgid "Staged for removal, still present"
 msgstr "K=C3=B6ade f=C3=B6r borttagning, fortfarande n=C3=A4rvarande"
=20
-#: git-gui.sh:1651 git-gui.sh:1652 git-gui.sh:1653 git-gui.sh:1654
+#: git-gui.sh:1838 git-gui.sh:1839 git-gui.sh:1840 git-gui.sh:1841
+#: git-gui.sh:1842 git-gui.sh:1843
 msgid "Requires merge resolution"
 msgstr "Kr=C3=A4ver konflikthantering efter sammanslagning"
=20
-#: git-gui.sh:1689
+#: git-gui.sh:1878
 msgid "Starting gitk... please wait..."
 msgstr "Startar gitk... v=C3=A4nta..."
=20
-#: git-gui.sh:1698
+#: git-gui.sh:1887
 msgid "Couldn't find gitk in PATH"
 msgstr "Hittar inte gitk i PATH."
=20
-#: git-gui.sh:1948 lib/choose_repository.tcl:36
+#: git-gui.sh:2280 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "Arkiv"
=20
-#: git-gui.sh:1949
+#: git-gui.sh:2281
 msgid "Edit"
 msgstr "Redigera"
=20
-#: git-gui.sh:1951 lib/choose_rev.tcl:561
+#: git-gui.sh:2283 lib/choose_rev.tcl:561
 msgid "Branch"
 msgstr "Gren"
=20
-#: git-gui.sh:1954 lib/choose_rev.tcl:548
+#: git-gui.sh:2286 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
 msgstr "Incheckning"
=20
-#: git-gui.sh:1957 lib/merge.tcl:120 lib/merge.tcl:149 lib/merge.tcl:1=
67
+#: git-gui.sh:2289 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "Sl=C3=A5 ihop"
=20
-#: git-gui.sh:1958 lib/choose_rev.tcl:557
+#: git-gui.sh:2290 lib/choose_rev.tcl:557
 msgid "Remote"
-msgstr "Fj=C3=A4rr"
+msgstr "Fj=C3=A4rrarkiv"
+
+#: git-gui.sh:2293
+msgid "Tools"
+msgstr "Verktyg"
+
+#: git-gui.sh:2302
+msgid "Explore Working Copy"
+msgstr "Utforska arbetskopia"
=20
-#: git-gui.sh:1967
+#: git-gui.sh:2307
 msgid "Browse Current Branch's Files"
 msgstr "Bl=C3=A4ddra i grenens filer"
=20
-#: git-gui.sh:1971
+#: git-gui.sh:2311
 msgid "Browse Branch Files..."
 msgstr "Bl=C3=A4ddra filer p=C3=A5 gren..."
=20
-#: git-gui.sh:1976
+#: git-gui.sh:2316
 msgid "Visualize Current Branch's History"
 msgstr "Visualisera grenens historik"
=20
-#: git-gui.sh:1980
+#: git-gui.sh:2320
 msgid "Visualize All Branch History"
 msgstr "Visualisera alla grenars historik"
=20
-#: git-gui.sh:1987
+#: git-gui.sh:2327
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Bl=C3=A4ddra i filer f=C3=B6r %s"
=20
-#: git-gui.sh:1989
+#: git-gui.sh:2329
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Visualisera historik f=C3=B6r %s"
=20
-#: git-gui.sh:1994 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2334 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Databasstatistik"
=20
-#: git-gui.sh:1997 lib/database.tcl:34
+#: git-gui.sh:2337 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "Komprimera databas"
=20
-#: git-gui.sh:2000
+#: git-gui.sh:2340
 msgid "Verify Database"
 msgstr "Verifiera databas"
=20
-#: git-gui.sh:2007 git-gui.sh:2011 git-gui.sh:2015 lib/shortcut.tcl:7
+#: git-gui.sh:2347 git-gui.sh:2351 git-gui.sh:2355 lib/shortcut.tcl:7
 #: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
 msgstr "Skapa skrivbordsikon"
=20
-#: git-gui.sh:2023 lib/choose_repository.tcl:177 lib/choose_repository=
=2Etcl:185
+#: git-gui.sh:2363 lib/choose_repository.tcl:183 lib/choose_repository=
=2Etcl:191
 msgid "Quit"
 msgstr "Avsluta"
=20
-#: git-gui.sh:2031
+#: git-gui.sh:2371
 msgid "Undo"
 msgstr "=C3=85ngra"
=20
-#: git-gui.sh:2034
+#: git-gui.sh:2374
 msgid "Redo"
 msgstr "G=C3=B6r om"
=20
-#: git-gui.sh:2038 git-gui.sh:2545
+#: git-gui.sh:2378 git-gui.sh:2923
 msgid "Cut"
 msgstr "Klipp ut"
=20
-#: git-gui.sh:2041 git-gui.sh:2548 git-gui.sh:2622 git-gui.sh:2715
+#: git-gui.sh:2381 git-gui.sh:2926 git-gui.sh:3000 git-gui.sh:3082
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "Kopiera"
=20
-#: git-gui.sh:2044 git-gui.sh:2551
+#: git-gui.sh:2384 git-gui.sh:2929
 msgid "Paste"
 msgstr "Klistra in"
=20
-#: git-gui.sh:2047 git-gui.sh:2554 lib/branch_delete.tcl:26
+#: git-gui.sh:2387 git-gui.sh:2932 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "Ta bort"
=20
-#: git-gui.sh:2051 git-gui.sh:2558 git-gui.sh:2719 lib/console.tcl:71
+#: git-gui.sh:2391 git-gui.sh:2936 git-gui.sh:3086 lib/console.tcl:71
 msgid "Select All"
 msgstr "Markera alla"
=20
-#: git-gui.sh:2060
+#: git-gui.sh:2400
 msgid "Create..."
 msgstr "Skapa..."
=20
-#: git-gui.sh:2066
+#: git-gui.sh:2406
 msgid "Checkout..."
 msgstr "Checka ut..."
=20
-#: git-gui.sh:2072
+#: git-gui.sh:2412
 msgid "Rename..."
 msgstr "Byt namn..."
=20
-#: git-gui.sh:2077 git-gui.sh:2187
+#: git-gui.sh:2417
 msgid "Delete..."
 msgstr "Ta bort..."
=20
-#: git-gui.sh:2082
+#: git-gui.sh:2422
 msgid "Reset..."
 msgstr "=C3=85terst=C3=A4ll..."
=20
-#: git-gui.sh:2094 git-gui.sh:2491
+#: git-gui.sh:2432
+msgid "Done"
+msgstr "F=C3=A4rdig"
+
+#: git-gui.sh:2434
+msgid "Commit@@verb"
+msgstr "Checka in"
+
+#: git-gui.sh:2443 git-gui.sh:2864
 msgid "New Commit"
 msgstr "Ny incheckning"
=20
-#: git-gui.sh:2102 git-gui.sh:2498
+#: git-gui.sh:2451 git-gui.sh:2871
 msgid "Amend Last Commit"
 msgstr "L=C3=A4gg till f=C3=B6reg=C3=A5ende incheckning"
=20
-#: git-gui.sh:2111 git-gui.sh:2458 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2461 git-gui.sh:2825 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "S=C3=B6k p=C3=A5 nytt"
=20
-#: git-gui.sh:2117
+#: git-gui.sh:2467
 msgid "Stage To Commit"
 msgstr "K=C3=B6a f=C3=B6r incheckning"
=20
-#: git-gui.sh:2123
+#: git-gui.sh:2473
 msgid "Stage Changed Files To Commit"
 msgstr "K=C3=B6a =C3=A4ndrade filer f=C3=B6r incheckning"
=20
-#: git-gui.sh:2129
+#: git-gui.sh:2479
 msgid "Unstage From Commit"
 msgstr "Ta bort fr=C3=A5n incheckningsk=C3=B6"
=20
-#: git-gui.sh:2134 lib/index.tcl:395
+#: git-gui.sh:2484 lib/index.tcl:410
 msgid "Revert Changes"
 msgstr "=C3=85terst=C3=A4ll =C3=A4ndringar"
=20
-#: git-gui.sh:2141 git-gui.sh:2702
+#: git-gui.sh:2491 git-gui.sh:3069
 msgid "Show Less Context"
 msgstr "Visa mindre sammanhang"
=20
-#: git-gui.sh:2145 git-gui.sh:2706
+#: git-gui.sh:2495 git-gui.sh:3073
 msgid "Show More Context"
 msgstr "Visa mer sammanhang"
=20
-#: git-gui.sh:2151 git-gui.sh:2470 git-gui.sh:2569
+#: git-gui.sh:2502 git-gui.sh:2838 git-gui.sh:2947
 msgid "Sign Off"
 msgstr "Skriv under"
=20
-#: git-gui.sh:2155 git-gui.sh:2474
-msgid "Commit@@verb"
-msgstr "Checka in"
-
-#: git-gui.sh:2166
+#: git-gui.sh:2518
 msgid "Local Merge..."
 msgstr "Lokal sammanslagning..."
=20
-#: git-gui.sh:2171
+#: git-gui.sh:2523
 msgid "Abort Merge..."
 msgstr "Avbryt sammanslagning..."
=20
-#: git-gui.sh:2183
+#: git-gui.sh:2535 git-gui.sh:2575
+msgid "Add..."
+msgstr "L=C3=A4gg till..."
+
+#: git-gui.sh:2539
 msgid "Push..."
 msgstr "S=C3=A4nd..."
=20
-#: git-gui.sh:2197 git-gui.sh:2219 lib/about.tcl:14
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
+#: git-gui.sh:2543
+msgid "Delete Branch..."
+msgstr "Ta bort gren..."
+
+#: git-gui.sh:2553 git-gui.sh:2589 lib/about.tcl:14
+#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
 #, tcl-format
 msgid "About %s"
 msgstr "Om %s"
=20
-#: git-gui.sh:2201
+#: git-gui.sh:2557
 msgid "Preferences..."
 msgstr "Inst=C3=A4llningar..."
=20
-#: git-gui.sh:2209 git-gui.sh:2740
+#: git-gui.sh:2565 git-gui.sh:3115
 msgid "Options..."
 msgstr "Alternativ..."
=20
-#: git-gui.sh:2215 lib/choose_repository.tcl:47
+#: git-gui.sh:2576
+msgid "Remove..."
+msgstr "Ta bort..."
+
+#: git-gui.sh:2585 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr "Hj=C3=A4lp"
=20
-#: git-gui.sh:2256
+#: git-gui.sh:2611
 msgid "Online Documentation"
 msgstr "Webbdokumentation"
=20
-#: git-gui.sh:2340
+#: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
+msgid "Show SSH Key"
+msgstr "Visa SSH-nyckel"
+
+#: git-gui.sh:2707
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 "=C3=B6desdigert: kunde inte ta status p=C3=A5 s=C3=B6kv=C3=A4gen %s: =
=46il eller katalog saknas"
=20
-#: git-gui.sh:2373
+#: git-gui.sh:2740
 msgid "Current Branch:"
 msgstr "Aktuell gren:"
=20
-#: git-gui.sh:2394
+#: git-gui.sh:2761
 msgid "Staged Changes (Will Commit)"
 msgstr "K=C3=B6ade =C3=A4ndringar (kommer att checkas in)"
=20
-#: git-gui.sh:2414
+#: git-gui.sh:2781
 msgid "Unstaged Changes"
 msgstr "Ok=C3=B6ade =C3=A4ndringar"
=20
-#: git-gui.sh:2464
+#: git-gui.sh:2831
 msgid "Stage Changed"
 msgstr "K=C3=B6a =C3=A4ndrade"
=20
-#: git-gui.sh:2480 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2850 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
 msgstr "S=C3=A4nd"
=20
-#: git-gui.sh:2510
+#: git-gui.sh:2885
 msgid "Initial Commit Message:"
 msgstr "Inledande incheckningsmeddelande:"
=20
-#: git-gui.sh:2511
+#: git-gui.sh:2886
 msgid "Amended Commit Message:"
 msgstr "Ut=C3=B6kat incheckningsmeddelande:"
=20
-#: git-gui.sh:2512
+#: git-gui.sh:2887
 msgid "Amended Initial Commit Message:"
 msgstr "Ut=C3=B6kat inledande incheckningsmeddelande:"
=20
-#: git-gui.sh:2513
+#: git-gui.sh:2888
 msgid "Amended Merge Commit Message:"
 msgstr "Ut=C3=B6kat incheckningsmeddelande f=C3=B6r sammanslagning:"
=20
-#: git-gui.sh:2514
+#: git-gui.sh:2889
 msgid "Merge Commit Message:"
 msgstr "Incheckningsmeddelande f=C3=B6r sammanslagning:"
=20
-#: git-gui.sh:2515
+#: git-gui.sh:2890
 msgid "Commit Message:"
 msgstr "Incheckningsmeddelande:"
=20
-#: git-gui.sh:2561 git-gui.sh:2723 lib/console.tcl:73
+#: git-gui.sh:2939 git-gui.sh:3090 lib/console.tcl:73
 msgid "Copy All"
 msgstr "Kopiera alla"
=20
-#: git-gui.sh:2585 lib/blame.tcl:100
+#: git-gui.sh:2963 lib/blame.tcl:104
 msgid "File:"
 msgstr "Fil:"
=20
-#: git-gui.sh:2691
-msgid "Apply/Reverse Hunk"
-msgstr "Anv=C3=A4nd/=C3=A5terst=C3=A4ll del"
-
-#: git-gui.sh:2696
-msgid "Apply/Reverse Line"
-msgstr "Anv=C3=A4nd/=C3=A5terst=C3=A4ll rad"
-
-#: git-gui.sh:2711
+#: git-gui.sh:3078
 msgid "Refresh"
 msgstr "Uppdatera"
=20
-#: git-gui.sh:2732
+#: git-gui.sh:3099
 msgid "Decrease Font Size"
 msgstr "Minska teckensnittsstorlek"
=20
-#: git-gui.sh:2736
+#: git-gui.sh:3103
 msgid "Increase Font Size"
 msgstr "=C3=96ka teckensnittsstorlek"
=20
-#: git-gui.sh:2747
+#: git-gui.sh:3111 lib/blame.tcl:281
+msgid "Encoding"
+msgstr "Teckenkodning"
+
+#: git-gui.sh:3122
+msgid "Apply/Reverse Hunk"
+msgstr "Anv=C3=A4nd/=C3=A5terst=C3=A4ll del"
+
+#: git-gui.sh:3127
+msgid "Apply/Reverse Line"
+msgstr "Anv=C3=A4nd/=C3=A5terst=C3=A4ll rad"
+
+#: git-gui.sh:3137
+msgid "Run Merge Tool"
+msgstr "Starta verktyg f=C3=B6r sammanslagning"
+
+#: git-gui.sh:3142
+msgid "Use Remote Version"
+msgstr "Anv=C3=A4nd versionen fr=C3=A5n fj=C3=A4rrarkivet"
+
+#: git-gui.sh:3146
+msgid "Use Local Version"
+msgstr "Anv=C3=A4nd lokala versionen"
+
+#: git-gui.sh:3150
+msgid "Revert To Base"
+msgstr "=C3=85terst=C3=A4ll till basversionen"
+
+#: git-gui.sh:3169
 msgid "Unstage Hunk From Commit"
 msgstr "Ta bort del ur incheckningsk=C3=B6"
=20
-#: git-gui.sh:2748
+#: git-gui.sh:3170
 msgid "Unstage Line From Commit"
 msgstr "Ta bort rad ur incheckningsk=C3=B6"
=20
-#: git-gui.sh:2750
+#: git-gui.sh:3172
 msgid "Stage Hunk For Commit"
 msgstr "St=C3=A4ll del i incheckningsk=C3=B6"
=20
-#: git-gui.sh:2751
+#: git-gui.sh:3173
 msgid "Stage Line For Commit"
 msgstr "St=C3=A4ll rad i incheckningsk=C3=B6"
=20
-#: git-gui.sh:2771
+#: git-gui.sh:3196
 msgid "Initializing..."
 msgstr "Initierar..."
=20
-#: git-gui.sh:2876
+#: git-gui.sh:3301
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -451,7 +516,7 @@ msgstr ""
 "av %s:\n"
 "\n"
=20
-#: git-gui.sh:2906
+#: git-gui.sh:3331
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -461,7 +526,7 @@ msgstr ""
 "Detta beror p=C3=A5 ett k=C3=A4nt problem med\n"
 "Tcl-bin=C3=A4ren som f=C3=B6ljer med Cygwin."
=20
-#: git-gui.sh:2911
+#: git-gui.sh:3336
 #, tcl-format
 msgid ""
 "\n"
@@ -482,80 +547,108 @@ msgstr ""
 msgid "git-gui - a graphical user interface for Git."
 msgstr "git-gui - ett grafiskt anv=C3=A4ndargr=C3=A4nssnitt f=C3=B6r G=
it."
=20
-#: lib/blame.tcl:70
+#: lib/blame.tcl:72
 msgid "File Viewer"
 msgstr "Filvisare"
=20
-#: lib/blame.tcl:74
+#: lib/blame.tcl:78
 msgid "Commit:"
 msgstr "Incheckning:"
=20
-#: lib/blame.tcl:257
+#: lib/blame.tcl:271
 msgid "Copy Commit"
 msgstr "Kopiera incheckning"
=20
-#: lib/blame.tcl:260
+#: lib/blame.tcl:275
+msgid "Find Text..."
+msgstr "S=C3=B6k text..."
+
+#: lib/blame.tcl:284
 msgid "Do Full Copy Detection"
 msgstr "G=C3=B6r full kopieringsigenk=C3=A4nning"
=20
-#: lib/blame.tcl:388
+#: lib/blame.tcl:288
+msgid "Show History Context"
+msgstr "Visa historiksammanhang"
+
+#: lib/blame.tcl:291
+msgid "Blame Parent Commit"
+msgstr "Klandra f=C3=B6r=C3=A4ldraincheckning"
+
+#: lib/blame.tcl:450
 #, tcl-format
 msgid "Reading %s..."
 msgstr "L=C3=A4ser %s..."
=20
-#: lib/blame.tcl:492
+#: lib/blame.tcl:557
 msgid "Loading copy/move tracking annotations..."
 msgstr "L=C3=A4ser annoteringar f=C3=B6r kopiering/flyttning..."
=20
-#: lib/blame.tcl:512
+#: lib/blame.tcl:577
 msgid "lines annotated"
 msgstr "rader annoterade"
=20
-#: lib/blame.tcl:704
+#: lib/blame.tcl:769
 msgid "Loading original location annotations..."
 msgstr "L=C3=A4ser in annotering av originalplacering..."
=20
-#: lib/blame.tcl:707
+#: lib/blame.tcl:772
 msgid "Annotation complete."
 msgstr "Annotering fullbordad."
=20
-#: lib/blame.tcl:737
+#: lib/blame.tcl:802
 msgid "Busy"
 msgstr "Upptagen"
=20
-#: lib/blame.tcl:738
+#: lib/blame.tcl:803
 msgid "Annotation process is already running."
 msgstr "Annoteringsprocess k=C3=B6rs redan."
=20
-#: lib/blame.tcl:777
+#: lib/blame.tcl:842
 msgid "Running thorough copy detection..."
 msgstr "K=C3=B6r grundlig kopieringsigenk=C3=A4nning..."
=20
-#: lib/blame.tcl:827
+#: lib/blame.tcl:910
 msgid "Loading annotation..."
 msgstr "L=C3=A4ser in annotering..."
=20
-#: lib/blame.tcl:883
+#: lib/blame.tcl:964
 msgid "Author:"
 msgstr "F=C3=B6rfattare:"
=20
-#: lib/blame.tcl:887
+#: lib/blame.tcl:968
 msgid "Committer:"
 msgstr "Incheckare:"
=20
-#: lib/blame.tcl:892
+#: lib/blame.tcl:973
 msgid "Original File:"
 msgstr "Ursprunglig fil:"
=20
-#: lib/blame.tcl:1006
+#: lib/blame.tcl:1021
+msgid "Cannot find HEAD commit:"
+msgstr "Hittar inte incheckning f=C3=B6r HEAD:"
+
+#: lib/blame.tcl:1076
+msgid "Cannot find parent commit:"
+msgstr "Hittar inte f=C3=B6r=C3=A4ldraincheckning:"
+
+#: lib/blame.tcl:1091
+msgid "Unable to display parent"
+msgstr "Kan inte visa f=C3=B6r=C3=A4lder"
+
+#: lib/blame.tcl:1092 lib/diff.tcl:297
+msgid "Error loading diff:"
+msgstr "Fel vid inl=C3=A4sning av differens:"
+
+#: lib/blame.tcl:1232
 msgid "Originally By:"
 msgstr "Ursprungligen av:"
=20
-#: lib/blame.tcl:1012
+#: lib/blame.tcl:1238
 msgid "In File:"
 msgstr "I filen:"
=20
-#: lib/blame.tcl:1017
+#: lib/blame.tcl:1243
 msgid "Copied Or Moved Here By:"
 msgstr "Kopierad eller flyttad hit av:"
=20
@@ -569,16 +662,18 @@ msgstr "Checka ut"
=20
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
-#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:171
-#: lib/option.tcl:103 lib/remote_branch_delete.tcl:42 lib/transport.tc=
l:97
+#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:172
+#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.t=
cl:42
+#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
+#: lib/transport.tcl:97
 msgid "Cancel"
 msgstr "Avbryt"
=20
-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:32=
8
 msgid "Revision"
 msgstr "Revision"
=20
-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
244
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
280
 msgid "Options"
 msgstr "Alternativ"
=20
@@ -598,7 +693,7 @@ msgstr "Skapa gren"
 msgid "Create New Branch"
 msgstr "Skapa ny gren"
=20
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:371
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:377
 msgid "Create"
 msgstr "Skapa"
=20
@@ -606,7 +701,7 @@ msgstr "Skapa"
 msgid "Branch Name"
 msgstr "Namn p=C3=A5 gren"
=20
-#: lib/branch_create.tcl:43
+#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
 msgid "Name:"
 msgstr "Namn:"
=20
@@ -751,9 +846,9 @@ msgstr "[Upp till f=C3=B6r=C3=A4lder]"
 msgid "Browse Branch Files"
 msgstr "Bl=C3=A4ddra filer p=C3=A5 grenen"
=20
-#: lib/browser.tcl:278 lib/choose_repository.tcl:387
-#: lib/choose_repository.tcl:472 lib/choose_repository.tcl:482
-#: lib/choose_repository.tcl:985
+#: lib/browser.tcl:278 lib/choose_repository.tcl:394
+#: lib/choose_repository.tcl:480 lib/choose_repository.tcl:491
+#: lib/choose_repository.tcl:995
 msgid "Browse"
 msgstr "Bl=C3=A4ddra"
=20
@@ -768,6 +863,7 @@ msgid "fatal: Cannot resolve %s"
 msgstr "=C3=B6desdigert: Kunde inte sl=C3=A5 upp %s"
=20
 #: lib/checkout_op.tcl:145 lib/console.tcl:81 lib/database.tcl:31
+#: lib/sshkey.tcl:53
 msgid "Close"
 msgstr "St=C3=A4ng"
=20
@@ -879,7 +975,7 @@ msgstr "Det kanske inte =C3=A4r s=C3=A5 enkelt att =
=C3=A5terskapa f=C3=B6rlorade incheckningar."
 msgid "Reset '%s'?"
 msgstr "=C3=85terst=C3=A4lla \"%s\"?"
=20
-#: lib/checkout_op.tcl:532 lib/merge.tcl:163
+#: lib/checkout_op.tcl:532 lib/merge.tcl:164 lib/tools_dlg.tcl:343
 msgid "Visualize"
 msgstr "Visualisera"
=20
@@ -928,221 +1024,225 @@ msgstr ""
 msgid "Git Gui"
 msgstr "Git Gui"
=20
-#: lib/choose_repository.tcl:81 lib/choose_repository.tcl:376
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:382
 msgid "Create New Repository"
 msgstr "Skapa nytt arkiv"
=20
-#: lib/choose_repository.tcl:87
+#: lib/choose_repository.tcl:93
 msgid "New..."
 msgstr "Nytt..."
=20
-#: lib/choose_repository.tcl:94 lib/choose_repository.tcl:458
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:465
 msgid "Clone Existing Repository"
 msgstr "Klona befintligt arkiv"
=20
-#: lib/choose_repository.tcl:100
+#: lib/choose_repository.tcl:106
 msgid "Clone..."
 msgstr "Klona..."
=20
-#: lib/choose_repository.tcl:107 lib/choose_repository.tcl:974
+#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:983
 msgid "Open Existing Repository"
 msgstr "=C3=96ppna befintligt arkiv"
=20
-#: lib/choose_repository.tcl:113
+#: lib/choose_repository.tcl:119
 msgid "Open..."
 msgstr "=C3=96ppna..."
=20
-#: lib/choose_repository.tcl:126
+#: lib/choose_repository.tcl:132
 msgid "Recent Repositories"
 msgstr "Senaste arkiven"
=20
-#: lib/choose_repository.tcl:132
+#: lib/choose_repository.tcl:138
 msgid "Open Recent Repository:"
 msgstr "=C3=96ppna tidigare arkiv:"
=20
-#: lib/choose_repository.tcl:296 lib/choose_repository.tcl:303
-#: lib/choose_repository.tcl:310
+#: lib/choose_repository.tcl:302 lib/choose_repository.tcl:309
+#: lib/choose_repository.tcl:316
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "Kunde inte skapa arkivet %s:"
=20
-#: lib/choose_repository.tcl:381 lib/choose_repository.tcl:476
+#: lib/choose_repository.tcl:387
 msgid "Directory:"
 msgstr "Katalog:"
=20
-#: lib/choose_repository.tcl:410 lib/choose_repository.tcl:535
-#: lib/choose_repository.tcl:1007
+#: lib/choose_repository.tcl:417 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1017
 msgid "Git Repository"
 msgstr "Gitarkiv"
=20
-#: lib/choose_repository.tcl:435
+#: lib/choose_repository.tcl:442
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "Katalogen %s finns redan."
=20
-#: lib/choose_repository.tcl:439
+#: lib/choose_repository.tcl:446
 #, tcl-format
 msgid "File %s already exists."
 msgstr "Filen %s finns redan."
=20
-#: lib/choose_repository.tcl:453
+#: lib/choose_repository.tcl:460
 msgid "Clone"
 msgstr "Klona"
=20
-#: lib/choose_repository.tcl:466
-msgid "URL:"
-msgstr "Webbadress:"
+#: lib/choose_repository.tcl:473
+msgid "Source Location:"
+msgstr "Plats f=C3=B6r k=C3=A4llkod:"
+
+#: lib/choose_repository.tcl:484
+msgid "Target Directory:"
+msgstr "M=C3=A5lkatalog:"
=20
-#: lib/choose_repository.tcl:487
+#: lib/choose_repository.tcl:496
 msgid "Clone Type:"
 msgstr "Typ av klon:"
=20
-#: lib/choose_repository.tcl:493
+#: lib/choose_repository.tcl:502
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "Standard (snabb, semiredundant, h=C3=A5rda l=C3=A4nkar)"
=20
-#: lib/choose_repository.tcl:499
+#: lib/choose_repository.tcl:508
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "Full kopia (l=C3=A5ngsammare, redundant s=C3=A4kerhetskopia)"
=20
-#: lib/choose_repository.tcl:505
+#: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "Delad (snabbast, rekommenderas ej, ingen s=C3=A4kerhetskopia)"
=20
-#: lib/choose_repository.tcl:541 lib/choose_repository.tcl:588
-#: lib/choose_repository.tcl:734 lib/choose_repository.tcl:804
-#: lib/choose_repository.tcl:1013 lib/choose_repository.tcl:1021
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:743 lib/choose_repository.tcl:813
+#: lib/choose_repository.tcl:1023 lib/choose_repository.tcl:1031
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "Inte ett Gitarkiv: %s"
=20
-#: lib/choose_repository.tcl:577
+#: lib/choose_repository.tcl:586
 msgid "Standard only available for local repository."
 msgstr "Standard =C3=A4r endast tillg=C3=A4ngligt f=C3=B6r lokala arki=
v."
=20
-#: lib/choose_repository.tcl:581
+#: lib/choose_repository.tcl:590
 msgid "Shared only available for local repository."
 msgstr "Delat =C3=A4r endast tillg=C3=A4ngligt f=C3=B6r lokala arkiv."
=20
-#: lib/choose_repository.tcl:602
+#: lib/choose_repository.tcl:611
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "Platsen %s finns redan."
=20
-#: lib/choose_repository.tcl:613
+#: lib/choose_repository.tcl:622
 msgid "Failed to configure origin"
 msgstr "Kunde inte konfigurera ursprung"
=20
-#: lib/choose_repository.tcl:625
+#: lib/choose_repository.tcl:634
 msgid "Counting objects"
 msgstr "R=C3=A4knar objekt"
=20
-#: lib/choose_repository.tcl:626
+#: lib/choose_repository.tcl:635
 msgid "buckets"
 msgstr "hinkar"
=20
-#: lib/choose_repository.tcl:650
+#: lib/choose_repository.tcl:659
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "Kunde inte kopiera objekt/info/alternativ: %s"
=20
-#: lib/choose_repository.tcl:686
+#: lib/choose_repository.tcl:695
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "Ingenting att klona fr=C3=A5n %s."
=20
-#: lib/choose_repository.tcl:688 lib/choose_repository.tcl:902
-#: lib/choose_repository.tcl:914
+#: lib/choose_repository.tcl:697 lib/choose_repository.tcl:911
+#: lib/choose_repository.tcl:923
 msgid "The 'master' branch has not been initialized."
 msgstr "Grenen \"master\" har inte initierats."
=20
-#: lib/choose_repository.tcl:701
+#: lib/choose_repository.tcl:710
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "H=C3=A5rda l=C3=A4nkar =C3=A4r inte tillg=C3=A4ngliga. Faller =
tillbaka p=C3=A5 kopiering."
=20
-#: lib/choose_repository.tcl:713
+#: lib/choose_repository.tcl:722
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "Klonar fr=C3=A5n %s"
=20
-#: lib/choose_repository.tcl:744
+#: lib/choose_repository.tcl:753
 msgid "Copying objects"
 msgstr "Kopierar objekt"
=20
-#: lib/choose_repository.tcl:745
+#: lib/choose_repository.tcl:754
 msgid "KiB"
 msgstr "KiB"
=20
-#: lib/choose_repository.tcl:769
+#: lib/choose_repository.tcl:778
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "Kunde inte kopiera objekt: %s"
=20
-#: lib/choose_repository.tcl:779
+#: lib/choose_repository.tcl:788
 msgid "Linking objects"
 msgstr "L=C3=A4nkar objekt"
=20
-#: lib/choose_repository.tcl:780
+#: lib/choose_repository.tcl:789
 msgid "objects"
 msgstr "objekt"
=20
-#: lib/choose_repository.tcl:788
+#: lib/choose_repository.tcl:797
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "Kunde inte h=C3=A5rdl=C3=A4nka objekt: %s"
=20
-#: lib/choose_repository.tcl:843
+#: lib/choose_repository.tcl:852
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
 msgstr "Kunde inte h=C3=A4mta grenar och objekt. Se konsolutdata f=C3=B6=
r detaljer."
=20
-#: lib/choose_repository.tcl:854
+#: lib/choose_repository.tcl:863
 msgid "Cannot fetch tags.  See console output for details."
 msgstr "Kunde inte h=C3=A4mta taggar. Se konsolutdata f=C3=B6r detalje=
r."
=20
-#: lib/choose_repository.tcl:878
+#: lib/choose_repository.tcl:887
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr "Kunde inte avg=C3=B6ra HEAD. Se konsolutdata f=C3=B6r detaljer=
=2E"
=20
-#: lib/choose_repository.tcl:887
+#: lib/choose_repository.tcl:896
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "Kunde inte st=C3=A4da upp %s"
=20
-#: lib/choose_repository.tcl:893
+#: lib/choose_repository.tcl:902
 msgid "Clone failed."
 msgstr "Kloning misslyckades."
=20
-#: lib/choose_repository.tcl:900
+#: lib/choose_repository.tcl:909
 msgid "No default branch obtained."
 msgstr "H=C3=A4mtade ingen standardgren."
=20
-#: lib/choose_repository.tcl:911
+#: lib/choose_repository.tcl:920
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "Kunde inte sl=C3=A5 upp %s till n=C3=A5gon incheckning."
=20
-#: lib/choose_repository.tcl:923
+#: lib/choose_repository.tcl:932
 msgid "Creating working directory"
 msgstr "Skapar arbetskatalog"
=20
-#: lib/choose_repository.tcl:924 lib/index.tcl:65 lib/index.tcl:127
-#: lib/index.tcl:193
+#: lib/choose_repository.tcl:933 lib/index.tcl:65 lib/index.tcl:128
+#: lib/index.tcl:196
 msgid "files"
 msgstr "filer"
=20
-#: lib/choose_repository.tcl:953
+#: lib/choose_repository.tcl:962
 msgid "Initial file checkout failed."
 msgstr "Inledande filutcheckning misslyckades."
=20
-#: lib/choose_repository.tcl:969
+#: lib/choose_repository.tcl:978
 msgid "Open"
 msgstr "=C3=96ppna"
=20
-#: lib/choose_repository.tcl:979
+#: lib/choose_repository.tcl:988
 msgid "Repository:"
 msgstr "Arkiv:"
=20
-#: lib/choose_repository.tcl:1027
+#: lib/choose_repository.tcl:1037
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "Kunde inte =C3=B6ppna arkivet %s:"
@@ -1242,7 +1342,7 @@ msgstr ""
 "\n"
 "S=C3=B6kningen kommer att startas automatiskt nu.\n"
=20
-#: lib/commit.tcl:154
+#: lib/commit.tcl:156
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1255,7 +1355,7 @@ msgstr ""
 "Filen %s har sammanslagningskonflikter. Du m=C3=A5ste l=C3=B6sa dem o=
ch k=C3=B6a filen "
 "innan du checkar in den.\n"
=20
-#: lib/commit.tcl:162
+#: lib/commit.tcl:164
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1266,7 +1366,7 @@ msgstr ""
 "\n"
 "Filen %s kan inte checkas in av programmet.\n"
=20
-#: lib/commit.tcl:170
+#: lib/commit.tcl:172
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1276,7 +1376,7 @@ msgstr ""
 "\n"
 "Du m=C3=A5ste k=C3=B6a =C3=A5tminstone en fil innan du kan checka in.=
\n"
=20
-#: lib/commit.tcl:183
+#: lib/commit.tcl:187
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1294,45 +1394,45 @@ msgstr ""
 "- Andra raden: Tom\n"
 "- F=C3=B6ljande rader: Beskriv varf=C3=B6r det h=C3=A4r =C3=A4r en br=
a =C3=A4ndring.\n"
=20
-#: lib/commit.tcl:207
+#: lib/commit.tcl:211
 #, tcl-format
 msgid "warning: Tcl does not support encoding '%s'."
 msgstr "varning: Tcl st=C3=B6der inte teckenkodningen \"%s\"."
=20
-#: lib/commit.tcl:221
+#: lib/commit.tcl:227
 msgid "Calling pre-commit hook..."
-msgstr "Anropar krok f=C3=B6re incheckning..."
+msgstr "Anropar kroken f=C3=B6re incheckning (pre-commit)..."
=20
-#: lib/commit.tcl:236
+#: lib/commit.tcl:242
 msgid "Commit declined by pre-commit hook."
-msgstr "Incheckningen avvisades av krok f=C3=B6re incheckning."
+msgstr "Incheckningen avvisades av kroken f=C3=B6re incheckning (pre-c=
ommit)."
=20
-#: lib/commit.tcl:259
+#: lib/commit.tcl:265
 msgid "Calling commit-msg hook..."
-msgstr "Anropar krok f=C3=B6r incheckningsmeddelande..."
+msgstr "Anropar kroken f=C3=B6r incheckningsmeddelande (commit-msg)...=
"
=20
-#: lib/commit.tcl:274
+#: lib/commit.tcl:280
 msgid "Commit declined by commit-msg hook."
-msgstr "Incheckning avvisad av krok f=C3=B6r incheckningsmeddelande."
+msgstr "Incheckning avvisad av kroken f=C3=B6r incheckningsmeddelande =
(commit-msg)."
=20
-#: lib/commit.tcl:287
+#: lib/commit.tcl:293
 msgid "Committing changes..."
 msgstr "Checkar in =C3=A4ndringar..."
=20
-#: lib/commit.tcl:303
+#: lib/commit.tcl:309
 msgid "write-tree failed:"
 msgstr "write-tree misslyckades:"
=20
-#: lib/commit.tcl:304 lib/commit.tcl:348 lib/commit.tcl:368
+#: lib/commit.tcl:310 lib/commit.tcl:354 lib/commit.tcl:374
 msgid "Commit failed."
 msgstr "Incheckningen misslyckades."
=20
-#: lib/commit.tcl:321
+#: lib/commit.tcl:327
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "Incheckningen %s verkar vara trasig"
=20
-#: lib/commit.tcl:326
+#: lib/commit.tcl:332
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1346,19 +1446,19 @@ msgstr ""
 "\n"
 "En s=C3=B6kning kommer att startas automatiskt nu.\n"
=20
-#: lib/commit.tcl:333
+#: lib/commit.tcl:339
 msgid "No changes to commit."
 msgstr "Inga =C3=A4ndringar att checka in."
=20
-#: lib/commit.tcl:347
+#: lib/commit.tcl:353
 msgid "commit-tree failed:"
 msgstr "commit-tree misslyckades:"
=20
-#: lib/commit.tcl:367
+#: lib/commit.tcl:373
 msgid "update-ref failed:"
 msgstr "update-ref misslyckades:"
=20
-#: lib/commit.tcl:454
+#: lib/commit.tcl:461
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr "Skapade incheckningen %s: %s"
@@ -1433,7 +1533,7 @@ msgstr ""
 msgid "Invalid date from Git: %s"
 msgstr "Ogiltigt datum fr=C3=A5n Git: %s"
=20
-#: lib/diff.tcl:44
+#: lib/diff.tcl:59
 #, tcl-format
 msgid ""
 "No differences detected.\n"
@@ -1456,48 +1556,98 @@ msgstr ""
 "En s=C3=B6kning kommer automatiskt att startas f=C3=B6r att hitta and=
ra filer som kan "
 "vara i samma tillst=C3=A5nd."
=20
-#: lib/diff.tcl:83
+#: lib/diff.tcl:99
 #, tcl-format
 msgid "Loading diff of %s..."
 msgstr "L=C3=A4ser differens f=C3=B6r %s..."
=20
-#: lib/diff.tcl:116 lib/diff.tcl:190
+#: lib/diff.tcl:120
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr "LOKAL: borttagen\n"
+"FJ=C3=84RR:\n"
+
+#: lib/diff.tcl:125
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr "FJ=C3=84RR: borttagen\n"
+"LOKAL:\n"
+
+#: lib/diff.tcl:132
+msgid "LOCAL:\n"
+msgstr "LOKAL:\n"
+
+#: lib/diff.tcl:135
+msgid "REMOTE:\n"
+msgstr "FJ=C3=84RR:\n"
+
+#: lib/diff.tcl:197 lib/diff.tcl:296
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "Kan inte visa %s"
=20
-#: lib/diff.tcl:117
+#: lib/diff.tcl:198
 msgid "Error loading file:"
 msgstr "Fel vid l=C3=A4sning av fil:"
=20
-#: lib/diff.tcl:124
+#: lib/diff.tcl:205
 msgid "Git Repository (subproject)"
 msgstr "Gitarkiv (underprojekt)"
=20
-#: lib/diff.tcl:136
+#: lib/diff.tcl:217
 msgid "* Binary file (not showing content)."
 msgstr "* Bin=C3=A4rfil (visar inte inneh=C3=A5llet)."
=20
-#: lib/diff.tcl:191
-msgid "Error loading diff:"
-msgstr "Fel vid inl=C3=A4sning av differens:"
+#: lib/diff.tcl:222
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr "* Den osp=C3=A5rade filen =C3=A4r %d byte.\n"
+"* Visar endast inledande %d byte.\n"
=20
-#: lib/diff.tcl:313
+#: lib/diff.tcl:228
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"* Den osp=C3=A5rade filen klipptes h=C3=A4r av %s.\n"
+"* F=C3=B6r att se hela filen, anv=C3=A4nd ett externt redigeringsprog=
ram.\n"
+
+#: lib/diff.tcl:436
 msgid "Failed to unstage selected hunk."
 msgstr "Kunde inte ta bort den valda delen fr=C3=A5n k=C3=B6n."
=20
-#: lib/diff.tcl:320
+#: lib/diff.tcl:443
 msgid "Failed to stage selected hunk."
 msgstr "Kunde inte l=C3=A4gga till den valda delen till k=C3=B6n."
=20
-#: lib/diff.tcl:386
+#: lib/diff.tcl:509
 msgid "Failed to unstage selected line."
 msgstr "Kunde inte ta bort den valda raden fr=C3=A5n k=C3=B6n."
=20
-#: lib/diff.tcl:394
+#: lib/diff.tcl:517
 msgid "Failed to stage selected line."
 msgstr "Kunde inte l=C3=A4gga till den valda raden till k=C3=B6n."
=20
+#: lib/encoding.tcl:443
+msgid "Default"
+msgstr "Standard"
+
+#: lib/encoding.tcl:448
+#, tcl-format
+msgid "System (%s)"
+msgstr "Systemets (%s)"
+
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
+msgstr "Annan"
+
 #: lib/error.tcl:20 lib/error.tcl:114
 msgid "error"
 msgstr "fel"
@@ -1534,39 +1684,48 @@ msgstr "Forst=C3=A4tt"
 msgid "Unlock Index"
 msgstr "L=C3=A5s upp index"
=20
-#: lib/index.tcl:282
+#: lib/index.tcl:287
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "Tar bort %s f=C3=B6r incheckningsk=C3=B6n"
=20
-#: lib/index.tcl:313
+#: lib/index.tcl:326
 msgid "Ready to commit."
 msgstr "Redo att checka in."
=20
-#: lib/index.tcl:326
+#: lib/index.tcl:339
 #, tcl-format
 msgid "Adding %s"
 msgstr "L=C3=A4gger till %s"
=20
-#: lib/index.tcl:381
+#: lib/index.tcl:396
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "=C3=85terst=C3=A4ll =C3=A4ndringarna i filen %s?"
=20
-#: lib/index.tcl:383
+#: lib/index.tcl:398
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "=C3=85terst=C3=A4ll =C3=A4ndringarna i dessa %i filer?"
=20
-#: lib/index.tcl:391
+#: lib/index.tcl:406
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 "Alla ok=C3=B6ade =C3=A4ndringar kommer permanent g=C3=A5 f=C3=B6rlora=
de vid =C3=A5terst=C3=A4llningen."
=20
-#: lib/index.tcl:394
+#: lib/index.tcl:409
 msgid "Do Nothing"
 msgstr "G=C3=B6r ingenting"
=20
+#: lib/index.tcl:427
+msgid "Reverting selected files"
+msgstr "=C3=85terst=C3=A4ller valda filer"
+
+#: lib/index.tcl:431
+#, tcl-format
+msgid "Reverting %s"
+msgstr "=C3=85terst=C3=A4ller %s"
+
 #: lib/merge.tcl:13
 msgid ""
 "Cannot merge while amending.\n"
@@ -1594,7 +1753,7 @@ msgstr ""
 "\n"
 "S=C3=B6kningen kommer att startas automatiskt nu.\n"
=20
-#: lib/merge.tcl:44
+#: lib/merge.tcl:45
 #, tcl-format
 msgid ""
 "You are in the middle of a conflicted merge.\n"
@@ -1611,7 +1770,7 @@ msgstr ""
 "Du m=C3=A5ste l=C3=B6sa dem, k=C3=B6a filen och checka in f=C3=B6r at=
t fullborda den aktuella "
 "sammanslagningen. N=C3=A4r du gjort det kan du p=C3=A5b=C3=B6rja en n=
y sammanslagning.\n"
=20
-#: lib/merge.tcl:54
+#: lib/merge.tcl:55
 #, tcl-format
 msgid ""
 "You are in the middle of a change.\n"
@@ -1629,34 +1788,34 @@ msgstr ""
 "sammanslagning. Om du g=C3=B6r det blir det enklare att avbryta en mi=
sslyckad "
 "sammanslagning, om det skulle vara n=C3=B6dv=C3=A4ndigt.\n"
=20
-#: lib/merge.tcl:106
+#: lib/merge.tcl:107
 #, tcl-format
 msgid "%s of %s"
 msgstr "%s av %s"
=20
-#: lib/merge.tcl:119
+#: lib/merge.tcl:120
 #, tcl-format
 msgid "Merging %s and %s..."
 msgstr "Sl=C3=A5r ihop %s och %s..."
=20
-#: lib/merge.tcl:130
+#: lib/merge.tcl:131
 msgid "Merge completed successfully."
 msgstr "Sammanslagningen avslutades framg=C3=A5ngsrikt."
=20
-#: lib/merge.tcl:132
+#: lib/merge.tcl:133
 msgid "Merge failed.  Conflict resolution is required."
 msgstr "Sammanslagningen misslyckades. Du m=C3=A5ste l=C3=B6sa konflik=
terna."
=20
-#: lib/merge.tcl:157
+#: lib/merge.tcl:158
 #, tcl-format
 msgid "Merge Into %s"
 msgstr "Sl=C3=A5 ihop i %s"
=20
-#: lib/merge.tcl:176
+#: lib/merge.tcl:177
 msgid "Revision To Merge"
 msgstr "Revisioner att sl=C3=A5 ihop"
=20
-#: lib/merge.tcl:211
+#: lib/merge.tcl:212
 msgid ""
 "Cannot abort while amending.\n"
 "\n"
@@ -1666,7 +1825,7 @@ msgstr ""
 "\n"
 "Du m=C3=A5ste g=C3=B6ra dig f=C3=A4rdig med att ut=C3=B6ka inchecknin=
gen.\n"
=20
-#: lib/merge.tcl:221
+#: lib/merge.tcl:222
 msgid ""
 "Abort merge?\n"
 "\n"
@@ -1681,7 +1840,7 @@ msgstr ""
 "\n"
 "G=C3=A5 vidare med att avbryta den aktuella sammanslagningen?"
=20
-#: lib/merge.tcl:227
+#: lib/merge.tcl:228
 msgid ""
 "Reset changes?\n"
 "\n"
@@ -1696,119 +1855,321 @@ msgstr ""
 "\n"
 "G=C3=A5 vidare med att =C3=A5terst=C3=A4lla de aktuella =C3=A4ndringa=
rna?"
=20
-#: lib/merge.tcl:238
+#: lib/merge.tcl:239
 msgid "Aborting"
 msgstr "Avbryter"
=20
-#: lib/merge.tcl:238
+#: lib/merge.tcl:239
 msgid "files reset"
 msgstr "filer =C3=A5terst=C3=A4llda"
=20
-#: lib/merge.tcl:266
+#: lib/merge.tcl:267
 msgid "Abort failed."
 msgstr "Misslyckades avbryta."
=20
-#: lib/merge.tcl:268
+#: lib/merge.tcl:269
 msgid "Abort completed.  Ready."
 msgstr "Avbrytning fullbordad. Redo."
=20
-#: lib/option.tcl:95
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
+msgstr "Tvinga l=C3=B6sning att anv=C3=A4nda basversionen?"
+
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
+msgstr "Tvinga l=C3=B6sning att anv=C3=A4nda den aktuella grenen?"
+
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
+msgstr "Tvinga l=C3=B6sning att anv=C3=A4nda den andra grenen?"
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
+"Observera att diffen endast visar de =C3=A4ndringar som st=C3=A5r i k=
onflikt.\n"
+"\n"
+"%s kommer att skrivas =C3=B6ver.\n"
+"\n"
+"Du m=C3=A5ste starta om sammanslagningen f=C3=B6r att g=C3=B6ra den h=
=C3=A4r operationen ogjord."
+
+#: lib/mergetool.tcl:45
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
+msgstr "Filen %s verkar inneh=C3=A5lla ol=C3=B6sta konflikter. Vill du=
 k=C3=B6a =C3=A4nd=C3=A5?"
+
+#: lib/mergetool.tcl:60
+#, tcl-format
+msgid "Adding resolution for %s"
+msgstr "L=C3=A4gger till l=C3=B6sning f=C3=B6r %s"
+
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr "Kan inte l=C3=B6sa borttagnings- eller l=C3=A4nkkonflikter med=
 ett verktyg"
+
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
+msgstr "Konfliktfil existerar inte"
+
+#: lib/mergetool.tcl:264
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "Inte ett grafiskt verktyg f=C3=B6r sammanslagning: %s"
+
+#: lib/mergetool.tcl:268
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr "Verktyget \"%s\" f=C3=B6r sammanslagning st=C3=B6ds inte"
+
+#: lib/mergetool.tcl:303
+msgid "Merge tool is already running, terminate it?"
+msgstr "Verktyget f=C3=B6r sammanslagning k=C3=B6rs redan. Vill du avs=
luta det?"
+
+#: lib/mergetool.tcl:323
+#, tcl-format
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr "Fel vid h=C3=A4mtning av versioner:\n"
+"%s"
+
+#: lib/mergetool.tcl:343
+#, tcl-format
+msgid ""
+"Could not start the merge tool:\n"
+"\n"
+"%s"
+msgstr "Kunde inte starta verktyg f=C3=B6r sammanslagning:\n"
+"\n"
+"%s"
+
+#: lib/mergetool.tcl:347
+msgid "Running merge tool..."
+msgstr "K=C3=B6r verktyg f=C3=B6r sammanslagning..."
+
+#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
+msgid "Merge tool failed."
+msgstr "Verktyget f=C3=B6r sammanslagning misslyckades."
+
+#: lib/option.tcl:11
+#, tcl-format
+msgid "Invalid global encoding '%s'"
+msgstr "Den globala teckenkodningen \"%s\" =C3=A4r ogiltig"
+
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
+msgstr "Arkivets teckenkodning \"%s\" =C3=A4r ogiltig"
+
+#: lib/option.tcl:117
 msgid "Restore Defaults"
 msgstr "=C3=85terst=C3=A4ll standardv=C3=A4rden"
=20
-#: lib/option.tcl:99
+#: lib/option.tcl:121
 msgid "Save"
 msgstr "Spara"
=20
-#: lib/option.tcl:109
+#: lib/option.tcl:131
 #, tcl-format
 msgid "%s Repository"
 msgstr "Arkivet %s"
=20
-#: lib/option.tcl:110
+#: lib/option.tcl:132
 msgid "Global (All Repositories)"
 msgstr "Globalt (alla arkiv)"
=20
-#: lib/option.tcl:116
+#: lib/option.tcl:138
 msgid "User Name"
 msgstr "Anv=C3=A4ndarnamn"
=20
-#: lib/option.tcl:117
+#: lib/option.tcl:139
 msgid "Email Address"
 msgstr "E-postadress"
=20
-#: lib/option.tcl:119
+#: lib/option.tcl:141
 msgid "Summarize Merge Commits"
 msgstr "Summera sammanslagningsincheckningar"
=20
-#: lib/option.tcl:120
+#: lib/option.tcl:142
 msgid "Merge Verbosity"
 msgstr "Pratsamhet f=C3=B6r sammanslagningar"
=20
-#: lib/option.tcl:121
+#: lib/option.tcl:143
 msgid "Show Diffstat After Merge"
 msgstr "Visa diffstatistik efter sammanslagning"
=20
-#: lib/option.tcl:123
+#: lib/option.tcl:144
+msgid "Use Merge Tool"
+msgstr "Anv=C3=A4nd verktyg f=C3=B6r sammanslagning"
+
+#: lib/option.tcl:146
 msgid "Trust File Modification Timestamps"
 msgstr "Lita p=C3=A5 fil=C3=A4ndringstidsst=C3=A4mplar"
=20
-#: lib/option.tcl:124
+#: lib/option.tcl:147
 msgid "Prune Tracking Branches During Fetch"
 msgstr "St=C3=A4da sp=C3=A5rade grenar vid h=C3=A4mtning"
=20
-#: lib/option.tcl:125
+#: lib/option.tcl:148
 msgid "Match Tracking Branches"
 msgstr "Matcha sp=C3=A5rade grenar"
=20
-#: lib/option.tcl:126
+#: lib/option.tcl:149
 msgid "Blame Copy Only On Changed Files"
 msgstr "Klandra kopiering bara i =C3=A4ndrade filer"
=20
-#: lib/option.tcl:127
+#: lib/option.tcl:150
 msgid "Minimum Letters To Blame Copy On"
 msgstr "Minsta antal tecken att klandra kopiering f=C3=B6r"
=20
-#: lib/option.tcl:128
+#: lib/option.tcl:151
+msgid "Blame History Context Radius (days)"
+msgstr "Historikradie f=C3=B6r klandring (dagar)"
+
+#: lib/option.tcl:152
 msgid "Number of Diff Context Lines"
 msgstr "Antal rader sammanhang i differenser"
=20
-#: lib/option.tcl:129
+#: lib/option.tcl:153
 msgid "Commit Message Text Width"
 msgstr "Textbredd f=C3=B6r incheckningsmeddelande"
=20
-#: lib/option.tcl:130
+#: lib/option.tcl:154
 msgid "New Branch Name Template"
 msgstr "Mall f=C3=B6r namn p=C3=A5 nya grenar"
=20
-#: lib/option.tcl:194
+#: lib/option.tcl:155
+msgid "Default File Contents Encoding"
+msgstr "Standardteckenkodning f=C3=B6r filinneh=C3=A5ll"
+
+#: lib/option.tcl:203
+msgid "Change"
+msgstr "=C3=84ndra"
+
+#: lib/option.tcl:230
 msgid "Spelling Dictionary:"
 msgstr "Stavningsordlista:"
=20
-#: lib/option.tcl:218
+#: lib/option.tcl:254
 msgid "Change Font"
 msgstr "Byt teckensnitt"
=20
-#: lib/option.tcl:222
+#: lib/option.tcl:258
 #, tcl-format
 msgid "Choose %s"
 msgstr "V=C3=A4lj %s"
=20
-#: lib/option.tcl:228
+#: lib/option.tcl:264
 msgid "pt."
 msgstr "p."
=20
-#: lib/option.tcl:242
+#: lib/option.tcl:278
 msgid "Preferences"
 msgstr "Inst=C3=A4llningar"
=20
-#: lib/option.tcl:277
+#: lib/option.tcl:314
 msgid "Failed to completely save options:"
 msgstr "Misslyckades med att helt spara alternativ:"
=20
+#: lib/remote.tcl:163
+msgid "Remove Remote"
+msgstr "Ta bort fj=C3=A4rrarkiv"
+
+#: lib/remote.tcl:168
+msgid "Prune from"
+msgstr "Ta bort fr=C3=A5n"
+
+#: lib/remote.tcl:173
+msgid "Fetch from"
+msgstr "H=C3=A4mta fr=C3=A5n"
+
+#: lib/remote.tcl:215
+msgid "Push to"
+msgstr "S=C3=A4nd till"
+
+#: lib/remote_add.tcl:19
+msgid "Add Remote"
+msgstr "L=C3=A4gg till fj=C3=A4rrarkiv"
+
+#: lib/remote_add.tcl:24
+msgid "Add New Remote"
+msgstr "L=C3=A4gg till nytt fj=C3=A4rrarkiv"
+
+#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
+msgid "Add"
+msgstr "L=C3=A4gg till"
+
+#: lib/remote_add.tcl:37
+msgid "Remote Details"
+msgstr "Detaljer f=C3=B6r fj=C3=A4rrarkiv"
+
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "Plats:"
+
+#: lib/remote_add.tcl:62
+msgid "Further Action"
+msgstr "Ytterligare =C3=A5tg=C3=A4rd"
+
+#: lib/remote_add.tcl:65
+msgid "Fetch Immediately"
+msgstr "H=C3=A4mta omedelbart"
+
+#: lib/remote_add.tcl:71
+msgid "Initialize Remote Repository and Push"
+msgstr "Initiera fj=C3=A4rrarkiv och s=C3=A4nd till"
+
+#: lib/remote_add.tcl:77
+msgid "Do Nothing Else Now"
+msgstr "G=C3=B6r ingent mer nu"
+
+#: lib/remote_add.tcl:101
+msgid "Please supply a remote name."
+msgstr "Ange ett namn f=C3=B6r fj=C3=A4rrarkivet."
+
+#: lib/remote_add.tcl:114
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "\"%s\" kan inte anv=C3=A4ndas som namn p=C3=A5 fj=C3=A4rrarkiv=
et."
+
+#: lib/remote_add.tcl:125
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "Kunde inte l=C3=A4gga till fj=C3=A4rrarkivet \"%s\" p=C3=A5 pl=
atsen \"%s\"."
+
+#: lib/remote_add.tcl:133 lib/transport.tcl:6
+#, tcl-format
+msgid "fetch %s"
+msgstr "h=C3=A4mta %s"
+
+#: lib/remote_add.tcl:134
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "H=C3=A4mtar %s"
+
+#: lib/remote_add.tcl:157
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "Vet inte hur arkivet p=C3=A5 platsen \"%s\" skall initieras."
+
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:71
+#, tcl-format
+msgid "push %s"
+msgstr "s=C3=A4nd %s"
+
+#: lib/remote_add.tcl:164
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "Konfigurerar %s (p=C3=A5 %s)"
+
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
-msgid "Delete Remote Branch"
-msgstr "Ta bort fj=C3=A4rrgren"
+msgid "Delete Branch Remotely"
+msgstr "Ta bort gren fr=C3=A5n fj=C3=A4rrarkiv"
=20
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
@@ -1816,11 +2177,11 @@ msgstr "Fr=C3=A5n arkiv"
=20
 #: lib/remote_branch_delete.tcl:50 lib/transport.tcl:123
 msgid "Remote:"
-msgstr "Fj=C3=A4rr:"
+msgstr "Fj=C3=A4rrarkiv:"
=20
 #: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
-msgid "Arbitrary URL:"
-msgstr "Godtycklig webbadress:"
+msgid "Arbitrary Location:"
+msgstr "Godtycklig plats:"
=20
 #: lib/remote_branch_delete.tcl:84
 msgid "Branches"
@@ -1890,17 +2251,21 @@ msgstr "Inget arkiv markerat."
 msgid "Scanning %s..."
 msgstr "S=C3=B6ker %s..."
=20
-#: lib/remote.tcl:165
-msgid "Prune from"
-msgstr "Ta bort fr=C3=A5n"
+#: lib/search.tcl:21
+msgid "Find:"
+msgstr "S=C3=B6k:"
=20
-#: lib/remote.tcl:170
-msgid "Fetch from"
-msgstr "H=C3=A4mta fr=C3=A5n"
+#: lib/search.tcl:23
+msgid "Next"
+msgstr "N=C3=A4sta"
=20
-#: lib/remote.tcl:213
-msgid "Push to"
-msgstr "S=C3=A4nd till"
+#: lib/search.tcl:24
+msgid "Prev"
+msgstr "F=C3=B6reg"
+
+#: lib/search.tcl:25
+msgid "Case-Sensitive"
+msgstr "Skilj p=C3=A5 VERSALER/gemener"
=20
 #: lib/shortcut.tcl:20 lib/shortcut.tcl:61
 msgid "Cannot write shortcut:"
@@ -1939,23 +2304,186 @@ msgstr "Stavningskontrollprogrammet k=C3=A4nns=
 inte igen"
 msgid "No Suggestions"
 msgstr "Inga f=C3=B6rslag"
=20
-#: lib/spellcheck.tcl:387
+#: lib/spellcheck.tcl:388
 msgid "Unexpected EOF from spell checker"
 msgstr "Ov=C3=A4ntat filslut fr=C3=A5n stavningskontroll"
=20
-#: lib/spellcheck.tcl:391
+#: lib/spellcheck.tcl:392
 msgid "Spell Checker Failed"
 msgstr "Stavningskontroll misslyckades"
=20
+#: lib/sshkey.tcl:31
+msgid "No keys found."
+msgstr "Inga nycklar hittades."
+
+#: lib/sshkey.tcl:34
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "Hittade =C3=B6ppen nyckel i: %s"
+
+#: lib/sshkey.tcl:40
+msgid "Generate Key"
+msgstr "Skapa nyckel"
+
+#: lib/sshkey.tcl:56
+msgid "Copy To Clipboard"
+msgstr "Kopiera till Urklipp"
+
+#: lib/sshkey.tcl:70
+msgid "Your OpenSSH Public Key"
+msgstr "Din =C3=B6ppna OpenSSH-nyckel"
+
+#: lib/sshkey.tcl:78
+msgid "Generating..."
+msgstr "Skapar..."
+
+#: lib/sshkey.tcl:84
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr "Kunde inte starta ssh-keygen:\n"
+"\n"
+"%s"
+
+#: lib/sshkey.tcl:111
+msgid "Generation failed."
+msgstr "Misslyckades med att skapa."
+
+#: lib/sshkey.tcl:118
+msgid "Generation succeded, but no keys found."
+msgstr "Lyckades skapa nyckeln, men hittar inte n=C3=A5gon nyckel."
+
+#: lib/sshkey.tcl:121
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "Din nyckel finns i: %s"
+
 #: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%s... %*i av %*i %s (%3i%%)"
=20
-#: lib/transport.tcl:6
+#: lib/tools.tcl:75
 #, tcl-format
-msgid "fetch %s"
-msgstr "h=C3=A4mta %s"
+msgid "Running %s requires a selected file."
+msgstr "F=C3=B6r att starta %s m=C3=A5ste du v=C3=A4lja en fil."
+
+#: lib/tools.tcl:90
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "=C3=84r du s=C3=A4ker p=C3=A5 att du vill starta %s?"
+
+#: lib/tools.tcl:110
+#, tcl-format
+msgid "Tool: %s"
+msgstr "Verktyg: %s"
+
+#: lib/tools.tcl:111
+#, tcl-format
+msgid "Running: %s"
+msgstr "Exekverar: %s"
+
+#: lib/tools.tcl:149
+#, tcl-format
+msgid "Tool completed succesfully: %s"
+msgstr "Verktyget avslutades framg=C3=A5ngsrikt."
+
+#: lib/tools.tcl:151
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "Verktyget misslyckades: %s"
+
+#: lib/tools_dlg.tcl:22
+msgid "Add Tool"
+msgstr "L=C3=A4gg till verktyg"
+
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "L=C3=A4gg till nytt verktygskommando"
+
+#: lib/tools_dlg.tcl:33
+msgid "Add globally"
+msgstr "L=C3=A4gg till globalt"
+
+#: lib/tools_dlg.tcl:45
+msgid "Tool Details"
+msgstr "Detaljer f=C3=B6r verktyg"
+
+#: lib/tools_dlg.tcl:48
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "Anv=C3=A4nd \"/\"-avdelare f=C3=B6r att skapa ett undermenytr=C3=
=A4d:"
+
+#: lib/tools_dlg.tcl:61
+msgid "Command:"
+msgstr "Kommando:"
+
+#: lib/tools_dlg.tcl:74
+msgid "Show a dialog before running"
+msgstr "Visa dialog innan programmet startas"
+
+#: lib/tools_dlg.tcl:80
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "Be anv=C3=A4ndaren v=C3=A4lja en version (s=C3=A4tter $REVISIO=
N)"
+
+#: lib/tools_dlg.tcl:85
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "Be anv=C3=A4ndaren om ytterligare parametrar (s=C3=A4tter $ARG=
S)"
+
+#: lib/tools_dlg.tcl:92
+msgid "Don't show the command output window"
+msgstr "Visa inte kommandots utdataf=C3=B6nster"
+
+#: lib/tools_dlg.tcl:97
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "K=C3=B6r endast om en diff har markerats ($FILENAME =C3=A4r in=
te tomt)"
+
+#: lib/tools_dlg.tcl:121
+msgid "Please supply a name for the tool."
+msgstr "Ange ett namn f=C3=B6r verktyget."
+
+#: lib/tools_dlg.tcl:129
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "Verktyget \"%s\" finns redan."
+
+#: lib/tools_dlg.tcl:151
+#, tcl-format
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr "Kunde inte l=C3=A4gga till verktyget:\n"
+"%s"
+
+#: lib/tools_dlg.tcl:190
+msgid "Remove Tool"
+msgstr "Ta bort verktyg"
+
+#: lib/tools_dlg.tcl:196
+msgid "Remove Tool Commands"
+msgstr "Ta bort verktygskommandon"
+
+#: lib/tools_dlg.tcl:200
+msgid "Remove"
+msgstr "Ta bort"
+
+#: lib/tools_dlg.tcl:236
+msgid "(Blue denotes repository-local tools)"
+msgstr "(Bl=C3=A5tt anger verktyg lokala f=C3=B6r arkivet)"
+
+#: lib/tools_dlg.tcl:297
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "K=C3=B6r kommandot: %s"
+
+#: lib/tools_dlg.tcl:311
+msgid "Arguments"
+msgstr "Argument"
+
+#: lib/tools_dlg.tcl:348
+msgid "OK"
+msgstr "OK"
=20
 #: lib/transport.tcl:7
 #, tcl-format
@@ -1972,11 +2500,6 @@ msgstr "fj=C3=A4rrborttagning %s"
 msgid "Pruning tracking branches deleted from %s"
 msgstr "Tar bort sp=C3=A5rande grenar som tagits bort fr=C3=A5n %s"
=20
-#: lib/transport.tcl:25 lib/transport.tcl:71
-#, tcl-format
-msgid "push %s"
-msgstr "s=C3=A4nd %s"
-
 #: lib/transport.tcl:26
 #, tcl-format
 msgid "Pushing changes to %s"
@@ -1989,7 +2512,7 @@ msgstr "S=C3=A4nder %s %s till %s"
=20
 #: lib/transport.tcl:89
 msgid "Push Branches"
-msgstr "S=C3=A4nder grenar"
+msgstr "S=C3=A4nd grenar"
=20
 #: lib/transport.tcl:103
 msgid "Source Branches"
@@ -2015,6 +2538,12 @@ msgstr "Anv=C3=A4nd tunt paket (f=C3=B6r l=C3=A5=
ngsamma n=C3=A4tverksanslutningar)"
 msgid "Include tags"
 msgstr "Ta med taggar"
=20
+#~ msgid "URL:"
+#~ msgstr "Webbadress:"
+
+#~ msgid "Delete Remote Branch"
+#~ msgstr "Ta bort fj=C3=A4rrgren"
+
 #~ msgid ""
 #~ "Unable to start gitk:\n"
 #~ "\n"
--=20
1.5.6.5
