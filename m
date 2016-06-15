From: =?ISO-2022-JP?B?GyRCMC1LYkxuNkxDY0w1GyhC?= 
	<devil.tamachan@gmail.com>
Subject: [PATCH 4/4] Update Japanese translation (Git-gui)
Date: Fri, 19 Jul 2013 02:15:50 +0900
Message-ID: <CAPM==H+fCx3k-iL2x4GQLtVxg662CqiPuD0g4v2+_a8MTrG4gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 19:15:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzro4-0004ei-0y
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 19:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933013Ab3GRRPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 13:15:52 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:61255 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab3GRRPv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 13:15:51 -0400
Received: by mail-ve0-f182.google.com with SMTP id ox1so2695115veb.41
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ltn+sHYEEJKXMnLlmeyPSX8JnrTfmJ9fcy9O++g8aYU=;
        b=AwUikrARWVTTIIfJ/7PW3ZJXpaUGDaD5dKoM+fryNqWFKn90w6UG2SJP71UQsdngrF
         0LMMN5G7T2Bavo+ZeKWQNZd9P3Mfe5ZRFBi+a2q07gPC71vaXr8oMYzMRgMmBrFotP8y
         LilPn3AHq6S31Wce/czUmWDSUsldqnXOUgg+hNxbMJRCOhX4QsArig6fTwR01TmqSlnc
         SAgEShqsjY0b637/LAQngRLnG/zUjJDSheENnQoDUHMJE3+FaZ0yvhmwOWxT4hzQMoMR
         kFFI23dZ8A0XprXxZetb5H5XxbjXguwfDi5RZPFk9CpxEU0xnx9nXHG22MYTq/KmrcVK
         TSig==
X-Received: by 10.59.0.2 with SMTP id au2mr4387784ved.83.1374167750452; Thu,
 18 Jul 2013 10:15:50 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Thu, 18 Jul 2013 10:15:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230706>

Signed-off-by: Yamada Saburo <devil.tamachan@gmail.com>
---
 git-gui/po/ja.po | 153 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 73 insertions(+), 80 deletions(-)

diff --git a/git-gui/po/ja.po b/git-gui/po/ja.po
index 0bbe504..05215b9 100644
--- a/git-gui/po/ja.po
+++ b/git-gui/po/ja.po
@@ -7,14 +7,17 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2013-07-10 02:45+0900\n"
+"POT-Creation-Date: 2013-07-10 03:38+0900\n"
 "PO-Revision-Date: 2010-02-02 19:03+0900\n"
-"Last-Translator: $B$7$i$$$7(B $B$J$J$3(B <nanako3@lavabit.com>\n"
+"Last-Translator: $B$7$i$$$7(B $B$J$J$3(B <nanako3@lavabit.com>, Yamada Saburo
<devil.tamachan@gmail.com>\n"
 "Language-Team: Japanese\n"
 "Language: \n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=1; plural=0;\n"
+"X-Language: ja_JP\n"
+"X-Source-Language: C\n"

 #: git-gui.sh:859
 #, tcl-format
@@ -29,8 +32,8 @@ msgstr "$B<g%U%)%s%H(B"
 msgid "Diff/Console Font"
 msgstr "diff/$B%3%s%=!<%k!&%U%)%s%H(B"

-#: git-gui.sh:926 git-gui.sh:940 git-gui.sh:953 git-gui.sh:1043
-#: git-gui.sh:1062 git-gui.sh:3094
+#: git-gui.sh:926 git-gui.sh:940 git-gui.sh:953 git-gui.sh:1043 git-gui.sh:1062
+#: git-gui.sh:3094
 msgid "git-gui: fatal error"
 msgstr "git-gui: $BCWL?E*$J%(%i!<(B"

