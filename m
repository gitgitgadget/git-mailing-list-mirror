Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78BFE1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 20:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeKUHOh (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 02:14:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:47495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeKUHOg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 02:14:36 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3d9B-1fYkfn0d8r-00rF6w; Tue, 20
 Nov 2018 21:43:34 +0100
Date:   Tue, 20 Nov 2018 21:43:18 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
In-Reply-To: <6f0ff2e3-4019-1dcc-f61a-cd0919b9a247@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811202142440.41@tvgsbejvaqbjf.bet>
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com> <871s7g29zy.fsf@evledraar.gmail.com> <6f0ff2e3-4019-1dcc-f61a-cd0919b9a247@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1824110070-1542746614=:41"
X-Provags-ID: V03:K1:a+v3LhvtxLW4isF5nWQWQdjBhrTmiX7R5MbJAx1Jwzq/0zSS1yM
 Oa4bJ0+ixT9JIVs14Z2el0sAZ46IewhEEWSAtiOab78iC6pU21SZD7/dU/dEDhuUb9/OSWv
 h8vk30ET/3YlIiaA2ynr49vOIBHmcQD60Mlq5zI3d80f+XzGg97/WrrjtHde8pd9c7z3l2h
 wFkHUQSZotbzIKlDkWCCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O/4kwssZS9s=:DiJROYM+NBDOUcPKgBee7A
 +BKZm9D3P/LzhI5sgbBjVts1sMsENJaw1owkSoeK+9RCnsdFKJ7wsrph8WEGk1VULAOspsk0l
 0ootS3KtY5VGkBNilVdJUXfJItNfnHnBn0O/DCYqT58FNY5JdshJM2LLgY7tCLGg7U5yAGhyf
 G6SFwGzPOs11t2rPIJp4yGaQVUers8w1wG7ak26tTyGtbSV3maUgMerRxaDzofgRt93e46IiC
 KLR/hLR+Jhqoo4YRObpYOiE8ZdGue3ajc0NMTWkqSV+Iq7vbfCSwlYjvrFHCpRQ5Dt64+BnGs
 Tkefn+sCN95GJGbmPbBtKG4cdlHnA+XlbuAWh25548vfM93RaHmlmoY1ydm1JGTiCkVkeI0vA
 nFNi+MJ+k2dZ4gvgZObNIr+Nau/qP2mROnU96JMOoEK4AnmN9/YwxggLyaZRPK5Y3ZkWTLk6V
 UVPUS1aj8l/MmIQvZALf8mccRroajWENwrLxjdp03VQzlQ6QMlQXt7pjP3/g0lKL51C/Tq9Sj
 WX0XJ9FwKtc6EubQdJVbHT8B3QFBBbsFZ8ZOjcNfERWxDA0l7yU7RQIIQGWCXeYRYVLAgiqYm
 SVpQ9hPLc2C+GZDRAkNgiV8bU2bKfue21owOLBWe5ZuTuoqzkRdx7Me8w7zkr3fEBVpcZTN+u
 AGOf3ygyGeKlooFFZwfCQ3uy72JyDPi9Alq188WWVzLoqAsQJdPGcjAAwStVCH93Y/WL+0ZqQ
 4vtkPNa8te+p6RuU7ef3prpVJTl8eg2of7MdbHoyopDuTxGis939InVf+ZI7kj+ujDSXYL4Zb
 fRXbqKGV2EWPk363dRcEnpPYAtanEKHgz69O/yBCUQUTHFH02r1pdSpp8zDC5JY4nMeB7nG5H
 siflT7gLU40eJOuSytreTxPv6KqjawitNU0fQ+UsfaTxk2YA9/ILvFbTwLFb6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1824110070-1542746614=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Stolee,

On Mon, 19 Nov 2018, Derrick Stolee wrote:

> On 11/19/2018 1:33 PM, Ævar Arnfjörð Bjarmason wrote:
> > On Mon, Nov 19 2018, Derrick Stolee wrote:
> >
> > > [...]
> > > builtin/rebase.c
> > > 62c23938fa 55) return env;
> > > [...]
> > > Ævar Arnfjörð Bjarmason 62c23938f: tests: add a special setup
> > > where rebase.useBuiltin is off
> > This one would be covered with
> > GIT_TEST_REBASE_USE_BUILTIN=false. Obviously trivial, but I wonder if
> > the rest of the coverage would look different when passed through the
> > various GIT_TEST_* options.
> >
> 
> Thanks for pointing out this GIT_TEST_* variable to me. I had been running
> builds with some of them enabled, but didn't know about this one.
> 
> Unfortunately, t3406-rebase-message.sh fails with
> GIT_TEST_REBASE_USE_BUILTIN=false and it bisects to 4520c2337: Merge branch
> 'ab/rebase-in-c-escape-hatch'.
> 
> The issue is that the commit 04519d72 "rebase: validate -C<n> and
> --whitespace=<mode> parameters early" introduced the following test that cares
> about error messages:
> 
> +test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
> +       test_must_fail git rebase -Cnot-a-number HEAD 2>err &&
> +       test_i18ngrep "numerical value" err &&
> +       test_must_fail git rebase --whitespace=bad HEAD 2>err &&
> +       test_i18ngrep "Invalid whitespace option" err
> +'
> 
> The merge commit then was the first place where this test could run with that
> variable.
> 
> What's the correct fix here? Force the builtin rebase in this test? Unify the
> error message in the non-builtin case?

I am obviously biased, but my take is that the correct fix is in
https://public-inbox.org/git/pull.86.git.gitgitgadget@gmail.com

Ciao,
Dscho
--8323328-1824110070-1542746614=:41--
