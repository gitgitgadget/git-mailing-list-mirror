From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Fri, 27 Apr 2007 10:30:07 +0200
Message-ID: <20070427083007.GA4690@ferdyx.org>
References: <20070426192439.GA6976@ferdyx.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 10:31:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhLr1-0005mS-HM
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 10:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457AbXD0Ia4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 04:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbXD0Iaz
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 04:30:55 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:49833
	"EHLO smtp.ferdyx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755447AbXD0IaP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 04:30:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 447108D315
	for <git@vger.kernel.org>; Fri, 27 Apr 2007 10:07:53 +0200 (CEST)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13596-10 for <git@vger.kernel.org>;
	Fri, 27 Apr 2007 10:07:48 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id AD4188D305
	for <git@vger.kernel.org>; Fri, 27 Apr 2007 10:07:47 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Fri, 27 Apr 2007 10:30:08 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@ferdyx.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070426192439.GA6976@ferdyx.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45701>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2007 at 09:24:39PM +0200, Fernando J. Pereda wrote:
> Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>
> ---
>=20
>  builtin-mailsplit.c |  107 ++++++++++++++++++++++++++++++++++++++++++---=
------
>  builtin.h           |    2 +-
>  2 files changed, 89 insertions(+), 20 deletions(-)
>

Actually, I forgot to update the documentation, I'll send an updated
patch.

- ferdy

--=20
Fernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGMbSPCkhbDGC9KNQRAkknAKCHzl79iK46oWgDPzjeb0W5FttWXgCfbCWJ
jyEei/evoL+x936SUBlJA98=
=XJMk
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
