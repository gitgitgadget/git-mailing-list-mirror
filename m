Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A88A2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 14:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbcGMOBu (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 10:01:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:53061 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbcGMOBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 10:01:49 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M51eM-1bAle30bU6-00zGNq; Wed, 13 Jul 2016 16:00:49
 +0200
Date:	Wed, 13 Jul 2016 16:00:46 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <xmqq60sa7rj2.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607131600110.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607120927410.6426@virtualbox> <xmqqpoqj6i3d.fsf@gitster.mtv.corp.google.com>
 <20160712151630.GE613@sigill.intra.peff.net> <CAPc5daWcb5bfgsxMP0vCrQ7gBdeYBgefzPNHztaaCKzqbCv2aQ@mail.gmail.com> <20160712153520.GG613@sigill.intra.peff.net> <xmqqlh167tjd.fsf@gitster.mtv.corp.google.com> <20160712160921.GA2965@sigill.intra.peff.net>
 <xmqq60sa7rj2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DIl9dLe5oxBcQ39L3bBvw9hhFIofrbWaeyOk6zQTBDf+nyUmW6q
 aeAxbhR+B2PzS9/BwE2/Vg+T+K4d5NyFGRi5emngxfGHXu9THo/7oCImfVS6PKmASafd/Wh
 itiDJkuZWXpNXs+Je8/FdWVbbUQhdifX6y8xxnDtK+A3y5T3Rpg4dSLPJNKEkUXp3DYlVf2
 EieHb54i5igBdNl3oKW+g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:hzS6sCWNXf0=:CTiXSkNlynU7i4ID2cUsxX
 fdlLBVUsnoa9yRCitzhRxss+eumlkyj0FF3MvTJ1RhgnGZw40g5XpoDFya+201B15A3QEcKtu
 mi0psRJXqF3GgqsGfdVqej593SWAPktK7igmpGfIaRy817fakFLYf7Bj7MLuxAfQqGbSDmAxZ
 eazaVWDKQKFrzQX4W4RLRaP5agAZuiII9lH/jG1i6lzzxRqEmWqDraDSvBzQ95MfmlTccN5q9
 fo8Q4wUqrJ4yA06s/x+7ABLMSw9EKugBCI9nS6WDEj1Sic4CExwMWrVD2yFgmO4kkbwiiHV8W
 hEmWI8iN4m2QXw0rFM1F9TyxU2igZp2slH/qwhZHYq9xdpf4l9iiZljkKBiL9xGni35d4WBFf
 Y8REBulS6Tpo7/tQuO/oCDzdLMUVaaNKOgUUx+03d11/7Ozn+DECh0/73geUVjOIGDg/K03y8
 mcDvSfoY6rIrLsTJsqo+8oACRXdP/bX34SoVy01vLl8UB8TOTp6Ncnp6rWUiB1EW0n0sdAkNo
 UXFH0PlmIQwkiLa4ISLRtKaXYaAsOYKR9Z8hk30AXrHHHztN4k6pY8PVXGIY7jZgYOwxtIar2
 H4J4qzHRfYoW7K38wpH90LSlL6Ob7Bj2YDEE1nLWJIIdCYACvRx8RDZe6uzzlAlWV6gNwZsss
 pxGmrxwA6eMVMLp5ibR5/sh9I5kibikWH1/zmT0czcViUBgCqyJN/dg9pIJIEmZDcQBGSw+2p
 SLHiPvMbB/Xkvwc04Ywm0Ijp4AFv5UN2zaPsKfD3BENS02bkHJAUUYNhUEpSvHkV57M0rQqQN
 T84u/0G
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Tue, 12 Jul 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In case it wasn't clear, I was mostly guessing there. So I dug a bit
> > further, and indeed, I am wrong. Linux never bumped to a 64-bit time_t
> > on i386 because of the ABI headaches.
> 
> X-< (yes, I knew).
> 
> > That being said, I still think the "clamp to time_t" strategy is
> > reasonable. Unless you are doing something really exotic like pretending
> > to be from the future, nobody will care for 20 years.
> 
> Yup.  It is a minor regression for them to go from ulong to time_t,
> because they didn't have to care for 90 years or so but now they do
> in 20 years, I'd guess, but hopefully after that many years,
> everybody's time_t would be sufficiently large.
> 
> I suspect Cobol programmers in the 50s would have said a similar
> thing about the y2k timebomb they created back then, though ;-)
> 
> > And at that point, systems with a 32-bit time_t are going to have
> > to do _something_, because time() is going to start returning
> > bogus values. So as long as we behave reasonably (e.g., clamping
> > values and not generating wrapped nonsense), I think that's a fine
> > solution.
> 
> OK.

I kept the unsigned long -> time_t conversion after reading the thread so
far.

Ciao,
Dscho
