From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Fri, 30 Nov 2007 19:34:14 +0100
Message-ID: <20071130183414.GD30048@efreet.light.src>
References: <200711282339.59938.jnareb@gmail.com> <200711290326.13822.jnareb@gmail.com> <20071129200710.GA3314@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 19:34:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyAhG-0005ay-4i
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 19:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760414AbXK3SeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 13:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760614AbXK3SeW
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 13:34:22 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:55451 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674AbXK3SeV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 13:34:21 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id B311957900;
	Fri, 30 Nov 2007 19:34:19 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 1ttBeVvWBT-o; Fri, 30 Nov 2007 19:34:17 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 7559C57608;
	Fri, 30 Nov 2007 19:34:16 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IyAgo-0003X9-R1; Fri, 30 Nov 2007 19:34:14 +0100
Content-Disposition: inline
In-Reply-To: <20071129200710.GA3314@steel.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66655>


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2007 at 21:07:10 +0100, Alex Riesen wrote:
> Jakub Narebski, Thu, Nov 29, 2007 03:26:12 +0100:
> > +                <s id=3D"git">
> > +                    Medium. There's Git User's Manual, manpages, some
> > +                    technical documentation and some howtos.  All
> > +                    documentation is also available online in HTML for=
mat;
> > +                    there is additional information (including beginni=
ngs
> > +                    of FAQ) on git wiki.
> > +                    Nevertheles one of complaints in surveys is insuff=
icient
>=20
> "Nevertheless" (two "s").

I think it's not amount of documentation that's insufficient, but rather the
organization. The problem is not that the information is not there, but that
it's sometimes not easy to find.

> BTW, I wouldn't call the level of documentation "Medium" when compared
> to any commercial SCM. How can they earn more than "a little", when
> compared to any opensource program?

I don't know that many commercial SCM, but clearcase does have more than "a
little" documentation.

> [...]
>
> > @@ -1106,6 +1165,10 @@ TODO:
> >                      There exists some HTTP-functionality, but it is qu=
ite
> >                      limited.
> >                  </s>
> > +                <s id=3D"git">
> > +                    Good.  Uses HTTPS (with WebDAV) or ssh for push,
> > +                    HTTP, FTP, ssh or custom protocol for fetch.
> > +                </s>
>=20
> You forgot bundles (aka SneakerNet).
> Again, compared to everyone else it is "vastly superior" :)

In fact at least darcs and bzr can also do SneakerNet.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHUFemRel1vVwhjGURAkGmAKDuwS+xXo1AcaFLnK+XSQb04f/PMACeKJid
1CnT7fDXoW6xxGo1UO5++G0=
=keph
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
