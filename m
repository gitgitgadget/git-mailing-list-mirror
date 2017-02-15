Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 859912013A
	for <e@80x24.org>; Wed, 15 Feb 2017 14:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750791AbdBOOXC (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 09:23:02 -0500
Received: from mout.gmx.net ([212.227.17.22]:57146 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbdBOOXB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 09:23:01 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6fXs-1cPn2e0DyO-00wRCW; Wed, 15
 Feb 2017 15:22:44 +0100
Date:   Wed, 15 Feb 2017 15:22:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Philip Oakley <philipoakley@iee.org>
cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git-for-windows@googlegroups.com, git <git@vger.kernel.org>
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
In-Reply-To: <E2C1B7A8FBF94C8CB1C9C5754D882800@PhilipOakley>
Message-ID: <alpine.DEB.2.20.1702151509251.3496@virtualbox>
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox> <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702142150220.3496@virtualbox> <xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com> <CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com>
 <E2C1B7A8FBF94C8CB1C9C5754D882800@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PVVs8kjQadaQqVOoMfs67QBYK7LvboDgUU+Py9lMhcSCT9Bqy6n
 jT+A/D52qtBC5RD2je5WpLwY3jxC80BSIiwkJ2/1pE/Fpv0lg2sXLj79CgEk+uTu1XryGR7
 WvWQaZvi3caNPmur1/YXuruYVZiwgY2zKLX8Le32L1zwwgUdvJvjf283SrMOAtn0J0IzXHh
 v6FS/StgETXInJh8y22Tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GFg+ddZanQg=:TQcGgWCgxs62ubhDd2u7Es
 iymI+Kw40GrZ2A/IRZ4FEK6xw8Rx2ffEfX3feAThlcLP4y3thijM4G0/1rcbDzVID6xvqjIPI
 HaHqREREJGm44TTZZKpiRz84kjLUFTA+xoPVCLW4fzzOUPR0h5NAL7KlS5m43KTRdFxZakv7W
 ZZF8JiILQySMnF078Y1lJCm/WkmVZEiUCmMv5HdwxKXJrPXQX1tSaqFJRSjTCDFec/dYNLeyk
 TuQhnnJWviMvdHB0YLjGMv/PfxPkslaFWfBnI7TcU3j6g1zpiSWBUmemQ7oxC238FTXHfRi9g
 KZXY/ZzyD0RnyqW5s7FNhxP5UBo9wTPY+iilDVitlC8fKRCMOn3ISvMB0tTSx+Zya+oS9h9Ms
 KEyGxDdQrw84ZvsqtEXmwulEO41qYCtjnrtjtIVlFXo8d6Hf5z/WglHsiIdukI2ca0J6AUz4w
 LDMb9duhhvVNmUqVotlfsoQvKhfNo9YjhEgxzYNoHLcSUvQO+iFt0LHwM6pk9TjKLuURC2dW8
 PqSSfI94akQWrS1ufaN6qForV7saMsjo8akJFCD9ffcsfdomiG+EVB4yBaFFqgEdJCVJWjDt9
 GlFOEe6xxsuE1Sn3gjS5j3KJ01btQgnaXl5XXsXChIjyha+nUjamqnWIUSC3jHBSqCRtJdC2a
 z7M5YsvjXL62YUDQmndFcVOoojkHun24NvXhRh2RBXP8ein67godXYEcxyguX9GE4F1GfHc0Y
 sleb4M0b8juumgwlNmX+XHl39WG7H4uVSHqjdgZoTWThfPhqAdcL8qJzVnsnDKomBBo4JlrYZ
 MJE1CSJ/gFTQ4ztOhmFkAAr5gmS1XE7Gi0adRgaMpiFmx+QwVQzSVV4x/QG1vyvyuqBe9L2Bq
 NMqMKSJEuqOJop5PxM92jZZojrphf0f9xFYXkH6fXGoJqWEJ1UiQLGVYyYSdCWrHbgr1YkchL
 i1d6Eq8mh6w+K9vRk086ovQviTeVqnuJhuGsmo1VU9JRb8dGSswYzM1cnGnT+33vHxzmLKfKl
 cuz6YerSVCA1ulUDWVnsr/iiubvNRg5ooqf6dZ2o8DpjE1Nwpj0c12bU2HdOyzgkOQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Tue, 14 Feb 2017, Philip Oakley wrote:

> From: "Christian Couder" <christian.couder@gmail.com>
> > On Tue, Feb 14, 2017 at 10:08 PM, Junio C Hamano <gitster@pobox.com>
> > wrote:
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >
> > > > On Mon, 13 Feb 2017, Junio C Hamano wrote:
> > > >
> > > > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > > >
> > > > > > That is why I taught the Git for Windows CI job that tests the
> > > > > > four upstream Git integration branches to *also* bisect test
> > > > > > breakages and then upload comments to the identified commit on
> > > > > > GitHub
> > > > >
> > > > > Good.  I do not think it is useful to try 'pu' as an aggregate
> > > > > and expect it to always build and work [*1*], but your "bisect
> > > > > and pinpoint" approach makes it useful to identify individual
> > > > > topic that brings in a breakage.
> > > >
> > > > Sadly the many different merge bases[*1*] between `next` and `pu`
> > > > (which are the obvious good/bad points for bisecting
> > > > automatically) bring my build agents to its knees. I may have to
> > > > disable the bisecting feature as a consequence.
> >
> > Yeah, this is a bug in the bisect algorithm. Fixing it is in the GSoC
> > 2017 Ideas.
> 
> There are also a few ideas at the SO answers:
> http://stackoverflow.com/a/5652323/717355

Thanks for that link!

However, my main aim was not to get distracted into yet another corner of
Git that needs to be fixed (I am on enough of those projects already).

I was merely surprised (and not in a good way) that a plenty ordinary
bisect between `next` and `pu` all of a sudden tested a *one year old*
commit whether it was good or not.

And I doubt that the strategy to mark all second parents of all merge
commits in pu..next as "good" would work well, as the merge bases *still*
would have to be tested.

I guess what I have to resort to is this: if I know that `next` tests
fine, and that `pu` fails, I shall mark all merge bases as "good". I am
sure this has its own set of pitfalls, undoubtedly costing me more time on
that front...

But at least my cursory analysis of this idea seems to make sense: I use
`next` essentially as a catch-all to verify that the breakage has entered
`pu`, but not yet `next`. This reasoning makes sense, given that we know
the waterfall topology of pu/next/master/maint: patches enter from left to
right, i.e. anything that entered `pu` may later enter `next`, but not
vice versa.

Ciao,
Dscho
