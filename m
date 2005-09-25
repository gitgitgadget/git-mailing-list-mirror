From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: cogito push problem
Date: Sun, 25 Sep 2005 21:22:14 +0200
Message-ID: <20050925192214.GC19023@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 21:23:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJc4s-0004Bl-70
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 21:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVIYTWU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 15:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVIYTWU
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 15:22:20 -0400
Received: from wg.technophil.ch ([213.189.149.230]:722 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932274AbVIYTWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 15:22:19 -0400
Received: (qmail 19359 invoked by uid 1000); 25 Sep 2005 19:22:14 -0000
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9279>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I was trying to push my current work out and recieved this error:

[21:20] hydrogenium:cinit% cg-push main
error: remote ref 'refs/heads/master' is not a strict subset of local ref '=
refs/heads/master'.

My questions:
- What does that mean to me as an end-user?
- What's the reason that this happened?
- How do I fix that?

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQzb45bOTBMvCUbrlAQJi1w//TO1z9Z+fIWWAVn478qG7E4vchkC/9vi1
pxcko9tDjx5xY0Ngqpy+ASyMasFO2uHCBZD+rPXb0xkA3h3m3msAszmo9FabK4x6
epT8at/vVflqm6zjOqoqSvrYg24URUnW5qpegDp6poLwToV0ogSEhsJcOT6ewpC6
zodBJGUdVIHOIpWgQAIsfrbx4VylPPFUAGDU7DmYqwmX1+muZshmiHinKvVVKveo
lBuRPtMTDqHCPONDd2IjSs0AapSPaELX2ckurp1xvuFNI8EY69VgWHbh7vUGvtgn
3Lmu5k+qrW+SEEX4SL6UjEdtJRzE74Rro5lwS+tzY1/9XLUJBIbHk3NiyUyLxl++
ZwaG/KAz0aWyuzGQIfwH9A5fAfKEP+OaFHfrnaS/KLTjt2iIRZq2n5r2dQilqTs3
4dPu2t08+79F1Krfdbu3RihoFui4NaJQb+Vg3uG1zC9F3yzVHowaiPpMOL6g8fxw
+1bSzU4x8fiX1pyr01AlgT0Bdj8cB9GTjj4tLrcoym9FPk6HATJUR0Dm+Z+5UJAn
0xQV4eqnYfahKQ45LO3TL4/DMfSQZm4bvuTwbHMn14hNfocYAph724OVwsMHnsnC
viHHbtz3ge8fnSsDdJWchXRiT05dIs/wtTt/XtFkpoXEuwex4gfPemyn7nRQb8dz
hQi/HEWpdzc=
=r5qK
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
