From: martin f krafft <madduck@madduck.net>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Fri, 12 Sep 2008 19:14:42 +0100
Message-ID: <20080912181442.GA5407@lapse.rw.madduck.net>
References: <20080909231009.GD10544@machine.or.cz> <1221120192.8962.7.camel@heerbeest> <20080912110017.GW10360@machine.or.cz> <1221222433.29747.8.camel@heerbeest> <20080912131530.GZ10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
To: Petr Baudis <pasky@suse.cz>,
	Jan Nieuwenhuizen <janneke-list@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 20:16:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeDBf-0000St-Od
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 20:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbYILSO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 14:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbYILSO7
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 14:14:59 -0400
Received: from clegg.madduck.net ([193.242.105.96]:40769 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbYILSO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 14:14:58 -0400
Received: from lapse.rw.madduck.net (cl-131.zrh-01.ch.sixxs.net [IPv6:2001:41e0:ff00:82::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id CA3EC1D40EE;
	Fri, 12 Sep 2008 20:14:43 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 8D61180BE; Fri, 12 Sep 2008 19:14:42 +0100 (IST)
Content-Disposition: inline
In-Reply-To: <20080912131530.GZ10360@machine.or.cz>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel
	2.6.24-etchnhalf.1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94/8227/Fri Sep 12 13:48:22 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95757>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Petr Baudis <pasky@suse.cz> [2008.09.12.1415 +0100]:
> I'm stopping to see any way how to sanely support dependency
> removal without history rewriting, since we rely on Git for our
> all changes propagation.

I've considered this question a lot before and could not come up
with anything; you cannot undo a merge.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
it may look like i'm just sitting here doing nothing.
but i'm really actively waiting
for all my problems to go away.
=20
spamtraps: madduck.bogus@madduck.net

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjKsZIACgkQIgvIgzMMSnWhaQCePNStwwwWS7MadxfqXesm4w/1
j7wAn0MX2BWK0lpafwystvl6IP7THcGl
=bG0H
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
