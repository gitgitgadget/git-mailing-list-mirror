Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2CBA1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 13:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934270AbcHYN56 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 09:57:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:60383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934212AbcHYN55 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 09:57:57 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MM0bQ-1bVCtN0WJ2-007i7f; Thu, 25 Aug 2016 15:51:09
 +0200
Date:   Thu, 25 Aug 2016 15:50:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Duy Nguyen <pclouds@gmail.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: core.autocrlf, was Re: [git-for-windows] Re: [ANNOUNCE] Git for
 Windows 2.9.3
In-Reply-To: <8b3f92e5-0cac-ebb1-0f03-460ba3ad4d32@web.de>
Message-ID: <alpine.DEB.2.20.1608251547510.4924@virtualbox>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox> <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox> <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608181022250.4924@virtualbox>
 <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com> <alpine.DEB.2.20.1608231553030.4924@virtualbox> <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net> <alpine.DEB.2.20.1608231736180.4924@virtualbox> <alpine.DEB.2.20.1608231758260.4924@virtualbox>
 <xmqqbn0iu50a.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608241743460.4924@virtualbox> <xmqq37luru7z.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608251343300.4924@virtualbox> <8b3f92e5-0cac-ebb1-0f03-460ba3ad4d32@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-237641899-1472133069=:4924"
X-Provags-ID: V03:K0:Vo79MxE9EMH740bZRr5AIcaPfjKFhhOXqcpTO5V+xtnD5w0mt/g
 +pCiMmBJqMswTDA7zU8bHOrTkhmz+TX4a0IG2L6I9uPv7YNH31HMdTWMMWYCO0bmi0v0MKn
 d6UEcKL2bODJVWRJkBT6JKh/qEpXZpDHE07JSHCRbvN8j0RccBEpPAVSnf9R/+Ins7Wb/G2
 dF7k8DlKByOo62gtZJ7fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LY8d09E3xo0=:2fRvQKjIwXxsp0T3gnU78H
 TYDE/NHqs7OFDYf7PuHkqv7rWUhkK+bZRsMf/kZVQYgJPoUVIu2DS4j2AzV4EMLEjiwvak8Us
 gOSe51hMTk/xfsxlB4+/67HoCHlerJdS3FUV2NfmaiYQv/jZmKNxFE+tuewrjmoAjeemZJHlq
 blXTcOfVsSV0j2rRsLc+nF3/jOBNueDLAUZXq8pBFcPYwMmql3mMfZCmPsYUMqoZCM14Sjnrm
 sjDbF7yn3eEU1djs4e3/6rO1GLk0XXk/vTm8aNCR3gsBAulNoa1wPyDc8oVw2onEe7k4nxJpb
 cI2NBidn0hFTUKMajjrOBhYjv2Ik5QRv5Ciq1zTiSvUI7TlWWQaiLKbPIr7+9PywB6DMHkjDC
 iZx4yESvylXmdqNXERfvrETSHCfOfg/vFS9lHhkAMuSn0nVpZXoQwKjTVH/lOpdzIVVDVHTQV
 XJOvKjjLhz6gVTSk0x2TFnkA+iD1wshvksI3hRho4xME+9g120NxVxD+R8qEz7RJ+HmUaIiXt
 g665BM0+S7a/ngFYQWvgw9qm9Mqve/u0Pe0m6Ek3vem0J9oq5hS9M4EahKQEfTGKgM4G9TW1y
 ItKmNDjFM5nWKDfNQVoc0kudEvHXgZ2otJFO+vb/eG06o5axkBewJPqwwVhvKqO0yKKNtdMG8
 NNxuE5xu5VSicMhaED6Q1eiamt1DwCTqu8HUtEs1/NUcg6qu8dMmWL50iZKIaHpsHOZ6YlrN/
 qaJUq4W/KrJPIrto8EQmOJlzN4yChaaE1mUUmlbaYjjpc2B7yalIanmA6bMJoUJMp3dqAuoEa
 ZFDUuyM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-237641899-1472133069=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Thu, 25 Aug 2016, Torsten B=C3=B6gershausen wrote:

> > I was not talking about the cost of correcting mistakes. Running --filt=
ers
> > is potentially very costly. Just so you understand what I am talking
> > about: I have a report that says that checking out a sizeable worktree
> > with core.autocrlf=3Dtrue is 58% slower than with core.autocrlf=3Dfalse=
=2E That
> > is horrible. []
>=20
> Is this a public repo ?

No.

> Or is there a benchmark repo somewhere ?

Unfortunately not. The only information I have is that it contains
gazillions of files and that most of that time was spent in figuring out
whether the files contain CR/LF, LF, or both.

I hope to get back to some performance benchmarking soon. I have some
experimental code to generate Git repositories of a specific size, and I
hope to be able to replicate the issues with that infrastructure.

Should be fun.

Ciao,
Dscho
--8323329-237641899-1472133069=:4924--
