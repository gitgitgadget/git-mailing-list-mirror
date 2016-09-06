Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3611F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 16:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936148AbcIFQeV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 12:34:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:64420 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935027AbcIFQeU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 12:34:20 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M8leW-1bmmyj3f6i-00C9rw; Tue, 06 Sep 2016 18:34:18
 +0200
Date:   Tue, 6 Sep 2016 18:34:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jaakko_P=C3=A4=C3=A4kk=C3=B6nen?= 
        <jaakko.t.paakkonen@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Windows Git will not start external diff at all
In-Reply-To: <CADr93XDA3CdgGBqBJTdmCHg_ZzGhsBf5hwwORJaCNB-V7o+APg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1609061832380.129229@virtualbox>
References: <CADr93XDA3CdgGBqBJTdmCHg_ZzGhsBf5hwwORJaCNB-V7o+APg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-73213576-1473179657=:129229"
X-Provags-ID: V03:K0:Nkb80wDmVpfKx2RuPOxaXTu+02ltoBkuG8MmE4rybbtazlZV/We
 IxExJkr4eQIL8hmfUn4KxxZ8I9eNUIIhK9/L/d1x523DUU8DyTufiCGNoEQiOKrKjf4PTVJ
 v6OwmsZrmfZI4JlU7LlERy2sKvqvzG2Smax361lOOSEAiG2OeipdAuE0GazyzkkFEQVtEHP
 LHIgp9guAJB/20qvbthFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gGFTv0Sq1/0=:vi00PvwzokQDYI2LKUHqrX
 dH1z4269rrsHbTR9jEzfQ5q9KviUIiTR/L/J6EfUYoeimcZ2ExB5qCWrbzNQ0tOUpafiM2y18
 tCXag2AXkUUOJRL4dKkQ38L4m24opDwFJx297MT+3GOXgCt9pTUAnMR+yBgD9gCJy0rHqM1i+
 tH+SNQDDzSIGVX2iG0OM+Y2ZnUJWgb1joD0Xe+hWLrsIF1oVUw+iLb/JuDD27z/Z3Ls0T8A/V
 EmciT4l6LehJNoCj8L2PklfywNoeA0X94T+hRz/0bHrPVaGSMKpaBhxTmHpWd8JKdpZqYHZ9N
 7wDSNKgkgPRaanTaekIIX2zpfhtPXD+JlqJnO6Z8hpaOnXYoANbzGsr8Swu46aM8IfjW7gMfI
 E4hr4zSAhupVyDgtnDUYn0Bv2VYoH1nHpwmFjwMvXLNDXVM9Ki0y7RletmpLGcDdfeK1NvYlc
 xiZZC2J2w4wU8CoY0rO8UsmtEeBec7hl0Y9ABwO1/AHY/ivKYoQtvagqbofVLidMP14dc84Ps
 uHzOJcHJ7dKOOtvSXgCWfQUPlnihz91AoqH4d4nlDoBeXdIeUqjLcmhpKLhIR7DRhBKumIC33
 Y73qPRXyVdPn3qGjNhIW1KS3I5jqOfBHwqxra0aQp7rzPmGpO9MZVh6iz+Xb3okw2jJhMC+7S
 usD7aGBcPqDbINNASjeZMCmvixZ65XfxDriLxZzVLijw7A8CloJgME3w0+p6jaBWuW9jNtGqp
 iNpTlBW7loTxFmpTYPz5lo0CGsLBG+Q/AOO+DfqgxUm9Gwiol+TwQ9EtwUFqqcesFKuN2GH1w
 QURymV6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-73213576-1473179657=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Jaakko,

On Tue, 6 Sep 2016, Jaakko P=C3=A4=C3=A4kk=C3=B6nen wrote:

> I am using beyond compare, but it does not really matter which one
> because even I create a dummy script as a external diff program, it
> will not get called ever. Only internal diff is started.

Any chance you can come up with an MCVE [*1*] using a dummy script?

>=20
> Re-installing git will not remove the problem. I am using the latest git
>=20
> Any hints how I can debug git difftool?

Sure. First hint: set GIT_TRACE=3D1. Next hint: difftool is a shell script,
so you can modify it, say, by inserting a `set -x` which will trace the
commands that are called.

Ciao,
Johannes

Footnote *1*: http://stackoverflow.com/help/mcve
--8323329-73213576-1473179657=:129229--
