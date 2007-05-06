From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sun, 6 May 2007 20:52:59 +0200
Message-ID: <20070506185259.GF30511@admingilde.org>
References: <463BD40C.6080909@gmail.com> <Pine.LNX.4.64.0705050324580.4015@racer.site> <20070505033039.GD16538@spearce.org> <20070505193214.GD30511@admingilde.org> <7vy7k3hvog.fsf@assigned-by-dhcp.cox.net> <20070505211857.GE30511@admingilde.org> <Pine.LNX.4.64.0705060259460.4015@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 06 20:53:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hklr6-00045a-9F
	for gcvg-git@gmane.org; Sun, 06 May 2007 20:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962AbXEFSxD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 14:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754999AbXEFSxD
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 14:53:03 -0400
Received: from mail.admingilde.org ([213.95.32.147]:55635 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962AbXEFSxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 14:53:01 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hklqt-0001Ft-TS; Sun, 06 May 2007 20:52:59 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705060259460.4015@racer.site>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46359>


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, May 06, 2007 at 02:59:55AM +0200, Johannes Schindelin wrote:
> > On Sat, May 05, 2007 at 01:17:35PM -0700, Junio C Hamano wrote:
> > > > we could also introduce "<tree-ish>/<path>" for absolute path entri=
es.
> > >=20
> > > When you name the tree-ish with usual "branch name", where does
> > > the branch name end and pathname start?  What happens when there
> > > is an ambiguity, and how costly to detect such an ambiguity to
> > > begin with?
> >=20
> > well, if you know that it starts with a tree-ish there is no
> > ambiguity [...]
>=20
> Wrong. For example, mw/submodules~10 _is_ a tree-ish (if you have a branc=
h=20
> named "mw/submodules").

so what?

a better argument is that one can have both refs/tags/a and
refs/heads/a/b.

So just forget my suggestion...

--=20
Martin Waitz

--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGPiQLj/Eaxd/oD7IRAu0fAJ9uhcRnlWGJQl8S9oNtbZW4wUhP8gCeNFbY
9L8YEumRA8NmUqMIXpiQHXc=
=yefM
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--
