Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A8B1F428
	for <e@80x24.org>; Sun, 26 Aug 2018 00:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbeHZDfi (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 23:35:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:36851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbeHZDfi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 23:35:38 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzcIM-1fpddy0P6Q-014mmE; Sun, 26
 Aug 2018 01:52:48 +0200
Date:   Sun, 26 Aug 2018 01:52:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bryan Turner <bturner@atlassian.com>
cc:     git-for-windows@googlegroups.com, Git Users <git@vger.kernel.org>
Subject: Re: Request for testing v2.19.0-rc0 *with builtin stash/rebase*
In-Reply-To: <CAGyf7-FB6oBpKHTBLoqviu=Ymk0Ksi_EHrxM6-Z4YK44w0kpYg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808260150320.18296@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1808241320540.73@tvgsbejvaqbjf.bet> <CAGyf7-FB6oBpKHTBLoqviu=Ymk0Ksi_EHrxM6-Z4YK44w0kpYg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MCdEU2uUt8lhL70arykZcvLGUhiLFtgUmZ8kQmJlzkWRVdx2hPd
 7AS2bAApoAJcHzjWZQWJdErAj4qzARjDrmdnCJNGQqQx7iQjh5rdviVu0X6BIq+u1a/HyXq
 B0GXXt8VANaq3NB44i1lLWURzzYQzl4FHAhrFQjmr0o4R9cU0yuV4cJdAYpck8ey2pNLHaz
 0UEFWAyfYnlmzG9QaW9WA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X9RntW2eKgY=:Ap1blgO05clL0x95kkpbZ4
 boIR1gkFK3Sz0XfgoQ7+cgYc6jVzBBZTdVi/2kj11WwY1ymXbpTiWHd+UbZhMDETVjo9AqhVa
 QA2D1bF9D36J54tD4zpYlyUwJh2AJ3F3A6ShR+H4FXTAfTNGgVKUeJ8TItQaO3A0K7zYKpKfZ
 0e9c9FRKLfx35z3aaMcOJuNN6XX6Ux4FmJ+EP4nhVHyeXObC7Uf8+tR/bdl2I9Di+f2sDoBf+
 79RbH/QGrGVPJOazXi7OsL4Bin2hGek/kPqn6VgMDtBMvqysY3CKLpSJTbToHdJBh2107u4As
 eTzGezJsrS9+vrnsGs62azqPXwODjua1BPIK9E/xJj7awZ+RNNX+oM1l+FhySXGr571gkrxbq
 jX8KnPzTyKPCV1Zz2ww9LdePOeVUYIQ63aj+O3ZKFYt0HIvdvmNMZr2esPSueYL7wx3bRHD9m
 fyHEXYrSV+IIKr8eIOyanDuzwZkoHsL4qOSemWQWqczbr6CnfC4TDl5dXeKBJheYXEnSPYOLu
 DvojxVz+5S0JQSddojCppVh/rxxmxs4+fotJDHDKft6BKXplgV+/pFW4e0yevtNoVLZexaRNV
 +YNyEP5sf083muNceOYBGWx1HRn7xL3YpOgUXvBuaVGFrpImnC675lx5b+ghzqXBpV1XVeE3J
 w6DQfffDiWDA7XH1p7jwpvZH/woo7TCJkxgLGV2814QCn4Dn2CCWpaNrzR4y7b1aHUE9h4+PO
 eYOFtpt0xruihnkgAb8rRg9uolY84/x0QVZ/DgxekUnHnpA+SYEKBH26HKZKOv0rcSQbFSFTX
 3k+t+WB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryan,

On Fri, 24 Aug 2018, Bryan Turner wrote:

> On Fri, Aug 24, 2018 at 5:14 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > For that reason, I was delighted to see that our Google Summer of Code
> > pushed pretty hard in that direction. And I could not help myself so I had
> > to test how much faster things got. Here is the result of my first, really
> > quick and dirty test:
> >
> >                 without builtin stash/rebase    with builtin stash/rebase
> > t3400 (rebase)          1m27s                           32s
> > t3404 (rebase -i)       13m15s                          3m59s
> > t3903 (stash)           8m37s                           1m18s
> >
> > What can I say? Even if the numbers are off by as much as 10%, these are
> > impressive improvements: keep in mind that there is a lot of churn going
> > on in the test suite because it is itself implemented in Unix shell
> > scripts (and hence I won't even bother to try more correct performance
> > benchmarking because that is simply not possible when Unix shell scripts
> > are in the equation). So the speed improvements of the stash/rebase
> > commands are *even higher* than this.
> 
> Thanks for taking the time to make these pre-releases available. I
> appreciate the effort. And the same to Junio, for always posting
> release candidates. We rely on them heavily to find changes that might
> cause issues before admins start upgrading in the wild and find them
> for us.
> 
> I downloaded both the rc0.1 and rc0.2 builds, as well as 2.18.0, and
> ran them all through Bitbucket Server's test suite a few times (to
> ensure warm disk for comparable numbers). I added support for some
> "simple" rebase cases a few releases ago, so we have a set of tests
> that verify the rebase behaviors we use. (We don't use git stash, so
> we don't have any tests in our suite for that.)
> 
> Running our entire Git test suite (~1,600 tests) against Git for
> Windows 2.18.0 takes ~5 minutes, and 2.19.0-rc0.1 produced an almost
> identical duration. Running our tests against rc0.2 cut the duration
> down to 4 minutes. There were no test failures on either pre-release
> build.
> 
> To try and get a better sense of the rebase performance improvement
> specifically, I filtered down to a set of 14 specific tests which use
> it and ran those. On Git 2.18, those 14 tests take just over 19
> seconds. On 2.19.0-rc0.2, they take just over 8 seconds.
> 
> When they do ship, whether it's in 2.19 (by default or optional) or
> later, the changes definitely offer some significant performance wins.
> 
> Thanks again, to everyone involved, for all the effort that went into
> designing, implementing, reviewing and releasing these improvements.
> As someone who develops under Windows most of the time, they make a
> big difference in my day to day work. And that's not to mention all
> the Bitbucket Server and Bitbucket Data Center users who will enjoy a
> snappier experience as these changes make their way out into the wild.

Thank you for the thorough testing!

As a heads-up: after Thomas Gummerer offered some cautious thoughts, I
decided to work on the stash.useBuiltin support after all: the Git for
Windows v2.19.0 installer will have builtin stash and rebase as two
experimental options, both defaulting to off (to protect not only Git for
Windows' users, but also the maintainer's inbox).

Likewise, portable Git and MinGit will support stash.useBuiltin and
rebase.useBuiltin, defaulting to `false` for both.

Thanks,
Johannes
