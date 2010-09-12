From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH] git-gui: Update Swedish translation (521t).
Date: Sun, 12 Sep 2010 21:13:29 +0100
Message-ID: <20100912202124.833B32FC00@perkele>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Sep 12 22:21:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Out3M-0000tk-85
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 22:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639Ab0ILUV3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Sep 2010 16:21:29 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43720 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753579Ab0ILUV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 16:21:27 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L8N005SDHVPQ740@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 12 Sep 2010 22:21:25 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 7B8361799109_C8D3645B	for <git@vger.kernel.org>; Sun,
 12 Sep 2010 20:21:25 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 2E3AB17968A6_C8D3645F	for <git@vger.kernel.org>; Sun,
 12 Sep 2010 20:21:25 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L8N00JGUHVO8U30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 12 Sep 2010 22:21:25 +0200 (MEST)
Received: by perkele (Postfix, from userid 501)	id 833B32FC00; Sun,
 12 Sep 2010 22:21:24 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156054>

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
 po/sv.po |  802 +++++++++++++++++++++++++++++++-----------------------=
--------
 1 files changed, 403 insertions(+), 399 deletions(-)

diff --git a/po/sv.po b/po/sv.po
index d8d73ac..8bd3c5d 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -8,41 +8,41 @@ msgid ""
 msgstr ""
 "Project-Id-Version: sv\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2010-01-26 15:47-0800\n"
-"PO-Revision-Date: 2010-01-28 13:57+0100\n"
+"POT-Creation-Date: 2010-09-12 21:11+0100\n"
+"PO-Revision-Date: 2010-09-12 21:12+0100\n"
 "Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
 "Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit"
=20
-#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.=
sh:903
-#: git-gui.sh:922
-msgid "git-gui: fatal error"
-msgstr "git-gui: =C3=B6desdigert fel"
-
-#: git-gui.sh:743
+#: git-gui.sh:781
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "Ogiltigt teckensnitt angivet i %s:"
=20
-#: git-gui.sh:779
+#: git-gui.sh:831
 msgid "Main Font"
 msgstr "Huvudteckensnitt"
=20
-#: git-gui.sh:780
+#: git-gui.sh:832
 msgid "Diff/Console Font"
 msgstr "Diff/konsolteckensnitt"
=20
-#: git-gui.sh:794
+#: git-gui.sh:845 git-gui.sh:859 git-gui.sh:872 git-gui.sh:955 git-gui=
=2Esh:974
+#: git-gui.sh:2964
+msgid "git-gui: fatal error"
+msgstr "git-gui: =C3=B6desdigert fel"
+
+#: git-gui.sh:846
 msgid "Cannot find git in PATH."
 msgstr "Hittar inte git i PATH."
=20
-#: git-gui.sh:821
+#: git-gui.sh:873
 msgid "Cannot parse Git version string:"
 msgstr "Kan inte tolka versionsstr=C3=A4ng fr=C3=A5n Git:"
=20
-#: git-gui.sh:839
+#: git-gui.sh:891
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -61,478 +61,478 @@ msgstr ""
 "\n"
 "Anta att \"%s\" =C3=A4r version 1.5.0?\n"
=20
-#: git-gui.sh:1128
+#: git-gui.sh:1180
 msgid "Git directory not found:"
 msgstr "Git-katalogen hittades inte:"
=20
-#: git-gui.sh:1146
+#: git-gui.sh:1201
 msgid "Cannot move to top of working directory:"
 msgstr "Kan inte g=C3=A5 till b=C3=B6rjan p=C3=A5 arbetskatalogen:"
=20
-#: git-gui.sh:1154
+#: git-gui.sh:1209
 msgid "Cannot use bare repository:"
 msgstr "Kan inte anv=C3=A4nda naket arkiv:"
=20
-#: git-gui.sh:1162
+#: git-gui.sh:1217
 msgid "No working directory"
 msgstr "Ingen arbetskatalog"
=20
-#: git-gui.sh:1334 lib/checkout_op.tcl:306
+#: git-gui.sh:1389 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr "Uppdaterar filstatus..."
=20
-#: git-gui.sh:1390
+#: git-gui.sh:1445
 msgid "Scanning for modified files ..."
 msgstr "S=C3=B6ker efter =C3=A4ndrade filer..."
=20
-#: git-gui.sh:1454
+#: git-gui.sh:1509
 msgid "Calling prepare-commit-msg hook..."
 msgstr ""
 "Anropar kroken f=C3=B6r f=C3=B6rberedelse av incheckningsmeddelande (=
prepare-commit-"
 "msg)..."
=20
-#: git-gui.sh:1471
+#: git-gui.sh:1526
 msgid "Commit declined by prepare-commit-msg hook."
 msgstr ""
 "Incheckningen avvisades av kroken f=C3=B6r f=C3=B6rberedelse av inche=
ckningsmeddelande "
 "(prepare-commit-msg)."
=20
-#: git-gui.sh:1629 lib/browser.tcl:246
+#: git-gui.sh:1684 lib/browser.tcl:246
 msgid "Ready."
 msgstr "Klar."
=20
-#: git-gui.sh:1787
+#: git-gui.sh:1842
 #, tcl-format
 msgid "Displaying only %s of %s files."
 msgstr "Visar endast %s av %s filer."
=20
-#: git-gui.sh:1913
+#: git-gui.sh:1968
 msgid "Unmodified"
 msgstr "Of=C3=B6r=C3=A4ndrade"
=20
-#: git-gui.sh:1915
+#: git-gui.sh:1970
 msgid "Modified, not staged"
 msgstr "F=C3=B6r=C3=A4ndrade, ej k=C3=B6ade"
=20
-#: git-gui.sh:1916 git-gui.sh:1924
+#: git-gui.sh:1971 git-gui.sh:1979
 msgid "Staged for commit"
 msgstr "K=C3=B6ade f=C3=B6r incheckning"
=20
-#: git-gui.sh:1917 git-gui.sh:1925
+#: git-gui.sh:1972 git-gui.sh:1980
 msgid "Portions staged for commit"
 msgstr "Delar k=C3=B6ade f=C3=B6r incheckning"
=20
-#: git-gui.sh:1918 git-gui.sh:1926
+#: git-gui.sh:1973 git-gui.sh:1981
 msgid "Staged for commit, missing"
 msgstr "K=C3=B6ade f=C3=B6r incheckning, saknade"
=20
-#: git-gui.sh:1920
+#: git-gui.sh:1975
 msgid "File type changed, not staged"
 msgstr "Filtyp =C3=A4ndrad, ej k=C3=B6ade"
=20
-#: git-gui.sh:1921
+#: git-gui.sh:1976
 msgid "File type changed, staged"
 msgstr "Filtyp =C3=A4ndrad, k=C3=B6ade"
=20
-#: git-gui.sh:1923
+#: git-gui.sh:1978
 msgid "Untracked, not staged"
 msgstr "Ej sp=C3=A5rade, ej k=C3=B6ade"
=20
-#: git-gui.sh:1928
+#: git-gui.sh:1983
 msgid "Missing"
 msgstr "Saknade"
=20
-#: git-gui.sh:1929
+#: git-gui.sh:1984
 msgid "Staged for removal"
 msgstr "K=C3=B6ade f=C3=B6r borttagning"
=20
-#: git-gui.sh:1930
+#: git-gui.sh:1985
 msgid "Staged for removal, still present"
 msgstr "K=C3=B6ade f=C3=B6r borttagning, fortfarande n=C3=A4rvarande"
=20
-#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
-#: git-gui.sh:1936 git-gui.sh:1937
+#: git-gui.sh:1987 git-gui.sh:1988 git-gui.sh:1989 git-gui.sh:1990
+#: git-gui.sh:1991 git-gui.sh:1992
 msgid "Requires merge resolution"
 msgstr "Kr=C3=A4ver konflikthantering efter sammanslagning"
=20
-#: git-gui.sh:1972
+#: git-gui.sh:2027
 msgid "Starting gitk... please wait..."
 msgstr "Startar gitk... v=C3=A4nta..."
=20
-#: git-gui.sh:1984
+#: git-gui.sh:2039
 msgid "Couldn't find gitk in PATH"
 msgstr "Hittade inte gitk i PATH."
=20
-#: git-gui.sh:2043
+#: git-gui.sh:2098
 msgid "Couldn't find git gui in PATH"
 msgstr "Hittade inte git gui i PATH."
=20
-#: git-gui.sh:2455 lib/choose_repository.tcl:36
+#: git-gui.sh:2515 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "Arkiv"
=20
-#: git-gui.sh:2456
+#: git-gui.sh:2516
 msgid "Edit"
 msgstr "Redigera"
=20
-#: git-gui.sh:2458 lib/choose_rev.tcl:561
+#: git-gui.sh:2518 lib/choose_rev.tcl:566
 msgid "Branch"
 msgstr "Gren"
=20
-#: git-gui.sh:2461 lib/choose_rev.tcl:548
+#: git-gui.sh:2521 lib/choose_rev.tcl:553
 msgid "Commit@@noun"
 msgstr "Incheckning"
=20
-#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
+#: git-gui.sh:2524 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "Sl=C3=A5 ihop"
=20
-#: git-gui.sh:2465 lib/choose_rev.tcl:557
+#: git-gui.sh:2525 lib/choose_rev.tcl:562
 msgid "Remote"
 msgstr "Fj=C3=A4rrarkiv"
