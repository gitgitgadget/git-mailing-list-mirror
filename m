From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [RFC] cgit in git?
Date: Thu, 11 Dec 2008 23:15:40 +0100
Message-ID: <20081211221540.GA5691@genesis.frugalware.org>
References: <8c5c35580812111348iceaf30dyb55183017cff5b1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sx3M3By4KbPIrykT"
Cc: Junio C Hamano <gitster@pobox.com>,
	Seth Vidal <skvidal@fedoraproject.org>,
	Git Mailing List <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 23:17:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAtqE-00075l-W3
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 23:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171AbYLKWPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 17:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757092AbYLKWPs
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 17:15:48 -0500
Received: from virgo.iok.hu ([212.40.97.103]:58816 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757019AbYLKWPr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 17:15:47 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 117CE58096;
	Thu, 11 Dec 2008 23:15:45 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CC91D4465E;
	Thu, 11 Dec 2008 23:15:40 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 59EFA11B885F; Thu, 11 Dec 2008 23:15:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <8c5c35580812111348iceaf30dyb55183017cff5b1d@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102829>


--Sx3M3By4KbPIrykT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2008 at 10:48:45PM +0100, Lars Hjemli <hjemli@gmail.com> wr=
ote:
> 2) the cgit release tarballs includes the needed git sources
> 3) the cgit sources are subtree-merged into git
> 4) cgit is modified to link against libgit2
>=20
> Option 1 seems unlikely to happen since such a 'git-for-cgit' package
> would basically require the fedora project to support two git
> packages.
>=20
> Option 2 is doable but still requires the fedora project to support
> two git packages (but now the 'git-for-cgit' package is hidden inside
> the cgit source tree). The good thing about this option is that it
> only requires some minor modifications to the cgit releases.

I don't say 2) is the ideal solution (probably 4) will be), but that's
what we choosed for Frugalware and I think Fedora could live with it as
well.

--Sx3M3By4KbPIrykT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklBkQwACgkQe81tAgORUJbmjgCgn9lAD+lJRduoPa+n/+NvNDDv
tm0AnihNom9ypoGZwl9+lp5XYZzj4E87
=O5Ik
-----END PGP SIGNATURE-----

--Sx3M3By4KbPIrykT--
