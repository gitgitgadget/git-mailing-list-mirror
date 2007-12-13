From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/2] parseopt: Add a gitcli(5) man page.
Date: Thu, 13 Dec 2007 14:56:58 +0100
Message-ID: <20071213135658.GA13802@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <20071213102636.GD12398@artemis.madism.org> <20071213102724.GE12398@artemis.madism.org> <A78DF383-1BD5-4AED-9DE8-60B8E96E54B5@wincent.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ibTvN161/egqYuK8";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 14:57:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2oZA-0005J9-1p
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 14:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbXLMN5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 08:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbXLMN5E
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 08:57:04 -0500
Received: from pan.madism.org ([88.191.52.104]:53670 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbXLMN5C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 08:57:02 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6352019737;
	Thu, 13 Dec 2007 14:57:00 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 8F440D5DC; Thu, 13 Dec 2007 14:56:58 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <A78DF383-1BD5-4AED-9DE8-60B8E96E54B5@wincent.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68154>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On jeu, d=C3=A9c 13, 2007 at 11:04:08 +0000, Wincent Colaiuta wrote:
> El 13/12/2007, a las 11:27, Pierre Habouzit escribi=C3=B3:
>=20
> >This page should hold every information about the git ways to parse=20
> >command
> >lines, and best practices to be used for scripting.
>=20
> Some feedback from a native English speaker follows...

  FWIW, like always when it comes to documentation, you're welcome to
send a patch superseding my 2/2. I'm not a good English writer, I won't
be offended at all. I care about the page being here, not about it being
written by me.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYToqvGr7W6HudhwRAuYQAKCAo61Wfp8wTQx+JoASJhnX4r0wzQCcDNQ1
04w3sAtYHt6ANjHxwzzfQwc=
=1TDx
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
