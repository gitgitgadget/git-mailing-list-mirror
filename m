From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] git-svn init/clone --stdlayout option to default-init
	trunk/tags/branches
Date: Sat, 14 Jul 2007 13:04:31 +0200
Message-ID: <20070714110431.GA3854@piper.oerlikon.madduck.net>
References: <1184405128718-git-send-email-madduck@madduck.net> <20070714105010.GA14842@muzzle>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jul 14 13:04:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9fQU-0004eg-Bg
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 13:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756440AbXGNLEe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 07:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756487AbXGNLEe
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 07:04:34 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:37451 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756421AbXGNLEd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 07:04:33 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 8833F895D73;
	Sat, 14 Jul 2007 13:04:32 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 21500-10; Sat, 14 Jul 2007 13:04:32 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 10652895D72;
	Sat, 14 Jul 2007 13:04:31 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 67EFD9F121;
	Sat, 14 Jul 2007 13:04:31 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 3D70343FC; Sat, 14 Jul 2007 13:04:31 +0200 (CEST)
Mail-Followup-To: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070714105010.GA14842@muzzle>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52471>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Eric Wong <normalperson@yhbt.net> [2007.07.14.1250 +0200]:
> This looks good and useful, but can I also have a  shorthand "-s" for
> this, too?  I'm lazy, thanks :)

Of course.

> Also, nitpicking, there's been some whitespace damage:
>=20
> I use tab characters for indentation, and (should be using) spaces for
> alignment.

What's the difference? Or is it simply:

  no. of tabs:   int(column / 8)
  no. of spaces: column % 8

?

I am sorry, I tried to do it right, even paid attention to the
tabs/spaces thing, but I guess I failed.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
save the plankton - eat a whale.

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmK2/IgvIgzMMSnURAqvtAKCuasB5T2wzrPyh+oHC9qOYuEekqACgxkUs
f492db/eFG4aiMVpCYyKxDM=
=tkwR
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
