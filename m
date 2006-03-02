From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Newbie question: git tag failure
Date: Thu, 2 Mar 2006 16:54:18 +0100
Message-ID: <20060302155418.GZ19232@lug-owl.de>
References: <6d6a94c50603020751v4bb96b75q1686d36b32e2c40f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nRb24sRrY2rSsMZw"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 16:55:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEq8H-0000rX-CF
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 16:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbWCBPyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 10:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWCBPyW
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 10:54:22 -0500
Received: from lug-owl.de ([195.71.106.12]:24498 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751978AbWCBPyV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 10:54:21 -0500
Received: by lug-owl.de (Postfix, from userid 1001)
	id 3AE5AF0034; Thu,  2 Mar 2006 16:54:18 +0100 (CET)
To: Aubrey <aubreylee@gmail.com>
Content-Disposition: inline
In-Reply-To: <6d6a94c50603020751v4bb96b75q1686d36b32e2c40f@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17083>


--nRb24sRrY2rSsMZw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-02 23:51:04 +0800, Aubrey <aubreylee@gmail.com> wrote:
> aubrey@linux:~/local/mygit>git tag -u
> 43368b967bd838292b8cc6b576c5aa13850551cc v2.5
> gpg: directory `/home/aubrey/.gnupg' created
> gpg: new configuration file `/home/aubrey/.gnupg/gpg.conf' created
> gpg: WARNING: options in `/home/aubrey/.gnupg/gpg.conf' are not yet
> active during this run
> gpg: keyring `/home/aubrey/.gnupg/secring.gpg' created
> gpg: keyring `/home/aubrey/.gnupg/pubring.gpg' created
> gpg: skipped "43368b967bd838292b8cc6b576c5aa13850551cc": secret key
> not available
> gpg: signing failed: secret key not available
> failed to sign the tag with GPG.

You seem to not have a working GnuPG installation, inclusing an
(already present) private key. Please first get familiar with GnuPG,
then try to use it :-)  "gpg --gen-key" may help.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--nRb24sRrY2rSsMZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEBxUqHb1edYOZ4bsRAkzZAJ9SXQ49GG68SLMjuMfLpvzCubPNWQCcCIUP
/65LfcxP0IovMRlwFvKTTcE=
=hCWx
-----END PGP SIGNATURE-----

--nRb24sRrY2rSsMZw--
