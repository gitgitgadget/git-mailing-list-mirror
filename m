From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: Problem getting older version
Date: Mon, 24 Oct 2005 07:23:35 +0200
Message-ID: <20051024052335.GB1830@schottelius.org>
References: <20051019080046.GI22986@schottelius.org> <20051020014230.GV30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 07:26:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETupD-00019D-5L
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 07:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVJXFYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 01:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVJXFYo
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 01:24:44 -0400
Received: from wg.technophil.ch ([213.189.149.230]:45037 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1750970AbVJXFYn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 01:24:43 -0400
Received: (qmail 2023 invoked by uid 1000); 24 Oct 2005 05:23:35 -0000
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051020014230.GV30889@pasky.or.cz>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10529>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks Petr!

Didn't have the time (and network connection, writing offline currently) to
test latest cogito/git for the other errors, but will do that on monday.

Nico

Petr Baudis [Thu, Oct 20, 2005 at 03:42:30AM +0200]:
>   Hello,
>=20
> Dear diary, on Wed, Oct 19, 2005 at 10:00:46AM CEST, I got a letter
> where Nico -telmich- Schottelius <nico-linux-git@schottelius.org> told me=
 that...
> > The following situation:
> >=20
> > - The last commit was a merge, mhich broke some files
> > - We want three files from the commit before
> ..snip..
> > Is this really the standard way to recover a file? As a developer / end=
 user I would expect that:
> >=20
> > cg-recover <filename> <commit id> and -f for overwriting the file if it=
 exists
>=20
>   thanks for the suggestion. I've revamped cg-restore to support this
> kind of syntax, so now if you do
>=20
> 	cg-restore -r ID [-f] FILENAME
>=20
> it should do what you want.
>=20
> --=20
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> VI has two modes: the one in which it beeps and the one in which
> it doesn't.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1xv17OTBMvCUbrlAQLFTQ/+KzElYKP7etT28ZFbNNB6Q+Xum2rZUahk
LbCR4305xRcLN7MHdHpUm2wkphTz1Icq+M8fc6LzB4MyNzKHrfkYBRgNOzZxqcBw
NeFFT1poZpAfdz/E0ziWwYKJsz005T6o+h36znNG7chYPyHobT7czfdrr3EWw7IO
XROXSpxQE5W64DVwhNl2AjGpTzn7PTcpj0Rb6uE163J6IySBAUyh/YDVQADmHL6X
pZyiCIKAoRnVEiURH7O0X9ueC+VCQVzkw+viboJMCimHsEjzx62mQC+pZXZz/zfx
lbhd4ej1GnVu1Emb/rHEMoKb7OBnBWKXVezC6yiuVYZYEGAk4u70dYU2fCeZmXXs
GP1yNIgoLFhPvlxNzDC1kJdJpieucfTxoRsM/w5ic7VrRba5FLXmzXvV4SAk6oO8
gvMOgdADfXiuMsG7f83jUE6t2w9jYXiPuntgOZPBOCqDB4aq6PCiIkOFnqBY2agk
dxjwo4se6wBDpnqKZ0rmqjIWa13yrZFkq5I06vM1c1Vva07dRRZHXWfLWF+q3vmR
bGCO1nNyRX8XqHa4Kjqtp5oWlOXHZGaFJ9luUMS1sWUZ30AxuAyeFKlrvAVjJ45w
9sx/Qmpf0tf9hIwMQgRlv2leatoAUob2IwCzQeFRNw01Fgf6pBuXcuiymlVc9ONG
vlomCPXz/XY=
=pNxD
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
