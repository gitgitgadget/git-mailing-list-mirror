From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: [PATCH v2] builtin-tag.c: allow arguments in $EDITOR
Date: Thu, 20 Dec 2007 12:06:01 +0000
Message-ID: <20071220120601.GA15290@bit.office.eurotux.com>
References: <20071219232326.GA4135@bit.office.eurotux.com> <20071220095706.GA9685@bit.office.eurotux.com> <Pine.LNX.4.64.0712201255510.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 20 13:07:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5KB0-0007oE-KN
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 13:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761875AbXLTMGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 07:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762329AbXLTMGN
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 07:06:13 -0500
Received: from os.eurotux.com ([216.75.63.6]:59189 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762230AbXLTMGI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 07:06:08 -0500
Received: (qmail 1529 invoked from network); 20 Dec 2007 12:06:06 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 20 Dec 2007 12:06:06 -0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712201255510.14355@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68995>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 20, 2007 at 12:58:59PM +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 20 Dec 2007, Luciano Rocha wrote:
>=20
> > The previous sh version of git-commit evaluated the value of the define=
d=20
> > editor, thus allowing arguments.
> >=20
> > Make the builtin version work the same, by adding an explicit check for=
=20
> > arguments in the editor command, and extract them to an additional=20
> > argument.
>=20
> Anything wrong with that patch?
>=20
> http://article.gmane.org/gmane.comp.version-control.git/68444

No, I just missed it in the mailing list. That patch also supports any
number of whitespace/arguments.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHalqpinSul6a7oB8RAuDxAJ9j2BI9pF7NHjkPN/oyb2yaxYKIAQCeOAu7
kgKXzPAk1AiDysSVkNuoTyM=
=xXRX
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
