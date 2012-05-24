From: Nicolas <sanpi@homecomputing.fr>
Subject: Re: [stgit] Play with patch remotely
Date: Fri, 25 May 2012 00:28:01 +0200
Message-ID: <4FBEB5F1.2010909@homecomputing.fr>
References: <20120524135807.GB1016@homecomputing.fr> <CAFBaKAyjaSw5zC3AfHp3j+YWbV=Ds1J-xZ_gb7Qp5tsYLxCw_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig292095934494537CFBF8C412"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 00:28:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXgWL-0000tU-NS
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 00:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757438Ab2EXW2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 18:28:08 -0400
Received: from homecomputing.fr ([88.185.228.16]:34750 "EHLO homecomputing.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756080Ab2EXW2H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 18:28:07 -0400
Received: by homecomputing.fr (Postfix, from userid 1002)
	id B00BBFB48; Fri, 25 May 2012 00:28:05 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	cuddles.homecomputing.fr
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from [192.168.51.2] (unknown [192.168.51.254])
	(Authenticated sender: sanpi)
	by homecomputing.fr (Postfix) with ESMTPSA id 0F33DFA88
	for <git@vger.kernel.org>; Fri, 25 May 2012 00:28:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <CAFBaKAyjaSw5zC3AfHp3j+YWbV=Ds1J-xZ_gb7Qp5tsYLxCw_g@mail.gmail.com>
X-Enigmail-Version: 1.4
OpenPGP: id=78532E92
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198439>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig292095934494537CFBF8C412
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 24/05/2012 21:01, Gustav H=E5llberg wrote:
> I believe you need .git/patches as well, which cannot be cloned like th=
at.

Ok. Is there is a command for create this directory?

This seems to be a directory version of the master.stgit branch: a patch
is a directory and sections (Bottom, Author, =85) are files.


--------------enig292095934494537CFBF8C412
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJPvrX0AAoJEAbXGiR4Uy6SseoIAML9w/mJRMyJtYas5a/Qm6Nk
KZe0ZeVjCD5DJCZyu7mKCGROi87+yLx7pCk8YNotd/I6dL8AsdsyQsKIlcjmZopp
Tn+71ETURh/FYLBf/yTcngAFR9rlxLONk7QKjprgnTNri+56O3cZUCYovb/cghxo
TOsVXPFZEopAyO3ojCLoq373BFZB6tIE1VprE9ozhJsiNtBjTcIi39xGZCrlHWWO
sUmHqo6LingjodEAxh1DIh3Z2gkSFqX02HgMLxjnilo0qeTKgXIeaYKJiYf+WE7E
KpQLcdh/+2Hqbfc3uYr6SmN2gjY4PsoqYONnfFkPUDkon48UP0JtlhUQvkr3U58=
=anCu
-----END PGP SIGNATURE-----

--------------enig292095934494537CFBF8C412--
