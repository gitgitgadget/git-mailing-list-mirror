From: martin f krafft <madduck@madduck.net>
Subject: Re: edit merge commit message
Date: Fri, 11 Apr 2008 20:08:59 +0200
Message-ID: <20080411180815.GA31608@lapse.madduck.net>
References: <20080411171204.GA29738@lapse.madduck.net> <18431.42219.921671.875700@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
To: Bill Lear <rael@zopyra.com>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 11 20:10:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkNhP-0004TH-Ee
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 20:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760700AbYDKSJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 14:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760891AbYDKSJO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 14:09:14 -0400
Received: from clegg.madduck.net ([82.197.162.59]:52925 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760510AbYDKSJM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 14:09:12 -0400
Received: from lapse.madduck.net (130.Red-83-34-247.dynamicIP.rima-tde.net [83.34.247.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id E6989A8523;
	Fri, 11 Apr 2008 20:09:01 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id DB95550FD2; Fri, 11 Apr 2008 20:08:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <18431.42219.921671.875700@lisa.zopyra.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.91.2/6704/Fri Apr 11 15:41:43 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79283>


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bill Lear <rael@zopyra.com> [2008.04.11.1950 +0200]:
> >I see there is an -m option but no --edit or the like. It would also
> >make sense to have a config option for this to turn on spawning the
> >editor by default, I think...
>=20
> % git commit --ammend

And git-merge --no-commit, but those both require multiple command
invocations.

I am sorry, I should have mentioned that --no-commit and --no-amend
are not what I want.

I just want git-merge --edit and then an editor spawns to let me
edit the commit message right away...

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"nothing can cure the soul but the senses,
 just as nothing can cure the senses but the soul."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH/6k7IgvIgzMMSnURAnzoAKCxn45fKJxOO9W1t/UOkNYq5olDpQCfamo5
9p2ZLCx7xD6pcLjnR67p1gk=
=vkbt
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
