Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566B11FD99
	for <e@80x24.org>; Thu, 25 Aug 2016 11:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbcHYLnI (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 07:43:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:51779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753421AbcHYLnH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 07:43:07 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LlUZz-1b2BKH3UwR-00bKvO; Thu, 25 Aug 2016 13:42:43
 +0200
Date:   Thu, 25 Aug 2016 13:42:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dakota Hawkins <dakotahawkins@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Duy Nguyen <pclouds@gmail.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git for Windows documentation, was Re: [git-for-windows] Re:
 [ANNOUNCE] Git for Windows 2.9.3
In-Reply-To: <CAG0BQXmovWAjn8sE=CFGMXguRpEqU3xUbF03aSEN4OLxNc9oZg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608251339510.4924@virtualbox>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox> <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox> <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608181022250.4924@virtualbox>
 <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com> <alpine.DEB.2.20.1608231553030.4924@virtualbox> <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net> <alpine.DEB.2.20.1608231736180.4924@virtualbox> <alpine.DEB.2.20.1608231758260.4924@virtualbox>
 <xmqqzio3uw31.fsf@gitster.mtv.corp.google.com> <xmqqa8g3uppx.fsf@gitster.mtv.corp.google.com> <CAG0BQXmmW_0n4OMQVsVQ5+OKbNVpgXmXeExFUOXqY8nH=sg3Jw@mail.gmail.com> <alpine.DEB.2.20.1608241740320.4924@virtualbox>
 <CAG0BQXmovWAjn8sE=CFGMXguRpEqU3xUbF03aSEN4OLxNc9oZg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:34uvO5qzGqNYm8VQTz/wWWQCYkiUrLVOVlUbokvlADCheCx3EfG
 1uJSZpSirymZc0GMnTIDfCsEsvnNNsmEqsfKYjNWvqNt1i0D1bOg7gPoBHQE5Fe6Csm4QH+
 PhSogZaFR/hFXDkL+RE0gQjQdvS9uMila9y6frLthfTJUdK5HZp1wIrlxkg5/YB2NX2h4FY
 nSx7QQKZVW8qvG/2Wpm3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jmHGbCJ5jag=:4F06ct8BIRX6ZMZ1J5wbQH
 SXM/wLJ+oSfbnw0WVb80GF9/Klxp2JRPERfxVbXP7utrKEhbT4b/G4jqTmN/tXAjww2FR42Cy
 nuBsS1lGTKrO6DRaKbjjINVI8TT+wdp0Ukr4dWcOgDRSg8EW688iBafmJetBHw/BxjKFSRJo4
 Xym401n8rCoKq8sJzWWmrF6jl89wqOjeNaL86q6s7GhWCxPLPLRHlwg6d35SmhA1AjGJYE68p
 1PNXXSzBNaCB0PspEgzbWRozz0CLT/M6kFz0tbmOQGi4PXcnUixbzl0CLJhQXLdWz2uNdQpKt
 jIJ8vcipauLqPYmp83UKWxZZmQhXq3QJX48EsS3kxsD668pRp9fRBqRW2GTfcPZcGfKf0zAs0
 JmgUAMl4ezAWw5wjrdLqSGRoDi8+g5zSvzeF6ka05C/+vHOqQqybsM1blD2g1Lf9xzrAj4ibM
 XnM8GY+zr/gUsjO68KL2E/PuA6t/9iCuEykmXpSqqYtG61ukN5PFCPGUNM2BqJp1pmOOWi0nn
 /royvaiMoilhbFuKPv3pAngcDV/8/27rYTznxpUFXb1zAWhaqN8UOamRtJq95MJi7ypwZlcDS
 oJiaBe2JDQJhwhHuXtoWKFcQxR/w9sKNmddTXlfdcBlRJRtJAtusHjvTq/2Cirq2CpIlWKr+D
 OXLoJfXqPE9iV6O7c8d9Ves63gpWQyNs9IbvrBGuEp3E3+SCGRsrznPNGrtIyaZBq+hmRbWVs
 y3nrJgaIhUtbGzC5P8OmUb1T5zZuhxjhQTzxoFzB3w/Tu3lipPyIbJLHoi5qrOM4FDA74IuOv
 wPwlpmv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dakota,

On Wed, 24 Aug 2016, Dakota Hawkins wrote:

> On Wed, Aug 24, 2016 at 11:41 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 23 Aug 2016, Dakota Hawkins wrote:
> >
> >> I use GFW almost exclusively, but I pretty much always consult the
> >> upstream documentation anyway (because I find it easier).
> >
> > Oh... I thought that typing "git help git-commit" opening a nice HTML
> > page in your favorite browser was good enough.
> >
> > Do you have any suggestion how to improve the user experience?
> 
> Just a small one, and that's that I'd prefer the option to have help
> display in my terminal (that option might exist and I don't know how to
> turn it on). That would be very convenient for me.

Ah, okay... The reason why this is not that easy is: we ship with HTML
documentation (and skip `man` altogether, also to conserve space in the
already large installer: it is ~30MB, which might seem acceptable to you
until you are stuck in a country where the download is at 30-70 kB/s).

So I am afraid that the only solution in that case would be to install the
Git for Windows SDK (https://git-for-windows.github.io/#download-sdk, as
pointed out by Philip).

Ciao,
Johannes
