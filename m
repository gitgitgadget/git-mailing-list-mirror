Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DAA61F453
	for <e@80x24.org>; Wed, 30 Jan 2019 18:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbfA3SnU (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 13:43:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:53543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733186AbfA3SnU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 13:43:20 -0500
Received: from MININT-6BKU6QN ([62.119.166.9]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEFqW-1gvTKB2yt6-00FSDN; Wed, 30
 Jan 2019 19:43:04 +0100
Date:   Wed, 30 Jan 2019 19:42:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
In-Reply-To: <87y3722sz7.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901301935010.41@tvgsbejvaqbjf.bet>
References: <pull.114.git.gitgitgadget@gmail.com> <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com> <20190129160030.GA7083@sigill.intra.peff.net> <87zhrj2n2l.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1901301317120.41@tvgsbejvaqbjf.bet>
 <87y3722sz7.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-645068560-1548873783=:41"
X-Provags-ID: V03:K1:Lde8yahAbk7au8V8qCjHrRrxuoInQI84hScj/ebmfjjdM0SEp/z
 m69ddz4f0mw05jeKm+9lJv+tL3CinBZ1efElcd2L0vevRnnhvH4heCiNvokz0w31R8gDafi
 JGDzXs+0znAk4O/ghM55HKr/javeMazUHJCa3J6eEY3F1t7SUXNROmJB2Di7o4+8gYajCwX
 In5PmwR6FIRALfkl6+YKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X9Y5Do9//h4=:mJuPAs1LmgJlzQv8b0s/CC
 Wv0BArGOZKYcWYxARec0usUfU7hUk7kgzU3gFZklukzYizLnTOtHBbK5dNHWGuI4AMPZRGBtn
 leB756+LGn3pMtWcv4Aj+23sEciz+cmOP8T4j1UjrrfAYk07VU/C6KwiH4Y11f0UK46CECnle
 PWdTiUnUazLAX2HhaR+6eukzezuAarxTNNDVxQoTH2F4HfkDdnpexozAAHaatOFkjHgwEqAFJ
 DMzthrId38gEWvKNGh4O4LpZ7YVs2Bv7IdMwbKme3wDjE04OvQSOQfcLOmb0FKTzBkRMBLcO2
 Fui3shz9ZBjaAFACV8uxA2qh7SEaC1lMIeS7zdH4Bm7Iw3qJmQct6YmRr4NVgfhqSvnuWDUZG
 Lrxshpz4an9pm+kdW1M4r2gyrjcCNZQ0fb4eqSAH7JqoqpcKjrflsc2hhpbLO5AWn7A/4UwQN
 gKfk36Y8SLLoE4po79N4xt9M2GuFRWHResTuuAZUz0wu/rkQyNoruVhhBfxvRYsQwe5/Rcakh
 n8VWSxKyMV8/b/Eu0kpQzHIPLTizDY834bJVTE3JlWXOfXZF04+ECY4y1E6P5OMy4DJdftRGv
 VxcsmkchMSowAx7eNRrGcPS84aSh7GvDeh8rfzGPVul+oe9tBUcvJypzLA/kg1uV3yh5+wW5e
 l1EKmVFByhtR3Xu4+8BnUfrrRbj6924zj2rfl7/7aSCloeQftsEDJKh2e3SiucgvNlj4anBw0
 yQPbEN23OrmObpPVUqL2ZaJSp4W2tzlkf+kfxpcRsOD8O37qUEQZL4Q7ftnHAjlLVB2wF+w5N
 SMaqfb34IYh4c6x42Om1FkgrBM/wYGx7hEw7TJNw9Rl9I2Q7ipPrLqIrAKdp3ZBJjw8HQDe4O
 2so9ELggcKe8ZQL+vlLYPzl8rdp/gfFz/3uPYW3L+4EqhcOwaEQ5wYx3ByH4eoDULQ4HmjLyR
 fEo0KO8NFMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-645068560-1548873783=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Wed, 30 Jan 2019, Ævar Arnfjörð Bjarmason wrote:

> On Wed, Jan 30 2019, Johannes Schindelin wrote:
> 
> > On Tue, 29 Jan 2019, Ævar Arnfjörð Bjarmason wrote:
> >
> >> On Tue, Jan 29 2019, Jeff King wrote:
> >>
> >> > On Tue, Jan 29, 2019 at 06:56:08AM -0800, Derrick Stolee via
> >> > GitGitGadget wrote:
> >> >
> >> >> From: Derrick Stolee <dstolee@microsoft.com>
> >> >>
> >> >> When running the test suite for code coverage using
> >> >> 'make coverage-test', a single test failure stops the
> >> >> test suite from completing. This leads to significant
> >> >> undercounting of covered blocks.
> >> >>
> >> >> Add two new targets to the Makefile:
> >> >>
> >> >> * 'prove' runs the test suite using 'prove'.
> >> >>
> >> >> * 'coverage-prove' compiles the source using the
> >> >>   coverage flags, then runs the test suite using
> >> >>   'prove'.
> >> >>
> >> >> These targets are modeled after the 'test' and
> >> >> 'coverage-test' targets.
> >> >
> >> > I think these are reasonable to have (and I personally much prefer
> >> > "prove" to the raw "make test" output anyway).
> >>
> >> I wonder if anyone would mind if we removed the non-prove path.
> >>
> >> When I added it in 5099b99d25 ("test-lib: Adjust output to be valid TAP
> >> format", 2010-06-24) there were still some commonly shipped OS's that
> >> had a crappy old "prove", but now almost a decade later that's not a
> >> practical problem, and it's installed by default with perl, and we
> >> already depend on perl for the tests.
> >
> > It's not only about crappy old `prove`, it is also about requiring Perl
> > (and remember, Perl is not really native in Git for Windows' case;
> 
> We require perl now for testing, NO_PERL is just for the installed
> version of git.

Which is confusing, if you want to put it nicely.

> If you change the various test-lib.sh and test-lib-functions.sh that
> unconditionally uses "perl" or "$PERL_PATH" hundreds/thousands (didn't
> take an exact count, just watched fail scroll by) tests fail.

I know. Oh boy, I know.

But we do not have to keep that status quo, nor do we have to make it
worse.

It would not surprise me in the least if we could accelerate our entire
test suite by reducing our heavy reliance on scripting (including Perl) to
the point that it really takes too little time *not* to run. (Right now,
if you are on Windows, you better think twice before you start the test
suite, it will easily take over 3h (!!!) to run in a regular developer
setup. Even on a regular Mac, I would think twice before starting the run
that blocks my machine for easily 20 minutes straight. Needless to say
that few developers, if any, use it to validate their patches, in
particular on Windows. Meaning: for all real purposes, the test suite is
nearly useless on Windows.)

So let's not bake *even more* Perl usage into our test suite. Thanks.

> So my assumption is that anyone running the tests now has perl anyway,
> and thus a further hard dependency on it won't hurt anything.

By that token, the effort to turn many a script into a built-in for better
performance and substantially better error checking would be totally
nonsensical. "Because anyone running Git used those scripts anyway, so
making them a hard dependency won't hurt anything"?

I do not believe even a fraction of a second that that effort is
nonsensical. Just like I do not believe even a fraction of a second that
it makes sense for our test suite to rely on scripting so much. Or for us
to make that reliance even bigger, for that matter.

> > I still have a hunch that we could save on time *dramatically* by
> > simply running through regular `make` rather than through `prove`).
> 
> My hunch is that on the OS's where this would matter (e.g. Windows) the
> overhead is mainly spawning the processes, and it doesn't matter if it's
> make or perl doing the spawning, but I have nothing to back that up...

I have at least the experience of several thousands runs of the test suite
on Windows, together with a couple dozen hours spent recently *just* on
making the CI of GitGitGadget at least bearable.

So I do not quite understand why you offered a contrary opinion when you
have nothing to back it up.

I mean, I would really like to have an informed discussion with you, to
benefit from your skills and from your experience to make the entire
design of our test suite better (there is so much room for improvement, we
should really be able to put together our knowledge to enhance it). It
needs to be based on facts, of course.

Ciao,
Dscho
--8323328-645068560-1548873783=:41--