=20
-#: git-gui.sh:2468
+#: git-gui.sh:2528
 msgid "Tools"
 msgstr "Verktyg"
=20
-#: git-gui.sh:2477
+#: git-gui.sh:2537
 msgid "Explore Working Copy"
 msgstr "Utforska arbetskopia"
=20
-#: git-gui.sh:2483
+#: git-gui.sh:2543
 msgid "Browse Current Branch's Files"
 msgstr "Bl=C3=A4ddra i grenens filer"
=20
-#: git-gui.sh:2487
+#: git-gui.sh:2547
 msgid "Browse Branch Files..."
 msgstr "Bl=C3=A4ddra filer p=C3=A5 gren..."
=20
-#: git-gui.sh:2492
+#: git-gui.sh:2552
 msgid "Visualize Current Branch's History"
 msgstr "Visualisera grenens historik"
=20
-#: git-gui.sh:2496
+#: git-gui.sh:2556
 msgid "Visualize All Branch History"
 msgstr "Visualisera alla grenars historik"
=20
-#: git-gui.sh:2503
+#: git-gui.sh:2563
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Bl=C3=A4ddra i filer f=C3=B6r %s"
=20
-#: git-gui.sh:2505
+#: git-gui.sh:2565
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Visualisera historik f=C3=B6r %s"
=20
-#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2570 lib/database.tcl:40 lib/database.tcl:66
 msgid "Database Statistics"
 msgstr "Databasstatistik"
=20
-#: git-gui.sh:2513 lib/database.tcl:34
+#: git-gui.sh:2573 lib/database.tcl:33
 msgid "Compress Database"
 msgstr "Komprimera databas"
=20
-#: git-gui.sh:2516
+#: git-gui.sh:2576
 msgid "Verify Database"
 msgstr "Verifiera databas"
=20
-#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
+#: git-gui.sh:2583 git-gui.sh:2587 git-gui.sh:2591 lib/shortcut.tcl:8
 #: lib/shortcut.tcl:40 lib/shortcut.tcl:72
 msgid "Create Desktop Icon"
 msgstr "Skapa skrivbordsikon"
=20
-#: git-gui.sh:2539 lib/choose_repository.tcl:183 lib/choose_repository=
=2Etcl:191
+#: git-gui.sh:2599 lib/choose_repository.tcl:188 lib/choose_repository=
=2Etcl:196
 msgid "Quit"
 msgstr "Avsluta"
=20
-#: git-gui.sh:2547
+#: git-gui.sh:2607
 msgid "Undo"
 msgstr "=C3=85ngra"
=20
-#: git-gui.sh:2550
+#: git-gui.sh:2610
 msgid "Redo"
 msgstr "G=C3=B6r om"
=20
-#: git-gui.sh:2554 git-gui.sh:3109
+#: git-gui.sh:2614 git-gui.sh:3190
 msgid "Cut"
 msgstr "Klipp ut"
=20
-#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
+#: git-gui.sh:2617 git-gui.sh:3193 git-gui.sh:3267 git-gui.sh:3340
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "Kopiera"
=20
-#: git-gui.sh:2560 git-gui.sh:3115
+#: git-gui.sh:2620 git-gui.sh:3196
 msgid "Paste"
 msgstr "Klistra in"
=20
-#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
-#: lib/remote_branch_delete.tcl:38
+#: git-gui.sh:2623 git-gui.sh:3199 lib/branch_delete.tcl:28
+#: lib/remote_branch_delete.tcl:39
 msgid "Delete"
 msgstr "Ta bort"
=20
-#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
+#: git-gui.sh:2627 git-gui.sh:3203 git-gui.sh:3344 lib/console.tcl:71
 msgid "Select All"
 msgstr "Markera alla"
=20
-#: git-gui.sh:2576
+#: git-gui.sh:2636
 msgid "Create..."
 msgstr "Skapa..."
=20
-#: git-gui.sh:2582
+#: git-gui.sh:2642
 msgid "Checkout..."
 msgstr "Checka ut..."
=20
-#: git-gui.sh:2588
+#: git-gui.sh:2648
 msgid "Rename..."
 msgstr "Byt namn..."
=20
-#: git-gui.sh:2593
+#: git-gui.sh:2653
 msgid "Delete..."
 msgstr "Ta bort..."
=20
-#: git-gui.sh:2598
+#: git-gui.sh:2658
 msgid "Reset..."
 msgstr "=C3=85terst=C3=A4ll..."
=20
-#: git-gui.sh:2608
+#: git-gui.sh:2668
 msgid "Done"
 msgstr "F=C3=A4rdig"
=20
-#: git-gui.sh:2610
+#: git-gui.sh:2670
 msgid "Commit@@verb"
 msgstr "Checka in"
=20
-#: git-gui.sh:2619 git-gui.sh:3050
+#: git-gui.sh:2679 git-gui.sh:3131
 msgid "New Commit"
 msgstr "Ny incheckning"
=20
-#: git-gui.sh:2627 git-gui.sh:3057
+#: git-gui.sh:2687 git-gui.sh:3138
 msgid "Amend Last Commit"
 msgstr "L=C3=A4gg till f=C3=B6reg=C3=A5ende incheckning"
=20
-#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2697 git-gui.sh:3092 lib/remote_branch_delete.tcl:101
 msgid "Rescan"
 msgstr "S=C3=B6k p=C3=A5 nytt"
=20
-#: git-gui.sh:2643
+#: git-gui.sh:2703
 msgid "Stage To Commit"
 msgstr "K=C3=B6a f=C3=B6r incheckning"
=20
-#: git-gui.sh:2649
+#: git-gui.sh:2709
 msgid "Stage Changed Files To Commit"
 msgstr "K=C3=B6a =C3=A4ndrade filer f=C3=B6r incheckning"
=20
-#: git-gui.sh:2655
+#: git-gui.sh:2715
 msgid "Unstage From Commit"
 msgstr "Ta bort fr=C3=A5n incheckningsk=C3=B6"
=20
-#: git-gui.sh:2661 lib/index.tcl:412
+#: git-gui.sh:2721 lib/index.tcl:415
 msgid "Revert Changes"
 msgstr "=C3=85terst=C3=A4ll =C3=A4ndringar"
=20
-#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
+#: git-gui.sh:2729 git-gui.sh:3391 git-gui.sh:3422
 msgid "Show Less Context"
 msgstr "Visa mindre sammanhang"
=20
-#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
+#: git-gui.sh:2733 git-gui.sh:3395 git-gui.sh:3426
 msgid "Show More Context"
 msgstr "Visa mer sammanhang"
=20
-#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
+#: git-gui.sh:2740 git-gui.sh:3105 git-gui.sh:3214
 msgid "Sign Off"
 msgstr "Skriv under"
=20
-#: git-gui.sh:2696
+#: git-gui.sh:2756
 msgid "Local Merge..."
 msgstr "Lokal sammanslagning..."
=20
-#: git-gui.sh:2701
+#: git-gui.sh:2761
 msgid "Abort Merge..."
 msgstr "Avbryt sammanslagning..."
=20
-#: git-gui.sh:2713 git-gui.sh:2741
+#: git-gui.sh:2773 git-gui.sh:2801
 msgid "Add..."
 msgstr "L=C3=A4gg till..."
=20
-#: git-gui.sh:2717
+#: git-gui.sh:2777
 msgid "Push..."
 msgstr "S=C3=A4nd..."
=20
-#: git-gui.sh:2721
+#: git-gui.sh:2781
 msgid "Delete Branch..."
 msgstr "Ta bort gren..."
=20
-#: git-gui.sh:2731 git-gui.sh:3292
+#: git-gui.sh:2791 git-gui.sh:3373
 msgid "Options..."
 msgstr "Alternativ..."
=20
-#: git-gui.sh:2742
+#: git-gui.sh:2802
 msgid "Remove..."
 msgstr "Ta bort..."
=20
-#: git-gui.sh:2751 lib/choose_repository.tcl:50
+#: git-gui.sh:2811 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr "Hj=C3=A4lp"
=20
-#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
+#: git-gui.sh:2815 git-gui.sh:2819 lib/about.tcl:14
 #: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
 #, tcl-format
 msgid "About %s"
 msgstr "Om %s"
=20
-#: git-gui.sh:2783
+#: git-gui.sh:2843
 msgid "Online Documentation"
 msgstr "Webbdokumentation"
=20
-#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
+#: git-gui.sh:2846 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
 msgid "Show SSH Key"
 msgstr "Visa SSH-nyckel"
=20
-#: git-gui.sh:2893
+#: git-gui.sh:2965
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 "=C3=B6desdigert: kunde inte ta status p=C3=A5 s=C3=B6kv=C3=A4gen %s: =
=46il eller katalog saknas"
=20
-#: git-gui.sh:2926
+#: git-gui.sh:2997
 msgid "Current Branch:"
 msgstr "Aktuell gren:"
=20
-#: git-gui.sh:2947
+#: git-gui.sh:3023
 msgid "Staged Changes (Will Commit)"
 msgstr "K=C3=B6ade =C3=A4ndringar (kommer att checkas in)"
