From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/4] completion fixes: Acks, whitespace, and r=""
Date: Fri, 20 Feb 2009 18:08:23 +0100
Message-ID: <200902201808.32834.trast@student.ethz.ch>
References: <7v63jgg7st.fsf@gitster.siamese.dyndns.org> <1234378479-29304-1-git-send-email-ted@tedpavlic.com> <499EE1DE.2000309@tedpavlic.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1645195.eGnzPjR95p";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: spearce <spearce@spearce.org>, git <git@vger.kernel.org>,
	gitster <gitster@pobox.com>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 18:10:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaYtB-0005T6-VU
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 18:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbZBTRIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 12:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbZBTRIq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 12:08:46 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:1879 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297AbZBTRIp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 12:08:45 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 18:08:44 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 18:08:43 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <499EE1DE.2000309@tedpavlic.com>
X-OriginalArrivalTime: 20 Feb 2009 17:08:43.0844 (UTC) FILETIME=[E295E840:01C9937D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110867>

--nextPart1645195.eGnzPjR95p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ted Pavlic wrote:
> In my latest "git pull," I noticed a few completion changes, but none of=
=20
> these changes were included (and thus on some of my machines, I get=20
> unbound variable errors again).
>=20
> Were these changes finally rejected?

$ git log --pretty=3Doneline --abbrev-commit -4 --author=3DPavlic origin/ne=
xt
5c9cc64 completion: More fixes to prevent unbound variable errors
e5dd864 completion: Better __git_ps1 support when not in working directory
ad244d2 completion: Use consistent if [...] convention, not "test"
fa26a40 completion: For consistency, change "git rev-parse" to __gitdir cal=
ls

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1645195.eGnzPjR95p
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkme45AACgkQqUud07tmzP3xtACcCvSysWpzYoI3/UDNye4lJAeW
itAAmwcnfMhVi4xlp96U5vyZxHiBYUAh
=BBiw
-----END PGP SIGNATURE-----

--nextPart1645195.eGnzPjR95p--
