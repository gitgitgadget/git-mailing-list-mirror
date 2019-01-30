Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 426EB1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 12:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfA3MUq (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 07:20:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:49939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3MUp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 07:20:45 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lh7sF-1hTfKL443D-00oSUL; Wed, 30
 Jan 2019 13:20:31 +0100
Date:   Wed, 30 Jan 2019 13:20:14 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
In-Reply-To: <87zhrj2n2l.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901301317120.41@tvgsbejvaqbjf.bet>
References: <pull.114.git.gitgitgadget@gmail.com> <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com> <20190129160030.GA7083@sigill.intra.peff.net> <87zhrj2n2l.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1918758187-1548850831=:41"
X-Provags-ID: V03:K1:ezrfRtRVB1RDtivpsL0C/e4aVCV6tCWggEb6RSh1mfUyhp7cSrH
 Ufb258ghNU6bDLbdGBbHSt5lK/Wj/sq4RJGiBDD6Q70aS6/9eyipzp5bsDF9oGFdwHhwpjc
 DVtpF3ahfyRPlIzHh0p2fqqodBIv7T+YfQJq2TmmRWEw/UthHyFp/4zad/ty1jzRMZDbFz1
 hKmYWLQmFbJwcFHEHhw8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eYQGAucZB9M=:mifFDU2NvP8IZAe6GUeTML
 s14/KkwlFMZ6uxrSFSY8i3ZuOmPFirEnw0BEhR0gb9O+OSgIe5D3AK08gVQ/f44ylHVaQ/yp5
 8ENapGR24VSJw2IzjY65G5kh1qKoBGnxZ9wNxcPC63OMGRTttPXxoM5Jvmg8Zocg303RJgvEU
 ar/WEpd2EvV02HmJzWzpwCEnpOwUtwBGUMcvAJk2jPWQYUKDmMO5GOfcKy8KEjZif/vIUsuf9
 nV2R5FnI/82QIR1Jjjoet5BiCd7ww1rfggu6YpMsXINbcO//kdYBIQ22sL6uiOV2am6JS7oIY
 gb9djfzmOEso9tahosEFaabXccLgG+oBpeTqN/OCmcsC4QwEw/pe7cHgIae/wEqb+4dpTzqZa
 ac04ScTZu55x+qmWZqKSvTTR8+fAZCNbqJgNyo2cuOliSgSyx+K14B2iZI+GW0Uh83X3mo8iy
 J7CBpat4dVICs0CM/vzAvaQlieSoJClyQpwlG7pNvD1RL3xGNbcml5JVvVK+HN7T7hV+1RSSb
 5VbEqyYvhVwitLZtnJE/1ooVrwYkSlemGJ1J9M/DQDitRzgr2kv6FFvDGIfidsKRypxk0p+aQ
 MQTMxO6OZiGY7+7sW8IKBDM4+HrSgMrzutopkNp0TANtVNCDQyDjDEiOj1zzfCaFK+t7uIDJa
 fBPbCgkrCeRyZJ3Tlmm13Ry0MBRlv3hp3PrA2uh9NNjJp/ikUkWKpDaISi8cPssCu9ZvvnixQ
 GGV29jGYOmXAfDaUUWnKtio4OXtjnnpuUSXF8Vuk4w4rYOHhLTM0GDaB8mOKb/CiTKPyFWtQb
 lEoygLvNddjPspzRh9gwZBkUAZM5opkrLeC2Sr4BCbhmuSxyug3AtAvt501FVsXrIRGTc84Xy
 cZW6nQggsoUljrxCxq8RMY5jaldQKUGQHIxcIg8R+vr+w8cs6ZKUqSqZfAHshJhSD7bZjwXAH
 NKhHPr+ROmA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1918758187-1548850831=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Tue, 29 Jan 2019, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Jan 29 2019, Jeff King wrote:
> 
> > On Tue, Jan 29, 2019 at 06:56:08AM -0800, Derrick Stolee via
> > GitGitGadget wrote:
> >
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> When running the test suite for code coverage using
> >> 'make coverage-test', a single test failure stops the
> >> test suite from completing. This leads to significant
> >> undercounting of covered blocks.
> >>
> >> Add two new targets to the Makefile:
> >>
> >> * 'prove' runs the test suite using 'prove'.
> >>
> >> * 'coverage-prove' compiles the source using the
> >>   coverage flags, then runs the test suite using
> >>   'prove'.
> >>
> >> These targets are modeled after the 'test' and
> >> 'coverage-test' targets.
> >
> > I think these are reasonable to have (and I personally much prefer
> > "prove" to the raw "make test" output anyway).
> 
> I wonder if anyone would mind if we removed the non-prove path.
> 
> When I added it in 5099b99d25 ("test-lib: Adjust output to be valid TAP
> format", 2010-06-24) there were still some commonly shipped OS's that
> had a crappy old "prove", but now almost a decade later that's not a
> practical problem, and it's installed by default with perl, and we
> already depend on perl for the tests.

It's not only about crappy old `prove`, it is also about requiring Perl
(and remember, Perl is not really native in Git for Windows' case; I still
have a hunch that we could save on time *dramatically* by simply running
through regular `make` rather than through `prove`).

I did start to implement a parallel test runner for use with BusyBox-based
MinGit, but dropped the ball on that front before I could satisfy myself
that this is robust enough. Once it *is* robust enough, we could even
replace the entire `prove` support with a native, test-tool driven test
framework.

> I don't feel strongly about it, but it would allow us to prune some
> login in the test library / Makefile.
> 
> Maybe something for a show of hands at the contributor summit?

Sure, let's put it up for discussion.

Ciao,
Dscho
--8323328-1918758187-1548850831=:41--