=20
-#: git-gui.sh:2967
+#: git-gui.sh:3043
 msgid "Unstaged Changes"
 msgstr "Ok=C3=B6ade =C3=A4ndringar"
=20
-#: git-gui.sh:3017
+#: git-gui.sh:3098
 msgid "Stage Changed"
 msgstr "K=C3=B6a =C3=A4ndrade"
=20
-#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
+#: git-gui.sh:3117 lib/transport.tcl:107 lib/transport.tcl:196
 msgid "Push"
 msgstr "S=C3=A4nd"
=20
-#: git-gui.sh:3071
+#: git-gui.sh:3152
 msgid "Initial Commit Message:"
 msgstr "Inledande incheckningsmeddelande:"
=20
-#: git-gui.sh:3072
+#: git-gui.sh:3153
 msgid "Amended Commit Message:"
 msgstr "Ut=C3=B6kat incheckningsmeddelande:"
=20
-#: git-gui.sh:3073
+#: git-gui.sh:3154
 msgid "Amended Initial Commit Message:"
 msgstr "Ut=C3=B6kat inledande incheckningsmeddelande:"
=20
-#: git-gui.sh:3074
+#: git-gui.sh:3155
 msgid "Amended Merge Commit Message:"
 msgstr "Ut=C3=B6kat incheckningsmeddelande f=C3=B6r sammanslagning:"
=20
-#: git-gui.sh:3075
+#: git-gui.sh:3156
 msgid "Merge Commit Message:"
 msgstr "Incheckningsmeddelande f=C3=B6r sammanslagning:"
=20
-#: git-gui.sh:3076
+#: git-gui.sh:3157
 msgid "Commit Message:"
 msgstr "Incheckningsmeddelande:"
=20
-#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
+#: git-gui.sh:3206 git-gui.sh:3348 lib/console.tcl:73
 msgid "Copy All"
 msgstr "Kopiera alla"
=20
-#: git-gui.sh:3149 lib/blame.tcl:104
+#: git-gui.sh:3230 lib/blame.tcl:104
 msgid "File:"
 msgstr "Fil:"
=20
-#: git-gui.sh:3255
+#: git-gui.sh:3336
 msgid "Refresh"
 msgstr "Uppdatera"
=20
-#: git-gui.sh:3276
+#: git-gui.sh:3357
 msgid "Decrease Font Size"
 msgstr "Minska teckensnittsstorlek"
=20
-#: git-gui.sh:3280
+#: git-gui.sh:3361
 msgid "Increase Font Size"
 msgstr "=C3=96ka teckensnittsstorlek"
=20
-#: git-gui.sh:3288 lib/blame.tcl:281
+#: git-gui.sh:3369 lib/blame.tcl:281
 msgid "Encoding"
 msgstr "Teckenkodning"
=20
-#: git-gui.sh:3299
+#: git-gui.sh:3380
 msgid "Apply/Reverse Hunk"
 msgstr "Anv=C3=A4nd/=C3=A5terst=C3=A4ll del"
=20
-#: git-gui.sh:3304
+#: git-gui.sh:3385
 msgid "Apply/Reverse Line"
 msgstr "Anv=C3=A4nd/=C3=A5terst=C3=A4ll rad"
=20
-#: git-gui.sh:3323
+#: git-gui.sh:3404
 msgid "Run Merge Tool"
 msgstr "Starta verktyg f=C3=B6r sammanslagning"
=20
-#: git-gui.sh:3328
+#: git-gui.sh:3409
 msgid "Use Remote Version"
 msgstr "Anv=C3=A4nd versionen fr=C3=A5n fj=C3=A4rrarkivet"
=20
-#: git-gui.sh:3332
+#: git-gui.sh:3413
 msgid "Use Local Version"
 msgstr "Anv=C3=A4nd lokala versionen"
=20
-#: git-gui.sh:3336
+#: git-gui.sh:3417
 msgid "Revert To Base"
 msgstr "=C3=85terst=C3=A4ll till basversionen"
=20
-#: git-gui.sh:3354
+#: git-gui.sh:3435
 msgid "Visualize These Changes In The Submodule"
 msgstr "Visualisera =C3=A4ndringarna i undermodulen"
=20
-#: git-gui.sh:3358
+#: git-gui.sh:3439
 msgid "Visualize Current Branch History In The Submodule"
 msgstr "Visualisera grenens historik i undermodulen"
=20
-#: git-gui.sh:3362
+#: git-gui.sh:3443
 msgid "Visualize All Branch History In The Submodule"
 msgstr "Visualisera alla grenars historik i undermodulen"
=20
-#: git-gui.sh:3367
+#: git-gui.sh:3448
 msgid "Start git gui In The Submodule"
 msgstr "Starta git gui i undermodulen"
=20
-#: git-gui.sh:3389
+#: git-gui.sh:3483
 msgid "Unstage Hunk From Commit"
 msgstr "Ta bort del ur incheckningsk=C3=B6"
=20
-#: git-gui.sh:3391
+#: git-gui.sh:3485
 msgid "Unstage Lines From Commit"
 msgstr "Ta bort rader ur incheckningsk=C3=B6"
=20
-#: git-gui.sh:3393
+#: git-gui.sh:3487
 msgid "Unstage Line From Commit"
 msgstr "Ta bort rad ur incheckningsk=C3=B6"
=20
-#: git-gui.sh:3396
+#: git-gui.sh:3490
 msgid "Stage Hunk For Commit"
 msgstr "St=C3=A4ll del i incheckningsk=C3=B6"
=20
-#: git-gui.sh:3398
+#: git-gui.sh:3492
 msgid "Stage Lines For Commit"
 msgstr "St=C3=A4ll rader i incheckningsk=C3=B6"
=20
-#: git-gui.sh:3400
+#: git-gui.sh:3494
 msgid "Stage Line For Commit"
 msgstr "St=C3=A4ll rad i incheckningsk=C3=B6"
=20
-#: git-gui.sh:3424
+#: git-gui.sh:3519
 msgid "Initializing..."
 msgstr "Initierar..."
=20
-#: git-gui.sh:3541
+#: git-gui.sh:3658
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -549,7 +549,7 @@ msgstr ""
 "av %s:\n"
 "\n"
=20
-#: git-gui.sh:3570
+#: git-gui.sh:3687
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -559,7 +559,7 @@ msgstr ""
 "Detta beror p=C3=A5 ett k=C3=A4nt problem med\n"
 "Tcl-bin=C3=A4ren som f=C3=B6ljer med Cygwin."
=20
-#: git-gui.sh:3575
+#: git-gui.sh:3692
 #, tcl-format
 msgid ""
 "\n"
@@ -613,132 +613,132 @@ msgstr "Klandra f=C3=B6r=C3=A4ldraincheckning"
 msgid "Reading %s..."
 msgstr "L=C3=A4ser %s..."
=20
-#: lib/blame.tcl:557
+#: lib/blame.tcl:581
 msgid "Loading copy/move tracking annotations..."
 msgstr "L=C3=A4ser annoteringar f=C3=B6r kopiering/flyttning..."
=20
-#: lib/blame.tcl:577
+#: lib/blame.tcl:601
 msgid "lines annotated"
 msgstr "rader annoterade"
=20
-#: lib/blame.tcl:769
+#: lib/blame.tcl:793
 msgid "Loading original location annotations..."
 msgstr "L=C3=A4ser in annotering av originalplacering..."
=20
-#: lib/blame.tcl:772
+#: lib/blame.tcl:796
 msgid "Annotation complete."
 msgstr "Annotering fullbordad."
=20
-#: lib/blame.tcl:802
+#: lib/blame.tcl:826
 msgid "Busy"
 msgstr "Upptagen"
=20
-#: lib/blame.tcl:803
+#: lib/blame.tcl:827
 msgid "Annotation process is already running."
 msgstr "Annoteringsprocess k=C3=B6rs redan."
=20
-#: lib/blame.tcl:842
+#: lib/blame.tcl:866
 msgid "Running thorough copy detection..."
 msgstr "K=C3=B6r grundlig kopieringsigenk=C3=A4nning..."
=20
-#: lib/blame.tcl:910
+#: lib/blame.tcl:934
 msgid "Loading annotation..."
 msgstr "L=C3=A4ser in annotering..."
=20
-#: lib/blame.tcl:963
+#: lib/blame.tcl:987
 msgid "Author:"
 msgstr "F=C3=B6rfattare:"
=20
-#: lib/blame.tcl:967
+#: lib/blame.tcl:991
 msgid "Committer:"
 msgstr "Incheckare:"
=20
-#: lib/blame.tcl:972
+#: lib/blame.tcl:996
 msgid "Original File:"
 msgstr "Ursprunglig fil:"
=20
-#: lib/blame.tcl:1020
+#: lib/blame.tcl:1044
 msgid "Cannot find HEAD commit:"
 msgstr "Hittar inte incheckning f=C3=B6r HEAD:"
=20
-#: lib/blame.tcl:1075
+#: lib/blame.tcl:1099
 msgid "Cannot find parent commit:"
 msgstr "Hittar inte f=C3=B6r=C3=A4ldraincheckning:"
=20
-#: lib/blame.tcl:1090
+#: lib/blame.tcl:1114
 msgid "Unable to display parent"
 msgstr "Kan inte visa f=C3=B6r=C3=A4lder"
