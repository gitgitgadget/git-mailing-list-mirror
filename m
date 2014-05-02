From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: Pull is Evil
Date: Thu, 1 May 2014 17:02:08 -0700
Message-ID: <20140502000208.GB28634@odin.tremily.us>
References: <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362266a3ca00_284da2f2eca3@nysa.notmuch>
 <7vbnvhil5x.fsf@alter.siamese.dyndns.org>
 <53629da233345_76612eb2f075@nysa.notmuch>
 <20140501194846.GA6227@odin.tremily.us>
 <20140501200703.GB6227@odin.tremily.us>
 <5362d7dc7b12_12fe14dd31095@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 02:02:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg0vf-0007qp-Q6
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 02:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbaEBACM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 20:02:12 -0400
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:57999
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752076AbaEBACL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 20:02:11 -0400
Received: from omta24.westchester.pa.mail.comcast.net ([76.96.62.76])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id wnuv1n0021ei1Bg57o2AXS; Fri, 02 May 2014 00:02:10 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta24.westchester.pa.mail.comcast.net with comcast
	id wo291n005152l3L3ko29Tg; Fri, 02 May 2014 00:02:10 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id CA0251173A0D; Thu,  1 May 2014 17:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1398988928; bh=xvA452jJ2zHiYzhmWCiYxNg9GzX4X9P5tuqPDwmPkqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=noaOqcpGmHj+cI2UPWvWFhYIRtSpRt13+JPMffUqMIGvCPTG0NuwBGMPP0JpgvzyQ
	 5nvXIMSW3bO188tf1AOPk9IhrmABePvEYW1DyErRhSXNM4v7hcwUrnuedrFVcPZ+AD
	 d01udY2ifG0ssCpxUzz0X4uUJKnRQNqL85qMCTCI=
Content-Disposition: inline
In-Reply-To: <5362d7dc7b12_12fe14dd31095@nysa.notmuch>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1398988930;
	bh=edlHD59HuKpWL4EvUcLVqFovvhnxuooJFxIk6wEOazk=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=oBiBUD9QP94o4CMWuA8f/gzYvVh8q/pAsALRvNhQFJOPAPO98bG+4a3L5S67gb/aR
	 9tqipMe+IKA9kPdIqeltBVlF+LWZdk6jw7OVZDHWtigAWZwakbC6ohAeAXWKPIXRco
	 PoT08n+vKTJmsC90TTNbGrmMk2cSbIJ7a7UqlFaEIdVI3d4Ks6Hn+h8VfcdpUquwV3
	 fCAgYX60GOayvXLY1MauogqaU90e5+kBMz4gRAn+HYZ+1OhPgV9s2cbMR7Bk90EfZo
	 am6RrYeUiIi7vZ0M0YIbU9IbifQqARruVuhd86CMI2kht/2J7ncYasobTNMFgACW5r
	 F1+9dKwXkBjOw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247900>


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 06:25:16PM -0500, Felipe Contreras wrote:
> W. Trevor King wrote:
> > On Thu, May 01, 2014 at 12:48:46PM -0700, W. Trevor King wrote:
> > > My interest in all of the proposed git-pull-training-wheel patches is
> > > that they give users a way to set a finger-breaking configuration that
> > > makes pull a no-op (or slows it down, like 'rm -i =E2=80=A6').  Then =
folks who
> > > compulsively run 'git pull' (e.g. because SVN habits die slowly) can
> > > set an option that gives them something to think about before going
> > > ahead and running the pull anyway.
> >=20
> > Actually, what do we think about an -i/--interactive flag (with an
> > associated pull.interactive boolean config to setup global/per-repo
> > defaults)?  Then after the fetch, you'd get one of the following:
> >=20
> >   Merge $count commits from $repository $refspec into $current_branch?
> >   Rebase $count commits from $current_branch onto $repository $refpec?
>=20
> Not much interactivity in those options. Maybe --prompt would make more
> sense.

I think matching rm, mv, cp, etc. is good, but I'd be ok with
--prompt.

> >   Fast-forward $current_branch by $count commits to $repository $refpec?
>=20
> Why would anyone say 'no' to this one?

Because the want explicit merges when they bring in topic branches?

> > and have a chance to bail out if you saw:
> >=20
> >   Merge 1003 commits from git://example.net/main.git master into my-fea=
ture?
> >=20
> > because you forgot which branch you were on.
>=20
> Yes, that might be nice. But we still need to change the defaults.

So I should submit an orthogonal patch with -i/--interative/--prompt?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYuB/AAoJEKKfehoaNkbtBWAQALG8NuPe1ReYfM8Gl/CPh4DZ
lC+AVIInx+mS2rdeb5wHLOsko0gur1ivkkDUNGnIRIft8smB8c3HemwYoJ/lALcl
l55+xLISD8R8uY/QNhOvoh01+6ndQcJJyIihJOTAVW3VsQ13oOy36yIIDyafMA12
4N3LEv5bfOJO43iQzFUrTZJeg0OmLKOJxe0eN1AO2GycKF6/+XwfiZ8o4edxVfHc
F1EMOGeC4KKhPkZcbYdna3NJhQ94QuepKxK7j6vg2bwKDXbmwzf5SBmDASbX3Dky
l9iIWOciis/pd7CRWxkcRM/UaaULVxgWbH4wr1RwpFjPfimFA0n0RJIYFLH7iUTM
JT3nFI0QBtHIhNPGXefIlgd4xyKycKFBFKMFU3gBXLW5i/Pwcnuc4/why5Nw5ONa
7HXb2BfK2bN3WjwdUApXhOHiiKxCemjkAFKlfiDMYtA2l84xMo57b/hIyd29gTJ3
EP42UCAwA0r4j+Gn4W6bqfCf2KbnXpprxa2lFyNuK2gFIPw0hgJJw827t2ahlYMd
6OLvIGtT67YkyRgxNGx41Ji41sMB1bH0oTXf/y89l4G2b/lAwRzAsq+3Mzjh+YrI
50881srE1kp6v6GcLtAak3RlhZYk5ZSaSPTRcD6u8sBpJiF2V+PzB6N/mugT0T21
QA2XzQrZkqKkX7bhGocF
=lW8M
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
