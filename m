Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B101202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 23:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751645AbdB1XSG (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 18:18:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:51997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbdB1XSE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 18:18:04 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mb7lL-1d2Ry326kV-00KjmA; Wed, 01
 Mar 2017 00:10:53 +0100
Date:   Wed, 1 Mar 2017 00:10:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Use time_t
In-Reply-To: <6bd6ef64-2749-f17a-aea8-d25b147892c5@web.de>
Message-ID: <alpine.DEB.2.20.1703010000260.3767@virtualbox>
References: <cover.1488231002.git.johannes.schindelin@gmx.de> <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net> <f6b57868-0173-48d9-86cb-79780f7e301b@web.de> <xmqqa896kuve.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702282149160.3767@virtualbox>
 <6bd6ef64-2749-f17a-aea8-d25b147892c5@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-960784029-1488323452=:3767"
X-Provags-ID: V03:K0:w8Q/mLtD/peYQaA6IauggL0HV3GBGKH1Q+tI7zYq6A+ZGTQ1NeU
 I/AUtOyq3VBZ6g4vc6tNeQWULgSl0yQOqnjB7J9v5zPMezyy0XkpRtbtOJKDz9YT8DtkYVJ
 N3uQ5U54R9zy3LGLHNrSBMIprzb7HKJFZUsWikGD7UIotH4rUkSM3J4F1BGFtN6q5kRuLDp
 acF8pYXda2P8F+Zkf7QSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VwGKiLEA2K8=:PZ6AM5edP9/Ouq3oYB8CdD
 um8FqXjmy0nqAm1JpYojAvQyOaPV7tRXAVQ8h4e0iMOoPF1W1t5M758xt2gxWg/SuHhWTeivL
 R2mCzVaS+GwDeNZO1XOvkxijPdZZeHhF4EkeZ2rz3kf7d0YtThmKaqkTgoa4OeDyOhGZfx5f7
 cMwjj1Am5PJ5S4v9Efdjtk8Cul4waHzDPBl0GB0I8fshnxkPvSa5jyTXJk4nea+sPgowV0537
 zf2CDkQKjY9fCDLYzLXOCfu6ah76N8W4oJUZGDMhoN0lRWecIbuNqjXiXeGK6fRoJXlwPYUXn
 ZeeHPq68vhbruENHMVgdK8uQfD7l2PF32ctgLPUR/Ywrf7nUiIayYYT6x/BZqTE2KBrHkBx2S
 sj97DbqOAEPY0qhX+MZ5O7VRObFsFJBLJ6InoNqmZJ7Km5EQcovBsQ6bY6pA1uvmGOOi83JH0
 DUxltN+H4OZMBfLv8r9LQuhZo/iHjpf/VV1DOA9vRhx1kjq6xkyhylmqICoQH6H9jdJxi50yU
 6dB4m9BenNGnU7+kmBuqiqcZKjPnFwDWlEMXQ5+0jXYhZ07w+NpmO1oWC88EFlqSONsfrgX7I
 e4oerPDyFvhCYlFDvOzFk/razK/idHGOGvt6P+MfWfXePjMVdN4+HDD392TIXUQiXlFpt4oaD
 ji9ckEF/I9C93e8Hn3zEkX4yLkPf0pMAcRusXv3uFrX/JLu2Pis5JNRH2B89gXDgUXYQF+zz+
 etTN/CDY58e3agL0yszPBc0isLBrRSOLjglw+RQuMBxJNzvziHV1G6Tysjb79HQ9grle/h7rc
 hv7tK64WvciT2x2wUN1IksKOdbosg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-960784029-1488323452=:3767
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Tue, 28 Feb 2017, Ren=C3=A9 Scharfe wrote:

> Am 28.02.2017 um 21:54 schrieb Johannes Schindelin:
> >
> > On Tue, 28 Feb 2017, Junio C Hamano wrote:
> >
> > > Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
> > >
> > > > Am 28.02.2017 um 15:28 schrieb Jeff King:
> > > >
> > > > > It looks from the discussion like the sanest path forward is our
> > > > > own signed-64bit timestamp_t. That's unfortunate compared to
> > > > > using the standard time_t, but hopefully it would reduce the
> > > > > number of knobs (like TIME_T_IS_INT64) in the long run.
> > > >
> > > > Glibc will get a way to enable 64-bit time_t on 32-bit platforms
> > > > eventually
> > > > (https://sourceware.org/glibc/wiki/Y2038ProofnessDesign).  Can
> > > > platforms that won't provide a 64-bit time_t by 2038 be actually
> > > > used at that point?  How would we get time information on them?
> > > > How would a custom timestamp_t help us?
> > >
> > > That's a sensible "wait, let's step back a bit".  I take it that you
> > > are saying "time_t is just fine", and I am inclined to agree.
> > >
> > > Right now, they may be able to have future timestamps ranging to
> > > year 2100 and switching to time_t would limit their ability to
> > > express future time to 2038 but they would be able to express
> > > timestamp in the past to cover most of 20th century.  Given that
> > > these 32-bit time_t software platforms will die off before year 2038
> > > (either by underlying hardware getting obsolete, or software updated
> > > to handle 64-bit time_t), the (temporary) loss of 2038-2100 range
> > > would not be too big a deal to warrant additional complexity.
> >
> > You seem to assume that time_t is required to be signed. But from my
> > understanding that is only guaranteed by POSIX, not by ISO C.
> >
> > We may very well buy ourselves a ton of trouble if we decide to switch
> > to `time_t` rather than to `int64_t`.
>=20
> True, and time_t doesn't even have to be an integer type.  But which
> platforms capable of running git use something else than int32_t or
> int64_t?

That kind of thinking is dangerous. We don't know what platforms are
running Git, and we have a very clear example how we got it very wrong
recently, when we broke building with musl by requiring REG_STARTEND
support [*1*].

So why gamble? If we switch to uint64_t, it would definitely provide the
smoothest upgrade path. It is what the code assumed implicitly when we
broke 32-bit in v2.9.1.

If anybody really wants to support negative timestamps, it should be done
on top of my work. My current patch series does not even start to try to
address the ramifications of negative timestamps (see e.g. the use of
strtoull() for parsing). It is quite unreasonable to ask for such a
fundamental design change when it could very easily be done incrementally
instead, when needed, by someone who needs it.

My work would pave the way for that effort, of course. But this is really
as far as I can go with this patch series, given that I have bigger fish
to fry than to support negative timestamps.

Ciao,
Dscho

Footnote *1*: I still deeply regret deviating from my v1 that did *not*
require REG_STARTEND, but would have kept things working for platforms
without REG_STARTEND by simulating it.

But our thinking was: who would want to run Git in an environment so
ridiculously old that it does not have that clearly useful REG_STARTEND
support? Our answer was "nobody". And it was incorrect.
--8323329-960784029-1488323452=:3767--
