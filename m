Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A257202DD
	for <e@80x24.org>; Tue, 24 Oct 2017 10:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932408AbdJXK0J (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 06:26:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:57184 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932304AbdJXK0I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 06:26:08 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpsmR-1daKsL3Wbv-00fkU7; Tue, 24
 Oct 2017 12:26:06 +0200
Date:   Tue, 24 Oct 2017 12:26:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.14.3
In-Reply-To: <20171024014718.16476-1-johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.21.1.1710241221010.6482@virtualbox>
References: <20171024014718.16476-1-johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bsaxrLOF4MRPQTqmPa8UnoLUJtMIKq5qCJowm0/M4zfAQ7IHkSl
 Xb86BMdXOz3jK1jl0xbFhv27mVFh0Zd+GxX69pnjWhR13m9tmFizl1GS7uhLks8Y9kUgi/i
 c0T7Sz9GLDIxayF52cyVHVK4KDUwtMpjaqD835QqVh/7+L7wdQ+DlRZAqF0dXr5AkVJIU3S
 TxYUddoLDmYG5mAbXVs2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EkqU4spFx3U=:pk6QDZ4mn1e/IAbZcueFhN
 pviHbm64WZyFHYcfHMYHul6gdZeeZs+4m6xMp2UJe737ZO1/VdI0usi17+yLyVx6pbThQP+07
 spgvgQZaC7iQHCshcfM125lY/SqsftNOd+/pzlXnl2k6AbMjhNYrOrbtpKeuONnZOSfp1QSVJ
 Dkuv5F0xwESjjM0n4dAqrvho6hEST2ImzxQsKxXKEYP5GXTO2wU0MWaccZo9BaYJBF+Oa6fpH
 rENF5sZFRtWi6KBBlf5HLOwT+YPeo77VRsooY4F4Rknrrl0IVvskR46ca/qMpxQ5TV5lGpk0f
 UrwhSYOAgXlypMu807OnknCP6mr9jfEbE0So2fTNzAUrv7jEWSkAmEeWEGekMLRBPidBqNh9X
 6IsOIkw1Czvln4bHbYRDztfT6wAq0p8nflBHxVJfq+BPyjubZzLyR+R6e6UKOm0BHp791js65
 ynNE4wi7sehJxYzO5ImnsdrFQaWrSb0iKrI2ae/U7hcGINZfWXzOkRdCWs9ZsAtRbmlOTVNMK
 ZiNozQzyppyflVCYyuSFBKb3KMSn+jOg0H/2vOBMJxUSigzEf44XzywFM9eraBrBQ5G/yxrxp
 6U70EXx2c4rlsYO2w7nsO724wGTdeWxxZrme6nWYhHs5ouUFdZyjTnF+6XWtSUbsslEDTnxQt
 Au6xP58nCZPjs/DpWPZQkko7Aj0BSzjA8e68g5R+mKJxyx2GmljCkPNGv1kv7SxALZb918KrX
 q8thr0W914Av+kPx829qaS8Xk114GA3Aqx3MhrW0vmos/ICvVv7BPaU93DWvS83Q7jvt2vthR
 1Wl47DCwRyepBobH7n/4WL5hDp3TQXq9t0hdKiDtrLfQldyF9dAB2zHNISjQXWy60lqhlAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

On Tue, 24 Oct 2017, Johannes Schindelin wrote:

> Dear Git users,
> 
> It is my pleasure to announce that Git for Windows 2.14.3 is available from:
> 
> 	https://git-for-windows.github.io/

... and at this point, usually the release notes are repeated. In this
case, they were not, for a simple reason: I am working very hard on
automating as much of the release engineering of Git for Windows (first,
because it is no fun to do it manually, second, it costs a lot of my time,
third, it is not robust if I can easily forget a step, fourth, it is an
awfully low bus number, and fifth, it hogs my computer for hours during
which I could do other work otherwise, when I have a perfectly fine cloud
available at my fingertips). And despite working on this for the entire
day (and until almost 4am), a couple of things did not work correctly,
including the generation of this mail. I will make sure to write a blog
post about this endeavor, in case anybody is interested in the background
story.

But in the short run: here are the missing release notes:

Changes since Git for Windows v2.14.2(3) (October 12th 2017)

New Features

  * Comes with Git v2.14.3.
  * Git for Windows now ships with a diff helper for OpenOffice
    documents.
  * Comes with Git LFS v2.3.4.
  * Comes with cURL v7.56.1.

Bug Fixes

  * Git for Windows now handles worktrees at the top-level of a UNC
    share correctly.

> Filename | SHA-256
> -------- | -------
> Git-2.14.3-64-bit.exe | 9610e082b823beb7f0da91a98d9f73e1f3f2430c21b2c4e15517dea4f981be3f
> Git-2.14.3-32-bit.exe | 6e5a8a939f3014b396f58622954ab394d7982d036c84571394118f2360bdca96
> PortableGit-2.14.3-64-bit.7z.exe | 2b1d952078795117a8c4549f6384275e047ebd75c10bea77e675f8b672e6d87a
> PortableGit-2.14.3-32-bit.7z.exe | f2dcb32c3133188d0b7a2c3683adcbebcc10b054467e1754d1b8b7e534a34494
> MinGit-2.14.3-64-bit.zip | 538294d2b1472e561493b67855f92380d8139011c74be6bf3cdc5b5d321b1345
> MinGit-2.14.3-32-bit.zip | a91385acb1da220612790807c41d0f304b41093c474b9d7342230ec194a3398e
> MinGit-2.14.3-busybox-64-bit.zip | b7710c7668d7ad3f1f5f7530b601d9bafbe66fcef5563c8ab74d442ac9478d8e
> MinGit-2.14.3-busybox-32-bit.zip | 8982fd12c60a9edd1b6f5f8465354534920bae351d38c867a2f4034a807d8231
> Git-2.14.3-64-bit.tar.bz2 | a5f09850334d5069afa0013249cc6678a7cde52c673823e5386d5cad9df41f10
> Git-2.14.3-32-bit.tar.bz2 | 644b7d7593e675f68a5a011d19a0a917430b79fb815f6260b807c00651696fa2

Ciao,
Johannes
