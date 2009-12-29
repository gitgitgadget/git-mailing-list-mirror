From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: Help on CGIT
Date: Tue, 29 Dec 2009 12:31:27 +0000
Message-ID: <20091229123127.GA6154@bit.office.eurotux.com>
References: <31576a6d119e2edd66bd8bcc3281e9ad@192.168.1.222>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Cc: git@vger.kernel.org
To: Jorge Bastos <mysql.jorge@decimal.pt>
X-From: git-owner@vger.kernel.org Tue Dec 29 13:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPbLB-0005Yw-SA
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 13:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbZL2MiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 07:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbZL2MiN
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 07:38:13 -0500
Received: from os.eurotux.com ([216.75.63.6]:44526 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbZL2MiM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 07:38:12 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Dec 2009 07:38:12 EST
Received: (qmail 26447 invoked from network); 29 Dec 2009 12:31:31 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by 0 with AES128-SHA encrypted SMTP; 29 Dec 2009 12:31:31 -0000
Content-Disposition: inline
In-Reply-To: <31576a6d119e2edd66bd8bcc3281e9ad@192.168.1.222>
User-Agent: Mutt/1.5.20 (2009-08-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135795>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 29, 2009 at 12:18:38PM +0000, Jorge Bastos wrote:
> Howdy people,=20
>=20
> Since i cannot find any CGIT web interface mailing list on their webpage,
> i'm asking here.=20
>=20
> I have CGIT working at 50%.=20
>=20
> The 1st page show's correctly, but when i click the project name, it
> becames unconfigured and wierd, and apache complains about this:=20
>=20
> [Tue Dec 29 12:12:25 2009] [error] [client 192.168.1.3] [cgit] Unable to
> lock slot /var/cache/cgit/53200000.lock: No such file or directory (2)

Does the directory /var/cache/cgit/ exist?

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAks59p8ACgkQinSul6a7oB8kNgCdE0UpsxWW7/q5JMg7NBVrzfSJ
m18AnR9d0e1ZArTMicI4O7nqyxd0gz0N
=yVRs
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
