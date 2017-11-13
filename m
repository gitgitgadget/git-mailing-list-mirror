Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3263B1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbdKMWit (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:38:49 -0500
Received: from mout.gmx.net ([212.227.15.18]:52022 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751376AbdKMWis (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:38:48 -0500
Received: from bedhanger.strangled.net ([188.192.144.31]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M7Hao-1fAIuD0MMg-00x77H; Mon, 13 Nov 2017 23:38:11 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v2 4/6] Documentation: user-manual: limit usage of ellipsis
Date:   Mon, 13 Nov 2017 23:36:52 +0100
Message-Id: <20171113223654.27732-4-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171113223654.27732-1-bedhanger@gmx.de>
References: <20171113223654.27732-1-bedhanger@gmx.de>
References: <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <EA775C6AB4684B7A86A88C733C132827@PhilipOakley>
X-Provags-ID: V03:K0:zEuxLHEdcBwZmdar5TcpJKaYKbGh7cRNRRuwIzNHHIMNJqmVrD2
 7Hl2/PfEzdBS00AqioOMinp+SvWtjdhCCOnsrvafpMt+r79Pd+dPSuGiLH/IrhOMvY0TVLS
 sG0htD4s6doObLI26A85wtP1FtxPcl33y/NvpcMH0dXTVxlqUYhyFM/oExgUshE4J9toInA
 uNqrcjw8AZcz+ePhaE6Sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iAr37rXoUbQ=:DL90UOUf7GKrvgvRhNFyJB
 TYI83O/Mb3EE2HdSnFxCya8r/Avkwtq3ybmdCtwVrND9Eo9WRpaXQeFXPVdouzLAK9jJgkSAi
 8th2PmE4KXiWtiqTWfNZJy44pS+2sKPHuM7DF+iOeD8M1g6NsJmbm0R7nvFC3+EwsczcEF6Ey
 8i7FFqgvN5cipMmHQz6N72RjaJAwC4NOozGRmUBUPuf97NaQG5lRudmsESoJNVshlnn5vV1Y7
 9AiTiNG/sZzgz2M7tg8uvx1XaMgQorjzVWC1ko9oQr0V1cqmb2y9X+uL6w05/Am7/8SUS/dqS
 qHcaygOCBOGMbsBIAYkl2/bxyw+WICr2Abae2wbztUiRdeAc4NxtAUtJixFC0eKklLm0aWXT/
 W7fQBimGwD0ZQii1DiNahJXgnzFcXeguGr4YHpbkY3j7UDjbIT+o3RKGFBBrhcGrn8wywyiVz
 v4kF/wFaQwQlXm74s1nBqHOcbKKBcZdurl8rPUpN/vk437V8JwgZ7pFw6sNPF/r3fLp9aiDIw
 XVE4P4FiFtBNZFhORE+kces1A1iO9mSgfHFruWj/gJ/T/a2snEYJZDgnfuK30OvWaYi0x/+hU
 5wDzmshVDoBq8BE6DtDKi8untZCBAxpMdAlOaWZ1sO0uPoxZ5vPGmxqJ0JUj7jUe2thUa20xk
 dNlkZCnm3gpwrDSTRFrBEQkJ91EH2fiVmYUNHsCQCgXNF+OJoOx626fythGe0tW8HSDCmgRyY
 AP+LXqvCoTjAPnog2urns2K8BT2dqmWMIz4Yp6DiuDGNYorAvaDonVJgyBOuH3jYHZFUQt68I
 Z8512KyRumuPfzj4KWqNYiKRMRp/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Confusing the ellipsis with the three-dot operator should be made as
difficult as possible.

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
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

