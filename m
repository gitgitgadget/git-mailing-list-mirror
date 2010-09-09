From: martin f krafft <madduck@madduck.net>
Subject: Re: Find the next tag on a given branch
Date: Thu, 9 Sep 2010 11:34:38 +0200
Message-ID: <20100909093438.GE8776@fishbowl.rw.madduck.net>
References: <20100909052841.GA16722@fishbowl.rw.madduck.net>
 <201009091007.35275.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
To: Thomas Rast <trast@student.ethz.ch>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 09 11:59:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtduM-0008W9-MA
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 11:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300Ab0IIJ67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 05:58:59 -0400
Received: from seamus.madduck.net ([213.203.238.82]:37522 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248Ab0IIJ65 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 05:58:57 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Sep 2010 05:58:57 EDT
Received: from fishbowl.rw.madduck.net (vera.madduck.net [77.109.139.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id C9D21411664;
	Thu,  9 Sep 2010 11:51:30 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 591971FE5B; Thu,  9 Sep 2010 11:34:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201009091007.35275.trast@student.ethz.ch>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.35-trunk-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96.1 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155855>


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Thomas Rast <trast@student.ethz.ch> [2010.09.09.1007 +0200]:
>   git tag --contains mycommit | grep ^debian/

Awesome. Thank you so much!

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
wind catches lily,
scattering petals to the ground.
segmentation fault.
=20
spamtraps: madduck.bogus@madduck.net

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAkyIqi4ACgkQIgvIgzMMSnVoKQCcCTjF0QK2cM5/eQcb7NaQNpWU
wQ8AoNYxiTWlJ0eCDHSM12BnODwFn0Vn
=Phlt
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--
