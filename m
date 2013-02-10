From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 09/15] user-manual: Use 'git config --global user.*' for
 setup
Date: Sun, 10 Feb 2013 17:25:08 -0500
Message-ID: <20130210222508.GC8377@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <b363f5b410098302a02af2d79b5b68ee79210be2.1360508415.git.wking@tremily.us>
 <7vip5zstsa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=3siQDZowHQqNOShm
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:25:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fLB-0004kY-8o
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881Ab3BJWZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:25:16 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:42432 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756607Ab3BJWZP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:25:15 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI0000ISZLW6L00@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 16:25:09 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 58656879B2B; Sun,
 10 Feb 2013 17:25:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360535108; bh=4osGU71wCJcifP/CgwgCxX9a4KQ4SafH0G25siuKr3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aAsSbmL0ea8eZDPlZnSIk/LgsVmhPemfFOx9BrhO71qUXj2f9n+TwQgU7YiGcUsYc
 Pc/yTDwYuIIfRmhB/8tx7+USKACamX/+SHmlmdkarihaue3VI4UIuD2kVH7YAeFUGv
 Eccw1hprATBD2+1McLRFHh6ZbUZKITSh7G7F2Cfw=
Content-disposition: inline
In-reply-to: <7vip5zstsa.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215953>


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 02:12:05PM -0800, Junio C Hamano wrote:
> > +Which will add the following stanza to a file named `.gitconfig` in
> > +your home directory:
>=20
> Looks good, even though I do not think we would want/need to confuse
> the readers with an unfamiliar word "stanza".

Aw.  I suppose "section" is better?  (It's what Python's ConfigParser
uses anyway).  I saw "stanza" in another part of the manual and
thought it was quite poetic ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGB5DAAoJEEUbTsx0l5OMfdEP/jMJF4mUmM+Bo4YpQK530PfV
uK8GizZ3qpovBa8CG3+J1nRZYhwwvtXmQzc8b2gGk5TmbHIe9Uu2Gwhmxwn2K1kQ
RJUZysHf5W9HiWESJLvAmCsiGlX3RHolFhojT0w/Mdelk3xy9ol7DrfqMJWxYySl
8T6mVDSrnPzo4JkOd4TTxW+HXmnp1B9BAwUsra5hP/fbMeRKJqGXEbS6nqKKRHFL
yApM0srzj28e9Hsgj9ncSgqJA1wrYVaWYI9VyFrB0i6Wn2hw85r/YEZkA4QsmzT1
spWaUjNyxJxEGI8br+txe/FBivEqEoTRFRp2avAB3sAKQNwF2FkOyvsAqMNJO0eS
lqSL1SqZEaqo6UIo8CxHo87jW64zRPFqK8MXYzEe3MZyg+xK+V4aWpy9NAtyWuwx
Ieu2yc754h4yrsdfuzQlIOEIPA0hRF6dA8LtDigNHGWZQmLdJjuZMnGyTpFd58US
a6z0QD8YemQgUWyrQ7QzUS91FJabpTV93yOFROHxCA04NatYajoKDMPJjiZenlqY
aQUlfd3xY2FLMZdZlpiz6QR5tbPfh/aVthAMnxfWGfspCLdIhvEbJTGIRdMfbmvb
i70X8ZVonh6z0hCnDDhnwMO9BRbs/VqFAZlOu7yQsfCQWBo11OMAwmX2VWGJ4fNa
kwxH0JltzO7lvQC9GHrn
=DERy
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
