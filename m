From: martin f krafft <madduck@madduck.net>
Subject: Re: First round of UGFWIINI results
Date: Tue, 17 Feb 2009 18:39:57 +0100
Message-ID: <20090217173957.GA22426@piper.oerlikon.madduck.net>
References: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 18:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZTx1-0001ox-T7
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 18:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbZBQRkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 12:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbZBQRkP
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 12:40:15 -0500
Received: from clegg.madduck.net ([193.242.105.96]:50709 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbZBQRkO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 12:40:14 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 56B871D409D;
	Tue, 17 Feb 2009 18:39:59 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTPS id 5340B9F13D;
	Tue, 17 Feb 2009 18:39:58 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id E30B64468; Tue, 17 Feb 2009 18:39:57 +0100 (CET)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8998/Tue Feb 17 04:40:00 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110422>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2009.02.17.17=
47 +0100]:
> a while ago I announced the UGFWIINI contest, a glorious battle of ideas
> how to
>=20
> 	Use Git For What It Is Not Indended
>=20
> As most of you probably did not find my blog yet, this may come as a
> surprise to you, but it will not be the only surprise in this email.

A shame that I didn't see the contest start. I would have had
a number of cases to add using Git

  - to track your ~ (cf. http://vcs-home.madduck.net)
  - to track /etc (cf. http://kitenet.net/~joey/code/etckeeper/)
  - as the backend for a service like snapshot.debian.net
  - as a mail store and complete replacement of IMAP

anyway, enter me for round 2!!



> Avery Pennarun explains his endeavor of tracking windows with
> git... "If I get a virus, I can 'git revert' it."
> http://alumnit.ca/~apenwarr/log/?m=3D200901#21
> =20
> Sverre remarks: "It even beats the way we use Git to track the
> MSys installation in msysgit.git..."
>=20
> This is also related to Martin Krafft's idea to sort of replace
> the Debian packaging management by using Git, but...

I had this idea? Well, maybe something related: vcs-pkg.org, which
is about using distributed VCS for distro package maintenance. More
Debian-specific is my goal to replace source packages with services
that build straight from trees identified by Git tags, which I've
written a bit about here:

  http://madduck.net/blog/2005.08.11:rcs-uploads/

This is up high on my list of todos, so expect more on this topic
soon.

Anyway, thanks Johannes for the fun! :)

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"wenn elephanten tanzen leidet das gras."
                                                 -- die vogelpredigt
=20
spamtraps: madduck.bogus@madduck.net

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkma9m0ACgkQIgvIgzMMSnUg8QCfZf6aZt1++QnQUHW16FieHrHb
w/AAoKdniyNc94D4pZY0ECUVCMp1AA6Q
=ScdI
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
