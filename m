From: Tilman Sauerbeck <tilman@code-monkey.de>
Subject: Re: [PATCH] Removed the printf("rm 'file'") from git-rm.
Date: Sun, 25 Mar 2007 23:04:19 +0200
Message-ID: <20070325210418.GA29221@code-monkey.de>
References: <11747590062554-git-send-email-tilman@code-monkey.de> <7vodmhc06f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 23:26:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVaEN-0004OL-Th
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 23:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbXCYV0Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 17:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbXCYV0Z
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 17:26:25 -0400
Received: from code-monkey.de ([81.169.170.126]:1216 "EHLO code-monkey.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932699AbXCYV0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 17:26:24 -0400
X-Greylist: delayed 1323 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Mar 2007 17:26:24 EDT
Received: from hammerfest (dialin-145-254-158-113.pools.arcor-ip.net [145.254.158.113])
	by code-monkey.de (Postfix) with ESMTP id 17DA0B427
	for <git@vger.kernel.org>; Sun, 25 Mar 2007 23:04:18 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vodmhc06f.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43081>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano [2007-03-24 23:22]:
> Tilman Sauerbeck <tilman@code-monkey.de> writes:
>=20
> > We used to print that, because you actually had to run the output
> > of git-rm to get rid of the files before Git 1.5. Now that git-rm
> > really removes the files, it's not needed anymore.
>=20
> Even though I admit I do not deeply care, as I never use 'git
> rm' myself, I do not necessarily agree with "because" part.
>=20
> I suspect people are by now accustomed to see the assuring
> feedback from the command when used this way:
> [snip]

Too bad, I find it rather annoying and irritating.

Regards,
Tilman

--=20
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQFGBuPS27uLisrW2w8RAvinAJ4mqn1pWKshvXingm979zLaPU4whgCfdI8X
k2BR5pOMktoj3r6BJzGrzIo=
=Qzic
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
