From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 07/10] git-fmt-merge-msg: make it useable from other
	builtins
Date: Sat, 7 Jun 2008 03:04:59 +0200
Message-ID: <20080607010459.GA29404@genesis.frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org> <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org> <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org> <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org> <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org> <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org> <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org> <7vd4mvzdbz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MSb6yok4K6y1+pfR"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 03:06:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4msk-0000IW-DZ
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 03:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbYFGBFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 21:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753949AbYFGBFE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 21:05:04 -0400
Received: from virgo.iok.hu ([193.202.89.103]:43893 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871AbYFGBFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 21:05:01 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 603C91B2532;
	Sat,  7 Jun 2008 03:05:00 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5F347446A5;
	Sat,  7 Jun 2008 02:47:09 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BF4451190ACA; Sat,  7 Jun 2008 03:04:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4mvzdbz.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84162>


--MSb6yok4K6y1+pfR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2008 at 04:12:00PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> The word in the title should be "usable" (s/sea/sa/).
>=20
> Other than that, looks like a quite straightforward conversion.

OK, I fixed up the patch title in git://repo.or.cz/git/vmiklos.git.

--MSb6yok4K6y1+pfR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhJ3rsACgkQe81tAgORUJZkgwCcCnNXa8ifoqOl24A0z1nbPKnc
xlYAn07EqjHtcP7mvZvtYJ+8B5MFDhF1
=gRur
-----END PGP SIGNATURE-----

--MSb6yok4K6y1+pfR--
