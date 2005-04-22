From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [patch] fixup GECOS handling
Date: Fri, 22 Apr 2005 19:25:45 +0200
Message-ID: <1114190745.29271.39.camel@nosferatu.lan>
References: <1113820589.16288.5.camel@nosferatu.lan>
	 <1113827713.5286.13.camel@localhost.localdomain>
	 <1114179795.29271.18.camel@nosferatu.lan>
	 <1114186599.31076.409.camel@axer.marchex.com>
	 <1114189105.29271.36.camel@nosferatu.lan>
	 <20050422171818.GE7173@pasky.ji.cz>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/8ApYlNu7ksO7FUP1mqT"
Content-Transfer-Encoding: 8bit
Cc: kyle@marchex.com, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 19:17:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP1mE-0003n4-NV
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 19:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVDVRVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 13:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVDVRVu
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 13:21:50 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:10148 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S262073AbVDVRVs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 13:21:48 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id AF12461EC;
	Fri, 22 Apr 2005 19:21:44 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 2CA1D3A2430;
	Fri, 22 Apr 2005 19:28:06 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02768-19; Fri, 22 Apr 2005 19:28:02 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 4B4113A241A;
	Fri, 22 Apr 2005 19:28:02 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050422171818.GE7173@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-/8ApYlNu7ksO7FUP1mqT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-22 at 19:18 +0200, Petr Baudis wrote:
> Dear diary, on Fri, Apr 22, 2005 at 06:58:25PM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > Meaning, if they use a ',' in one of the fields (and it is a linux
> > system with the chfn most probably from the shadow package), then they
> > are looking for trouble.  The only reason I added the ';' was because
> > somebody said whatever OS used it instead of a ','.
>=20
> What about just swapping the two tests so that ; is cut off and , only
> when no ; is around?
>=20

Actually, maybe just leave it.  Its not a train smash, and in theory on
linux ';' is a valid char in the gecos.


--=20
Martin Schlemmer


--=-/8ApYlNu7ksO7FUP1mqT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCaTOZqburzKaJYLYRAvvQAKCGSzr9xpeFHpz2pu++7ufsCYCesgCeN9gg
35pi/RcyYAX9tF88XSqgE6M=
=gmw7
-----END PGP SIGNATURE-----

--=-/8ApYlNu7ksO7FUP1mqT--

