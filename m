From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [StGIT] Failure to install on RHELWS4
Date: Fri, 11 Jul 2008 21:26:29 +0200
Message-ID: <200807112126.39729.trast@student.ethz.ch>
References: <20080711170356.GF32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1747617.z08nvZPqUz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jul 11 21:27:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHOHA-00031X-2X
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 21:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbYGKT02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 15:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754509AbYGKT02
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 15:26:28 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:1912 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754065AbYGKT01 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 15:26:27 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Jul 2008 21:26:25 +0200
Received: from [192.168.0.2] ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Jul 2008 21:26:25 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080711170356.GF32184@machine.or.cz>
X-OriginalArrivalTime: 11 Jul 2008 19:26:25.0455 (UTC) FILETIME=[025BB3F0:01C8E38C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88161>

--nextPart1747617.z08nvZPqUz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Petr Baudis wrote:
>=20
> 	    pyver =3D '.'.join(str(n) for n in sys.version_info)
> 	                              ^
[...]
> Python version is 2.3.4

That is indeed too old.  Generator expressions like the above were
introduced in 2.4:

  http://www.python.org/dev/peps/pep-0289/

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart1747617.z08nvZPqUz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkh3s+8ACgkQqUud07tmzP3unQCfVjJebKh14PG+MzmBGK/6lyZx
fUAAn2apfMkZGKN/Ycg31rLKyu8tPcBE
=Md6s
-----END PGP SIGNATURE-----

--nextPart1747617.z08nvZPqUz--
