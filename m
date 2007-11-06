From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in  git, help users out.
Date: Tue, 06 Nov 2007 20:39:59 +0100
Message-ID: <20071106193959.GB4382@artemis.corp>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com> <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711052325090.4362@racer.site> <7vsl3kjdct.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711060317220.4362@racer.site> <7vode8j7o5.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711061230540.4362@racer.site> <7v8x5bi703.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711061827030.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="3uo+9/B/ebqu+fSQ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 20:40:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUHY-0005zm-3l
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 20:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbXKFTkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 14:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbXKFTkB
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 14:40:01 -0500
Received: from pan.madism.org ([88.191.52.104]:34949 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348AbXKFTkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 14:40:00 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BC6D326487;
	Tue,  6 Nov 2007 20:39:59 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5F108F9C4; Tue,  6 Nov 2007 20:39:59 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711061827030.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63707>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2007 at 06:27:54PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 6 Nov 2007, Junio C Hamano wrote:
>=20
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >=20
> > > Well, I think that _if_ we allow "git revert <path>" to mean "revert =
the=20
> > > changes to <path>, relative to the index" (which would be the same as=
 "git=20
> > > checkout <path>"), then committing that change just does not make sen=
se.
> > >
> > > And it is this behaviour that people are seeking, not "git revert <co=
mmit>=20
> > > <path>".
> >=20
> > Heh, I found this in the recent log somewhere.
> >=20
> > <gitte> Really, I wonder how difficult git is for people who are not
> > 	brainwashed by cvs/svn, and unfortunately enough, partly by bzr and hg.
> > <gitte> From a user perspective, you might be correct.  But then we hav=
e to
> > 	add 1000 commands to reflect the English language.
> > <gitte> Not what I want.						[06:46]
> >=20
> > I am wondering who said it ;-).
>=20
> Now, that is not fair, using my own words against me ;-)

  That's very funny actually :]

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMMMPvGr7W6HudhwRAtCOAJ9Bi3wqk8RPqLXUbp4AW8CUkS2GHwCfep1a
IFz24AE3Bdu+oQoV01UgLkc=
=rFbV
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
