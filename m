From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 08 Nov 2007 12:38:38 +0100
Message-ID: <20071108113838.GD23807@artemis.corp>
References: <20071022061115.GR14735@spearce.org> <7vodeecyni.fsf@gitster.siamese.dyndns.org> <7vpryqwtt7.fsf@gitster.siamese.dyndns.org> <7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="11Y7aswkeuHtSBEs";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 12:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq5iq-0005ld-Dk
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 12:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759127AbXKHLil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 06:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758986AbXKHLik
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 06:38:40 -0500
Received: from pan.madism.org ([88.191.52.104]:56320 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757727AbXKHLik (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 06:38:40 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2626C27AB0;
	Thu,  8 Nov 2007 12:38:38 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 86C791AB72; Thu,  8 Nov 2007 12:38:38 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63998>


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2007 at 08:06:14AM +0000, Junio C Hamano wrote:
> On 'master' front:
>=20
>  - git-p4 in contrib/ has updates.  As I cannot test it myself
>    and did not hear any success/failure stories from the list,
>    the only way to make sure is to push it out and see if
>    anybody screams.
>=20
>  - "git lost-found" is going to be deprecated (not removed) in
>    the next feature release.
>=20
>  - Unspecified clean.requireForce defaults to true; this would
>    make "git clean" require "-f" by default.
>=20
>  - "git send-email --suppress-from" does not CC yourself even
>    when your name is on S-o-b: or Cc: lines in the body of the
>    message.
>=20
> ----------------------------------------------------------------
>=20
> * The 'maint' branch has these fixes since the last announcement.
[...]
> Pierre Habouzit (1):
>   Some better parse-options documentation.

  Eeeer isn't there some kind of problem ? This is not in maint, I
believe you swapped 'master' and 'maint' :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMvU+vGr7W6HudhwRAshnAJ9wMVs/dnIEZ6mS1dbUG8E1YSokcACcCGuv
VcXMvTCAgbSdRHznG4GUzFg=
=asi4
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
