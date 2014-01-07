From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Tue, 7 Jan 2014 15:14:04 -0800
Message-ID: <20140107231404.GD26583@odin.tremily.us>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
 <1388890249-3577-2-git-send-email-ceztko@gmail.com>
 <20140105203349.GB3737@book.hvoigt.net>
 <CALas-ijjzyRVuc0NaAS5QS98pX2198mv4HoHDacgYFYNLXbXFw@mail.gmail.com>
 <20140106140627.GA27265@t2784.greatnet.de>
 <CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
 <20140107041004.GA11060@odin.tremily.us>
 <20140107225128.GC10782@sandbox-ub>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Cc: Francesco Pretto <ceztko@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jan 08 00:14:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0fqh-0003E4-Cl
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 00:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbaAGXOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 18:14:12 -0500
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:56335
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753007AbaAGXOJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 18:14:09 -0500
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by qmta15.westchester.pa.mail.comcast.net with comcast
	id B19y1n00216LCl05FBE8qd; Tue, 07 Jan 2014 23:14:08 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id BBE61n00f152l3L3SBE7Zt; Tue, 07 Jan 2014 23:14:08 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 00998EAAED3; Tue,  7 Jan 2014 15:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389136445; bh=/8j+KNjxyVrdg1LkIu7e8VHp0me4A3h+2slkPRJRSPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F+KJculvZlFyfzwZmip5GV3bj+T0AvYzCHlH6svftEqeAzscMonuXVluk9VlN4saX
	 2mr+rADuCcAdCKFHgQMMCwbw3vfWI4GNgq1kj64vyvgoYerXWFUiVL+awlVOkJTa6z
	 qXYsintIhu7pgimfRW083nLG+3Fyzwn/bb4r6lM0=
Content-Disposition: inline
In-Reply-To: <20140107225128.GC10782@sandbox-ub>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389136448;
	bh=Nsk9fs2hYPrOJOqx8OHHHogSftVZbDRMaufHtiH4Mrw=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=J9rLeEo8ttDJV7bEeWwr+jBajTgbZccuo5AHNbnK4DJrQeUt7TX6N+1ik0+D/NNO7
	 n6EeRVSOnah+v7jaWIkTuEaX8yXEoRRwVpVoExlBNwoP3BuVenL473jgADpRxl9mkC
	 IVR8opN3n/bv3zeRyiniEw73HNaSJiVo6KRgwox0tk80iFFRMOu54ayKiqBXdBtAk0
	 MhDPOu8FEqas184v4mK1aUB0Mpf3k444SdYNydYcMrygt2lq0uXRXwPyF79rcSaEv7
	 x3UnAPX53ey5+v/vm61VLnArSVc0SqiBhMnPCnlBIioIliQkz2pGCwxC+OTIeXtywN
	 59coL9S96S2KQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240180>


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 11:51:28PM +0100, Heiko Voigt wrote:
> On Mon, Jan 06, 2014 at 08:10:04PM -0800, W. Trevor King wrote:
> > Here's an attempted summary of our desires, and my ideal route
> > forward:
> >=20
> > * Preferred local submodule branches for each superproject branch.
> >   * Not currently supported by Git.
> >   * Requires some sort of per-superproject-branch .git/config.
> >   * Fall back to the remote-tracking submodule.<name>.branch?
> >=20
> > * Auto checkout of the preferred branch
> >   * Can do this at clone-update time with my patch.
> >   * For later submodule branch switches, maybe we want:
> >=20
> >       git submodule checkout [-b <branch>] [<paths>=E2=80=A6]
> >=20
> >     Then if a user blows off their detached HEAD, at least they'll
> >     feel a bit sheepish afterwards.
>=20
> Well, for development on a detached HEAD in a submodule we are currently
> not very careful anyway. A simple
>=20
> 	git submodule update
>=20
> will already blow away any detached HEAD work.

Only if you use the checkout strategy.  With --merge or --rebase,
you'll have the $sha1 (or upstream remote with --remote) integrated
with your detached HEAD work.  You end up with a new detached HEAD
containing the result of the integration (just confirmed with tests
using Git v1.8.3.2).  That seems reasonable to me, so I'm happy with
the integration logic.

> But AFAIK it should trigger the "you are leaving commits from a
> detached HEAD behind" warning, so there is some safeguard and
> recovery.

I did not see those in testing with Git v1.8.3.2, likely because of
the '-f -q' we pass to 'git checkout' for checkout-mode updates.

Regardless of branch integration issues, I think a
per-superproject-branch preferred submodule branch is important for
'git checkout' to work in the superproject.  If you want:

* submodule branch master for superproject branch master, and
* submodule branch my-feature for superproject branch my-feature,

  $ git checkout my-feature

in the superproject is currently going to leave you with the submodule
on master, which is not convenient ;).  I think we should come up with
a better solution to the superproject checkout problem before adding
in additional complications due to branch integration ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzIo2AAoJEKKfehoaNkbt18oP+gJ6FaUAeUzd6ztp0TOZ7pn2
B8wkXfKyAQ9X4hALjPwMGrfSOaIIyk9yvbCjJeaV+2JwEp7cW+1G0yTqBQNbfLW3
nPe2VlHvpQcQuVWrG7Z2BzJ6wN3znZrvMzPmj4j45XlbWgcii8qQz7eD8EdZv6Md
LAn4Dn55A1gKsz2R0Oog0BeG/VDBFqEdH0vuDXK5q9/ko7lzXgG02K6omAInThNR
As5ShMuKdSTEtytD9HtbOujaAhcqNNdwNa4swMK96TdP5PzzxHv1RSqRsON4C/mx
hMbuT5gAWYmHlmJWd+3xx1emIFtHOHyrcmvgm07goSGfyD6Qr2H+omXo+atZK4eO
5fu9L5rZD4D72BR087OAoL4yB9kAocY8XhTx3/CeSxSD5i103tMA1MFmYusA516d
gJ6YAbhS3zOMnD5TY/KEV5ZTCgTeh0yLDeg+ibRg8Z0dtXU8GFyyksVlr7XmAaat
FHy7WIHTq/h6GZbbxtlLP74IxSmMQc/oRVyZJa+cBnOxD68V7xLMlrz5YA0HtPoa
ierSWuiz8q1o2PbhHw6Pes78bAEmCxYDIx6i9585TtxYMGdeGPHjvDxSJPFBJotE
xeeCGqaEb7aBOajoUqvu62mWveCG3ni6kqfX9KJk9+AnrCwXwIuCzMkPKuep1ZkR
JAeOu9IBbsngSaGTiqOW
=78s2
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
