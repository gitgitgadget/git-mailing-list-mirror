From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: 1.3.2 git-clone segfaults
Date: Wed, 17 May 2006 20:41:21 +0200
Message-ID: <20060517184121.GA17846@ferdyx.org>
References: <879BAFDD-87DB-4041-8753-5D63630076B5@cs.utexas.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Cc: git@vger.kernel.org, Wolfgang Denk <wd@denx.de>
X-From: git-owner@vger.kernel.org Wed May 17 20:41:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgQxg-0002ab-L7
	for gcvg-git@gmane.org; Wed, 17 May 2006 20:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWEQSla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 14:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWEQSl3
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 14:41:29 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:28571
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S1750886AbWEQSl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 14:41:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 8393D8D318;
	Wed, 17 May 2006 20:37:19 +0200 (CEST)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10623-04; Wed, 17 May 2006 20:37:15 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id C884A8D305;
	Wed, 17 May 2006 20:37:14 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Wed, 17 May 2006 20:41:21 +0200 (CEST)
To: Bill Yoder <byoder@cs.utexas.edu>
Mail-Followup-To: "Fernando J. Pereda" <ferdy@ferdyx.org>,
	Bill Yoder <byoder@cs.utexas.edu>, git@vger.kernel.org,
	Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <879BAFDD-87DB-4041-8753-5D63630076B5@cs.utexas.edu>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20220>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2006 at 01:32:39PM -0500, Bill Yoder wrote:
> Please let me know if I can supply more information or if I'm
> misusing the command.

I reported this same issue to Nick Hengeveld and he said he'll take a
look at it. this is also Gentoo Bug #133412 [1].

- ferdy

[1] https://bugs.gentoo.org/show_bug.cgi?id=3D133412

--=20
Fernando J. Pereda Garcimart=EDn
Gentoo Developer (Alpha,net-mail,mutt,git)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEa25RCkhbDGC9KNQRAgJ5AJ0b5Hl6gLt/gGsrrPpga+GfdlD+8gCfUny0
VFD3N6YWC6O9rK5DvvI6in4=
=ocjd
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
