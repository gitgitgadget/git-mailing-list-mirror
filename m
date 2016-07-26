Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44756203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 15:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbcGZPfL (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 11:35:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:64791 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbcGZPfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 11:35:09 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MGSDw-1bWWMf00wa-00DK8L; Tue, 26 Jul 2016 17:34:53
 +0200
Date:	Tue, 26 Jul 2016 17:34:39 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
	git@jeffhostetler.com, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v2 7/8] status: update git-status.txt for
 --porcelain=v2
In-Reply-To: <57969607.9080206@gmail.com>
Message-ID: <alpine.DEB.2.20.1607261733500.14111@virtualbox>
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com> <1469474750-49075-8-git-send-email-jeffhost@microsoft.com> <57969607.9080206@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1888738029-1469547282=:14111"
X-Provags-ID: V03:K0:dACdXPo+i8/9GuNbfzxboeXiCBkLsgZwTs87kNPKe4B+MqqMfZa
 Xra6day+cCb1VkAKmA1duTe6rFpnUaNB/h406asl9tO3ustlXX+m3VBpuZa7ahSAsPyKGli
 Mi4M7fMbG3FxKpYxbcd86t1tFDrcG+c0/DMqdcCaBi/6TToibuX3kigEHnbHREPNs0sbkDp
 /Ow6QZeXE9KyoKsnZZm3Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:f3m47D7/t7c=:OatwCBIa+2LeKdcDVlpQ1I
 I3x5HF/6/6i4XU20GeLp1dz4UvJOJSWPpznpoF46Evfl1dCTc2exVwAjGOANOy2F8X6WwDr12
 yWTfif1OPC3C62/26Zr65jWZj+zzpIQdUB5vdKhQEcTxF6nePzXSrMhEXof1jvUoLZWYDqvTr
 ABJbYBH0teEMVP9y05uRHE4Us2BfTeHQxevCP1eJ5++eCFuIQqkskDH1bmyYRSGv95ouhugu5
 CvQMgy0KO/J5ffeJdKBBJuhe+qOm6Dl5gZU9vUtiKQ5h1Mw3F1qxI6Om+0n9FAd6P2TuGspKc
 dAP8BaVth/MFxrxUpUm0tWFIMHe9hwlaa98YrYnV0WiYKm036NWlCNJK6nfKllBzmx0f5dauN
 /40/W90uSqFF9QTXq6GrAgXgqzu2wrXtW9xGB/LMMt2DfjotyfPfcu9HhNUZ1toqvvJDMolRy
 SOoLwIMxrXcrLGJfP5aluyz8xzxF9eKGMV+0RimHkWmvL6tMxhEMylxaYR54oQuXPD7BzD6AS
 +QgQBvCjDQ0gxAYRw2HplMVSutYmW4LkWVq6pQXghZGqo8pCIN2LKXKHIUMbFZLtmNuo525zf
 uFtlw8MRL2K5LOUY0s1LOrI7h9MJyJjxilYAFkz4eJHdDCAlodIeLrjh47eVUyAQrRE681oiT
 Ub7moBTEqi7oK+mKR4gSeJ+aC1VMq5uer6qRjREG4w8uKO4Mp50Q3EYdxz23bg7zvb2sd/8zr
 CZNoYy+XX/QN2723X7TGXDGMMSo+fRcQO4bZCBhGNja1MJQxD4efvYBM1b/ux81zaZ/daaeLW
 EYYprx6
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1888738029-1469547282=:14111
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Tue, 26 Jul 2016, Jakub Nar=C4=99bski wrote:

> W dniu 2016-07-25 o 21:25, Jeff Hostetler pisze:
>=20
> > +    Field       Meaning
> > +    --------------------------------------------------------
> > +    <xy>        A 2 character field describing the conflict type
> > +                as described in the short format.
> > +    <sub>       A 4 character field describing the submodule state
> > +                as described above.
> > +    <m*>        The 6 character octal file modes for the stage 1,
> > +                stage 2, stage 3, and worktree.
>=20
> Errr... the pattern has only _3_ character octal modes, <m1> <m2> <m3>.
> A question: what happens during octopus merge?

From=20git-merge-octopus.sh:

=09# We allow only last one to have a hand-resolvable
=09# conflicts.  Last round failed and we still had
=09# a head to merge.

In other words, octopus merges do not use higher stages than 3.

Ciao,
Dscho
--8323329-1888738029-1469547282=:14111--
