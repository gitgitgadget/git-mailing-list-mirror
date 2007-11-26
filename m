From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] best way to show diff of commit
Date: Mon, 26 Nov 2007 09:47:31 +0100
Message-ID: <20071126084731.GB23373@artemis.corp>
References: <20071125211831.GA21121@artemis.corp> <20071126002519.GA11133@efreet.light.src>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="BwCQnh7xodEAoBMC";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Nov 26 09:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwZdT-0007F5-KL
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 09:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbXKZIrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 03:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbXKZIrd
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 03:47:33 -0500
Received: from pan.madism.org ([88.191.52.104]:40304 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753777AbXKZIrc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 03:47:32 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 97189EE;
	Mon, 26 Nov 2007 09:47:31 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 407CD48BD32; Mon, 26 Nov 2007 09:47:31 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jan Hudec <bulb@ucw.cz>, Git ML <git@vger.kernel.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
Content-Disposition: inline
In-Reply-To: <20071126002519.GA11133@efreet.light.src>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66055>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2007 at 12:25:19AM +0000, Jan Hudec wrote:
> Hm, looking at the builtin-commit.c that is currently cooking in next, it
> does not seem to be the case there. It probably should, so the editor can
> inspect what will be commited.

  I confirm that it's broken now, but that it works at the top of main.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHSogjvGr7W6HudhwRAhbYAJ9mZqXDjh1eAE7Om9ZlwpvdK+vpRQCfXuO7
2kIzQvsQe13gf8XMXKhoVts=
=CGtC
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