=20
-#: lib/blame.tcl:1091 lib/diff.tcl:320
+#: lib/blame.tcl:1115 lib/diff.tcl:323
 msgid "Error loading diff:"
 msgstr "Fel vid inl=C3=A4sning av differens:"
=20
-#: lib/blame.tcl:1231
+#: lib/blame.tcl:1255
 msgid "Originally By:"
 msgstr "Ursprungligen av:"
=20
-#: lib/blame.tcl:1237
+#: lib/blame.tcl:1261
 msgid "In File:"
 msgstr "I filen:"
=20
-#: lib/blame.tcl:1242
+#: lib/blame.tcl:1266
 msgid "Copied Or Moved Here By:"
 msgstr "Kopierad eller flyttad hit av:"
=20
-#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+#: lib/branch_checkout.tcl:16 lib/branch_checkout.tcl:21
 msgid "Checkout Branch"
 msgstr "Checka ut gren"
=20
-#: lib/branch_checkout.tcl:23
+#: lib/branch_checkout.tcl:26
 msgid "Checkout"
 msgstr "Checka ut"
=20
-#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
-#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
-#: lib/checkout_op.tcl:579 lib/choose_font.tcl:43 lib/merge.tcl:172
-#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.t=
cl:42
-#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
-#: lib/transport.tcl:108
+#: lib/branch_checkout.tcl:30 lib/branch_create.tcl:37
+#: lib/branch_delete.tcl:34 lib/branch_rename.tcl:32 lib/browser.tcl:2=
86
+#: lib/checkout_op.tcl:579 lib/choose_font.tcl:45 lib/merge.tcl:172
+#: lib/option.tcl:127 lib/remote_add.tcl:34 lib/remote_branch_delete.t=
cl:43
+#: lib/tools_dlg.tcl:41 lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345
+#: lib/transport.tcl:111
 msgid "Cancel"
 msgstr "Avbryt"
=20
-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:32=
8
+#: lib/branch_checkout.tcl:35 lib/browser.tcl:291 lib/tools_dlg.tcl:32=
1
 msgid "Revision"
 msgstr "Revision"
=20
-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
280
+#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:69 lib/option.tcl:=
287
 msgid "Options"
 msgstr "Alternativ"
=20
-#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
+#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
 msgid "Fetch Tracking Branch"
 msgstr "H=C3=A4mta sp=C3=A5rande gren"
=20
-#: lib/branch_checkout.tcl:44
+#: lib/branch_checkout.tcl:47
 msgid "Detach From Local Branch"
 msgstr "Koppla bort fr=C3=A5n lokal gren"
=20
-#: lib/branch_create.tcl:22
+#: lib/branch_create.tcl:23
 msgid "Create Branch"
 msgstr "Skapa gren"
=20
-#: lib/branch_create.tcl:27
+#: lib/branch_create.tcl:28
 msgid "Create New Branch"
 msgstr "Skapa ny gren"
=20
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
+#: lib/branch_create.tcl:33 lib/choose_repository.tcl:389
 msgid "Create"
 msgstr "Skapa"
=20
-#: lib/branch_create.tcl:40
+#: lib/branch_create.tcl:42
 msgid "Branch Name"
 msgstr "Namn p=C3=A5 gren"
=20
-#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
+#: lib/branch_create.tcl:44 lib/remote_add.tcl:41 lib/tools_dlg.tcl:51
 msgid "Name:"
 msgstr "Namn:"
=20
-#: lib/branch_create.tcl:58
+#: lib/branch_create.tcl:57
 msgid "Match Tracking Branch Name"
 msgstr "Anv=C3=A4nd namn p=C3=A5 sp=C3=A5rad gren"
=20
@@ -766,41 +766,41 @@ msgstr "=C3=85terst=C3=A4ll"
 msgid "Checkout After Creation"
 msgstr "Checka ut n=C3=A4r skapad"
=20
-#: lib/branch_create.tcl:131
+#: lib/branch_create.tcl:132
 msgid "Please select a tracking branch."
 msgstr "V=C3=A4lj en gren att sp=C3=A5ra."
=20
-#: lib/branch_create.tcl:140
+#: lib/branch_create.tcl:141
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
 msgstr "Den sp=C3=A5rade grenen %s =C3=A4r inte en gren i fj=C3=A4rrar=
kivet."
=20
-#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
+#: lib/branch_create.tcl:154 lib/branch_rename.tcl:92
 msgid "Please supply a branch name."
 msgstr "Ange ett namn f=C3=B6r grenen."
=20
-#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#: lib/branch_create.tcl:165 lib/branch_rename.tcl:112
 #, tcl-format
 msgid "'%s' is not an acceptable branch name."
 msgstr "\"%s\" kan inte anv=C3=A4ndas som namn p=C3=A5 grenen."
=20
-#: lib/branch_delete.tcl:15
+#: lib/branch_delete.tcl:16
 msgid "Delete Branch"
 msgstr "Ta bort gren"
=20
-#: lib/branch_delete.tcl:20
+#: lib/branch_delete.tcl:21
 msgid "Delete Local Branch"
 msgstr "Ta bort lokal gren"
=20
-#: lib/branch_delete.tcl:37
+#: lib/branch_delete.tcl:39
 msgid "Local Branches"
 msgstr "Lokala grenar"
=20
-#: lib/branch_delete.tcl:52
+#: lib/branch_delete.tcl:51
 msgid "Delete Only If Merged Into"
 msgstr "Ta bara bort om sammanslagen med"
=20
-#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
+#: lib/branch_delete.tcl:53 lib/remote_branch_delete.tcl:120
 msgid "Always (Do not perform merge checks)"
 msgstr "Alltid (utf=C3=B6r inte sammanslagningstest)"
=20
@@ -809,7 +809,7 @@ msgstr "Alltid (utf=C3=B6r inte sammanslagningstest=
)"
 msgid "The following branches are not completely merged into %s:"
 msgstr "F=C3=B6ljande grenar =C3=A4r inte till fullo sammanslagna med =
%s:"
=20
-#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
+#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:218
 msgid ""
 "Recovering deleted branches is difficult.\n"
 "\n"
@@ -828,32 +828,32 @@ msgstr ""
 "Kunde inte ta bort grenar:\n"
 "%s"
=20
-#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
+#: lib/branch_rename.tcl:15 lib/branch_rename.tcl:23
 msgid "Rename Branch"
 msgstr "Byt namn p=C3=A5 gren"
=20
-#: lib/branch_rename.tcl:26
+#: lib/branch_rename.tcl:28
 msgid "Rename"
 msgstr "Byt namn"
=20
-#: lib/branch_rename.tcl:36
+#: lib/branch_rename.tcl:38
 msgid "Branch:"
 msgstr "Gren:"
=20
-#: lib/branch_rename.tcl:39
+#: lib/branch_rename.tcl:46
 msgid "New Name:"
 msgstr "Nytt namn:"
=20
-#: lib/branch_rename.tcl:75
+#: lib/branch_rename.tcl:81
 msgid "Please select a branch to rename."
 msgstr "V=C3=A4lj en gren att byta namn p=C3=A5."
=20
-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
+#: lib/branch_rename.tcl:102 lib/checkout_op.tcl:202
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr "Grenen \"%s\" finns redan."
=20
-#: lib/branch_rename.tcl:117
+#: lib/branch_rename.tcl:123
 #, tcl-format
 msgid "Failed to rename '%s'."
 msgstr "Kunde inte byta namn p=C3=A5 \"%s\"."
@@ -862,7 +862,7 @@ msgstr "Kunde inte byta namn p=C3=A5 \"%s\"."
 msgid "Starting..."
 msgstr "Startar..."
=20
-#: lib/browser.tcl:26
+#: lib/browser.tcl:27
 msgid "File Browser"
 msgstr "Filbl=C3=A4ddrare"
=20
@@ -875,13 +875,13 @@ msgstr "L=C3=A4ser %s..."
 msgid "[Up To Parent]"
 msgstr "[Upp till f=C3=B6r=C3=A4lder]"
=20
-#: lib/browser.tcl:267 lib/browser.tcl:273
+#: lib/browser.tcl:269 lib/browser.tcl:276
 msgid "Browse Branch Files"
 msgstr "Bl=C3=A4ddra filer p=C3=A5 grenen"
=20
-#: lib/browser.tcl:278 lib/choose_repository.tcl:398
-#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
-#: lib/choose_repository.tcl:1028
+#: lib/browser.tcl:282 lib/choose_repository.tcl:404
+#: lib/choose_repository.tcl:491 lib/choose_repository.tcl:500
+#: lib/choose_repository.tcl:1027
 msgid "Browse"
 msgstr "Bl=C3=A4ddra"
=20
@@ -895,8 +895,8 @@ msgstr "H=C3=A4mtar %s fr=C3=A5n %s"
 msgid "fatal: Cannot resolve %s"
 msgstr "=C3=B6desdigert: Kunde inte sl=C3=A5 upp %s"
=20
-#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
-#: lib/sshkey.tcl:53
+#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:30
+#: lib/sshkey.tcl:55
 msgid "Close"
 msgstr "St=C3=A4ng"
