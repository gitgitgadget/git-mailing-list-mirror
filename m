From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: error: could not lock config file %C:\Users\Hen%/.gitconfig:
 Invalid argument
Date: Fri, 20 Apr 2012 15:10:26 +0200
Message-ID: <1334927426.20138.8.camel@centaur.lab.cmartin.tk>
References: <4F915C26.5010403@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-i1l9r/UXhKWyLyaBcZsD"
Cc: git@vger.kernel.org
To: hen vertis <henvertis@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 15:10:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLDbi-0007Lg-Jq
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 15:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321Ab2DTNKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 09:10:33 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:60380 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753673Ab2DTNK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 09:10:29 -0400
Received: from [192.168.1.17] (brln-4db9d760.pool.mediaWays.net [77.185.215.96])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id B16AC46057;
	Fri, 20 Apr 2012 15:10:25 +0200 (CEST)
In-Reply-To: <4F915C26.5010403@gmail.com>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195990>


--=-i1l9r/UXhKWyLyaBcZsD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-04-20 at 15:52 +0300, hen vertis wrote:
> hi
> i run as administrator git-gui and i get for every action that i make=20
> this error please help me

It looks like Windows parameter expansion gone awry. Your HOME setting
seems get set to %%HOMEPATH%% instead of %HOMEPATH% or similar.

   cmn




--=-i1l9r/UXhKWyLyaBcZsD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJPkWBCAAoJEHKRP1jG7ZzTEfYH/jqvek3xDqsVY+JUQS4yKeiC
BuxBl2bMUC2SBASWMM01AeWcmMa8a8TB6dvc+pKFy++szs9WkeW098XpYqLREYxM
mpZCZF/ATN59g/KmuputocZTB1U3ZUNrqlL6wKQtx/UW89tGW/wg0YehF3Oq0isO
c/lZaNYzBbKy2Yps9Rix1QsKxXt+jDIXBamAIpaKfaKlGOaBV6bmj1wN4yaI/9nh
hXl59YVyMnEi31Dv3cmAK/x74fkCG3GrXNuWChTflLkx0vcbkOKKe4asD07il6qa
Pmd+C9LIcR4gbTvQwQ08mAgOS7OgPmd5tyY4ryFB3qe3xDoxYVpq9ZE8+hZ2lP8=
=fKjr
-----END PGP SIGNATURE-----

--=-i1l9r/UXhKWyLyaBcZsD--
