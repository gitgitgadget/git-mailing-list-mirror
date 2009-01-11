From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and  --prune-empty.
Date: Sun, 11 Jan 2009 15:27:32 +0100
Message-ID: <20090111142732.GA18484@artemis.corp>
References: <20081030132623.GC24098@artemis.corp> <1225445204-28000-1-git-send-email-madcoder@debian.org> <7viqr5wgl7.fsf@gitster.siamese.dyndns.org> <20081103092729.GE13930@artemis.corp> <20081103151826.GJ13930@artemis.corp> <76718490901091129q534ca981iac54e0653d76170d@mail.gmail.com> <20090111111800.GA8032@artemis.corp> <alpine.DEB.1.00.0901111433580.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="a8Wt8u1KmwUX3Y2C";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pasky@suse.cz, srabbelier@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 11 15:30:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM1Ku-0003rB-FA
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 15:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbZAKO1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 09:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbZAKO1g
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 09:27:36 -0500
Received: from pan.madism.org ([88.191.52.104]:45961 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbZAKO1g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 09:27:36 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id BB12B3C4D9;
	Sun, 11 Jan 2009 15:27:33 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 9AC6B2B100; Sun, 11 Jan 2009 15:27:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901111433580.3586@pacific.mpi-cbg.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105182>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2009 at 01:35:15PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Sun, 11 Jan 2009, Pierre Habouzit wrote:
>=20
> > On Fri, Jan 09, 2009 at 07:29:15PM +0000, Jay Soffian wrote:
> > > On Mon, Nov 3, 2008 at 10:18 AM, Pierre Habouzit <madcoder@debian.org=
> wrote:
> > > > On Mon, Nov 03, 2008 at 09:27:29AM +0000, Pierre Habouzit wrote:
> > > >> On Mon, Nov 03, 2008 at 04:58:44AM +0000, Junio C Hamano wrote:
> > >=20
> > > Bump, http://thread.gmane.org/gmane.comp.version-control.git/99440/
> > >=20
> > > (I'd like to see this included. Having a bunch of empty commits after
> > > using filter-branch to remove unwanted files from history is, er,
> > > sub-optimal, so seems like it might even be default behavior?)
> >=20
> > Yeah I have that in my own git tree, and I meant to ask if something ha=
d=20
> > to be fixed for it to be accepted for some time, but always forget abou=
t=20
> > it.
> >=20
> > Junio, do you think this could be accepted, or does it need some work ?
>=20
> AFAICT Junio had some style issues which were not addressed.

Huh, I did in a latter resend in that very thread.

> And I suggested to merge the tests with Sverre's patch.  That suggestion=
=20
> also went unaddressed.

I can't find any mails from Sverre in the same thread, but maybe I'm not
searching in the proper place...

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklqAdQACgkQvGr7W6HudhxrAwCffYm+ZYfb7xPiYUMPigxyNlyk
zvUAoJxZXisKeBR1WfjFotZiI3RmffxC
=qeYD
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
