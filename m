From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] checkout: be quiet if not on isatty()
Date: Sun, 28 Aug 2011 08:28:48 +0200
Message-ID: <20110828062848.GA22182@albatross.gern.madduck.net>
References: <cover.1314472512.git.sdaoden@gmail.com>
 <c70a246a601bec0ce973b177bf5553d3fee47014.1314472512.git.sdaoden@gmail.com>
 <7vaaau9hso.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
To: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Steffen Daode Nurpmeso <sdaoden@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 08:38:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxZ0z-0000Ji-Rx
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 08:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051Ab1H1Gii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 02:38:38 -0400
Received: from swan.madduck.net ([80.68.90.58]:51371 "EHLO swan.madduck.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941Ab1H1Gig (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 02:38:36 -0400
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Aug 2011 02:38:36 EDT
Received: from albatross.gern.madduck.net (albatross.gern.madduck.net [IPv6:2001:a60:f0fb:0:22cf:30ff:fe2a:7c07])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albatross.gern.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by swan.madduck.net (Postfix) with ESMTPS id E9D111A019;
	Sun, 28 Aug 2011 07:28:49 +0100 (BST)
Received: by albatross.gern.madduck.net (Postfix, from userid 1000)
	id 0B680BEFDB; Sun, 28 Aug 2011 08:28:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vaaau9hso.fsf@alter.siamese.dyndns.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 3.0.0-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180260>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Junio C Hamano <gitster@pobox.com> [2011.08.28.0822 +0200]:
> 	In general, the progress output should not be given unless the
>         output is sent to a tty (i.e. an interactive session).

Just as a note =E2=80=94 around Unix, it's generally "output should not be
given unless there was an unexpected condition, or --verbose was
passed. If a tool did successfully what it was asked to do, it
should just be quiet about it."

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
/.ing an issue is like asking an infinite number of monkeys for advice
                                                   -- in #debian-devel
=20
spamtraps: madduck.bogus@madduck.net

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJOWeAdwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xGci
D/4pdRhk51F9S6/h9E8ys9lX3YLiqe9ayNtJ0EJSy+m2lgow1Ox5XzEXS7uU21uz
j2htcXXkWyw+/tLgIAfR9jn1gWPA0x+o61S1j8sLbyWUSQYNGRFlIjCIxLfJ+oMZ
HwFi7yiDK/8WNQVgZv3iGVgg3tk0ZAmZ5HnCFdKHZNo/pU0T1XcAzA/QKGrjJXOD
615bNV5bjI3MPUGGIIUFnhSDKG7Y74UIDyjEoyMqfz4JGz2HOMaTKSHvuDblv+XT
C7+09lyuY3ZnyV1dE9Kb9VDqYlH9bSmbI7zQXU1uIdE+oG1bAGiwFWhxjbupRh4D
2nGtIZHMF5z0BGcqn7cBaleS1bMOlrI8pn+NeuHTcsGG70LexOuTXmRRzgIR5jj0
9IoEmeNxfeMP0tvJmwbLunhQmXF2myr0NWjtKt/mmYoV5uPRoO4/dTnh7U90Fkx3
jw7Q6gQzHLZoYnCdR2Xpvzac+Ef5/UTUsSPefDuU6BMNjjNzf2dnqtsyEc4HKPDF
ez3InjzAMqI0TQlacaxlmwuf0JK2/lG/JDaRAtMi0zXiSrIST7yzkl8v/oKD2UVD
2xRPvJMKlAMtcwRcGt/BluxXJi2hlXAnK7QyqbSEvxN1USqClprYvG+xQlmSBq8Z
z9oYw2E+gDancTj8uyP1pvvTd2gPO6P+/26Z7scaSG+dtQ==
=bT8N
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
