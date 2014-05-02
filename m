From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Pull is Evil
Date: Fri, 2 May 2014 12:46:37 -0700
Message-ID: <20140502194637.GL28634@odin.tremily.us>
References: <20140501200703.GB6227@odin.tremily.us>
 <5362d7dc7b12_12fe14dd31095@nysa.notmuch>
 <20140502000208.GB28634@odin.tremily.us>
 <5362e8b09aba1_429131b31038@nysa.notmuch>
 <20140502011004.GD28634@odin.tremily.us>
 <5362f1755f2a9_d1310572f0fa@nysa.notmuch>
 <20140502145433.GF28634@odin.tremily.us>
 <5363ea28d3c14_70ef0f30c94@nysa.notmuch>
 <20140502190746.GJ28634@odin.tremily.us>
 <5363ee55ac2af_70ef0f30cf3@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eMP3JyRexyk9c0Bv"
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:46:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgJPw-0004Aq-Ri
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 21:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbaEBTql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 15:46:41 -0400
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:60760
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752172AbaEBTqk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 15:46:40 -0400
Received: from omta22.westchester.pa.mail.comcast.net ([76.96.62.73])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id x4eg1n0041ap0As547mfmR; Fri, 02 May 2014 19:46:39 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta22.westchester.pa.mail.comcast.net with comcast
	id x7md1n00h152l3L3i7met6; Fri, 02 May 2014 19:46:39 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 83F28117465F; Fri,  2 May 2014 12:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1399059997; bh=vFP+R0BYI/0wT0UFqWyaKSCgWMnGh+H4IpPTyHvgV/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kGutsPcOvOlJpcfCt8QuuMvoydBfN9WUftD2jSF11+TARRo+iy8Mlb18FIKqS6f9j
	 m/QkWefdenYfLYx9vqXbkCFtZ28zxxY83N+Fem2EDvimBbUhk6VyPk076ZnFs6o2ok
	 cGed1yqDUEvG5dQA5KLPy3ZeGHDk3U3aVA1JQ4bA=
Content-Disposition: inline
In-Reply-To: <5363ee55ac2af_70ef0f30cf3@nysa.notmuch>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1399059999;
	bh=QyXFM1jW7rLYwDKqQfQWeFvn+g1/JNjuyGpv3kqeDpc=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=p8+ogpQosja0acofXy4s3u71HzqN+DiOJguVHU7Gn4KJFCGCTgMUcLZswmtR55000
	 1FlNHmO329FYY+vv2SvuwCnM0tmYq0s/QlyBbvlb07LVeDBYFOWqQh6Bmch/jkE56p
	 XW/Veclya2xxqtyHirckeqaLwCpjwh80rri7KqcHggeA8/bEiUwZpfovGeFFmvvrPo
	 Gb0M/tlltPWryAekaPFxK/0Cv21pyOBhmOUKnYrRIq77MmswtfNXQG1zNtA8Hh1UKT
	 UPWhjEGuIkgDo94l9Dys/xDCdvEq+QLiRjC/X9wIj768CDDN6tFnnwcz3KAAELYncF
	 rbQx3L+tLjVhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247963>


--eMP3JyRexyk9c0Bv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2014 at 02:13:25PM -0500, Felipe Contreras wrote:
> W. Trevor King wrote [1]:
> > On Fri, May 02, 2014 at 01:55:36PM -0500, Felipe Contreras wrote:
> > > W. Trevor King wrote:
> > > > On Thu, May 01, 2014 at 08:14:29PM -0500, Felipe Contreras wrote:
> > > > > W. Trevor King wrote:
> > > > > > My proposed --prompt behavior is for folks who think =E2=80=9CI=
 often run
> > > > > > this command without thinking it through all the way.  I'm also
> > > > > > not used to reading Git's output and using 'reset --hard' with =
the
> > > > > > reflog to reverse changes.  Instead of trusting me to only say
> > > > > > what I mean or leaving me to recover from mistakes, please tell=
 me
> > > > > > what's about to change and let me opt out if I've changed my
> > > > > > mind.=E2=80=9D
> > > > >=20
> > > > > Unfortunately those folks by definition wouldn't know about the
> > > > > --prompt option.
> > > >=20
> > > > But once such folks are identified, you just have to convince them
> > > > (once) to set the pull.prompt config.  That's a lot easier than
> > > > convincing them (for every pull) to set the appropriate ff flag.
> > >=20
> > > It wouldn't matter if by the default non-fast-forward merges are
> > > rejected.
> >=20
> > It would matter if you [only wanted] them making non-fast-forward
> > merges (e.g. for explicitly-merged topic branches).
>=20
> It would matter almost exactly zero.

Some folks have explicit merge policies, and deciding how much that
matters is probably best left up to the projects themselves and not
decided in Git code.  I like having a place to explain why a feature
is useful and has been included in projects I maintain.

> And just as they can do pull.promot =3D true, they can do pull.mode =3D
> fetch-only.

Why would you run a fetch-only pull instead of running 'git fetch'?  I
think it would make more sense to have 'pull.mode =3D none' with which
'git pull =E2=80=A6' turns into a no-op suggesting an explicit
fetch/{merge|rebase}.  Having something like that available would
help with the training issue that pull.prompt was addressing.

Cheers,
Trevor

[1]: With David Kastrup's "only wanted" typo fix.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--eMP3JyRexyk9c0Bv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY/YbAAoJEKKfehoaNkbt7oMQAIkihm9ajmFyZaZsLBVPJExf
QNbmMEczV6Dk1OOJ25eJimu/lM4FBIUzZT1qd15xVNTHtAXr9teP2A3PfucNSo1P
9AyObtZQDmajP5Fn+4Al1zlnC6sNCX/ycpVmeV1Ys62njs1QRbGpemKysD7WVzvX
IOJ8YdZXqLSpX5ojDZauV/VkO0QWRP6Vfoy37vJuYJlXTS/3xlAqU/HpLjriLuMp
7XKzE/Map2uix0TTpUayAbtBukMYy1/z6fnZ+r+4jCiZ7fbwWt+R+nyjvOrBBjSs
UZGC4s9LJ8Ci31nTiqW30tOcAoqSAnOUKnAcNW1NL3+q84eyqC1wesLBIwYCR2H9
XYUHmB/ZXsvXK9lmysvMBcJcWgijn6Z5PrY1HqaF5zbGGJYwVM9X7530vbFYfpUb
/FPPh0ZgRX1DdSHphRDjFoTKexXkk9zf0lw+jwPDxjqusxlByIrxO3+AU3tFO6ak
cJXQLVp0scodMYnsIgD1Z0h8WxRrOwSzlr9u0HLn47CJX50hZO373KaRlykuDV3i
8MT4kjQniHp0IKYPypgDr1k5A/JKgDeyTKW13lG+4mzC4cykGWTitHFy9pkUXlAy
ygRndj0CnBRB6Uyj6aGO7qMqAc1I+vqEO4XgdUxPSS/j6j34A4MDsOPhleEL5Z1n
H8veC/NacAPSDLzLQ7RR
=nDXz
-----END PGP SIGNATURE-----

--eMP3JyRexyk9c0Bv--