@@ -124,26 +127,23 @@ msgstr "$B%3%_%C%HM=Dj:Q!"%U%!%$%kL5$7(B"

 #: git-gui.sh:2087
 msgid "File type changed, not staged"
-msgstr "$B%U%!%$%k7?JQ99!"%3%_%C%HL$M=Dj(B"
+msgstr "$B%U%!%$%k%?%$%WJQ99!"%3%_%C%HL$M=Dj(B"

 #: git-gui.sh:2088 git-gui.sh:2089
-#, fuzzy
 msgid "File type changed, old type staged for commit"
-msgstr "$B%U%!%$%k7?JQ99!"%3%_%C%HL$M=Dj(B"
+msgstr "$B%U%!%$%k%?%$%WJQ99!"%3%_%C%HM=Dj$N7A<0$,8E$$(B"

 #: git-gui.sh:2090
 msgid "File type changed, staged"
-msgstr "$B%U%!%$%k7?JQ99!"%3%_%C%HM=Dj:Q(B"
+msgstr "$B%U%!%$%k%?%$%WJQ99!"%3%_%C%HM=Dj:Q(B"

 #: git-gui.sh:2091
-#, fuzzy
 msgid "File type change staged, modification not staged"
-msgstr "$B%U%!%$%k7?JQ99!"%3%_%C%HL$M=Dj(B"
+msgstr "$B%U%!%$%k%?%$%W$NJQ99$O%3%_%C%HM=Dj:Q!"FbMF$NJQ99$O%3%_%C%HL$M=Dj(B"

 #: git-gui.sh:2092
-#, fuzzy
 msgid "File type change staged, file missing"
-msgstr "$B%U%!%$%k7?JQ99!"%3%_%C%HM=Dj:Q(B"
+msgstr "$B%U%!%$%k%?%$%W$NJQ99$O%3%_%C%HM=Dj:Q!"%U%!%$%k$,8+$D$+$i$J$$(B"

 #: git-gui.sh:2094
 msgid "Untracked, not staged"
@@ -403,19 +403,16 @@ msgstr "SSH $B%-!<$rI=<((B"

 #: git-gui.sh:2983 git-gui.sh:3115
 msgid "Usage"
-msgstr ""
+msgstr "$B;HMQ>u67(B"

 #: git-gui.sh:3064 lib/blame.tcl:573
-#, fuzzy
 msgid "Error"
 msgstr "$B%(%i!<(B"

 #: git-gui.sh:3095
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
-msgstr ""
-"$BCWL?E*(B: $B%Q%9(B %s $B$,(B stat $B$G$-$^$;$s!#$=$N$h$&$J%U%!%$%k$d%G%#%l%/%H%j$O$"$j$^(B"
-"$B$;$s(B"
+msgstr "$BCWL?E*(B: $B%Q%9(B %s $B$,(B stat $B$G$-$^$;$s!#$=$N$h$&$J%U%!%$%k$d%G%#%l%/%H%j$O$"$j$^$;$s(B"

 #: git-gui.sh:3128
 msgid "Current Branch:"
@@ -614,9 +611,8 @@ msgid "Find Text..."
 msgstr "$B%F%-%9%H$r8!:w(B"

 #: lib/blame.tcl:288
-#, fuzzy
 msgid "Goto Line..."
-msgstr "$BJ#@=!D(B"
+msgstr "$B;XDj9T$X0\F0(B"

 #: lib/blame.tcl:297
 msgid "Do Full Copy Detection"
@@ -715,12 +711,11 @@ msgstr "$B%V%i%s%A$r%A%'%C%/%"%&%H(B"
 msgid "Checkout"
 msgstr "$B%A%'%C%/%"%&%H(B"

-#: lib/branch_checkout.tcl:30 lib/branch_create.tcl:37
-#: lib/branch_delete.tcl:34 lib/branch_rename.tcl:32 lib/browser.tcl:292
-#: lib/checkout_op.tcl:579 lib/choose_font.tcl:45 lib/merge.tcl:174
-#: lib/option.tcl:127 lib/remote_add.tcl:34 lib/remote_branch_delete.tcl:43
-#: lib/tools_dlg.tcl:41 lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345
-#: lib/transport.tcl:141
+#: lib/branch_checkout.tcl:30 lib/branch_create.tcl:37 lib/branch_delete.tcl:34
+#: lib/branch_rename.tcl:32 lib/browser.tcl:292 lib/checkout_op.tcl:579
+#: lib/choose_font.tcl:45 lib/merge.tcl:174 lib/option.tcl:127
+#: lib/remote_add.tcl:34 lib/remote_branch_delete.tcl:43 lib/tools_dlg.tcl:41
+#: lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345 lib/transport.tcl:141
 msgid "Cancel"
 msgstr "$BCf;_(B"

@@ -970,8 +965,7 @@ msgid ""
 msgstr ""
 "$B:G8e$K%9%-%c%s$7$?>uBV$O%j%]%8%H%j$N>uBV$H9gCW$7$^$;$s!#(B\n"
 "\n"
-"$B:G8e$K%9%-%c%s$7$F0J8e!"JL$N(B Git $B%W%m%0%i%`$,%j%]%8%H%j$rJQ99$7$F$$$^$9!#8=:_(B"
-"$B$N%V%i%s%A$rJQ99$9$kA0$K!":F%9%-%c%s$,I,MW$G$9!#(B\n"
+"$B:G8e$K%9%-%c%s$7$F0J8e!"JL$N(B Git $B%W%m%0%i%`$,%j%]%8%H%j$rJQ99$7$F$$$^$9!#8=:_$N%V%i%s%A$rJQ99$9$kA0$K!":F%9%-%c%s$,I,MW$G$9!#(B\n"
 "\n"
 "$B<+F0E*$K:F%9%-%c%s$r3+;O$7$^$9!#(B\n"

@@ -1007,8 +1001,7 @@ msgid ""
 msgstr ""
 "$B%m!<%+%k!&%V%i%s%A$+$iN%$l$^$9!#(B\n"
 "\n"
-"$B%V%i%s%A>e$KBZ$^$j$?$$$H$-$O!"$3$N!VJ,N%$5$l$?%A%'%C%/%"%&%H!W$+$i?75,%V%i%s(B"
-"$B%A$r3+;O$7$F$/$@$5$$!#(B"
+"$B%V%i%s%A>e$KBZ$^$j$?$$$H$-$O!"$3$N!VJ,N%$5$l$?%A%'%C%/%"%&%H!W$+$i?75,%V%i%s%A$r3+;O$7$F$/$@$5$$!#(B"

 #: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
 #, tcl-format
@@ -1045,8 +1038,7 @@ msgid ""
 msgstr ""
 "$B8=:_$N%V%i%s%A$r@_Dj$G$-$^$;$s!#(B\n"
 "\n"
-"$B:n6H%G%#%l%/%H%j$OItJ,E*$K$7$+@Z$jBX$o$C$F$$$^$;$s!#%U%!%$%k$N99?7$K$O@.8y$7(B"
-"$B$^$7$?$,!"(B Git $B$NFbIt%G!<%?$r99?7$G$-$^$;$s$G$7$?!#(B\n"
+"$B:n6H%G%#%l%/%H%j$OItJ,E*$K$7$+@Z$jBX$o$C$F$$$^$;$s!#%U%!%$%k$N99?7$K$O@.8y$7$^$7$?$,!"(B Git $B$NFbIt%G!<%?$r99?7$G$-$^$;$s$G$7$?!#(B\n"
 "$B5/$3$k$O$:$N$J$$%(%i!<$G$9!#$"$-$i$a$F(B %s $B$r=*N;$7$^$9!#(B"

 #: lib/choose_font.tcl:41
@@ -1350,8 +1342,7 @@ msgid ""
 msgstr ""
 "$BD{@5$9$k%3%_%C%H$,$=$b$=$b$"$j$^$;$s!#(B\n"
 "\n"
-"$B$3$l$+$i:n$k$N$O:G=i$N%3%_%C%H$G$9!#$=$NA0$K$O$^$@D{@5$9$k$h$&$J%3%_%C%H$O$"(B"
-"$B$j$^$;$s!#(B\n"
+"$B$3$l$+$i:n$k$N$O:G=i$N%3%_%C%H$G$9!#$=$NA0$K$O$^$@D{@5$9$k$h$&$J%3%_%C%H$O$"$j$^$;$s!#(B\n"

 #: lib/commit.tcl:18
 msgid ""
@@ -1363,8 +1354,7 @@ msgid ""
 msgstr ""
 "$B%^!<%8Cf$K%3%_%C%H$ND{@5$O$G$-$^$;$s!#(B\n"
 "\n"
-"$B8=:_$O$^$@%^!<%8$NESCf$G$9!#@h$K$3$N%^!<%8$rCf;_$7$J$$$H!"A0$N%3%_%C%H$ND{@5(B"
-"$B$O$G$-$^$;$s(B\n"
+"$B8=:_$O$^$@%^!<%8$NESCf$G$9!#@h$K$3$N%^!<%8$rCf;_$7$J$$$H!"A0$N%3%_%C%H$ND{@5$O$G$-$^$;$s(B\n"

 #: lib/commit.tcl:48
 msgid "Error loading commit data for amend:"
@@ -1394,8 +1384,7 @@ msgid ""
 msgstr ""
 "$B:G8e$K%9%-%c%s$7$?>uBV$O%j%]%8%H%j$N>uBV$H9gCW$7$^$;$s!#(B\n"
 "\n"
-"$B:G8e$K%9%-%c%s$7$F0J8e!"JL$N(B Git $B%W%m%0%i%`$,%j%]%8%H%j$rJQ99$7$F$$$^$9!#?7$7(B"
-"$B$/%3%_%C%H$9$kA0$K!":F%9%-%c%s$,I,MW$G$9!#(B\n"
+"$B:G8e$K%9%-%c%s$7$F0J8e!"JL$N(B Git $B%W%m%0%i%`$,%j%]%8%H%j$rJQ99$7$F$$$^$9!#?7$7$/%3%_%C%H$9$kA0$K!":F%9%-%c%s$,I,MW$G$9!#(B\n"
 "\n"
 "$B<+F0E*$K:F%9%-%c%s$r3+;O$7$^$9!#(B\n"

@@ -1409,8 +1398,7 @@ msgid ""
 msgstr ""
 "$B%^!<%8$7$F$$$J$$%U%!%$%k$O%3%_%C%H$G$-$^$;$s!#(B\n"
 "\n"
-"$B%U%!%$%k(B %s $B$K$O%^!<%8>WFM$,;D$C$F$$$^$9!#$^$:2r7h$7$F%3%_%C%HM=Dj$K2C$($kI,(B"
-"$BMW$,$"$j$^$9!#(B\n"
+"$B%U%!%$%k(B %s $B$K$O%^!<%8>WFM$,;D$C$F$$$^$9!#$^$:2r7h$7$F%3%_%C%HM=Dj$K2C$($kI,MW$,$"$j$^$9!#(B\n"

 #: lib/commit.tcl:181
 #, tcl-format
@@ -1468,6 +1456,11 @@ msgid ""
 " \n"
 " Do you really want to proceed with your Commit?"
 msgstr ""
+"$B$"$J$?$O(Bdetached "
+"head$B>uBV$G%3%_%C%H$7$h$&$H$7$F$$$^$9!#$3$l$O4m81$JA`:n$G$9!#$b$7B39T$9$l$P!"B>%V%i%s%A$X@Z$jBX$($?:]$KJQ99$r<:$C$?$j!"(Breflog$B$GJQ99$rI|85$9$k$3$H$,:$Fq$K$J$j$^$9!#$"$J$?$O<!$NA`:n$r$9$k$Y$-$G$9!#(B1.
"
+"$B$3$N%3%_%C%H$r%-%c%s%;%k$9$k!#(B2. $B?7$7$$%V%i%s%A$r:n$j!"%3%_%C%H$7D>$9!#(B\n"
+"\n"
+"$BK\Ev$K$3$N4m81$J%3%_%C%H$r<B9T$7$^$9$+!)(B"

 #: lib/commit.tcl:290
 msgid "Calling commit-msg hook..."
@@ -1611,8 +1604,7 @@ msgstr ""
 "\n"
 "%s $B$K$OJQ99$,$"$j$^$;$s!#(B\n"
 "\n"
-"$B$3$N%U%!%$%k$NJQ99;~9o$OB>$N%"%W%j%1!<%7%g%s$K$h$C$F99?7$5$l$F$$$^$9$,%U%!%$(B"
-"$B%kFbMF$K$OJQ99$,$"$j$^$;$s!#(B\n"
+"$B$3$N%U%!%$%k$NJQ99;~9o$OB>$N%"%W%j%1!<%7%g%s$K$h$C$F99?7$5$l$F$$$^$9$,%U%!%$%kFbMF$K$OJQ99$,$"$j$^$;$s!#(B\n"
 "\n"
 "$BF1MM$J>uBV$N%U%!%$%k$rC5$9$?$a$K!"<+F0E*$K:F%9%-%c%s$r3+;O$7$^$9!#(B"

@@ -1736,9 +1728,7 @@ msgstr "$B:w0z%(%i!<(B"
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically started to "
 "resynchronize git-gui."
-msgstr ""
-"GIT $B%$%s%G%C%/%9$N99?7$,<:GT$7$^$7$?!#(Bgit-gui $B$HF14|$r$H$k$?$a$K:F%9%-%c%s$7(B"
-"$B$^$9!#(B"
+msgstr "GIT $B%$%s%G%C%/%9$N99?7$,<:GT$7$^$7$?!#(Bgit-gui $B$HF14|$r$H$k$?$a$K:F%9%-%c%s$7$^$9!#(B"

 #: lib/index.tcl:30
 msgid "Continue"
@@ -1765,7 +1755,7 @@ msgstr "$B%3%_%C%H$K(B %s $B$r2C$($F$$$^$9(B"
 #: lib/index.tcl:380
 #, tcl-format
 msgid "Stage %d untracked files?"
-msgstr ""
+msgstr "%d $B8D$N?75,%U%!%$%k$,$"$j$^$9!#%3%_%C%HM=Dj$7$F$b$$$$$G$9$+!)(B"

 #: lib/index.tcl:428
 #, tcl-format
@@ -1796,11 +1786,11 @@ msgstr "%s $B$K$7$?JQ99$r85$KLa$7$^$9(B"

 #: lib/line.tcl:17
 msgid "Goto Line:"
-msgstr ""
+msgstr "$B;XDj9T$X0\F0(B:"

 #: lib/line.tcl:23
 msgid "Go"
-msgstr ""
+msgstr "$B0\F0(B"

 #: lib/merge.tcl:13
 msgid ""
@@ -1823,8 +1813,7 @@ msgid ""
 msgstr ""
 "$B:G8e$K%9%-%c%s$7$?>uBV$O%j%]%8%H%j$N>uBV$H9gCW$7$^$;$s!#(B\n"
 "\n"
-"$B:G8e$K%9%-%c%s$7$F0J8e!"JL$N(B Git $B%W%m%0%i%`$,%j%]%8%H%j$rJQ99$7$F$$$^$9!#%^!<(B"
-"$B%8$r3+;O$9$kA0$K!":F%9%-%c%s$,I,MW$G$9!#(B\n"
+"$B:G8e$K%9%-%c%s$7$F0J8e!"JL$N(B Git $B%W%m%0%i%`$,%j%]%8%H%j$rJQ99$7$F$$$^$9!#%^!<%8$r3+;O$9$kA0$K!":F%9%-%c%s$,I,MW$G$9!#(B\n"
 "\n"
 "$B<+F0E*$K:F%9%-%c%s$r3+;O$7$^$9!#(B\n"

@@ -1842,8 +1831,7 @@ msgstr ""
 "\n"
 "$B%U%!%$%k(B %s $B$K$O%^!<%8Cf$N>WFM$,;D$C$F$$$^$9!#(B\n"
 "\n"
-"$B$3$N%U%!%$%k$N>WFM$r2r7h$7!"%3%_%C%HM=Dj$K2C$($F!"%3%_%C%H$9$k$3$H$G%^!<%8$r(B"
-"$B40N;$7$^$9!#$=$&$d$C$F;O$a$F!"?7$?$J%^!<%8$r3+;O$G$-$k$h$&$K$J$j$^$9!#(B\n"
+"$B$3$N%U%!%$%k$N>WFM$r2r7h$7!"%3%_%C%HM=Dj$K2C$($F!"%3%_%C%H$9$k$3$H$G%^!<%8$r40N;$7$^$9!#$=$&$d$C$F;O$a$F!"?7$?$J%^!<%8$r3+;O$G$-$k$h$&$K$J$j$^$9!#(B\n"

 #: lib/merge.tcl:55
 #, tcl-format
@@ -1859,8 +1847,7 @@ msgstr ""
 "\n"
 "$B%U%!%$%k(B %s $B$OJQ99Cf$G$9!#(B\n"
 "\n"
-"$B8=:_$N%3%_%C%H$r40N;$7$F$+$i%^!<%8$r3+;O$7$F2<$5$$!#$=$&$9$kJ}$,%^!<%8$K<:GT(B"
-"$B$7$?$H$-$N2sI|$,3Z$G$9!#(B\n"
+"$B8=:_$N%3%_%C%H$r40N;$7$F$+$i%^!<%8$r3+;O$7$F2<$5$$!#$=$&$9$kJ}$,%^!<%8$K<:GT$7$?$H$-$N2sI|$,3Z$G$9!#(B\n"

 #: lib/merge.tcl:108
 #, tcl-format
@@ -1973,8 +1960,7 @@ msgstr ""
 #: lib/mergetool.tcl:45
 #, tcl-format
 msgid "File %s seems to have unresolved conflicts, still stage?"
-msgstr ""
-"$B%U%!%$%k(B %s $B$K$O2r7h$7$F$$$J$$6%9gItJ,$,$^$@$"$k$h$&$G$9$,!"$$$$$G$9$+(B?"
+msgstr "$B%U%!%$%k(B %s $B$K$O2r7h$7$F$$$J$$6%9gItJ,$,$^$@$"$k$h$&$G$9$,!"$$$$$G$9$+(B?"

 #: lib/mergetool.tcl:60
 #, tcl-format
@@ -2056,7 +2042,7 @@ msgstr "%s $B%j%]%8%H%j(B"

 #: lib/option.tcl:134
 msgid "Global (All Repositories)"
-msgstr "$BBg0h!JA4$F$N%j%]%8%H%j!K(B"
+msgstr "$BI8=`@_Dj!JA4$F$N%j%]%8%H%j!K(B"

 #: lib/option.tcl:140
 msgid "User Name"
@@ -2068,15 +2054,15 @@ msgstr "$BEE;R%a!<%k%"%I%l%9(B"

 #: lib/option.tcl:143
 msgid "Summarize Merge Commits"
-msgstr "$B%^!<%8%3%_%C%H$NMWLs(B"
+msgstr "$B%^!<%8%3%_%C%H$NMWLs(B (--summary)"

 #: lib/option.tcl:144
 msgid "Merge Verbosity"
-msgstr "$B%^!<%8$N>iD9EY(B"
+msgstr "$B%^!<%8$N%(%i!<=PNO%l%Y%k(B (0-5, $BI8=`(B2$B!":G9b(B5)(merge.verbosity)"

 #: lib/option.tcl:145
 msgid "Show Diffstat After Merge"
-msgstr "$B%^!<%88e$K(B diffstat $B$rI=<((B"
+msgstr "$B%^!<%88e$KJQ99NL$N%0%i%U$rI=<((B (git diff --stat)"

 #: lib/option.tcl:146
 msgid "Use Merge Tool"
@@ -2088,7 +2074,7 @@ msgstr "$B%U%!%$%kJQ99;~9o$r?.Mj$9$k(B"

 #: lib/option.tcl:149
 msgid "Prune Tracking Branches During Fetch"
-msgstr "$B%j%b!<%H$+$iJQ99$r<hF@(B (fetch) $B$7$?$H$-!"%j%b!<%H$G:o=|:Q$_$N%V%i%s%A$r:o=|$9$k(B"
+msgstr "$B%j%b!<%H$+$iJQ99<hF@(B (fetch) $B$7$?$H$-!"%j%b!<%H$G:o=|:Q$_$N%V%i%s%A$r:o=|$9$k(B"

 #: lib/option.tcl:150
 msgid "Match Tracking Branches"
@@ -2096,7 +2082,7 @@ msgstr "$B%H%i%C%-%s%0%V%i%s%A$r9g$o$;$k(B"

 #: lib/option.tcl:151
 msgid "Use Textconv For Diffs and Blames"
-msgstr ""
+msgstr "Diff$B$H(BBlame$B$G(BTextConv$B$r;HMQ$9$k(B"

 #: lib/option.tcl:152
 msgid "Blame Copy Only On Changed Files"
@@ -2104,19 +2090,19 @@ msgstr "$BJQ99$5$l$?%U%!%$%k$N$_%3%T!<8!CN$r9T$J$&(B"

 #: lib/option.tcl:153
 msgid "Minimum Letters To Blame Copy On"
-msgstr "$B%3%T!<$r8!CN$9$k:G>/J8;z?t(B"
+msgstr "$BB>%U%!%$%k$+$i0\F0(B/$B%3%T!<$r8!CN$9$k:G>/J8;z?t(B ($BI8=`CM(B40)"

 #: lib/option.tcl:154
 msgid "Blame History Context Radius (days)"
-msgstr "$BCp<a$9$kMzNrH>7B!JF|?t!K(B"
+msgstr "Blame$B$NI=<(HO0O!JA08eF|?t!K(B"

 #: lib/option.tcl:155
 msgid "Number of Diff Context Lines"
-msgstr "diff $B$NJ8L.9T?t(B"
+msgstr "$B:9J,I=<($GI=<($9$kL$JQ999T?t(B ($BJQ999T$NA0(Bx$B9T!"8e(Bx$B9T$NL$JQ999T$rI=<((B)"

 #: lib/option.tcl:156
 msgid "Additional Diff Parameters"
-msgstr ""
+msgstr "Diff$B$NDI2C%Q%i%a!<%?(B"

 #: lib/option.tcl:157
 msgid "Commit Message Text Width"
@@ -2128,15 +2114,27 @@ msgstr "$B?7$7$$%V%i%s%AL>$N%F%s%W%l!<%H(B"

 #: lib/option.tcl:159
 msgid "Default File Contents Encoding"
-msgstr "$B%U%!%$%kFbMF$N%G%U%)!<%k%H%(%s%3!<%G%#%s%0(B"
+msgstr "$B%U%!%$%kFbMF$N%G%U%)%k%HJ8;z%3!<%I(B"

 #: lib/option.tcl:160
 msgid "Warn before committing to a detached head"
-msgstr ""
+msgstr "detached head$B>uBV$G%3%_%C%H$9$kA0$K7Y9p$9$k(B"

 #: lib/option.tcl:161
 msgid "Staging of untracked files"
-msgstr ""
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

 #: lib/option.tcl:207
 msgid "Change"
@@ -2291,9 +2289,7 @@ msgstr ""
 msgid ""
 "One or more of the merge tests failed because you have not fetched the "
 "necessary commits.  Try fetching from %s first."
-msgstr ""
-"$BI,MW$J%3%_%C%H$,ITB-$7$F$$$k$?$a$K!"%^!<%88!::$,<:GT$7$^$7$?!#$^$:(B %s $B$+$i(B"
-"$B%U%'%C%A$7$F2<$5$$!#(B"
+msgstr "$BI,MW$J%3%_%C%H$,ITB-$7$F$$$k$?$a$K!"%^!<%88!::$,<:GT$7$^$7$?!#$^$:(B %s $B$+$i%U%'%C%A$7$F2<$5$$!#(B"

 #: lib/remote_branch_delete.tcl:208
 msgid "Please select one or more branches to delete."
@@ -2343,11 +2339,11 @@ msgstr "$BA0(B"

 #: lib/search.tcl:52
 msgid "RegExp"
-msgstr ""
+msgstr "$B@55,I=8=(B"

 #: lib/search.tcl:54
 msgid "Case"
-msgstr ""
+msgstr "$B>.(B/$BBgJ8;z$r6hJL(B"

 #: lib/shortcut.tcl:21 lib/shortcut.tcl:62
 msgid "Cannot write shortcut:"
@@ -2545,9 +2541,9 @@ msgid "Running %s requires a selected file."
 msgstr "$B%U%!%$%k$rA*Br$7$F$+$i(B %s $B$r5/F0$7$F$/$@$5$$!#(B"

 #: lib/tools.tcl:91
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
-msgstr "$BK\Ev$K(B %s $B$r5/F0$7$^$9$+(B?"
+msgstr "\"%2$s\" $B%U%!%$%k$r(B %1$s $B$G<B9T$7$F$h$m$7$$$G$9$+(B?"

 #: lib/tools.tcl:95
 #, tcl-format
@@ -2591,20 +2587,17 @@ msgstr "%s $B$+$i:o=|$5$l$?%V%i%s%A$r:o=|Cf(B"

 #: lib/transport.tcl:25
 msgid "fetch all remotes"
-msgstr ""
+msgstr "$B$9$Y$F$N%j%b!<%H%l%]%8%H%j$+$iJQ99<hF@(B"

 #: lib/transport.tcl:26
-#, fuzzy
 msgid "Fetching new changes from all remotes"
-msgstr "%s $B$+$i?7$7$$JQ99$r%U%'%C%A$7$F$$$^$9(B"
+msgstr "$B$9$Y$F$N%j%b!<%H%l%]%8%H%j$N?7$7$$JQ99$r<hF@(B(fetch)$B$7$F$$$^$9(B"

 #: lib/transport.tcl:40
-#, fuzzy
 msgid "remote prune all remotes"
 msgstr "$BA4%j%b!<%H%l%]%8%H%j$N:o=|:Q%V%i%s%A$r:o=|Cf(B"

 #: lib/transport.tcl:41
-#, fuzzy
 msgid "Pruning tracking branches deleted from all remotes"
 msgstr "$BA4%j%b!<%H%l%]%8%H%j$+$i:o=|$5$l$?%V%i%s%A$r:o=|Cf(B"

--
1.8.1.msysgit.1
