Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C4A91F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 19:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeKUG0u (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:26:50 -0500
Received: from mout.gmx.net ([212.227.17.22]:54289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbeKUG0u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:26:50 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9eHT-1gIHyh1b2d-00D0QB; Tue, 20
 Nov 2018 20:55:52 +0100
Date:   Tue, 20 Nov 2018 20:55:35 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase: mark a test as failing with
 rebase.useBuiltin=false
In-Reply-To: <20181120114208.14251-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811202029110.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1811201157170.41@tvgsbejvaqbjf.bet> <20181120114208.14251-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1121995470-1542743331=:41"
Content-ID: <nycvar.QRO.7.76.6.1811202053390.41@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:zWhqNeyHBrwxy9yHNFZmthh8Bm3YPgOvCM8vM6xFO//Ho55hDKa
 B5sIpvS7puWT7WVYX83qw2vjhGDaUUR1SsX9wdnjDNOjSIUKBmzyuiyn5Wwra4RbyZxL8nx
 TMyWOjB2W5pO7Fc/NL8TLRUyzZ5qAASdqDu7rHk40mgB0hvzMR4BF9bYVgrEDQkA68EDKSp
 6mNXP46WA5U/kkDP21EIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d09OgQbA4eg=:JrHXrvEQZSPVkV5Qw2DS3b
 hMatoRx4yEIIN9u637ZQULbmX1eO1/lTJRE1POEIhPfpTOV7IYg3E7p/u8i0JvNjjou7KJvqo
 xs3s47KfTYcC8oTLvS2pxHUgJ7YcG369UftaoI+dRPQ7vtY8BbowekC09hRXbeVyp+Rvzxvqs
 v8zxiYYq5AQSIHKHE3l1cDysvdeENoLkm1mvl971aCSAVufbrKf5VtjGh2e1hLBwllEfL4YYR
 W19LpITy/yeY/+ifJgGkjVdLYNhhw05Kz9i21Yvjz4aog6HGFNW7nc+zJJZsj4OckFoYR6mS3
 HNmKr+Fy30sLB8gfNOjXnYE69fCYc9DutAb3+e1MzzEb6g6DxCLYn79AsrDExv8X2ZKGctT4q
 OBfF4w9N/yuaY5un4+IE2t5rntN4k/t98iIpHIpdMRzY5GlkAQqdCb5wxfMktyywnYT4jyAXz
 L1vhAhGfHvC9w59DnupG4fCLgnzt9mcyTIKehukevLgb20IpGW4OX0T9TFQJjWH4XRKtMXolX
 zihWymH42himOwOUYs7NG+1Vs9nsplrlb0bGdMUVGs+pzI5I/Fi3jrIarMu8qmySNGzXvhYZc
 FFcvGw9mNB9ite9pHBIkPb9nn2pD+PT1cFagWxGWhORjjBSwYVDUB/wmn09nrFpa2NVhLSDjt
 x/QaHo2FD93O85my/xPMA9zCinPu1ZxeLGmgUmdoSUWU9UajDIkwCFlIPX3r74UZ2SGlX1qUj
 yJMe9nMUSuNNEdP/gkm3eCPoAdfGuvRIeT7w7GO4Azq3JcaNpaCKwvSGoMeVEighxHBQiWkNp
 o0AZddk351dSBME5OALdd5xYK5QSVpW05eQXNojuq1XU8V8AdgvPCFOvlHa5vn2GCQNKCxNC7
 hWPE6o7tnVy1h2EGR6D1mHvD6CIs6z+JSUiXCEnUXghHLchhTalzJtMfzxmxANIbILT12HqRN
 epVK7BD9PoA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1121995470-1542743331=:41
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <nycvar.QRO.7.76.6.1811202053391.41@tvgsbejvaqbjf.bet>

Hi Ævar,

On Tue, 20 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> Mark a test added in 04519d7201 ("rebase: validate -C<n> and
> --whitespace=<mode> parameters early", 2018-11-14) as only succeeding
> with the builtin version of rebase. It would be nice if the
> shellscript version had the same fix, but it's on its way out, and the
> author is not interested in fixing it[1].

It's not that I am not interested in fixing it. It's more like I hoped
that I could work on Git for Windows v2.20.0-rc0 and rely on you to fix
this bug.

Now that Git for Windows v2.20.0-rc0 is out (see
https://github.com/git-for-windows/git/releases/tag/v2.20.0-rc0.windows.1),
expect a patch soon (see https://github.com/gitgitgadget/git/pull/86).

Ciao,
Dscho

> 
> This makes the entire test suite pass again with the
> GIT_TEST_REBASE_USE_BUILTIN=false mode added in my 62c23938fa ("tests:
> add a special setup where rebase.useBuiltin is off", 2018-11-14).
> 
> 1. https://public-inbox.org/git/nycvar.QRO.7.76.6.1811201157170.41@tvgsbejvaqbjf.bet/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> On Tue, Nov 20 2018, Johannes Schindelin wrote:
> 
> > [...]
> > Maybe you can concoct a prereq for this test? Something like
> >
> > test_lazy_prereq BUILTIN_REBASE '
> >       test true = "${GIT_TEST_REBASE_USE_BUILTIN:-true}"
> > '
> 
> It's better to just mark the test as needing the prereq turned
> off. E.g. this is what we do for the split index tests & now for the
> gettext tests. That way we always run the test, but just indicate that
> it relies on GIT_TEST_REBASE_USE_BUILTIN being unset.
> 
>  t/t3406-rebase-message.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index 38bd876cab..77e5bbb3d5 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -84,7 +84,8 @@ test_expect_success 'rebase --onto outputs the invalid ref' '
>  	test_i18ngrep "invalid-ref" err
>  '
>  
> -test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
> +test_expect_success 'builtin rebase: error out early upon -C<n> or --whitespace=<bad>' '
> +	sane_unset GIT_TEST_REBASE_USE_BUILTIN &&
>  	test_must_fail git rebase -Cnot-a-number HEAD 2>err &&
>  	test_i18ngrep "numerical value" err &&
>  	test_must_fail git rebase --whitespace=bad HEAD 2>err &&
> -- 
> 2.20.0.rc0.387.gc7a69e6b6c
> 
> 
--8323328-1121995470-1542743331=:41--
