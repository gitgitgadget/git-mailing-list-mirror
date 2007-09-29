From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/4] Rework progress module so that it uses less screen  lines, with progress bars.
Date: Sat, 29 Sep 2007 18:07:33 +0200
Message-ID: <20070929160733.GE32142@artemis.corp>
References: <1191062758-30631-1-git-send-email-madcoder@debian.org> <1191062758-30631-2-git-send-email-madcoder@debian.org> <alpine.LFD.0.9999.0709291030010.17881@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/unnNtmY43mpUSKx";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 18:07:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iber2-0008Se-U2
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 18:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864AbXI2QHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 12:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755220AbXI2QHh
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 12:07:37 -0400
Received: from pan.madism.org ([88.191.52.104]:38949 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753842AbXI2QHg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 12:07:36 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 098B4226B4;
	Sat, 29 Sep 2007 18:07:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6B94E2D1BCD; Sat, 29 Sep 2007 18:07:33 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0709291030010.17881@xanadu.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59476>


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 29, 2007 at 02:33:44PM +0000, Nicolas Pitre wrote:
> On Sat, 29 Sep 2007, Pierre Habouzit wrote:
>=20
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
>=20
> NAK.
>=20
> I don't mind the progress bar, but please don't supress the printing of=
=20
> the number of objects.  This is the only indication we have to=20
> guesstimate the time needed for given operation.

  As said, I don't intend this series to be integrated as is, it's just
a basis for some discussion :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/nhFvGr7W6HudhwRApP1AJ96GDW+oKc+DiJsQPIyPi52Cnji+QCgh5Hz
pQSizlEa+ax5o/+AbTp8GhM=
=ODFG
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
