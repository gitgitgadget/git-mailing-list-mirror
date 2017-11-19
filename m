Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2049202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 18:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbdKSSmR (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 13:42:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:63979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbdKSSmP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 13:42:15 -0500
Received: from bedhanger.strangled.net ([188.193.87.84]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M3zne-1f7dNw38yo-00rbT5; Sun, 19 Nov 2017 19:41:39 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v3 3/5] Documentation: user-manual: limit usage of ellipsis
Date:   Sun, 19 Nov 2017 19:41:11 +0100
Message-Id: <20171119184113.16630-3-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171119184113.16630-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de>
References: <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:WyL8JOMk5by2e0WnLRkK9V39wXtWAV0NIOZwpE6FbhU2nlBQVqT
 eEPcGG7v73OftR4EY8NCxtVILReGPRCPJON+8xWZF/LpvI3ly9hWpiZV1Fekz9kfkJFWh/u
 z7DsHganv3aeB0SDjotX5DZnckp9aRXdi57UYhpSE91GwUmm/bM6E7shvOIXsZl7QRto8K1
 Hm7YqyW/bqr2NF+fGyDDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z/kpE7xYbRg=:vu7QKtTmrbCpUmZjvtSspX
 iSxl+5oxWO/tKrUqOBuAzAzYGbP/OZpJzxHj80sx4fz0bEANFTsJeJ/vfieW4oSu+OGIlyZjR
 Pt5+qoht9gI19LC/aEA6M6YdtbDwKiooVuOJqooKZMOrZd4tTpIFvgYBpEjxN4tuM971B3osO
 yYGkEKDD0Yz8ecPG8SoEPmDVKx7QIVg7xNVkGrs2yjc5np6ZNcX2aaEnGWA2K2ZlTgc8h3yT+
 iuBVv4tTnL4GKMnPMYAl4NFzJxbrR61cTG4l3At7NcSMlk0NLCu14MBqDG8ByschbMZPg8ud8
 cnweB0n9GPcWo5OXEXrGY1TYweJV6bXrRmQ0SCVbBqtLxpLMBk/Xzuh2YZKX8FP6KPs0Z8iIA
 +YWtx4eZvJzC2nHxOgqOApVKiRKPWi7+n17TfHFZEO8aqOszwALmjotF0L2pR4sL0tFc8404m
 f6f5shlCwAKkrfEiCSQBrvCMINZOcFDAxO5+iS08OteOmKujJzL5ole9wUTb1zEBMUOtwOHIP
 S3rCzFbjyTiAyzzNt4OZ4Uod5eWvlyu/NxK03j9K9+ykR2UWZtglVPdabteQZunRyHImyQhi6
 XkF6jn+/j5+cbY2oAcCT6Xdgsqfny0jGOAVdvnsS0PwJnOisJo7jS+jpDrmxtkRbh0MAX5wMy
 SjnMN5ftif6w/N1ByuaXhcIf6aDeb80si+CLq7ht+HmIr3ruHlajyvFuzz00tLnXF+OYfelK8
 DTBaJ0/zWon9NjrzZ23G/r1v1R40Oz/zMVDU+8tP/OOlTh+6E4VwSwB28SDTqmzIvVX3GV6N+
 B38anMg4kkhP2toGsfi6xfjfbH++Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Confusing the ellipsis with the three-dot operator should be made as
difficult as possible.

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
 Documentation/user-manual.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 3a03e63eb0d8..eff78902742a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -319,7 +319,7 @@ do so (now or later) by using -b with the checkout command again. Example:
 
   git checkout -b new_branch_name
 
-HEAD is now at 427abfa... Linux v2.6.17
+HEAD is now at 427abfa Linux v2.6.17
 ------------------------------------------------
 
 The HEAD then refers to the SHA-1 of the commit instead of to a branch,
@@ -508,7 +508,7 @@ Bisecting: 3537 revisions left to test after this
 
 If you run `git branch` at this point, you'll see that Git has
 temporarily moved you in "(no branch)". HEAD is now detached from any
-branch and points directly to a commit (with commit id 65934...) that
+branch and points directly to a commit (with commit id 65934) that
 is reachable from "master" but not from v2.6.18. Compile and test it,
 and see whether it crashes. Assume it does crash. Then:
 
@@ -549,14 +549,14 @@ says "bisect".  Choose a safe-looking commit nearby, note its commit
 id, and check it out with:
 
 -------------------------------------------------
-$ git reset --hard fb47ddb2db...
+$ git reset --hard fb47ddb2db
 -------------------------------------------------
 
 then test, run `bisect good` or `bisect bad` as appropriate, and
 continue.
 
 Instead of `git bisect visualize` and then `git reset --hard
-fb47ddb2db...`, you might just want to tell Git that you want to skip
+fb47ddb2db`, you might just want to tell Git that you want to skip
 the current commit:
 
 -------------------------------------------------
@@ -3416,7 +3416,7 @@ commit abc
 Author:
 Date:
 ...
-:100644 100644 4b9458b... newsha... M somedirectory/myfile
+:100644 100644 4b9458b newsha M somedirectory/myfile
 
 
 commit xyz
@@ -3424,7 +3424,7 @@ Author:
 Date:
 
 ...
-:100644 100644 oldsha... 4b9458b... M somedirectory/myfile
+:100644 100644 oldsha 4b9458b M somedirectory/myfile
 ------------------------------------------------
 
 This tells you that the immediately following version of the file was
@@ -3449,7 +3449,7 @@ and your repository is good again!
 $ git log --raw --all
 ------------------------------------------------
 
-and just looked for the sha of the missing object (4b9458b..) in that
+and just looked for the sha of the missing object (4b9458b) in that
 whole thing. It's up to you--Git does *have* a lot of information, it is
 just missing one particular blob version.
 
@@ -4114,9 +4114,9 @@ program, e.g.  `diff3`, `merge`, or Git's own merge-file, on
 the blob objects from these three stages yourself, like this:
 
 ------------------------------------------------
-$ git cat-file blob 263414f... >hello.c~1
-$ git cat-file blob 06fa6a2... >hello.c~2
-$ git cat-file blob cc44c73... >hello.c~3
+$ git cat-file blob 263414f >hello.c~1
+$ git cat-file blob 06fa6a2 >hello.c~2
+$ git cat-file blob cc44c73 >hello.c~3
 $ git merge-file hello.c~2 hello.c~1 hello.c~3
 ------------------------------------------------
 
@@ -4374,7 +4374,7 @@ $ git log --no-merges t/
 ------------------------
 
 In the pager (`less`), just search for "bundle", go a few lines back,
-and see that it is in commit 18449ab0...  Now just copy this object name,
+and see that it is in commit 18449ab0.  Now just copy this object name,
 and paste it into the command line
 
 -------------------
-- 
2.13.6

