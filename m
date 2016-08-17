Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7A91FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 13:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbcHQNy5 (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 09:54:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:56368 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbcHQNyp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 09:54:45 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MMYZG-1bXHD12rHy-008G1j; Wed, 17 Aug 2016 15:54:21
 +0200
Date:	Wed, 17 Aug 2016 15:54:20 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.9.3
In-Reply-To: <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608171507530.4924@virtualbox>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox> <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1426037386-1471442061=:4924"
X-Provags-ID: V03:K0:YApLDc6cFJHbsb3UsyBqkvH15y+JIOpvjYraftgKDy718u4PPN3
 4IrhADYaIZ06m4iP6iVhbgn1VDXEt+6oMfZO1CEWFX7xeAwe1MQfaUbawxqZlneJM19ET/7
 ADtwmPeo/xxAfExIbmsZjdBab7tQQuBy/NoJDv1yl/iPCyLKrSUzSLWtrf0yXzKBi2tbcx2
 KAGagetQg1s9t+zTP4mtQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:P2Fx/h90JaE=:vT5x4QzqXxlmPl7VIBAs+b
 FG5v7D3J4NhCo6KzVyj3t73Wf/t3Bzkl+BEv/Bqt+jkA2DYmXF+kJe0BNN1K8VIB3gDQvrHKT
 60FTTcsTR+8l1pj4f98Zd4I4CTe3HD74dQqy+eGR2yThIa78bfbCjYgjMVdtwCgGCcHmtz4x/
 X3EmVN6+CT5Gl4R25dZ6xsZZmry4N6NGdDg6afhyZTr4bt2p3wn25Sl5S09lKra9hfdYTp0pk
 aA3/1ydIl8li7n5zYvW2+WhN3xdG/AsQBdw8LHQfh7H+gtm3Dpson/7jZT5m6Mm50uWkdC4Ts
 +IdhSurMc5EtSXGM5xPLOzsVfM0m8TAkJ8lodW4tA11yOYfW9r47/Nu/9eIPYyJ7EpGaV5H1C
 TyEzrLKRBBuztmsANZYWG5KlKVCJx+sN9zvZnPPYmdPBY3YfldQDmw9MBV2QRdikQbXVgkfwS
 bt22WkSzGAJJm5VQGtRPAIPcsK5yYsaeP4RyciO5ZAw9OoObLI2QFYdzEfllVUFbjBR7z4T8/
 2wlR4jgPl+A/J3VcC89uZs79ypN6RxORzNmjv3d43XdSi90XVF+/AlVB+6TTUal68yFKcQ5pD
 Yyh3ZDOV8A6O961AgkAy8Qfii567Et4bVAt5cJdFIrbeJ6FKCxVbEThzj1w9cmviMqSq8ZtsI
 Xh4uftVvbee3FUuWBfxbt2VrtbX9PsS6QWTVe9cRkDcBWcQTyw6YVq2hsXFOsK4LYhQ3MaRj5
 IZl/aBAaLQgTcxonR0x18RDPMdtkCb/vLOv1OHpMjqLCDUnseJDGRcFXTrAC2v2/IMHcttA4p
 vtIGwUy
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1426037386-1471442061=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Sat, 13 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>=20
> > New Features
> >
> >   =E2=80=A2 Comes with Git 2.9.3.
>=20
> For future reference, what time (in UTC) of the day is convenient
> for you to see an upstream tarball?

Heh... I don't do tarballs anymore, I now use this newfangled tool to
manage source code... "gyt" or something like that, it is called.

:-)

Given that between you and me there is currently a time zone difference of
9h (except for four weeks, two in spring, when it is only 8h, and two in
fall, when it is 10h), I believe we cannot find a time that is convenient
for both of us.

But I also think it is fine, when I discover a new upstream Git version in
the morning, I can spend all day on fixing any problems and on packaging
the result ;-)

> >   =E2=80=A2 Sports a new --smudge option for git cat-file that lets it =
pass
> >   blob contents through smudge filters configured for the specified
> >   path.
>=20
> Perhaps we want to upstream this, together with a new "--clean" option
> for git hash-object?

No question about that. I just needed this in a hurry and short-circuited
it into Git for Windows before submitting it upstream.

> And after writing all of the above, I noticed that hash-object by
> default uses the clean machinery and that can be turned off by giving
> the "--no-filters" option.  The reason why the option is not called
> "--no-clean" is because it is not just about the clean filter but is
> about using the entirety of convert_to_git() filter chain.

Right, as is the --smudge option (it is about the entirety of
convert_to_worktree()).

> We probably should teach "hash-objects" to take "--filters" for
> consistency.

I actually thought about that, too. Which was one of the reasons I did not
submit the patch to the Git mailing list first, as I expect several
iterations to be necessary to get everything into `master`.

> And then your "git cat-file" patch can be upstreamed with the option
> renamed to (or with an additional synonym) "--filters", which would make
> things consistent.

Right. I would like to ask for a `--smudge` synonym nevertheless, just
because I already use this. On the other hand, it is early enough to tell
everybody who knows about this feature to change their invocation (anybody
who would know about `--smudge` would be in that 1% of users that have
read the release notes, so most likely would read the next release notes,
too).

Ciao,
Dscho
--8323329-1426037386-1471442061=:4924--