=20
@@ -1008,7 +1008,7 @@ msgstr "Det kanske inte =C3=A4r s=C3=A5 enkelt at=
t =C3=A5terskapa f=C3=B6rlorade incheckningar."
 msgid "Reset '%s'?"
 msgstr "=C3=85terst=C3=A4lla \"%s\"?"
=20
-#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
+#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:336
 msgid "Visualize"
 msgstr "Visualisera"
=20
@@ -1029,23 +1029,23 @@ msgstr ""
 "\n"
 "Detta skulle inte ha h=C3=A4nt. %s kommer nu st=C3=A4ngas och ge upp.=
"
=20
-#: lib/choose_font.tcl:39
+#: lib/choose_font.tcl:41
 msgid "Select"
 msgstr "V=C3=A4lj"
=20
-#: lib/choose_font.tcl:53
+#: lib/choose_font.tcl:55
 msgid "Font Family"
 msgstr "Teckensnittsfamilj"
=20
-#: lib/choose_font.tcl:74
+#: lib/choose_font.tcl:76
 msgid "Font Size"
 msgstr "Storlek"
=20
-#: lib/choose_font.tcl:91
+#: lib/choose_font.tcl:93
 msgid "Font Example"
 msgstr "Exempel"
=20
-#: lib/choose_font.tcl:103
+#: lib/choose_font.tcl:105
 msgid ""
 "This is example text.\n"
 "If you like this text, it can be your font."
@@ -1057,7 +1057,7 @@ msgstr ""
 msgid "Git Gui"
 msgstr "Git Gui"
=20
-#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:394
 msgid "Create New Repository"
 msgstr "Skapa nytt arkiv"
=20
@@ -1065,76 +1065,76 @@ msgstr "Skapa nytt arkiv"
 msgid "New..."
 msgstr "Nytt..."
=20
-#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:478
 msgid "Clone Existing Repository"
 msgstr "Klona befintligt arkiv"
=20
-#: lib/choose_repository.tcl:106
+#: lib/choose_repository.tcl:111
 msgid "Clone..."
 msgstr "Klona..."
=20
-#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
+#: lib/choose_repository.tcl:118 lib/choose_repository.tcl:1017
 msgid "Open Existing Repository"
 msgstr "=C3=96ppna befintligt arkiv"
=20
-#: lib/choose_repository.tcl:119
+#: lib/choose_repository.tcl:124
 msgid "Open..."
 msgstr "=C3=96ppna..."
=20
-#: lib/choose_repository.tcl:132
+#: lib/choose_repository.tcl:137
 msgid "Recent Repositories"
 msgstr "Senaste arkiven"
=20
-#: lib/choose_repository.tcl:138
+#: lib/choose_repository.tcl:143
 msgid "Open Recent Repository:"
 msgstr "=C3=96ppna tidigare arkiv:"
=20
-#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
-#: lib/choose_repository.tcl:320
+#: lib/choose_repository.tcl:313 lib/choose_repository.tcl:320
+#: lib/choose_repository.tcl:327
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "Kunde inte skapa arkivet %s:"
=20
-#: lib/choose_repository.tcl:391
+#: lib/choose_repository.tcl:399
 msgid "Directory:"
 msgstr "Katalog:"
=20
-#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
-#: lib/choose_repository.tcl:1052
+#: lib/choose_repository.tcl:429 lib/choose_repository.tcl:550
+#: lib/choose_repository.tcl:1051
 msgid "Git Repository"
 msgstr "Gitarkiv"
=20
-#: lib/choose_repository.tcl:448
+#: lib/choose_repository.tcl:454
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "Katalogen %s finns redan."
=20
-#: lib/choose_repository.tcl:452
+#: lib/choose_repository.tcl:458
 #, tcl-format
 msgid "File %s already exists."
 msgstr "Filen %s finns redan."
=20
-#: lib/choose_repository.tcl:466
+#: lib/choose_repository.tcl:473
 msgid "Clone"
 msgstr "Klona"
=20
-#: lib/choose_repository.tcl:479
+#: lib/choose_repository.tcl:486
 msgid "Source Location:"
 msgstr "Plats f=C3=B6r k=C3=A4llkod:"
=20
-#: lib/choose_repository.tcl:490
+#: lib/choose_repository.tcl:495
 msgid "Target Directory:"
 msgstr "M=C3=A5lkatalog:"
=20
-#: lib/choose_repository.tcl:502
+#: lib/choose_repository.tcl:505
 msgid "Clone Type:"
 msgstr "Typ av klon:"
=20
-#: lib/choose_repository.tcl:508
+#: lib/choose_repository.tcl:510
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "Standard (snabb, semiredundant, h=C3=A5rda l=C3=A4nkar)"
=20
-#: lib/choose_repository.tcl:514
+#: lib/choose_repository.tcl:515
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "Full kopia (l=C3=A5ngsammare, redundant s=C3=A4kerhetskopia)"
=20
@@ -1144,7 +1144,7 @@ msgstr "Delad (snabbast, rekommenderas ej, ingen =
s=C3=A4kerhetskopia)"
=20
 #: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
 #: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
-#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
+#: lib/choose_repository.tcl:1057 lib/choose_repository.tcl:1065
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "Inte ett Gitarkiv: %s"
@@ -1258,8 +1258,8 @@ msgstr "Kunde inte sl=C3=A5 upp %s till n=C3=A5go=
n incheckning."
 msgid "Creating working directory"
 msgstr "Skapar arbetskatalog"
=20
-#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
-#: lib/index.tcl:198
+#: lib/choose_repository.tcl:939 lib/index.tcl:70 lib/index.tcl:133
+#: lib/index.tcl:201
 msgid "files"
 msgstr "filer"
=20
@@ -1267,20 +1267,20 @@ msgstr "filer"
 msgid "Initial file checkout failed."
 msgstr "Inledande filutcheckning misslyckades."
=20
-#: lib/choose_repository.tcl:1011
+#: lib/choose_repository.tcl:1012
 msgid "Open"
 msgstr "=C3=96ppna"
=20
-#: lib/choose_repository.tcl:1021
+#: lib/choose_repository.tcl:1022
 msgid "Repository:"
 msgstr "Arkiv:"
=20
-#: lib/choose_repository.tcl:1072
+#: lib/choose_repository.tcl:1071
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "Kunde inte =C3=B6ppna arkivet %s:"
=20
-#: lib/choose_rev.tcl:53
+#: lib/choose_rev.tcl:52
 msgid "This Detached Checkout"
 msgstr "Denna fr=C3=A5nkopplade utcheckning"
=20
@@ -1288,36 +1288,36 @@ msgstr "Denna fr=C3=A5nkopplade utcheckning"
 msgid "Revision Expression:"
 msgstr "Revisionsuttryck:"
=20
-#: lib/choose_rev.tcl:74
+#: lib/choose_rev.tcl:72
 msgid "Local Branch"
 msgstr "Lokal gren"
=20
-#: lib/choose_rev.tcl:79
+#: lib/choose_rev.tcl:77
 msgid "Tracking Branch"
 msgstr "Sp=C3=A5rande gren"
=20
-#: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
+#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:543
 msgid "Tag"
 msgstr "Tagg"
=20
-#: lib/choose_rev.tcl:317
+#: lib/choose_rev.tcl:321
 #, tcl-format
 msgid "Invalid revision: %s"
 msgstr "Ogiltig revision: %s"
=20
-#: lib/choose_rev.tcl:338
+#: lib/choose_rev.tcl:342
 msgid "No revision selected."
 msgstr "Ingen revision vald."
=20
-#: lib/choose_rev.tcl:346
+#: lib/choose_rev.tcl:350
 msgid "Revision expression is empty."
 msgstr "Revisionsuttrycket =C3=A4r tomt."
=20
-#: lib/choose_rev.tcl:531
+#: lib/choose_rev.tcl:536
 msgid "Updated"
 msgstr "Uppdaterad"
=20
-#: lib/choose_rev.tcl:559
+#: lib/choose_rev.tcl:564
 msgid "URL"
 msgstr "Webbadress"
=20
@@ -1508,31 +1508,31 @@ msgstr "Lyckades"
 msgid "Error: Command Failed"
 msgstr "Fel: Kommando misslyckades"
=20
-#: lib/database.tcl:43
+#: lib/database.tcl:42
 msgid "Number of loose objects"
 msgstr "Antal l=C3=B6sa objekt"
=20
-#: lib/database.tcl:44
+#: lib/database.tcl:43
 msgid "Disk space used by loose objects"
 msgstr "Diskutrymme anv=C3=A4nt av l=C3=B6sa objekt"
=20
-#: lib/database.tcl:45
+#: lib/database.tcl:44
 msgid "Number of packed objects"
 msgstr "Antal packade objekt"
=20
-#: lib/database.tcl:46
+#: lib/database.tcl:45
 msgid "Number of packs"
 msgstr "Antal paket"
=20
-#: lib/database.tcl:47
+#: lib/database.tcl:46
 msgid "Disk space used by packed objects"
 msgstr "Diskutrymme anv=C3=A4nt av packade objekt"
=20
-#: lib/database.tcl:48
+#: lib/database.tcl:47
 msgid "Packed objects waiting for pruning"
 msgstr "Packade objekt som v=C3=A4ntar p=C3=A5 st=C3=A4dning"
=20
-#: lib/database.tcl:49
+#: lib/database.tcl:48
 msgid "Garbage files"
 msgstr "Skr=C3=A4pfiler"
