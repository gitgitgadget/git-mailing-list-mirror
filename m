From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: 1.5.4-rc2 plans
Date: Sat, 22 Dec 2007 18:38:49 +0100
Message-ID: <20071222173849.GC23262@artemis.madism.org>
References: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org> <20071222170315.GB23262@artemis.madism.org> <7vir2qy7ie.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="rQ2U398070+RC21q";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 18:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J68Jp-0004RC-DO
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 18:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbXLVRi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 12:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbXLVRi6
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 12:38:58 -0500
Received: from pan.madism.org ([88.191.52.104]:52368 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbXLVRi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 12:38:57 -0500
Received: from madism.org (unknown [62.147.220.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3445C1BD17;
	Sat, 22 Dec 2007 18:38:57 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id D078314AFBE; Sat, 22 Dec 2007 18:38:49 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vir2qy7ie.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69147>


--rQ2U398070+RC21q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 22, 2007 at 05:16:41PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   So I'd argue in favor of that:
> >   + push the patch that forces the stuck forms (that I already posted)
> >     for 1.5.4.
>=20
> Ok, sounds sane.  You posted multiple serieses; which ones?

All the patches I think should go in 1.5.4 are in that very thread.
Forcing the stuck forms for optional arguments is in
Message-Id: <20071221104704.GC17701@artemis.madism.org>, or is on
git.madism.org in branch ph/parseopt.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--rQ2U398070+RC21q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHbUupvGr7W6HudhwRAipJAJ4ubl6hc2OUHsD2wA9b2KQNJlY+MQCgjjTt
Qxo6tPstjpqq6dUvu28ACHA=
=+GzJ
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
