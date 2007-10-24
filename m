From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add some fancy colors in the test library when terminal supports it.
Date: Wed, 24 Oct 2007 22:28:17 +0200
Message-ID: <20071024202817.GB10900@artemis.corp>
References: <1193256219-24222-1-git-send-email-madcoder@debian.org> <1193256219-24222-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="3uo+9/B/ebqu+fSQ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 24 22:28:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikmq6-0003ey-Pb
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 22:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027AbXJXU2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 16:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756066AbXJXU2U
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 16:28:20 -0400
Received: from pan.madism.org ([88.191.52.104]:46438 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756027AbXJXU2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 16:28:19 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 902E72653A;
	Wed, 24 Oct 2007 22:28:18 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 02B4B31B302; Wed, 24 Oct 2007 22:28:17 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1193256219-24222-2-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62235>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> +default_color=3D0
> +fail_color=3D1    # red
> +pass_color=3D2    # green
> +msg_color=3D3     # brown
> +

  err, sorry, this part is spurious, I wasn't paying attention when I
re-read my patch. It's impressive how many mistakes you catch reading
the same patch 20 minutes later=E2=80=A6

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

iD8DBQBHH6rhvGr7W6HudhwRAvU4AKCNweA8FG9RRW/7nMTYKCOM6DZnvwCfd1JE
glky/p/rrna0roiIAw6pBgM=
=iO7S
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
