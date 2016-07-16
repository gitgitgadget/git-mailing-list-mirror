Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C4202018F
	for <e@80x24.org>; Sat, 16 Jul 2016 13:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbcGPNbJ (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 09:31:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:61607 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbcGPNbH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 09:31:07 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MMShK-1bR9Ev0Lmg-008GFi; Sat, 16 Jul 2016 15:30:47
 +0200
Date:	Sat, 16 Jul 2016 15:30:45 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] config: add conditional include
In-Reply-To: <CACsJy8AjVX1Say0srEq+ezGg=CzmbjBAt4PnuikXiqdnVC4G6g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607161507250.28832@virtualbox>
References: <20160712164216.24072-1-pclouds@gmail.com> <20160714153311.2166-1-pclouds@gmail.com> <alpine.DEB.2.20.1607141750190.6426@virtualbox> <CACsJy8AjVX1Say0srEq+ezGg=CzmbjBAt4PnuikXiqdnVC4G6g@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1585032505-1468675847=:28832"
X-Provags-ID: V03:K0:uuuXwW28hzsFH8mU3Il8LBJpoQH37MO9mXTjFuIlqYCeNnFIfl+
 KL/tqmvlycCUJLAHPXYaXw5TtJbZGnhPv5hgOrAp/yG3Mn1ts5s7DX/+hvWDZqTvBgKGHXp
 JYMm3SiProtrTn5nkzS9i1XWB3+SxM8YCfF0SUfSo49NPs6CqEYEwnB1fvmd9kJuUuv2XFt
 Md0SxguunTF2GXg0xk4cg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:rizbqYXsvAw=:tZNW5jAiGGK8sOYbtpJhZv
 /zp9d85wrdaBbTlVcoj5+AXTrEh/exK/avDfHcqbzQA8okHYK6Fsz7zP9bqvG4mW7f/B/TFMY
 ErgyxkPJCAnsKsxui51wFOMFmHcAy09+sum4QH0MuJqco9SIYTQEjDEc6VzEEBxeZbboWcilX
 aiBLfCyv5/JsL256Hw3qVV8xRxkHVTuURc1/x3Iqth7vS9xKksni3KB2kB+iF6IgCx2KYhPUM
 pjfmN3V4P6NSlS/z2xJt4sYRDWGRgGEsedVDYcSjtjjXwq7DRECeMs8oQSFd9I1QKsgbCz7ON
 il1s0Kf+tSrJNqgIYKfQfdPNcHXiQaxifAyO8z4YoMoXIM2l7zTxs0+Quv2U9r2pnfBfPdel8
 NIgPRvaZeWmCS496uksoFmE0iZw/6wKgEiwpGK/+hVAmBLsUkJgItGX5gVzlpiOpcyRz9VZXj
 OOc18V9L//KpPJqWzIJgl4SHA4O8Cw1mRN9rQid412BIBlYEBVQAs8kBcuIhnwYNioMzGwNmp
 M/zFOlr9Oj/rUGAcgRdfTVk6yaxg87bSUT3k7GlY6mi7hnVQo66S2VQh+aOf71J74vzG3e69K
 LG2DKVPeZJkg7b+cgqdRs6nYsRwNJKx3J5xlEQMEFQWzr6dAgpvaOFSfU/kXtXsZx+kLRDBos
 67kpjjIxvPqTYHSCA8VeWV2YeeQhVI0+PYwvdjz5iWhNR9vYmDR/SJcTMqFck8Pp0tVHbalqx
 twgD/z0sl8+15rKOK738c7pAHYI6xNlxK9sjQYkqJG0gRA97WAdIxHXDxyH0UzCbegt3hokYq
 7Lg+4co
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1585032505-1468675847=:28832
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Thu, 14 Jul 2016, Duy Nguyen wrote:

> On Thu, Jul 14, 2016 at 5:53 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Duy,
> >
> > On Thu, 14 Jul 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >
> >> Helped-by: Jeff King <peff@peff.com>
> >> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmai=
l.com>
> >
> > This commit message is quite a bit short on details.
>=20
> Because it's fully documented in config.txt.

Surely there is more information left for the commit message, such as:
what motivated the patch, what alternative solutions were considered, was
any thought given to how this might break down, etc

> > I still fail to see what use case this would benefit,
>=20
> It allows you to group repos together. The first mail that started all
> this [1] is one of the use cases: you may want to use one identity in
> a group of repos, and another identity in some other. I want some
> more, to use a private key one some repos and another private key on
> some other. Some more settings may be shareable this way, like coding
> style-related (trailing spaces or not...)
>=20
> [1] http://thread.gmane.org/gmane.comp.version-control.git/273811
>=20
> > and I already start to suspect that the change would open a can of worm=
s that might not be desired.
>=20
> You can choose not to use it, I guess.

Sadly, as the maintainer I am unable to share in that luxury of yours.

> From what I see it's nothing super tricky. The config hierarchy we have
> now is: system -> per-user -> repo. This could change this to: system ->
> per-user -> per-directory -> repo. You could create a different
> hierarchy, but with git-config now showing where a config var comes
> from, it's not hard to troubleshoot.

The more indirection you allow, the harder it gets. And that problem is
exacerbated when allowing conditional includes.

> >> +     ; include if $GIT_DIR is /path/to/foo/.git
> >> +     [include "gitdir:/path/to/foo/.git"]
> >> +             path =3D /path/to/foo.inc
> >
> > I find this way to specify a conditional unintuitive. Reading
> > "gitdir:/path/to/foo/.git" suggests to me that the Git dir is *re-set*,
> > not that this is a condition.
>=20
> Well.. to me it's no different than [remote "foo"] to apply stuff to "foo=
".

Except that "include" is an imperative and "remote" is not.

Quite frankly, this conditional business scares me. If you introduce it
for [include], users will want it for every config setting. And the
current syntax is just not up to, say, making user.name conditional on
anything.

As an alternative solution to your problem, you could of course avoid all
conditional includes. Simply by adding the include.path settings
explicitly to the configs that require them. Now, that would make reasoning
and trouble-shooting simple, wouldn't it?

And the most beautiful aspect of it: no patch needed.

Ciao,
Dscho
--8323329-1585032505-1468675847=:28832--
