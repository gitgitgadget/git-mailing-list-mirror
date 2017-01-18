Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F49D1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 16:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbdARQls (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 11:41:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:53732 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbdARQlr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 11:41:47 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMShK-1cLcNN32g2-008IJ0; Wed, 18
 Jan 2017 17:41:43 +0100
Date:   Wed, 18 Jan 2017 17:41:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael Gooch <goochmi@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: problem with insider build for windows and git
In-Reply-To: <alpine.DEB.2.20.1701131300390.3469@virtualbox>
Message-ID: <alpine.DEB.2.20.1701181738490.3469@virtualbox>
References: <1bddbd50-86ea-6c38-6ab8-08336de2ba72@gmail.com> <alpine.DEB.2.20.1701131300390.3469@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MMlRnzf8CUK2KNg4mndsHKQwvGvR0IPENiCRzxONmsZiDE9Cku0
 ehJuvywax539hrGBknZcqqK1a+nDexGWmLhzXVFE/Zd/Sf/hTIn28rMyYuGOIenwvODsYh6
 0753rvDvYNeg3ATkjaOpwtTt6PjzT5NKmG8drW3K5fBlK9HgnEhfjBYVoZv4T9lCwlV5Owj
 K+9nPvM2hswJjKHqeQVJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r1+M7fbO2TQ=:C5R6HU1hg2gI7rOC3q8g95
 RmYKCsW8GCobtoYfXPF34oTwub9UZ34Z+YX7bcp1QzqLJC7+bbKnh7t3spdKIRbMbxpqCxAKC
 TutyPRbsGNLazdQEwqsXhD187GmOWCcN6JJSRmeT3mUYqF1raJQv/YQAb3dJ56HxXSGQV8DFP
 2i0aXscn2KmKpX5uQ8EmBxdDOSp9mox28XZhZdUtvjEyuIHtb+8uBFv2kA24BemRMfseaVmSO
 efgIQ7xwHTkeK15FGFyLYGK6bmj9sXy9MWJztUSddbqJbwNOGTc1cPFPR3tnyFafsaF0xV1OY
 kcup/OB7L2XHPSXr37h7gb6b016itwSpOz+zo1pABrGiMGYFF/oCYy/wECD5UZts/c+BdoddF
 WeAiimRsXmihiliuTm6Ja/4dvK1GpZGuAoR/A+fy6bn1cax4zFHOLn3tOQfGIN5iVqe1cm38B
 GHIVLN4Y20NZzQC8KKElmQhFxupF/KpBcO/qOEvEABed/baXpR2uBqtwc+T5r3lLDYqAoKsYc
 TroBvDq5zM8rWfaIvIbsY8ev/g5T05oHXPfphQlco88HY3pC0e/5lh+t8BCwOoI8wCSd4uDI0
 Q528Ezz2NI1oDGHcyufTvN0bcVo3chfu63KPEVfBx9L9r2XYYL9OggloFcCEJvDsOv1bQPlaR
 QlSbmz4EPDXQhiUWQ2AdXlsIJ4m1E61sOvf9mA6+eApUxhZQ5wSffEc7axQXFQXTbFS5SOg4n
 cyfNBwx0inwCadIbqDXVHLQNrO4h/rqTcP4AXzPDdrkR+lKxpcQdf0x55CMq5UWx5NUMJYbwH
 ejUOVb/XDXk2za3LiF00P0XZZALsbKrCcwgH0shwZ0h3A8aY8eZ+IcGnevOHLBB85Ccqdnxgu
 rJvl0nA3/J8LckAX0jHoBaNO1+cMfrVdFhGUzWXqkxsiBMb1bV3C+gF4K1RAD/CmHY0GkS8OH
 YelCV3IjGTMsOA1cdiyepSPB8UyqPKRvXQvLsQYsvvst2UI5Sb6td
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 14 Jan 2017, Johannes Schindelin wrote:

> Footnote *2*: http://tinyurl.com/gitCal suggests that Git v2.12.0 will
> be released early February soon after Git Merge (and Git for Windows
> v2.12.0 will follow soon thereafter), and with no patches applied to the
> `maint` branch since v2.11.0, I do actually not expect any v2.11.1 to
> happen before v2.12.0 comes out.

And just to prove me wrong, today I got the first update to `maint` in six
weeks, with a message "Almost ready for 2.11.1" at its tip, featuring a
whopping 141 commits (95 of which are not merge commits).

So it seems that v2.11.1 may happen soon, after all.

Sorry for my misjudgement,
Johannes
