From: Luciano Miguel Ferreira Rocha <luciano@eurotux.com>
Subject: Re: [PATCH 1/1] git-instaweb: support for apache2/lighttpd by
	other names
Date: Tue, 16 Jun 2009 10:02:09 +0100
Message-ID: <20090616090209.GA3835@bit.office.eurotux.com>
References: <20090211184029.GB1127@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 11:09:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGUf8-0006UG-TE
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 11:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbZFPJIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 05:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbZFPJIw
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 05:08:52 -0400
Received: from os.eurotux.com ([216.75.63.6]:52059 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbZFPJIv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 05:08:51 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2009 05:08:51 EDT
Received: (qmail 14075 invoked from network); 16 Jun 2009 09:02:13 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by 0 with AES128-SHA encrypted SMTP; 16 Jun 2009 09:02:13 -0000
Content-Disposition: inline
In-Reply-To: <20090211184029.GB1127@bit.office.eurotux.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121668>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2009 at 06:40:29PM +0000, Luciano Miguel Ferreira Rocha wro=
te:
> Some distributions include the Apache httpd server as just "httpd", but
> specifying the option --httpd=3Dhttpd doesn't work, as git-instaweb uses
> the program name to detect the type of server used.
>=20
> Now the output if $httpd -v is used to also detect the server type.
>=20
> Remove also the hard-coded path to apache2 modules, use apache2's
> compilation options.

<snip>

I got no replies. Is there any interest in this? Or in a pure perl
server option?

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko3X5EACgkQinSul6a7oB/cPwCgohTjNSlx37xiAQF7Ff9JtqZ5
ImQAniyhU8Wij0iV4mKqvDcYwenfXOmA
=RAIv
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
