From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Pull is Evil
Date: Fri, 2 May 2014 12:07:46 -0700
Message-ID: <20140502190746.GJ28634@odin.tremily.us>
References: <53629da233345_76612eb2f075@nysa.notmuch>
 <20140501194846.GA6227@odin.tremily.us>
 <20140501200703.GB6227@odin.tremily.us>
 <5362d7dc7b12_12fe14dd31095@nysa.notmuch>
 <20140502000208.GB28634@odin.tremily.us>
 <5362e8b09aba1_429131b31038@nysa.notmuch>
 <20140502011004.GD28634@odin.tremily.us>
 <5362f1755f2a9_d1310572f0fa@nysa.notmuch>
 <20140502145433.GF28634@odin.tremily.us>
 <5363ea28d3c14_70ef0f30c94@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iRjOs3ViPWHdlw/I"
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:07:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgIoL-0001NC-Pr
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 21:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbaEBTHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 15:07:50 -0400
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:45659
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751824AbaEBTHt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 15:07:49 -0400
Received: from omta18.westchester.pa.mail.comcast.net ([76.96.62.90])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id x72p1n0021wpRvQ5877omV; Fri, 02 May 2014 19:07:48 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta18.westchester.pa.mail.comcast.net with comcast
	id x77m1n00u152l3L3e77n0o; Fri, 02 May 2014 19:07:48 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 6C55E1174531; Fri,  2 May 2014 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1399057666; bh=lR+ImQTbPUpAMoIgh8wfsv5Qh9EeJ1r8LBegNFG6Zog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g7ZXWZG8bliMQwx2x8nbcHf4lNjX4daD0cQgrUciZmLVgU9mfoUXigNvWb7/6mf8g
	 /HznxGbdSpv/9kXnBAv0sSSnt1isZSiHWvIHU+9TAUpQCuQscgBhftKMmXxjmEOFyQ
	 2J9FQFZ4D0KV/sVmU2YBqnu90RHRIruf4cs0HT0M=
Content-Disposition: inline
In-Reply-To: <5363ea28d3c14_70ef0f30c94@nysa.notmuch>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1399057668;
	bh=g5hTMT+KDU1O3WXHpdlIRVTjlHorYOK8N/n0V7oAq9w=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=Kbtr4yP4eZ+6YhA7IygP3tWFix6v+10IWYXrwn6oWtHPlim8wTfebHhCBdEqvXk05
	 /w55Op44CQZ72vXTV7qa1IiEDjCAQMWjiRv/GjewWiIql4MsajZJGORkdLOu8GSh1r
	 uYQR8I0UlttydgsGCgtoYz76g4O67p0q9F2ngY6uxiN6d/WG89oUDWg0ziD0N8ahAs
	 S9R97v3cDNGjCBmtc0REoX9ZVtFeYXijWENM2UX1tc2D+ejAuE3Ouradna2BecvrBY
	 ag2BKPz+tBEsBb1RYhVf9DNOa0Su6oObOtEsElPXkeHVdVQjPatN4Q3teeaZbA6A7P
	 KjNrYfkbttP5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247953>


--iRjOs3ViPWHdlw/I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2014 at 01:55:36PM -0500, Felipe Contreras wrote:
> W. Trevor King wrote:
> > On Thu, May 01, 2014 at 08:14:29PM -0500, Felipe Contreras wrote:
> > > W. Trevor King wrote:
> > > > My proposed --prompt behavior is for folks who think =E2=80=9CI oft=
en run
> > > > this command without thinking it through all the way.  I'm also
> > > > not used to reading Git's output and using 'reset --hard' with the
> > > > reflog to reverse changes.  Instead of trusting me to only say
> > > > what I mean or leaving me to recover from mistakes, please tell me
> > > > what's about to change and let me opt out if I've changed my
> > > > mind.=E2=80=9D
> > >=20
> > > Unfortunately those folks by definition wouldn't know about the
> > > --prompt option.
> >=20
> > But once such folks are identified, you just have to convince them
> > (once) to set the pull.prompt config.  That's a lot easier than
> > convincing them (for every pull) to set the appropriate ff flag.
>=20
> It wouldn't matter if by the default non-fast-forward merges are
> rejected.

It would matter if you didn't want them making non-fast-forward merges
(e.g. for explicitly-merged topic branches).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--iRjOs3ViPWHdlw/I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY+z/AAoJEKKfehoaNkbt+W4P/3aI3zdAJBv2Fyz+7kOBw3nR
uRYUA8GxyuHd2A9kxdYpmDhcM6OhQvJ2BE+JPJJP5XTTJj1QN2ykDDchnWWtzHDI
chhF1Dc2T0DF90oEXm0ZdvYDiiUu7QXjYcgZppqZxT7iK0OrWj5oKNNItLctp+YK
LM0WeE7TJI5vl5gumo3sZlPkC3lYii/MsiWhAxLdQ/rB+ZzWd2nBZx9ty1hpo8Ca
ewAeDy8ert9j16nYenIPBLmWcQ9okerwRND1y6xj+GornzAckKOsolg0hnpKmVKK
kR4HZwDS65O/GO8ebVmf/2xyEppN/NyODvP2ZRC1heB5X1/HCi8Wcj7h88dznjWe
AJNkkNL5RocOPEl7XkqSxQjZzjJGM+G/KEBzXxCIeqPcIXzqLLneEaZ+wUjpFtBb
m8TtR+XKm5ILGtulCtS5U4+rA6+N0iQzJujaskztguscMPSXMZOr4IjS7Wl+U2D/
myLPmO7SQ/+UEGOARDn6+iLOdB9IBQcWBmdFd14r6Tu/9ZyhiPQQRDsxNMH0xIip
S7sIPSfdTWj5MRTh7jaQAl0tCOkDT6Md5OLS9c7rcB8G5Hsrlz596WBjnhICr8oC
hfbt8/O97/IlGVQzCZWZBDAMmJh6qKxkUfFSJYplkXNcNQshuL0L3NIp8g6Sa4+S
EYXCsfWPIsfVYkCNDYhF
=SHLR
-----END PGP SIGNATURE-----

--iRjOs3ViPWHdlw/I--
