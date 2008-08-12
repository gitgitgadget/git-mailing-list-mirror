From: martin f krafft <madduck@madduck.net>
Subject: Re: TopGit: problem with patch series generation
Date: Tue, 12 Aug 2008 20:07:27 -0300
Message-ID: <20080812230727.GB16481@lapse.rw.madduck.net>
References: <20080812161854.GB30067@lapse.rw.madduck.net>
	<20080812173257.GK10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6514446152805932296=="
To: Petr Baudis <pasky@suse.cz>, git discussion list <git@vger.kernel.org>,
	Manoj Srivastava <srivasta@debian.org>,
	vcs distro packaging discussion list
	<vcs-pkg-discuss@lists.alioth.debian.org>
X-From: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org Wed Aug 13 01:11:17 2008
Return-path: <vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org>
Envelope-to: gcpv-vcs-pkg-discuss@m.gmane.org
Received: from alioth.debian.org ([217.196.43.134])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT31H-0000bm-T7
	for gcpv-vcs-pkg-discuss@m.gmane.org; Wed, 13 Aug 2008 01:11:15 +0200
Received: from localhost
	([127.0.0.1] helo=alioth.debian.org ident=list)
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org>)
	id 1KT30M-0000y0-0T
	for gcpv-vcs-pkg-discuss@m.gmane.org; Tue, 12 Aug 2008 23:10:18 +0000
Received: from seamus.madduck.net ([213.203.238.82])
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <madduck@lapse.rw.madduck.net>) id 1KT30D-0000o8-Da
	for vcs-pkg-discuss@lists.alioth.debian.org;
	Tue, 12 Aug 2008 23:10:14 +0000
Received: from lapse.rw.madduck.net (unknown [209.13.181.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net",
	Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id 34D47440AB5;
	Wed, 13 Aug 2008 01:09:53 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 04EE680B6; Tue, 12 Aug 2008 20:07:27 -0300 (ART)
In-Reply-To: <20080812173257.GK10151@machine.or.cz>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel
	2.6.24-etchnhalf.1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.93.1/8021/Tue Aug 12 21:27:39 2008 on
	seamus.madduck.net
X-Virus-Status: Clean
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on alioth.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.2.3
X-BeenThere: vcs-pkg-discuss@lists.alioth.debian.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: Discussions on using VCS for distro packaging
	<vcs-pkg-discuss.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/vcs-pkg-discuss>
List-Post: <mailto:vcs-pkg-discuss@lists.alioth.debian.org>
List-Help: <mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=subscribe>
Mime-version: 1.0
Sender: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
Errors-To: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Scanned: No (on alioth.debian.org); SAEximRunCond expanded to false
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92152>


--===============6514446152805932296==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Petr Baudis <pasky@suse.cz> [2008.08.12.1432 -0300]:
> I'm not really happy about this idea, though. It would complicate
> TopGit even much more than it is now, and I'm not sure if this is
> worth it instead of just requiring you to maintain your
> dependencies more carefully when you intend to serialize your
> series later.

Sure, but there are no dependencies between some of these branches.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"i worked myself up from nothing to a state of extreme poverty."
                                                       -- groucho marx
=20
spamtraps: madduck.bogus@madduck.net

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiiF68ACgkQIgvIgzMMSnVO6QCgv+lvKByqfriaitq7gCz8eYvw
oVIAnA53ZYmy6LMAUPIvJZ6y3wFzanrd
=GUEC
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--


--===============6514446152805932296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
