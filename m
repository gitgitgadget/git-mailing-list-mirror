From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc2
Date: Fri, 28 Dec 2007 15:26:54 +0000
Message-ID: <20071228152654.GD19928@bit.office.eurotux.com>
References: <7v1w98lsg3.fsf@gitster.siamese.dyndns.org> <AAB76121-7F18-4506-809F-EFCAAD76F8BC@zib.de> <20071228150240.GC19928@bit.office.eurotux.com> <87sl1m6e9h.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 16:27:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8H7R-00062O-HS
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 16:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbXL1P1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 10:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbXL1P1E
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 10:27:04 -0500
Received: from os.eurotux.com ([216.75.63.6]:55258 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841AbXL1P1D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 10:27:03 -0500
Received: (qmail 18310 invoked from network); 28 Dec 2007 15:27:00 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 28 Dec 2007 15:27:00 -0000
Content-Disposition: inline
In-Reply-To: <87sl1m6e9h.fsf@wine.dyndns.org>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69287>


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 28, 2007 at 04:16:26PM +0100, Alexandre Julliard wrote:
> Luciano Rocha <luciano@eurotux.com> writes:
>=20
> > On Fri, Dec 28, 2007 at 11:43:53AM +0100, Steffen Prohaska wrote:
> >>=20
> >>  On Dec 27, 2007, at 4:36 AM, Junio C Hamano wrote:
> >>=20
> >> > GIT 1.5.4-rc2 is available at the usual places:
> >>=20
> >>=20
> >>  The msysgit installer is now available at
> >>=20
> >>     http://code.google.com/p/msysgit/downloads
> >>=20
> >
> > Trying to install it in wine ends with:
> >
> > Runtime Error (at -1:0):
> >
> > Cannot Import dll:Kernel32.dll.
> >
> > That popup appears immediately after running wine
> > Git-1.5.4-rc2-preview20071228.exe and the installation ends.
>=20
> That's because it doesn't find CreateHardLinkA. The following Wine patch
> should enable the installer to succeed.
>=20

Thanks. I won't have time to test it in the comming days, but it makes
sense.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHdRW+inSul6a7oB8RAjn6AJ0f2vEVTt1jc7164T5xvHaDYjRTqwCfTPnW
XeuVWIe+01IF8Of2Okx6Fe4=
=DS4J
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
