From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] gitweb: fix spelling errors in comments
Date: Sun, 27 Sep 2009 10:54:12 +0200
Message-ID: <20090927085412.GS32702@genesis.frugalware.org>
References: <1254007953-1961-1-git-send-email-vmiklos@frugalware.org>
 <20090927083507.GA25891@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PsEZZJjWpOB92CxQ"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 27 10:54:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrpWc-0004wU-NN
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 10:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbZI0IyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 04:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbZI0IyM
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 04:54:12 -0400
Received: from virgo.iok.hu ([212.40.97.103]:39745 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533AbZI0IyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 04:54:09 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DE3105808B;
	Sun, 27 Sep 2009 10:54:12 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CAD7844906;
	Sun, 27 Sep 2009 10:54:12 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CED5911F0028; Sun, 27 Sep 2009 10:54:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090927083507.GA25891@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129204>


--PsEZZJjWpOB92CxQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2009 at 04:35:07AM -0400, Jeff King <peff@peff.net> wrote:
> > The plural form of "id" is "ids", not "id's", right?
>=20
> It is a matter of some debate, actually. As an abbreviation, it should
> rightly be "ID", and therefore "IDs". Most style manuals indicate that
> no apostrophe should be used these days, unless it is an abbreviation
> separated by dots (e.g., "I.D.'s").
>=20
> Some disagree, and some indicate that you should use an apostrophe where
> it may be visually more clear (for example, in single-letter
> abbreviations like "A's").
>=20
> There is a nice summary of some style guides here:
>=20
>   http://answers.google.com/answers/threadview?id=3D499296
>=20
> Honestly, for such an informal bit of text as a code comment, I'm not
> sure it is worth nit-picking the grammar (e.g., we should be
> writing SHA-1 everywhere, and we obviously don't). I'll let Shawn decide
> whether he wants to apply or not.

As a non-native I did not know to resolve "id's" to "id is" or "id has",
and once I figured it out, I thought about sending a patch.

Though, if that helps, I can resend it with "Blobs defined by
non-textual hash IDs can be cached" to be more readable.

--PsEZZJjWpOB92CxQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkq/KDQACgkQe81tAgORUJZIwgCfRbRHMkbOqnqvdwdZsz1qiosN
7aUAni9LE8Q7ZsHGoz+IYT74rqFQpuaS
=462u
-----END PGP SIGNATURE-----

--PsEZZJjWpOB92CxQ--
