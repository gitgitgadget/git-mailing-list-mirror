Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6731F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfA2O06 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:26:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:58867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfA2O05 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:26:57 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lx5hl-1hD1TY0XYv-016c2N; Tue, 29
 Jan 2019 15:26:53 +0100
Date:   Tue, 29 Jan 2019 15:26:37 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: [PATCH] Fix typos in whats-cooking.txt, was Re: What's cooking in
 git.git (Jan 2019, #04; Mon, 28)
In-Reply-To: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901291523550.41@tvgsbejvaqbjf.bet>
References: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Y5vId68FEGPqlIOj3CTlwWGOOxKqbKe7+5IazqpmQpt1Up+WMqb
 yc/33G1hoNASPIl4QYd80ASZkIw6YnfyTu+MZTgJGsjJ0E16nIIbZjIwV0F2bRlROgCs+6I
 xbIELVrqvvsU2zsW5wtsTtPuI+20kCrRA1Xlx3Arz4wumoIxpptN7f2qbMEHOGKRzS91vzr
 u+2y0izgO68BcWcESGGOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:++7qCYgfMxY=:lbh/pq7ukp2XbIFxdyB9W6
 bpPddPqdCXRpmVoP9b+ABNcmjPJgfXiHI62wX6MscIyIqAn9m/aFk9WolgBPu+HsoErugwugq
 NvJC6cnc4eYallII9709SU5KVAGv3fOAVpqct9c+n7faeAPG6ErGgeeGs52Xx415oCEenBzSX
 tA5o2pRWyfHvk4boboP7vK0VeI2gFC4ZqdFQXZCB9VLTQkALLkTgj0nRJBU8z5jgyykn2Fn5F
 M5RNrIWZ8B4wnr2PCHp7dpfM1xclwLknSkeYhbpEstjlzfcp2esOXYr2aFL6JOkeTI2jF349u
 FXfJL7MPtLMBwKS9a2R6Uv5L6uZCqW0Z354B8qZ13yMURr4bVnd+0B860j8OuIDw7pDUFA5C6
 mxtoIpANc6t2B5s1drS6pXIU1IOuhSh7kldY5qD2IRzefChbeabyoiMR0akEiGrY2/s7tlPJm
 F+ogvCNfrzk/MKvCg55IrhwGkkdNsn1gZOcxb9UNkR6MBIyKDxWPtI5gf/9QXA303YGTelkor
 kOqOcFqr3uN+ERDZljaWy2tx9w3bYL0MN2mjJg42pzFvYNBkJREAMYcMMox+b6FGgaPJcn0S7
 bEGNBZPy5VI1BDtpkQ6xP67kY5WfINQLKcRK9/9fZiXtYlk+ChweaFKcL9h9EJqF7bQHdTIE2
 tzoykmGQUa4rVyfMcwRMG4En+nttlA5J4/FHsbLawY2+e0ZpJS5xRQ84TFE66MVflsUFyFW6a
 vN8qyCifTWpkIIfVJSLdBXKG4xjPKpnKQgstPmyNJr+O3D/OBaa5dxpdKHyQdHzp0agUdmTqW
 XZ15yc7ovZ/ZR3+TTDibEJ05wn4bwk5N03xeDs+O29N7t8oFv8Uqk1/knGHK2u/jfoXuGjLVA
 XPDaTUzrXU4lesqxUzerpBg5St3O7Q7g6RmT2dXN48M175IOwW+7Na2tYXuElNrrgkRIExiIw
 TqTOWmNJ8uQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

while reading the What's Cooking mail, even if I did not specifically
looked for them, I found some typos. Here is the diff I would suggest to
apply on top of the tip of `todo`, which is f9efee013546 (What's cooking
(2019/01 #04), 2019-01-28) for me at the time of writing:

-- snipsnap --
diff --git a/whats-cooking.txt b/whats-cooking.txt
index 8a43b74f7c0f..ed2464b43d02 100644
--- a/whats-cooking.txt
+++ b/whats-cooking.txt
@@ -312,7 +312,7 @@ of the repositories listed at
  "git checkout -b <new> [HEAD]" to create a new branch from the
  current commit and check it out ought to be a no-op in the index
  and the working tree in normal cases, but there are corner cases
- that does require updates to the index and the working tree.
+ that do require updates to the index and the working tree.
  Running it immediately after "git clone --no-checkout" is one of
  these cases that an earlier optimization kicked in incorrectly,
  which has been fixed.
@@ -332,7 +332,7 @@ of the repositories listed at
 * js/abspath-part-inside-repo (2019-01-18) 1 commit
  - abspath_part_inside_repo: respect core.ignoreCase
 
- On a case-insensntive filesystem, we failed to compare the part of
+ On a case-insensitive filesystem, we failed to compare the part of
  the path that is above the worktree directory in an absolute
  pathname, which has been corrected.
 
@@ -466,7 +466,7 @@ of the repositories listed at
  Will merge to 'master'.
 
 
-* cc/parial-clone-doc-typofix (2019-01-14) 1 commit
+* cc/partial-clone-doc-typofix (2019-01-14) 1 commit
   (merged to 'next' on 2019-01-14 at 0395de767e)
  + partial-clone: add missing 'is' in doc
 
@@ -713,7 +713,7 @@ of the repositories listed at
  A new date format "--date=human" that morphs its output depending
  on how far the time is from the current time has been introduced.
  "--date=auto" can be used to use this new format when the output is
- goint to the pager or to the terminal and otherwise the default
+ going to the pager or to the terminal and otherwise the default
  format.
 
  Will merge to 'next'.
@@ -1055,7 +1055,7 @@ of the repositories listed at
  unnecessarily.
 
  May need a further update, including squashing the tip commit to a
- releavant place.
+ relevant place.
 
 
 * sb/submodule-recursive-fetch-gets-the-tip (2018-12-09) 9 commits
