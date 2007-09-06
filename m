From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: rebase from ambiguous ref discards changes
Date: Fri, 07 Sep 2007 00:37:21 +0200
Message-ID: <20070906223721.GC26924@artemis.corp>
References: <1189115308.30308.9.camel@koto.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="bAmEntskrkuBymla";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git Mailing List <git@vger.kernel.org>
To: Keith Packard <keithp@keithp.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:37:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITPyc-0003q9-Jk
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 00:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533AbXIFWh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 18:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756606AbXIFWh0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 18:37:26 -0400
Received: from pan.madism.org ([88.191.52.104]:54197 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754294AbXIFWhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 18:37:25 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id EDA451E575;
	Fri,  7 Sep 2007 00:37:22 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 029F63033; Fri,  7 Sep 2007 00:37:21 +0200 (CEST)
Mail-Followup-To: Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1189115308.30308.9.camel@koto.keithp.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57939>


--bAmEntskrkuBymla
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2007 at 09:48:28PM +0000, Keith Packard wrote:
> recovering my patch (having the ID in my terminal window from the
> commit), I named it 'master-with-fix'

  Note that your patch was not lost, even if you had pruned, because it
would still be accessible from the reflog of your master branch. Not
that it's supposed to soften your disappointment but well, at least it
should make you a bit less uncomfortable, maybe :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--bAmEntskrkuBymla
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4IEhvGr7W6HudhwRApceAJ9ehFwIHoqJpkW1M/VK0qmhyGw6mwCgjgSE
H4rEW7+6XMroii92iE/KDLg=
=haMA
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
