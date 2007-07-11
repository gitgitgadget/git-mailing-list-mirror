From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] Fix core.sharedRepository = 2
Date: Wed, 11 Jul 2007 16:52:04 +0200
Message-ID: <20070711145204.GA5768@piper.oerlikon.madduck.net>
References: <Pine.LNX.4.64.0707111338360.4516@racer.site> <20070711135656.GA28593@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0707111517050.4516@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 11 16:52:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8dY6-0001Dh-Bh
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 16:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762069AbXGKOwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 10:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761343AbXGKOwK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 10:52:10 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:37291 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761962AbXGKOwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 10:52:09 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 2D7DF895D73;
	Wed, 11 Jul 2007 16:52:06 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30226-04; Wed, 11 Jul 2007 16:52:05 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 8BD10895D72;
	Wed, 11 Jul 2007 16:52:05 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 05E989F15D;
	Wed, 11 Jul 2007 16:52:05 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id C828F43FC; Wed, 11 Jul 2007 16:52:04 +0200 (CEST)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707111517050.4516@racer.site>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52166>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.07.11.16=
18 +0200]:
> This patch fixes both issues, and adds a test to prove it.

I also tested it and can confirm.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"wer ein warum hat, dem ist kein wie zu schwer."
                                                 - friedrich nietzsche

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGlO6UIgvIgzMMSnURAia/AJ9p0TI1l9nzMQrAX1s0aNd/hoyvGQCeORXt
eo7eLxKLmdIVVmbMVitY1JM=
=H8iz
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
