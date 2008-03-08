From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Idea for Git Bugtracking Tool
Date: Sat, 08 Mar 2008 16:02:19 +0100
Message-ID: <20080308150219.GA8536@artemis.madism.org>
References: <20080306142246.5d9460b7@gmail.com> <m3zltaf7vs.fsf@localhost.localdomain> <20080308134210.GA3230@artemis.madism.org> <200803081523.14340.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="cNdxnHkX5QqsyA0e";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 16:03:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY0Zg-0007P0-3E
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 16:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbYCHPCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 10:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbYCHPCW
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 10:02:22 -0500
Received: from pan.madism.org ([88.191.52.104]:47375 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbYCHPCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 10:02:21 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8F6ED326C2;
	Sat,  8 Mar 2008 16:02:20 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 93A2E2BCDC1; Sat,  8 Mar 2008 16:02:19 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200803081523.14340.jnareb@gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76565>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08, 2008 at 02:23:13PM +0000, Jakub Narebski wrote:
> Dnia sobota 8. marca 2008 14:42, Pierre Habouzit napisa=C5=82:
> > On Fri, Mar 07, 2008 at 11:10:18PM +0000, Jakub Narebski wrote:
> >> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> >>=20
> >>> Thomas Harning <harningt@gmail.com> writes:
> >>>=20
> >>>> Any ideas/flaws with this concept?  Anybody up for taking on this
> >>>> project... or for taking this up as a GSOC project mentor?
> >>>=20
> >>> Already discussed here:
> >>>=20
> >>> http://thread.gmane.org/gmane.comp.version-control.git/48981/
> >>>=20
> >>> Pierre Habouzit started working on something called grit, which
> >>> seems to be dead.
> >>=20
> >> Pierre, what happened to git://git.madism.org/grit.git ?
> >=20
> >   it was very badly coded, and not going in the proper direction.
>=20
> Should it be then removed from InterfacesFrontendsAndTools wiki page
> (perhaps putting "Bugs Everywhere", with Git as one of supported version
> control backends in its place)?

  Oh I didn't remembered it was there, yes it should be removed.

> > We discussed design with Dscho a couple of time, I know how to build
> > such a tool in git (at least a bit how) but I never found the time.
>=20
> Care to share those thoughts, and what mistakes were made?

  I'll try to post a summary of the design/thoughts we had back then at
some point, I don't have the time _right now_ though. I'll keep you
posted.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH0qp7vGr7W6HudhwRAgDBAJ0al61ZfLhuNmSTW6DcY8olOTuSTgCfb4Ei
TNELxOrMOvJldUPP/DZ4h6k=
=QRX8
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
