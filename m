Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FDE9202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 19:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758633AbdKGTFi (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 14:05:38 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39743 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757059AbdKGTFh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2017 14:05:37 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 041E220CF9;
        Tue,  7 Nov 2017 14:05:37 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 07 Nov 2017 14:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=GSDnFCtMgc4NkxeFq2m2cwtc7GT8O
        OEKLndU9u3y5rs=; b=UvoItUGvkqU3k88LQaz/nWNjR66dcfOLOLCnXJHkNOohc
        i+h0pmNhNbA8232Q3yKtsvMZkKLQRqx720QCDHOZEJ2EOGi4xkDqsX83G3ONv7/J
        tMR2C29p74WVTJxa+75k4ksWY+Xip46lipAW1J5YTDaF6xG9okeLBk1Zi02W7qbk
        VbHA+612IETmOXf22iORHHjpj8f/8u6tPhPH/0r9LwiCwEX8Q319ZLZT3zxJTD0J
        mQKYKExup4OV7iqtlnoA95uZ3YYK5dPPsg1xB9ZrrA3LiuxtY0ohPwWKHJHM6uG5
        cAzTi+RNIMz89iSz2dhG8nyzRM3qHbyc+99hxQtuQ==
X-ME-Sender: <xms:AAQCWmZLVBSk8suwK1JxErYT1hpkZieNfG0tDEj9qRgZH8FfAObr2g>
Received: from localhost (x4db48b5f.dyn.telefonica.de [77.180.139.95])
        by mail.messagingengine.com (Postfix) with ESMTPA id 438CB7FA6B;
        Tue,  7 Nov 2017 14:05:34 -0500 (EST)
Date:   Tue, 7 Nov 2017 19:05:32 +0000
From:   Patrick Steinhardt <ps@pks.im>
To:     Henry Kleynhans <hkleynhans@bloomberg.net>
Cc:     t.gummerer@gmail.com, git@vger.kernel.org, peff@peff.net
Subject: Re: Git Open Source Weekend London 11th/12th November
Message-ID: <20171107190532.GA21295@pks-pc>
References: <5A0036F7026201F600390334_0_28211@msllnjpmsgsv06>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <5A0036F7026201F600390334_0_28211@msllnjpmsgsv06>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Patrick,
>=20
> libgit2 tasks are welcome!  Feel free to bring your ideas
> along.  Also, Peff could add some to the task list if they are
> appropriate for others to participate on.

That's nice. I don't want to populate the list with too much
libgit2 specific things, but we do have a summary at [1] which
highlights a few starters as well as some possibly bigger
projects. I'd be grateful to see that URL mentioned, together
with the fact that there are two core developers present which
are able and happy to help out.

Please let me know whether that's enough for you to work with.

Thanks
Patrick

[1]: https://github.com/libgit2/libgit2/blob/master/PROJECTS.md

> Look forward to seeing you at the event!
>=20
> Kind regards, Henry
>=20
> From: ps@pks.im At: 11/05/17 12:42:53
> To: t.gummerer@gmail.com
> Cc: Henry Kleynhans (BLOOMBERG/ LONDON), git@vger.kernel.org, peff@peff.n=
et
> Subject: Re: Git Open Source Weekend London 11th/12th November
>=20
> On Wed, Nov 01, 2017 at 04:36:24PM +0000, Thomas Gummerer wrote:
> > Hi,
> >=20
> > Bloomberg is hosting an Open Source Weekend in London on the 11th
> > & 12th November 2017 to contribute to the Git project.  We have
> > also confirmed that Peff will be amongst the mentors on hand to
> > guide attendees through their efforts!
> >=20
> > Some of you may notice that we tried to organize this earlier in the
> > year, but unfortunately had to postpone it.  For this time around we
> > are further along in planning, and it's definitely happening :)
> >=20
> > For those unfamiliar with Bloomberg Open Source weekends: These
> > events provide a great way for those who love working on code to
> > give back to the community. Come and help make difference to a
> > great project!
> >=20
> > There will be tasks provided by the mentors, or bring your own if
> > you already have a great idea.  Also if you can't attend the weekend
> > and can think of a project which you would like tackled at this
> > event please let me know.  Obviously the projects should be
> > completable inside a weekend.
> >=20
> > Normally attendees work in small groups on a specific task to
> > prevent anyone from getting stuck. Per usual, Bloomberg will
> > provide the venue, mentors, snacks and drinks.  Bring your
> > enthusiasm (and your laptop!) and come share in the fun!  The
> > event is also open to everyone, so feel free to pass on the
> > invite!
> >=20
> > The event is free of charge, but please ensure that you are able
> > to attend the event before registering.  That will greatly help
> > us with accurate numbers for catering so that we don't create
> > unwanted waste!
> >=20
> > You can register for the event here:
> >=20
> > https://go.bloomberg.com/attend/invite/git-sprint-hosted-bloomberg/
> >=20
> > Whether you already are a contributor (as probably most people on
> > this list are) or interested in starting to contribute to git or
> > have some friends that you'd like to get to contribute to git, it
> > would be great to see you at the event.
> >=20
> > If you have any further questions feel free to get in touch.
> >=20
> > - Thomas
>=20
> Hi,
>=20
> nice to hear, thanks for organizing. Due to having moved to
> London just that week I'd love to take part.
>=20
> As I'm a core contributor of libgit2, I am interested in bringing
> forward libgit2 at that occasion. Would that be welcome or should
> participants keep strictly to the core git project? Just asking
> as I'd like to take part but have a rather long list of topics
> for libgit2 on my backlog which I'd like to tackle myself.
>=20
> Regards
> Patrick

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAloCA/oACgkQEXxntp6r
8Syu/g//dKXMNz6h94hGd79aA/cxC/VJoQqnkA51SB0+L5GS4/KSp8k/G6ixT/qg
Bu0VtSsWjZ2ptAT+fJG+WGs4YFSO3roxorHhaBrB/AuaF/oh6ByZKVLL9ZjD+O2E
axvN63XQ0YmyInuxRZY1c6+jPO/6OD+U+cPRJw/QaLy/I5VCwwHKC59tkiiNWUst
8VRpUB8xj3WE1TJlRMzE2nEZeQy/W1kExMaGkfAaxPxSvID0hu1cXlPo9rLa6g6L
MTx/0p4jNRUigN1AydgCeBtTjzrgz8QT+iEkdvZR31WO4OKX9b5an8inVz4LN2+I
6RI+FaxXyx21iC05W9Y9l+V/jozz2yf+HP/uIPZ7o2Ea1vC0L9FhukIcxePKQawT
H6ArpOtagqoyABrIOXM1pRC4un5vaspDc/vqjGa9NUV3f3e0Bx8TSWfrDeMSNuTq
A3G2vymLq9evGY7Xbwt1cl8dQpaJNjLeNv0pc2RcDvyCUFXWvs0MAYXoTRXEXi5t
EDNeruij/dB6aVADCby5oUbytSwmFkhuquV5Dv1sT7X5Nv8EMmbfFzuMIqFCQHUb
Z0kwapsLBdV76g32a8UFyHl8FszqouHEV002oSe6+ss0Tu7v/5j5h3MFVTKPjaUT
+t16sgJGjNMKtVKGWkznucMEUO3kEvnMQG8T9QgCOJFFS8LUl0I=
=ptgP
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
