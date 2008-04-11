From: martin f krafft <madduck@madduck.net>
Subject: edit merge commit message
Date: Fri, 11 Apr 2008 19:12:04 +0200
Message-ID: <20080411171204.GA29738@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 11 19:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkNJx-0002ey-Do
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 19:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760291AbYDKRpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 13:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760287AbYDKRpI
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 13:45:08 -0400
Received: from clegg.madduck.net ([82.197.162.59]:60688 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760281AbYDKRpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 13:45:07 -0400
X-Greylist: delayed 1975 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Apr 2008 13:45:06 EDT
Received: from lapse.madduck.net (130.Red-83-34-247.dynamicIP.rima-tde.net [83.34.247.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 5AAA7A8032
	for <git@vger.kernel.org>; Fri, 11 Apr 2008 19:12:05 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 37B8350FD2; Fri, 11 Apr 2008 19:12:04 +0200 (CEST)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79280>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks

Is there any way to edit the message of a merge prior to the commit?
I see there is an -m option but no --edit or the like. It would also
make sense to have a config option for this to turn on spawning the
editor by default, I think...

If there is none, I am willing to take a stab at it. Unless you tell
me that this will have no chance to go upstream.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
a gourmet concerned about calories
is like a punter eyeing the clock.
=20
spamtraps: madduck.bogus@madduck.net

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH/5vkIgvIgzMMSnURAsuiAJ4zAGCwa4ab3VJ+QL/3IZphatdPkgCfYVaL
1U0WBSBZcWDP78j+Z/fxLwU=
=MUji
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