=20
@@ -1618,7 +1618,7 @@ msgstr "LOKAL:\n"
 msgid "REMOTE:\n"
 msgstr "FJ=C3=84RR:\n"
=20
-#: lib/diff.tcl:202 lib/diff.tcl:319
+#: lib/diff.tcl:202 lib/diff.tcl:322
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "Kan inte visa %s"
@@ -1655,19 +1655,19 @@ msgstr ""
 "* Den osp=C3=A5rade filen klipptes h=C3=A4r av %s.\n"
 "* F=C3=B6r att se hela filen, anv=C3=A4nd ett externt redigeringsprog=
ram.\n"
=20
-#: lib/diff.tcl:482
+#: lib/diff.tcl:485
 msgid "Failed to unstage selected hunk."
 msgstr "Kunde inte ta bort den valda delen fr=C3=A5n k=C3=B6n."
=20
-#: lib/diff.tcl:489
+#: lib/diff.tcl:492
 msgid "Failed to stage selected hunk."
 msgstr "Kunde inte l=C3=A4gga till den valda delen till k=C3=B6n."
=20
-#: lib/diff.tcl:568
+#: lib/diff.tcl:571
 msgid "Failed to unstage selected line."
 msgstr "Kunde inte ta bort den valda raden fr=C3=A5n k=C3=B6n."
=20
-#: lib/diff.tcl:576
+#: lib/diff.tcl:579
 msgid "Failed to stage selected line."
 msgstr "Kunde inte l=C3=A4gga till den valda raden till k=C3=B6n."
=20
@@ -1684,7 +1684,7 @@ msgstr "Systemets (%s)"
 msgid "Other"
 msgstr "Annan"
=20
-#: lib/error.tcl:20 lib/error.tcl:114
+#: lib/error.tcl:20 lib/error.tcl:116
 msgid "error"
 msgstr "fel"
=20
@@ -1692,7 +1692,7 @@ msgstr "fel"
 msgid "warning"
 msgstr "varning"
=20
-#: lib/error.tcl:94
+#: lib/error.tcl:96
 msgid "You must correct the above errors before committing."
 msgstr "Du m=C3=A5ste r=C3=A4tta till felen ovan innan du checkar in."
=20
@@ -1700,11 +1700,11 @@ msgstr "Du m=C3=A5ste r=C3=A4tta till felen ova=
n innan du checkar in."
 msgid "Unable to unlock the index."
 msgstr "Kunde inte l=C3=A5sa upp indexet."
=20
-#: lib/index.tcl:15
+#: lib/index.tcl:17
 msgid "Index Error"
 msgstr "Indexfel"
=20
-#: lib/index.tcl:17
+#: lib/index.tcl:19
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically starte=
d to "
 "resynchronize git-gui."
@@ -1712,52 +1712,52 @@ msgstr ""
 "Misslyckades med att uppdatera Gitindexet. En oms=C3=B6kning kommer a=
tt startas "
 "automatiskt f=C3=B6r att synkronisera om git-gui."
=20
-#: lib/index.tcl:28
+#: lib/index.tcl:30
 msgid "Continue"
 msgstr "Forst=C3=A4tt"
=20
-#: lib/index.tcl:31
+#: lib/index.tcl:33
 msgid "Unlock Index"
 msgstr "L=C3=A5s upp index"
=20
-#: lib/index.tcl:289
+#: lib/index.tcl:292
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "Tar bort %s f=C3=B6r incheckningsk=C3=B6n"
=20
-#: lib/index.tcl:328
+#: lib/index.tcl:331
 msgid "Ready to commit."
 msgstr "Redo att checka in."
=20
-#: lib/index.tcl:341
+#: lib/index.tcl:344
 #, tcl-format
 msgid "Adding %s"
 msgstr "L=C3=A4gger till %s"
=20
-#: lib/index.tcl:398
+#: lib/index.tcl:401
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "=C3=85terst=C3=A4ll =C3=A4ndringarna i filen %s?"
=20
-#: lib/index.tcl:400
+#: lib/index.tcl:403
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "=C3=85terst=C3=A4ll =C3=A4ndringarna i dessa %i filer?"
=20
-#: lib/index.tcl:408
+#: lib/index.tcl:411
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 "Alla ok=C3=B6ade =C3=A4ndringar kommer permanent g=C3=A5 f=C3=B6rlora=
de vid =C3=A5terst=C3=A4llningen."
=20
-#: lib/index.tcl:411
+#: lib/index.tcl:414
 msgid "Do Nothing"
 msgstr "G=C3=B6r ingenting"
=20
-#: lib/index.tcl:429
+#: lib/index.tcl:432
 msgid "Reverting selected files"
 msgstr "=C3=85terst=C3=A4ller valda filer"
=20
-#: lib/index.tcl:433
+#: lib/index.tcl:436
 #, tcl-format
 msgid "Reverting %s"
 msgstr "=C3=85terst=C3=A4ller %s"
@@ -2004,145 +2004,133 @@ msgstr "Den globala teckenkodningen \"%s\" =C3=
=A4r ogiltig"
 msgid "Invalid repo encoding '%s'"
 msgstr "Arkivets teckenkodning \"%s\" =C3=A4r ogiltig"
=20
-#: lib/option.tcl:117
+#: lib/option.tcl:119
 msgid "Restore Defaults"
 msgstr "=C3=85terst=C3=A4ll standardv=C3=A4rden"
=20
-#: lib/option.tcl:121
+#: lib/option.tcl:123
 msgid "Save"
 msgstr "Spara"
=20
-#: lib/option.tcl:131
+#: lib/option.tcl:133
 #, tcl-format
 msgid "%s Repository"
 msgstr "Arkivet %s"
=20
-#: lib/option.tcl:132
+#: lib/option.tcl:134
 msgid "Global (All Repositories)"
 msgstr "Globalt (alla arkiv)"
=20
-#: lib/option.tcl:138
+#: lib/option.tcl:140
 msgid "User Name"
 msgstr "Anv=C3=A4ndarnamn"
=20
-#: lib/option.tcl:139
+#: lib/option.tcl:141
 msgid "Email Address"
 msgstr "E-postadress"
=20
-#: lib/option.tcl:141
+#: lib/option.tcl:143
 msgid "Summarize Merge Commits"
 msgstr "Summera sammanslagningsincheckningar"
=20
-#: lib/option.tcl:142
+#: lib/option.tcl:144
 msgid "Merge Verbosity"
 msgstr "Pratsamhet f=C3=B6r sammanslagningar"
=20
-#: lib/option.tcl:143
+#: lib/option.tcl:145
 msgid "Show Diffstat After Merge"
 msgstr "Visa diffstatistik efter sammanslagning"
=20
-#: lib/option.tcl:144
+#: lib/option.tcl:146
 msgid "Use Merge Tool"
 msgstr "Anv=C3=A4nd verktyg f=C3=B6r sammanslagning"
=20
-#: lib/option.tcl:146
+#: lib/option.tcl:148
 msgid "Trust File Modification Timestamps"
 msgstr "Lita p=C3=A5 fil=C3=A4ndringstidsst=C3=A4mplar"
=20
-#: lib/option.tcl:147
+#: lib/option.tcl:149
 msgid "Prune Tracking Branches During Fetch"
 msgstr "St=C3=A4da sp=C3=A5rade grenar vid h=C3=A4mtning"
=20
-#: lib/option.tcl:148
+#: lib/option.tcl:150
 msgid "Match Tracking Branches"
 msgstr "Matcha sp=C3=A5rade grenar"
=20
-#: lib/option.tcl:149
+#: lib/option.tcl:151
+msgid "Use Textconv For Diffs and Blames"
+msgstr "Anv=C3=A4nd Textconv f=C3=B6r diff och klandring"
+
+#: lib/option.tcl:152
 msgid "Blame Copy Only On Changed Files"
 msgstr "Klandra kopiering bara i =C3=A4ndrade filer"
=20
-#: lib/option.tcl:150
+#: lib/option.tcl:153
 msgid "Minimum Letters To Blame Copy On"
 msgstr "Minsta antal tecken att klandra kopiering f=C3=B6r"
=20
-#: lib/option.tcl:151
+#: lib/option.tcl:154
 msgid "Blame History Context Radius (days)"
 msgstr "Historikradie f=C3=B6r klandring (dagar)"
=20
-#: lib/option.tcl:152
+#: lib/option.tcl:155
 msgid "Number of Diff Context Lines"
 msgstr "Antal rader sammanhang i differenser"
=20
-#: lib/option.tcl:153
+#: lib/option.tcl:156
 msgid "Commit Message Text Width"
 msgstr "Textbredd f=C3=B6r incheckningsmeddelande"
=20
-#: lib/option.tcl:154
+#: lib/option.tcl:157
 msgid "New Branch Name Template"
 msgstr "Mall f=C3=B6r namn p=C3=A5 nya grenar"
=20
-#: lib/option.tcl:155
+#: lib/option.tcl:158
 msgid "Default File Contents Encoding"
 msgstr "Standardteckenkodning f=C3=B6r filinneh=C3=A5ll"
=20
-#: lib/option.tcl:203
+#: lib/option.tcl:204
 msgid "Change"
 msgstr "=C3=84ndra"
