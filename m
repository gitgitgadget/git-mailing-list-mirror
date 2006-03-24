From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Fri, 24 Mar 2006 08:52:29 +0100
Message-ID: <20060324075229.GH31387@lug-owl.de>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org> <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <Pine.LNX.4.64.0603221717120.26286@g5.osdl.org> <20060323200306.GG31387@lug-owl.de> <20060324003944.GA28652@pe.Belkin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 08:52:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMh64-0003Vv-4O
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 08:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422750AbWCXHwc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 02:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422756AbWCXHwc
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 02:52:32 -0500
Received: from lug-owl.de ([195.71.106.12]:24801 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1422750AbWCXHwb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 02:52:31 -0500
Received: by lug-owl.de (Postfix, from userid 1001)
	id DF5F1F0042; Fri, 24 Mar 2006 08:52:29 +0100 (CET)
To: Chris Shoemaker <c.shoemaker@cox.net>
Content-Disposition: inline
In-Reply-To: <20060324003944.GA28652@pe.Belkin>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17902>


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-23 19:39:44 -0500, Chris Shoemaker <c.shoemaker@cox.net> wr=
ote:
> On Thu, Mar 23, 2006 at 09:03:06PM +0100, Jan-Benedict Glaw wrote:
> > On Wed, 2006-03-22 17:28:23 -0800, Linus Torvalds <torvalds@osdl.org> w=
rote:
> > It seems there's a patch like
> > http://www.gelato.unsw.edu.au/archives/git/0602/16278.html is missing?
> > ...or we need a better cvsps.  Shall I add it and try again / try to
> > continue, or give up on it for now?  Though it would be nice to have
> > these two large and important source trees under GIT control :-)
>=20
> You make want to try the cvsps patch I attached to the email here:
>=20
> http://www.gelato.unsw.edu.au/archives/git/0511/11812.html

[...]
cvs rlog: Logging src/winsup/w32api/include/ddk
cvs rlog: Logging src/winsup/w32api/include/directx
cvs rlog: Logging src/winsup/w32api/lib
cvs rlog: Logging src/winsup/w32api/lib/ddk
cvs rlog: Logging src/winsup/w32api/lib/directx
invalid initial_branch for file bfd/po/BLD-POTFILES.in, probably from old c=
ache, run with -x.
DONE; creating master branch
fatal: refs/heads/origin: not a valid SHA1
fatal: master: not a valid SHA1
fatal: 'HEAD': No such file or directory
usage: git-read-tree (<sha> | -m [--aggressive] [-u | -i] <sha1> [<sha2> [<=
sha3>]])
checkout failed: 256


So it fails pretty early this time :)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEI6U9Hb1edYOZ4bsRAn/yAJ47IDvsWd4ILZggP27ACXSg2yBXDQCggWQu
MwfjmFJr5V+qKo1qN+Axvaw=
=mqR5
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
