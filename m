Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDC831F453
	for <e@80x24.org>; Thu, 18 Oct 2018 10:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeJRSBM (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 14:01:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:45169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbeJRSBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 14:01:12 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNq4h-1gG576324p-007VAv; Thu, 18
 Oct 2018 12:00:55 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNq4h-1gG576324p-007VAv; Thu, 18
 Oct 2018 12:00:55 +0200
Date:   Thu, 18 Oct 2018 12:01:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: On overriding make variables from the environment...
In-Reply-To: <20181017142923.GR19800@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1810181159200.4546@tvgsbejvaqbjf.bet>
References: <20181016184537.GN19800@szeder.dev> <20181016215456.GB96853@aiede.svl.corp.google.com> <20181016223330.GP19800@szeder.dev> <20181016224001.GC96853@aiede.svl.corp.google.com> <20181017142923.GR19800@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1884435874-1539856861=:4546"
X-Provags-ID: V03:K1:zj/eygRKnCCa0+ovCQ2UkwjvuvyrVS7fxLZ7Py6S1I6A5W9Gvik
 8ou9C/v/EStAFLW6Vp7umStASo51PrEjN87F5SqOb7ZLoMUNLNx7UqWU8tr5RHxuW3zJK8v
 Ivt0sd4JMeePPvMvAjFtSMp7omV/KIxSTYPQnMB4dukDmFfTtEysDdIA+FqSiW5Y/ErMUbk
 +xxVk0zRLpEXe/sOwnEXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cKbhrgWSp4w=:ZTnHVGbhJ1gHpGmM68TkGt
 QGHmfnwRqGj0m4gdxSERnS4dGMdLyvsxfxKCd6s+KR4T78C/C1mvzHsvxe03CJNdNI8PvV1kS
 4vACgDBh2FSsX5J5hW1R9H55RVyJ9LZ0+gzZkcbKp67TUp3KzNgUVxOgTfj3x7DBEpHKicUdU
 k2YA8/G0xRjuaurb79Y/Q0EcnPrtmt1knq9uGvyamiArkSx3QFw7NoigS+fQvJxtKEOjYRJ7S
 AzvAwYPBit/NsNhjZy40EiwlNEX0ibnrn61TpZengXpkUZy8lKJfL9rRVLda5oiz/GhjxTIca
 +ILpw0lt6a93WoPAtOUiMV1igNCSp/avkCPwKtq3kO8s+1ksaoNcmKIrgWpCKo+2V0G9TpxLY
 tMTGi5zCwAxGdorvggVwD5I4KXhluLr04VIF5uI0QhG9ynsukh0KQshqiXFfrDlR2dSHTWYBe
 ZAbieoiNLpLTrnh9b9UYbILnd0vJDlJSWa4dleRTVsINrWQDcfSkaWRfgld3vsTWrdFtDfp/J
 GC5vBZnmGaHkKqn+kOLpOQz4X2waFQwRB4iJyav1wDKBNaVffDK6fhUV2DbWwRtZwB+2UNVwV
 kohEV4yjG1TRlHEMn/6GvqRNID862zL3k+nQMCddQoxrAADY78vCrRKcdt29s/Ir1qC/oVrpK
 vldnMXLLsp+aMAFYgoCHaUykkZYHMK8g5b7QD42NcXTY2O0tw4Jvz+4NAZTsLOA7EeGJ4HgD7
 18UHxC1e5nRr8om80hRRv1A3nPfloC93sDA6/crF3aIPNd9fODs3RSTCIbd60VTNCFxM5gZ0r
 ZD98AMTzQvIlFG4fyAfnps/mIk2nyZZMvLHIZXjjhehxp+Tn4U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1884435874-1539856861=:4546
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Wed, 17 Oct 2018, SZEDER Gábor wrote:

> On Tue, Oct 16, 2018 at 03:40:01PM -0700, Jonathan Nieder wrote:
> > SZEDER Gábor wrote:
> > > On Tue, Oct 16, 2018 at 02:54:56PM -0700, Jonathan Nieder wrote:
> > >> SZEDER Gábor wrote:
> > 
> > >>> Our Makefile has lines like these:
> > >>>
> > >>>   CFLAGS = -g -O2 -Wall
> > >>>   CC = cc
> > >>>   AR = ar
> > >>>   SPATCH = spatch
> > [...]
> > >>> I'm not sure what to do.  I'm fine with updating our 'ci/' scripts to
> > >>> explicitly respect CC in the environment (either by running 'make
> > >>> CC=$CC' or by writing $CC into 'config.mak').  Or I could update our
> > >>> Makefile to use '?=' for specific variables, but:
> > >>
> > >> That's a good question.  I don't have a strong opinion myself, so I
> > >> tend to trust larger projects like Linux to have thought this through
> > >> more, and they use 'CC = cc' as well.
> > >
> > > I don't think Linux is a good example to follow in this case, see e.g.
> > > 6d62c983f7 (Makefile: Change the default compiler from "gcc" to "cc",
> > > 2011-12-20) (in short: Git is supposed to be buildable with compilers
> > > other than GCC as well, while Linux not really, so they can hardcode
> > > 'CC = gcc').
> > 
> > Nowadays Linux builds with clang as well.  People also have other
> > reasons to override the CC setting (cross-compiling, etc) and to
> > override other settings like CFLAGS.
> > 
> > > Also, the projects I have on hand usually have 'CC = gcc' hardcoded in
> > > their Makefiles, too, but those Makefiles were generated by their
> > > ./configure script (which in turn by ./autogen.sh...), and those tend
> > > to write CC from the environment into the generated Makefiles.
> > 
> > Yes, I think that's what makes travis's setup normally work.  It makes
> > sense to me since ./configure is expected to have more implicit or
> > automatic behavior.  For "make", I kind of like that it doesn't depend
> > on environment variables that I am not thinking about when debugging a
> > reported build problem.
> > 
> > When building Git without autoconf, the corresponding place for
> > settings is config.mak.  Would it make sense for the ci scripts to
> > write a config.mak file?
> 
> A first I though it doesn't, but it turns out it acually does.
> 
> 'ci/run-build-and-tests.sh' basically runs:
> 
>   make
>   make test
> 
> I naively put a 'CC=$CC' argument at the end of the first command,
> thinking it should Just Work...  but then that second 'make test' got
> all clever on me, said "* new build flags", and then proceeded to
> rebuild everything with the default 'cc'.  (With the additional
> complication, that on Travis CI we actually run 'make --quiet test',
> which rebuilds everything, well, quietly...  so the rebuild itself is
> not even visible in the build logs.)
> 
> So, then it's either 'config.mak', or passing a 'CC=$CC' argument to
> _all_ make commands, including those that are not supposed to build
> anything, but only run the tests.  I find the latter aesthetically not
> particularly pleasing.

How about using `MAKEFLAGS`? I ran a quick test:

	MAKEFLAGS='CC=blub' make -C .. git.o
	make: Entering directory '/usr/src/git/wip'
	    * new build flags
	    CC git.o
	/bin/sh: blub: command not found

In other words, you could add something like this to the ci/ script:

	MAKEFLAGS="${MAKEFLAGS:+$MAKEFLAGS }CC=$CC"
	export MAKEFLAGS

Ciao,
Dscho
--8323328-1884435874-1539856861=:4546--
