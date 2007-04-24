From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: Re: Odd problem in repository
Date: Tue, 24 Apr 2007 12:43:04 -0500
Message-ID: <1177436584.3923.12.camel@lt21223.campus.dmacc.edu>
References: <462E3D32.60804@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CTSANSp7ZHu2/h1Mhi0A"
Cc: git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 20:03:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgPMh-0008Nl-64
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 20:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422941AbXDXSDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 14:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422955AbXDXSDk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 14:03:40 -0400
Received: from homer.isunet.net ([63.175.164.9]:53244 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422941AbXDXSDj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 14:03:39 -0400
X-Greylist: delayed 1291 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Apr 2007 14:03:39 EDT
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id D6AA138830B;
	Tue, 24 Apr 2007 11:50:09 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 26644-10; Tue, 24 Apr 2007 11:50:07 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id AB3F6388319;
	Tue, 24 Apr 2007 11:50:07 -0500 (CDT)
Received: from [161.210.6.122]
	by max1.ocjtech.us with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1HgP1p-0002oR-Mc; Tue, 24 Apr 2007 12:42:14 -0500
In-Reply-To: <462E3D32.60804@gmail.com>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45483>


--=-CTSANSp7ZHu2/h1Mhi0A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-04-24 at 12:24 -0500, Clark Williams wrote:
>
> If anyone wants to see the repository, you can clone it from:
>=20
> git://git.fedoraprojects.org/git/hosted/mock

FYI, this should be:

git://git.fedoraproject.org/git/hosted/mock

> I'm not sure if it makes sense to try and repair this or just start
> anew. Any advice would be appreciated.

The only thing that I would consider would be to redo the conversion but
this time specifying an author conversion file with the -A switch.

Jeff


--=-CTSANSp7ZHu2/h1Mhi0A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGLkGkrtk7xyyIQRERAsqsAJ0QCYlyO4o2IurcCUW327M7akaHNACeJK5C
davMem7s2D2VHef+oVds+oM=
=JFNp
-----END PGP SIGNATURE-----

--=-CTSANSp7ZHu2/h1Mhi0A--
