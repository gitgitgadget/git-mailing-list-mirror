Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B983420C11
	for <e@80x24.org>; Sun,  3 Dec 2017 21:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbdLCV3E (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 16:29:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:62684 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752499AbdLCV3D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 16:29:03 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lz4KW-1f83cP3CSG-014DPc; Sun, 03 Dec 2017 22:28:25 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v5 2/7] Documentation: user-manual: limit usage of ellipsis
Date:   Sun,  3 Dec 2017 22:27:38 +0100
Message-Id: <20171203212743.10228-2-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171203212743.10228-1-bedhanger@gmx.de>
References: <20171203212743.10228-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com> <20171124235330.15157-1-bedhanger@gmx.de> <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com> <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:1lN3S0EOQNC4CU7VHOGzOebdtZ6CsiNlCSi7DJ3xMoIxLW2o7e3
 gGgJLRZc0rTI9OJE98twQjhnPz8Y9MBnwQFyz28ATvzojuoI9Lq+zVlLjDbHNrQPpJTLmZo
 p9ak3GKkoE7ZA5WIhOY7UKpJ0rLYTMji8S4kAsYGHxUUeOww0iac394+oEa5MFx9EHh1mAi
 9IfW6AGTLHpvm4eTDOhzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N726GOICeCM=:aMDsJrV7gWVXmL0RiFwenW
 5dcUthRVzBReUwt8m92v2xB6xqKxuj40P6PT9eMNWBhh952bxakh4dTgsGrk8YMiMAYPRZS5M
 TqeLT+QX0eAVKyeNNvsiWuCh5QR/7qL9P+fxKW3x80i1NMQ9NTFudRk2ihKCkVHfUE6tsW59p
 wBLqTbINfql/Yj2dsvTBvznLBWcmbssbKopyU7q48NAIgRh9BS0pUfGJhDGOfoiVuihQojqSC
 /6wkooTrJnz4MJyvnj54HhBB3IJOu2koT1GLyYmTALAEGSx39SVS7IDLkVO6sNMfemxlvTniV
 iyK8zWmxkgAXGMnpiXJSzEVZvjBomNAVXYSZ/lzzGhwZjQwS3pGWVEqBkUr3srrjNeb+aVCZa
 DfNPInsriuMjOgOj8onBnxh4DQpfVBn2v7mIqsBiNEfVmdjgSsh8JU6vxgauglpIAzzD3iBA8
 GlBuydmUKm9knoVb2C8vF6Rw7RdtPokFjG9By2OFsutmZxnQHIi1Rb293ZgXacqs903QRAcLB
 Y1J4Ye88gyguJEVDyGLjY10GJO2tGLjGR4hldNLfUWvhxhc8bB156HkyNyiSEyby/BFI6JzY7
 AnaQzcGIvIMon/1WNkb8da9Oa6APL027vPK3HuptMucsYBaVbKAadAzJta7H0Mka4ezFdwX80
 8vS5vdITc0PaM9I3Qn0lnVHguml/9HN7OEy9jBeHTGkTxQZM193D+Vppnf98r3j3LaeoxnqqF
 2KvAsVxWPElyAY3H59Z4MNGHEtLAb4y8zyAnAny9rwRosUgdyfpY2VFmypMnYR/3FtQ2c2KrR
 Yvc69yDgKQpw5SJy2JdoMUgu31qeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no need to use full 40-hex to identify the object names like
the examples hint at by omitting the tail part of an object name as if
that has to be spelled out but the example omits them only for brevity.
Give examples using abbreviated object names without ellipses just like
how people do in real life.

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
v4: improve env var handling (rename, helper func to query, docu)
v5: rewrite series to take Junio's comments in <xmqqd145k9td.fsf@gitster.mtv.corp.google.com> aboard
 Documentation/user-manual.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 3a03e63eb0d8..497e82e88dd0 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
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

