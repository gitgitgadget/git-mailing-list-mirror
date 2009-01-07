From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] gitweb: support the rel=vcs microformat
Date: Wed, 7 Jan 2009 14:02:38 -0500
Message-ID: <20090107190238.GA3909@gnu.kitenet.net>
References: <20090107042518.GB24735@gnu.kitenet.net> <gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net> <cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com> <20090107184515.GB31795@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 20:04:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKdhD-0007Uo-4w
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 20:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758837AbZAGTCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 14:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758372AbZAGTCn
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 14:02:43 -0500
Received: from wren.kitenet.net ([80.68.85.49]:41980 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758080AbZAGTCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 14:02:42 -0500
Received: from gnu.kitenet.net (tn-76-5-152-94.dhcp.embarqhsd.net [76.5.152.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 075C4314285;
	Wed,  7 Jan 2009 14:02:41 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id B0E00A8106; Wed,  7 Jan 2009 14:02:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20090107184515.GB31795@gnu.kitenet.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8842/Wed Jan  7 09:06:50 2009 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104822>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Joey Hess wrote:
> Another approach would be to just memoize git_get_project_description
> and git_get_project_url_list.

Especially since git_get_project_description is already called more than
once for some pages.

--=20
see shy jo

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJZPxOd8HHehbQuO8RAlV+AKC0piZf0pHIyfO8j8p9F2XPqEYUAACg0rHY
FbcI3KWMuETAxp+3Aq0Qbig=
=A8up
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
