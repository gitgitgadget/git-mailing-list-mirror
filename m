From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 13/13] Fixup! doc: giteveryday and user-manual man
 format
Date: Sun, 24 Feb 2013 10:01:40 -0500
Message-ID: <20130224150140.GM1361@odin.tremily.us>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
 <1361660761-1932-14-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=I4g3zIzscEHdx6fd
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 16:02:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9d5d-0000As-Hq
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 16:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758086Ab3BXPBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 10:01:44 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:54906 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757548Ab3BXPBo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 10:01:44 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIQ009YCCEST510@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 24 Feb 2013 09:01:41 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 7D4FC8C0DAA; Sun,
 24 Feb 2013 10:01:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361718100; bh=uAeZWNqw9SWRMLIQFOgeP/zgCC+XGZazl6UJt3PCNF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RLvD05x2iCBNdvxhWtg4Ddr9zHHP85oo7/oquApo1BATJ/UH1pDWqjg0u8XzQ0Kmr
 CMR1TSsrh5HK7rj0iLSqe5WDOXcCNwTNjtQLOveHFuIUa29X6v2kXinM9ORbjlxyv/
 52izfBKfrvj3wwG9vnIZv5pQ+WXKxqtCwbstE+lY=
Content-disposition: inline
In-reply-to: <1361660761-1932-14-git-send-email-philipoakley@iee.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216993>


--I4g3zIzscEHdx6fd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 23, 2013 at 11:06:01PM +0000, Philip Oakley wrote:
> diff --git a/Documentation/gituser-manual.txt b/Documentation/gituser-man=
ual.txt
> index a4778d7..e991b11 100644
> --- a/Documentation/gituser-manual.txt
> +++ b/Documentation/gituser-manual.txt
> @@ -1,7 +1,12 @@
>  Git User's Manual (for version 1.5.3 or newer)
> -______________________________________________
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I'd be happy dropping the parenthetical bit here.  It's hard to
imagine someone still running something earlier than 1.5.3.  It's even
harder to imagine them installing a modern user manual man page for
their old Git version ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--I4g3zIzscEHdx6fd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRKitTAAoJEEUbTsx0l5OMytcP/AsXTSz2xGRglCqzj0zwjSlg
9JYlB6Xt9EZP9rLx+k4o25RuByAke3Q9o8bIOHgpyBJh7yMKjMB4ZCcrHkq91ICf
Id93h8/kJ6dYP8wAH7ea8Bx+OdzHs8n782pvlXJSZE5G69wKMZ6ESERFzGk6r2VQ
Qe0auBp05VjHBBgWAOFa9ysGuE/tqZvJo6Qy46abv0Q6LB+EsmtUFtwQ85Fb0juN
9ywRXLMPS010Suj+3YV5cRtGoAUv91ac0F9w7OshqQ8MAH4Y1w8rpvMKfPuXcGxM
EhbAHQVPcm6teuojTU9YqcXz/Y0elg0NLQlE18pPP5u4KCqp2gEL8zVRPtiu6BOt
DmHfx07FtoN1WOa1yej4WYXG42QgOTYLdXmm9tukhlWKl3+A1ZCobCgTAS6QgYGp
6LeA/oIjhQHRWv/aDoXgWEwxfdPIt64MvMYGjUdUFCxoXdEeu/Cw2vK6eNzXK5P/
f42tgmvaNfle/ZUyXx40pUfBTnPyaOu6QYepa0iF71o3HeUi59yYFDvcrM/f0b6z
WIJId9i09eTfB28mNYwHmk8Dp1qzrqwR7ToRrNXW27E+72wzM/j9zAZ3yoKCntOd
ts4hj29LIMipGpEQcpibFpeFz+tMUtewBaZMMcGufAPdIVpIiV+NdL7nbfXYidsd
LHccl2wGW/whbLZ5ezZB
=YuxY
-----END PGP SIGNATURE-----

--I4g3zIzscEHdx6fd--
