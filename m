From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: [usability bug] git branch -a does not disambiguate remote and local branches
Date: Mon, 15 Dec 2008 13:21:00 -0600
Message-ID: <200812151321.05421.bss03@volumehost.net>
References: <85647ef50812151015t4d5bc2b8p4ea53a0e4ad25e64@mail.gmail.com> <alpine.DEB.1.00.0812152005490.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7204284.yyvCdMU0Wb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 20:52:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCJUV-0001XV-1e
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 20:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbYLOTvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 14:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbYLOTvM
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 14:51:12 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:38382 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbYLOTvL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 14:51:11 -0500
X-Greylist: delayed 1799 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Dec 2008 14:51:11 EST
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss03@volumehost.net>)
	id 1LCJ0B-0000ii-MQ; Mon, 15 Dec 2008 19:21:11 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0812152005490.30769@pacific.mpi-cbg.de>
X-Virus-Scanned: clamd@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103202>

--nextPart7204284.yyvCdMU0Wb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2008 December 15 13:09:16 Johannes Schindelin wrote:
>IMHO it is better to be nice to the many users who do not try to shoot
>themselves in the foot, by showing them the nice short names that will
>work.

It should be possible to support both.  Short names when they are unique,=20
longer names when the short names are ambiguous.
=2D-=20
Boyd Stephen Smith Jr. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,=3D ,-_-. =
=3D.=20
bss03@volumehost.net =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((_/)o o(\_=
))
ICQ: 514984 YM/AIM: DaTwinkDaddy =A0 =A0 =A0 =A0 =A0 `-'(. .)`-'=20
http://iguanasuicide.org/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_/ =
=A0 =A0=20

--nextPart7204284.yyvCdMU0Wb
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklGriEACgkQdNbfk+86fC0KMwCfc7CpPKXou5PnHm6ELSkUUVL+
uyUAn2UKRfoCuqpYj+6NbOH9eXgs73eb
=SO3A
-----END PGP SIGNATURE-----

--nextPart7204284.yyvCdMU0Wb--
