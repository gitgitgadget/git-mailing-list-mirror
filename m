From: martin f krafft <madduck@debian.org>
Subject: Re: [PATCH] [TOPGIT] make creating a commit from a topgit branch a
	function
Date: Thu, 22 Jan 2009 11:13:54 +1100
Organization: The Debian project
Message-ID: <20090122001354.GA29835@lapse.rw.madduck.net>
References: <1231968443-13960-1-git-send-email-u.kleine-koenig@pengutronix.de> <1231968443-13960-2-git-send-email-u.kleine-koenig@pengutronix.de> <20090121031913.GA7422@lapse.rw.madduck.net> <20090121101644.GA19052@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Jan 22 01:16:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPnEv-0000j6-4G
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 01:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565AbZAVAOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 19:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754515AbZAVAOm
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 19:14:42 -0500
Received: from clegg.madduck.net ([193.242.105.96]:33417 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380AbZAVAOl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 19:14:41 -0500
Received: from lapse.rw.madduck.net (unknown [IPv6:2001:388:a001:1:214:a4ff:fe04:eadc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 9454A1D40B1;
	Thu, 22 Jan 2009 01:14:25 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 50F3E80CC; Thu, 22 Jan 2009 13:13:54 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <20090121101644.GA19052@pengutronix.de>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.27-1-686 i686
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8886/Wed Jan 21 23:46:06 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106708>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2009.01.21=
=2E2116 +1100]:
> > What's the "next commit"?
> oh, sorry.  I intended to post my patch that implements `tg export
> --linearize`, but then found a bug and so didn't send it.
>=20
> You can find it in my pu branch at
>=20
> 	git://git.pengutronix.de/git/ukl/topgit.git pu
>=20
> .  It's not yet ready for general use, but I look forward to any
> constructive feedback.

It'll be a while until I can look into this. Until I do, I will only
pull in f4fa614, and we'll pull ae3fe45 when your linearizing patch
is ready.

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
"you grabbed my hand and we fell into it,
 like a daydream - or a fever."
                                        -- godspeed you black emperor!

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl3ujMACgkQIgvIgzMMSnWYMQCg5DBcV5vlJj0aB8kKZ+8qG/ID
Qk4An3NQ2S9xZ0FMCXOyx2Myq2OjL6l2
=hzB8
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
