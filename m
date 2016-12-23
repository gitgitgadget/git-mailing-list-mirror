Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710241FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 17:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757581AbcLWRFA (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 12:05:00 -0500
Received: from mout.gmx.net ([212.227.17.22]:58286 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753347AbcLWRE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 12:04:59 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Md31i-1c3M7p3hVi-00IF3q; Fri, 23
 Dec 2016 18:04:40 +0100
Date:   Fri, 23 Dec 2016 18:04:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     thomas.attwood@stfc.ac.uk, peff@peff.net, git@vger.kernel.org
Subject: Re: git 2.11.0 error when pushing to remote located on a windows
 share
In-Reply-To: <91983cb6-eed8-987d-bdda-c0fe55a9d139@web.de>
Message-ID: <alpine.DEB.2.20.1612231803530.155951@virtualbox>
References: <AABB04BF1441D24CB4E9FCF46394F17D666F34E1@exchmbx01> <20161202223749.2n7wa37e5w6446uv@sigill.intra.peff.net> <20161204080914.GB2415@tb-raspi> <AABB04BF1441D24CB4E9FCF46394F17D666F3805@exchmbx01> <91983cb6-eed8-987d-bdda-c0fe55a9d139@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1101424664-1482512679=:155951"
X-Provags-ID: V03:K0:Uve3rIitx3YQAVFtDslHNCFqWsKK4uLeVYYxJu0ngqfMrWDWH9O
 aTKaKkhKirtjYYWK9glG5D//MNJXm46PWPB/IuUoqGUW6Hhi6s1g2B4yOP36ZUnAf8LKNPd
 8rEA2O2wprNTnwr5dNIPJr3QbvyEKKVdVW8BIcgwk0T8mRYjCcudq/k/xTxgGnOaEwlPxXE
 n7spmDBmeZpPB7Yuvm2dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bC76e8kd4Wg=:0ny5+5dy8JaGV3UZuB9uaR
 n2JjotSCgQ97YipJ3U7XDSp0F7jziXtk84DZpkR1cbMobyQT9cpSMDcwgfoeVi6rkfyzk8yHO
 iQ6nwG2/ku42Pie+ryHbjCJzahdf9boEILHgYujsQoq/lEZ82BLe/wJ69kkJMrHuhiFkSZlRG
 x54K3o/6aAhNP0BobH2+ELbsQvlKd98ejiESqy0QyMeR7pKDCvOQM9c6IF+ojBG0pwjGNEvVw
 JlzIc5QYezycNTZvPJkw6Ajb9kpTqWipDVNfXLtxensGTmDpNTThT2AKlVSZgB8NhZE6JFdH3
 e35nhhkPpxNhIuL9xf5mnOQgGCDmZfBBJ0AQF8/6vHf4arsWvbJQWMmT6fJSuMJjZr4McBCJP
 ga72hB0aNHWSJfC7q36W9ZSAvPz6ymDBN+y4CXscwco4BFfEKc805KaPFb6gE+ETKGpcpzbBn
 DBcgwtY8EpFA9DF+GfwCd0cgk+K81MnyrpeFils2PkRk/p/sXzSAAC3yODXiwRY5lBhJl6tPi
 0/aNsws5hBcCeL5W/iKACGBEflqCyjauudtyPc/HitEIt8pFLtrJagmGL/cjpZ2PqhLsJlwxo
 Bg7YUxYyfdtsfxTFwLyJhThzNuBGLFJJOQM5kJKYRf2xMElWusmXRnEUpx7b7dYclEB6J99Jr
 K2i7eyhTZP59f3jzdhdwFbH1wTPCZW7Dw1W0PCQCOzYn6/5JTQXQld8I/dke/jvwcRRAoLiX+
 z1Q04lGi8MFiM2WBBgxFbWSqz7NptGp1eBUHNEUYo5aWs65tagUB2RxJYt8fLJQMi7kWZcdWz
 7xtedOi8Rohyvw9RxObI50V5/d7wmTxvYVgrmh005fgEYDFicn/OB94qHk4w17YbikTcBVYib
 TUuNUl3dcWVX9RuraFoteepi8O3jZAqcb9JJFVcZay8tXoUOIgciVziKTpqPy66kSts5qisNX
 +fn0JSI0hi+QFqJfE+lyZyT5Rx+53YQI3bTzDDc3Uv181CdC0IMO7CsE2mgZljEjkNqBuRnpi
 1PWQJkDSUYsRgfbHg0CrkLcuuBfxfUXXkJpcIL00jwzl0saqU/v5N7aDMzLBrHLAcg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1101424664-1482512679=:155951
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 6 Dec 2016, Torsten B=C3=B6gershausen wrote:

> On 2016-12-05 12:05, thomas.attwood@stfc.ac.uk wrote:
> > On Sun, 4 Dec 2016 08:09:14 +0000, Torsten B=C3=83=C2=B6gershausen wrot=
e:
> >> There seems to be another issue, which may or may not being related:
> >> https://github.com/git-for-windows/git/issues/979
> >=20
> > I think this is the same issue. I've posted my trace command output the=
re as
> > It might be more appropriate:
> > https://github.com/git-for-windows/git/issues/979#issuecomment-26481617=
5
> >=20
> Thanks for the trace.
> I think that the problem comes from the "cwd", when a UNC name is used.
>=20
> cd //SERVER/share/somedir
> does not work under Windows, the is no chance to change into that directo=
ry.
> Does anybody know out of his head why and since when we change the direct=
ory
> like this ?
> Or "git bisect" may help.

For the record, Hannes Sixt came up with a patch that fixes #979, and
which already made it into Git for Windows' `master`.

Ciao,
Johannes
--8323329-1101424664-1482512679=:155951--
