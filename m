Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DDB21F453
	for <e@80x24.org>; Wed, 13 Feb 2019 14:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733302AbfBMO40 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 09:56:26 -0500
Received: from mout.gmx.net ([212.227.17.22]:54311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbfBMO40 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 09:56:26 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPD8G-1gyJfe1WIy-004Vrt; Wed, 13
 Feb 2019 15:56:18 +0100
Date:   Wed, 13 Feb 2019 15:56:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: Git v2.21.0-rc0 broken on *BSD, maybe others
In-Reply-To: <20190212133032.GG1622@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1902131551060.41@tvgsbejvaqbjf.bet>
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com> <87sgwtjjbk.fsf@evledraar.gmail.com> <20190212124323.GA11677@ash> <CACsJy8D-FVGXHbqKf8BAVWEFchbF5LAN6x8UM5g7v_HLO29CLQ@mail.gmail.com> <87pnrxjghb.fsf@evledraar.gmail.com>
 <20190212133032.GG1622@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-478875880-1550069778=:41"
X-Provags-ID: V03:K1:/I0tnxpm8Jn+uW9H/UxmCAkMWUKynMqzel5/11mABnAGzuFmqGg
 CmC4ZaCYeWP6IudqcLf9CaATzSoC8vPR01u2sVDBb8JZ0BW+RB8IAgN6vUHqMOCMfWVNBAS
 HQFOrlUb3MLlR24lGatnu6s4P3u4vqftSW0EziwRX85KcaYUbqIaxMt9/5DUaabEd7Xpsd6
 H4qypvAu9gEoHQ3RNF4dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E42lmOcs/KU=:j4dj6KGzfISpJlJ1qLt/Z2
 Vy0mPcRKHqRWdkOxQuen6aaozgsEFDqo4+7/RwY1S7xC7f38mjbf248j7174vH6IYRLeSAkDT
 HGzVWk407W3x64EMOoU5EaUjZp05+KVmJ3OLKWeYQ2FOQD53EyHhAZjA00q9NHDlUVAzAFaEP
 CxBpu709YEfKuTn5wiJcC5gRuLovMM1u78Nb3drKU+T4sLrga6VKYlMOtC7TD9ITc94mJC+Hn
 vJx/DhthlHIqF0ip/7T1RPnSdNY0jfJPAjOgqDd4QqWMOHsdqRT2vCcDwou6dolxqlm/nMB38
 M6AZfh0s31QI+X8bPDdYqb0mokgIGM3bqUvmRSGls7yi/S6MAgo2fyhbiRHCr165Xtj/mZ2HG
 0uR4RouVeGWtyBA0ZhZaiACHtqBdt/oX/M0BezEdOcJOSZaCeh1YmWoyJcEm6RP4mMlpOagsX
 rtHsobpkyTCBWuzV4JvFQsHm5QPb/Znw/AlYkdtTWQaddieLSkeVMxYXLlFIK6A2m78TAf0lP
 NA+QnLImr9qlO4A8ULYI48yc3MEAurHjk3pbl/OD3JcY3xwKqakXEpaApaMFnaDJfAlcn+60R
 RXNzWKX/+VwklqCy6iP0tzgzSo6S+6UxgwZ5yY1v6jm5sXBGYvyv+YwdVBm5HlkPJcxxgZfpm
 /ejgAVFlPOj2fiDfPSFJrxbriGEneqQeILqV9/Gq1SgAd4lx4W0BqFJiN2mFLHfjSe/75RBCn
 ZLMPcdyppQEpeARN/Zj+VfW64a9jYBsaAkWTqonAO3vBFSJ4j7BXWMM6dHrslhHJcSHxYqAlw
 vABswc3cZpVnc0QX0kcLOTMoKOGYSdoVd6HgShiLYB6FAyJahqqEuAZEQH8qp/tmzMskEofr2
 NwGAdcbQwEz8FTNery9Vh81IP/sppWcFDDBvszbdJD5Bm/wwEYGXqX+92CFaccWuZPRnv9mxp
 LCcDNTbQM/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-478875880-1550069778=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 12 Feb 2019, SZEDER Gábor wrote:

> On Tue, Feb 12, 2019 at 02:14:56PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > 
> > On Tue, Feb 12 2019, Duy Nguyen wrote:
> > 
> > > On Tue, Feb 12, 2019 at 7:43 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > >> The test failures on NetBSD and Solaris/Sparc, not sure if we can do
> > >> anything without test logs or access to these systems.
> > >
> > > Actually if you could tweak your ci script a bit to run tests with -v,
> > > that would help.
> > 
> > I vaguely remember doing that and running into some issue where it
> > truncated the output, so e.g. I wouldn't see compile warnings on AIX
> > because of the firehose of subsequent test output.
> > 
> > But yeah, having this in some smart way would be great. I'd be most keen
> > to just work towards offloading this to some smarter test runner as
> > noted to Johannes upthread.
> > 
> > I.e. a good test_for(SHA1, params) function would run the tests with
> > "prove", and e.g. spot that tests so-and-so failed, and then run those
> > specific ones with -v -x.
> 
> Just follow suit of what we have been doing on Travis CI since the
> very beginning: run tests with '--verbose-log' to begin with, and then
> dump the logfiles of any failed tests, i.e. where the content of
> 'test-results/t1234-foo.exit' is not '0'.

Indeed, and this is how you can do it at home:

	ci/run-build-and-tests.sh || {
           ci/print-test-failures.sh
           exit 1
       }

Erm, that's how it *used* to be possible at home, but I broke that! Now it
will tell you that it "Could not identify CI type". I guess we should fix
this by introducing a new arm to the `if test true = "$TRAVIS"` construct,
to allow for manual runs (or for your CI builds where you specify the
parameters such as CI_TYPE, CI_BRANCH, CI_COMMIT and CI_OS_NAME via
environment variables).

To get you unblocked, you could rewrite ci/lib.sh on the fly:

	mv ci/lib.sh ci/lib.sh.orig
	sed "s/^if.*TRAVIS/if true; then :; el/" >ci/lib.sh <ci/lib.sh.orig

Ciao,
Dscho

> 
> Re-running a failed test is not a good idea, as it won't help if the
> test managed to fail because of a rare flakiness.
> 
> 
> > That's how I was going to fix the log overflow problem, but I'd much
> > rather not continue hacking on this gitlab-gccfarm-specific thing, and
> > instead work towards something more general.
> 
--8323328-478875880-1550069778=:41--
