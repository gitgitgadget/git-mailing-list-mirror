From: Pierre Habouzit <madcoder@artemis.madism.org>
Subject: Re: 1.5.4-rc2 plans
Date: Fri, 21 Dec 2007 12:13:56 +0100
Message-ID: <20071221111356.GA25953@artemis.madism.org>
References: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org> <20071221104704.GC17701@artemis.madism.org> <7vk5n8b92w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="azLHFNyN32YCQGCU";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 12:14:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5fpe-0000Bo-SF
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 12:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbXLULN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 06:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754667AbXLULN6
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 06:13:58 -0500
Received: from pan.madism.org ([88.191.52.104]:58000 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754162AbXLULN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 06:13:57 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E0F051E04C;
	Fri, 21 Dec 2007 12:13:56 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3A19D349A26; Fri, 21 Dec 2007 12:13:56 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@artemis.madism.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vk5n8b92w.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69059>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2007 at 11:06:47AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@artemis.madism.org> writes:
>=20
> > Hmm now I'm confused, I believed we settled for the: --abbrev 10 HEAD is
> > forbidden, --abbrev=3D10 HEAD works, and --abbrev HEAD too.
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/68121/focus=3D6865=
9 ?

  okay, then it's what I remembered, I was confused because the patch
for that was around for quite some time, but I just resent it so this
one is okay.

> > I'd also like to see any kind of form of gitcli(5) be merged for 1.5.4
> > too, I believe the first version I ever sent. In the thread where I
> > posted the proposal using `{}` the patch introducing it is the version
> > formed using:
>=20
> Unfortunately I've been busy lately and have already discarded
> the whole series that had the {} stuff.  Could you resend
> cleaned up patch please, so that I can take a look over the
> weekend?

  sure, this is the patch from
http://article.gmane.org/gmane.comp.version-control.git/68140 actually,
I will resend a proper patch when I've been able to get that one back :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHa5/0vGr7W6HudhwRAq1oAJ9oFPNV/6zhAf7Ety8AkSgNdfZ3nQCeNXdw
9Yh+dADoHR+qPF3Au6MWAhE=
=Np1G
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
