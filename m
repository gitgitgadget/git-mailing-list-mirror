From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/2] Make builtin-rerere use of strbuf nicer and more efficient.
Date: Wed, 26 Sep 2007 10:41:16 +0200
Message-ID: <20070926084116.GA11479@artemis.corp>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org> <1190625904-22808-2-git-send-email-madcoder@debian.org> <1190625904-22808-3-git-send-email-madcoder@debian.org> <7v3ax22rnw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ZGiS0Q5IWpPtfppv";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 10:41:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaSSW-0004CY-9c
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 10:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbXIZIlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 04:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbXIZIlU
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 04:41:20 -0400
Received: from pan.madism.org ([88.191.52.104]:58312 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbXIZIlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 04:41:19 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id CB88921A40;
	Wed, 26 Sep 2007 10:41:17 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A3021433; Wed, 26 Sep 2007 10:41:16 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3ax22rnw.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59218>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On mer, sep 26, 2007 at 12:31:47 +0000, Junio C Hamano wrote:
> Signoffs?

  This is obviously a lapse on my end.  You can add:

Signed-off-by: Pierre Habouzit <madcoder@debian.org>

  To any patch I send to this list.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG+hssvGr7W6HudhwRAimwAJ4hMRtdyGG8Vu1SJkhcl+/3cOvS+wCeJcKN
Y8vU9V/2TiBVSww5JRQ5iy0=
=vqF8
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
