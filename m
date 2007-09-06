From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 3/9] Add strbuf_printf() to do formatted printing to a strbuf.
Date: Thu, 06 Sep 2007 11:50:16 +0200
Message-ID: <20070906095016.GD8451@artemis.corp>
References: <11890382183913-git-send-email-krh@redhat.com> <11890382242333-git-send-email-krh@redhat.com> <11890382243290-git-send-email-krh@redhat.com> <7vwsv4b2bl.fsf@gitster.siamese.dyndns.org> <20070906094323.GB8451@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="DrWhICOqskFTAXiy";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 11:50:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITE0H-0001JE-Fo
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 11:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbXIFJuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 05:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755775AbXIFJuT
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 05:50:19 -0400
Received: from pan.madism.org ([88.191.52.104]:34971 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755608AbXIFJuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 05:50:17 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 908B81E3DB;
	Thu,  6 Sep 2007 11:50:16 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4A97C1A3CA; Thu,  6 Sep 2007 11:50:16 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070906094323.GB8451@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57852>


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2007 at 09:43:23AM +0000, Pierre Habouzit wrote:
> On Thu, Sep 06, 2007 at 08:55:26AM +0000, Junio C Hamano wrote:
> > As you noted in your follow-up message, this one has overlaps
> > with the other strbuf series.  I could adjust them if I wanted
> > to, but I do not have time for it right now.  I might try over
> > the weekend but no promises.
>=20
>   This one is exactly the same as the one that follows, I corrected a
> typo in the comment of the commit, and I forgot to cleanse my tree
> before running format-patch again, so you have the "second" patch twice
> (name of the patch changed, hence the new one did not replaced the
> previous, but created a 0002-foo.patch instead of overwriting the
> 0002-bar.patch).
>=20
>   You just must drop the one I followup-ed to.

  err sorry, I mixed up with another thread. Did not had coffee yet :/

  Just nvm


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG381YvGr7W6HudhwRAorsAKCKnHC7+E2KFrypuF46ZgX1FIAHrwCgmB7T
CLUJhj8ZjMGcVEK8e0Y6rEA=
=5iw1
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
