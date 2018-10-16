Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242611F453
	for <e@80x24.org>; Tue, 16 Oct 2018 13:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJPUxD (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 16:53:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:40893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbeJPUxD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 16:53:03 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgMCe-1fp9ah1yS4-00ni3v; Tue, 16
 Oct 2018 15:02:35 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgMCe-1fp9ah1yS4-00ni3v; Tue, 16
 Oct 2018 15:02:35 +0200
Date:   Tue, 16 Oct 2018 15:02:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/13] tests: include detailed trace logs with
 --write-junit-xml upon failure
In-Reply-To: <20181016100438.GK19800@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1810161455200.4546@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com> <ae3c42519abff7ef32c767f9587ef7f0160033ed.1539598316.git.gitgitgadget@gmail.com> <20181016100438.GK19800@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-23946581-1539694958=:4546"
X-Provags-ID: V03:K1:UqTrFfKGl5g1lJgIutvnzNValqtEeLTpDsA8jkdf4e2Ti4AVUKo
 skGOcbIgpdmqv1S0in/RWahpnba2VkwzkH2k14RovetubmC9fkDJz0HVBTSimgO/FumcP+G
 XYSrnq6h3LkwNdePxQSpEBK+ddsmmyJpDdOYzDRetohrvmhjdY2pbJUJCzLO58lxp2TZH3w
 X/rlkV7rcGrrb8SJDiW2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JB/FF3BKahQ=:wsJVbPTepjhW6X/XXNbTe6
 /SqWA16+c86ghHHb2r7neJAfQJtFrDbmZ40ol88rDgt7TgsDPmHbjusMV7rmln2x5UDE1xEwY
 BtRTbDlQNMColkO4k1P0LraMdR4AvAi1JW0/DQVpupcBy+FrJhmo0ArImlvmgtpVRz05qCjXF
 4jtS2AlFaEdf87WHN15j1FPW0g+pFYdi6BZYMOwOhJFtEzNVO1Agi16gCylIr+FEljwX0Ej7l
 cQ3ypXKSOF9d/w6PWzvPESQ9jUFkTYihIh8vI8p2dx4uuRh2UBqSefB1GdCQ4oQ7+7GClfSqJ
 LFBuLC4B8cKnXb4Y3IzMJsbPy7oyMIkUCIRpv+091Ts/iIafzNs7C1Z55dXNDdjphAbtZTdWr
 u3umuymuKfaX4KSroo7FkDihUCYgpE1OxUyS8DpGUTGudWy9rQ2j/E4rI+n3dQo1/BxlB7k0L
 0lMDV9f97IJ6rmOsCuhkR7ixG6cUq08I8CZP4C4AESZtuNEvKx41mda9bOKCpE5hsW1Mx6ILj
 oOeasTo2nm0FXhiyLbwNJVfA40fNpe9F8zhjmKUlUE8DHHIyHC23+5JHJWQHrBrV4W/7sBnIw
 9C18rDbRQxpJmoTAqVg7CzfQgZ61kDH1Wl9TGcAGNW38/m7hwtLxqATLWWqEQkkGBXCrxVngm
 lQxtz15DZfuqOWHjtanejv6MJW84VWA3pRVSiqkvHz/nfG/EnJdjqAKDXuddzoXOBXaeUIsAK
 IU5xrGM5f1lAX1+V7GCRFcnHfTvwAifL743ewzxoeI4j91RrXD/Q91ssKwv8PgcZr18Nht59V
 or10XsSZKzCpzV+euCmYd/3AbFNoQRgNYHRcdKkxmTHwfm7K2M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-23946581-1539694958=:4546
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Tue, 16 Oct 2018, SZEDER Gábor wrote:

> On Mon, Oct 15, 2018 at 03:12:12AM -0700, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > The JUnit XML format lends itself to be presented in a powerful UI,
> > where you can drill down to the information you are interested in very
> > quickly.
> > 
> > For test failures, this usually means that you want to see the detailed
> > trace of the failing tests.
> > 
> > With Travis CI, we passed the `--verbose-log` option to get those
> > traces. However, that seems excessive, as we do not need/use the logs in
> 
> As someone who has dug into a few occasional failures found by Travis
> CI, I'd say that the output of '--verbose-log -x' is not excessive,
> but downright essential.

I agree that the output is essential for drilling down into failures. This
paragraph, however, talks about the general case: where there are *no*
failures. See here:

> > almost all of those cases: only when a test fails do we have a way to
> > include the trace.
> > 
> > So let's do something different when using Azure DevOps: let's run all
> > the tests with `--quiet` first, and only if a failure is encountered,
> > try to trace the commands as they are executed.
> > 
> > Of course, we cannot turn on `--verbose-log` after the fact. So let's
> > just re-run the test with all the same options, adding `--verbose-log`.
> > And then munging the output file into the JUnit XML on the fly.
> > 
> > Note: there is an off chance that re-running the test in verbose mode
> > "fixes" the failures (and this does happen from time to time!). That is
> > a possibility we should be able to live with.
> 
> Any CI system worth its salt should provide as much information about
> any failures as possible, especially when it was lucky enough to
> stumble upon a rare and hard to reproduce non-deterministic failure.

I would agree with you if more people started to pay attention to our CI
failures. And if we had some sort of a development model where a CI
failure would halt development on that particular topic until the failure
is fixed, with the responsibility assigned to somebody to fix it.

This is not the case here, though. pu is broken for ages, at least on
Windows, and even a *single* topic is enough to do that. And this is even
worse with flakey tests. I cannot remember *how often* I saw CI failures
in t5570-git-daemon.sh, for example. It is rare enough that it is obvious
that this is a problem of the *regression test*, rather than a problem of
the code that is to be tested.

So I would suggest to go forward with my proposed strategy for the moment,
right up until the time when we have had the resources to fix t5570, for
starters.

Ciao,
Dscho

> > Ideally, we would label this as "Passed upon rerun", and Azure
> > Pipelines even know about that outcome, but it is not available when
> > using the JUnit XML format for now:
> > https://github.com/Microsoft/azure-pipelines-agent/blob/master/src/Agent.Worker/TestResults/JunitResultReader.cs
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
--8323328-23946581-1539694958=:4546--
