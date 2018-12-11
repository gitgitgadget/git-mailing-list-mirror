Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF9F20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 13:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeLKNjM (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 08:39:12 -0500
Received: from mout.gmx.net ([212.227.17.22]:51713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeLKNjM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 08:39:12 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mc9U3-1gmS5J1XWB-00JZUS; Tue, 11
 Dec 2018 14:39:10 +0100
Date:   Tue, 11 Dec 2018 14:39:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Steven Penny <svnpenn@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
In-Reply-To: <CAAXzdLUKhCfvqdvsPryeMGJ2ttJxof4sUcyTx-xd5p2BaoryiQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812111429320.43@tvgsbejvaqbjf.bet>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181207170456.8994-1-tboegi@web.de> <CAAXzdLVTjCVDmBik-j9B_Z_2wgSj=_6baqmjmGEGBFOsjkyOsw@mail.gmail.com> <nycvar.QRO.7.76.6.1812100938140.43@tvgsbejvaqbjf.bet>
 <CAAXzdLUKhCfvqdvsPryeMGJ2ttJxof4sUcyTx-xd5p2BaoryiQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mfrzhpYiLgZyue1Xhei6kDy2SM+ZPaDFern+Qbx3qplibgO9K8T
 z1MsjUyZX6nsfmw3x0lsvovRC3zOG81nYVWHuPWXAcUKYY7sqQAc07Q5UEg+2jvPjqK7x+I
 VfFeewvsoT2xukuauwsCQPYSmDsDOAznZwal+PX7tRCc9BAyOKYdUR7mlMqJZBkOiykRCTP
 9mgxxtViVtE0ot0582ExA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ff6nI3wiEwY=:fzZiWGNDGKCdHyOQ6e4ZVv
 KH0xljROO7gbivK3YMR8vJWjQZcoIp/JFzDquNzxajNjuQUPi9gQ7NFsFTwfUk58U8liwNups
 OVg4xoD5RQe7eWGxUZHgpIiMYp/WUDYYePBJBeV+Px4Tmjv+ATD61Uq2QS6VDXNKiumjqHAmN
 YbLylMzEajVj6e1lS4TaQDU6FqkO1eVfXct0CciwPkCtziQZEm5I/g+/CnrBt8Q3Okl5buY0v
 uD9SZPut2N+tgiRcSTXMMRx+X3Manlz/XuDHg60yiJ2uqksJ/PdYLFfwnnQ8r3f9xCZEHniXF
 XxNv3XXV4sXG2uoq7tZ8YR9yfuwVpe94m+PAPhvzh0RNQ6cmGkythCEAo/vAFMmYvbvfbRLwl
 qC6nkED87WdUpCnFWYI+PeorzkMyKeE5g+EEGeJXHhyVQBS22mzYpQMhPDp+s1tMdALzXznzF
 FZ6mAE61o61kxSSmr7JZf3UwjYEj3yH6KrmqIFqPV3J91rd1Z2z2eBeMvwThmS3cWITkSX4Vj
 oCz+GdvWotPQ2/zNcSAzcWCQhhZvmfOugD0J+Pria/YyMCryWuZMJxAuiTQFpZky3JTEtOITr
 wdfQxd1HU9+8sacnZgAlg61efhjYyGwGPx7uq2xhA6i1nyh2np/lJRE7aJlBLUC+7TjV/qXrG
 Km/tAjqbWaM5s4WdscYGXlZ1LXXdkxMFCnck7M53UzpXE/itXnpSuOtU0Mxvakis1bQgIOUGU
 9zv1XQP1PxJrybDw5yHKLFT9Qey/zGxRf/vxtE53x2nHYaCyL7lPhuIECjnI9cEwxSFItKUKS
 cq5H5O/LHqteJYQsaQTA8UHnUM9J6ei7ET/qR8REAAsji+iIeObfn/fddGG5XDzCO98/uBrqG
 ug4hxcxELYOb9enxMBwplNaOThrYNxOTDzAny7dJJCdjKC4fA9SZShOydypM7hYsbeTyvxcoM
 cAa97B3X8kA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Steven,

On Mon, 10 Dec 2018, Steven Penny wrote:

> On Mon, Dec 10, 2018 at 2:46 AM Johannes Schindelin wrote:
> > please stop dropping me from the Cc: list. Thanks.
> 
> i dropped you specifically because i knew you were going to flame like
> you just did below. oh well, i guess you cant avoid the inevitable.

I have no intention of flaming anybody. That is simply a
misrepresentation.

> > > - pc-windows
> > > - pc-win
> > > - win
> >
> > I find all of those horrible.
> 
> they arent great, but "win32" simply isnt valid.

It is a long established convention to talk about the Win32 API as the set
of functions developed for Windows NT and backported to Windows 95.

There is no benefit in abandoning that convention just to please you.

> > ... except if you take into account that this has been our convention
> > for, what, almost 9 years (since 44626dc7d5 (MSVC: Windows-native
> > implementation for subset of Pthreads API, 2010-01-15), to be
> > precise)? In that case, it makes a ton of sense, and one might be
> > tempted to ask who the person wanting to change that thinks they
> > are...
> 
> "That's the way it's always been done" is not a good reason to keep
> doing something. I would say the justification goes the other way, as to
> why we should keep using an old moniker when its past making sense.

If you want to change something that has been in use for a long time, you
have to have good reasons. None of your arguments convinces me so far that
you have any good reason to change these.

Let's hear some good argument in a well-prepared patch, or alternatively
let's just not discuss these hypotheticals anymore.

> > You may disagree all you want, but given that Torsten has been a lot
> > more active on this code than you have been so far, I'll go with
> > Torsten's taste. Which incidentally happens to match my tastes, so
> > that's an added bonus.
> 
> in the end i dont really care what your taste is, or Torsten for that
> matter. I care that the issue be fixed.

If anyone truly cares about an issue to be fixed, I would expect more
assisting, and less distracting, to do wonders.

Ciao,
Johannes
