From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Set TAR in t/Makefile and in t4116-apply-reverse.sh
Date: Fri, 25 Jul 2008 19:12:19 +0200
Message-ID: <20080725171219.GE27172@leksak.fem-net>
References: <TE3N1FoSy-vEEv0qsAyvBwBMMq2RuJCWYw7DNLBC7mEh6PxM1LCsOw@cipher.nrlssc.navy.mil> <1217003860-10609-1-git-send-email-s-beyer@gmx.net> <20080725170522.GG32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jul 25 19:13:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQrC-0003LU-ED
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 19:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbYGYRMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 13:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbYGYRMa
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 13:12:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:57427 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751286AbYGYRM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 13:12:29 -0400
Received: (qmail invoked by alias); 25 Jul 2008 17:12:27 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp002) with SMTP; 25 Jul 2008 19:12:27 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+iDLAc1i+icMPZpR1kg0M5U+xDiMuso+DgfYckAF
	1TjIR0yMEOI82M
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMQq3-0001f2-OS; Fri, 25 Jul 2008 19:12:19 +0200
Content-Disposition: inline
In-Reply-To: <20080725170522.GG32057@genesis.frugalware.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90074>


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Miklos Vajna wrote:
> On Fri, Jul 25, 2008 at 06:37:40PM +0200, Stephan Beyer <s-beyer@gmx.net>=
 wrote:
> > Hence, the test passes also when you run "make" in t/
> > or when you invoke t4116-apply-reverse.sh directly,
> > without $TAR being set.
>=20
> Thanks, I just hit this issue today. ;-)

Puh, I'm glad that you're not writing
"I've hit this issue yesterday and already sent a patch to this list" :)

Regards,
  Stephan

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFIiglzbt3SB/zFBA8RAnE0AJ9noqOww9RhEuj146/klzhxdSlAzQCgtKoP
htdBIXhOSFdeeN9sfwKTMCE=
=tSbf
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
