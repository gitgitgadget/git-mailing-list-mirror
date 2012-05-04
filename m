From: =?ISO-8859-1?B?Suly9G1l?= Benoit <jerome.benoit@grenouille.com>
Subject: Re: Newbie grief
Date: Fri, 4 May 2012 20:57:07 +0200
Organization: Grenouille.com
Message-ID: <20120504205707.119725f3@nemesis.grenouille.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org>
	<4F9F28F5.2020403@palm.com>
	<201205010137.q411bxaU002449@no.baka.org>
	<4F9F52B9.9060508@palm.com>
	<08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
	<4FA2D8EA.7030809@palm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/fWEB1K_L9sXBzJ+MPtla1Ps"; protocol="application/pgp-signature"
Cc: <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Fri May 04 21:05:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQNoK-0003qh-LA
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810Ab2EDTE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 15:04:56 -0400
Received: from ns37873.ovh.net ([91.121.8.57]:38456 "EHLO
	laposte.grenouille.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab2EDTEz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 15:04:55 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 May 2012 15:04:55 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by laposte.grenouille.com (Postfix) with ESMTP id D4A687F56A;
	Fri,  4 May 2012 20:57:10 +0200 (CEST)
X-Virus-Scanned: spam & virus filtering at laposte.grenouille.com
X-Spam-Flag: NO
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.902 tagged_above=-9999 required=5
	tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001]
	autolearn=ham
Received: from laposte.grenouille.com ([127.0.0.1])
	by localhost (ns37873.ovh.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r7H8EacJXvTF; Fri,  4 May 2012 20:57:08 +0200 (CEST)
In-Reply-To: <4FA2D8EA.7030809@palm.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197050>

--Sig_/fWEB1K_L9sXBzJ+MPtla1Ps
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 03 May 2012 12:13:46 -0700
Rich Pixley <rich.pixley@palm.com> wrote:

=20
> * the hg commands are simpler and have the defaults that we want,=20
> primarily because no extra branches are required.

You can mimic them with a brand new porclain.

For example, the worklfow described here :=20

http://nvie.com/posts/a-successful-git-branching-model/

have been implemented here :=20

https://github.com/nvie/gitflow

Since git do not have by design the multi HEAD hg design, you will
still not have it but all the glory command chains to mimic it can be
done with some shell scripts and a good knowledge of git internals.=20

Regards, =20

--=20
J=E9r=F4me Benoit aka fraggle
La M=E9t=E9o du Net - http://grenouille.com
OpenPGP Key ID : 9FE9161D
Key fingerprint : 9CA4 0249 AF57 A35B 34B3 AC15 FAA0 CB50 9FE9 161D

--Sig_/fWEB1K_L9sXBzJ+MPtla1Ps
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+kJoMACgkQ+qDLUJ/pFh0hWgCfQZT/EyyzSiDg7ZwwG5HUhyVk
1V4AoKYmeW95cIE0meli7hClF7kD08sN
=pZNP
-----END PGP SIGNATURE-----

--Sig_/fWEB1K_L9sXBzJ+MPtla1Ps--
