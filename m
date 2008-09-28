From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-describe doesn't show the most recent tag
Date: Sun, 28 Sep 2008 15:55:26 +0200
Message-ID: <20080928135526.GG5302@artemis.corp>
References: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Cp3Cp8fzgozWLBWL";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	open-iscsi@googlegroups.com
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 28 16:05:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjwtN-0006vU-0m
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 16:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbYI1OCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 10:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbYI1OCh
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 10:02:37 -0400
Received: from pan.madism.org ([88.191.52.104]:47368 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbYI1OCg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 10:02:36 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Sep 2008 10:02:36 EDT
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B88ED3A7B8;
	Sun, 28 Sep 2008 15:55:27 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5E2D62AC9C; Sun, 28 Sep 2008 15:55:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96967>


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2008 at 01:48:42PM +0000, Erez Zilber wrote:
> Why is this happening?

       --tags
           Instead of using only the annotated tags, use any tag found in
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
           .git/refs/tags.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjfjM4ACgkQvGr7W6HudhygCQCeI1Yfw1cpYP5wWiqSOnmTCiFw
mtQAoJopZT0qvBkkh6HeXfyGHdUuiHfy
=vidd
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--
