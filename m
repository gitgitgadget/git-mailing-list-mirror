From: "Jonas Juselius" <jonas.juselius@chem.uit.no>
Subject: Re: Git in a Nutshell guide
Date: Tue, 20 Nov 2007 12:34:38 +0100
Message-ID: <1195558478.10369.8.camel@localhost>
References: <1195477504.8093.15.camel@localhost> <fhsc7b$k4g$1@ger.gmane.org> <1195488877.10573.29.camel@localhost> <3057F6F3-BEAA-447A-AB79-A0AFB7DB8826@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-VqZz1z1P8T2JrBkPKYHW"
Cc: "git" <git@vger.kernel.org>
To: "Benoit Sigoure" <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Nov 20 12:35:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuRNd-0002Ey-1M
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 12:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756445AbXKTLen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 06:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756365AbXKTLen
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 06:34:43 -0500
Received: from mux2.uit.no ([129.242.5.252]:62581 "EHLO mux2.uit.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755994AbXKTLem (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 06:34:42 -0500
Received: from EVS1.ad.uit.no (eden6.ad.uit.no [129.242.8.62])
	by mux2.uit.no (8.13.8/8.13.6/Mux) with ESMTP id lAKBYcVQ034495;
	Tue, 20 Nov 2007 12:34:38 +0100 (CET)
Received: from EVS2.ad.uit.no ([129.242.8.59]) by EVS1.ad.uit.no with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Nov 2007 12:34:38 +0100
Received: from 129.242.24.54 ([129.242.24.54]) by EVS2.ad.uit.no ([129.242.8.29]) via Exchange Front-End Server postboks.uit.no ([129.242.164.132]) with Microsoft Exchange Server HTTP-DAV ; Tue, 20 Nov 2007 11:34:38 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Received: from snowflake by postboks.uit.no; 20 Nov 2007 12:34:38 +0100
Content-class: urn:content-classes:message
In-Reply-To: <3057F6F3-BEAA-447A-AB79-A0AFB7DB8826@lrde.epita.fr>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Git in a Nutshell guide
Thread-Index: AcgraVVICEqOvC8kRkutUf4O7ghyKQ==
X-OriginalArrivalTime: 20 Nov 2007 11:34:38.0330 (UTC) FILETIME=[5555B5A0:01C82B69]
X-Virus-Scanned: : ok
X-Scanned-By: MIMEDefang 2.62 on 129.242.5.252
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65542>


--=-VqZz1z1P8T2JrBkPKYHW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-11-19 at 17:49 +0100, Benoit Sigoure wrote:
> You can create a repository on repo.or.cz then :)
I will :=3D)
>=20
> As it is often the case different people happen to work on similar =20
> things without knowing each other.  I started http://repo.or.cz/w/=20
> tutorial.git which is meant to be a big Beamer presentation that =20
> presents Git thoroughly.  I wrote some ideas but didn't start to =20
> write the slides.  Just in case you want to have a look.
Thanks, there are certainly some things in that document that I ought to
consider incorporating in the guide. But for now I'll let it rest for a
little while, because I don't have time to mess with it. Patches are
always welcome ;)

> One of the things you said in your guide is that Git is easy to =20
> learn.  I think this is wrong.  Git is way more complicated than most =20
> other SCMs, especially compared to SVN.  Its documentation is far =20
> behind, compared to what other SCMs have.  There is no real user =20
> guide and the man pages are incomplete, at best.  I know saying this =20
> is a bit harsh, especially to the people out there that are working =20
> and sending patches to improve the documentation, but I think we have =20
> to admit that it's true, even though Git is making progress on this =20
> aspect.
Well, you are right to some extent. But it's this gap I would like to
fill with the nutshell guide. The "for normal people" slogan is meant to
refer to non-technical developers (like scientists). I should probably
include a little section in the intro describing distributed vs.
centralised SCMs in general.

Thanks for the input,

.jonas.

--=-VqZz1z1P8T2JrBkPKYHW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHQsZOwakVfwpZemYRAgCXAJ9KBJe7oAODYydcTyZ5uJK4RRwS+ACfU+Ae
AqHf9Rl0tI77wWF7WzWJLpg=
=9/Xa
-----END PGP SIGNATURE-----

--=-VqZz1z1P8T2JrBkPKYHW--
