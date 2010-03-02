From: =?utf-8?q?K=C4=81rlis_Repsons?= <karlis.repsons@gmail.com>
Subject: Re: Which VCS besides git?
Date: Tue, 2 Mar 2010 15:38:11 +0000
Message-ID: <201003021538.15276.karlis.repsons@gmail.com>
References: <201003021455.52483.karlis.repsons@gmail.com> <20100302152821.GD28997@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1972578.uAxtC3ejy1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 02 16:38:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmUAx-0006wX-8s
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 16:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab0CBPiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 10:38:18 -0500
Received: from [85.15.210.5] ([85.15.210.5]:51851 "EHLO pasts.trikata.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab0CBPiS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 10:38:18 -0500
Received: from keeper.loca (unknown [85.15.210.9])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pasts.trikata.com (Postfix) with ESMTPSA id 43E6C6E890;
	Tue,  2 Mar 2010 17:41:11 +0200 (EET)
Received: from station.localnet (station [192.168.7.93])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by keeper.loca (Postfix) with ESMTPSA id 4C0A910E4399;
	Tue,  2 Mar 2010 15:38:16 +0000 (GMT)
User-Agent: KMail/1.12.4 (Linux/2.6.31.5-2009.10.30; KDE/4.3.5; x86_64; ; )
In-Reply-To: <20100302152821.GD28997@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141402>

--nextPart1972578.uAxtC3ejy1
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 02 March 2010 15:28:21 Shawn O. Pearce wrote:
> K??rlis Repsons <karlis.repsons@gmail.com> wrote:
> > which VCS besides git provide chaining of commits with help of some
> > cryptographic hash function, warning about or not allowing commits to be
> > deleted on an equivalent of pull action, so that all added pieces of da=
ta
> > can be retained securely on client side?
>=20
> Most of the distributed VCS systems do this.  I know Mercurial is
> functionally identical to Git in this regard.  Maybe even Monotone
> and Bazaar are as well, but I'm less familiar with those.
And svn doesn't?

--nextPart1972578.uAxtC3ejy1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuNMOcACgkQHuSu329e3GGWrACfTlZkGA4v3HwiubgGCCq8WuUe
s1QAn2na1PkJHzFjE4hez9P9++KW8ZW5
=TKc2
-----END PGP SIGNATURE-----

--nextPart1972578.uAxtC3ejy1--
