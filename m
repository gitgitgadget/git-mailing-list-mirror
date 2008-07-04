From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [Junio C Hamano] Re: Consolidate SHA1 object file close
Date: Fri, 04 Jul 2008 19:44:57 +0200
Message-ID: <20080704174457.GA7955@artemis.madism.org>
References: <7viqwbfxk6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="FCuugMFkClbJLl1L";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 19:46:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEpM7-0008Lk-Sl
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 19:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbYGDRpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 13:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbYGDRpB
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 13:45:01 -0400
Received: from pan.madism.org ([88.191.52.104]:51020 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbYGDRpA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 13:45:00 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 2BD9912116;
	Fri,  4 Jul 2008 19:44:58 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6FE4C31F3; Fri,  4 Jul 2008 19:44:57 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7viqwbfxk6.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87404>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2008 at 10:42:33PM +0000, Junio C Hamano wrote:
> Somehow the thread went off-list, so I'm diverting it back to the list...
>=20

  FWIW, the person with that patch here do not have the issue with NFS
at all, whereas people with older git versions have had the issue. IOW,
I consider my issue with NFS fixed by this patch.

  Thanks a lot guys \o/

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhuYZcACgkQvGr7W6HudhyIdgCcCK8RIkHAlrYLrzzXaXa7Ny0c
zW0AniojiVaurDBit3SJeEaZ6joCxCkp
=pXKg
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
