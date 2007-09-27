From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git push (mis ?)behavior
Date: Thu, 27 Sep 2007 21:36:32 +0200
Message-ID: <20070927193632.GF12427@artemis.corp>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="R6sEYoIZpp9JErk7";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:36:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IazAA-0003Ch-5G
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352AbXI0Tgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 15:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756524AbXI0Tgf
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:36:35 -0400
Received: from pan.madism.org ([88.191.52.104]:44850 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbXI0Tge (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 15:36:34 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 839D41E9E9;
	Thu, 27 Sep 2007 21:36:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DB8782ACAAF; Thu, 27 Sep 2007 21:36:32 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59321>


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2007 at 07:22:24PM +0000, Junio C Hamano wrote:
> I am not sure if it is sensible to make that the default (and
> introduce --matching option to get the current behaviour) at this
> point in 1.5.X series, but from the general usability point of view, I
> would not object to demote 'matching' to optional and make 'current
> only' the default in 1.6.X or later.

  Sounds like a plan to me.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/AZAvGr7W6HudhwRAnHWAJ9ylRz1nQ6JxFap3jqTFG/tO3nsuQCfdFE7
1mRmK7uxyY9St3x5JOUIVrs=
=uGlo
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
