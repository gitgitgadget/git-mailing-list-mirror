From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: how do I install "git" on Redhat linux? (getting confused)
Date: Fri, 6 Feb 2009 10:44:42 +0100
Message-ID: <20090206094442.GA5229@denkbrett.schottelius.org>
References: <d30068860902051623w758bbfccrb1acca0adaf4a59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Cc: git@vger.kernel.org
To: Greg Hauptmann <greg.hauptmann.ruby@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 10:46:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVNHo-0002Ti-2Y
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 10:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbZBFJop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 04:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbZBFJop
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 04:44:45 -0500
Received: from mx3.schottelius.org ([77.109.138.221]:34120 "EHLO
	mx3.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbZBFJoo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 04:44:44 -0500
Received: from ikn.ethz.ch (ikn.inf.ethz.ch [129.132.130.3])
	by mx3.schottelius.org (Postfix) with ESMTPSA id D0C27197A07F;
	Fri,  6 Feb 2009 10:44:40 +0100 (CET)
Received: by ikn.ethz.ch (Postfix, from userid 1000)
	id 75C781F0AF; Fri,  6 Feb 2009 10:44:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <d30068860902051623w758bbfccrb1acca0adaf4a59@mail.gmail.com>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: ikn (Linux 2.6.28-rc9-wl-denkbrett-24896-gf4f5c96 x86_64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108667>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greg Hauptmann [Fri, Feb 06, 2009 at 10:23:17AM +1000]:
> Hi,
>=20
> Can someone give me a pointer re how to install "git" on Redhat linux?

git-core is in EPEL. If you add it to your repos, you can simply
yum install git-core.

Sincerly,

Nico

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmMBooACgkQuL75KpiFGIwPYgCgzLSkOb3ArTS7fn15nQ28GzeK
IhsAoJJfYQAz6Gh/Zu1XgWc5v3AiCgMl
=8AuX
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
