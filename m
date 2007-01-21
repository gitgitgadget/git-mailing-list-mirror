From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] apply --cached: fix crash in subdirectory
Date: Sun, 21 Jan 2007 15:40:50 +0100
Message-ID: <20070121144050.GB6459@admingilde.org>
References: <20070120014851.GF5231@admingilde.org> <Pine.LNX.4.63.0701200312000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070120183615.GA6459@admingilde.org> <Pine.LNX.4.63.0701210212410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 15:41:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8dsT-0002oS-Dq
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 15:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbXAUOkw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 09:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbXAUOkw
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 09:40:52 -0500
Received: from mail.admingilde.org ([213.95.32.147]:46971 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbXAUOkw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 09:40:52 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1H8dsI-0003Sv-UE; Sun, 21 Jan 2007 15:40:50 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701210212410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37327>


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Jan 21, 2007 at 02:17:19AM +0100, Johannes Schindelin wrote:
> 	On Sat, 20 Jan 2007, Martin Waitz wrote:
> =09
> 	> git-apply inside the "src" directory segfaulted.
>=20
> 	Well, that was not the complete truth now, was it? Cannily, you=20
> 	avoided mentioning the use of the "--cached" argument...

You are right.  I forgot to mention that in the bug report.
Well, I was in a hurry...

Thanks for being faster in fixing the bug than I am in getting some
spare time!

> 	But as you see, your evil plan failed ;-)

Damn!
I'll need a better plan next time...

;-)

--=20
Martin Waitz

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFs3tyj/Eaxd/oD7IRAsqtAJ9zVB9Y4xlSjxHon1h+whu3427QbACfXtz+
XCL6H0wywsRlf0Cj7Qs+kVA=
=R/n9
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
