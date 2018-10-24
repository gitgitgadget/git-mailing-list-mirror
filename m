Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F2B1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 08:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeJXRUr (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 13:20:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:46357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeJXRUr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 13:20:47 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmrUq-1ff4ku0Dl6-00h4YJ; Wed, 24
 Oct 2018 10:53:28 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmrUq-1ff4ku0Dl6-00h4YJ; Wed, 24
 Oct 2018 10:53:28 +0200
Date:   Wed, 24 Oct 2018 10:53:31 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t5410: use longer path for sample script
In-Reply-To: <20181024073705.GA31202@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1810241051440.4546@tvgsbejvaqbjf.bet>
References: <20181024073637.GA31069@sigill.intra.peff.net> <20181024073705.GA31202@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ctmCQaT4QpRboAeL9GCY94txcjLVYbaAr04w+87sFu8bJZ0cpVV
 pD7qdHnJlIzlpqpCumw3QBSHhkgqGwan30y1+YIQ8n5DRFSnaIqFxQUMX3cFw3jWzWRSOEN
 k7mDhW3KKlOsZOim0bYfJFAdgeAMQHnpNNgGRvO8nnQbIjyCCDPSOMLbPxKswizLPIqJu0Z
 cYAB0p//LPFvKv/fxua+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8bXvM0tNrnI=:e6xg1p66AKZHjuA/Uq8YVv
 hqFA2j+WMVzRhzZ0Cd7jEHfxo7HS5DViFoyRB7zzO/5jtD3c+9MMW+TmDs3Kychn2YXM7BOYj
 sZnGGDb91LaA1WAb4tTYo1ugajmgm8y5C+2Ptz7OO/wueOYA4Gns+oFASJ6GzeFaW/T3BJqhl
 F26u9hPjc32cIxKF9a6Mc7iJAW/yb6H/lM7wMn+lkgO9G73z1lNI6IIf03JaP5xHrfxSIds+J
 a6U1mwQR8A3sV+Ez1ociJYB1BDgA6rKoGST5HvDtWvBsSDvHLnIfNaS0CDahBnDNtaAFn2X4F
 tlfDaa4i2WsKCpJsM7Za790msV9wYIawNEfKuNQYWnh4hFyu+fKFccVwCcH7RQIRudOPYQERF
 fNfb9S5I5tF+XRnINM4siX4BvKo12Cp720lZ/wPBcXGrglLRpkMqnEaoGjmmwRAdS5x0CIQ2P
 l/nMVJ0/SStqukJSnX6va3mMBSv+l8XR7W7CxZJ6UD2KD+K03yt/5fME/qw8NXci0GeNrxAQ2
 KIqzL9Oh5H2yMLcd6SB/YSYbZUGwFkIxrU7ArYl0LzfYrQpPqsbZy7PTfcm0Qjq/L/FOIhtIi
 4i2xezukV10t3bbrVQpg32XnOdo1fwJL5y8hK6B3xrTO7G1J2mArn1lFSyrJ/ep9zY3fwfDtm
 yke91Ds/cyleXoW4NtKHzXLkkG6MrJNAJIZl7+GTIPAtk893H8aGstA6DtgIuT47tXOHQTxW/
 1cmzd5oI9z7+1XiK9ziIBHhyXK1oVzzsgZXVjUa/EFutOrZ07itiyesAy/u+UJIzGm14viVZM
 b6nX86fa6MbIjdEt/zunbGOPbwSW8pAmxCfpT8bh30iwDknBvo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 24 Oct 2018, Jeff King wrote:

> t5410 creates a sample script "alternate-refs", and sets
> core.alternateRefsCommand to just "alternate-refs". That
> shouldn't work, as "." is not in our $PATH, and so we should
> not find it.
> 
> However, due to a bug in run-command.c, we sometimes find it
> anyway! Even more confusing, this bug is only in the
> fork-based version of run-command. So the test passes on
> Linux (etc), but fails on Windows.
> 
> In preparation for fixing the run-command bug, let's use a
> more complete path here.
> 
> Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Thank you for the fix! I can confirm that the patch works, and the commit
message is stellar, as per usual for your contributions.

BTW since this breaks every single one of our Continuous Builds on
Windows, I would be very much in favor of fast-tracking this to `master`.

Thanks,
Dscho

>  t/t5410-receive-pack-alternates.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
> index 457c20c2a5..f00d0da860 100755
> --- a/t/t5410-receive-pack-alternates.sh
> +++ b/t/t5410-receive-pack-alternates.sh
> @@ -23,7 +23,7 @@ test_expect_success 'with core.alternateRefsCommand' '
>  			--format="%(objectname)" \
>  			refs/heads/public/
>  	EOF
> -	test_config -C fork core.alternateRefsCommand alternate-refs &&
> +	test_config -C fork core.alternateRefsCommand ./alternate-refs &&
>  	git rev-parse public/branch >expect &&
>  	printf "0000" | git receive-pack fork >actual &&
>  	extract_haves <actual >actual.haves &&
> -- 
> 2.19.1.1094.gd480080bf6
> 
> 
