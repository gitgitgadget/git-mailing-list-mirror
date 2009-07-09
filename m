From: Luciano Miguel Ferreira Rocha <luciano@eurotux.com>
Subject: Re: default aliases (ci, di, st, co)
Date: Thu, 9 Jul 2009 09:58:37 +0100
Message-ID: <20090709085837.GA12348@bit.office.eurotux.com>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com> <4A55958E.1050401@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Cc: Ondrej Certik <ondrej@certik.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:58:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOpSv-0000Q0-8w
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283AbZGII6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 04:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757191AbZGII6o
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:58:44 -0400
Received: from os.eurotux.com ([216.75.63.6]:60182 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756191AbZGII6n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 04:58:43 -0400
Received: (qmail 17715 invoked from network); 9 Jul 2009 08:58:42 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by 0 with AES128-SHA encrypted SMTP; 9 Jul 2009 08:58:42 -0000
Content-Disposition: inline
In-Reply-To: <4A55958E.1050401@op5.se>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122954>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2009 at 09:00:30AM +0200, Andreas Ericsson wrote:
>  Ondrej Certik wrote:
> > Hi,
> > coming to git from mercurial and svn, here is the alias part of my=20
> > .gitconfig:
> > [alias]
> >     ci =3D commit
> >     di =3D diff --color-words
> >     st =3D status
> >     co =3D checkout
> > And all is fine until I share commands to checkout my branch (for
> > example) with other people, then basically I have to write those
> > commands in full (e.g. commit, checkout, ...), since I cannot assume
> > they have their .gitconfig setup the same way I do. Especially for
> > people who are new to git.
> > What is the view on this in the git community?
>=20
>=20
>  Personally I think "plain" aliases like you use above are evil.
>  git is not svn or mercurial. If you use it like svn you'll be
>  surprised sooner or later and your workflow will feel awkward or
>  just plain wrong. hg and git are very similar, but the fact that
>  hg assumed the svn shorthands implies to me that they've tried
>  to retain a compatibility that does not, in fact, exist.

No, it just means that shorting common commands is useful and common.

>  I have no simple aliases for any of the commands. There's just no reason
>  for them since tab completion works so well.

"Intelligent" bash completion always gets in my way, so I can't use it.

I vote yes.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpVsT0ACgkQinSul6a7oB93tACeKfWbgsnXL4lKnG+UwAKgABqS
4IYAnA+I8XpbFgoZBAPRx1nFGD0J+0vx
=uO3S
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
