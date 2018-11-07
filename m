Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40FD1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 13:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbeKGXUe (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 18:20:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:59311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727752AbeKGXUe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 18:20:34 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOBOi-1gPu051alg-005cMq; Wed, 07
 Nov 2018 14:50:01 +0100
Date:   Wed, 7 Nov 2018 14:50:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Re: Regression in rebase-in-C with rebase.autoStash=true
In-Reply-To: <878t2671dc.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811071436290.39@tvgsbejvaqbjf.bet>
References: <pull.56.git.gitgitgadget@gmail.com> <878t2671dc.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-953644727-1541598601=:39"
X-Provags-ID: V03:K1:sVv4AkXhOxALWi0TB6chhr9TWyQOEfdVkig9UjjojZitmlKj13W
 vLFzuvW2z+iCLThLUttTwN8G0RJEpndv/ylo7XsWSs93ToU8DGwxEEOT6jwHU2DEcl3HuzG
 DNW+4/STZiwsdpLtcA2Dv1FnAqNeU5G0LFO52VGAjfe/KvgDc4atrKDyThnfZLgLKLvTjHW
 841OyJg3O+7r2GJbiTfQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:577LD6UGJs4=:5lQPhHVMSP9TYW/TPkiTQu
 RsZ+GMRNrO9WpcL5/gq1df1s1Kzq3Jg30HF1xhZC9Gno0kUkXdBLvgiHOgWUmaedrhXpWWCAM
 x8oCKTVHRAU5x2OaDFMSo//NS0RXOAv659ubAOrocdTIGGTyASnnwK9hoZ9KfptDXnrRpKaCZ
 PeKkmQDOITI20Fr/ivMubr3NeYc3k5GvWdtThwtNwqlhgTxu9rz8ve6LzjcwNusWR/i6HHAHH
 zU7GlQAnyFLy33PVwsDbE0lZyq7qQu4aT0dTc5aFHgcQpccaec9jqQYLVx/x41P3izJ3sIDZv
 Fh5NSyBaE2fMbCaMi/I6BANexEllVpSEvXyxaC0Wej7aN3aJOoPXoX6p+3U5ocafMPC2J6X+c
 8wTJ9TyTwjDawqWNGaDVgEeZsGjLWKl2DogLpGY/as7X6iK0qBguvqAq8HrSAA8f54Odbh/Um
 0aICrGCCqIjv8Ism4Yi2IcJK+PIa29K+RhaJ1rxa+Ko6bmRn4jnV/Gr8OoQxUfNq7DLiH4r4j
 gfaQioJbOoTWwzqpH/xGiDlr0LhsMZzXPb52x9VT0O/OruzkrCiTAStuOVGslj2MBJtGJ1/2S
 vEHlVeDXqBz24B0wCyuPQcSZC3pKW/qxh+XHERDY4rUqnGWXwhCcj+dQv4uS1Pifo4uq+tGDU
 JtYTtJkr2Znw2Csp5vd2cO1Ydn3SXvejomJnmM7zGJNpEMec7fBo0q/3GbgFlPqmVLInxg4QH
 L6Yhji5XqNKT1vQcKOe7GC4P0EhDbAZB+t9/6NhS5MBcgIVSewISjx3iuXGkcWd90EagdwGxh
 2sZ21XJumJzIQLUvn/9iQ6rvoJaCnb5cQeyGaG8dI2upSlPy80KogwuJKYc2qT7Y/8m8yTrFO
 f0aLtrdTGiftbUvZqDBMo6/W7uq8kE9McFzXKAalwQU2dhW6XlDAMJhG65JHDwBm2i4sKuEny
 Z8fPigL50YQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-953644727-1541598601=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Tue, 6 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> 
> On Tue, Oct 23 2018, Johannes Schindelin via GitGitGadget wrote:
> 
> > Johannes Schindelin (2):
> >   rebase --autostash: demonstrate a problem with dirty submodules
> >   rebase --autostash: fix issue with dirty submodules
> >
> >  builtin/rebase.c            |  2 +-
> >  t/t3420-rebase-autostash.sh | 10 ++++++++++
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> There's another bug with rebase.autoStash in master (and next/pu) but
> not v2.19.0. I tried to bisect bit it just comes down to 5541bd5b8f
> ("rebase: default to using the builtin rebase", 2018-08-08).
> 
> Credit to a co-worker of mine who wishes to remain anonymous for
> discovering this. I narrowed down his test-case to (any repo will do):
>     
>     (
>         rm -rf /tmp/todo &&
>         git clone --single-branch --no-tags --branch=todo https://github.com/git/git.git /tmp/todo &&
>         cd /tmp/todo &&
>         rm Make &&
>         git rev-parse --abbrev-ref HEAD &&
>         git -c rebase.autoStash=true -c pull.rebase=true pull &&
>         if test $(git rev-parse --abbrev-ref HEAD) != 'todo'
>         then
>             echo 'On detached head!' &&
>             git status &&
>             exit 1
>         else
>             echo 'We are still on our todo branch!'
>         fi
>     )

I found the culprit. Patch forthcoming,
Dscho
--8323328-953644727-1541598601=:39--
