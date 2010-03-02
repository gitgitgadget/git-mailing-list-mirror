From: =?iso-8859-4?q?K=E0rlis_Repsons?= <karlis.repsons@gmail.com>
Subject: Re: Which VCS besides git?
Date: Tue, 2 Mar 2010 16:22:16 +0000
Message-ID: <201003021622.22196.karlis.repsons@gmail.com>
References: <201003021455.52483.karlis.repsons@gmail.com> <m3y6ialn3z.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1966744.I59aSqSDke";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 17:22:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmUrd-0007HP-L2
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 17:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab0CBQWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 11:22:24 -0500
Received: from [85.15.210.5] ([85.15.210.5]:35456 "EHLO pasts.trikata.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753997Ab0CBQWY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 11:22:24 -0500
Received: from keeper.loca (unknown [85.15.210.9])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pasts.trikata.com (Postfix) with ESMTPSA id 8006B6E893;
	Tue,  2 Mar 2010 18:25:17 +0200 (EET)
Received: from station.localnet (station [192.168.7.93])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by keeper.loca (Postfix) with ESMTPSA id AB32510F009C;
	Tue,  2 Mar 2010 16:22:22 +0000 (GMT)
User-Agent: KMail/1.12.4 (Linux/2.6.31.5-2009.10.30; KDE/4.3.5; x86_64; ; )
In-Reply-To: <m3y6ialn3z.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141405>

--nextPart1966744.I59aSqSDke
Content-Type: Text/Plain;
  charset="iso-8859-4"
Content-Transfer-Encoding: quoted-printable

On Tuesday 02 March 2010 16:12:22 Jakub Narebski wrote:
> K=E0rlis Repsons <karlis.repsons@gmail.com> writes:
> > which VCS besides git provide chaining of commits with help of some
> > cryptographic hash function, warning about or not allowing commits to be
> > deleted on an equivalent of pull action, so that all added pieces of da=
ta
> > can be retained securely on client side?
>=20
> Could you rephrase your request in more clear way?
>=20
> Bazaar, if I understand it correctly, and from what I remember, uses
> some UUID which includes commit digest as a commit identifier, but I
> don't know if Bazaar have immutable history.
On top of what you wrote already, I'd like to know which VCS have immutable=
=20
history, which can all be stored (say, gradually accumulated) on clientside=
? I=20
hope, that explained the idea...

--nextPart1966744.I59aSqSDke
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuNOz4ACgkQHuSu329e3GFP2ACfeXCFwL4ObyvKuNHhwJC/na3X
5bcAnR7xkxjXZS/KF13yUyFaWTW2f2AD
=8QSa
-----END PGP SIGNATURE-----

--nextPart1966744.I59aSqSDke--
