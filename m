Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3BD2036D
	for <e@80x24.org>; Fri, 24 Nov 2017 23:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753866AbdKXXy6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 18:54:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:54172 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753855AbdKXXy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 18:54:57 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M08eS-1f81Zv3Y9k-00uM1A; Sat, 25 Nov 2017 00:54:19 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v4 3/6] Documentation: user-manual: limit usage of ellipsis
Date:   Sat, 25 Nov 2017 00:53:27 +0100
Message-Id: <20171124235330.15157-3-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171124235330.15157-1-bedhanger@gmx.de>
References: <20171124235330.15157-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
In-Reply-To: <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:PQ80uEYXXKvIWt1c2vNFZTtjv4hpcUJwAzHOtbfpRwjqVJ7ybQE
 AiUzRQDBIY5FC5xIIbuA13saV/V5PILjIVKefJWtVlkqJERV5M9V11J+jAALuy0hFas13JT
 DGVA7p4KFgqE1jXAM+hISjxQSw9pb1S6PYDYXpODuT0aquXYQn2MdZF9Nj0uFqjc2z+5SK0
 XzTZUn6C0byiWHNV2uSbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bOU8PwvP5IE=:2ThKPkakmPfEEZbHlCtXnw
 /0ENyppjzTo3tYRDo1CX0K14sP+d9LkHzP8CculCeVREIq3ukM3c3zUqr7VyMYhgckfzWldAA
 24w6jzubGWC8plVZR/C2oB9Hi5gqvj2sjo+ogR/VrUehoNoWPdQpuBC2QpHDNTqkrDFmyxWeJ
 o8Mc72MWEPYIM1H31Slz2lqP6pxbw/Z4/7ZVR37W2Gl3t2Zj63GDdBsHvvj8WRHiNFqIOpllM
 tVLXLtxnhl4xn2GD1mqCCHO612GX1f1iykKxvaWPoTztJwsNOyzHgX5T5OnDAzUel9E2kktx/
 5VN+hRf+1AGHlMcVHO+uTc5CcARX16zNAjh9VwkX9R8urdVttiVVMlXAxH1VdsHTnq/frVMvi
 uXbATdUJdZCRIH1riaoRPAiXTEmO8vNzaUaG45qTtke7RBGbsPivHHsiRkMkFRfqPRwOSZyoU
 /4jKLjORFpzpc0SFczlnufb8Pw5gUmMVvBFt4K+gLTOkSryLe3GO+TRVAYt9I9si3DbhHpcYp
 baRDTGL84nQ03+0udMTy7BHD8cuHSNHIF+TqaDGeRz52E+g8dpveVytNV44i+QMuTXGLeY1mD
 Vv4FsDCN+nXVHhyRfOMTQiDOMukT3riMoK96l0e944N5SMULLOv87zKGNO0Qb7anJt86EN+WY
 2YI6PWGOavMAouo+uaKFfzK11/O/+Gedyz98KMpr4WkvnacWbEdKkBn2Ec0EEXqhXzsjhHZ7m
 LldxtYm9YaIvJ1ode9Pl69o8Po+dWldgE5Uky1Vh8ZRky6cu/d0BW/DFSG3VTXcK2EVAVN0vq
 TJfg2Ka4OBV10eWRBeVAaivpn88jQ==
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
v4: improve env var handling (rename, helper func to query, docu)
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

