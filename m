Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E242203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 14:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbcGUOc0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 10:32:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:61047 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbcGUOcY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 10:32:24 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MYwQh-1bn13R1IXr-00Vh9T; Thu, 21 Jul 2016 16:32:18
 +0200
Date:	Thu, 21 Jul 2016 16:31:34 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Christian Couder <christian.couder@gmail.com>
cc:	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] GitRev News edition 17
In-Reply-To: <CAP8UFD1TWYct7OJDcP+w8AYNTroquZ++T_1ovt-Z7SrBtn_S+Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607211631100.14111@virtualbox>
References: <CAP8UFD2PjKHkcs-EWzDU6eWF9ar7BzOxRB838iFr6iDAaGnkeA@mail.gmail.com> <CAPc5daXoL+v-YWy-EQ=d-8m9o8twv6Cs5U_NL14KGzPMVNQUPg@mail.gmail.com> <CAP8UFD1TWYct7OJDcP+w8AYNTroquZ++T_1ovt-Z7SrBtn_S+Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Vqr2ig1kRJhbP9Yh7OSctPaYgI9kiQTVi0IC4svnmJhMZ2J04YS
 p5nemwca6BzRM7X8R4VDWtHWFroSoGITy9TnBaGjbh2OMcbFzEi9TMgj2l3w1B76FSAllnR
 WuePLg2+Cl0YG4jqHtndhuEA9MXg3zGaL+AQvHvVD3oUUbLP2UHog9gd54YG3sAX5W0+Omp
 ivqj5d97kTye6nAwg6A4A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:/f2cHSb+ca0=:SefBfVdA93aI9bP7GSXIPM
 cblZvFBLRaABMPWOvLd+D8L2cyNC4hSY2PvG/wbXsEGzWdxsa00IsJr+ceL6W8YoUJewWBUW0
 QON5WlWQYTm4lsBHc3NpLI/NcH3Iu8sGros6bIM5h7FZIqW7jY7sKgtbbx7i6k2oMOufovknB
 9iHxoIdB8FzvgqtzW9XMtDIrhBZtXDgnl7IUx+JH+oMvgdQqP9wG+geLOsIjebPixjk7eG4Ie
 qh2pFAsgQB/rN4LGDijmpkQ44uKqoOBqrcgPQ62iPvk22OJiz3IisG0tQrrZDYRNIVfwevgXJ
 mDpT7SZ3WxYUQ5Km4SOKDcSD8G2GqdQO+HU/EczqwZqAdNAVc13I9xbryJuBIBey5fML8RmFb
 4LyHn5c7lNabR94iaUd7PYbddXFX5cVzY6uH0oqWyOdEaouR1hPAAojQiq5Z2Ib2mofL9bzOq
 W7yX0H+UY2pcdU+sM4CvA93qe0BxXV3sEgXEymbP6gTpHWdEKy1NPVyUXJhrv7rQ/CQItRd0o
 Ub+pu1WXYWP64mwNHtBO1w8R9De82CH3VlrNA8KLielX25braD0Qe8oTxWezu2Uqd6pW4uVc/
 VX9Xo1Ut0FfR9/hVHzLQM4pVHZ/PyrGGpVCfQ8bNabn93KWoxN+csqu4rK8ZSHry+GcOEuv0S
 ehNZVXT/mV6YkPm4mDXh4JVsc6ZgBlclrxxs2A3/3KAyOkROwOrWvjR3k3CKIxNwP4s45IGL7
 7VsqeJn4ZKIOQa2z9XY58kxrtObiOaNfpXwIh9gHdqk9QrRkuIXjo2EevRdx3b4G2mE8aBbmY
 VA7a6JR
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Wed, 20 Jul 2016, Christian Couder wrote:

> On Wed, Jul 20, 2016 at 8:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > On Wed, Jul 20, 2016 at 5:58 AM, Christian Couder
> > <christian.couder@gmail.com> wrote:
> >> Hi everyone,
> >>
> >> I'm happy announce that the 17th edition of Git Rev News is now published:
> >>
> >> https://git.github.io/rev_news/2016/07/20/edition-17/
> >
> > Micronit. 2.9.1 (or 2.9.2) would not be a "major release". 2.9.0 was,
> > and x.y.z (z > 0) are "maintenance releases".
> 
> Yeah, I wondered about that when I saw :
> 
> https://github.com/git/git.github.io/commit/d2eb8fbbb30594d19fcda731c309ad03229dc5d5
> 
> but forgot to ask or do something about it...

Sorry, pure copy-paste error.

Ciao,
Dscho
