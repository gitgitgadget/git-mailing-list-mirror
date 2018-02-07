Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08131F404
	for <e@80x24.org>; Wed,  7 Feb 2018 20:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbeBGUCI (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 15:02:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:49623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754266AbeBGUCH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 15:02:07 -0500
Received: from localhost.localdomain ([65.55.188.220]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lq9Ma-1fEQsm2ruy-00dqGF; Wed, 07 Feb 2018 21:02:05 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.16.1(4)
Date:   Wed,  7 Feb 2018 20:01:57 +0000
Message-Id: <20180207200157.17672-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.16.1.windows.4
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:xTucmJPJdcnYPjexwWbxZmoC8xTYpagO5jxVFwTFxDQjK53S+0G
 9k8zrC2Vq3WJkVQvGmTsvkFkdrn0EAawhtHCfdOUyLT8XxBKw48Q7Www/h4yERg3PtlrtRX
 KhugqXcZVZ/EaL4ngbBl4hPXcYIthJZdn+anvnrBdYs+qGqR+XR3J0ZSurS76QR8b/+92aK
 7j4Jeh4+Gn61hB7lmNOkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+N5ew/jKaCA=:wUE/r+88Met0Rk0m4oKZv4
 ycoLT0AwOwqZ1nGsrn6ClKT4fPXT65hC9h8t1x5qJqnCuMEuHHN9XpnmdnTo3qrsSEVKlMbZ0
 KENvz7Jkqfzs9yz0IH/FpX79GWcHcc870ZaidP4Jzr/eNDFg2CIR0SeYovAhmwEl39luuvuxd
 OPmxWOIxsjQlkg9w7weiyf0qFJN76204toC8PjG5pHuQMw1y93VBBYnevH/SSCuam+/rnsLOj
 GOel9z/FFe3NrCjWITZQpi6yRoPfsOi/R1ConISEOW5Xhe0WFj26hp9/oMURdDJehb+igQYdf
 VtVs0Pa5S5moe59qi30dMBKFPplcReZnA5+hklYtQX5qHSvp5kACHH7AnYsgKJQD+1H8dEL7d
 H9y1HaULtSpp4e3gYXWCUHCPpL4mn+NzBVTo4nTxSl6y/HhIqeKeuwxy3/K6i31lFVn1GnSgQ
 U4F17IH2wA+1ZqC1sUxTjwkmKrYTDp8MQbqstBDvEjM+qnQZu9EniQ271K9dMi5tet6pg1T+i
 pWuOTwm/mfOn8CpTjVfBXHNPwWMwboXXa2Lm0241rzsjLK7awqtyThT8NoXofpAOX1q692msE
 Mdxj/v57J5fYLzAImP4vr7WCOWgJgiPsxnWocS2egEvwPxc0zyELQgCg8xhcrUXHwORmpJ7Kp
 6PljhwEXXxUYIJIvNuM4yS0XcszYRtHmJFinkDDko4QUTeplytADloaTpWmVqDFfl/MNIYXgT
 VRz09AF+7GzipqK/h4OfCSpxfE1dFZaIg07K8gPHnEBeJ2buzqLP98ZDdDIIhD1nCtIIG2ek6
 Zp5RKQN8VyOhai9+G4jife6JZOUHbkFT8zWgVyjyVFrAlKAsNY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.16.1(4) is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.16.1(3) (February 6th 2018)

Bug Fixes

  * When called from TortoiseGit, git.exe can now spawn processes again
    .

Filename | SHA-256
-------- | -------
Git-2.16.1.4-64-bit.exe | 5664d42d6ea636f760e6f926bf2239c30782742af6b10d5fb7b6541ba4356c8c
Git-2.16.1.4-32-bit.exe | 742234e477afdfa07c446758adf7234ab2cd7231ba3bc17642073dd1267cc55a
PortableGit-2.16.1.4-64-bit.7z.exe | a2191f676d77f8b8ba88501b8d373dc5418845c52dca86313ec449881af14cbd
PortableGit-2.16.1.4-32-bit.7z.exe | 5d3e89163cb8b88484d906f8ba53604279e3d7b8c170e39d89116aa5c7274f26
MinGit-2.16.1.4-64-bit.zip | 4185d4510a82ca1a4f27297b800e9851832a183adb5a52644ae129b395c60fa6
MinGit-2.16.1.4-32-bit.zip | d8bd7f8d8145a0ba961a91884acb6fdeadd580b28b77218a833c1ade498b6aff
MinGit-2.16.1.4-busybox-64-bit.zip | 28fbbc5c9d8ae587b332484dca8a8bee275560e40f5ebf41e9767c0cdadd40db
MinGit-2.16.1.4-busybox-32-bit.zip | 170b4dffd84f781c03d98d16e89b772785a3081c4b85c91d46bfb53f5659c84f
Git-2.16.1.4-64-bit.tar.bz2 | edf22fd92f414a930a8dab4916930fe0b74bd0cf6ae664aa9600360a2ed52bd1
Git-2.16.1.4-32-bit.tar.bz2 | b5c0991479a29369841da78e713a850244cff6a600acc16803cf35c5dfe5fcdd

Ciao,
Johannes
