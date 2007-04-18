From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 17:34:45 +0200
Message-ID: <20070418153445.GC12888@admingilde.org>
References: <11768880622402-git-send-email-junkio@cox.net> <Pine.LNX.4.64.0704181247410.12094@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 17:34:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeCBI-0007OO-RW
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 17:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbXDRPer (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 11:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992774AbXDRPer
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 11:34:47 -0400
Received: from mail.admingilde.org ([213.95.32.147]:40623 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981AbXDRPeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 11:34:46 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HeCBB-0006i1-Em; Wed, 18 Apr 2007 17:34:45 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704181247410.12094@racer.site>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44899>


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Apr 18, 2007 at 12:48:48PM +0200, Johannes Schindelin wrote:
> On Wed, 18 Apr 2007, Junio C Hamano wrote:
>=20
> > 	[merge]
> > 		driver =3D ancient merge %A %O %B
>=20
> Why not do something like
>=20
> 	[merge.driver]
> 		ancient =3D merge %A %O %B

or

[merge "ancient"]
	driver =3D merge %A %O %B

--=20
Martin Waitz

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGJjqVj/Eaxd/oD7IRAnkNAJ99e0RqCPp/D/BsTJOjNbQCFmeLyACeMVZ1
9cDUqnVkIspTXPI+g8uWdls=
=wK2A
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
