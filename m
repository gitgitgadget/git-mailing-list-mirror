Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4474820C11
	for <e@80x24.org>; Sun,  3 Dec 2017 21:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbdLCV27 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 16:28:59 -0500
Received: from mout.gmx.net ([212.227.17.20]:62043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752499AbdLCV26 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 16:28:58 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LoaCE-1f26Yr1922-00ga9X; Sun, 03 Dec 2017 22:28:19 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v5 1/7] Documentation: revisions: fix typo: "three dot" ---> "three-dot" (in line with "two-dot").
Date:   Sun,  3 Dec 2017 22:27:37 +0100
Message-Id: <20171203212743.10228-1-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
References: <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com> <20171124235330.15157-1-bedhanger@gmx.de> <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com> <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:BHtTfA+u256qkzUkHLLV66Y1e3JceXlKxn0D8Wo0XMpMETOYMAv
 KtcRp4JRoJOZ1R0NRJHqxGFX911XG2iNM4iSeLsgEpwTipA26ZyzWipykUEmwOODMA44CI9
 Cc4XaRgHHpcWWXUoBcjgf3uIDFLWJMe94wvwvuN5aEhRNGIvnv4oiwscALndSwqU6fyMHR3
 ktkt5nDzUMtpO3WNTY5Ug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/Uj2HNXQFKQ=:qhw9cx9tWekpe6KuFWn9nN
 +DFNKq+DLqqRxw8fFnIRMIOP2UBhs+E9c6g6iFu2oxQwM1sM6fWaRIfrQ7uDDfTT61oTcUOkZ
 8Uj47f1tM0Yym15OIrZ/XYmQrWxVUhChtKgEsQGcBoKLRNbYQzNRw6XKWYqxkjaF3U9AyePI1
 hR391DVwIbSUADQVDoL04VBPnSIpnEE678z7F1AVZElwnYqhWYte89CSIRb/DpS9bgaTTpV9o
 8DzO516T56u8mxojsw7w/dGl0bbhrtN8Hhs6TpDuhVegrXwtQqj1KKNZzJUx7dLJujPUIu8a4
 /IwQdlVz1a9JoOQ9Kn9izZBExdvrTxvvw4INS3/V3tnVmXR/WHoJeAzypeACYqW0nOn1Eiak6
 yVIZK/52o+CBfkg3/4Cw6jx6Va/wFtVD3fLvfAxgIhcXm9uVBgbUgtd3+RJlu+N7tKnnLfCSV
 hmWSUZjApAzax8PkX9JxPSaBpUjXYRiQABJvbznoxPFB0P8TgdQckfGi7rmq8Ojyqd39+AwP8
 ctoDzX56GVW27LlYnGOOZS87PnPVcqVkxpdSWYJwipbEy3XBLg6wWP59T28eelaGcOSvdE88j
 9VoMzeEJEnX4XDrobb1aSKkMj2uMGiYcEaXxaMi7BOUxvhIecww9J9rYpmDPhNSWzFl2HnrEH
 tzvkxJZ1QagDCifo6QkUwGzcw/FmNtrPNIbA3ULZFLX9S8pb+heWO3FDmcVgdyCMaMyuWgPPC
 lp71alm688vJLlkkyLfqyHRjZmQwCyKiRTunl0VoL+gGSOCN5HFVoliq8+iAwIGfY5p7CGZEU
 KylwCSUia9lqwGQBMTPMaGxpv3Zig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
v4: improve env var handling (rename, helper func to query, docu)
v5: rewrite series to take Junio's comments in <xmqqd145k9td.fsf@gitster.mtv.corp.google.com> aboard
 Documentation/revisions.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 61277469c874..dfcc49c72c0f 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -271,7 +271,7 @@ The '..' (two-dot) Range Notation::
  for commits that are reachable from r2 excluding those that are reachable
  from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
 
-The '...' (three dot) Symmetric Difference Notation::
+The '...' (three-dot) Symmetric Difference Notation::
  A similar notation 'r1\...r2' is called symmetric difference
  of 'r1' and 'r2' and is defined as
  'r1 r2 --not $(git merge-base --all r1 r2)'.
-- 
2.13.6

