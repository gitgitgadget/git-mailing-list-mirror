Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF85E20195
	for <e@80x24.org>; Thu, 14 Jul 2016 10:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbcGNK7Q (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 06:59:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:56641 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbcGNK7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 06:59:14 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LzHZ7-1bIzfM3A3d-014WAw; Thu, 14 Jul 2016 12:58:49
 +0200
Date:	Thu, 14 Jul 2016 12:58:47 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Mike Hommey <mh@glandium.org>
cc:	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: 32-bit Travis, was Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <20160714091240.GB26046@glandium.org>
Message-ID: <alpine.DEB.2.20.1607141256100.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <xmqqmvllz2t7.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607140952160.6426@virtualbox>
 <20160714091240.GB26046@glandium.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XFUsDGO8SMvY29xKYdnFuF7j8lPN2YqZSgm6OYa0LIbxKqIAiZJ
 sa3EuCK4MhJ1H/vI7sYjGu2JhVQ0m+UTEhi9MVBhv/mmwtOjz5T5CdtTv5G2V00aTOZqM8M
 WvszwNY7dHj6QbYDkPFtDOSIxI/kvo62dYLVn0o/eBiuOUKs4H7+DF+xyHj6P/non5d6cIa
 HBI2RDhQG+ELwCHRt7Y6A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:OJ2CDuGtnmM=:Mm7Xf/ZjXybBCQanzS7oia
 CIXVO2nAEgk+OgYVo7UgSLy3fZeLu7RgYXZ1TWKXh5tMC7YxOFjULbClg3HW1gTcNiN16Ep+N
 bq5fZwrs4uZ4Uk9GUyoWs37QEAY1dj33D9EUAix4nf4YSsnV3MDxSzf6ucfyhZG7CMMS4orBW
 84kzshc/1xwzag+tydcQ/l8eo29XRqLWEabdwX4oz0BQsmZfL1fxQBUiztSjrbotlgSJW8l1n
 sbTtym21xVUFmIl2stb2stLQ6Ddi1YaJpz6vR1QrYGqW22tvpk8VbVWoaG3OQkzbx29hmU0XX
 xBfj76QeE8tT0r8mIBeT6nbe0/Ucqh6Kv2sUnXZ4vMGtcE906mCjn7s0l6Z2JuVjljdQhwZUh
 KZTb4JF8Wc/orANY2aEq9FCcsVUCqiSkaB9dFQvziDEWcqP6zd+xY7uEWDpf1HSym2vjbb0us
 1SiQ7Dtg6YSrmOQ1S/oQI6WkMNmlODaG00Fh11VUB84XSQNDJARmwFDHC0n/qAYLpgZEK+5BS
 JCgZEiT6H3Dx1mfgNdP6b7zr7mrjIkshRN84UDpd1eipx006FuqJzScOBgOM4hu7l+rWHZ4ti
 alDRZi5hqphFjr7ZhaRYyLeNSmt4a884UULKoufYa9SSAOlcCd9eIYiD3Wo1NlBqtMl+0kENG
 VsYYRh2SMuwx6QIWLXyew2k29kujOsZLSkobtaM2Win9rLwMJCw1wimQlVYcCSfFuSGJvg48U
 E17k2tl3smizjiHn8M5oQLrCuoyu2vf1OyRuCx1mCPAlGfCO45yFHxOj+kdq1nPg0/QKns8H2
 yC92c5l
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Mike,

On Thu, 14 Jul 2016, Mike Hommey wrote:

> On Thu, Jul 14, 2016 at 09:58:45AM +0200, Johannes Schindelin wrote:
> > Hi Junio,
> > 
> > On Wed, 13 Jul 2016, Junio C Hamano wrote:
> > 
> > > Does Travis CI testing have an option to run our tests on some
> > > 32-bit platforms?
> > 
> > AFAIR Docker does not support 32-bit, and IIRC that's what Travis uses.
> > 
> > However, it is possible to install a 32-bit toolchain and use that to
> > compile Git.
> 
> You just need to install gcc-multilib on travis, and you can use -m32. I
> did that for jemalloc recently.
> See https://github.com/jemalloc/jemalloc/blob/dev/.travis.yml

Would we not also need

	apt:
		packages:
			lib32z1

(or ia32libs in case of an older Ubuntu)?

Ciao,
Dscho
