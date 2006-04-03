From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Mon, 03 Apr 2006 09:54:42 -0700
Message-ID: <1144083282.2303.102.camel@neko.keithp.com>
References: <1143956188.2303.39.camel@neko.keithp.com>
	 <20060402093906.GH1259@lug-owl.de> <20060402193144.GK1259@lug-owl.de>
	 <1144037456.2303.92.camel@neko.keithp.com>
	 <20060403072554.GN1259@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Zvz2beyYtR1HtQvZFRU0"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 03 18:55:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQSKz-0004Ov-QB
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 18:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWDCQzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 12:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWDCQzR
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 12:55:17 -0400
Received: from home.keithp.com ([63.227.221.253]:17420 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S932183AbWDCQzP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 12:55:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 4FD4C13001F;
	Mon,  3 Apr 2006 09:55:13 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 31734-02-2; Mon, 3 Apr 2006 09:55:13 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 13C9E13001E; Mon,  3 Apr 2006 09:55:13 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 5FC0D14002;
	Mon,  3 Apr 2006 09:55:12 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id AF41454386; Mon,  3 Apr 2006 09:54:43 -0700 (PDT)
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20060403072554.GN1259@lug-owl.de>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18343>


--=-Zvz2beyYtR1HtQvZFRU0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-04-03 at 09:25 +0200, Jan-Benedict Glaw wrote:

> -YFLAGS=3D-d
> +YFLAGS=3D-d -l
> +LFLAGS=3D-l

Works for me too; thanks for the fix.

--=20
keith.packard@intel.com

--=-Zvz2beyYtR1HtQvZFRU0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMVNSQp8BWwlsTdMRAi8tAJ9iVLnvPiuwkUXBuvdOggTQdnzGhgCgofub
p98lyV/dpnIJEtPVOGsTDK0=
=Nj+z
-----END PGP SIGNATURE-----

--=-Zvz2beyYtR1HtQvZFRU0--
