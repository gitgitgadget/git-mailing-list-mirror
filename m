From: Joey Hess <joey@kitenet.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 14:56:26 -0500
Message-ID: <20100120195626.GA6641@gnu.kitenet.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 20:56:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXgfK-0007Qz-Ga
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 20:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235Ab0ATT4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 14:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754220Ab0ATT4a
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 14:56:30 -0500
Received: from wren.kitenet.net ([80.68.85.49]:43544 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998Ab0ATT43 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 14:56:29 -0500
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 8E92711829F
	for <git@vger.kernel.org>; Wed, 20 Jan 2010 14:56:28 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 49E2FA8365; Wed, 20 Jan 2010 14:56:27 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vhbqg376b.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137566>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Let me ask a stupid question.  Did the output change before and after the
> notes code even when your history does not have notes?

No.=20

> >> > Might be worth documenting in release notes, maybe too late now thou=
gh.
>=20
> This depends on the answer to the above question.  If the answers is "No",
> then I don't see the need to say much more than "New 'git notes' feature
> allows comments applied to existing commits after the fact to be shown by
> log and friends".  If it is "Yes", we should fix the code not to change
> the output.
>=20
> In any case, "log" is still a Porcelain, so it is understandable that by
> triggering a new feature you would get output from the new feature.  It is
> called progress ;-)

Do you think it makes sense for even git log --format=3Dformat:%s to be
porcelain and potentially change when new features are used? Seems to
me that parts of git log walk the line between porcelain and plumbing.
So it's not clear which parts are safe to use.

--=20
see shy jo

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBS1df58kQ2SIlEuPHAQjX2Q/+L/LMVVQkSQ7a/Cd1IDrKzCFA8/OaWFr1
pCI60dhPLJgr415lLoqkgbLrgQTmGeFo5dPTrFG+1/hnBUWHRYfPvG7iNjyeTgz9
pkcoZhO0YW5fNMQhDkkdKVECgaIKrJnJhCfl6/+LzaY35EB7/WDO6LRT4nYW/SJX
+5oip6kEJDUDtp5OIgSUKO1Ir+OQN0tqk9zWcV0K/5kUx0OyNJgzFPLk0Jx097gY
fH6OMxifqGS06K9HzN8EZ8wQUxFgGTBd1Mt5VWXbTptMcBwOZvfrTNu56O/HvMi5
+9ejZWCSYsIn0hfnc+cYy0sxNA6N9MSnG6BH5szAlNLQ134xkTHRXcGacUepDsAC
Aa26OSXP03ZdKzL86efoiKq/SbPmVkgsCrlPwhUh2L5m5Crmv3xkOPOIdMZi4zL6
6Kv7BejQwVYvzVqbOUYJRU/0wRCbyQTZLRgv9zS/U1K+Pl2A9kox0eZpuGw23RjS
Dg6VcsKhs6StnVADqO2wOHHdQjy6tzcH178sv+ueBL/LHjuSP5TlEIlmY1hz2Yjw
ynmvBQrkzfxmqPJyrQT1k2J2EYHarxM8AMPC0CsrV8g8eE/KkBx7cVKCwtPG8dtu
ezsih8TAk3DzSGcAxYHCjnnUNK+dW4/S7QjUJmArJiGNmT/SyS2OpSNpczNaT80O
IgfrzJbAfVw=
=v+ga
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
