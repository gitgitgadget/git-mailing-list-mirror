From: Luciano Miguel Ferreira Rocha <luciano@eurotux.com>
Subject: Re: making docs
Date: Tue, 14 Apr 2009 14:14:24 +0100
Message-ID: <20090414131424.GB16419@bit.office.eurotux.com>
References: <49E4A72D.21604.198A9AD@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Cc: git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 15:23:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltib7-00083Q-Pr
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 15:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647AbZDNNVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 09:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754418AbZDNNVL
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 09:21:11 -0400
Received: from os.eurotux.com ([216.75.63.6]:49985 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753059AbZDNNVK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 09:21:10 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Apr 2009 09:21:10 EDT
Received: (qmail 8240 invoked from network); 14 Apr 2009 13:14:28 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@213.205.93.24)
  by 0 with AES128-SHA encrypted SMTP; 14 Apr 2009 13:14:28 -0000
Content-Disposition: inline
In-Reply-To: <49E4A72D.21604.198A9AD@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116539>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2009 at 03:09:33PM +0200, Ulrich Windl wrote:
> Hi!
>=20
> THis is a change request: When building Git, many systems lack the tools =
to build=20
> the documentation, so the Manual pages (among others) are not built. When=
=20
> installing, several ".txt" files are installed, but when invoking help li=
ke "git=20
> commit --help", git only complains about not finding the manual page.
>=20
> Obvious solutions are:
> 1) Pre-build the documentation (manual pages) with the source archive. If=
 the=20
> sources are used unmodified, the manual pages should be fine
> 2) If nothing better is found when invoking help, display the text files =
with a=20
> pager
>=20
> An alternative to 1) would be a add-on "source" package that contains the=
 pre-
> built documentation. Documentation files should be platform-independent, =
so that=20
> should be fine for almost everyone.
>=20
> Comments?

If using the git repository, there's the man branch with prebuilt man
pages.

There's already the 'add-on "source" package', e.g.
http://www.kernel.org/pub/software/scm/git/git-manpages-1.6.2.3.tar.bz2

Regards,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknkjDAACgkQinSul6a7oB9CsACfS0+87jLNo9l++/8Kf9n+AamT
z0YAnA9WiSMplgD6lTLcbfPHPe7dfH7s
=qokg
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
