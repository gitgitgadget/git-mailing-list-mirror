From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: how to track the history of a line in a file
Date: Sat, 3 Jan 2009 01:07:03 +0100
Message-ID: <200901030107.07228.trast@student.ethz.ch>
References: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm> <7vvdsxb9oh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0901021658330.21567@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1237110.0MMER0bPkf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Jan 03 01:08:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIu3s-0001DC-IA
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 01:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757656AbZACAGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 19:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757105AbZACAGy
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 19:06:54 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:7638 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbZACAGx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 19:06:53 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 3 Jan 2009 01:06:51 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 3 Jan 2009 01:06:51 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.10.0901021658330.21567@asgard.lang.hm>
X-OriginalArrivalTime: 03 Jan 2009 00:06:51.0164 (UTC) FILETIME=[2D8D65C0:01C96D37]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104448>

--nextPart1237110.0MMER0bPkf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

david@lang.hm wrote:
> On Fri, 2 Jan 2009, Junio C Hamano wrote:
> > You may find the --porcelain output format of git-blame useful to make
> > your script safer and more robust.
>=20
> where is this output defined? I can look at it and understand it, but I=20
> don't know what is guarenteeded to exist, what will be on a specific line=
,=20
> and what may vanish on me.

man git-blame | less -p PORCELAIN\ FORMAT

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart1237110.0MMER0bPkf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklerCsACgkQqUud07tmzP0HawCeILIDgkjxTlBLmlaGF/f5EQry
NngAoJIefCvSPMBi95x7HUgsCnTRkRGc
=qKY+
-----END PGP SIGNATURE-----

--nextPart1237110.0MMER0bPkf--
