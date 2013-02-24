From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 09/13] Rename everyday to giteveryday
Date: Sun, 24 Feb 2013 09:55:26 -0500
Message-ID: <20130224145526.GK1361@odin.tremily.us>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
 <1361660761-1932-10-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=tKtFalx5NIx0HZ72
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 15:55:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9czZ-0003JJ-1D
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 15:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757492Ab3BXOz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 09:55:29 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:62861 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268Ab3BXOz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 09:55:28 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIQ006FKC4EH910@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 24 Feb 2013 08:55:27 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 7F1538C0D48; Sun,
 24 Feb 2013 09:55:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361717726; bh=aDFhgafqffb2y4cBCt8W1uhvnqLkwZLOA8p652xTDOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T734IrQ9VYn+rnf/9oE4jeQ17WXyda8xjp6i7Nrz85p0/7OqHa8clW3aNkaAGpMcy
 yN1lE1iV933JsiQ6LFQK6hjVO+2CWQ1agSi9oxm16PnsrP1pDc8C/sQgpSIliSiSUw
 cXY+753NPvGYB1S+LEup54eoCaf6wN+XGQ5YwC5s=
Content-disposition: inline
In-reply-to: <1361660761-1932-10-git-send-email-philipoakley@iee.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216991>


--tKtFalx5NIx0HZ72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 23, 2013 at 11:05:57PM +0000, Philip Oakley wrote:
> diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
> index e1fba85..3fc69f6 100644
> --- a/Documentation/everyday.txt
> +++ b/Documentation/everyday.txt
> @@ -1,413 +1,25 @@
> -Everyday Git With 20 Commands Or So
> +Everyday GIT With 20 Commands Or So
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This looks like it's opposing 48a8c26 (Documentation: avoid poor-man's
small caps GIT, 2013-01-21).  Another reason to use 'Git' over 'GIT'
is to match the page we're redirecting to:

> new file mode 100644
> index 0000000..e1fba85
> --- /dev/null
> +++ b/Documentation/giteveryday.txt
> @@ -0,0 +1,413 @@
> +Everyday Git With 20 Commands Or So
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--tKtFalx5NIx0HZ72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRKindAAoJEEUbTsx0l5OMJoIQAJY2/MPMRUD8Rp05TucGuTvQ
O9nZec1xG4mSZl9OuCYlnymDk7kKyyP5jm9PYg6f9AwhxHYXE7uiHQ3JwY642P+L
N3rDRvYcULuP2i3gBA78WIl+UsgB7OAqmpsCX7EP3lvYnj8jIsillZar1MWmk6rv
ntMiXembY/m+Zx0MkyYLRWkYXKDL6RR1KvAuCevvf9jDhDYRMshffk9827x9fH5e
VMBiDzgddHSCEIEzZQ6Yixq8r3Lmqt6MPVRx6BJ2CW+9FW8IXbgxlUUhG3P2VzKt
L21f71k1O7buMq+NXv7xyrvip6EsOxnmgBAGdNLLahfzPigQvjjI9z9oLlK0R8K7
vNBc27OXgLzWYXjrnz3dAF1aip2jbSQv1137IhGyKVR53Pfl8C7194KA1crb3213
f23vUORYCr3oI/9mO4foN8UMD5djI6QGzvy/UvvA/QX211YjSX/OQzfIReY+L+nV
1nfF8yF9jSrhhu/lpReKgfBFu/c5tuFPaweSPsHse79QBDFP6Mzorrc0wD1I5fOh
dRlWGNk5AN/0TrdpC6szsny8DDhZ38DFZw9NOnvYinlcQlw+IKgEz1Z/6Ch34Elm
iXEQ4DDsqBGpJYebPwKOBi+4ktq1aTJJ8YYCR8IgK+plaKrEzJUWAWXwHx5vQDFu
F9ktd1SoHG2x7iTq3wUd
=rl0W
-----END PGP SIGNATURE-----

--tKtFalx5NIx0HZ72--
