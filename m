From: Max Horn <max@quendi.de>
Subject: Re: Silly time stamps
Date: Fri, 11 Apr 2014 17:14:54 +0200
Message-ID: <3B629BFA-C610-4B4A-9CE4-629C8930D334@quendi.de>
References: <loom.20140409T210150-369@post.gmane.org> <5347CD22.9010003@alum.mit.edu> <5347EBF5.102@ira.uka.de>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_2AC24D5D-C7EC-4061-9710-12F1BC5501E0"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Mahmoud Asshole <a1209145@drdrb.net>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Apr 11 17:14:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYdAL-0005of-NE
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 17:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539AbaDKPOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 11:14:48 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:41635 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755524AbaDKPOs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Apr 2014 11:14:48 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WYdAD-0004mf-UK; Fri, 11 Apr 2014 17:14:45 +0200
In-Reply-To: <5347EBF5.102@ira.uka.de>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1397229288;3b5e32ae;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246098>


--Apple-Mail=_2AC24D5D-C7EC-4061-9710-12F1BC5501E0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1


On 11.04.2014, at 15:19, Holger Hellmuth <hellmuth@ira.uka.de> wrote:

> Am 11.04.2014 13:08, schrieb Michael Haggerty:
>> On 04/09/2014 10:50 PM, Mahmoud Asshole wrote:
>>> [...]
>>=20
>> Please conduct your discussions here in a civil tone.  It is both =
more
>> pleasant for all involved and also more likely to elicit a response.  =
I
>> hardly think that the "waste" of 12 bytes in every commit is an act =
of
>> stupidity so inexcusable that it would deserve your bile, even *if* =
one
>> were to agree that this information is useless (which I personally =
don't
>> think).
>=20
> I would guess he is more concerned about the unnecessary disclosure of =
information that could be used to track or (together with other data) =
identify you.

Perhaps, though I fully agree with Michael that calling people =
"assholes" because their opinion differs from yours is not increasing =
the chances that anybody will listen to you, or bother to try and =
understand your problem.

>=20
> Since the reasons to include it seem to be specifically to know more =
about the comitter this seems to me the typical conflict between privacy =
and security.
>=20


More between "privacy" (or perhaps "personal safety"? think: dissident =
coder?)  vs. "feature that is useful to some people".

If one is truly concerned about spilling timezone information, how about =
this:

  alias git=3D'TZ=3D0 git'

Seems to work for me, at least in bash.


Cheers,
Max

--Apple-Mail=_2AC24D5D-C7EC-4061-9710-12F1BC5501E0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlNIBvIACgkQIpJVslrhe1noSQD/YOsMoCZo8m5E9Qb9KMGbOm0B
XDJeTdbY2YrREO5o3uMA/AhvRBnYyCqjMeL3f5mxD3QaiHP8GIbOXZvW4tGofeNR
=338I
-----END PGP SIGNATURE-----

--Apple-Mail=_2AC24D5D-C7EC-4061-9710-12F1BC5501E0--
