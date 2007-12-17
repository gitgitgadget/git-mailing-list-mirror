From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Have a flag to stop the option parsing at the first argument.
Date: Mon, 17 Dec 2007 17:29:08 +0100
Message-ID: <20071217162907.GC22554@artemis.madism.org>
References: <20071217095014.GF7453@artemis.madism.org> <30351C09-8BED-4D81-ABDD-2E079B4D54D2@wincent.com> <20071217114703.GH7453@artemis.madism.org> <Pine.LNX.4.64.0712171149540.9446@racer.site> <3CF3CEA5-72F1-47D1-ADB9-37F5C2E292A8@wincent.com> <Pine.LNX.4.64.0712171223210.9446@racer.site> <26962818-F702-44D2-BD26-95D74CE21F0D@wincent.com> <Pine.LNX.4.64.0712171253290.9446@racer.site> <223E3B44-92DA-4861-83D6-67E56F70E784@wincent.com> <47669234.7020202@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ALfTUftag+2gvp1h";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 17:32:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Iqa-0003Gr-9o
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 17:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457AbXLQQ3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 11:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbXLQQ3M
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 11:29:12 -0500
Received: from pan.madism.org ([88.191.52.104]:39884 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030AbXLQQ3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 11:29:11 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A7E6930744;
	Mon, 17 Dec 2007 17:29:09 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5821618F74; Mon, 17 Dec 2007 17:29:08 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <47669234.7020202@viscovery.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68576>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 03:13:56PM +0000, Johannes Sixt wrote:
> Wincent Colaiuta schrieb:
> > But leaving -p aside, will you oppose any patches that make it possible
> > for people to write stuff like:
> >=20
> > git init --bare
> >=20
> > Personally, I think this is an obvious usability improvement worth
> > striving for. Given that "git --bare init" will continue to work under
> > what I'm proposing, I really can't see any worthwhile argument against
> > it. Because we're talking about a UI improvement for newcomers at no
> > cost to old timers.
>=20
> Your point. I hate to have to think hard each time whether it's "git --ba=
re
> init" or "git init --bare" and "git clone --bare" or "git --bare clone" a=
nd
> wouldn't mind if I no longer needed to.

Seconded.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZqPTvGr7W6HudhwRAkd8AJwOTbcpQf6xSo1oBLa+siGZ1yLzqgCfTRx/
SukBWfBrmP20IRng5ddZmiM=
=RPWC
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
