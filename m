From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI  revamp
Date: Thu, 30 Oct 2008 18:03:29 +0100
Message-ID: <20081030170329.GK24098@artemis.corp>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <20081030143918.GB14744@mit.edu> <vpqmygmw1mr.fsf@bauges.imag.fr> <alpine.LFD.2.00.0810301259130.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="hl1kWnBARzJiTscN";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Theodore Tso <tytso@mit.edu>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 18:05:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvawx-0000Cw-5F
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 18:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbYJ3RDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 13:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755154AbYJ3RDd
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 13:03:33 -0400
Received: from pan.madism.org ([88.191.52.104]:54658 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132AbYJ3RDc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 13:03:32 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 019483B43D;
	Thu, 30 Oct 2008 18:03:31 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id DCAF45EE23A; Thu, 30 Oct 2008 18:03:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810301259130.13034@xanadu.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99502>


--hl1kWnBARzJiTscN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2008 at 05:00:18PM +0000, Nicolas Pitre wrote:
> On Thu, 30 Oct 2008, Matthieu Moy wrote:
>=20
> > I've already argued in favor of allowing "git reset --hard <files>",
> > which is consistant with existing terminology and doesn't add an extra
> > command, but without success.
>=20
> If you have a file argument, the --hard option is redundant, isn't it?
> So what about simply "git reset <file>" ?

errrrm, git reset <file> resets the index notion of the file to its status
in HEAD... which I'm sure is *somehow* useful to "some" people ;P

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--hl1kWnBARzJiTscN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkJ6OEACgkQvGr7W6HudhzxjQCfQVeTrMAqEW8W6PDYUC0SKsxq
4Z4AoJWizoB9c03d7pYzwiixS8ET1GiS
=Jq68
-----END PGP SIGNATURE-----

--hl1kWnBARzJiTscN--
