From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] best way to show diff of commit
Date: Sun, 25 Nov 2007 23:31:50 +0100
Message-ID: <20071125223150.GD21121@artemis.corp>
References: <20071125211831.GA21121@artemis.corp> <20071125212748.GB23820@fieldses.org> <20071125220902.GB21121@artemis.corp> <7vfxyuj70i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="HWvPVVuAAfuRc6SZ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 23:32:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwQ1P-0008SG-1F
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 23:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539AbXKYWb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 17:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756369AbXKYWb4
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 17:31:56 -0500
Received: from pan.madism.org ([88.191.52.104]:41566 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbXKYWb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 17:31:56 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2E0182C2F7;
	Sun, 25 Nov 2007 23:31:55 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 1556B490B7F; Sun, 25 Nov 2007 23:31:50 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vfxyuj70i.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66021>


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2007 at 10:27:09PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   Hmm it doesn't because I would have to call git commit -v each time I
> > commit and well I _like_ having the status better. And moreover I want
> > the diff to go in a separated buffer too.
>=20
> I've never felt it a problem while editing the log message in Emacs.
>=20
> Don't enhanced vi implementations let you split the same buffer into
> two allowing you to view different portions of it these days?

  Well, maybe I could write my plugin so that it cuts the diff out from
the main buffer indeed, though I will have to learn using git commit -v
instead of git commit :P

  That and the fact that the syntax colorization of the diff doesn't
work, but it's probably not up to git to fix that.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHSffWvGr7W6HudhwRAigDAJ91TKFog/etZOCONxX9GdJafEpQSgCggOOW
cwBYoZdIODrmGtxBRXDfNYk=
=aJp5
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
