Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33EAF203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 13:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756425AbcGZNn5 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 09:43:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:57929 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756143AbcGZNn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 09:43:56 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MLNpK-1bRUgV0Ia2-000dDG; Tue, 26 Jul 2016 15:43:53
 +0200
Date:	Tue, 26 Jul 2016 15:43:43 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Orgad Shaneh <orgads@gmail.com>
cc:	git <git@vger.kernel.org>
Subject: Re: [PATCH] commit: Fix description of no-verify
In-Reply-To: <CAGHpTB+5ePbGyBMjozmwC=0ksqQShUt8Pa=QzPg4R0tf5467Xw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607261541170.14111@virtualbox>
References: <1469519305-11361-1-git-send-email-orgad.shaneh@audiocodes.com> <alpine.DEB.2.20.1607261452281.14111@virtualbox> <CAGHpTB+5ePbGyBMjozmwC=0ksqQShUt8Pa=QzPg4R0tf5467Xw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5LBTuoykJTLt2qFTXNgADnQiwxWwD1n3If6wQteM/fB4rfEn56t
 lV4J8EoAcle9ySatJjR0MEv3ez84oJoKeh6SKpBUo82vxPBZmq7celSJoTvfuBbIcKn6uMA
 dU5wu6uaXi1SlMOAdyIo0X0lvRKD94nGdq0MR8r1Qr0EqpbGHnlpB70Mdd5erutljloH2yF
 yZHpO2e/ca4dy1Tb2J1kw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:vDaXcJLJIQg=:wbX8R1lhd2YBJFyYsXT2CZ
 ZjTjF3uqyCpOpmSp6jxPN2A41IASos1fQPaWnFPDnABWZ/cyqUy81AgvwQ/1Estwa8QE9BGWe
 Ur6wwGq0uNCh5C3ttd7b7YgRuQjobCOmyS2Cej3l8kVdoeKO+FoTCXn0rJWqoUHjbaYeejIHp
 P5j1T6pRR7da8YIRRG7lXufENGmtQA6s9+Ts+y3PhkclKyIalO7CPGaQb2+fGnXVkJm9XSpnC
 eOMww+pJIwbfWUfu0VYt2kENY1+tdet6j2Q6yohn9XY4dKRnX2KW9Z04ZN8FZ/ESUFjcaFY5w
 ri8AIldZBzy1Wf2brraY6YtwhYXTN4/6FkImy0gweFLFhyk2VaU1lOwO96hY+Mxi/H5p0Wwwa
 9ZvicVL/NE/WrFte1f/mtf7LJ8NQjYmHBLTRoT8UCmF/UtKQdygf2bWVvtes9ZmBZvpHN8BU4
 w8CgT5oAktZIyj0k0IA0MXX4zMv42hbSvC6fduFxR8PUbCE3uwCtpO+WYClztUGFfNn/PZAQw
 NQQnESQEMSoiYAxAdOp+46cZCrKJBD4aY1oGhN1i31bnD17YfNfri2BK8OozMvWoJcJG4GlIn
 rY9BnYUwRMd9vtjBmVhbRUjo3vaKftDyeoLyNRc6nmU/14PixOwdfGu1cp21V0Dp3cIUQljxN
 rcBY7W7mth+pIz2ZxnyyYV+6C/LfxUD4LcTzqWQqDNhXhEYDUgouhdxRELJALJJ00qBMxUXuA
 hIrvZ3s01boI3m6RvnZHb6i3fH2ZVD9QENJQKmzI9XmRkOzXgSLTgDvf8M1lLddMKOM3b8HEV
 JVJcLFB
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Orgad,

On Tue, 26 Jul 2016, Orgad Shaneh wrote:

> On Tue, Jul 26, 2016 at 3:55 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 26 Jul 2016, Orgad Shaneh wrote:
> >
> >> include also commit-msg hook.
> >
> > This comment was a bit cryptic, until I read the patch. Now I find that
> > comment redundant with the patch.
> 
> This brings the short help in line with the documentation. I should
> have stated that in the commit message.

That would be good.

> I don't have much experience with submitting patches to Git. How do I
> edit the commit message? Submit it as a new patch?

You edit it locally via `git commit --amend` (or using rebase -i's
`reword` if you need to adjust a commit message in the middle of a patch
series, not at the end).

Then you send it as a reply to the first submission (--in-reply-to, if you
use format-patch), with the `[PATCH v2]` prefix (--subject-prefix='[PATCH
v2]' if you use format-patch).

Ciao,
Dscho