=20
-#: lib/option.tcl:230
+#: lib/option.tcl:231
 msgid "Spelling Dictionary:"
 msgstr "Stavningsordlista:"
=20
-#: lib/option.tcl:254
+#: lib/option.tcl:261
 msgid "Change Font"
 msgstr "Byt teckensnitt"
=20
-#: lib/option.tcl:258
+#: lib/option.tcl:265
 #, tcl-format
 msgid "Choose %s"
 msgstr "V=C3=A4lj %s"
=20
-#: lib/option.tcl:264
+#: lib/option.tcl:271
 msgid "pt."
 msgstr "p."
=20
-#: lib/option.tcl:278
+#: lib/option.tcl:285
 msgid "Preferences"
 msgstr "Inst=C3=A4llningar"
=20
-#: lib/option.tcl:314
+#: lib/option.tcl:322
 msgid "Failed to completely save options:"
 msgstr "Misslyckades med att helt spara alternativ:"
=20
-#: lib/remote.tcl:163
-msgid "Remove Remote"
-msgstr "Ta bort fj=C3=A4rrarkiv"
-
-#: lib/remote.tcl:168
-msgid "Prune from"
-msgstr "Ta bort fr=C3=A5n"
-
-#: lib/remote.tcl:173
-msgid "Fetch from"
-msgstr "H=C3=A4mta fr=C3=A5n"
-
-#: lib/remote.tcl:215
-msgid "Push to"
-msgstr "S=C3=A4nd till"
-
-#: lib/remote_add.tcl:19
+#: lib/remote_add.tcl:20
 msgid "Add Remote"
 msgstr "L=C3=A4gg till fj=C3=A4rrarkiv"
=20
-#: lib/remote_add.tcl:24
+#: lib/remote_add.tcl:25
 msgid "Add New Remote"
 msgstr "L=C3=A4gg till nytt fj=C3=A4rrarkiv"
=20
-#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
+#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
 msgid "Add"
 msgstr "L=C3=A4gg till"
=20
-#: lib/remote_add.tcl:37
+#: lib/remote_add.tcl:39
 msgid "Remote Details"
 msgstr "Detaljer f=C3=B6r fj=C3=A4rrarkiv"
=20
@@ -2150,58 +2138,58 @@ msgstr "Detaljer f=C3=B6r fj=C3=A4rrarkiv"
 msgid "Location:"
 msgstr "Plats:"
=20
-#: lib/remote_add.tcl:62
+#: lib/remote_add.tcl:60
 msgid "Further Action"
 msgstr "Ytterligare =C3=A5tg=C3=A4rd"
=20
-#: lib/remote_add.tcl:65
+#: lib/remote_add.tcl:63
 msgid "Fetch Immediately"
 msgstr "H=C3=A4mta omedelbart"
=20
-#: lib/remote_add.tcl:71
+#: lib/remote_add.tcl:69
 msgid "Initialize Remote Repository and Push"
 msgstr "Initiera fj=C3=A4rrarkiv och s=C3=A4nd till"
=20
-#: lib/remote_add.tcl:77
+#: lib/remote_add.tcl:75
 msgid "Do Nothing Else Now"
 msgstr "G=C3=B6r ingent mer nu"
=20
-#: lib/remote_add.tcl:101
+#: lib/remote_add.tcl:100
 msgid "Please supply a remote name."
 msgstr "Ange ett namn f=C3=B6r fj=C3=A4rrarkivet."
=20
-#: lib/remote_add.tcl:114
+#: lib/remote_add.tcl:113
 #, tcl-format
 msgid "'%s' is not an acceptable remote name."
 msgstr "\"%s\" kan inte anv=C3=A4ndas som namn p=C3=A5 fj=C3=A4rrarkiv=
et."
=20
-#: lib/remote_add.tcl:125
+#: lib/remote_add.tcl:124
 #, tcl-format
 msgid "Failed to add remote '%s' of location '%s'."
 msgstr "Kunde inte l=C3=A4gga till fj=C3=A4rrarkivet \"%s\" p=C3=A5 pl=
atsen \"%s\"."
=20
-#: lib/remote_add.tcl:133 lib/transport.tcl:6
+#: lib/remote_add.tcl:132 lib/transport.tcl:6
 #, tcl-format
 msgid "fetch %s"
 msgstr "h=C3=A4mta %s"
=20
-#: lib/remote_add.tcl:134
+#: lib/remote_add.tcl:133
 #, tcl-format
 msgid "Fetching the %s"
 msgstr "H=C3=A4mtar %s"
=20
-#: lib/remote_add.tcl:157
+#: lib/remote_add.tcl:156
 #, tcl-format
 msgid "Do not know how to initialize repository at location '%s'."
 msgstr "Vet inte hur arkivet p=C3=A5 platsen \"%s\" skall initieras."
=20
-#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
+#: lib/remote_add.tcl:162 lib/transport.tcl:25 lib/transport.tcl:63
 #: lib/transport.tcl:81
 #, tcl-format
 msgid "push %s"
 msgstr "s=C3=A4nd %s"
=20
-#: lib/remote_add.tcl:164
+#: lib/remote_add.tcl:163
 #, tcl-format
 msgid "Setting up the %s (at %s)"
 msgstr "Konfigurerar %s (p=C3=A5 %s)"
@@ -2210,35 +2198,35 @@ msgstr "Konfigurerar %s (p=C3=A5 %s)"
 msgid "Delete Branch Remotely"
 msgstr "Ta bort gren fr=C3=A5n fj=C3=A4rrarkiv"
=20
-#: lib/remote_branch_delete.tcl:47
+#: lib/remote_branch_delete.tcl:48
 msgid "From Repository"
 msgstr "Fr=C3=A5n arkiv"
=20
-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
+#: lib/remote_branch_delete.tcl:51 lib/transport.tcl:134
 msgid "Remote:"
 msgstr "Fj=C3=A4rrarkiv:"
=20
-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
+#: lib/remote_branch_delete.tcl:72 lib/transport.tcl:154
 msgid "Arbitrary Location:"
 msgstr "Godtycklig plats:"
=20
-#: lib/remote_branch_delete.tcl:84
+#: lib/remote_branch_delete.tcl:88
 msgid "Branches"
 msgstr "Grenar"
=20
-#: lib/remote_branch_delete.tcl:109
+#: lib/remote_branch_delete.tcl:110
 msgid "Delete Only If"
 msgstr "Ta endast bort om"
=20
-#: lib/remote_branch_delete.tcl:111
+#: lib/remote_branch_delete.tcl:112
 msgid "Merged Into:"
 msgstr "Sammanslagen i:"
=20
-#: lib/remote_branch_delete.tcl:152
+#: lib/remote_branch_delete.tcl:153
 msgid "A branch is required for 'Merged Into'."
 msgstr "En gren kr=C3=A4vs f=C3=B6r \"Sammanslagen i\"."
=20
-#: lib/remote_branch_delete.tcl:184
+#: lib/remote_branch_delete.tcl:185
 #, tcl-format
 msgid ""
 "The following branches are not completely merged into %s:\n"
@@ -2249,7 +2237,7 @@ msgstr ""
 "\n"
 " - %s"
=20
-#: lib/remote_branch_delete.tcl:189
+#: lib/remote_branch_delete.tcl:190
 #, tcl-format
 msgid ""
 "One or more of the merge tests failed because you have not fetched th=
e "
@@ -2258,37 +2246,53 @@ msgstr ""
 "En eller flera av sammanslagningstesterna misslyckades eftersom du in=
te har "
 "h=C3=A4mtat de n=C3=B6dv=C3=A4ndiga incheckningarna. F=C3=B6rs=C3=B6k=
 h=C3=A4mta fr=C3=A5n %s f=C3=B6rst."
=20
-#: lib/remote_branch_delete.tcl:207
+#: lib/remote_branch_delete.tcl:208
 msgid "Please select one or more branches to delete."
 msgstr "V=C3=A4lj en eller flera grenar att ta bort."
=20
-#: lib/remote_branch_delete.tcl:226
+#: lib/remote_branch_delete.tcl:227
 #, tcl-format
 msgid "Deleting branches from %s"
 msgstr "Tar bort grenar fr=C3=A5n %s"
=20
-#: lib/remote_branch_delete.tcl:292
+#: lib/remote_branch_delete.tcl:293
 msgid "No repository selected."
 msgstr "Inget arkiv markerat."
=20
-#: lib/remote_branch_delete.tcl:297
+#: lib/remote_branch_delete.tcl:298
 #, tcl-format
 msgid "Scanning %s..."
 msgstr "S=C3=B6ker %s..."
=20
-#: lib/search.tcl:21
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
+#: lib/search.tcl:22
 msgid "Find:"
 msgstr "S=C3=B6k:"
=20
-#: lib/search.tcl:23
+#: lib/search.tcl:24
 msgid "Next"
 msgstr "N=C3=A4sta"
=20
-#: lib/search.tcl:24
+#: lib/search.tcl:25
 msgid "Prev"
 msgstr "F=C3=B6reg"
=20
-#: lib/search.tcl:25
+#: lib/search.tcl:26
 msgid "Case-Sensitive"
 msgstr "Skilj p=C3=A5 VERSALER/gemener"
