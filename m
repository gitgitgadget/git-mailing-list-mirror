From: "Alexey I. Froloff" <raorn@altlinux.org>
Subject: Re: [PATCH] Fixed man entities.
Date: Wed, 6 May 2009 04:37:46 +0400
Message-ID: <20090506003746.GA20646@altlinux.org>
References: <1241560283-13529-1-git-send-email-raorn@altlinux.org> <2FF716E3-8C58-4FF5-B0FD-A694E36238EC@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Cc: git@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 02:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1V93-00030H-U2
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 02:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbZEFAht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 20:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbZEFAht
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 20:37:49 -0400
Received: from vint.altlinux.org ([194.107.17.35]:53321 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbZEFAhs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 20:37:48 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vint.altlinux.org (Postfix) with ESMTP id 64A123F80009;
	Wed,  6 May 2009 00:37:48 +0000 (UTC)
Received: from [213.85.39.63] (unknown [213.85.39.63])
	by imap.altlinux.org (Postfix) with ESMTPSA id 380853E489EB;
	Wed,  6 May 2009 04:37:48 +0400 (MSD)
Received: by hell.fortress (Postfix, from userid 500)
	id 0FA183600058; Wed,  6 May 2009 04:37:47 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <2FF716E3-8C58-4FF5-B0FD-A694E36238EC@pobox.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118321>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Chris Johnsen <chris_johnsen@> [090506 04:14]:
> > It has to be just "\fR", "\fB", ".sp" and ".br", not weird unicode
> > stuff.
> Which versions of asciidoc and docbook-xsl are you using?
asciidoc-8.4.4, docbook-style-xsl-1.73.2.

> If you are not using docbook-xsl 1.72.0, you should not be using =20
> manpage-1.72.xsl.
Yep.  Despite of using docbook-xsl 1.73.2 git was built with
DOCBOOK_XSL_172=3D1.  Without this option manual pages looks
correct.

--=20
Regards,
Sir Raorn.

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoA29YACgkQVqT7+fkT8woR5ACgnVq05etK9lUbnWg/WPDukevd
q4IAnRNprl+Y6OeyTFXfqZ5Z/rsPPWXJ
=JVnv
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
