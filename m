From: martin f krafft <madduck@madduck.net>
Subject: Re: Using trees for metatagging
Date: Fri, 19 Feb 2010 12:25:23 +1300
Message-ID: <20100218232523.GD22371@lapse.rw.madduck.net>
References: <20100218041240.GA4127@lapse.rw.madduck.net>
 <201002182200.09100.johan@herland.net>
 <20100218225758.GL9756@lapse.rw.madduck.net>
 <32541b131002181506v1d28526cpf8491994868272af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
To: Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 00:25:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiFkd-0002mR-Ha
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 00:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707Ab0BRXZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 18:25:38 -0500
Received: from clegg.madduck.net ([193.242.105.96]:42929 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab0BRXZi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 18:25:38 -0500
Received: from lapse.rw.madduck.net (koruout.airnz.co.nz [162.112.38.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 340451D40A2;
	Fri, 19 Feb 2010 00:25:27 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 87EBA24C; Fri, 19 Feb 2010 12:25:23 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <32541b131002181506v1d28526cpf8491994868272af@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.32-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140394>


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Avery Pennarun <apenwarr@gmail.com> [2010.02.19.1206 +1300]:
> > I am aware of notes, but so far I stayed away from them, simply
> > because it seems hackish to represent tag trees as text when dealing
> > with a tool that is essentially all about trees and refs.
>=20
> I think you're using the wrong definition of hacky vs. elegant.  A
> "tree" is really just a file containing a list of objects.  A "ref" is
> just a file that contains an object id.
>
> So checking in a file that contains a list of object ids (or
> filenames) is perfectly appropriate.

Indeed. But Git provides a lot of tools to manipulate all those,
which I would not be able to reuse in the text-file approach.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"good advice is something a man gives
 when he is too old to set a bad example.
                                                  -- la rouchefoucauld
=20
spamtraps: madduck.bogus@madduck.net

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAkt9zGMACgkQIgvIgzMMSnXFIgCdE+DpTSz73Wy93MSXvimWJq/8
G4sAoMuiUAgDB/dzo9uKx7wWUq8NwmXn
=Jaw0
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
