From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] Documentation/githooks: Explain pre-rebase parameters
Date: Tue, 19 Feb 2013 08:23:31 -0500
Message-ID: <20130219132331.GD5125@odin.tremily.us>
References: <c19c03f51d71a58fa3795f665fe4a4c0461fa58f.1361271116.git.wking@tremily.us>
 <878v6ksars.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:24:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7nAw-0006iD-4c
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 14:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758318Ab3BSNXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 08:23:38 -0500
Received: from vms173021pub.verizon.net ([206.46.173.21]:33105 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758264Ab3BSNXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 08:23:37 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIG00LOLYJ8YN30@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 19 Feb 2013 07:23:32 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id EEBDE8ABDDB; Tue,
 19 Feb 2013 08:23:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361280211; bh=Nr4A09raKKXIC3BqVdsOhYDyDlBEAfh6/jO/9mxliDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d0T3qSpgsisWUTCa+2hjoKfD08LpDEbMHRBtr7zUpMhwiAIuIRDknP8loIAsKekMw
 AQFiqRu1LX4CnUpQQgBiI/4TJmrW8E6mR7iw5m/4V1WI8nkS46mh2uxqIpJ2xD8DTU
 WWzf96KeY5tVNDy3iiUhZ6k4G3ABdK/5pSIlvDI8=
Content-disposition: inline
In-reply-to: <878v6ksars.fsf@pctrast.inf.ethz.ch>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216615>


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2013 at 02:17:43PM +0100, Thomas Rast wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > I haven't been able to find documentation for the ${1+"$@"} syntax.
> > Is it in POSIX?  It's not in the Bash manual:
> [...]
> > In my local tests, it seems equivalent to "$@".
>=20
> It's definitely in the bash manual and POSIX[1]: it's a special case of
> the ${parameter+word} expansion.

I need to read more carefully ;).  There's even a nice table in the
POSIX specs=E2=80=A6

Thanks,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRI3zQAAoJEEUbTsx0l5OM9+YP/0ZNYwFHO5FpC5/Ni7kEzvjl
r3aWlZcEr8+nZdtGudYdrFzVXd/a1FwU5HoEt+YdkU8C2Nxxzf+JJDIvUvhLzZ+p
kmO7P3SZznp8Pn9xyAjG2lmJlRksZiCwdHg+rPmaClXRw2RiRYgFxp8niXlqH5Uu
jfmOqvI3PEzHW2JmnInBOUeWx1TVjZlLrz/LSVkPZIhF1OFWj3P1v3YG2Ewq6d5G
WbSIFlcPdBxMgLmQS9hW4ai+a4d2aWdszhw+eeUOTA6cPlFeOKzCxr+lO4fwc0Fa
zoYn6IG9IYl12XhwNVxg41HhKBONvV3fTHg0KTKLHsVpr/h6+xWEoMLj+zBQfjcy
DYGR2wD48DtB+B7M1EMDHXU1xenvh/8HoT8gjiTU5/qegGX7SJQORh8zEgFrQG/I
BAfvMuDkov8gcNovfeWOYk0fT/6dgoczu57rfbL11sXcMKGcPISclZu1QKG69Y8V
tFKmUxK5R9JdXVsafVTWNtgEkM/RiU8/CffP4mfVqQf6K5TyZi+mLag/HDy9tXaO
FepzvWaXldULGHoHaETn3xzwRSqp/jmFH0DTb/3PgGfvKtwD9sktKGzuGQmkPijz
govjwF264Xcv+IjpVn3tdVirVDlFAYoYdS6Eaziy6DQp1CrEW0krTvo5+EHRi4AQ
9qBSaCJlNnBt5J3DYwIF
=OXXH
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
