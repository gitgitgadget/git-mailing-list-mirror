From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Wishlist: Please add --author to git-tag
Date: Thu, 31 Jan 2008 20:35:50 +0100
Message-ID: <20080131193550.GB10905@artemis.madism.org>
References: <47A20503.2000603@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="i9LlY+UWpKt15+FH";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 20:36:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKfD3-0001YF-BF
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 20:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761433AbYAaTfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 14:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760745AbYAaTfy
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 14:35:54 -0500
Received: from pan.madism.org ([88.191.52.104]:47303 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759668AbYAaTfw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 14:35:52 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8816730842
	for <git@vger.kernel.org>; Thu, 31 Jan 2008 20:35:50 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 510FA4F045D; Thu, 31 Jan 2008 20:35:50 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <47A20503.2000603@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72135>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2008 at 05:27:31PM +0000, Daniel Baumann wrote:
> Hi,
>=20
> git commit supports --author to overwrite the author information on a
> particular commit; it would be nice if git tag would offer the same.

  Meanwhile,

  GIT_AUTHOR_NAME=3D"John Doe" GIT_AUTHOR_EMAIL=3Dluser@example.com git tag

  Will work
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHoiMWvGr7W6HudhwRAgCrAJ0eDgtqmtEbme5/MpxvBQ4zmkWVewCgi1aS
rzbdZtGfGyeDWor/EGHMqtM=
=pQUG
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
