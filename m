Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79651F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 14:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeKOAKy (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 19:10:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:33173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbeKOAKy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 19:10:54 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb4vZ-1fd6cl03NB-00kdtQ; Wed, 14
 Nov 2018 15:07:22 +0100
Date:   Wed, 14 Nov 2018 15:07:20 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        gitgitgadget@gmail.com, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] rebase.useBuiltin doc & test mode
In-Reply-To: <20181114090144.31412-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811141506100.39@tvgsbejvaqbjf.bet>
References: <CAGZ79kYX4vNMYgzitY1D8Bu7o=2oY6Aiq0d7KQdCTaC5eu=RYg@mail.gmail.com> <20181114090144.31412-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1077966491-1542204442=:39"
X-Provags-ID: V03:K1:y5Bjy1hKjIBkX9EBjtbKvM0Xd3jb8GTABQKOH3bdFzR2an6q4ov
 2F2v1v7fj6LwYgeNpJ1GhEJR3LZyBfL94q0OwFZmgrgQvyB09d5gdZeN287NM8+dre1Etq6
 lHeODPrA3KsRxusGrersW6mvyksXfOecsUwMwPmz+oGXi9w0y2Nc7bwU7Risgv5v2UETm8+
 ZGsJhimvN11IGwJ+bzm2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HsE7EEI1Rm4=:9odcRYSMovyHUwFUekFdFC
 z+PB6UUgwBavu5cSRM3Zp1LtlcB6ldVBTUqzgltrVRmyeweTre21dah1TFaX7eqwQlsiYsybV
 9cpUM8mVcGlM1WH+7LTBqrFvaGiuZmd2h8/b7o1oyAEy8KtnQ90D3qdr24PrCA0UJTD/XN56x
 g2XQ0qTpUvRWW2TlH9koKfL8Ca1ES94AqJzCnYHx8ryQLzh/N6jR4BSUzV5ovV3Uj/19fstrF
 Glpo2Fl8eE9IjmK/sYVN3DQxlMVCov7kVB9BdBbp4mPztQ4PHZYF4pV/8prvGSLAfkytd/Dol
 ANG7oDm22ptUw2gBRkMt3N2G4M+vJbUOX6EWBTNCCqu9mquKVqadvucAGNXggbE7SHAAGe/JR
 hYGroRrrLPHWaAh3DcpYDjBDj4q2CBjgAHouFOSZ9QtTPdLDT4yCbHebzbUSEP9nFW/GadRld
 WZUWIx0YWh/r7lJsNyQ9B0VymuYNQWkFGUOZcOwSBZxFh5Sew0qNbjXEnu660IK9e2XwZLCcb
 N7PsJrrOFOVbZ3SSm2kBMqmhxb/sLRxJwwhogq7oH2J4GUI9Rm0LqL7iolozfXLrfIMmuqAy9
 fbJSYFUMn4TyaYpmQ1xjHp3PuwT6pkiXqBY7/5/mPIBDXHooADtY1OqhE5Jt6kfTDwf6bi5pp
 kefvwHxcsG0ERBKxkYuKN8vPxrSrhmeQ11EPFoJfzmOQbgjbjlHQKjphHauFbh/ieBk9F9kRY
 6P85JDSzWXmDGhaJvof6HcxjD9IUlBqJd+xdv8fUK/Q53EAevan5j5nN95ylrpcvsqJKRs5it
 BP1m1Y0unMC1vThk9WE3OsJ8Cl5YOezn4WWa6BbkCpOp0GYtDV9ikGHwhicHChQYQICR36Afl
 0zsokWKFgeV7ZCfehmvea5NDfNyxva6WzfKGikIcoUrWYi2Ev5bUQU6C7/JjlxXARU3qSsqm0
 ejsF8CGfb2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1077966491-1542204442=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Wed, 14 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> On Wed, Nov 14 2018, Stefan Beller wrote:
> 
> >> But maybe I'm being overly paranoid. What do those more familiar with
> >> this think?
> >
> > I am not too worried,
> > * as rebase is a main porcelain, that is even hard to use in a script.
> >   so any failures are not deep down in some automation,
> >   but when found exposed quickly (and hopefully reported).
> > * 5541bd5b8f was merged to next a month ago; internally we
> >    distribute the next branch to Googlers (on a weekly basis)
> >    and we have not had any bug reports regarding rebase.
> >    (Maybe our environment is too strict for the wide range
> >     of bugs reported)
> 
> I do the same at Booking.com (although at a more ad-hoc schedule) and
> got the report whose fix is now sitting in "pu" noted upthread.
> 
> I fear that these sorts of corporate environments, both Google's and
> Booking's, end up testing a relatively narrow featureset. Most people
> have similar enough workflows, e.g. just using "git pull --rebase",
> I'd be surprised if we have more than 2-3 internal users who ever use
> the --onto option for example.
> 
> > * Johannes reported that the rebase is used in GfW
> >    https://public-inbox.org/git/nycvar.QRO.7.76.6.1808241320540.73@tvgsbejvaqbjf.bet/
> >    https://github.com/git-for-windows/git/pull/1800
> >    and from my cursory reading it is part of
> >    2.19.windows, which has a large user base.
> >
> >> (and would re-enable rebase.useBuiltin=true in
> >> master right after 2.20 is out the door).
> >
> > That would be fine with me as well, but I'd rather
> > document rebase.useBuiltin instead of flip-flopping
> > the switch around the release.
> >
> > Have there been any fixes that are only in
> > the C version (has the shell version already bitrotted)?
> 
> That's a good question, one which I don't think we knew the answer to
> before the following patches.

I pay close attention to `git rebase` bug reports and patches (obviously),
and there have not been any changes going into the built-in rebase/rebase
-i that necessitated changes also in the scripted version.

Ciao,
Dscho

> As it turns out no, we still run the tests without failures with
> GIT_TEST_REBASE_USE_BUILTIN=false.
> 
> Ævar Arnfjörð Bjarmason (2):
>   rebase doc: document rebase.useBuiltin
>   tests: add a special setup where rebase.useBuiltin is off
> 
>  Documentation/config/rebase.txt | 14 ++++++++++++++
>  builtin/rebase.c                |  5 ++++-
>  t/README                        |  3 +++
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> -- 
> 2.19.1.1182.g4ecb1133ce
> 
> 
--8323328-1077966491-1542204442=:39--
