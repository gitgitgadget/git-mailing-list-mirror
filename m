From: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Sat, 24 Apr 2010 00:18:19 +0200
Message-ID: <4BD21CAB.8060903@gmx.de>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> 	<20100422155806.GC4801@progeny.tock> <4BD1EE10.4010009@gmx.de> <k2ub4087cc51004231234z29228ac8ia0f62a4e16cedae4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF31AC27AE5088913887ABD3D"
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 00:18:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5RCh-00051N-0F
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 00:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968Ab0DWWS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 18:18:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:45550 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750881Ab0DWWSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 18:18:25 -0400
Received: (qmail invoked by alias); 23 Apr 2010 22:18:23 -0000
Received: from g230100064.adsl.alicedsl.de (EHLO apollo.emma.line.org) [92.230.100.64]
  by mail.gmx.net (mp006) with SMTP; 24 Apr 2010 00:18:23 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX18VJdw4mvMVEYTpICRkZyGwA26Pi7/LV4NNXicHAH
	L4LhI+gr4FTuxu
Received: from localhost ([127.0.0.1] helo=apollo.emma.line.org)
	by apollo.emma.line.org with esmtp (Exim 4.71 (FreeBSD))
	(envelope-from <matthias.andree@gmx.de>)
	id 1O5RCY-000HV5-Pp; Sat, 24 Apr 2010 00:18:22 +0200
User-Agent: Mozilla/5.0 (X11; U; FreeBSD amd64; de-DE; rv:1.9.1.9) Gecko/20100406 Thunderbird/3.0.4
In-Reply-To: <k2ub4087cc51004231234z29228ac8ia0f62a4e16cedae4@mail.gmail.com>
X-Enigmail-Version: 1.0.1
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145644>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF31AC27AE5088913887ABD3D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 23.04.2010 21:34, schrieb Michael Witten:
> On Fri, Apr 23, 2010 at 13:59, Matthias Andree <matthias.andree@gmx.de>=
 wrote:
>> I'd also concur that "default to commit -a" would be a most undesireab=
le
>=20
> The proposal was not "default to commit -a" but rather "default to
> commit -a when the index has not been explicitly updated with
> something like git add".

Which is the same:

default (n) (5b) "a selection automatically used by a computer program
in the absence of a choice made by the user" (Merriam-Webster)

No previous "git add" =3D> default "git commit -a".  Exactly what I don't=

want.  It makes the software appear at nondeterministic as you add to
the "if"s and "but"s, and it breaks established practice.

It is not desirable to break established workflows for the sake of
newcomers' convenience.


--------------enigF31AC27AE5088913887ABD3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (FreeBSD)

iEYEARECAAYFAkvSHK4ACgkQvmGDOQUufZWZSgCgzaQAMO3S5ZwsK0ejuU0ejXwJ
S6YAoOUEu17bi4OknWLtcKtAZ/MxpuOI
=tOBS
-----END PGP SIGNATURE-----

--------------enigF31AC27AE5088913887ABD3D--
