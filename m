From: martin f krafft <madduck@madduck.net>
Subject: Re: [TopGit PATCH] .gitignore += vim swap files
Date: Thu, 18 Sep 2008 18:54:15 +0100
Message-ID: <20080918175415.GA30383@lapse.rw.madduck.net>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru> <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru> <36ca99e90809181038o74c73121j59849b3f24fe6469@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:56:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgNjQ-0008BW-Kb
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 19:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447AbYIRRys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 13:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbYIRRys
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 13:54:48 -0400
Received: from clegg.madduck.net ([193.242.105.96]:58770 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487AbYIRRyr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 13:54:47 -0400
Received: from lapse.rw.madduck.net (lapse.rw.madduck.net [IPv6:2001:41e0:ff3a::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 7878B1D40A6;
	Thu, 18 Sep 2008 19:54:15 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 5A95380C3; Thu, 18 Sep 2008 18:54:15 +0100 (IST)
Content-Disposition: inline
In-Reply-To: <36ca99e90809181038o74c73121j59849b3f24fe6469@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel
	2.6.24-etchnhalf.1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94/8280/Thu Sep 18 16:52:56 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96231>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2008.09.18.1838 +0100=
]:
> can't you do this in your .git/info/excludes?

Of course, but then I'd have to do it too, and on all machines where
I have a topgit clone.

martin, who'd love to see '/*-stamp' added to the .gitignore file
too to hide the temporary files created during the Debian build;
mdadm recently added it. :)

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"in diving to the bottom of pleasure
 we bring up more gravel than pearls."
                                                   -- honor=E9 de balzac
=20
spamtraps: madduck.bogus@madduck.net

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjSlcYACgkQIgvIgzMMSnXJpgCeKkyn8HUALbPbVq/fcgjfLUHQ
q20AoM8nP8z9Y2wjOP2iG396J0MNDASF
=uSrY
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
