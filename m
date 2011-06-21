From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: corrupted Git repository
Date: Tue, 21 Jun 2011 16:32:11 +0200
Message-ID: <20110621143211.GA4910@bee.lab.cmartin.tk>
References: <BANLkTi=A=DpyfNwEeSd6N6ibCsA5qh_NPQ@mail.gmail.com>
 <4E005404.5010901@drmicha.warpmail.net>
 <BANLkTi=WVTGcGkUXjkuPYcxhMY0a5KPB7g@mail.gmail.com>
 <4E006682.80101@drmicha.warpmail.net>
 <BANLkTi=GdEfXnAGa6V-33wqX2C-2x-9JQQ@mail.gmail.com>
 <4E00A0E1.8000006@viscovery.net>
 <BANLkTi=6jt7Z3fvK++ontW=F9AJbmEr9Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Kasra Khosoussi <kasra.mail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 16:32:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ204-0003gm-BZ
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 16:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752Ab1FUOcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 10:32:15 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:36420 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747Ab1FUOcO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 10:32:14 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 0F631461EB;
	Tue, 21 Jun 2011 16:31:40 +0200 (CEST)
Received: (nullmailer pid 23482 invoked by uid 1000);
	Tue, 21 Jun 2011 14:32:11 -0000
Content-Disposition: inline
In-Reply-To: <BANLkTi=6jt7Z3fvK++ontW=F9AJbmEr9Qg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176156>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 21, 2011 at 06:56:55PM +0430, Kasra Khosoussi wrote:
> Good question! Actually I have no idea!
>=20
> It was fine yesterday. I had to leave home so I just shutdown my
> netbook (I just issued the command and closed the lid). Files were
> open in my editor but I'm sure that there were no Git processes
> running at the time. The battery was empty this morning, so my best
> guess is that the halt operation was somehow failed, but I think it
> can not explain the corruption.
>=20
> Any idea?

Does your computer actually shutdown or suspend? It could be that the
files still hadn't been flushed to disc when the battery ran out, but
that is unlikely if it did keep running.

Cheers,
   cmn

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOAKtrAAoJEHKRP1jG7ZzTLqkIAID6ddhGrhjEPicSuIHw6boY
uZQwIP4BWsf3PN6maidw5Pzel52WxM7jsW40VHojt7D0yHfeyLZ5s3obhwAY+FTM
1Cff+0LwV7cz9Rl9v36IEb4JZ8nxtxGIIg3UGN+VtGmGeSkX8pElgWvU+I7aSevC
TFJiLd097W3j6tqfdFomnW+gj7Ikaady9RztcyPLOJkyRNx5Xed2kklvhuoqBi4h
ZNmwJxhv8TfZN6BfdenO26VOjbzhJnnPEcVa+0Wpdl4O1d+6vLB5YSkEigmDK4av
avaoruClZ8icOn69Ua4HDgZeshbg1h6y7FGNmE6rft9GA2QntqhVMbznlnfeSCA=
=aMjj
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
