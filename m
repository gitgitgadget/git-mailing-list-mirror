Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139331F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 13:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbeKNXzk (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 18:55:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:51041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731746AbeKNXzj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 18:55:39 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0Ppl-1fTJEJ46ij-00udXx; Wed, 14
 Nov 2018 14:52:07 +0100
Date:   Wed, 14 Nov 2018 14:52:05 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        gitgitgadget@gmail.com, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] rebase doc: document rebase.useBuiltin
In-Reply-To: <20181114091506.1452-2-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811141451460.39@tvgsbejvaqbjf.bet>
References: <0181114090144.31412-1-avarab@gmail.com> <20181114091506.1452-2-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1239315993-1542203527=:39"
X-Provags-ID: V03:K1:pHW3upBAI+AaOVkclRZ2rHXk8nIaC84FTa1XfM6pfljw24njR3U
 BeXhr/IOk5rvQZ5SZiJou9OGJfcxjFuNa/HGw7uvJU78XCMAdcdLgi85N9zhyDNZ5LvXFu9
 7efCXUbAT/6au4WwLNfHCMxguO4mf5CtWZiUU+kgPYhZOiYP0nxJYQ9S4/DKUzXLMp4AsVb
 cVB/j9TpyYFv/qIpfR+BQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vPKD/KDJ/ms=:qddF3O3oQzEePRMNxiQ1D7
 zUhNH/JbmqqQEwWuEtWsVS7ynPWpBsqi/9Uom00+bFyZ2ASZWmiPmMU6Cl8Sr97djufYN6A2W
 MwAz4anLDVcMRLzL28ZJAFThMfx/l+5Kl2GX1Nl+oC7ibJn1B2yhLnEh9sinLYSkIkC9wuDW0
 xH9yNUekmZq7Kuy9NYxGDvsGRA7sKJGVzJO3TC3zTcN1fMgBnPVV39R/Rbq3Kg03iCInt5qZK
 PXGOsNPEZhKalYvfqfc2Z8pmlcO07ood/BKTnLsOiNBLCRk72vbw0LNAZBTLpgzEb2NFCkgo3
 a7nvrEWcFdD+fi32dGx5hpzACxaXiCNWhlAkQE8go3T7S/WlyKKMF2PibLw5gf05oWyAX3jyx
 jdwqX3zIYu/MQicA5F4zM/F5DvKA6pXYVVLw46UdjzIoJZPfAhAF8mW2eMXHyCqnyun+BUy1K
 BAY4vqfd1L3RrVGHjU1xSg871ov2sFs0DWVnDIFkdIxa/W7Zbjw/Y9O72dATO8sEyoZDIZVXG
 AnMxh+O5ajyLgbXZoNwLKNqXBO0bK0eypthyAY+o5n5kytYNl3RFb3eBRzFf+NLw24bo5ahK6
 gKpmMFgPJSK4YFsOj3lqLiOPBUoY2BfUDLbewO+QyarplRI6VXcFcxPIercb56udzt10D/DeG
 kwrVmLzCAt1cLWcYSV2E4MvXNPAEUnbVHDCRR0WZJcOTjCiqV2UNuRv2hhgyJeOCgWy8qrxye
 SBRG+UpHdLNXC2jy3Te2CGMa9FVlhgtv9MvYN/FfDm2UL0i/IBPnmlvkr+9I6ttRhMraJDKZQ
 by7bfclctlIBFFqkesfccD2MTCAxPq46AOPOOuLPHZdO6LYB6W/4a3OwZVaaJW9gLMqs6EOU8
 b25HshoUZWH5RkBGXP2aY8kE11z8DwthVeVlER3aw3T3qo6Qh50k3NNu9rYcC7KaRGNsbRXIv
 qeIUtbInbEg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1239315993-1542203527=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Wed, 14 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> The rebase.useBuiltin variable introduced in 55071ea248 ("rebase:
> start implementing it as a builtin", 2018-08-07) was turned on by
> default in 5541bd5b8f ("rebase: default to using the builtin rebase",
> 2018-08-08), but had no documentation.
> 
> Let's document it so that users who run into any stability issues with
> the C rewrite know there's an escape hatch[1], and make it clear that
> needing to turn off builtin rebase means you've found a bug in git.
> 
> 1. https://public-inbox.org/git/87y39w1wc2.fsf@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Makes sense.

Thanks,
Dscho

> ---
>  Documentation/config/rebase.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
> index 42e1ba7575..f079bf6b7e 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -1,3 +1,17 @@
> +rebase.useBuiltin::
> +	Set to `false` to use the legacy shellscript implementation of
> +	linkgit:git-rebase[1]. Is `true` by default, which means use
> +	the built-in rewrite of it in C.
> ++
> +The C rewrite is first included with Git version 2.20. This option
> +serves an an escape hatch to re-enable the legacy version in case any
> +bugs are found in the rewrite. This option and the shellscript version
> +of linkgit:git-rebase[1] will be removed in some future release.
> ++
> +If you find some reason to set this option to `false` other than
> +one-off testing you should report the behavior difference as a bug in
> +git.
> +
>  rebase.stat::
>  	Whether to show a diffstat of what changed upstream since the last
>  	rebase. False by default.
> -- 
> 2.19.1.1182.g4ecb1133ce
> 
> 
--8323328-1239315993-1542203527=:39--
