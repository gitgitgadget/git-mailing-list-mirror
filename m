Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 047A41F404
	for <e@80x24.org>; Wed, 29 Aug 2018 14:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeH2Snu (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 14:43:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:54861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbeH2Snu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 14:43:50 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lr46Z-1fPnev3uNv-00eg5x; Wed, 29
 Aug 2018 16:46:31 +0200
Date:   Wed, 29 Aug 2018 16:46:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: Contributor Summit planning
In-Reply-To: <20180829045548.GB15274@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1808291644430.71@tvgsbejvaqbjf.bet>
References: <20180813163108.GA6731@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1808271523180.73@tvgsbejvaqbjf.bet> <20180829045548.GB15274@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2nvWNc+advorylRyfaWpEYR4dvh8pLhHZCEqMKbJOUuI3Waahap
 LRJC8tLG2ciBHRFycLwuRoFH3zk+kTrHeFwYcYMcqJ8SOrhlezGkWV6J3+v525TRngiHLz+
 8I1zx13hq53pOtxK432OSRvwql01AASJbtDZ0gFbdQhLcj9n3/eUYVQuKpHuqtHHrLJtvZ7
 A9ygWLOGmJFpY2V/ozRww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gw6+EycY4wE=:Wlk2wg14FmjK6D8wjwcnPe
 qGxoDIOqUI3dLQqUrwHqP9fcizgT+/t8pUn3ngATDS92WAQRPG0VYGlh5TUKPbCNA6ixWkp1/
 FRAT1NgWx/c03v9WrzHJg/bCRAyH91LU0xkz7zePCnEKrnfZMJiZZJ261MUADCNrmUTI96tCi
 YweuoN6IdOuh3SEtMbg3yXivCRGOhHcMibGal/Jx+kw/Y9rTaQxk8w8IL7yVovh9FLkND8EEd
 gks5HP9h0OUF+ZVK17bd2p2TBS4dCw+d/9yuLbo61bBA30e9Je5Z53AnHjGOZNi/T2lpvSr2m
 Y7uLsvKnR1k5a1rsjxWi0aC3VhcPZ2ZDOFj+LKE8VTxgY0yyJ2VIcIxx2h+m6BeoPa5NV+AoF
 8wBRDAK70n0P4EMElNsh0epgEZD30XVMZkyMDGKcpsXsdhwIB005jqQiiHBXLi6ki6PkjIMe6
 eE6ge8zd+OqLrw16MwYd7fz0xA0lH/HvvHkCGQfPPJ4sdEBYt1fA81iwLLPUzxxlHvjHTvDPp
 S7LDCBbPXHjdaOdIMClrdi8/AjHikzXRnIdTJMwBQGkuMhO+vrgX8nrIT8yzI6YUQCmez2vEG
 zkgqHNaut/d858xRFqld08gnlJTAH+wtFn+0JM78xEjj/ImWXJGzhw5rUoZps6w/MYUC3If8M
 SJ5ybBIUUd7FlJvbAgYWER86Zn/u+9ucERx0zzHS71KmlQFz07XpT179jRMk4PDX7zT6uIjPa
 keGEXZ61KhzBGbDxVwy7ATekCj4wl+9mjx8Yj2NqYPNZicI6wshbH8kkAHn6TI0HEJFWmpfE/
 d6Fmqcf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 29 Aug 2018, Jeff King wrote:

> On Mon, Aug 27, 2018 at 03:34:16PM +0200, Johannes Schindelin wrote:
> 
> > Rather than have a "hack day", I would actually prefer to work with
> > other contributors in a way that we have not done before, but which I
> > had the pleasure of "test ballooning" with Pratik: using Visual Studio
> > Code Live Share. This allows multiple users to work on the same code
> > base, in the same worktree, seeing what each other is doing. It
> > requires a separate communication channel to talk; Pratik & I used
> > IRC, but I think Google Hangout (or Skype or WhatsApp or
> > <insert-your-favorite-chat-here>) would have worked a bit better. It's
> > kind of pair programming, but with some of the limitations removed.
> 
> OK, I said in my earlier email that I would give any scheme a try, but I
> really don't like pair programming. ;)

Tastes do differ, and that's okay.

I found it pretty invaluable a tool for intense 1:1 mentoring. It
definitely helps a lot with getting over the initial hurdles.

Ciao,
Dscho
