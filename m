From: Yamada Saburo <devil.tamachan@gmail.com>
Subject: Re: [PATCH v2 3/3] Update po/ja.po
Date: Fri, 19 Jul 2013 21:32:18 +0900
Message-ID: <CAPM==HJ4pTrb5cp0gNNef3PDdk5Sae-aw0ADzsb7zOY4VjDMVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 14:32:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V09rG-0006R2-98
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 14:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812Ab3GSMcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 08:32:21 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:45944 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759544Ab3GSMcT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 08:32:19 -0400
Received: by mail-ve0-f175.google.com with SMTP id da11so3385203veb.34
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=UZ78t8fHZ6LhxJGeJ3c+xeUg6DVN9eB8sCL5Kc40H0U=;
        b=YFO//2JtRyEJq2hlLx+riqiBxtiBqUbAktSIhnL9OfyWQ9Axsg9jp8b0RbO6IslEPA
         oMKFiJ9rlMPh7y1NZKt4KRB26Kp3iFOPoDvdQKoAY7vBftCfgsv+y/LTp3WzE3HoETl7
         illOfWt+msLUjzgF22HkiLjt7lNEZ/HIZ9Ipa/fk6bu73ts6gG9dUrQNSAE++vRIvivL
         uOcczWFAjRbo75Lc3OBftixQad+yze29kmGMGeU8+PtGNh3qHehNExfT7MlUnW4nHD/d
         daY3UzogSTgpy6j4Pd61k3J6CwxqDmxCVKAv9S25ZGC//OLEX1Wl+s8Iy3/bpdSuUwpP
         POFQ==
X-Received: by 10.220.203.197 with SMTP id fj5mr5827601vcb.60.1374237138260;
 Fri, 19 Jul 2013 05:32:18 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Fri, 19 Jul 2013 05:32:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230798>

Signed-off-by: Yamada Saburo <devil.tamachan@gmail.com>
---
 po/ja.po | 1143 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 616 insertions(+), 527 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index 9aff249..4e583fa 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -7,41 +7,41 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2010-01-26 15:47-0800\n"
+"POT-Creation-Date: 2013-07-10 03:38+0900\n"
 "PO-Revision-Date: 2010-02-02 19:03+0900\n"
-"Last-Translator: $B$7$i$$$7(B $B$J$J$3(B <nanako3@lavabit.com>\n"
+"Last-Translator: Yamada Saburo <devil.tamachan@gmail.com>\n"
 "Language-Team: Japanese\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"

-#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.sh:903
-#: git-gui.sh:922
-msgid "git-gui: fatal error"
-msgstr "git-gui: $BCWL?E*$J%(%i!<(B"
-
-#: git-gui.sh:743
+#: git-gui.sh:859
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "%s $B$KL58z$J%U%)%s%H$,;XDj$5$l$F$$$^$9(B:"

-#: git-gui.sh:779
+#: git-gui.sh:911
 msgid "Main Font"
 msgstr "$B<g%U%)%s%H(B"

-#: git-gui.sh:780
+#: git-gui.sh:912
 msgid "Diff/Console Font"
 msgstr "diff/$B%3%s%=!<%k!&%U%)%s%H(B"

-#: git-gui.sh:794
+#: git-gui.sh:926 git-gui.sh:940 git-gui.sh:953 git-gui.sh:1043 git-gui.sh:1062
+#: git-gui.sh:3094
+msgid "git-gui: fatal error"
+msgstr "git-gui: $BCWL?E*$J%(%i!<(B"
+
+#: git-gui.sh:927
 msgid "Cannot find git in PATH."
 msgstr "PATH $BCf$K(B git $B$,8+$D$+$j$^$;$s(B"

-#: git-gui.sh:821
+#: git-gui.sh:954
 msgid "Cannot parse Git version string:"
 msgstr "Git $B%P!<%8%g%sL>$,M}2r$G$-$^$;$s(B:"

-#: git-gui.sh:839
+#: git-gui.sh:979
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -60,475 +60,493 @@ msgstr ""
 "\n"
 "'%s' $B$O%P!<%8%g%s(B 1.5.0 $B$H;W$C$FNI$$$G$9$+!)(B\n"

-#: git-gui.sh:1128
+#: git-gui.sh:1276
 msgid "Git directory not found:"
 msgstr "Git $B%G%#%l%/%H%j$,8+$D$+$j$^$;$s(B:"

-#: git-gui.sh:1146
+#: git-gui.sh:1306
 msgid "Cannot move to top of working directory:"
 msgstr "$B:n6H%G%#%l%/%H%j$N:G>e0L$K0\F0$G$-$^$;$s(B"

-#: git-gui.sh:1154
+#: git-gui.sh:1314
 msgid "Cannot use bare repository:"
 msgstr "$BMg$N%j%]%8%H%j$O;H$($^$;$s(B:"

