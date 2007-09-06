From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 3/9] Add strbuf_printf() to do formatted printing to a strbuf.
Date: Thu, 06 Sep 2007 11:43:23 +0200
Message-ID: <20070906094323.GB8451@artemis.corp>
References: <11890382183913-git-send-email-krh@redhat.com> <11890382242333-git-send-email-krh@redhat.com> <11890382243290-git-send-email-krh@redhat.com> <7vwsv4b2bl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="rJwd6BRFiFCcLxzm";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 11:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITDu8-000802-I8
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 11:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756405AbXIFJn1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 05:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755402AbXIFJn1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 05:43:27 -0400
Received: from pan.madism.org ([88.191.52.104]:44651 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755203AbXIFJn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 05:43:26 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7A822173DD;
	Thu,  6 Sep 2007 11:43:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 339EB1A3BA; Thu,  6 Sep 2007 11:43:23 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwsv4b2bl.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57850>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2007 at 08:55:26AM +0000, Junio C Hamano wrote:
> As you noted in your follow-up message, this one has overlaps
> with the other strbuf series.  I could adjust them if I wanted
> to, but I do not have time for it right now.  I might try over
> the weekend but no promises.

  This one is exactly the same as the one that follows, I corrected a
typo in the comment of the commit, and I forgot to cleanse my tree
before running format-patch again, so you have the "second" patch twice
(name of the patch changed, hence the new one did not replaced the
previous, but created a 0002-foo.patch instead of overwriting the
0002-bar.patch).

  You just must drop the one I followup-ed to.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG38u7vGr7W6HudhwRAph4AJ0SVRSKB+/Yil1g6OzQagKJZ3shmQCfUlxV
rPgZX9VJRFgEVlgzGSni+qQ=
=Q68e
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
