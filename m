Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74615207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 14:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932885AbcJLO0T (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 10:26:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:62663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932751AbcJLO0R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 10:26:17 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MaE4a-1baT7p0a2y-00JvdI; Wed, 12 Oct 2016 16:18:09
 +0200
Date:   Wed, 12 Oct 2016 16:17:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer: mark a file-local symbol static
In-Reply-To: <376d8514-fe01-cc37-691d-6e101af564a5@ramsayjones.plus.com>
Message-ID: <alpine.DEB.2.20.1610121617410.3492@virtualbox>
References: <376d8514-fe01-cc37-691d-6e101af564a5@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aLDEFxSPpwwldobsb38jowGwNYK1RyizwNAXRUkFuj1uZi504Ib
 b6k3kOairUVvn/zrz4c0ibhKnxWPaZXSenCc5OXXtO270hcLYBKO3je2uZkf5Bw2mdcjKdj
 RHMOEHJkd8QVwPYGfOjrHwlIv6ix7v5DyvrNW9bXyTax8GtxbdUsIFTnExxkYiilPsgWi/E
 bT4JBoByf4cxcVPCIzppA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tEYsoxKKCm0=:H61tAsxD3rnIPTdp6PhVFU
 +ElDzz7cCtcnS54gRmEWeQr5MarCeEFASU6+5FgHO/kMzM5Jc5B3zMattIM7k17UmFYBn3KXO
 l2WKQObjJT4IYjo6Ekebgr9BtfEcPg9NiUvzFTLCQZSZ0rnagwuZqE08m2rgITct281TqKihB
 yW+b+XkRZHRetrj33iwkkQb7uAXDC770Ygnw1wxnFp7tbw6Watdj8hukA5wSut994PPuNpCI/
 ylHcpBJ7OE9+9DuAlVx3184oArphcTjbHpnVZWkjBqQvxyIovVDA+/2Leyn9FApC4Z/6J4GNi
 5YDLCdtA+t5Iye0O9PhaJFFrmCy59NB84OWrT3ZmyEa2gD5Zw3tJWU7rF3ThkZlUWts/ZpeM+
 0WLG0VwjWK7I2p03Z408x/5EDH2YX41oTuhSGDDdUFMAMjmTR23oMzh/xB/+jpOe55PvaAbI+
 7ny9Ug9sz1BdggSn+IzuwkNfFHrbbzuNPXHCoJp1DrTG/731N9gRef6qKs2HgCND27hQxuETb
 /racPMVSAvV1yMq70ULu/rGojtJpPsQb7EYWPgll1ffK5uYTEiLlcpuJW4redEMS0bthCItml
 jqF0ocG1PYRkqwYJYiY/9u5f7ZEX0de/FpflzMaF2DCahpG+RQy/FwaSsPKCH5k2f+Wy7K/r1
 DnH44o+75r2jx/vG5qX2Zl3f9h1goYWCp2x0x6iFapUdMmKSd8cZLVtEg5w0ZkPDIfq4U2Wzf
 ekTrxMX7/ushxmazwDct7L3NfvfZYiSJ4shX+HnOzyI2KGW7ysuGfKYL2G5pQYSM0Imvrr8an
 4PT26On
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay!

On Wed, 12 Oct 2016, Ramsay Jones wrote:

> If you need to re-roll your 'js/prepare-sequencer' branch, could you
> please squash this into commit 53f8024e ("sequencer: completely revamp
> the "todo" script parsing", 10-10-2016).

Will do!

Thanks,
Dscho
