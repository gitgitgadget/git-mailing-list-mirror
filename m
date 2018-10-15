Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4F41F453
	for <e@80x24.org>; Mon, 15 Oct 2018 14:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeJOWlG (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 18:41:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:53617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeJOWlG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 18:41:06 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhNwC-1fpuoN3VcO-00mYRm; Mon, 15
 Oct 2018 16:55:23 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhNwC-1fpuoN3VcO-00mYRm; Mon, 15
 Oct 2018 16:55:23 +0200
Date:   Mon, 15 Oct 2018 16:55:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/13] Offer to run CI/PR builds in Azure Pipelines
In-Reply-To: <20181015142215.GB1764@syl.hsd1.wa.comcast.net>
Message-ID: <nycvar.QRO.7.76.6.1810151636510.4546@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com> <20181015142215.GB1764@syl.hsd1.wa.comcast.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JIjxG7JXFgUEsCFBsSZ2fuOvo5IL8bhOP4SbZ+cO5TU0Bv5I5mq
 MoBF4NkFHcBLq+dolc5e4kg/j0rkcdLll37x1LUxht9hTRV9m3koYmgDiE2vp1Pix+0zyZO
 K+a7nWIFmOrZAarpyQMwpkJrYSH0IR+ih961D3KAMUrsgqxAtc0NjaPR16F4HFTd7dR7Z4d
 z9W7DqtNxHe0rJB27F00Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N2ZKsTW9Qeg=:GWv0kVuBq+clmCNpW8Zi4m
 jsgnDU06FBRY36RmhboGWnkUVjwqIMWUwbao9I813tqsMN2/L9t7XDr4H+/7L8EH7DdDi/+CS
 DJFlmvVwScVdJA2zQyifV+Fixu/eryNoCOSX+6EKtJaasF5H9xxrEGCqLr3aNQRNSEGN2416W
 J6dH9A4U20FZv2GCE+X2vT/wJmub69N/ihsnvBlW5forw8t6jvVfURtW2WEdM2hDldTasHpDE
 K8v84uqBwaRkBs2Qu3CQoV9Z4lFjvYjS8Gs8aFzAfa5vI2oe1kotcIw0t7qL9+KHcQW63bAjV
 WAZanx4edLlrMehYkCDAI0/zCdKr1doEUmk06hMSf9ijt3sdXtgsiEhXvvBQDvEmRjzG/gaX2
 xpafi2d5U25YAYYA0+v6ruptZkM3q0MfGBO1UCOH654XYLXya8igeYMJL151ERf24RKRd1ocE
 fpW5iQjjge9I7jiSGmWMZJKdh8q86fm1S5e51TauhPtt0oFgNiuj9h38SiLNRN0nAiFE0uG2k
 pV4PgpzfzpyJRzP8AfyjdJ7LsY0FmSsYbzxDnhrQ+iIHNHU/gpUSvE3S2jVjyJOJxE/akmzwU
 E5HHLzPtfe6NPvFu2NfBoLOh2pfx/8q5hcSpBGrD7q/HyoEVRweo1zxajWwO3w7S0EbC6xv0b
 wxrxSyYAV90yzMTDwhBTK6fHRQmb05Dr+/Edw90SGeUpVfiKiwg2qMt+DDRvQfBo4vJ/qKK46
 HQ5YhBiKyLqSxG1odVvvUlOHyE2jAxsKPBLyAsPucXh4l6yigp9OwgVMK9VYzAgocaPBV/p5Q
 1fb9GgsRo22EXFu2M8bGJaHmQ49eiE5GZrbfpxr9w4DvB0Hi8o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Mon, 15 Oct 2018, Taylor Blau wrote:

> Thanks for putting this together, and offering to build Git on Azure
> Pipelines. I haven't followed v1 of this series very closely, so please
> excuse me if my comments have already been addressed, and I missed them
> in a skim of the last revision.
> 
> On Mon, Oct 15, 2018 at 03:11:57AM -0700, Johannes Schindelin via GitGitGadget wrote:
> > It is also an invaluable tool for contributors who can validate their code
> > contributions via PRs on GitHub, e.g. to verify that their tests do actually
> > run on macOS (i.e. with the BSD family of Unix tools instead of the GNU
> > one).
> 
> Agree.
> 
> > The one sad part about this is the Windows support. Travis lacks it, and we
> > work around that by using Azure Pipelines (the CI part of Azure DevOps,
> > formerly known as Visual Studio Team Services) indirectly: one phase in
> > Travis would trigger a build, wait for its log, and then paste that log.
> 
> I wonder if Travis' recent announcement [1] affects this at all.

