Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406941FD99
	for <e@80x24.org>; Sun, 28 Aug 2016 08:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755243AbcH1Igu (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 04:36:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:50297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755220AbcH1Igr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 04:36:47 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MXIGf-1baxav0N0P-00WFUO; Sun, 28 Aug 2016 10:36:40
 +0200
Date:   Sun, 28 Aug 2016 10:36:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     Eric Wong <e@80x24.org>, Stefan Beller <sbeller@google.com>,
        meta@public-inbox.org, git@vger.kernel.org
Subject: Re: Working with public-inbox.org
In-Reply-To: <d2c4d54f-e3be-8e17-860c-d9b8bacf68e0@gmail.com>
Message-ID: <alpine.DEB.2.20.1608281033340.129229@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160818204902.GA1670@starla> <alpine.DEB.2.20.1608191720040.4924@virtualbox> <20160819223547.GB16646@dcvr>
 <alpine.DEB.2.20.1608221509010.4924@virtualbox> <20160822225549.GA25383@starla> <alpine.DEB.2.20.1608251457310.4924@virtualbox> <d2c4d54f-e3be-8e17-860c-d9b8bacf68e0@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1261616707-1472373400=:129229"
X-Provags-ID: V03:K0:7erH4fAA6fAOIGf1d0cmhrFrJ4AwVbnAM77DzvtcrrF2n3S6xnG
 Pd8wcdipaOUJwSCWsv0B0pWx1x+gud2ZL+cDy7i1zFWSDlkmzaURDbSOp+q+Ab7qgt7ZB+K
 qbI/0S5jY4nlh1ypZHaHsovPatQwQ4G7YLX9XtH1hRF57mVdlFfqp+QyG8LI/NI/YPb5CL/
 qUzdzMRullCctZUINSNjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dDzmxv5towo=:HTr1JFiFFeOJLu8RqiCdy2
 QbT/JKKyn5TIpwzt4eFaB1Rk3dVn6tcEC/z7022G66szWhTVT8PaYN0Pigo64vp9Nsn3JqlhV
 tmTMGU+UWqUL/4Doso01SzCBe3WghtODgMdZzIyxvjPjvIP3SZGoZoWflIMzj6yVBnkgdAnwh
 7d8bN6iCrRla7mzLCJ1HHde+WyfwtrWC3Lqx1vsqMiM36JzYOMK/LKOBXV+fHn4R+KWXaKTP1
 +hnfVTyYfZShNRAxdN5Z3FYj5IGCsPSuGvCpjWbK5i2LAe1nLQ5AmyII5eEyToxjduyM8r/6M
 w3iaSp7PhLTsf2Rqh9I9DEckYoVyLsn0qhW7XiAKyQ3V7C0emofRLmFfJz/wC41b52mBLQ9ys
 Or0ywTfjDxpP9Q2CvAO5M07WPBAvnCtcrRx75JKL5XHfRGfOOFD2pp5Fk2VU9teNNM+/a2eNX
 rLh8fHuLr/Mdd1Xu4O5qOkmwfosYYrxRFtk3s1LTy+Xploo7OhhXcSte0BJK8EGmXRsyCTOSO
 fhAoeoHUWSBQJWWPdg9cL6Wb3+ZLu/2up90/CVtLwxomRcjMOn/m9FMNZh+Ec8AClhmnHHznB
 MSqhodaMtOn7M+lH/LwhX7kpzfBRJXETWnkLPyl43lWunwcB0x328Td5VZsgiFHOST653d8sL
 7tyGEOrFSyZb+8hS+HkuGkfid21GcG+t2O4QEre43kCWYnzeS4LRRJaRqAuNPxuwYWEbhwxYV
 R015GJhaN7JTknho+fPb7jNwozSR78MXrJ1cDQunvUx6j7X0NFNsWugMwxoVSCXanPxuFc/Tt
 ezpyC1X
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1261616707-1472373400=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Sun, 28 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 25.08.2016 o 14:58, Johannes Schindelin pisze:
> > On Mon, 22 Aug 2016, Eric Wong wrote:
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >>
> >>> I just want developers who are already familiar with Git, and come up=
 with
> >>> an improvement to Git itself, to be able to contribute it without hav=
ing
> >>> to pull out their hair in despair.
> >>
> >> We want the same thing.  I just want to go farther and get
> >> people familiar with (federated|decentralized) tools instead of
> >> proprietary and centralized ones.
> >=20
> > Why require users to get familiar with (federated|decentralized) tools
> > *unless* they make things provably more convenient? So far, I only see
> > that this would add to the hurdle, not improve things.
>=20
> Arguably for some federated/decentralized tools are preferred
> (for philosophical reasons), even if they do not achieve even feature
> parity with centralized tools (c.f. FSF).

This statement is false. If you had talked about *your* preference, it
would be true. But to state that federated/decentralized tools are
universally preferred is nonsense.

You know as well as I do that most users/contributors go for convenience.

And if you require an inconvenient step (e.g. subscribing to a
federated/decentralized philosophy), most potential contributors simply
stop being potential contributors. End of story.

Ciao,
Johannes
--8323329-1261616707-1472373400=:129229--
