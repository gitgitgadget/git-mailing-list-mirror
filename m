From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] Document how to tell git to not launch a pager
Date: Thu, 19 Jul 2007 13:49:30 +0200
Message-ID: <20070719114930.GA8477@piper.oerlikon.madduck.net>
References: <20070719104351.GA17182@midwinter.com> <20070719110224.GA4293@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0707191211010.14781@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 19 13:49:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBUVl-0004zc-Sn
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 13:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbXGSLte (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 07:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbXGSLte
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 07:49:34 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:56891 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbXGSLtd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 07:49:33 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id A3189895D74;
	Thu, 19 Jul 2007 13:49:32 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 21960-02; Thu, 19 Jul 2007 13:49:32 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 5FF47895D72;
	Thu, 19 Jul 2007 13:49:32 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 605EB9F1A1;
	Thu, 19 Jul 2007 13:49:31 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id D918D43EA; Thu, 19 Jul 2007 13:49:30 +0200 (CEST)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707191211010.14781@racer.site>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52975>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.07.19.13=
13 +0200]:
> It was evidently liked unilaterally amongst the big whigs in the git=20
> community.  Me too, I like it (which says nothing about my hair style). =
=20
> Often it annoys me tremendously that all the other programs like make, ls=
,=20
> etc. do not have this nice "-p" flag.

Thanks for the explanation. I'll come back and pick up this
discussion once I became a big whig in the git community. Now
I'll add the FAQ to the wiki.

http://git.or.cz/gitwiki/GitFaq#head-9dfc528b189148e801031d161201645af532a5=
80

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"das internet wurde konzipiert, um einem atomschlag standzuhalten.
 leider hatte kein milit=E4rstratege mit der deutschen telekom
 gerechnet..."
                                                      -- attila radnai=20

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGn0/KIgvIgzMMSnURAnR4AJ96MXikNb+HYYdpjTK6IjzC7h/HGACdHVR0
f8ZcDyjfLH/ylSRXlooQvZA=
=Sd/j
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
