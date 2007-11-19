From: "Jonas Juselius" <jonas.juselius@chem.uit.no>
Subject: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 14:05:04 +0100
Message-ID: <1195477504.8093.15.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-b1o1bw7yIhxKujDEtQTE"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 14:13:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu6Ro-0005vA-8x
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 14:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbXKSNNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 08:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626AbXKSNNj
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 08:13:39 -0500
Received: from mux2.uit.no ([129.242.5.252]:61267 "EHLO mux2.uit.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbXKSNNi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 08:13:38 -0500
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2007 08:13:38 EST
Received: from EVS1.ad.uit.no (eden6.ad.uit.no [129.242.8.62])
	by mux2.uit.no (8.13.8/8.13.6/Mux) with ESMTP id lAJD54HR034608
	for <git@vger.kernel.org>; Mon, 19 Nov 2007 14:05:04 +0100 (CET)
Received: from EVS2.ad.uit.no ([129.242.8.59]) by EVS1.ad.uit.no with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Nov 2007 14:05:05 +0100
Received: from 129.242.24.54 ([129.242.24.54]) by EVS2.ad.uit.no ([129.242.8.29]) via Exchange Front-End Server postboks.uit.no ([129.242.164.132]) with Microsoft Exchange Server HTTP-DAV ; Mon, 19 Nov 2007 13:05:04 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Received: from snowflake by postboks.uit.no; 19 Nov 2007 14:05:05 +0100
Content-class: urn:content-classes:message
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Git in a Nutshell guide
Thread-Index: AcgqrM0nyI7GA0z2RZy/bm7sP3PVBg==
X-OriginalArrivalTime: 19 Nov 2007 13:05:05.0247 (UTC) FILETIME=[CD9DC6F0:01C82AAC]
X-Virus-Scanned: : ok
X-Scanned-By: MIMEDefang 2.62 on 129.242.5.252
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65435>


--=-b1o1bw7yIhxKujDEtQTE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi everybody,

I have been involved in a somewhat painful process of trying to convert
a bunch of scientific programmers from being CVS users to becoming git
users. In this process I ended up writing a sort of git in a nutshell
guide for non-technical users. It struck me that this might be of
interest to others as well. I'm not a grand git wizard myself, so the
guide is probably not entirely correct in every respect. All comments
and suggestions are welcome!=20
I have also written a CVS2git transition guide, which outlines one
possible way of converting from CVS to git. This guide has some overlap
with the Git in a Nutshell guide, since I started with the CVS2git guide
and then realised it was not quite enough. It would probably be a good
idea to slim down the CVS2git guide, and move some of the discussion to
the Nushell guide instead. Let me know what you think. Both guides still
need quite a bit of polishing, but I hope they can be useful and
interesting in the crusade against CVS/SVN ;)If you think the guides
could benefit other users, they could maybe be posted (or at least
linked) on the git site.

The guides, including the LaTeX source, are available via gitweb:
http://git.jonas.iki.fi/gitweb.cgi?p=3Dgit_guides.git;a=3Dsummary


.jonas.

--=-b1o1bw7yIhxKujDEtQTE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHQYoAwakVfwpZemYRApp/AJ9i4qstj2yfS3ss7Y2WpJoTXusTTgCdHXSM
Y5A1+f1vhnmR/tapVK2ZKRY=
=cX5D
-----END PGP SIGNATURE-----

--=-b1o1bw7yIhxKujDEtQTE--
