From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] gitweb: support the rel=vcs microformat
Date: Wed, 7 Jan 2009 13:41:13 -0500
Message-ID: <20090107184113.GA31795@gnu.kitenet.net>
References: <20090107042518.GB24735@gnu.kitenet.net> <gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net> <cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 19:42:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKdMc-00088I-CG
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 19:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628AbZAGSlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 13:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756300AbZAGSlW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 13:41:22 -0500
Received: from wren.kitenet.net ([80.68.85.49]:56060 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756198AbZAGSlV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 13:41:21 -0500
Received: from gnu.kitenet.net (tn-76-5-153-29.dhcp.embarqhsd.net [76.5.153.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 6588F3142F2;
	Wed,  7 Jan 2009 13:41:17 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id D8C2CA8106; Wed,  7 Jan 2009 13:41:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8842/Wed Jan  7 09:06:50 2009 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104819>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Giuseppe Bilotta wrote:
> > Thanks for the feedback. There are some changes happening to the
> > microformat that should make gitweb's job slightly easier, I'll respin
> > the patch soon.
>=20
> Let me know about this too, I very much like the idea of this microformat.

FYI, I've updated the microformat's page with the changes. The
significant one for gitweb is that it can now be applied to <a> links.
So on the project page, the display of the git URL could be converted to
a link using the microformat, and there's no need to get the info
earlier to put it in the header. Unfortunatly, the same can't be done to
the project list page, unless it's changed to have "git" links as seen
on vger.kernel.org's gitweb.

--=20
see shy jo

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJZPdGd8HHehbQuO8RAjlJAKCzf2JugziglRDC5x5vJEEAHxjhlwCgvkxx
EWyu+TioFassph0k+kjVtRU=
=V2RG
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
