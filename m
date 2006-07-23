From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [RFC] Colorize 'commit' lines in log ui
Date: Sun, 23 Jul 2006 13:24:22 +0200
Message-ID: <20060723112422.GB27825@lug-owl.de>
References: <20060723092417.GA7547@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jul 23 13:24:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4c4R-00061o-OZ
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 13:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWGWLYY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 07:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWGWLYX
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 07:24:23 -0400
Received: from lug-owl.de ([195.71.106.12]:668 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750864AbWGWLYX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Jul 2006 07:24:23 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 33F94F029D; Sun, 23 Jul 2006 13:24:22 +0200 (CEST)
To: Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <20060723092417.GA7547@coredump.intra.peff.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24094>


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-07-23 05:24:18 -0400, Jeff King <peff@peff.net> wrote:
> @@ -33,7 +24,8 @@ static char diff_colors[][24] =3D {
>  	"\033[1m",	/* bold */
>  	"\033[36m",	/* cyan */
>  	"\033[31m",	/* red */
> -	"\033[32m"	/* green */
> +	"\033[32m",	/* green */
> +	"\033[33m"	/* yellow */
>  };
> =20
>  static int parse_diff_color_slot(const char *var, int ofs)

If people only were used to *always* place a comma behind the last
array element, the diff would be shorter by one line each time...

MfG, JBG

--=20
       Jan-Benedict Glaw       jbglaw@lug-owl.de                +49-172-760=
8481
 Signature of:                     ...und wenn Du denkst, es geht nicht meh=
r,
 the second  :                            kommt irgendwo ein Lichtlein her.

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEw1xlHb1edYOZ4bsRAspMAJ9GqRL0Ef4axvJk8pbeML9BliGWUQCeL4BT
7tqUX9V7T1vV8OP88jnAwlM=
=aHbs
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