=20
@@ -2350,19 +2354,19 @@ msgstr "Hittade =C3=B6ppen nyckel i: %s"
 msgid "Generate Key"
 msgstr "Skapa nyckel"
=20
-#: lib/sshkey.tcl:56
+#: lib/sshkey.tcl:58
 msgid "Copy To Clipboard"
 msgstr "Kopiera till Urklipp"
=20
-#: lib/sshkey.tcl:70
+#: lib/sshkey.tcl:72
 msgid "Your OpenSSH Public Key"
 msgstr "Din =C3=B6ppna OpenSSH-nyckel"
=20
-#: lib/sshkey.tcl:78
+#: lib/sshkey.tcl:80
 msgid "Generating..."
 msgstr "Skapar..."
=20
-#: lib/sshkey.tcl:84
+#: lib/sshkey.tcl:86
 #, tcl-format
 msgid ""
 "Could not start ssh-keygen:\n"
@@ -2373,54 +2377,24 @@ msgstr ""
 "\n"
 "%s"
=20
-#: lib/sshkey.tcl:111
+#: lib/sshkey.tcl:113
 msgid "Generation failed."
 msgstr "Misslyckades med att skapa."
=20
-#: lib/sshkey.tcl:118
+#: lib/sshkey.tcl:120
 msgid "Generation succeded, but no keys found."
 msgstr "Lyckades skapa nyckeln, men hittar inte n=C3=A5gon nyckel."
=20
-#: lib/sshkey.tcl:121
+#: lib/sshkey.tcl:123
 #, tcl-format
 msgid "Your key is in: %s"
 msgstr "Din nyckel finns i: %s"
=20
-#: lib/status_bar.tcl:83
+#: lib/status_bar.tcl:86
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%s... %*i av %*i %s (%3i%%)"
=20
-#: lib/tools.tcl:75
-#, tcl-format
-msgid "Running %s requires a selected file."
-msgstr "F=C3=B6r att starta %s m=C3=A5ste du v=C3=A4lja en fil."
-
-#: lib/tools.tcl:90
-#, tcl-format
-msgid "Are you sure you want to run %s?"
-msgstr "=C3=84r du s=C3=A4ker p=C3=A5 att du vill starta %s?"
-
-#: lib/tools.tcl:110
-#, tcl-format
-msgid "Tool: %s"
-msgstr "Verktyg: %s"
-
-#: lib/tools.tcl:111
-#, tcl-format
-msgid "Running: %s"
-msgstr "Exekverar: %s"
-
-#: lib/tools.tcl:149
-#, tcl-format
-msgid "Tool completed successfully: %s"
-msgstr "Verktyget avslutades framg=C3=A5ngsrikt: %s"
-
-#: lib/tools.tcl:151
-#, tcl-format
-msgid "Tool failed: %s"
-msgstr "Verktyget misslyckades: %s"
-
 #: lib/tools_dlg.tcl:22
 msgid "Add Tool"
 msgstr "L=C3=A4gg till verktyg"
@@ -2429,52 +2403,52 @@ msgstr "L=C3=A4gg till verktyg"
 msgid "Add New Tool Command"
 msgstr "L=C3=A4gg till nytt verktygskommando"
=20
-#: lib/tools_dlg.tcl:33
+#: lib/tools_dlg.tcl:34
 msgid "Add globally"
 msgstr "L=C3=A4gg till globalt"
=20
-#: lib/tools_dlg.tcl:45
+#: lib/tools_dlg.tcl:46
 msgid "Tool Details"
 msgstr "Detaljer f=C3=B6r verktyg"
=20
-#: lib/tools_dlg.tcl:48
+#: lib/tools_dlg.tcl:49
 msgid "Use '/' separators to create a submenu tree:"
 msgstr "Anv=C3=A4nd \"/\"-avdelare f=C3=B6r att skapa ett undermenytr=C3=
=A4d:"
=20
-#: lib/tools_dlg.tcl:61
+#: lib/tools_dlg.tcl:60
 msgid "Command:"
 msgstr "Kommando:"
=20
-#: lib/tools_dlg.tcl:74
+#: lib/tools_dlg.tcl:71
 msgid "Show a dialog before running"
 msgstr "Visa dialog innan programmet startas"
=20
-#: lib/tools_dlg.tcl:80
+#: lib/tools_dlg.tcl:77
 msgid "Ask the user to select a revision (sets $REVISION)"
 msgstr "Be anv=C3=A4ndaren v=C3=A4lja en version (s=C3=A4tter $REVISIO=
N)"
=20
-#: lib/tools_dlg.tcl:85
+#: lib/tools_dlg.tcl:82
 msgid "Ask the user for additional arguments (sets $ARGS)"
 msgstr "Be anv=C3=A4ndaren om ytterligare parametrar (s=C3=A4tter $ARG=
S)"
=20
-#: lib/tools_dlg.tcl:92
+#: lib/tools_dlg.tcl:89
 msgid "Don't show the command output window"
 msgstr "Visa inte kommandots utdataf=C3=B6nster"
=20
-#: lib/tools_dlg.tcl:97
+#: lib/tools_dlg.tcl:94
 msgid "Run only if a diff is selected ($FILENAME not empty)"
 msgstr "K=C3=B6r endast om en diff har markerats ($FILENAME =C3=A4r in=
te tomt)"
=20
-#: lib/tools_dlg.tcl:121
+#: lib/tools_dlg.tcl:118
 msgid "Please supply a name for the tool."
 msgstr "Ange ett namn f=C3=B6r verktyget."
=20
-#: lib/tools_dlg.tcl:129
+#: lib/tools_dlg.tcl:126
 #, tcl-format
 msgid "Tool '%s' already exists."
 msgstr "Verktyget \"%s\" finns redan."
=20
-#: lib/tools_dlg.tcl:151
+#: lib/tools_dlg.tcl:148
 #, tcl-format
 msgid ""
 "Could not add tool:\n"
@@ -2483,35 +2457,65 @@ msgstr ""
 "Kunde inte l=C3=A4gga till verktyget:\n"
 "%s"
=20
-#: lib/tools_dlg.tcl:190
+#: lib/tools_dlg.tcl:187
 msgid "Remove Tool"
 msgstr "Ta bort verktyg"
=20
-#: lib/tools_dlg.tcl:196
+#: lib/tools_dlg.tcl:193
 msgid "Remove Tool Commands"
 msgstr "Ta bort verktygskommandon"
=20
-#: lib/tools_dlg.tcl:200
+#: lib/tools_dlg.tcl:198
 msgid "Remove"
 msgstr "Ta bort"
=20
-#: lib/tools_dlg.tcl:236
+#: lib/tools_dlg.tcl:231
 msgid "(Blue denotes repository-local tools)"
 msgstr "(Bl=C3=A5tt anger verktyg lokala f=C3=B6r arkivet)"
=20
-#: lib/tools_dlg.tcl:297
+#: lib/tools_dlg.tcl:292
 #, tcl-format
 msgid "Run Command: %s"
 msgstr "K=C3=B6r kommandot: %s"
=20
-#: lib/tools_dlg.tcl:311
+#: lib/tools_dlg.tcl:306
 msgid "Arguments"
 msgstr "Argument"
=20
-#: lib/tools_dlg.tcl:348
+#: lib/tools_dlg.tcl:341
 msgid "OK"
 msgstr "OK"
=20
+#: lib/tools.tcl:75
+#, tcl-format
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
+msgid "Tool completed successfully: %s"
+msgstr "Verktyget avslutades framg=C3=A5ngsrikt: %s"
+
+#: lib/tools.tcl:151
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "Verktyget misslyckades: %s"
+
 #: lib/transport.tcl:7
 #, tcl-format
 msgid "Fetching new changes from %s"
@@ -2542,11 +2546,11 @@ msgstr "Speglar till %s"
 msgid "Pushing %s %s to %s"
 msgstr "S=C3=A4nder %s %s till %s"
=20
-#: lib/transport.tcl:100
+#: lib/transport.tcl:102
 msgid "Push Branches"
 msgstr "S=C3=A4nd grenar"
=20
-#: lib/transport.tcl:114
+#: lib/transport.tcl:117
 msgid "Source Branches"
 msgstr "K=C3=A4llgrenar"
=20
@@ -2554,19 +2558,19 @@ msgstr "K=C3=A4llgrenar"
 msgid "Destination Repository"
 msgstr "Destinationsarkiv"
=20
-#: lib/transport.tcl:169
+#: lib/transport.tcl:172
 msgid "Transfer Options"
 msgstr "=C3=96verf=C3=B6ringsalternativ"
=20
-#: lib/transport.tcl:171
+#: lib/transport.tcl:174
 msgid "Force overwrite existing branch (may discard changes)"
 msgstr "Tvinga =C3=B6verskrivning av befintlig gren (kan kasta bort =C3=
=A4ndringar)"
=20
-#: lib/transport.tcl:175
+#: lib/transport.tcl:178
 msgid "Use thin pack (for slow network connections)"
 msgstr "Anv=C3=A4nd tunt paket (f=C3=B6r l=C3=A5ngsamma n=C3=A4tverksa=
nslutningar)"
=20
-#: lib/transport.tcl:179
+#: lib/transport.tcl:182
 msgid "Include tags"
 msgstr "Ta med taggar"
=20
--=20
1.7.1
