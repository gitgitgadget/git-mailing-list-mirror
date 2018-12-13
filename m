Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0783C20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 13:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbeLMNol (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 08:44:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:38605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbeLMNok (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 08:44:40 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpPg1-1h3lyP3ew1-00fDut; Thu, 13
 Dec 2018 14:44:32 +0100
Date:   Thu, 13 Dec 2018 14:44:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] .gitattributes: ensure t/oid-info/* has eol=lf
In-Reply-To: <20181213132254.GW30222@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1812131443500.43@tvgsbejvaqbjf.bet>
References: <pull.98.git.gitgitgadget@gmail.com> <4a22502a318a65f144b3b6542cc5e711a1811c78.1544560544.git.gitgitgadget@gmail.com> <20181212133945.GV30222@szeder.dev> <nycvar.QRO.7.76.6.1812131358530.43@tvgsbejvaqbjf.bet> <20181213132254.GW30222@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-753620658-1544708672=:43"
X-Provags-ID: V03:K1:N1WIMv7eDNzGUZOFa+eHnQQHD4RPAOe+HGa6r1AWxN5ASfzHjjz
 GvbEkdrak9VTdpmZoTZIXetVoeaTcO7eZSVuH1i2ry1NO/73h4ohgZEOz70KrrmzePPnMTB
 YdvwhxwJXGhQW72jb1IEvcu3KB0UaWyUps7kwFNaCPRTVS9I0oRdxdlRIWOulVM/efeweLw
 4rt3IaU5fLioxCu+gErgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HgawqdQPYws=:b4BPs1JoXo2bKMb1rNhTMj
 RS5mgdGA3wknya9xVsBZblw3jLV8LSaeWyQKo4gd2vgEUC+JMiLij0+C1rULwkkIgN/FtzrvD
 4eZ3HnqNp910JRnyGgOHD1QGQO3GBPNzuiLoPXtlH+dP9OcGJ3fHh1QPAED4Y7mDU4VaZvDjZ
 7J+Z9ixZ3LilvfiY3Ha6ix0HmQFlFrLQAiz6Op7JBtOPyrwazhXyeeehaySUfLF5rRHP/wAd4
 3v7EJv7pzqyH+KmT4t8VYCLfxOw1zERYv0ONIvH6uT4hZjaViz+JUPpC5euB3qI7RYSb+n5dj
 dhGnbjN+wqyYiryap+jg51p6W0l5Xjvu9LF3AKLezfRmizqgZ7QVy1CYPT3hTv3Qxp1XoA9po
 x2RnlcZm9iF9KajyldJTCJi6Mln0qfk00UEioLgUv1OhWZPZSU88JXSVG2f4LriIpjQRuDTqM
 8PpqCoIdWENLLcNQGLSqKOW86KD8aSz3mAZv7OBru7rGGaH5n3iWAZ3XcR67G7vk8WNq6NKhL
 m8ys9vGQg9rCE8/aHtHOuuT5RimYMdDpuERiXMvpyg/eIBun9Xw8xsGMfMChJPYF4DHU2C17W
 UZfOp9US/2wFqHLZCeJIqZ0WJFnOQy6C41L2xGL1vr29S2+j1ahhmIK2Bni+ZJ51pt8SGJ8Xv
 ahLRwRHqDI9pTyMB83CKelHJ7xRmX3eDMwDq0c5AKMlGedcddOdYRuPG81PNwgh2XxwiryLGz
 aeM0n/uH+YuH7VyPDyccJMQHWnFG3owO8ROXFeri1P3I9Np/2ooPCkr99ZbOdBcPxphrNSaEC
 zwDhg7mLHxVmop9jPwQ6oslFZ7o3s5dE1d5ae0ing169omVOh3RL39IH+ttN+prJR4PEYp5+/
 z42Fsjm2GK835fQSMT/DSVt9MIdft2Th9GO1DWXAkkQPskFRSAJLNufPflPvMqwmKM2ez12ZH
 aL5UYYvXd1Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-753620658-1544708672=:43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Thu, 13 Dec 2018, SZEDER Gábor wrote:

> On Thu, Dec 13, 2018 at 02:01:15PM +0100, Johannes Schindelin wrote:
> > 
> > On Wed, 12 Dec 2018, SZEDER Gábor wrote:
> > 
> > > On Tue, Dec 11, 2018 at 12:35:46PM -0800, Derrick Stolee via GitGitGadget wrote:
> > > > From: Derrick Stolee <dstolee@microsoft.com>
> > > > 
> > > > The new test_oid machinery in the test library requires reading
> > > > some information from t/oid-info/hash-info and t/oid-info/oid.
> > > > The shell logic that reads from these files is sensitive to CRLF
> > > > line endings, causing a problem when the test suite is run on a
> > > > Windows machine that converts LF to CRLF.
> > > 
> > > "What problem?" is what people will ask when they read this commit
> > > message in the future.
> > 
> > The test script (not test case) fails with the rather terrifying message
> > 
> > 	error: bug in the test script: bad hash algorithm
> > 
> > See e.g. line 958 of the Build & Test log in the Windows phase of
> > https://dev.azure.com/git-for-windows/git/_build/results?buildId=26757
> 
> Yeah, I saw that in the cover letter.  And that was my point, that I
> saw this there, not in the proposed commit log message:
> 
> > > Please include the relevant details in the commit message instead of
> > > the cover letter.

Oy, oy, oy. I missed that. Where is the coffee.

Ciao,
Dscho
--8323328-753620658-1544708672=:43--