-#: git-gui.sh:1162
+#: git-gui.sh:1322
 msgid "No working directory"
 msgstr "$B:n6H%G%#%l%/%H%j$,$"$j$^$;$s(B"

-#: git-gui.sh:1334 lib/checkout_op.tcl:306
+#: git-gui.sh:1494 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr "$B%U%!%$%k>uBV$r99?7$7$F$$$^$9!D(B"

-#: git-gui.sh:1390
+#: git-gui.sh:1554
 msgid "Scanning for modified files ..."
 msgstr "$BJQ99$5$l$?%U%!%$%k$r%9%-%c%s$7$F$$$^$9!D(B"

-#: git-gui.sh:1454
+#: git-gui.sh:1621
 msgid "Calling prepare-commit-msg hook..."
 msgstr "prepare-commit-msg $B%U%C%/$r<B9TCf!&!&!&(B"

-#: git-gui.sh:1471
+#: git-gui.sh:1638
 msgid "Commit declined by prepare-commit-msg hook."
 msgstr "prepare-commit-msg $B%U%C%/$,%3%_%C%H$r5qH]$7$^$7$?(B"

-#: git-gui.sh:1629 lib/browser.tcl:246
+#: git-gui.sh:1796 lib/browser.tcl:252
 msgid "Ready."
 msgstr "$B=`Hw40N;(B"

-#: git-gui.sh:1787
+#: git-gui.sh:1954
 #, tcl-format
 msgid "Displaying only %s of %s files."
 msgstr "$BA4BN$G(B%s$B8D$NFb$N(B%s$B%U%!%$%k$@$1I=<($7$F$$$^$9(B"

-#: git-gui.sh:1913
+#: git-gui.sh:2080
 msgid "Unmodified"
 msgstr "$BJQ99L5$7(B"

-#: git-gui.sh:1915
+#: git-gui.sh:2082
 msgid "Modified, not staged"
 msgstr "$BJQ99$"$j!"%3%_%C%HL$M=Dj(B"

-#: git-gui.sh:1916 git-gui.sh:1924
+#: git-gui.sh:2083 git-gui.sh:2095
 msgid "Staged for commit"
 msgstr "$B%3%_%C%HM=Dj:Q(B"

-#: git-gui.sh:1917 git-gui.sh:1925
+#: git-gui.sh:2084 git-gui.sh:2096
 msgid "Portions staged for commit"
 msgstr "$BItJ,E*$K%3%_%C%HM=Dj:Q(B"

-#: git-gui.sh:1918 git-gui.sh:1926
+#: git-gui.sh:2085 git-gui.sh:2097
 msgid "Staged for commit, missing"
 msgstr "$B%3%_%C%HM=Dj:Q!"%U%!%$%kL5$7(B"

-#: git-gui.sh:1920
+#: git-gui.sh:2087
 msgid "File type changed, not staged"
-msgstr "$B%U%!%$%k7?JQ99!"%3%_%C%HL$M=Dj(B"
+msgstr "$B%U%!%$%k%?%$%WJQ99!"%3%_%C%HL$M=Dj(B"

-#: git-gui.sh:1921
+#: git-gui.sh:2088 git-gui.sh:2089
+msgid "File type changed, old type staged for commit"
+msgstr "$B%U%!%$%k%?%$%WJQ99!"85$N%U%!%$%k%?%$%W$G$NJQ99$r%3%_%C%HM=Dj:Q(B"
+
+#: git-gui.sh:2090
 msgid "File type changed, staged"
-msgstr "$B%U%!%$%k7?JQ99!"%3%_%C%HM=Dj:Q(B"
+msgstr "$B%U%!%$%k%?%$%WJQ99!"%3%_%C%HM=Dj:Q(B"
+
+#: git-gui.sh:2091
+msgid "File type change staged, modification not staged"
+msgstr "$B%U%!%$%k%?%$%W$NJQ99$O%3%_%C%HM=Dj:Q!"FbMF$NJQ99$O%3%_%C%HL$M=Dj(B"
+
+#: git-gui.sh:2092
+msgid "File type change staged, file missing"
+msgstr "$B%U%!%$%k%?%$%W$NJQ99$O%3%_%C%HM=Dj:Q!"%U%!%$%k$,8+$D$+$i$J$$(B"

-#: git-gui.sh:1923
+#: git-gui.sh:2094
 msgid "Untracked, not staged"
 msgstr "$B4IM}30!"%3%_%C%HL$M=Dj(B"

-#: git-gui.sh:1928
+#: git-gui.sh:2099
 msgid "Missing"
 msgstr "$B%U%!%$%kL5$7(B"

-#: git-gui.sh:1929
+#: git-gui.sh:2100
 msgid "Staged for removal"
 msgstr "$B:o=|M=Dj:Q(B"

-#: git-gui.sh:1930
+#: git-gui.sh:2101
 msgid "Staged for removal, still present"
 msgstr "$B:o=|M=Dj:Q!"%U%!%$%kL$:o=|(B"

-#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
-#: git-gui.sh:1936 git-gui.sh:1937
+#: git-gui.sh:2103 git-gui.sh:2104 git-gui.sh:2105 git-gui.sh:2106
+#: git-gui.sh:2107 git-gui.sh:2108
 msgid "Requires merge resolution"
 msgstr "$BMW%^!<%82r7h(B"

-#: git-gui.sh:1972
+#: git-gui.sh:2143
 msgid "Starting gitk... please wait..."
 msgstr "gitk $B$r5/F0Cf!D$*BT$A2<$5$$!D(B"

-#: git-gui.sh:1984
+#: git-gui.sh:2155
 msgid "Couldn't find gitk in PATH"
 msgstr "PATH $BCf$K(B gitk $B$,8+$D$+$j$^$;$s(B"

-#: git-gui.sh:2043
+#: git-gui.sh:2214
 msgid "Couldn't find git gui in PATH"
 msgstr "PATH $BCf$K(B git gui $B$,8+$D$+$j$^$;$s(B"

-#: git-gui.sh:2455 lib/choose_repository.tcl:36
+#: git-gui.sh:2633 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "$B%j%]%8%H%j(B"

-#: git-gui.sh:2456
+#: git-gui.sh:2634
 msgid "Edit"
 msgstr "$BJT=8(B"

-#: git-gui.sh:2458 lib/choose_rev.tcl:561
+#: git-gui.sh:2636 lib/choose_rev.tcl:567
 msgid "Branch"
 msgstr "$B%V%i%s%A(B"

-#: git-gui.sh:2461 lib/choose_rev.tcl:548
+#: git-gui.sh:2639 lib/choose_rev.tcl:554
 msgid "Commit@@noun"
 msgstr "$B%3%_%C%H(B"

-#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+#: git-gui.sh:2642 lib/merge.tcl:123 lib/merge.tcl:152 lib/merge.tcl:170
 msgid "Merge"
 msgstr "$B%^!<%8(B"

-#: git-gui.sh:2465 lib/choose_rev.tcl:557
+#: git-gui.sh:2643 lib/choose_rev.tcl:563
 msgid "Remote"
 msgstr "$B%j%b!<%H(B"

-#: git-gui.sh:2468
+#: git-gui.sh:2646
 msgid "Tools"
 msgstr "$B%D!<%k(B"

-#: git-gui.sh:2477
+#: git-gui.sh:2655
 msgid "Explore Working Copy"
 msgstr "$B%o!<%-%s%0%3%T!<$r%V%i%&%:(B"

-#: git-gui.sh:2483
+#: git-gui.sh:2661
 msgid "Browse Current Branch's Files"
 msgstr "$B8=:_$N%V%i%s%A$N%U%!%$%k$r8+$k(B"

-#: git-gui.sh:2487
+#: git-gui.sh:2665
 msgid "Browse Branch Files..."
 msgstr "$B%V%i%s%A$N%U%!%$%k$r8+$k!D(B"

-#: git-gui.sh:2492
+#: git-gui.sh:2670
 msgid "Visualize Current Branch's History"
 msgstr "$B8=:_$N%V%i%s%A$NMzNr$r8+$k(B"

-#: git-gui.sh:2496
+#: git-gui.sh:2674
 msgid "Visualize All Branch History"
 msgstr "$BA4$F$N%V%i%s%A$NMzNr$r8+$k(B"

-#: git-gui.sh:2503
+#: git-gui.sh:2681
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "$B%V%i%s%A(B %s $B$N%U%!%$%k$r8+$k(B"

-#: git-gui.sh:2505
+#: git-gui.sh:2683
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "$B%V%i%s%A(B %s $B$NMzNr$r8+$k(B"

-#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2688 lib/database.tcl:40 lib/database.tcl:66
 msgid "Database Statistics"
 msgstr "$B%G!<%?%Y!<%9E}7W(B"

-#: git-gui.sh:2513 lib/database.tcl:34
+#: git-gui.sh:2691 lib/database.tcl:33
 msgid "Compress Database"
 msgstr "$B%G!<%?%Y!<%905=L(B"

-#: git-gui.sh:2516
+#: git-gui.sh:2694
 msgid "Verify Database"
 msgstr "$B%G!<%?%Y!<%98!>Z(B"

-#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
+#: git-gui.sh:2701 git-gui.sh:2705 git-gui.sh:2709 lib/shortcut.tcl:8
 #: lib/shortcut.tcl:40 lib/shortcut.tcl:72
 msgid "Create Desktop Icon"
 msgstr "$B%G%9%/%H%C%W!&%"%$%3%s$r:n$k(B"

-#: git-gui.sh:2539 lib/choose_repository.tcl:183 lib/choose_repository.tcl:191
+#: git-gui.sh:2717 lib/choose_repository.tcl:188 lib/choose_repository.tcl:196
 msgid "Quit"
 msgstr "$B=*N;(B"

-#: git-gui.sh:2547
+#: git-gui.sh:2725
 msgid "Undo"
 msgstr "$B85$KLa$9(B"

-#: git-gui.sh:2550
+#: git-gui.sh:2728
 msgid "Redo"
 msgstr "$B$d$jD>$7(B"

-#: git-gui.sh:2554 git-gui.sh:3109
+#: git-gui.sh:2732 git-gui.sh:3321
 msgid "Cut"
 msgstr "$B@Z$j<h$j(B"

-#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
+#: git-gui.sh:2735 git-gui.sh:3324 git-gui.sh:3398 git-gui.sh:3483
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "$B%3%T!<(B"

-#: git-gui.sh:2560 git-gui.sh:3115
+#: git-gui.sh:2738 git-gui.sh:3327
 msgid "Paste"
 msgstr "$BE=$jIU$1(B"

-#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
-#: lib/remote_branch_delete.tcl:38
+#: git-gui.sh:2741 git-gui.sh:3330 lib/branch_delete.tcl:28
+#: lib/remote_branch_delete.tcl:39
 msgid "Delete"
 msgstr "$B:o=|(B"

-#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
+#: git-gui.sh:2745 git-gui.sh:3334 git-gui.sh:3487 lib/console.tcl:71
 msgid "Select All"
 msgstr "$BA4$FA*Br(B"

-#: git-gui.sh:2576
+#: git-gui.sh:2754
 msgid "Create..."
 msgstr "$B:n@.!D(B"

-#: git-gui.sh:2582
+#: git-gui.sh:2760
 msgid "Checkout..."
 msgstr "$B%A%'%C%/%"%&%H(B"

-#: git-gui.sh:2588
+#: git-gui.sh:2766
 msgid "Rename..."
 msgstr "$BL>A0JQ99!D(B"

-#: git-gui.sh:2593
+#: git-gui.sh:2771
 msgid "Delete..."
 msgstr "$B:o=|!D(B"

-#: git-gui.sh:2598
+#: git-gui.sh:2776
 msgid "Reset..."
 msgstr "$B%j%;%C%H!D(B"

-#: git-gui.sh:2608
+#: git-gui.sh:2786
 msgid "Done"
 msgstr "$B40N;(B"

-#: git-gui.sh:2610
+#: git-gui.sh:2788
 msgid "Commit@@verb"
 msgstr "$B%3%_%C%H(B"

-#: git-gui.sh:2619 git-gui.sh:3050
+#: git-gui.sh:2797 git-gui.sh:3262
 msgid "New Commit"
 msgstr "$B?75,%3%_%C%H(B"

-#: git-gui.sh:2627 git-gui.sh:3057
+#: git-gui.sh:2805 git-gui.sh:3269
 msgid "Amend Last Commit"
 msgstr "$B:G?7%3%_%C%H$rD{@5(B"

-#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2815 git-gui.sh:3223 lib/remote_branch_delete.tcl:101
 msgid "Rescan"
 msgstr "$B:F%9%-%c%s(B"

-#: git-gui.sh:2643
+#: git-gui.sh:2821
 msgid "Stage To Commit"
 msgstr "$B%3%_%C%HM=Dj$9$k(B"

-#: git-gui.sh:2649
+#: git-gui.sh:2827
 msgid "Stage Changed Files To Commit"
 msgstr "$BJQ99$5$l$?%U%!%$%k$r%3%_%C%HM=Dj(B"

-#: git-gui.sh:2655
+#: git-gui.sh:2833
 msgid "Unstage From Commit"
 msgstr "$B%3%_%C%H$+$i9_$m$9(B"

-#: git-gui.sh:2661 lib/index.tcl:412
+#: git-gui.sh:2839 lib/index.tcl:442
 msgid "Revert Changes"
 msgstr "$BJQ99$r85$KLa$9(B"

-#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
+#: git-gui.sh:2847 git-gui.sh:3534 git-gui.sh:3565
 msgid "Show Less Context"
 msgstr "$BJ8L.$r>/$J$/(B"

-#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
+#: git-gui.sh:2851 git-gui.sh:3538 git-gui.sh:3569
 msgid "Show More Context"
 msgstr "$BJ8L.$rB?$/(B"

-#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
+#: git-gui.sh:2858 git-gui.sh:3236 git-gui.sh:3345
 msgid "Sign Off"
 msgstr "$B=pL>(B"

-#: git-gui.sh:2696
+#: git-gui.sh:2874
 msgid "Local Merge..."
 msgstr "$B%m!<%+%k!&%^!<%8!D(B"

-#: git-gui.sh:2701
+#: git-gui.sh:2879
 msgid "Abort Merge..."
 msgstr "$B%^!<%8Cf;_!D(B"

-#: git-gui.sh:2713 git-gui.sh:2741
+#: git-gui.sh:2891 git-gui.sh:2919
 msgid "Add..."
 msgstr "$BDI2C(B"

-#: git-gui.sh:2717
+#: git-gui.sh:2895
 msgid "Push..."
 msgstr "$B%W%C%7%e!D(B"

-#: git-gui.sh:2721
+#: git-gui.sh:2899
 msgid "Delete Branch..."
 msgstr "$B%V%i%s%A:o=|(B..."

-#: git-gui.sh:2731 git-gui.sh:3292
+#: git-gui.sh:2909 git-gui.sh:3516
 msgid "Options..."
 msgstr "$B%*%W%7%g%s!D(B"

-#: git-gui.sh:2742
+#: git-gui.sh:2920
 msgid "Remove..."
 msgstr "$B:o=|(B..."

-#: git-gui.sh:2751 lib/choose_repository.tcl:50
+#: git-gui.sh:2929 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr "$B%X%k%W(B"

-#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
+#: git-gui.sh:2933 git-gui.sh:2937 lib/about.tcl:14
 #: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
 #, tcl-format
 msgid "About %s"
 msgstr "%s $B$K$D$$$F(B"

-#: git-gui.sh:2783
+#: git-gui.sh:2961
 msgid "Online Documentation"
 msgstr "$B%*%s%i%$%s!&%I%-%e%a%s%H(B"

-#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.tcl:56
+#: git-gui.sh:2964 lib/choose_repository.tcl:47 lib/choose_repository.tcl:56
 msgid "Show SSH Key"
 msgstr "SSH $B%-!<$rI=<((B"

-#: git-gui.sh:2893
+#: git-gui.sh:2983 git-gui.sh:3115
+msgid "Usage"
+msgstr "$B;HMQ>u67(B"
+
+#: git-gui.sh:3064 lib/blame.tcl:573
+msgid "Error"
+msgstr "$B%(%i!<(B"
+
+#: git-gui.sh:3095
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
-msgstr ""
-"$BCWL?E*(B: $B%Q%9(B %s $B$,(B stat $B$G$-$^$;$s!#$=$N$h$&$J%U%!%$%k$d%G%#%l%/%H%j$O$"$j$^(B"
-"$B$;$s(B"
+msgstr "$BCWL?E*(B: $B%Q%9(B %s $B$,(B stat $B$G$-$^$;$s!#$=$N$h$&$J%U%!%$%k$d%G%#%l%/%H%j$O$"$j$^$;$s(B"

-#: git-gui.sh:2926
+#: git-gui.sh:3128
 msgid "Current Branch:"
 msgstr "$B8=:_$N%V%i%s%A(B"

-#: git-gui.sh:2947
+#: git-gui.sh:3154
 msgid "Staged Changes (Will Commit)"
 msgstr "$B%9%F!<%8%s%0$5$l$?!J%3%_%C%HM=Dj:Q$N!KJQ99(B"

-#: git-gui.sh:2967
+#: git-gui.sh:3174
 msgid "Unstaged Changes"
 msgstr "$B%3%_%C%HM=Dj$KF~$C$F$$$J$$JQ99(B"

-#: git-gui.sh:3017
+#: git-gui.sh:3229
 msgid "Stage Changed"
 msgstr "$BJQ99$r%3%_%C%HM=Dj$KF~$l$k(B"

-#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
+#: git-gui.sh:3248 lib/transport.tcl:137 lib/transport.tcl:229
 msgid "Push"
 msgstr "$B%W%C%7%e(B"

-#: git-gui.sh:3071
+#: git-gui.sh:3283
 msgid "Initial Commit Message:"
 msgstr "$B:G=i$N%3%_%C%H%a%C%;!<%8(B:"

-#: git-gui.sh:3072
+#: git-gui.sh:3284
 msgid "Amended Commit Message:"
 msgstr "$BD{@5$7$?%3%_%C%H%a%C%;!<%8(B:"

-#: git-gui.sh:3073
+#: git-gui.sh:3285
 msgid "Amended Initial Commit Message:"
 msgstr "$BD{@5$7$?:G=i$N%3%_%C%H%a%C%;!<%8(B:"

-#: git-gui.sh:3074
+#: git-gui.sh:3286
 msgid "Amended Merge Commit Message:"
 msgstr "$BD{@5$7$?%^!<%8%3%_%C%H%a%C%;!<%8(B:"

-#: git-gui.sh:3075
+#: git-gui.sh:3287
 msgid "Merge Commit Message:"
 msgstr "$B%^!<%8%3%_%C%H%a%C%;!<%8(B:"

-#: git-gui.sh:3076
+#: git-gui.sh:3288
 msgid "Commit Message:"
 msgstr "$B%3%_%C%H%a%C%;!<%8(B:"

-#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
+#: git-gui.sh:3337 git-gui.sh:3491 lib/console.tcl:73
 msgid "Copy All"
 msgstr "$BA4$F%3%T!<(B"

-#: git-gui.sh:3149 lib/blame.tcl:104
+#: git-gui.sh:3361 lib/blame.tcl:105
 msgid "File:"
 msgstr "$B%U%!%$%k(B:"

-#: git-gui.sh:3255
+#: git-gui.sh:3479
 msgid "Refresh"
 msgstr "$B:FFI$_9~$_(B"

-#: git-gui.sh:3276
+#: git-gui.sh:3500
 msgid "Decrease Font Size"
 msgstr "$B%U%)%s%H$r>.$5$/(B"

-#: git-gui.sh:3280
+#: git-gui.sh:3504
 msgid "Increase Font Size"
 msgstr "$B%U%)%s%H$rBg$-$/(B"

-#: git-gui.sh:3288 lib/blame.tcl:281
+#: git-gui.sh:3512 lib/blame.tcl:294
 msgid "Encoding"
 msgstr "$B%(%s%3!<%G%#%s%0(B"

-#: git-gui.sh:3299
+#: git-gui.sh:3523
 msgid "Apply/Reverse Hunk"
 msgstr "$B%Q%C%A$rE,MQ(B/$B<h$j>C$9(B"

-#: git-gui.sh:3304
+#: git-gui.sh:3528
 msgid "Apply/Reverse Line"
 msgstr "$B%Q%C%A9T$rE,MQ(B/$B<h$j>C$9(B"

-#: git-gui.sh:3323
+#: git-gui.sh:3547
 msgid "Run Merge Tool"
 msgstr "$B%^!<%8%D!<%k$r5/F0(B"

-#: git-gui.sh:3328
+#: git-gui.sh:3552
 msgid "Use Remote Version"
 msgstr "$B%j%b!<%H$NJ}$r:NMQ(B"

-#: git-gui.sh:3332
+#: git-gui.sh:3556
 msgid "Use Local Version"
 msgstr "$B%m!<%+%k$NJ}$r:NMQ(B"

-#: git-gui.sh:3336
+#: git-gui.sh:3560
 msgid "Revert To Base"
 msgstr "$B%Y!<%9HG$r:NMQ(B"

-#: git-gui.sh:3354
+#: git-gui.sh:3578
 msgid "Visualize These Changes In The Submodule"
 msgstr "$B%5%V%b%8%e!<%kFb$N$3$l$i$NJQ99$r8+$k(B"

-#: git-gui.sh:3358
+#: git-gui.sh:3582
 msgid "Visualize Current Branch History In The Submodule"
 msgstr "$B%5%V%b%8%e!<%kFb$G8=:_$N%V%i%s%A$NMzNr$r8+$k(B"

-#: git-gui.sh:3362
+#: git-gui.sh:3586
 msgid "Visualize All Branch History In The Submodule"
 msgstr "$B%5%V%b%8%e!<%kFb$GA4$F$N%V%i%s%A$NMzNr$r8+$k(B"

-#: git-gui.sh:3367
+#: git-gui.sh:3591
 msgid "Start git gui In The Submodule"
 msgstr "$B%5%V%b%8%e!<%kFb$G(Bgit gui$B$r5/F0$9$k(B"

-#: git-gui.sh:3389
+#: git-gui.sh:3626
 msgid "Unstage Hunk From Commit"
 msgstr "$B%Q%C%A$r%3%_%C%HM=Dj$+$i30$9(B"

-#: git-gui.sh:3391
+#: git-gui.sh:3628
 msgid "Unstage Lines From Commit"
 msgstr "$B%3%_%C%HM=Dj$+$i9T$r30$9(B"

-#: git-gui.sh:3393
+#: git-gui.sh:3630
 msgid "Unstage Line From Commit"
 msgstr "$B%3%_%C%HM=Dj$+$i9T$r30$9(B"

-#: git-gui.sh:3396
+#: git-gui.sh:3633
 msgid "Stage Hunk For Commit"
 msgstr "$B%Q%C%A$r%3%_%C%HM=Dj$K2C$($k(B"

-#: git-gui.sh:3398
+#: git-gui.sh:3635
 msgid "Stage Lines For Commit"
 msgstr "$B%Q%C%A9T$r%3%_%C%HM=Dj$K2C$($k(B"

-#: git-gui.sh:3400
+#: git-gui.sh:3637
 msgid "Stage Line For Commit"
 msgstr "$B%Q%C%A9T$r%3%_%C%HM=Dj$K2C$($k(B"

-#: git-gui.sh:3424
+#: git-gui.sh:3662
 msgid "Initializing..."
 msgstr "$B=i4|2=$7$F$$$^$9!D(B"

-#: git-gui.sh:3541
+#: git-gui.sh:3805
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -543,7 +561,7 @@ msgstr ""
 "$B0J2<$N4D6-JQ?t$O(B %s $B$,5/F0$9$k(B Git $B%5%V%W%m%;%9$K$h$C$FL5;k$5$l$k$G$7$g$&(B:\n"
 "\n"

-#: git-gui.sh:3570
+#: git-gui.sh:3834
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -553,7 +571,7 @@ msgstr ""
 "$B$3$l$O(B Cygwin $B$GG[I[$5$l$F$$$k(B Tcl $B%P%$%J%j$K(B\n"
 "$B4X$7$F$N4{CN$NLdBj$K$h$j$^$9(B"

-#: git-gui.sh:3575
+#: git-gui.sh:3839
 #, tcl-format
 msgid ""
 "\n"
@@ -572,165 +590,168 @@ msgstr ""
 msgid "git-gui - a graphical user interface for Git."
 msgstr "Git $B$N%0%i%U%#%+%k(BUI git-gui"

-#: lib/blame.tcl:72
+#: lib/blame.tcl:73
 msgid "File Viewer"
 msgstr "$B%U%!%$%k%T%e!<%o(B"

-#: lib/blame.tcl:78
+#: lib/blame.tcl:79
 msgid "Commit:"
 msgstr "$B%3%_%C%H(B:"

-#: lib/blame.tcl:271
+#: lib/blame.tcl:280
 msgid "Copy Commit"
 msgstr "$B%3%_%C%H$r%3%T!<(B"

-#: lib/blame.tcl:275
+#: lib/blame.tcl:284
 msgid "Find Text..."
 msgstr "$B%F%-%9%H$r8!:w(B"

-#: lib/blame.tcl:284
+#: lib/blame.tcl:288
+msgid "Goto Line..."
+msgstr "$B;XDj9T$X0\F0(B"
+
+#: lib/blame.tcl:297
 msgid "Do Full Copy Detection"
 msgstr "$B%3%T!<8!CN(B"

-#: lib/blame.tcl:288
+#: lib/blame.tcl:301
 msgid "Show History Context"
 msgstr "$BJ8L.$r8+$;$k(B"

-#: lib/blame.tcl:291
+#: lib/blame.tcl:304
 msgid "Blame Parent Commit"
 msgstr "$B?F%3%_%C%H$rCp<a(B"

-#: lib/blame.tcl:450
+#: lib/blame.tcl:466
 #, tcl-format
 msgid "Reading %s..."
 msgstr "%s $B$rFI$s$G$$$^$9!D(B"

-#: lib/blame.tcl:557
+#: lib/blame.tcl:594
 msgid "Loading copy/move tracking annotations..."
 msgstr "$B%3%T!<!&0\F0DI@W%G!<%?$rFI$s$G$$$^$9!D(B"

-#: lib/blame.tcl:577
+#: lib/blame.tcl:614
 msgid "lines annotated"
 msgstr "$B9T$rCm<a$7$^$7$?(B"

-#: lib/blame.tcl:769
+#: lib/blame.tcl:806
 msgid "Loading original location annotations..."
 msgstr "$B850LCV9T$NCm<a%G!<%?$rFI$s$G$$$^$9!D(B"

-#: lib/blame.tcl:772
+#: lib/blame.tcl:809
 msgid "Annotation complete."
 msgstr "$BCm<a40N;$7$^$7$?(B"

-#: lib/blame.tcl:802
+#: lib/blame.tcl:839
 msgid "Busy"
 msgstr "$B<B9TCf(B"

-#: lib/blame.tcl:803
+#: lib/blame.tcl:840
 msgid "Annotation process is already running."
 msgstr "$B$9$G$K(B blame $B%W%m%;%9$r<B9TCf$G$9!#(B"

-#: lib/blame.tcl:842
+#: lib/blame.tcl:879
 msgid "Running thorough copy detection..."
 msgstr "$B%3%T!<8!CN$r<B9TCf!D(B"

-#: lib/blame.tcl:910
+#: lib/blame.tcl:947
 msgid "Loading annotation..."
 msgstr "$BCm<a$rFI$_9~$s$G$$$^$9!D(B"

-#: lib/blame.tcl:963
+#: lib/blame.tcl:1000
 msgid "Author:"
 msgstr "$B:n<T(B:"

-#: lib/blame.tcl:967
+#: lib/blame.tcl:1004
 msgid "Committer:"
 msgstr "$B%3%_%C%H<T(B:"

-#: lib/blame.tcl:972
+#: lib/blame.tcl:1009
 msgid "Original File:"
 msgstr "$B85%U%!%$%k(B"

-#: lib/blame.tcl:1020
+#: lib/blame.tcl:1057
 msgid "Cannot find HEAD commit:"
 msgstr "HEAD $B%3%_%C%H$,8+$D$+$j$^$;$s(B"

-#: lib/blame.tcl:1075
+#: lib/blame.tcl:1112
 msgid "Cannot find parent commit:"
 msgstr "$B?F%3%_%C%H$,8+$D$+$j$^$;$s(B:"

-#: lib/blame.tcl:1090
+#: lib/blame.tcl:1127
 msgid "Unable to display parent"
 msgstr "$B?F$rI=<($G$-$^$;$s(B"

-#: lib/blame.tcl:1091 lib/diff.tcl:320
+#: lib/blame.tcl:1128 lib/diff.tcl:338
 msgid "Error loading diff:"
 msgstr "diff $B$rFI$`:]$N%(%i!<$G$9(B:"

-#: lib/blame.tcl:1231
+#: lib/blame.tcl:1269
 msgid "Originally By:"
 msgstr "$B86:n<T(B:"

-#: lib/blame.tcl:1237
+#: lib/blame.tcl:1275
 msgid "In File:"
 msgstr "$B%U%!%$%k(B:"

-#: lib/blame.tcl:1242
+#: lib/blame.tcl:1280
 msgid "Copied Or Moved Here By:"
 msgstr "$BJ#<L!&0\F0<T(B:"

-#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+#: lib/branch_checkout.tcl:16 lib/branch_checkout.tcl:21
 msgid "Checkout Branch"
 msgstr "$B%V%i%s%A$r%A%'%C%/%"%&%H(B"

-#: lib/branch_checkout.tcl:23
+#: lib/branch_checkout.tcl:26
 msgid "Checkout"
 msgstr "$B%A%'%C%/%"%&%H(B"

-#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
-#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:282
-#: lib/checkout_op.tcl:579 lib/choose_font.tcl:43 lib/merge.tcl:172
-#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.tcl:42
-#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
-#: lib/transport.tcl:108
+#: lib/branch_checkout.tcl:30 lib/branch_create.tcl:37 lib/branch_delete.tcl:34
+#: lib/branch_rename.tcl:32 lib/browser.tcl:292 lib/checkout_op.tcl:579
+#: lib/choose_font.tcl:45 lib/merge.tcl:174 lib/option.tcl:127
+#: lib/remote_add.tcl:34 lib/remote_branch_delete.tcl:43 lib/tools_dlg.tcl:41
+#: lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345 lib/transport.tcl:141
 msgid "Cancel"
 msgstr "$BCf;_(B"

-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:328
+#: lib/branch_checkout.tcl:35 lib/browser.tcl:297 lib/tools_dlg.tcl:321
 msgid "Revision"
 msgstr "$B%j%S%8%g%s(B"

-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:280
+#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:69 lib/option.tcl:307
 msgid "Options"
 msgstr "$B%*%W%7%g%s(B"

-#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
+#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
 msgid "Fetch Tracking Branch"
 msgstr "$B%H%i%C%-%s%0!&%V%i%s%A$r%U%'%C%A(B"

-#: lib/branch_checkout.tcl:44
+#: lib/branch_checkout.tcl:47
 msgid "Detach From Local Branch"
 msgstr "$B%m!<%+%k!&%V%i%s%A$+$i:o=|(B"

-#: lib/branch_create.tcl:22
+#: lib/branch_create.tcl:23
 msgid "Create Branch"
 msgstr "$B%V%i%s%A$r:n@.(B"

-#: lib/branch_create.tcl:27
+#: lib/branch_create.tcl:28
 msgid "Create New Branch"
 msgstr "$B%V%i%s%A$r?75,:n@.(B"

-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
+#: lib/branch_create.tcl:33 lib/choose_repository.tcl:383
 msgid "Create"
 msgstr "$B:n@.(B"

-#: lib/branch_create.tcl:40
+#: lib/branch_create.tcl:42
 msgid "Branch Name"
 msgstr "$B%V%i%s%AL>(B"

-#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
+#: lib/branch_create.tcl:44 lib/remote_add.tcl:41 lib/tools_dlg.tcl:51
 msgid "Name:"
 msgstr "$BL>A0(B:"

-#: lib/branch_create.tcl:58
+#: lib/branch_create.tcl:57
 msgid "Match Tracking Branch Name"
 msgstr "$B%H%i%C%-%s%0!&%V%i%s%AL>$r9g$o$;$k(B"

@@ -758,41 +779,41 @@ msgstr "$B%j%;%C%H(B"
 msgid "Checkout After Creation"
 msgstr "$B:n@.$7$F$9$0%A%'%C%/%"%&%H(B"

-#: lib/branch_create.tcl:131
+#: lib/branch_create.tcl:132
 msgid "Please select a tracking branch."
 msgstr "$B%H%i%C%-%s%0!&%V%i%s%A$rA*Br$7$F2<$5$$!#(B"

-#: lib/branch_create.tcl:140
+#: lib/branch_create.tcl:141
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
 msgstr "$B%H%i%C%-%s%0!&%V%i%s%A(B %s $B$O1s3V%j%]%8%H%j$N%V%i%s%A$G$O$"$j$^$;$s!#(B"

-#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
+#: lib/branch_create.tcl:154 lib/branch_rename.tcl:92
 msgid "Please supply a branch name."
 msgstr "$B%V%i%s%AL>$r;XDj$7$F2<$5$$!#(B"

-#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#: lib/branch_create.tcl:165 lib/branch_rename.tcl:112
 #, tcl-format
 msgid "'%s' is not an acceptable branch name."
 msgstr "'%s' $B$O%V%i%s%AL>$K;H$($^$;$s!#(B"

-#: lib/branch_delete.tcl:15
+#: lib/branch_delete.tcl:16
 msgid "Delete Branch"
 msgstr "$B%V%i%s%A:o=|(B"

-#: lib/branch_delete.tcl:20
+#: lib/branch_delete.tcl:21
 msgid "Delete Local Branch"
 msgstr "$B%m!<%+%k!&%V%i%s%A$r:o=|(B"

-#: lib/branch_delete.tcl:37
+#: lib/branch_delete.tcl:39
 msgid "Local Branches"
 msgstr "$B%m!<%+%k!&%V%i%s%A(B"

-#: lib/branch_delete.tcl:52
+#: lib/branch_delete.tcl:51
 msgid "Delete Only If Merged Into"
 msgstr "$B%^!<%8:Q$_$N;~$N$_:o=|(B"

-#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
+#: lib/branch_delete.tcl:53 lib/remote_branch_delete.tcl:120
 msgid "Always (Do not perform merge checks)"
 msgstr "$BL5>r7o!J%^!<%88!::$r$7$J$$!K(B"

@@ -801,7 +822,7 @@ msgstr "$BL5>r7o!J%^!<%88!::$r$7$J$$!K(B"
 msgid "The following branches are not completely merged into %s:"
 msgstr "$B0J2<$N%V%i%s%A$O(B %s $B$K40A4$K%^!<%8$5$l$F$$$^$;$s(B:"

-#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
+#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:218
 msgid ""
 "Recovering deleted branches is difficult.\n"
 "\n"
@@ -820,32 +841,32 @@ msgstr ""
 "$B0J2<$N%V%i%s%A$r:o=|$G$-$^$;$s(B:\n"
 "%s"

-#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
+#: lib/branch_rename.tcl:15 lib/branch_rename.tcl:23
 msgid "Rename Branch"
 msgstr "$B%V%i%s%A$NL>A0JQ99(B"

-#: lib/branch_rename.tcl:26
+#: lib/branch_rename.tcl:28
 msgid "Rename"
 msgstr "$BL>A0JQ99(B"

-#: lib/branch_rename.tcl:36
+#: lib/branch_rename.tcl:38
 msgid "Branch:"
 msgstr "$B%V%i%s%A(B:"

-#: lib/branch_rename.tcl:39
+#: lib/branch_rename.tcl:46
 msgid "New Name:"
 msgstr "$B?7$7$$L>A0(B:"

-#: lib/branch_rename.tcl:75
+#: lib/branch_rename.tcl:81
 msgid "Please select a branch to rename."
 msgstr "$BL>A0$rJQ99$9$k%V%i%s%A$rA*$s$G2<$5$$!#(B"

-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
+#: lib/branch_rename.tcl:102 lib/checkout_op.tcl:202
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr "'%s'$B$H$$$&%V%i%s%A$O4{$KB8:_$7$^$9!#(B"

-#: lib/branch_rename.tcl:117
+#: lib/branch_rename.tcl:123
 #, tcl-format
 msgid "Failed to rename '%s'."
 msgstr "'%s'$B$NL>A0JQ99$K<:GT$7$^$7$?!#(B"
@@ -854,26 +875,26 @@ msgstr "'%s'$B$NL>A0JQ99$K<:GT$7$^$7$?!#(B"
 msgid "Starting..."
 msgstr "$B5/F0Cf!D(B"

-#: lib/browser.tcl:26
+#: lib/browser.tcl:27
 msgid "File Browser"
 msgstr "$B%U%!%$%k!&%V%i%&%6(B"

-#: lib/browser.tcl:126 lib/browser.tcl:143
+#: lib/browser.tcl:132 lib/browser.tcl:149
 #, tcl-format
 msgid "Loading %s..."
 msgstr "%s $B$r%m!<%ICf!D(B"

-#: lib/browser.tcl:187
+#: lib/browser.tcl:193
 msgid "[Up To Parent]"
 msgstr "[$B>e0L%U%)%k%@$X(B]"

-#: lib/browser.tcl:267 lib/browser.tcl:273
+#: lib/browser.tcl:275 lib/browser.tcl:282
 msgid "Browse Branch Files"
 msgstr "$B8=:_$N%V%i%s%A$N%U%!%$%k$r8+$k(B"

-#: lib/browser.tcl:278 lib/choose_repository.tcl:398
-#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
-#: lib/choose_repository.tcl:1028
+#: lib/browser.tcl:288 lib/choose_repository.tcl:398
+#: lib/choose_repository.tcl:485 lib/choose_repository.tcl:494
+#: lib/choose_repository.tcl:1021
 msgid "Browse"
 msgstr "$B%V%i%&%:(B"

@@ -887,8 +908,8 @@ msgstr "%s $B$+$i(B %s $B$r%U%'%C%A$7$F$$$^$9(B"
 msgid "fatal: Cannot resolve %s"
 msgstr "$BCWL?E*%(%i!<(B: %s $B$r2r7h$G$-$^$;$s(B"

-#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
-#: lib/sshkey.tcl:53
+#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:30
+#: lib/sshkey.tcl:55
 msgid "Close"
 msgstr "$BJD$8$k(B"

@@ -940,8 +961,7 @@ msgid ""
 msgstr ""
 "$B:G8e$K%9%-%c%s$7$?>uBV$O%j%]%8%H%j$N>uBV$H9gCW$7$^$;$s!#(B\n"
 "\n"
-"$B:G8e$K%9%-%c%s$7$F0J8e!"JL$N(B Git $B%W%m%0%i%`$,%j%]%8%H%j$rJQ99$7$F$$$^$9!#8=:_(B"
-"$B$N%V%i%s%A$rJQ99$9$kA0$K!":F%9%-%c%s$,I,MW$G$9!#(B\n"
+"$B:G8e$K%9%-%c%s$7$F0J8e!"JL$N(B Git $B%W%m%0%i%`$,%j%]%8%H%j$rJQ99$7$F$$$^$9!#8=:_$N%V%i%s%A$rJQ99$9$kA0$K!":F%9%-%c%s$,I,MW$G$9!#(B\n"
 "\n"
 "$B<+F0E*$K:F%9%-%c%s$r3+;O$7$^$9!#(B\n"

@@ -977,8 +997,7 @@ msgid ""
 msgstr ""
 "$B%m!<%+%k!&%V%i%s%A$+$iN%$l$^$9!#(B\n"
 "\n"
-"$B%V%i%s%A>e$KBZ$^$j$?$$$H$-$O!"$3$N!VJ,N%$5$l$?%A%'%C%/%"%&%H!W$+$i?75,%V%i%s(B"
-"$B%A$r3+;O$7$F$/$@$5$$!#(B"
+"$B%V%i%s%A>e$KBZ$^$j$?$$$H$-$O!"$3$N!VJ,N%$5$l$?%A%'%C%/%"%&%H!W$+$i?75,%V%i%s%A$r3+;O$7$F$/$@$5$$!#(B"

 #: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
 #, tcl-format
@@ -999,7 +1018,7 @@ msgstr "$B<:$J$o$l$?%3%_%C%H$r2sI|$9$k$N$O4JC1$G$O$"$j$^$;(B
 msgid "Reset '%s'?"
 msgstr "'%s' $B$r%j%;%C%H$7$^$9$+!)(B"

-#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
+#: lib/checkout_op.tcl:567 lib/merge.tcl:166 lib/tools_dlg.tcl:336
 msgid "Visualize"
 msgstr "$B2D;k2=(B"

@@ -1015,27 +1034,26 @@ msgid ""
 msgstr ""
 "$B8=:_$N%V%i%s%A$r@_Dj$G$-$^$;$s!#(B\n"
 "\n"
-"$B:n6H%G%#%l%/%H%j$OItJ,E*$K$7$+@Z$jBX$o$C$F$$$^$;$s!#%U%!%$%k$N99?7$K$O@.8y$7(B"
-"$B$^$7$?$,!"(B Git $B$NFbIt%G!<%?$r99?7$G$-$^$;$s$G$7$?!#(B\n"
+"$B:n6H%G%#%l%/%H%j$OItJ,E*$K$7$+@Z$jBX$o$C$F$$$^$;$s!#%U%!%$%k$N99?7$K$O@.8y$7$^$7$?$,!"(B Git $B$NFbIt%G!<%?$r99?7$G$-$^$;$s$G$7$?!#(B\n"
 "$B5/$3$k$O$:$N$J$$%(%i!<$G$9!#$"$-$i$a$F(B %s $B$r=*N;$7$^$9!#(B"

-#: lib/choose_font.tcl:39
+#: lib/choose_font.tcl:41
 msgid "Select"
 msgstr "$BA*Br(B"

-#: lib/choose_font.tcl:53
+#: lib/choose_font.tcl:55
 msgid "Font Family"
 msgstr "$B%U%)%s%H!&%U%!%_%j!<(B"

-#: lib/choose_font.tcl:74
+#: lib/choose_font.tcl:76
 msgid "Font Size"
 msgstr "$B%U%)%s%H$NBg$-$5(B"

-#: lib/choose_font.tcl:91
+#: lib/choose_font.tcl:93
 msgid "Font Example"
 msgstr "$B%U%)%s%H!&%5%s%W%k(B"

-#: lib/choose_font.tcl:103
+#: lib/choose_font.tcl:105
 msgid ""
 "This is example text.\n"
 "If you like this text, it can be your font."
@@ -1047,7 +1065,7 @@ msgstr ""
 msgid "Git Gui"
 msgstr "Git GUI"

-#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:388
 msgid "Create New Repository"
 msgstr "$B?7$7$$%j%]%8%H%j$r:n$k(B"

@@ -1055,42 +1073,42 @@ msgstr "$B?7$7$$%j%]%8%H%j$r:n$k(B"
 msgid "New..."
 msgstr "$B?75,!D(B"

-#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:472
 msgid "Clone Existing Repository"
 msgstr "$B4{B8%j%]%8%H%j$rJ#@=$9$k(B"

-#: lib/choose_repository.tcl:106
+#: lib/choose_repository.tcl:111
 msgid "Clone..."
 msgstr "$BJ#@=!D(B"

-#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
+#: lib/choose_repository.tcl:118 lib/choose_repository.tcl:1011
 msgid "Open Existing Repository"
 msgstr "$B4{B8%j%]%8%H%j$r3+$/(B"

-#: lib/choose_repository.tcl:119
+#: lib/choose_repository.tcl:124
 msgid "Open..."
 msgstr "$B3+$/!D(B"

-#: lib/choose_repository.tcl:132
+#: lib/choose_repository.tcl:137
 msgid "Recent Repositories"
 msgstr "$B:G6a;H$C$?%j%]%8%H%j(B"

-#: lib/choose_repository.tcl:138
+#: lib/choose_repository.tcl:143
 msgid "Open Recent Repository:"
 msgstr "$B:G6a;H$C$?%j%]%8%H%j$r3+$/(B"

-#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
-#: lib/choose_repository.tcl:320
+#: lib/choose_repository.tcl:307 lib/choose_repository.tcl:314
+#: lib/choose_repository.tcl:321
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "$B%j%]%8%H%j(B %s $B$r:n@=$G$-$^$;$s(B:"

-#: lib/choose_repository.tcl:391
+#: lib/choose_repository.tcl:393
 msgid "Directory:"
 msgstr "$B%G%#%l%/%H%j(B:"

-#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
-#: lib/choose_repository.tcl:1052
+#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1045
 msgid "Git Repository"
 msgstr "GIT $B%j%]%8%H%j(B"

@@ -1104,173 +1122,173 @@ msgstr "$B%G%#%l%/%H%j(B '%s' $B$O4{$KB8:_$7$^$9!#(B"
 msgid "File %s already exists."
 msgstr "$B%U%!%$%k(B '%s' $B$O4{$KB8:_$7$^$9!#(B"

-#: lib/choose_repository.tcl:466
+#: lib/choose_repository.tcl:467
 msgid "Clone"
 msgstr "$BJ#@=(B"

-#: lib/choose_repository.tcl:479
+#: lib/choose_repository.tcl:480
 msgid "Source Location:"
 msgstr "$B%=!<%9$N0LCV(B"

-#: lib/choose_repository.tcl:490
+#: lib/choose_repository.tcl:489
 msgid "Target Directory:"
-msgstr "$B@h%G%#%l%/%H%j(B:"
+msgstr "$BJ]B8%G%#%l%/%H%j(B:"

-#: lib/choose_repository.tcl:502
+#: lib/choose_repository.tcl:499
 msgid "Clone Type:"
 msgstr "$BJ#@=J}<0(B:"

-#: lib/choose_repository.tcl:508
+#: lib/choose_repository.tcl:504
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "$BI8=`(B($B9bB.!&Cf>iD9EY!&%O!<%I%j%s%/(B)"

-#: lib/choose_repository.tcl:514
+#: lib/choose_repository.tcl:509
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "$BA4J#<L(B($BDcB.!&>iD9%P%C%/%"%C%W(B)"

-#: lib/choose_repository.tcl:520
+#: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "$B6&M-(B($B:G9bB.!&Hs?d>)!&%P%C%/%"%C%WL5$7(B)"

-#: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
-#: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
-#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:743 lib/choose_repository.tcl:813
+#: lib/choose_repository.tcl:1051 lib/choose_repository.tcl:1059
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "Git $B%j%]%8%H%j$G$O$"$j$^$;$s(B: %s"

-#: lib/choose_repository.tcl:592
+#: lib/choose_repository.tcl:586
 msgid "Standard only available for local repository."
 msgstr "$BI8=`J}<0$OF10l7W;;5!>e$N%j%]%8%H%j$K$N$_;H$($^$9!#(B"

-#: lib/choose_repository.tcl:596
+#: lib/choose_repository.tcl:590
 msgid "Shared only available for local repository."
 msgstr "$B6&M-J}<0$OF10l7W;;5!>e$N%j%]%8%H%j$K$N$_;H$($^$9!#(B"

-#: lib/choose_repository.tcl:617
+#: lib/choose_repository.tcl:611
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "'%s' $B$O4{$KB8:_$7$^$9!#(B"

-#: lib/choose_repository.tcl:628
+#: lib/choose_repository.tcl:622
 msgid "Failed to configure origin"
 msgstr "origin $B$r@_Dj$G$-$^$;$s$G$7$?(B"

-#: lib/choose_repository.tcl:640
+#: lib/choose_repository.tcl:634
 msgid "Counting objects"
 msgstr "$B%*%V%8%'%/%H$r?t$($F$$$^$9(B"

-#: lib/choose_repository.tcl:641
+#: lib/choose_repository.tcl:635
 msgid "buckets"
 msgstr "$B%P%1%D(B"

-#: lib/choose_repository.tcl:665
+#: lib/choose_repository.tcl:659
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "objects/info/alternates $B$rJ#<L$G$-$^$;$s(B: %s"

-#: lib/choose_repository.tcl:701
+#: lib/choose_repository.tcl:695
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "%s $B$+$iJ#@=$9$kFbMF$O$"$j$^$;$s(B"

-#: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
-#: lib/choose_repository.tcl:929
+#: lib/choose_repository.tcl:697 lib/choose_repository.tcl:911
+#: lib/choose_repository.tcl:923
 msgid "The 'master' branch has not been initialized."
 msgstr "'master' $B%V%i%s%A$,=i4|2=$5$l$F$$$^$;$s(B"

-#: lib/choose_repository.tcl:716
+#: lib/choose_repository.tcl:710
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "$B%O!<%I%j%s%/$,:n$l$J$$$N$G!"%3%T!<$7$^$9(B"

-#: lib/choose_repository.tcl:728
+#: lib/choose_repository.tcl:722
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "%s $B$+$iJ#@=$7$F$$$^$9(B"

-#: lib/choose_repository.tcl:759
+#: lib/choose_repository.tcl:753
 msgid "Copying objects"
 msgstr "$B%*%V%8%'%/%H$rJ#<L$7$F$$$^$9(B"

-#: lib/choose_repository.tcl:760
+#: lib/choose_repository.tcl:754
 msgid "KiB"
 msgstr "KiB"

-#: lib/choose_repository.tcl:784
+#: lib/choose_repository.tcl:778
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "$B%*%V%8%'%/%H$rJ#<L$G$-$^$;$s(B: %s"

-#: lib/choose_repository.tcl:794
+#: lib/choose_repository.tcl:788
 msgid "Linking objects"
 msgstr "$B%*%V%8%'%/%H$rO"7k$7$F$$$^$9(B"

-#: lib/choose_repository.tcl:795
+#: lib/choose_repository.tcl:789
 msgid "objects"
 msgstr "$B%*%V%8%'%/%H(B"

-#: lib/choose_repository.tcl:803
+#: lib/choose_repository.tcl:797
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "$B%*%V%8%'%/%H$r%O!<%I%j%s%/$G$-$^$;$s(B: %s"

-#: lib/choose_repository.tcl:858
+#: lib/choose_repository.tcl:852
 msgid "Cannot fetch branches and objects.  See console output for details."
 msgstr "$B%V%i%s%A$d%*%V%8%'%/%H$r<hF@$G$-$^$;$s!#%3%s%=!<%k=PNO$r8+$F2<$5$$(B"

-#: lib/choose_repository.tcl:869
+#: lib/choose_repository.tcl:863
 msgid "Cannot fetch tags.  See console output for details."
 msgstr "$B%?%0$r<hF@$G$-$^$;$s!#%3%s%=!<%k=PNO$r8+$F2<$5$$(B"

-#: lib/choose_repository.tcl:893
+#: lib/choose_repository.tcl:887
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr "HEAD $B$r3NDj$G$-$^$;$s!#%3%s%=!<%k=PNO$r8+$F2<$5$$(B"

-#: lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:896
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "%s $B$rA]=|$G$-$^$;$s(B"

-#: lib/choose_repository.tcl:908
+#: lib/choose_repository.tcl:902
 msgid "Clone failed."
 msgstr "$BJ#<L$K<:GT$7$^$7$?!#(B"

-#: lib/choose_repository.tcl:915
+#: lib/choose_repository.tcl:909
 msgid "No default branch obtained."
 msgstr "$B%G%U%)!<%k%H!&%V%i%s%A$,<hF@$5$l$^$;$s$G$7$?(B"

-#: lib/choose_repository.tcl:926
+#: lib/choose_repository.tcl:920
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "%s $B$r%3%_%C%H$H$7$F2r<a$G$-$^$;$s(B"

-#: lib/choose_repository.tcl:938
+#: lib/choose_repository.tcl:932
 msgid "Creating working directory"
 msgstr "$B:n6H%G%#%l%/%H%j$r:n@.$7$F$$$^$9(B"

-#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
-#: lib/index.tcl:198
+#: lib/choose_repository.tcl:933 lib/index.tcl:70 lib/index.tcl:136
+#: lib/index.tcl:207
 msgid "files"
 msgstr "$B%U%!%$%k(B"

-#: lib/choose_repository.tcl:968
+#: lib/choose_repository.tcl:962
 msgid "Initial file checkout failed."
 msgstr "$B=i4|%A%'%C%/%"%&%H$K<:GT$7$^$7$?(B"

-#: lib/choose_repository.tcl:1011
+#: lib/choose_repository.tcl:1006
 msgid "Open"
 msgstr "$B3+$/(B"

-#: lib/choose_repository.tcl:1021
+#: lib/choose_repository.tcl:1016
 msgid "Repository:"
 msgstr "$B%j%]%8%H%j(B:"

-#: lib/choose_repository.tcl:1072
+#: lib/choose_repository.tcl:1065
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "$B%j%]%8%H%j(B %s $B$r3+$1$^$;$s(B:"

-#: lib/choose_rev.tcl:53
+#: lib/choose_rev.tcl:52
 msgid "This Detached Checkout"
 msgstr "$BJ,N%$5$l$?%A%'%C%/%"%&%H(B"

@@ -1278,36 +1296,36 @@ msgstr "$BJ,N%$5$l$?%A%'%C%/%"%&%H(B"
 msgid "Revision Expression:"
 msgstr "$B%j%S%8%g%s<0(B:"

-#: lib/choose_rev.tcl:74
+#: lib/choose_rev.tcl:72
 msgid "Local Branch"
 msgstr "$B%m!<%+%k!&%V%i%s%A(B"

-#: lib/choose_rev.tcl:79
+#: lib/choose_rev.tcl:77
 msgid "Tracking Branch"
 msgstr "$B%H%i%C%-%s%0!&%V%i%s%A(B"

-#: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
+#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
 msgid "Tag"
 msgstr "$B%?%0(B"

-#: lib/choose_rev.tcl:317
+#: lib/choose_rev.tcl:321
 #, tcl-format
 msgid "Invalid revision: %s"
 msgstr "$BL58z$J%j%S%8%g%s(B: %s"

-#: lib/choose_rev.tcl:338
+#: lib/choose_rev.tcl:342
 msgid "No revision selected."
 msgstr "$B%j%S%8%g%s$,L$A*Br$G$9!#(B"

-#: lib/choose_rev.tcl:346
+#: lib/choose_rev.tcl:350
 msgid "Revision expression is empty."
 msgstr "$B%j%S%8%g%s<0$,6u$G$9!#(B"

-#: lib/choose_rev.tcl:531
+#: lib/choose_rev.tcl:537
 msgid "Updated"
 msgstr "$B99?7$7$^$7$?(B"

-#: lib/choose_rev.tcl:559
+#: lib/choose_rev.tcl:565
 msgid "URL"
 msgstr "URL"

@@ -1320,8 +1338,7 @@ msgid ""
 msgstr ""
 "$BD{@5$9$k%3%_%C%H$,$=$b$=$b$"$j$^$;$s!#(B\n"
 "\n"
-"$B$3$l$+$i:n$k$N$O:G=i$N%3%_%C%H$G$9!#$=$NA0$K$O$^$@D{@5$9$k$h$&$J%3%_%C%H$O$"(B"
-"$B$j$^$;$s!#(B\n"
+"$B$3$l$+$i:n$k$N$O:G=i$N%3%_%C%H$G$9!#$=$NA0$K$O$^$@D{@5$9$k$h$&$J%3%_%C%H$O$"$j$^$;$s!#(B\n"

 #: lib/commit.tcl:18
 msgid ""
@@ -1333,8 +1350,7 @@ msgid ""
 msgstr ""
 "$B%^!<%8Cf$K%3%_%C%H$ND{@5$O$G$-$^$;$s!#(B\n"
 "\n"
-"$B8=:_$O$^$@%^!<%8$NESCf$G$9!#@h$K$3$N%^!<%8$rCf;_$7$J$$$H!"A0$N%3%_%C%H$ND{@5(B"
-"$B$O$G$-$^$;$s(B\n"
+"$B8=:_$O$^$@%^!<%8$NESCf$G$9!#@h$K$3$N%^!<%8$rCf;_$7$J$$$H!"A0$N%3%_%C%H$ND{@5$O$G$-$^$;$s(B\n"

 #: lib/commit.tcl:48
 msgid "Error loading commit data for amend:"
@@ -1364,12 +1380,11 @@ msgid ""
 msgstr ""
 "$B:G8e$K%9%-%c%s$7$?>uBV$O%j%]%8%H%j$N>uBV$H9gCW$7$^$;$s!#(B\n"
 "\n"
-"$B:G8e$K%9%-%c%s$7$F0J8e!"JL$N(B Git $B%W%m%0%i%`$,%j%]%8%H%j$rJQ99$7$F$$$^$9!#?7$7(B"
-"$B$/%3%_%C%H$9$kA0$K!":F%9%-%c%s$,I,MW$G$9!#(B\n"
+"$B:G8e$K%9%-%c%s$7$F0J8e!"JL$N(B Git $B%W%m%0%i%`$,%j%]%8%H%j$rJQ99$7$F$$$^$9!#?7$7$/%3%_%C%H$9$kA0$K!":F%9%-%c%s$,I,MW$G$9!#(B\n"
 "\n"
 "$B<+F0E*$K:F%9%-%c%s$r3+;O$7$^$9!#(B\n"

-#: lib/commit.tcl:172
+#: lib/commit.tcl:173
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1379,10 +1394,9 @@ msgid ""
 msgstr ""
 "$B%^!<%8$7$F$$$J$$%U%!%$%k$O%3%_%C%H$G$-$^$;$s!#(B\n"
 "\n"
-"$B%U%!%$%k(B %s $B$K$O%^!<%8>WFM$,;D$C$F$$$^$9!#$^$:2r7h$7$F%3%_%C%HM=Dj$K2C$($kI,(B"
-"$BMW$,$"$j$^$9!#(B\n"
+"$B%U%!%$%k(B %s $B$K$O%^!<%8>WFM$,;D$C$F$$$^$9!#$^$:2r7h$7$F%3%_%C%HM=Dj$K2C$($kI,MW$,$"$j$^$9!#(B\n"

-#: lib/commit.tcl:180
+#: lib/commit.tcl:181
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1393,7 +1407,7 @@ msgstr ""
 "\n"
 "$B%U%!%$%k(B %s $B$OK\%W%m%0%i%`$G$O%3%_%C%H$G$-$^$;$s!#(B\n"

-#: lib/commit.tcl:188
+#: lib/commit.tcl:189
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1403,7 +1417,7 @@ msgstr ""
 "\n"
 "$B:GDc0l$D$NJQ99$r%3%_%C%HM=Dj$K2C$($F$+$i%3%_%C%H$7$F2<$5$$!#(B\n"

-#: lib/commit.tcl:203
+#: lib/commit.tcl:204
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1421,40 +1435,55 @@ msgstr ""
 "- $BBh#29T(B: $B6uGr(B\n"
 "- $B;D$j$N9T(B: $B$J$<!"$3$NJQ99$,NI$$JQ99$+!"$N@bL@!#(B\n"

-#: lib/commit.tcl:234
+#: lib/commit.tcl:235
 msgid "Calling pre-commit hook..."
 msgstr "$B%3%_%C%HA0%U%C%/$r<B9TCf!&!&!&(B"

-#: lib/commit.tcl:249
+#: lib/commit.tcl:250
 msgid "Commit declined by pre-commit hook."
 msgstr "$B%3%_%C%HA0%U%C%/$,%3%_%C%H$r5qH]$7$^$7$?(B"

-#: lib/commit.tcl:272
+#: lib/commit.tcl:269
+msgid ""
+"You are about to commit on a detached head. This is a potentially dangerous "
+"thing to do because if you switch to another branch you will lose your "
+"changes and it can be difficult to retrieve them later from the reflog. You "
+"should probably cancel this commit and create a new branch to continue.\n"
+" \n"
+" Do you really want to proceed with your Commit?"
+msgstr ""
+"$B$"$J$?$O(Bdetached "
+"head$B>uBV$G%3%_%C%H$7$h$&$H$7$F$$$^$9!#$3$l$O4m81$JA`:n$G$9!#$b$7B39T$9$l$P!"B>%V%i%s%A$X@Z$jBX$($?:]$KJQ99$r<:$C$?$j!"(Breflog$B$GJQ99$rI|85$9$k$3$H$,:$Fq$K$J$j$^$9!#$"$J$?$O<!$NA`:n$r$9$k$Y$-$G$9!#(B1.
"
+"$B$3$N%3%_%C%H$r%-%c%s%;%k$9$k!#(B2. $B?7$7$$%V%i%s%A$r:n$j!"%3%_%C%H$7D>$9!#(B\n"
+"\n"
+"$BK\Ev$K$3$N4m81$J%3%_%C%H$r<B9T$7$^$9$+!)(B"
+
+#: lib/commit.tcl:290
 msgid "Calling commit-msg hook..."
 msgstr "$B%3%_%C%H!&%a%C%;!<%8!&%U%C%/$r<B9TCf!&!&!&(B"

-#: lib/commit.tcl:287
+#: lib/commit.tcl:305
 msgid "Commit declined by commit-msg hook."
 msgstr "$B%3%_%C%H!&%a%C%;!<%8!&%U%C%/$,%3%_%C%H$r5qH]$7$^$7$?(B"

-#: lib/commit.tcl:300
+#: lib/commit.tcl:318
 msgid "Committing changes..."
 msgstr "$BJQ99E@$r%3%_%C%HCf!&!&!&(B"

-#: lib/commit.tcl:316
+#: lib/commit.tcl:334
 msgid "write-tree failed:"
 msgstr "write-tree $B$,<:GT$7$^$7$?(B:"

-#: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
+#: lib/commit.tcl:335 lib/commit.tcl:379 lib/commit.tcl:400
 msgid "Commit failed."
 msgstr "$B%3%_%C%H$K<:GT$7$^$7$?!#(B"

-#: lib/commit.tcl:334
+#: lib/commit.tcl:352
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "$B%3%_%C%H(B %s $B$O2u$l$F$$$^$9(B"

-#: lib/commit.tcl:339
+#: lib/commit.tcl:357
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1468,19 +1497,19 @@ msgstr ""
 "\n"
 "$B<+F0E*$K:F%9%-%c%s$r3+;O$7$^$9!#(B\n"

-#: lib/commit.tcl:346
+#: lib/commit.tcl:364
 msgid "No changes to commit."
 msgstr "$B%3%_%C%H$9$kJQ99$,$"$j$^$;$s!#(B"

-#: lib/commit.tcl:360
+#: lib/commit.tcl:378
 msgid "commit-tree failed:"
 msgstr "commit-tree $B$,<:GT$7$^$7$?(B:"

-#: lib/commit.tcl:381
+#: lib/commit.tcl:399
 msgid "update-ref failed:"
 msgstr "update-ref $B$,<:GT$7$^$7$?(B:"

-#: lib/commit.tcl:469
+#: lib/commit.tcl:492
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr "$B%3%_%C%H(B %s $B$r:n@.$7$^$7$?(B: %s"
@@ -1497,31 +1526,31 @@ msgstr "$B@.8y(B"
 msgid "Error: Command Failed"
 msgstr "$B%(%i!<(B: $B%3%^%s%I$,<:GT$7$^$7$?(B"

-#: lib/database.tcl:43
+#: lib/database.tcl:42
 msgid "Number of loose objects"
 msgstr "$B$P$i$P$i$J%*%V%8%'%/%H$N?t(B"

-#: lib/database.tcl:44
+#: lib/database.tcl:43
 msgid "Disk space used by loose objects"
 msgstr "$B$P$i$P$i$J%*%V%8%'%/%H$N;HMQ$9$k%G%#%9%/NL(B"

-#: lib/database.tcl:45
+#: lib/database.tcl:44
 msgid "Number of packed objects"
 msgstr "$B%Q%C%/$5$l$?%*%V%8%'%/%H$N?t(B"

-#: lib/database.tcl:46
+#: lib/database.tcl:45
 msgid "Number of packs"
 msgstr "$B%Q%C%/$N?t(B"

-#: lib/database.tcl:47
+#: lib/database.tcl:46
 msgid "Disk space used by packed objects"
 msgstr "$B%Q%C%/$5$l$?%*%V%8%'%/%H$N;HMQ$9$k%G%#%9%/NL(B"

-#: lib/database.tcl:48
+#: lib/database.tcl:47
 msgid "Packed objects waiting for pruning"
 msgstr "$B%Q%C%/$KB8:_$9$k$N$G<N$F$FNI$$%*%V%8%'%/%H$N?t(B"

-#: lib/database.tcl:49
+#: lib/database.tcl:48
 msgid "Garbage files"
 msgstr "$B%4%_%U%!%$%k(B"

@@ -1571,8 +1600,7 @@ msgstr ""
 "\n"
 "%s $B$K$OJQ99$,$"$j$^$;$s!#(B\n"
 "\n"
-"$B$3$N%U%!%$%k$NJQ99;~9o$OB>$N%"%W%j%1!<%7%g%s$K$h$C$F99?7$5$l$F$$$^$9$,%U%!%$(B"
-"$B%kFbMF$K$OJQ99$,$"$j$^$;$s!#(B\n"
+"$B$3$N%U%!%$%k$NJQ99;~9o$OB>$N%"%W%j%1!<%7%g%s$K$h$C$F99?7$5$l$F$$$^$9$,%U%!%$%kFbMF$K$OJQ99$,$"$j$^$;$s!#(B\n"
 "\n"
 "$BF1MM$J>uBV$N%U%!%$%k$rC5$9$?$a$K!"<+F0E*$K:F%9%-%c%s$r3+;O$7$^$9!#(B"

@@ -1605,7 +1633,7 @@ msgstr "LOCAL:\n"
 msgid "REMOTE:\n"
 msgstr "REMOTE\n"

-#: lib/diff.tcl:202 lib/diff.tcl:319
+#: lib/diff.tcl:202 lib/diff.tcl:337
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "%s $B$rI=<($G$-$^$;$s(B"
@@ -1643,19 +1671,19 @@ msgstr ""
 "* %s $B$O4IM}30$N%U%!%$%k$r$3$3$G@Z$j$*$H$7$^$7$?!#(B\n"
 "* $BA4BN$r8+$k$K$O30It%(%G%#%?$r;H$C$F$/$@$5$$!#(B\n"

-#: lib/diff.tcl:482
+#: lib/diff.tcl:557
 msgid "Failed to unstage selected hunk."
 msgstr "$BA*Br$5$l$?%Q%C%A$r%3%_%C%HM=Dj$+$i30$;$^$;$s!#(B"

-#: lib/diff.tcl:489
+#: lib/diff.tcl:564
 msgid "Failed to stage selected hunk."
 msgstr "$BA*Br$5$l$?%Q%C%A$r%3%_%C%HM=Dj$K2C$($i$l$^$;$s!#(B"

-#: lib/diff.tcl:568
+#: lib/diff.tcl:643
 msgid "Failed to unstage selected line."
 msgstr "$BA*Br$5$l$?%Q%C%A9T$r%3%_%C%HM=Dj$+$i30$;$^$;$s!#(B"

-#: lib/diff.tcl:576
+#: lib/diff.tcl:651
 msgid "Failed to stage selected line."
 msgstr "$BA*Br$5$l$?%Q%C%A9T$r%3%_%C%HM=Dj$K2C$($i$l$^$;$s!#(B"

@@ -1672,7 +1700,7 @@ msgstr "$B%7%9%F%`(B (%s)"
 msgid "Other"
 msgstr "$B$=$NB>(B"

-#: lib/error.tcl:20 lib/error.tcl:114
+#: lib/error.tcl:20 lib/error.tcl:116
 msgid "error"
 msgstr "$B%(%i!<(B"

@@ -1680,7 +1708,7 @@ msgstr "$B%(%i!<(B"
 msgid "warning"
 msgstr "$B7Y9p(B"

-#: lib/error.tcl:94
+#: lib/error.tcl:96
 msgid "You must correct the above errors before committing."
 msgstr "$B%3%_%C%H$9$kA0$K!"0J>e$N%(%i!<$r=$@5$7$F2<$5$$(B"

@@ -1688,67 +1716,78 @@ msgstr "$B%3%_%C%H$9$kA0$K!"0J>e$N%(%i!<$r=$@5$7$F2<$5$$(B"
 msgid "Unable to unlock the index."
 msgstr "$B%$%s%G%C%/%9$r%m%C%/$G$-$^$;$s(B"

-#: lib/index.tcl:15
+#: lib/index.tcl:17
 msgid "Index Error"
 msgstr "$B:w0z%(%i!<(B"

-#: lib/index.tcl:17
+#: lib/index.tcl:19
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically started to "
 "resynchronize git-gui."
-msgstr ""
-"GIT $B%$%s%G%C%/%9$N99?7$,<:GT$7$^$7$?!#(Bgit-gui $B$HF14|$r$H$k$?$a$K:F%9%-%c%s$7(B"
-"$B$^$9!#(B"
+msgstr "GIT $B%$%s%G%C%/%9$N99?7$,<:GT$7$^$7$?!#(Bgit-gui $B$HF14|$r$H$k$?$a$K:F%9%-%c%s$7$^$9!#(B"

-#: lib/index.tcl:28
+#: lib/index.tcl:30
 msgid "Continue"
 msgstr "$BB39T(B"

-#: lib/index.tcl:31
+#: lib/index.tcl:33
 msgid "Unlock Index"
 msgstr "$B%$%s%G%C%/%9$N%m%C%/2r=|(B"

-#: lib/index.tcl:289
+#: lib/index.tcl:298
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "$B%3%_%C%H$+$i(B '%s' $B$r9_$m$9(B"

-#: lib/index.tcl:328
+#: lib/index.tcl:337
 msgid "Ready to commit."
 msgstr "$B%3%_%C%H=`Hw40N;(B"

-#: lib/index.tcl:341
+#: lib/index.tcl:350
 #, tcl-format
 msgid "Adding %s"
 msgstr "$B%3%_%C%H$K(B %s $B$r2C$($F$$$^$9(B"

-#: lib/index.tcl:398
+#: lib/index.tcl:380
+#, tcl-format
+msgid "Stage %d untracked files?"
+msgstr "%d $B8D$N?75,%U%!%$%k$,$"$j$^$9!#%3%_%C%HM=Dj$7$F$b$$$$$G$9$+!)(B"
+
+#: lib/index.tcl:428
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "$B%U%!%$%k(B %s $B$K$7$?JQ99$r85$KLa$7$^$9$+!)(B"

-#: lib/index.tcl:400
+#: lib/index.tcl:430
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "$B$3$l$i(B %i $B8D$N%U%!%$%k$K$7$?JQ99$r85$KLa$7$^$9$+!)(B"

-#: lib/index.tcl:408
+#: lib/index.tcl:438
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr "$BJQ99$r85$KLa$9$H%3%_%C%HM=Dj$7$F$$$J$$JQ99$OA4$F<:$o$l$^$9!#(B"

-#: lib/index.tcl:411
+#: lib/index.tcl:441
 msgid "Do Nothing"
 msgstr "$B2?$b$7$J$$(B"

-#: lib/index.tcl:429
+#: lib/index.tcl:459
 msgid "Reverting selected files"
 msgstr "$BA*Br$5$l$?%U%!%$%k$K$7$?JQ99$r85$KLa$7$^$9(B"

-#: lib/index.tcl:433
+#: lib/index.tcl:463
 #, tcl-format
 msgid "Reverting %s"
 msgstr "%s $B$K$7$?JQ99$r85$KLa$7$^$9(B"

+#: lib/line.tcl:17
+msgid "Goto Line:"
+msgstr "$B;XDj9T$X0\F0(B:"
+
+#: lib/line.tcl:23
+msgid "Go"
+msgstr "$B0\F0(B"
+
 #: lib/merge.tcl:13
 msgid ""
 "Cannot merge while amending.\n"
@@ -1770,8 +1809,7 @@ msgid ""
 msgstr ""
 "$B:G8e$K%9%-%c%s$7$?>uBV$O%j%]%8%H%j$N>uBV$H9gCW$7$^$;$s!#(B\n"
 "\n"
-"$B:G8e$K%9%-%c%s$7$F0J8e!"JL$N(B Git $B%W%m%0%i%`$,%j%]%8%H%j$rJQ99$7$F$$$^$9!#%^!<(B"
-"$B%8$r3+;O$9$kA0$K!":F%9%-%c%s$,I,MW$G$9!#(B\n"
+"$B:G8e$K%9%-%c%s$7$F0J8e!"JL$N(B Git $B%W%m%0%i%`$,%j%]%8%H%j$rJQ99$7$F$$$^$9!#%^!<%8$r3+;O$9$kA0$K!":F%9%-%c%s$,I,MW$G$9!#(B\n"
 "\n"
 "$B<+F0E*$K:F%9%-%c%s$r3+;O$7$^$9!#(B\n"

@@ -1789,8 +1827,7 @@ msgstr ""
 "\n"
 "$B%U%!%$%k(B %s $B$K$O%^!<%8Cf$N>WFM$,;D$C$F$$$^$9!#(B\n"
 "\n"
-"$B$3$N%U%!%$%k$N>WFM$r2r7h$7!"%3%_%C%HM=Dj$K2C$($F!"%3%_%C%H$9$k$3$H$G%^!<%8$r(B"
-"$B40N;$7$^$9!#$=$&$d$C$F;O$a$F!"?7$?$J%^!<%8$r3+;O$G$-$k$h$&$K$J$j$^$9!#(B\n"
+"$B$3$N%U%!%$%k$N>WFM$r2r7h$7!"%3%_%C%HM=Dj$K2C$($F!"%3%_%C%H$9$k$3$H$G%^!<%8$r40N;$7$^$9!#$=$&$d$C$F;O$a$F!"?7$?$J%^!<%8$r3+;O$G$-$k$h$&$K$J$j$^$9!#(B\n"

 #: lib/merge.tcl:55
 #, tcl-format
@@ -1806,37 +1843,36 @@ msgstr ""
 "\n"
 "$B%U%!%$%k(B %s $B$OJQ99Cf$G$9!#(B\n"
 "\n"
-"$B8=:_$N%3%_%C%H$r40N;$7$F$+$i%^!<%8$r3+;O$7$F2<$5$$!#$=$&$9$kJ}$,%^!<%8$K<:GT(B"
-"$B$7$?$H$-$N2sI|$,3Z$G$9!#(B\n"
+"$B8=:_$N%3%_%C%H$r40N;$7$F$+$i%^!<%8$r3+;O$7$F2<$5$$!#$=$&$9$kJ}$,%^!<%8$K<:GT$7$?$H$-$N2sI|$,3Z$G$9!#(B\n"

-#: lib/merge.tcl:107
+#: lib/merge.tcl:108
 #, tcl-format
 msgid "%s of %s"
 msgstr "%s $B$N(B %s $B%V%i%s%A(B"

-#: lib/merge.tcl:120
+#: lib/merge.tcl:122
 #, tcl-format
 msgid "Merging %s and %s..."
 msgstr "%s $B$H(B %s $B$r%^!<%8Cf!&!&!&(B"

-#: lib/merge.tcl:131
+#: lib/merge.tcl:133
 msgid "Merge completed successfully."
 msgstr "$B%^!<%8$,40N;$7$^$7$?(B"

-#: lib/merge.tcl:133
+#: lib/merge.tcl:135
 msgid "Merge failed.  Conflict resolution is required."
 msgstr "$B%^!<%8$,<:GT$7$^$7$?!#>WFM$N2r7h$,I,MW$G$9!#(B"

-#: lib/merge.tcl:158
+#: lib/merge.tcl:160
 #, tcl-format
 msgid "Merge Into %s"
 msgstr "%s $B$K%^!<%8(B"

-#: lib/merge.tcl:177
+#: lib/merge.tcl:179
 msgid "Revision To Merge"
 msgstr "$B%^!<%8$9$k%j%S%8%g%s(B"

-#: lib/merge.tcl:212
+#: lib/merge.tcl:214
 msgid ""
 "Cannot abort while amending.\n"
 "\n"
@@ -1846,7 +1882,7 @@ msgstr ""
 "\n"
 "$B$^$::#$N%3%_%C%HD{@5$r40N;$5$;$F2<$5$$!#(B\n"

-#: lib/merge.tcl:222
+#: lib/merge.tcl:224
 msgid ""
 "Abort merge?\n"
 "\n"
@@ -1860,7 +1896,7 @@ msgstr ""
 "\n"
 "$B%^!<%8$rCfCG$7$F$h$m$7$$$G$9$+!)(B"

-#: lib/merge.tcl:228
+#: lib/merge.tcl:230
 msgid ""
 "Reset changes?\n"
 "\n"
@@ -1874,19 +1910,19 @@ msgstr ""
 "\n"
 "$B%j%;%C%H$7$F$h$m$7$$$G$9$+!)(B"

-#: lib/merge.tcl:239
+#: lib/merge.tcl:241
 msgid "Aborting"
 msgstr "$BCfCG$7$F$$$^$9(B"

-#: lib/merge.tcl:239
+#: lib/merge.tcl:241
 msgid "files reset"
 msgstr "$B%j%;%C%H$7$?%U%!%$%k(B"

-#: lib/merge.tcl:267
+#: lib/merge.tcl:269
 msgid "Abort failed."
 msgstr "$BCfCG$K<:GT$7$^$7$?!#(B"

-#: lib/merge.tcl:269
+#: lib/merge.tcl:271
 msgid "Abort completed.  Ready."
 msgstr "$BCfCG40N;!#(B"

@@ -1920,8 +1956,7 @@ msgstr ""
 #: lib/mergetool.tcl:45
 #, tcl-format
 msgid "File %s seems to have unresolved conflicts, still stage?"
-msgstr ""
-"$B%U%!%$%k(B %s $B$K$O2r7h$7$F$$$J$$6%9gItJ,$,$^$@$"$k$h$&$G$9$,!"$$$$$G$9$+(B?"
+msgstr "$B%U%!%$%k(B %s $B$K$O2r7h$7$F$$$J$$6%9gItJ,$,$^$@$"$k$h$&$G$9$,!"$$$$$G$9$+(B?"

 #: lib/mergetool.tcl:60
 #, tcl-format
@@ -1936,21 +1971,21 @@ msgstr "$B%D!<%k$G$O:o=|$d%j%s%/6%9g$O07$($^$;$s(B"
 msgid "Conflict file does not exist"
 msgstr "$B6%9g%U%!%$%k$OB8:_$7$^$;$s!#(B"

-#: lib/mergetool.tcl:264
+#: lib/mergetool.tcl:246
 #, tcl-format
 msgid "Not a GUI merge tool: '%s'"
 msgstr "GUI $B%^!<%8%D!<%k$G$O$"$j$^$;$s(B: %s"

-#: lib/mergetool.tcl:268
+#: lib/mergetool.tcl:275
 #, tcl-format
 msgid "Unsupported merge tool '%s'"
 msgstr "$B%^!<%8%D!<%k(B '%s' $B$O%5%]!<%H$7$F$$$^$;$s(B"

-#: lib/mergetool.tcl:303
+#: lib/mergetool.tcl:310
 msgid "Merge tool is already running, terminate it?"
 msgstr "$B%^!<%8%D!<%k$O$9$G$K5/F0$7$F$$$^$9!#=*N;$7$^$9$+(B?"

-#: lib/mergetool.tcl:323
+#: lib/mergetool.tcl:330
 #, tcl-format
 msgid ""
 "Error retrieving versions:\n"
@@ -1959,7 +1994,7 @@ msgstr ""
 "$BHG$N<h$j=P$7;~$K%(%i!<$,=P$^$7$?(B:\n"
 "%s"

-#: lib/mergetool.tcl:343
+#: lib/mergetool.tcl:350
 #, tcl-format
 msgid ""
 "Could not start the merge tool:\n"
@@ -1970,11 +2005,11 @@ msgstr ""
 "\n"
 "%s"

-#: lib/mergetool.tcl:347
+#: lib/mergetool.tcl:354
 msgid "Running merge tool..."
 msgstr "$B%^!<%8%D!<%k$r<B9T$7$F$$$^$9(B..."

-#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
+#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
 msgid "Merge tool failed."
 msgstr "$B%^!<%8%D!<%k$,<:GT$7$^$7$?!#(B"

@@ -1988,145 +2023,157 @@ msgstr "$BA4BN%(%s%3!<%G%#%s%0$K(B $BL58z$J(B %s $B$,;XDj$5$l$F$$$^(B
 msgid "Invalid repo encoding '%s'"
 msgstr "$B%j%]%8%H%j%(%s%3!<%G%#%s%0$K(B $BL58z$J(B %s $B$,;XDj$5$l$F$$$^$9(B"

-#: lib/option.tcl:117
+#: lib/option.tcl:119
 msgid "Restore Defaults"
 msgstr "$B4{DjCM$KLa$9(B"

-#: lib/option.tcl:121
+#: lib/option.tcl:123
 msgid "Save"
 msgstr "$BJ]B8(B"

-#: lib/option.tcl:131
+#: lib/option.tcl:133
 #, tcl-format
 msgid "%s Repository"
 msgstr "%s $B%j%]%8%H%j(B"

-#: lib/option.tcl:132
+#: lib/option.tcl:134
 msgid "Global (All Repositories)"
-msgstr "$BBg0h!JA4$F$N%j%]%8%H%j!K(B"
+msgstr "$BI8=`@_Dj!JA4$F$N%j%]%8%H%j!K(B"

-#: lib/option.tcl:138
+#: lib/option.tcl:140
 msgid "User Name"
 msgstr "$B%f!<%6L>(B"

-#: lib/option.tcl:139
+#: lib/option.tcl:141
 msgid "Email Address"
 msgstr "$BEE;R%a!<%k%"%I%l%9(B"

-#: lib/option.tcl:141
+#: lib/option.tcl:143
 msgid "Summarize Merge Commits"
-msgstr "$B%^!<%8%3%_%C%H$NMWLs(B"
+msgstr "$B%^!<%8%3%_%C%H$NMWLs(B (--summary)"

-#: lib/option.tcl:142
+#: lib/option.tcl:144
 msgid "Merge Verbosity"
-msgstr "$B%^!<%8$N>iD9EY(B"
+msgstr "$B%^!<%8$N%(%i!<=PNO%l%Y%k(B (0-5, $BI8=`(B2$B!":G9b(B5)(merge.verbosity)"

-#: lib/option.tcl:143
+#: lib/option.tcl:145
 msgid "Show Diffstat After Merge"
-msgstr "$B%^!<%88e$K(B diffstat $B$rI=<((B"
+msgstr "$B%^!<%88e$KJQ99NL$N%0%i%U$rI=<((B (git diff --stat)"

-#: lib/option.tcl:144
+#: lib/option.tcl:146
 msgid "Use Merge Tool"
 msgstr "$B%^!<%8%D!<%k$r;HMQ(B"

-#: lib/option.tcl:146
+#: lib/option.tcl:148
 msgid "Trust File Modification Timestamps"
 msgstr "$B%U%!%$%kJQ99;~9o$r?.Mj$9$k(B"

-#: lib/option.tcl:147
+#: lib/option.tcl:149
 msgid "Prune Tracking Branches During Fetch"
-msgstr "$B%U%'%C%ACf$K%H%i%C%-%s%0%V%i%s%A$r4"$k(B"
+msgstr "$B%j%b!<%H$+$iJQ99<hF@(B (fetch) $B$7$?$H$-!"%j%b!<%H$G:o=|:Q$_$N%V%i%s%A$r:o=|$9$k(B"

-#: lib/option.tcl:148
+#: lib/option.tcl:150
 msgid "Match Tracking Branches"
 msgstr "$B%H%i%C%-%s%0%V%i%s%A$r9g$o$;$k(B"

-#: lib/option.tcl:149
+#: lib/option.tcl:151
+msgid "Use Textconv For Diffs and Blames"
+msgstr "Diff$B$H(BBlame$B$G(BTextConv$B$r;HMQ$9$k(B"
+
+#: lib/option.tcl:152
 msgid "Blame Copy Only On Changed Files"
 msgstr "$BJQ99$5$l$?%U%!%$%k$N$_%3%T!<8!CN$r9T$J$&(B"

-#: lib/option.tcl:150
+#: lib/option.tcl:153
 msgid "Minimum Letters To Blame Copy On"
-msgstr "$B%3%T!<$r8!CN$9$k:G>/J8;z?t(B"
+msgstr "$BB>%U%!%$%k$+$i0\F0(B/$B%3%T!<$r8!CN$9$k:G>/J8;z?t(B ($BI8=`CM(B40)"

-#: lib/option.tcl:151
+#: lib/option.tcl:154
 msgid "Blame History Context Radius (days)"
-msgstr "$BCp<a$9$kMzNrH>7B!JF|?t!K(B"
+msgstr "Blame$B$NI=<(HO0O!JA08eF|?t!K(B"

-#: lib/option.tcl:152
+#: lib/option.tcl:155
 msgid "Number of Diff Context Lines"
-msgstr "diff $B$NJ8L.9T?t(B"
+msgstr "$B:9J,I=<($GI=<($9$kL$JQ999T?t(B ($BJQ999T$NA0(Bx$B9T!"8e(Bx$B9T$NL$JQ999T$rI=<((B)"

-#: lib/option.tcl:153
+#: lib/option.tcl:156
+msgid "Additional Diff Parameters"
+msgstr "Diff$B$NDI2C%Q%i%a!<%?(B"
+
+#: lib/option.tcl:157
 msgid "Commit Message Text Width"
 msgstr "$B%3%_%C%H%a%C%;!<%8$N%F%-%9%HI}(B"

-#: lib/option.tcl:154
+#: lib/option.tcl:158
 msgid "New Branch Name Template"
 msgstr "$B?7$7$$%V%i%s%AL>$N%F%s%W%l!<%H(B"

-#: lib/option.tcl:155
+#: lib/option.tcl:159
 msgid "Default File Contents Encoding"
-msgstr "$B%U%!%$%kFbMF$N%G%U%)!<%k%H%(%s%3!<%G%#%s%0(B"
+msgstr "$B%U%!%$%kFbMF$N%G%U%)%k%HJ8;z%3!<%I(B"
+
+#: lib/option.tcl:160
+msgid "Warn before committing to a detached head"
+msgstr "detached head$B>uBV$G%3%_%C%H$9$kA0$K7Y9p$9$k(B"

-#: lib/option.tcl:203
+#: lib/option.tcl:161
+msgid "Staging of untracked files"
+msgstr "$BDI2C$5$l$?%U%!%$%k$r%3%_%C%HM=Dj$9$k(B"
+
+#: lib/option.tcl:161
+msgid "yes"
+msgstr "$B>o$KF~$l$k(B"
+
+#: lib/option.tcl:161
+msgid "no"
+msgstr "$B>o$KF~$l$J$$(B"
+
+#: lib/option.tcl:161
+msgid "ask"
+msgstr "$BKh2s3NG'(B"
+
+#: lib/option.tcl:207
 msgid "Change"
 msgstr "$BJQ99(B"

-#: lib/option.tcl:230
+#: lib/option.tcl:251
 msgid "Spelling Dictionary:"
 msgstr "$B%9%Z%k%A%'%C%/<-=q(B"

-#: lib/option.tcl:254
+#: lib/option.tcl:281
 msgid "Change Font"
 msgstr "$B%U%)%s%H$rJQ99(B"

-#: lib/option.tcl:258
+#: lib/option.tcl:285
 #, tcl-format
 msgid "Choose %s"
 msgstr "%s $B$rA*Br(B"

-#: lib/option.tcl:264
+#: lib/option.tcl:291
 msgid "pt."
 msgstr "$B%]%$%s%H(B"

-#: lib/option.tcl:278
+#: lib/option.tcl:305
 msgid "Preferences"
 msgstr "$B@_Dj(B"

-#: lib/option.tcl:314
+#: lib/option.tcl:342
 msgid "Failed to completely save options:"
 msgstr "$B40A4$K%*%W%7%g%s$rJ]B8$G$-$^$;$s(B:"

-#: lib/remote.tcl:163
-msgid "Remove Remote"
-msgstr "$B%j%b!<%H$r:o=|(B"
-
-#: lib/remote.tcl:168
-msgid "Prune from"
-msgstr "$B$+$i4"9~$`!D(B"
-
-#: lib/remote.tcl:173
-msgid "Fetch from"
-msgstr "$B<hF@85(B"
-
-#: lib/remote.tcl:215
-msgid "Push to"
-msgstr "$B%W%C%7%e@h(B"
-
-#: lib/remote_add.tcl:19
+#: lib/remote_add.tcl:20
 msgid "Add Remote"
 msgstr "$B%j%b!<%H$rDI2C(B"

-#: lib/remote_add.tcl:24
+#: lib/remote_add.tcl:25
 msgid "Add New Remote"
 msgstr "$B%j%b!<%H$r?75,$KDI2C(B"

-#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
+#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
 msgid "Add"
 msgstr "$BDI2C(B"

-#: lib/remote_add.tcl:37
+#: lib/remote_add.tcl:39
 msgid "Remote Details"
 msgstr "$B%j%b!<%H$N>\:Y(B"

@@ -2134,58 +2181,58 @@ msgstr "$B%j%b!<%H$N>\:Y(B"
 msgid "Location:"
 msgstr "$B>l=j(B:"

-#: lib/remote_add.tcl:62
+#: lib/remote_add.tcl:60
 msgid "Further Action"
 msgstr "$B$=$NB>$NF0:n(B"

-#: lib/remote_add.tcl:65
+#: lib/remote_add.tcl:63
 msgid "Fetch Immediately"
 msgstr "$BB(:B$K<hF@(B"

-#: lib/remote_add.tcl:71
+#: lib/remote_add.tcl:69
 msgid "Initialize Remote Repository and Push"
 msgstr "$B%j%b!<%H%l%]%8%H%j$r=i4|2=$7$F%W%C%7%e(B"

-#: lib/remote_add.tcl:77
+#: lib/remote_add.tcl:75
 msgid "Do Nothing Else Now"
 msgstr "$B2?$b$7$J$$(B"

-#: lib/remote_add.tcl:101
+#: lib/remote_add.tcl:100
 msgid "Please supply a remote name."
 msgstr "$B%j%b!<%HL>$r;XDj$7$F2<$5$$!#(B"

-#: lib/remote_add.tcl:114
+#: lib/remote_add.tcl:113
 #, tcl-format
 msgid "'%s' is not an acceptable remote name."
 msgstr "'%s' $B$O%j%b!<%HL>$K;H$($^$;$s!#(B"

-#: lib/remote_add.tcl:125
+#: lib/remote_add.tcl:124
 #, tcl-format
 msgid "Failed to add remote '%s' of location '%s'."
 msgstr "$B>l=j(B '%2$s' $B$N%j%b!<%H(B '%1$s'$B$NL>A0JQ99$K<:GT$7$^$7$?!#(B"

-#: lib/remote_add.tcl:133 lib/transport.tcl:6
+#: lib/remote_add.tcl:132 lib/transport.tcl:6
 #, tcl-format
 msgid "fetch %s"
 msgstr "%s $B$r<hF@(B"

-#: lib/remote_add.tcl:134
+#: lib/remote_add.tcl:133
 #, tcl-format
 msgid "Fetching the %s"
 msgstr "%s $B$+$i%U%'%C%A$7$F$$$^$9(B"

-#: lib/remote_add.tcl:157
+#: lib/remote_add.tcl:156
 #, tcl-format
 msgid "Do not know how to initialize repository at location '%s'."
 msgstr "$B%j%]%8%H%j(B '%s' $B$r=i4|2=$G$-$^$;$s!#(B"

-#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
-#: lib/transport.tcl:81
+#: lib/remote_add.tcl:162 lib/transport.tcl:54 lib/transport.tcl:92
+#: lib/transport.tcl:110
 #, tcl-format
 msgid "push %s"
 msgstr "%s $B$r%W%C%7%e(B"

-#: lib/remote_add.tcl:164
+#: lib/remote_add.tcl:163
 #, tcl-format
 msgid "Setting up the %s (at %s)"
 msgstr "%2$s $B$K$"$k(B %1$s $B$r%;%C%H%"%C%W$7$^$9(B"
@@ -2194,35 +2241,35 @@ msgstr "%2$s $B$K$"$k(B %1$s $B$r%;%C%H%"%C%W$7$^$9(B"
 msgid "Delete Branch Remotely"
 msgstr "$B1s3V$G%V%i%s%A:o=|(B"

-#: lib/remote_branch_delete.tcl:47
+#: lib/remote_branch_delete.tcl:48
 msgid "From Repository"
 msgstr "$B85$N%j%]%8%H%j(B"

-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
+#: lib/remote_branch_delete.tcl:51 lib/transport.tcl:165
 msgid "Remote:"
 msgstr "$B%j%b!<%H(B:"

-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
+#: lib/remote_branch_delete.tcl:72 lib/transport.tcl:187
 msgid "Arbitrary Location:"
 msgstr "$BG$0U$N0LCV(B:"

-#: lib/remote_branch_delete.tcl:84
+#: lib/remote_branch_delete.tcl:88
 msgid "Branches"
 msgstr "$B%V%i%s%A(B"

-#: lib/remote_branch_delete.tcl:109
+#: lib/remote_branch_delete.tcl:110
 msgid "Delete Only If"
 msgstr "$B>r7oIU$G:o=|(B"

-#: lib/remote_branch_delete.tcl:111
+#: lib/remote_branch_delete.tcl:112
 msgid "Merged Into:"
 msgstr "$B%^!<%8@h(B:"

-#: lib/remote_branch_delete.tcl:152
+#: lib/remote_branch_delete.tcl:153
 msgid "A branch is required for 'Merged Into'."
 msgstr "'$B%^!<%8@h(B' $B$K$O%V%i%s%A$,I,MW$G$9!#(B"

-#: lib/remote_branch_delete.tcl:184
+#: lib/remote_branch_delete.tcl:185
 #, tcl-format
 msgid ""
 "The following branches are not completely merged into %s:\n"
@@ -2233,48 +2280,66 @@ msgstr ""
 "\n"
 " - %s"

-#: lib/remote_branch_delete.tcl:189
+#: lib/remote_branch_delete.tcl:190
 #, tcl-format
 msgid ""
 "One or more of the merge tests failed because you have not fetched the "
 "necessary commits.  Try fetching from %s first."
-msgstr ""
-"$BI,MW$J%3%_%C%H$,ITB-$7$F$$$k$?$a$K!"%^!<%88!::$,<:GT$7$^$7$?!#$^$:(B %s $B$+$i(B"
-"$B%U%'%C%A$7$F2<$5$$!#(B"
+msgstr "$BI,MW$J%3%_%C%H$,ITB-$7$F$$$k$?$a$K!"%^!<%88!::$,<:GT$7$^$7$?!#$^$:(B %s $B$+$i%U%'%C%A$7$F2<$5$$!#(B"

-#: lib/remote_branch_delete.tcl:207
+#: lib/remote_branch_delete.tcl:208
 msgid "Please select one or more branches to delete."
 msgstr "$B:o=|$9$k%V%i%s%A$rA*Br$7$F2<$5$$!#(B"

-#: lib/remote_branch_delete.tcl:226
+#: lib/remote_branch_delete.tcl:227
 #, tcl-format
 msgid "Deleting branches from %s"
 msgstr "%s $B$+$i%V%i%s%A$r:o=|$7$F$$$^$9!#(B"

-#: lib/remote_branch_delete.tcl:292
+#: lib/remote_branch_delete.tcl:300
 msgid "No repository selected."
 msgstr "$B%j%]%8%H%j$,A*Br$5$l$F$$$^$;$s!#(B"

-#: lib/remote_branch_delete.tcl:297
+#: lib/remote_branch_delete.tcl:305
 #, tcl-format
 msgid "Scanning %s..."
 msgstr "%s $B$r%9%-%c%s$7$F$$$^$9!D(B"

-#: lib/search.tcl:21
+#: lib/remote.tcl:200
+msgid "Push to"
+msgstr "$B%W%C%7%e@h(B"
+
+#: lib/remote.tcl:218
+msgid "Remove Remote"
+msgstr "$B%j%b!<%H$r:o=|(B"
+
+#: lib/remote.tcl:223
+msgid "Prune from"
+msgstr "$B%j%b!<%H$G:o=|:Q%V%i%s%A$r:o=|(B (Prune)"
+
+#: lib/remote.tcl:228
+msgid "Fetch from"
+msgstr "$BJQ99$r<hF@(B (Fetch)"
+
+#: lib/search.tcl:48
 msgid "Find:"
 msgstr "$B8!:w(B:"

-#: lib/search.tcl:23
+#: lib/search.tcl:50
 msgid "Next"
 msgstr "$B<!(B"

-#: lib/search.tcl:24
+#: lib/search.tcl:51
 msgid "Prev"
 msgstr "$BA0(B"

-#: lib/search.tcl:25
-msgid "Case-Sensitive"
-msgstr "$BBgJ8;z>.J8;z$r6hJL(B"
+#: lib/search.tcl:52
+msgid "RegExp"
+msgstr "$B@55,I=8=(B"
+
+#: lib/search.tcl:54
+msgid "Case"
+msgstr "$B>.(B/$BBgJ8;z$r6hJL(B"

 #: lib/shortcut.tcl:21 lib/shortcut.tcl:62
 msgid "Cannot write shortcut:"
@@ -2334,19 +2399,19 @@ msgstr "$B8x3+80$,$"$j$^$7$?(B: %s"
 msgid "Generate Key"
 msgstr "$B80$r@8@.(B"

-#: lib/sshkey.tcl:56
+#: lib/sshkey.tcl:58
 msgid "Copy To Clipboard"
 msgstr "$B%/%j%C%W%\!<%I$K%3%T!<(B"

-#: lib/sshkey.tcl:70
+#: lib/sshkey.tcl:72
 msgid "Your OpenSSH Public Key"
 msgstr "$B$"$J$?$N(B OpenSSH $B8x3+80(B"

-#: lib/sshkey.tcl:78
+#: lib/sshkey.tcl:80
 msgid "Generating..."
 msgstr "$B@8@.Cf(B..."

-#: lib/sshkey.tcl:84
+#: lib/sshkey.tcl:86
 #, tcl-format
 msgid ""
 "Could not start ssh-keygen:\n"
@@ -2357,54 +2422,24 @@ msgstr ""
 "\n"
 "%s"

-#: lib/sshkey.tcl:111
+#: lib/sshkey.tcl:113
 msgid "Generation failed."
 msgstr "$B@8@.$K<:GT$7$^$7$?!#(B"

-#: lib/sshkey.tcl:118
+#: lib/sshkey.tcl:120
 msgid "Generation succeeded, but no keys found."
 msgstr "$B@8@.$K$O@.8y$7$^$7$?$,!"80$,8+$D$+$j$^$;$s!#(B"

-#: lib/sshkey.tcl:121
+#: lib/sshkey.tcl:123
 #, tcl-format
 msgid "Your key is in: %s"
 msgstr "$B$"$J$?$N80$O(B %s $B$K$"$j$^$9(B"

-#: lib/status_bar.tcl:83
+#: lib/status_bar.tcl:87
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%1$s ... %4$*i %6$s $BCf$N(B %2$*i (%7$3i%%)"

-#: lib/tools.tcl:75
-#, tcl-format
-msgid "Running %s requires a selected file."
-msgstr "$B%U%!%$%k$rA*Br$7$F$+$i(B %s $B$r5/F0$7$F$/$@$5$$!#(B"
-
-#: lib/tools.tcl:90
-#, tcl-format
-msgid "Are you sure you want to run %s?"
-msgstr "$BK\Ev$K(B %s $B$r5/F0$7$^$9$+(B?"
-
-#: lib/tools.tcl:110
-#, tcl-format
-msgid "Tool: %s"
-msgstr "$B%D!<%k(B: %s"
-
-#: lib/tools.tcl:111
-#, tcl-format
-msgid "Running: %s"
-msgstr "$B<B9TCf(B: %s"
-
-#: lib/tools.tcl:149
-#, tcl-format
-msgid "Tool completed successfully: %s"
-msgstr "$B%D!<%k$,40N;$7$^$7$?(B: %s"
-
-#: lib/tools.tcl:151
-#, tcl-format
-msgid "Tool failed: %s"
-msgstr "$B%D!<%k$,<:GT$7$^$7$?(B: %s"
-
 #: lib/tools_dlg.tcl:22
 msgid "Add Tool"
 msgstr "$B%D!<%k$NDI2C(B"
@@ -2413,52 +2448,52 @@ msgstr "$B%D!<%k$NDI2C(B"
 msgid "Add New Tool Command"
 msgstr "$B?75,%D!<%k%3%^%s%I$NDI2C(B"

-#: lib/tools_dlg.tcl:33
+#: lib/tools_dlg.tcl:34
 msgid "Add globally"
 msgstr "$BA4BN$KDI2C(B"

-#: lib/tools_dlg.tcl:45
+#: lib/tools_dlg.tcl:46
 msgid "Tool Details"
 msgstr "$B%D!<%k$N>\:Y(B"

-#: lib/tools_dlg.tcl:48
+#: lib/tools_dlg.tcl:49
 msgid "Use '/' separators to create a submenu tree:"
 msgstr "'/' $B$G%5%V%a%K%e!<$r6h@Z$j$^$9(B:"

-#: lib/tools_dlg.tcl:61
+#: lib/tools_dlg.tcl:60
 msgid "Command:"
 msgstr "$B%3%^%s%I(B:"

-#: lib/tools_dlg.tcl:74
+#: lib/tools_dlg.tcl:71
 msgid "Show a dialog before running"
 msgstr "$B5/F0$9$kA0$K%@%$%"%m%0$rI=<((B"

-#: lib/tools_dlg.tcl:80
+#: lib/tools_dlg.tcl:77
 msgid "Ask the user to select a revision (sets $REVISION)"
 msgstr "$B%f!<%6$K%3%_%C%H$r0l$DA*$P$;$k(B ($REVISION $B$K%;%C%H$7$^$9(B)"

-#: lib/tools_dlg.tcl:85
+#: lib/tools_dlg.tcl:82
 msgid "Ask the user for additional arguments (sets $ARGS)"
 msgstr "$B%f!<%6$KB>$N0z?t$rDI2C$5$;$k(B ($ARGS $B$K%;%C%H$7$^$9(B)"

-#: lib/tools_dlg.tcl:92
+#: lib/tools_dlg.tcl:89
 msgid "Don't show the command output window"
 msgstr "$B%3%^%s%I$+$i$N=PNO%&%#%s%I%&$r8+$;$J$$(B"

-#: lib/tools_dlg.tcl:97
+#: lib/tools_dlg.tcl:94
 msgid "Run only if a diff is selected ($FILENAME not empty)"
 msgstr "$B%Q%C%A$,A*$P$l$F$$$k$H$-$@$1F0$+$9(B($FILENAME $B$,6u$G$J$$(B)"

-#: lib/tools_dlg.tcl:121
+#: lib/tools_dlg.tcl:118
 msgid "Please supply a name for the tool."
 msgstr "$B%D!<%kL>$r;XDj$7$F2<$5$$!#(B"

-#: lib/tools_dlg.tcl:129
+#: lib/tools_dlg.tcl:126
 #, tcl-format
 msgid "Tool '%s' already exists."
 msgstr "$B%D!<%k(B '%s' $B$O4{$KB8:_$7$^$9!#(B"

-#: lib/tools_dlg.tcl:151
+#: lib/tools_dlg.tcl:148
 #, tcl-format
 msgid ""
 "Could not add tool:\n"
@@ -2467,35 +2502,70 @@ msgstr ""
 "$B%D!<%k$rDI2C$G$-$^$;$s(B:\n"
 "%s"

-#: lib/tools_dlg.tcl:190
+#: lib/tools_dlg.tcl:187
 msgid "Remove Tool"
 msgstr "$B%D!<%k$N:o=|(B"

-#: lib/tools_dlg.tcl:196
+#: lib/tools_dlg.tcl:193
 msgid "Remove Tool Commands"
 msgstr "$B%D!<%k%3%^%s%I$N:o=|(B"

-#: lib/tools_dlg.tcl:200
+#: lib/tools_dlg.tcl:198
 msgid "Remove"
 msgstr "$B:o=|(B"

-#: lib/tools_dlg.tcl:236
+#: lib/tools_dlg.tcl:231
 msgid "(Blue denotes repository-local tools)"
 msgstr "($B@D?'$O%m!<%+%k%l%]%8%H%j$N%D!<%k$G$9(B)"

-#: lib/tools_dlg.tcl:297
+#: lib/tools_dlg.tcl:292
 #, tcl-format
 msgid "Run Command: %s"
 msgstr "$B%3%^%s%I$r5/F0(B: %s"

-#: lib/tools_dlg.tcl:311
+#: lib/tools_dlg.tcl:306
 msgid "Arguments"
 msgstr "$B0z?t(B"

-#: lib/tools_dlg.tcl:348
+#: lib/tools_dlg.tcl:341
 msgid "OK"
 msgstr "OK"

+#: lib/tools.tcl:75
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "$B%U%!%$%k$rA*Br$7$F$+$i(B %s $B$r5/F0$7$F$/$@$5$$!#(B"
+
+#: lib/tools.tcl:91
+#, tcl-format
+msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
+msgstr "\"%2$s\" $B%U%!%$%k$r(B %1$s $B$G<B9T$7$F$h$m$7$$$G$9$+(B?"
+
+#: lib/tools.tcl:95
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "$BK\Ev$K(B %s $B$r5/F0$7$^$9$+(B?"
+
+#: lib/tools.tcl:116
+#, tcl-format
+msgid "Tool: %s"
+msgstr "$B%D!<%k(B: %s"
+
+#: lib/tools.tcl:117
+#, tcl-format
+msgid "Running: %s"
+msgstr "$B<B9TCf(B: %s"
+
+#: lib/tools.tcl:155
+#, tcl-format
+msgid "Tool completed successfully: %s"
+msgstr "$B%D!<%k$,40N;$7$^$7$?(B: %s"
+
+#: lib/tools.tcl:157
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "$B%D!<%k$,<:GT$7$^$7$?(B: %s"
+
 #: lib/transport.tcl:7
 #, tcl-format
 msgid "Fetching new changes from %s"
@@ -2504,52 +2574,71 @@ msgstr "%s $B$+$i?7$7$$JQ99$r%U%'%C%A$7$F$$$^$9(B"
 #: lib/transport.tcl:18
 #, tcl-format
 msgid "remote prune %s"
-msgstr "$B1s3V4"9~(B %s"
+msgstr "$B%j%b!<%H%l%]%8%H%j(B %s $B$N:o=|:Q%V%i%s%A$r:o=|Cf(B"

 #: lib/transport.tcl:19
 #, tcl-format
 msgid "Pruning tracking branches deleted from %s"
-msgstr "%s $B$+$i:o=|$5$l$?%H%i%C%-%s%0!&%V%i%s%A$r4"$C$F$$$^$9(B"
+msgstr "%s $B$+$i:o=|$5$l$?%V%i%s%A$r:o=|Cf(B"
+
+#: lib/transport.tcl:25
+msgid "fetch all remotes"
+msgstr "$B$9$Y$F$N%j%b!<%H%l%]%8%H%j$+$iJQ99<hF@(B"

 #: lib/transport.tcl:26
+msgid "Fetching new changes from all remotes"
+msgstr "$B$9$Y$F$N%j%b!<%H%l%]%8%H%j$N?7$7$$JQ99$r<hF@(B(fetch)$B$7$F$$$^$9(B"
+
+#: lib/transport.tcl:40
+msgid "remote prune all remotes"
+msgstr "$BA4%j%b!<%H%l%]%8%H%j$N:o=|:Q%V%i%s%A$r:o=|Cf(B"
+
+#: lib/transport.tcl:41
+msgid "Pruning tracking branches deleted from all remotes"
+msgstr "$BA4%j%b!<%H%l%]%8%H%j$+$i:o=|$5$l$?%V%i%s%A$r:o=|Cf(B"
+
+#: lib/transport.tcl:55
 #, tcl-format
 msgid "Pushing changes to %s"
 msgstr "%s $B$XJQ99$r%W%C%7%e$7$F$$$^$9(B"

-#: lib/transport.tcl:64
+#: lib/transport.tcl:93
 #, tcl-format
 msgid "Mirroring to %s"
 msgstr "%s $B$X%_%i!<$7$F$$$^$9(B"

-#: lib/transport.tcl:82
+#: lib/transport.tcl:111
 #, tcl-format
 msgid "Pushing %s %s to %s"
 msgstr "%3$s $B$X(B %1$s %2$s $B$r%W%C%7%e$7$F$$$^$9(B"

-#: lib/transport.tcl:100
+#: lib/transport.tcl:132
 msgid "Push Branches"
 msgstr "$B%V%i%s%A$r%W%C%7%e(B"

-#: lib/transport.tcl:114
+#: lib/transport.tcl:147
 msgid "Source Branches"
 msgstr "$B85$N%V%i%s%A(B"

-#: lib/transport.tcl:131
+#: lib/transport.tcl:162
 msgid "Destination Repository"
 msgstr "$BAw$j@h%j%]%8%H%j(B"

-#: lib/transport.tcl:169
+#: lib/transport.tcl:205
 msgid "Transfer Options"
 msgstr "$BDL?.%*%W%7%g%s(B"

-#: lib/transport.tcl:171
+#: lib/transport.tcl:207
 msgid "Force overwrite existing branch (may discard changes)"
 msgstr "$B4{B8%V%i%s%A$r>e=q$-(B($BJQ99$rGK4~$9$k2DG=@-$,$"$j$^$9(B)"

-#: lib/transport.tcl:175
+#: lib/transport.tcl:211
 msgid "Use thin pack (for slow network connections)"
 msgstr "Thin Pack $B$r;H$&!JCY$$%M%C%H%o!<%/@\B3!K(B"

-#: lib/transport.tcl:179
+#: lib/transport.tcl:215
 msgid "Include tags"
 msgstr "$B%?%0$r4^$a$k(B"
+
+#~ msgid "Case-Sensitive"
+#~ msgstr "$BBgJ8;z>.J8;z$r6hJL(B"
-- 
1.8.1.msysgit.1
