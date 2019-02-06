Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 206A61F453
	for <e@80x24.org>; Wed,  6 Feb 2019 13:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfBFN4D (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 08:56:03 -0500
Received: from mout.gmx.net ([212.227.17.22]:57279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfBFN4C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 08:56:02 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwGDy-1hBVab30wA-017zUQ; Wed, 06
 Feb 2019 14:55:59 +0100
Date:   Wed, 6 Feb 2019 14:55:59 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Luke Diamand <luke@diamand.org>, git@vger.kernel.org
Subject: Re: Weird (seemingly flakey) p4 breakage in t9833
In-Reply-To: <20190206111111.GK10587@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1902061454220.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1902061004110.41@tvgsbejvaqbjf.bet> <20190206111111.GK10587@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-700399013-1549461359=:41"
X-Provags-ID: V03:K1:rvkmXtJJWfAJecLrF1YYmEeoha/17LLHAaDcQHvr+QVNSKvyWt7
 lzNmB0EYXc82vTDmwmv9VZmkSxbyneIad3tzaEPOwvi7OHts/DTzapX1ZJYCuNt96fP98Sz
 behJ/7EZXNEYSe08iHnnBKo9lO+ug2gzynh+op8u6dw/A687JZkn3uq+DsV9pmY7fIt4N3k
 9PWODGgjOSbk2usbtcW/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tk2lNEQi8lw=:4eqa3yukRww1FNY9oN5SWu
 TN0vRco5KhRnpUqDnU116L6IKEktYVkWptMfSCGEXeqosMQQunb22n9399eSw6y3BXG1yHlnw
 IVGFwC1mKNl6VmFo258ZGwYDmU02KeLz4E/HmZojMk/gqB+zYod503tWbOGN3upVL/R/WXObV
 91zA/LSnpu/K6IFxRNmg0vqtKLn7FQKPeIiV3d2ObCMoLgz7M3yb0yBBa6vbpaiegZMfF4fQc
 lZJwXFLrVxq6SoIQ3y2p42SCxogWOUVBWpo4phX5dWeimuhDGcuIyb7FlAOo/ktTUSn79k5Sk
 81bglYYmIWclJrObNZKzak7uAdypUhsxXvnzsAhfXdmwQNAmDEo3oZgl+Y+BMDO10JB0/CVAC
 GTc5F0cLIfqXalxIQNdu2B9p9flFDnlAM5ysF5WIDpIPPC+ke2ychOY7fiqPuN3/VIPahXAhZ
 0iK9CxCmH5qjbIS86bJCou8l+qSY1KpakxaTn7d0tWvfox3uDLkqqX1o+6UeSy6KOz0/ua6fk
 Y+MA/7MyWq1F8Gv5PLAYOGo9ohwsktNlAyG6OKJhYrpdbsTezLZsG4Nt4C+58fszFLyQr0bfF
 0OdfLzMKDeK0e3dXyDk2UA2wumlo45PxEKmWKt3yq3SjY1JARqd5pVk/Q1YLqiWUWtAudCskH
 JTWHcxgWqGGxALfu+NP2+bJ2ZmqVbYLmASOv1WdXwpnN+l6SniLSsJy0bYWBj/x4wHwbbjtg4
 3qbESGZrPCW2RzwzHJt88MBITm+4rPgDYVvFZXZga9xd7ujZmvzMDt6jHpDk7mRL7XQTAa3Iy
 L8/zaqi/Y8ZfKDDUR1M8OxFxwOPRr7hXmuconw/EiwB8uhucsaENg3rX/+Z3eqoInhFlN/7Bb
 7Vsr/UjyC6bj0nvEnSeidNR2G8jmAdBU5NbJcQqYQ35YzmGhigfampa0ckA7HEnoLHH6D/OXp
 K1v36+My1MA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-700399013-1549461359=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Wed, 6 Feb 2019, SZEDER Gábor wrote:

> On Wed, Feb 06, 2019 at 11:33:21AM +0100, Johannes Schindelin wrote:
> 
> > in a private Azure Pipeline (sorry...) I noticed an intermittent problem
> > in the p4 tests on osx-gcc.
> > 
> > I would point you to a public log, but the Azure Pipelines support *just*
> > made it to next, so I *just* set up a public one targeting anything else
> > than my `vsts-ci` branch, at
> > https://dev.azure.com/gitgitgadget/git/_build/index?definitionId=6. And
> > those builds do not show that problem, so it must be a flakey test.
> > 
> > But maybe you can spot anything familiar from the log?
> > 
> > -- snip --
> > [...]
> > ++ P4TICKETS='/Users/vsts/agent/2.146.0/work/1/s/t/trash
> > directory.t9833-errors/cli/tickets'
> > ++ P4USER=short_expiry_user
> > ++ echo password
> > ++ p4 login
> > Enter password: 
> > User short_expiry_user logged in.
> > Perforce db files in '.' will be created if missing...
> > ++ cd '/Users/vsts/agent/2.146.0/work/1/s/t/trash
> > directory.t9833-errors/git'
> > ++ git p4 sync
> > ++ true
> > +++ time_in_seconds
> > +++ cd /
> > +++ /usr/bin/python -c 'import time; print(int(time.time()))'
> > ++ test 1549411312 -gt 1549411605
> > ++ sleep 1
> > Perforce db files in '.' will be created if missing...
> > failure accessing depot: perforce ticket expires in 1 seconds
> > Performing incremental import into refs/remotes/p4/master git branch
> > Depot paths: //depot/
> > error: last command exited with $?=1
> > ++ true
> > +++ time_in_seconds
> > +++ cd /
> > +++ /usr/bin/python -c 'import time; print(int(time.time()))'
> > ++ test 1549411314 -gt 1549411605
> > ++ sleep 1
> > not ok 6 - git operation with expired ticket
> > #	
> > #		P4TICKETS="$cli/tickets" &&
> > #		P4USER=short_expiry_user &&
> > #		echo "password" | p4 login &&
> > #		(
> > #			cd "$git" &&
> > #			git p4 sync &&
> > #			sleep 5 &&
> > #			test_must_fail git p4 sync 2>errmsg &&
> > #			grep "failure accessing depot" errmsg
> > #		)
> > #	
> > -- snap --
> 
> I saw this on Travis CI a couple of times, and looked into it, though
> I have no idea how p4 is supposed to work...  anyway, my theory is:
> 
> The previous test 'create group with short ticket expiry' creates a
> "ticket" with 3 seconds expiration time, to be used in this failing
> one.  This timeout might be just a bit too short when running the test
> under high load, and it takes long enough to reach the first 'git p4
> sync', so long that the timeout is (almost?) up, and then 'git p4'
> errors out.

That sounds very plausible to me, thank you for the analysis!

> I'm not sure what the proper solution would be (assuming that my
> theory is right, that is): increasing the ticket timeout to a "must be
> surely long enough" value would require longer 'sleep' in this test,
> which is not good.  I wonder why that failing 'git p4 sync' is
> necessary in the first place, and whether it's really necessary to
> test ticket expiration, but then again: I have no idea how p4 works.
> 
> On a related note, I think it would be better if these two tests were
> squashed into one, so we would get the whole picture.

Agreed.

> > BTW I find it very odd to see a `sleep 1` in the trace but not in the
> > snippet (there is only a `sleep 5` instead, which I fail to see in the
> > trace). Odd?
> 
> Intentional.  p4d seems to be prone to hang, to circumvent this
> start_p4d() from 'lib-git-p4.sh' starts a watchdog process in the
> background to kill it after a long-enough timeout is up.

What I found odd was that I did not see that `sleep 1` at all in the
trace, but now it makes sense.

> These three lines in the log:
> 
> > +++ /usr/bin/python -c 'import time; print(int(time.time()))'
> > ++ test 1549411312 -gt 1549411605
> > ++ sleep 1
> 
> come from that background process.
> 
> A couple of cleanup patches on top of your 'test_atexit' will
> eventually get rid of it...  once I get around to clean them up :)

Heh, so there *will* be something useful coming out of that aborted side
track? Great!

Thank you,
Dscho
--8323328-700399013-1549461359=:41--