:-)

It did not escape my notice that after years and years of trying to get
*anybody* at Travis to listen to my offers to help get this started, the
announcement of Azure Pipelines for OSS seemed to finally do the trick
(they still don't bother to talk to me, of course).

And to answer your question without a question mark: I do not really think
that the Travis announcement affects this here patch series: I have a ton
of good experience with Azure Pipelines, use it in Git for Windows for
ages, and I am finally able to have it in core Git, too. So I want it, and
I spent a lot of time getting there, and I think it probably won't hurt
core Git at all (besides, it seems that at least some of the phases are a
bit faster on Azure Pipelines than Travis).

Another really good reason for me to do this is that I can prod the Azure
Pipelines team directly. And I even get an answer, usually within minutes.
Which is a lot faster than the Travis team answers my questions, which
is... not yet? (I tried to get in contact with them in late 2015 or early
2016, and I tried again a year later, and then a couple of months later,
and I have yet to hear back.)

Also, I am not quite sure about the timeouts on Travis, but at least
AppVeyor had rather short timeouts: the Windows build (due to our
extensive use of Unix shell scripting in our test suite) takes 1h40m
currently, and AppVeyor times out after 20 or 30 minutes. I could imagine
that Travis times out after the same time, or maybe 60 minutes, which
would still be too short. On Azure Pipelines, the maximum timeout (which
can be configured via the azure-pipelines.yml file) is four hours IIRC.
Plenty enough even for our test suite on Windows.

> To summarize [1], Travis is offering an early version of adding Windows
> to their list of supported builder operations systems. This brings the
> list to macOS, Linux, and Windows, which I think satisfies what we would
> like to regularly build git.git on.

Honestly, I would love to have also FreeBSD and other platforms being
tested. And with Azure Pipelines, I can make that happen (eventually), by
adding another pool of VMs (given that I have a free $150/month Azure
subscription, I'd use Azure VMs, of course). As long as a platform can run
.NET Core software, it can run Azure Pipelines agents.

With Travis, I don't think I can add private agent pools.

> Would we like to abandon Travis as our main CI service for upstream
> git.git, and build on Azure Pipelines only? If so, I think that this is
> an OK way to go, but I think that I would be opposed to having more than
> one build system. (FWIW, we tend to _three_ for Git LFS, and it can be a
> hassle at times).

This question of abandoning Travis in favor of Azure Pipelines is a bit of
a hornets' nest, as I really, really only want to bring the goodness of
Azure Pipelines to git.git, and I am *clearly* biased, as I work at
Microsoft.

Which is the reason why I did not even hint at it in the cover letter, let
alone included a patch to make it so.

My patch series is purely about adding support for running CI/PR builds of
https://github.com/git/git via Azure Pipelines.

> I see some benefit to sticking with Travis, since we already have a
> build configuration that works there. But, you've done the work to
> "port" that build configuration over to Azure, so perhaps the point is
> moot.

It is not so much a port, as an attempt to generalize our ci/* files.

> > As Git's Windows builds (and tests!) take quite a bit of time, Travis often
> > timed out, or somehow the trigger did not work, and for security reasons
> > (the Windows builds are performed in a private pool of containers), the
> > Windows builds are completely disabled for Pull Requests on GitHub.
> 
> This would be a concession of [1], in my mind: is it possible to run the
> tests on Windows in a time such that Travis will not time out?

To be honest, I spent such a lot of time to get things to work on Azure
Pipelines, *and* we get a nice view on the test failures there, too (which
Travis will probably also offer soon, in response to what Azure Pipelines
offer ;-)), I cannot really justify spending time on trying to make things
work on Travis' Windows VMs, too. Especially when I have to expect to run
into timeout issues anyway.

> > As a special treat, this patch series adds the ability to present the
> > outcome of Git's test suite as JUnit-style .xml files. This allows the Azure
> > Pipelines build to present fun diagrams, trends, and makes it a lot easier
> > to drill down to test failures than before. See for example
> > https://dev.azure.com/git/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details
> > [https://dev.azure.com/git/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details]
> > (you can click on the label of the failed test, and then see the detailed
> > output in the right pane).
> 
> That's pretty cool. Travis doesn't support this (to the best of my
> knowledge).

Exactly.

Plus, if things don't work in Azure Pipelines, I (or one of the other
Microsoft employees among the core Git developers) can easily take a
shortcut to the team and get things fixed. In my mind, that counts for a
lot, too, especially given my own, frustrating personal experience with
Travis.

Ciao,
Dscho

> [1]: https://blog.travis-ci.com/2018-10-11-windows-early-release
