Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D568920281
	for <e@80x24.org>; Sun,  5 Nov 2017 12:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbdKEMmx (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 07:42:53 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33725 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751095AbdKEMmw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 07:42:52 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E08620BC5;
        Sun,  5 Nov 2017 07:42:52 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 05 Nov 2017 07:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=CApj7Wh+322l47pvjRMRw08yqAVvS
        dPQlEmMTddTYlQ=; b=mTSWPr/TXcqF1YO/kysfpsme49mgMaoSAyH+LMhGb+Vrp
        7YjAuiJv/DGw6B/GEmMWvkW+x9OlxQkmIzan+UvBwnIPWbAolaNEgvBdWNK0Xivv
        htgVOXe3biafMKnk7JoOy4rKPkNMWfjFBOgIkqgcDCie10LJ80huztJqmiNcllLP
        sN8551/xLHxXn2vNivAG8qsbRhzzuJlP9TCiLAdBuK7ADNLSkJrcX5SXp35zKYTc
        AoWTLNnpxIyqlsc7vaMOqFGcwNzjfHXT5pGcNswa12dCgxoa9zBwMj9XydZP4DGp
        bDxQ7VWahzcdOHWWV0+IDIDcAWnjGCoOO6m7Lx3HQ==
X-ME-Sender: <xms:TAf_WVW_BdTmH2K_08Xmt1S2k21kpAjkZZMpkF9NZJrsWQRbnQOOlA>
Received: from localhost (x4e37c27a.dyn.telefonica.de [78.55.194.122])
        by mail.messagingengine.com (Postfix) with ESMTPA id 64D04240B2;
        Sun,  5 Nov 2017 07:42:51 -0500 (EST)
Date:   Sun, 5 Nov 2017 12:42:49 +0000
From:   Patrick Steinhardt <ps@pks.im>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, hkleynhans@bloomberg.net,
        Jeff King <peff@peff.net>
Subject: Re: Git Open Source Weekend London 11th/12th November
Message-ID: <20171105124249.GA1494@pks-xps>
References: <CALgYhfO=6WfdzfGYwgw+cp2Tb58Yzx6YYvBtMCPNcJto5rMUCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <CALgYhfO=6WfdzfGYwgw+cp2Tb58Yzx6YYvBtMCPNcJto5rMUCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2017 at 04:36:24PM +0000, Thomas Gummerer wrote:
> Hi,
>=20
> Bloomberg is hosting an Open Source Weekend in London on the 11th
> & 12th November 2017 to contribute to the Git project.  We have
> also confirmed that Peff will be amongst the mentors on hand to
> guide attendees through their efforts!
>=20
> Some of you may notice that we tried to organize this earlier in the
> year, but unfortunately had to postpone it.  For this time around we
> are further along in planning, and it's definitely happening :)
>=20
> For those unfamiliar with Bloomberg Open Source weekends: These
> events provide a great way for those who love working on code to
> give back to the community. Come and help make difference to a
> great project!
>=20
> There will be tasks provided by the mentors, or bring your own if
> you already have a great idea.  Also if you can't attend the weekend
> and can think of a project which you would like tackled at this
> event please let me know.  Obviously the projects should be
> completable inside a weekend.
>=20
> Normally attendees work in small groups on a specific task to
> prevent anyone from getting stuck. Per usual, Bloomberg will
> provide the venue, mentors, snacks and drinks.  Bring your
> enthusiasm (and your laptop!) and come share in the fun!  The
> event is also open to everyone, so feel free to pass on the
> invite!
>=20
> The event is free of charge, but please ensure that you are able
> to attend the event before registering.  That will greatly help
> us with accurate numbers for catering so that we don't create
> unwanted waste!
>=20
> You can register for the event here:
>=20
> https://go.bloomberg.com/attend/invite/git-sprint-hosted-bloomberg/
>=20
> Whether you already are a contributor (as probably most people on
> this list are) or interested in starting to contribute to git or
> have some friends that you'd like to get to contribute to git, it
> would be great to see you at the event.
>=20
> If you have any further questions feel free to get in touch.
>=20
> - Thomas

Hi,

nice to hear, thanks for organizing. Due to having moved to
London just that week I'd love to take part.

As I'm a core contributor of libgit2, I am interested in bringing
forward libgit2 at that occasion. Would that be welcome or should
participants keep strictly to the core git project? Just asking
as I'd like to take part but have a rather long list of topics
for libgit2 on my backlog which I'd like to tackle myself.

Regards
Patrick

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAln/B0gACgkQEXxntp6r
8SwHug/6At6u/+g676e0slOZTQJEj7E0Ce2T8OBtjaSzuw9Sza/83TprSv7Ukoh+
kz7umFH30GtuovQ2IyrpTNGpa7VNIIcjX7cnfWZjJhomovvZh4H/bY1sG1vX8wyz
YrtMvCtP4WVdFUhV18n61+56tSRTlolR+nP4j/8i/V6snPDqYjKUIwHkQEMc8tS/
fSFcfyJZjcMQFGIGCiFTQ/i7G7yJZ+dAgXXtqlD4N4GrNhpffSfK5INV7wwEBzg5
F6NuMCNen11AHHm0i/FPTrFqhaO8qVadqceeXL5hUNoUZghDtkwMlUA25CNZFpNX
zrVEST1mpSM3MnVWUBiWF/9lEZYr3X9ljIvG2RzuHPajxPzqxdHkYNx5ed70AFrD
wNdx80zbiM+n+2sP5LADJY9yYcuxLGLshB2YUvsb9l2SPAxaKrkSCHGbJOVW1gsY
JwDjCsa9AU4oc0dCcPIj/K7upZC3RF7u2mK7nMnWyeheA/44XzcFBZJYmOn2/RI4
EoavJFaQWGqVou6+6Bnb5nRognD/gUDmZATBIKwnlirxNrItx6qt8KY0XTIoL1Cb
vdphYHWKAuVyRWiFHKZ3tZooWbw2klL77Z89Fgq+L9fuYm2nxK/JScPA/W2TLwDk
gT8xaj1QuWDpzN3ygS0c8BY/z1lR28zwHCqrBg3T5IqN4AFyNuc=
=Nnqk
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
