From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: `git stash pop` UX Problem
Date: Tue, 25 Feb 2014 23:50:15 +0000
Message-ID: <20140225235015.GE250380@vauxhall.crustytoothpaste.net>
References: <530B0395.5030407@booking.com>
 <CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
 <vpqlhx0a3cb.fsf@anie.imag.fr>
 <530C893D.7000108@ira.uka.de>
 <vpqzjlf5q2z.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Brandon McCaig <bamccaig@gmail.com>,
	Omar Othman <omar.othman@booking.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 26 00:50:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIRlY-0005hu-OY
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 00:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbaBYXuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 18:50:20 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:52178 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751785AbaBYXuU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Feb 2014 18:50:20 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:dded:7c23:2974:8ea2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F391428088;
	Tue, 25 Feb 2014 23:50:18 +0000 (UTC)
Mail-Followup-To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Brandon McCaig <bamccaig@gmail.com>,
	Omar Othman <omar.othman@booking.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <vpqzjlf5q2z.fsf@anie.imag.fr>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242695>


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2014 at 01:33:56PM +0100, Matthieu Moy wrote:
> Holger Hellmuth <hellmuth@ira.uka.de> writes:
> > Maybe status should display a stash count if that count is > 0, as
> > this is part of the state of the repo.
>=20
> Maybe it would help some users, but not me for example. My main use of
> "git stash" is a safe replacement for "git reset --hard": when I want to
> discard changes, but keep them safe just in case.
>=20
> So, my stash count is almost always >0, and I don't want to hear about
> it.

I concur with this.  Sometimes the stashed changes are remnants of a
small hack or a very brief start to an aborted project that I stashed
when I needed to change branches.  I figure that they might be useful in
the future, but I don't care about them right now.  I may pick them up,
I may not, but I certainly don't want to be reminded of them constantly.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTDSw3AAoJEL9TXYEfUvaLoPEP/ijDg5OV0cBB2xS/jQV5ckZB
ownZVa9zsRnpddcRdL1jh6xCqix1e8pEO6HwvsvWl2DouvnSQMS/JK8w2LCL5hpM
R89phGF3eO4HW+j882X61K96mzWS334b95A6JKuyvpnCL6TqCCZen4kwLgGe6PU1
DtmlqFQZcJSGTMoM/Easusgon1bnKsyVFjg7W7A1OIVTeyBGZWaIM6NlNbz1Wa3o
vipZla6E/BL+7CQvAXB0oZSPWqKKAyCMwueTHxHM1Kt84HQG5/rerJYQWT6dTfc/
/eyZIGOV9ZTDfSaaLyc2hLA9P9xLVZm1TLwDyFT2hwq0ZoNf2R/uj7T2NqXLZaCq
PQEl1lNglkTw95d6AIkn3yVL1jOIn35QOm8yfm1p/Nbc8PhrNBFQYD5x+jAIQa3s
6GPF/iLBT2v5GRtvF6YPgr3kh/FmIT9GUOICI4eOsTX5ZKW59AucS1fB8ojHyoL+
EjyfSAv4pRWMF4ZFon4uRzN08/J+/KGtHEShdmPGZr9KwfOvotVPeoGdbQ3rf6/I
tuyxaoKF7pXX7WaqUKVAF+KfXTx2A2RNb2b0vcrcMCsJmncyw0ePG3MKx7LtR2F2
XOQGs08JmpPvDEdOP8MRB5Mc+bw1KO84jAl4zeX2BPlgUfy6qr7wMrpNKHJeeMIr
xvQXdKmFZcwdiM2QzHpT
=C9KR
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--
