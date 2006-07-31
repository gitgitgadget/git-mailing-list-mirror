From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: fill in gitweb configuration by Makefile
Date: Mon, 31 Jul 2006 09:08:19 +0200
Message-ID: <20060731070819.GD16364@admingilde.org>
References: <20060730223754.GA16364@admingilde.org> <7vzmeqa7tx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 09:08:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Rt9-0007Za-FK
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 09:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWGaHIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 03:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWGaHIW
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 03:08:22 -0400
Received: from admingilde.org ([213.95.32.146]:54239 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932504AbWGaHIV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 03:08:21 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G7Rsx-0001MG-PD; Mon, 31 Jul 2006 09:08:19 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmeqa7tx.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24497>


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Jul 30, 2006 at 06:20:26PM -0700, Junio C Hamano wrote:
> I think the other parts are sensible but I am not sure if we
> want to report the version of git distribution (your patch), or
> the version of git binary the cgi script happens to use (the
> current implementation).

hmm, right.
Well, now that gitweb is included with GIT I think that they will
be in sync on many sites, but of course that's not guaranteed.

Shall I send a new patch without that change?

--=20
Martin Waitz

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEzaxjj/Eaxd/oD7IRAvBPAJ0YmvlAbtqd4EM+/UnG2pNaVJBSkACfbGui
6z2VGFMuJZ1CY7yHUnZTCOw=
=S60n
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
