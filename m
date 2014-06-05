From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Submodules with feature branches
Date: Thu, 5 Jun 2014 12:18:29 -0700
Message-ID: <20140605191829.GA32192@odin.tremily.us>
References: <CAHd499Bn7CCVy=vhFzpLYXCssxR0oGxm3Vdgou_Yk5zSt1gfmA@mail.gmail.com>
 <20140605151549.GQ21803@odin.tremily.us>
 <CAHd499Dc7_fob2-X1KZ77sdx20r+erQ_9JbDc7y4G0RUxG65eg@mail.gmail.com>
 <20140605162333.GR21803@odin.tremily.us>
 <CAHd499CBAQHG4rdojb8pdjymUCaZNYSnKb-ksmsLesq73OWTyA@mail.gmail.com>
 <20140605190033.GV21803@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 21:26:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsdBQ-00067A-Hy
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 21:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbaFETSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 15:18:35 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:51953
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752564AbaFETSc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2014 15:18:32 -0400
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id AiVm1o00316LCl051jJX2g; Thu, 05 Jun 2014 19:18:31 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id AjJW1o00U152l3L3SjJXQJ; Thu, 05 Jun 2014 19:18:31 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id DB174120A70E; Thu,  5 Jun 2014 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1401995909; bh=ah0C4JG4gq1Nv1Y0Znt9X+gtPljzESpl61e8uUzP3sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CuO4TcfnotOqlo2DBwFFRCRKIVy/WULszXP5xdFlo+YRSxjnYIbs96SFKujMqzoww
	 ZWEpRmdm2EcLsti6vgnM3f058SmMfOzPIzHCYsHB4tmUOSTKLEEt+9Z27B0+Gk8uTN
	 OGU74BOO+S3caYKNp6v0N8yUmDDy+ipmKGY4JnSQ=
Content-Disposition: inline
In-Reply-To: <20140605190033.GV21803@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1401995911;
	bh=t+dtZogT048rA7s3a97ypJ1s0MNgXKl6My5xEPtX8qk=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=EhearZ0ASnY6bP2kQUxzzbsOd6EZzWVoR/TpLX4Oax8yUY4Zl52ZVZuirXxCjGjw5
	 m7pp/RYVqr5fWLPlGPQ/+YaeRjQco9Qv7UEA5sv/fYadZCWjMf1CJkqzvV1zSdgCSH
	 1qYr/vri73H1DZVaa9TpqtVONwdutGtEt3ao7gItmBbz/cJ7ukY92y3BFKpu7azarg
	 QeVHUM/Potjm6N2deD5/+dRi/Elh12EZuIT1rRSvYTXs62M7AVztd0sAbJQtW4i39M
	 25e6NT2SitNcEydm2V5dSLBXkX19zZPTglAhXDlOYNgfuIyuMTk42ShmWpyEn+NyXN
	 bDyYZv1R2klrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250857>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2014 at 12:00:33PM -0700, W. Trevor King wrote:
> On Thu, Jun 05, 2014 at 01:31:39PM -0500, Robert Dailey wrote:
> > Instead of just creating my branch and starting to make commits, I
> > now have to setup my submodule branch first. Also pull requests
> > won't show the changes to the third party libraries unless I do a
> > second pull request for the third party repo.
>=20
> That I agree with ;).  However, if you're treating the third-party
> library as a separate repo, I think it makes sense that you need to
> be making branches and pull requests in the submodule independently
> from your branches and pull requests in the superproject.

To make this more concrete, I think you'll rarely have tight
one-to-one binding between third-party library changes and your
superproject.  More likely, you'll have some high-level feature branch
in the superproject (=E2=80=9Caccept comments via email=E2=80=9D) and an un=
related
number of prerequisite feature branches for your libraries (=E2=80=9Cadd
support for MIME documents,=E2=80=9D =E2=80=9Cparse RFC 2822 dates,=E2=80=
=9D =E2=80=A6).  You only
have synchronized branches when you mess with the API tying components
together (updating the submodule API and updating the superproject to
use it).  With good library design, that type of API migration should
happen more and more rarely as the library stabilizes.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkMKDAAoJEG8/JgBt8ol8eVMQAKFrynPPAdFLuX7zpTWED27O
H1KvfBHgOTB8ViT7FxMMF1VPSdd/1KMsNQp9OiAnhGDHoHteEpSgNsNp3X8MjkRb
z0vgZerWDwl7kobk/qQx866E+cZyrZeWklqwJ4PmXxwtdA0snITfI9PdzdESIrG4
w1FGQcP1l6kexyW6C433xUyHNC0wqdWXwdKBRy3IqxOxR44xy5TNxnzoXWpUwehs
eGWsfnkhIv6RZ1Q97e1HmYHS/W1MUbCYVydFaBBM2SXGX0/A5Fk16ZgLjDypk9NW
ZxN++8Cj2W041uW08nZGgcpR47IUykp4DXZjH5Yz1v8VyzA2M6voKVHXr3Vmrvz2
xj4LNljYVkL54QuPaiVmmbfDsb6ZGhapP8aLUQamHAez2pJsUhgbaNZjWtPzEOu3
1EPlbT5hS/rPFBTKHMVspik8+qrsGZLNI5V3jXL3BqQPbKpqQ+5fSEgrNK5N6whJ
AYoRufEn50j3eBb0nyqM75Zvrg2KwEvJtZIIdvb5ad+pjO0Kw+3RuM1NfMZs+yIO
PVu20INOUEyoGgUC/O4gE8Af4K7XB+ntKXXYg1P8YmhCTHOC6P9zIoDzWM0Ll+GU
SM7hgVtGKEtAilR1pYIURLopBMmUxA52RzxuTCBYgbaMNPXCew9eih9R4wnYlzjO
zaRB5MnytPGnMzGPgVjT
=I3Kh
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
