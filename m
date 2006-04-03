From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Sun, 02 Apr 2006 21:10:56 -0700
Message-ID: <1144037456.2303.92.camel@neko.keithp.com>
References: <1143956188.2303.39.camel@neko.keithp.com>
	 <20060402093906.GH1259@lug-owl.de>  <20060402193144.GK1259@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-p0pcV1fwhQmDNCd+43IQ"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 03 06:11:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQGPZ-0006k9-VP
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 06:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWDCELY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 00:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWDCELY
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 00:11:24 -0400
Received: from home.keithp.com ([63.227.221.253]:62980 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S932309AbWDCELX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 00:11:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 7F98B13001F;
	Sun,  2 Apr 2006 21:11:22 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 18822-05-3; Sun, 2 Apr 2006 21:11:22 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 44A4613001E; Sun,  2 Apr 2006 21:11:22 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 158A114001;
	Sun,  2 Apr 2006 21:11:22 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 511D154386; Sun,  2 Apr 2006 21:10:57 -0700 (PDT)
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20060402193144.GK1259@lug-owl.de>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18307>


--=-p0pcV1fwhQmDNCd+43IQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-04-02 at 21:31 +0200, Jan-Benedict Glaw wrote:

> lex.l: In function =E2=80=98parse_data=E2=80=99:
> lex.l:90: error: =E2=80=98yytext_ptr=E2=80=99 undeclared (first use in th=
is function)
> lex.l:90: error: (Each undeclared identifier is reported only once
> lex.l:90: error: for each function it appears in.)
> make: *** [lex.o] Error 1

I think this is a bug in your version of flex; I'm using standard lex
conventions here. I don't know how to make it work for you.

--=20
keith.packard@intel.com

--=-p0pcV1fwhQmDNCd+43IQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMKBQQp8BWwlsTdMRAoVeAKCa7qr03He6XUBcJMWDog9+ywFZJgCgl+wF
b0m/nftSaQo9nK4VTfaCXeA=
=qj+L
-----END PGP SIGNATURE-----

--=-p0pcV1fwhQmDNCd+43IQ--
