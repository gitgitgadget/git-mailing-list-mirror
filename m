From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v5 00/10] transport-helper: updates
Date: Thu, 31 Oct 2013 18:59:08 +0100
Message-ID: <BBA75EFD-E68A-4E7F-A886-8878650D58A8@quendi.de>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com> <1383212197-14259-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_C65F0B18-6EBB-4C56-B694-0CEF2EF3467B"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 18:59:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbwWh-0007qx-CZ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 18:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310Ab3JaR7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 13:59:17 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:51742 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755291Ab3JaR7P (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Oct 2013 13:59:15 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1VbwWV-0002BH-Qi; Thu, 31 Oct 2013 18:59:11 +0100
In-Reply-To: <1383212197-14259-2-git-send-email-felipe.contreras@gmail.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1383242355;c7d03c12;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237134>


--Apple-Mail=_C65F0B18-6EBB-4C56-B694-0CEF2EF3467B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 31.10.2013, at 10:36, Felipe Contreras <felipe.contreras@gmail.com> =
wrote:

> Hi,
>=20
> Here are the patches that allow transport helpers to be completely =
transparent;
> renaming branches, deleting them, custom refspecs, --force, --dry-run,
> reporting forced update, everything works.

I looked through this patch series in detail, and it looks fine to me. =
Indeed, it fixes several nuisances when using remote-helpers, and as =
such would be a definite win. In other words: Would be really nice to =
see these applied!


Cheers,
Max


--Apple-Mail=_C65F0B18-6EBB-4C56-B694-0CEF2EF3467B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlJymm8ACgkQIpJVslrhe1nZEwEAxj9zkLeO0NEetOhvB+O6pnXf
n/nzvdPQCFngh6lJh6cBAMhkbgvLy90qyBhslClQneR4+qZaQcy64nJMwM46UK9d
=bCrI
-----END PGP SIGNATURE-----

--Apple-Mail=_C65F0B18-6EBB-4C56-B694-0CEF2EF3467B--
