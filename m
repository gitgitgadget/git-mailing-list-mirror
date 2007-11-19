From: "Jonas Juselius" <jonas.juselius@chem.uit.no>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 17:14:37 +0100
Message-ID: <1195488877.10573.29.camel@localhost>
References: <1195477504.8093.15.camel@localhost> <fhsc7b$k4g$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-sM4LysAT683FM5sP6Cr2"
Cc: <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 17:15:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu9H1-0005mP-A6
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 17:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbXKSQOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 11:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbXKSQOk
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 11:14:40 -0500
Received: from mux2.uit.no ([129.242.5.252]:52735 "EHLO mux2.uit.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbXKSQOk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 11:14:40 -0500
Received: from EVS1.ad.uit.no (eden6.ad.uit.no [129.242.8.62])
	by mux2.uit.no (8.13.8/8.13.6/Mux) with ESMTP id lAJGEaE5001795;
	Mon, 19 Nov 2007 17:14:36 +0100 (CET)
Received: from EVS2.ad.uit.no ([129.242.8.59]) by EVS1.ad.uit.no with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Nov 2007 17:14:36 +0100
Received: from 129.242.24.54 ([129.242.24.54]) by EVS2.ad.uit.no ([129.242.8.29]) via Exchange Front-End Server postboks.uit.no ([129.242.164.132]) with Microsoft Exchange Server HTTP-DAV ; Mon, 19 Nov 2007 16:14:36 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Received: from snowflake by postboks.uit.no; 19 Nov 2007 17:14:37 +0100
Content-class: urn:content-classes:message
In-Reply-To: <fhsc7b$k4g$1@ger.gmane.org>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Git in a Nutshell guide
Thread-Index: Acgqx0dS69FvY7J6TXaQEEDTCMiuwQ==
X-OriginalArrivalTime: 19 Nov 2007 16:14:36.0634 (UTC) FILETIME=[477DBBA0:01C82AC7]
X-Virus-Scanned: : ok
X-Scanned-By: MIMEDefang 2.62 on 129.242.5.252
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65459>


--=-sM4LysAT683FM5sP6Cr2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-11-19 at 17:05 +0100, Jakub Narebski wrote:
> By the way, the description of this repository (for gitweb) is
> "CVS to git migration guide", the same as for CVS2git.git
> (shouldn't it be CVS2git_guide.git?).

Well, it's the same repository. When I started out, I only planned to
write the CVS2git manual. Then I wrote the Nutshell guide, and changed
the name of the repo, but I had already given the link to a bunch of
people so I kept the link.

>=20
> Perhaps you should have make gitweb.cgi with=20
>   GITWEB_BASE_URL=3D"http://git.jonas.iki.fi"
> then, or configure @git_base_url_list in gitweb_config.perl.
>=20

I'll look into that :)

> Do I understand correctly that you don't support cloning via git://
> protocol?

Yes, that is correct. The machine is behind a number of firewalls, and I
simply cannot be bothered to go through the bureaucracy...

.j.


--=-sM4LysAT683FM5sP6Cr2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHQbZtwakVfwpZemYRAqq+AJ9/DoIdYmvIjDXPi/H1AyVcaly8LQCgqvLW
QbMuln1/bWlHKKnYowMgfoo=
=wcW3
-----END PGP SIGNATURE-----

--=-sM4LysAT683FM5sP6Cr2--
