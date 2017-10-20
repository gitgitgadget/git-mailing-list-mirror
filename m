Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8281B202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 22:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbdJTWW6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 18:22:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:56145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752227AbdJTWW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 18:22:57 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzYY2-1d9wOF3FFi-014ihq; Sat, 21
 Oct 2017 00:22:53 +0200
Date:   Sat, 21 Oct 2017 00:22:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-for-windows@googlegroups.com
Subject: Git for Windows v2.15.0-rc prerelease, was Re: [ANNOUNCE] Git
 v2.15.0-rc2
In-Reply-To: <xmqqr2tygvp4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710210020290.40514@virtualbox>
References: <xmqqr2tygvp4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uGssfKNvDUF6cekqQI6QQStanQq1tzEoOb/rVIZuHMTUR+J0tth
 7dyZ8o5DGAFYkvf7A5zFrzSbHNmshFXXA16IYikxWMKTyVcSG28apIivqL9xYTjjKkKAVy/
 EPq8Xo4GB47B0trPsENqCAzLkMYKr+lL7HlOkSlGm6uug5xlyVT6v0QzpXO/8BBUZg0qtcR
 YOvj1s3KngHrUeXlbCOBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TCHjwvh56Lc=:OSsJcSHs4N2UDanmQeezeh
 Li5ffPjXbwZ8/pq6bq/AOG6d9thVdcT1UzusI/6C5UUBqajxClT08OAKlOI78fivvTVjFLrFq
 MAW5ep+9/N4bFttd8Tw3sfOyrHAMBsZzixslAG/bMC8RcLIw7g3rGR9+Q+2pYro+sZlt83qRd
 oDX/GkMd1rs+Ip77WkU4K22WyeeZfC/OpC4i4Gb2sAQqnJugUuWBGfQ8173N5UdhVqlqpFi6n
 hupHgBkezHDP/n36+GgtANq6pHY0gFUgOoH3beAe2Lwp0un7UP1ZHi2xWMKfy/v8/ehcRHG/H
 We9fHfrkY2EQim/V2SWi+Ww51UMPSlUJXusykA3JIqp1qElAG68p+WtW/PEodESBOo310GFBs
 DUeLym2fhfbOzifVXwvbPtfbKW/UBSzfumjvz640NuMAkP+1uUZ323ca4TLu0oVz4UZiD8tt+
 gHoz/R7U0VbNLe02FUgRrX+MoDM223Ub6AlIlcN6AUlIFc29v2PjgM9j+ofZu9Mf2R+Kr4I0l
 Dj7JI1V3FjlhscpQWNVxbV8sitdMWH6hcE7pnYuQlatqHfXnvg3S2xow2qCB/dbPkqUlTEesW
 3DD4f9+fvQceQsL76Ps73fv4qDuHxTavLOTPrmCnLNFaLHSNLeO9QTljBh3hY83v9T7CySQsf
 BmfjEhSyRXes4tY/MPcOCcvVPNNXcFwYZ8+vcZdE7mMBWFXpPzVxSJCQYe9b138Vim6hD7S9G
 aTpNlasV02TTdlYvKVCHDZZGPFo/1KREv2MF/3nfZvYPGiVU93G6r+2OIKqYFVKClUF638JXA
 2uiZ0yO5nvkykzCUkVIym7jPaoOYWtsRqOOjtF8hWwjHZi6d6BQr4A2XezkiXlUYjZqkkJM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

[cutting linux-kernel]

On Fri, 20 Oct 2017, Junio C Hamano wrote:

> A release candidate Git v2.15.0-rc2 is now available for testing
> at the usual places.

The Git for Windows equivalent is now available from

    https://github.com/git-for-windows/git/releases/tag/v2.15.0-rc2.windows.1

Please test at your convenience,
Johannes
