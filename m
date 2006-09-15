From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Build on Debian GNU/Hurd
Date: Fri, 15 Sep 2006 17:47:42 +0200
Message-ID: <20060915154742.GT17042@admingilde.org>
References: <20060915125846.10469.qmail@ccc765dd61a02d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hw0FrjWlp+qkNlJP"
X-From: git-owner@vger.kernel.org Fri Sep 15 17:48:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOFuu-0000fw-BM
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 17:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWIOPro (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 11:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWIOPro
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 11:47:44 -0400
Received: from agent.admingilde.org ([213.95.21.5]:48352 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932098AbWIOPro
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 11:47:44 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GOFuo-00065Q-Sq
	for git@vger.kernel.org; Fri, 15 Sep 2006 17:47:42 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060915125846.10469.qmail@ccc765dd61a02d.315fe32.mid.smarden.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27090>


--Hw0FrjWlp+qkNlJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Sep 15, 2006 at 12:58:46PM +0000, Gerrit Pape wrote:
> +ifeq ($(uname_S),GNU)
> +       # GNU stands for GNU/Hurd
> +       NO_STRLCPY =3D YesPlease
> +       ALL_CFLAGS +=3D -DPATH_MAX=3D4096
> +endif

I guess this arbitrary limit will upset all the Hurd enthusiasts... ;-)

--=20
Martin Waitz

--Hw0FrjWlp+qkNlJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFCssej/Eaxd/oD7IRAr26AJ9drdoRCnS+Wvev7kXKk2CAjv7bsQCcDisN
9GH2qke6furgy8rWDTpJhCM=
=vXYq
-----END PGP SIGNATURE-----

--Hw0FrjWlp+qkNlJP--
