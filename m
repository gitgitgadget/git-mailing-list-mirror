From: Simon Richter <sjr@debian.org>
Subject: Re: Regarding: Debian: packaging updates.
Date: Tue, 08 Nov 2005 20:36:55 +0100
Message-ID: <4370FE57.7010304@debian.org>
References: <Pine.LNX.4.63.0511081806320.18374@wbgn013.biozentrum.uni-wuerzburg.de>	<4370EEF7.4060708@debian.org> <7vbr0vey42.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8D6521F686BC74135DBFD746"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 20:38:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZZHN-00074K-CE
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 20:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbVKHThJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 14:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbVKHThJ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 14:37:09 -0500
Received: from kleinhenz.com ([213.239.205.196]:24488 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S965297AbVKHThI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 14:37:08 -0500
Received: from [192.168.115.35] (p54995D51.dip.t-dialin.net [84.153.93.81])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id 111674A800D;
	Tue,  8 Nov 2005 20:37:05 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr0vey42.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11352>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8D6521F686BC74135DBFD746
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Junio C Hamano wrote:

> Since you have debian.org e-mail address, perhaps you can feed
> me patches to debian/ area and deb: rule in the main Makefile?

Sure. I have also talked this over with a few people and am going to 
make official uploads occasionally.

> I'd appreciate if you can take care of it
> when you update the Makefile deb: rule as well, if the *.changes
> file request makes sense to you.

Not really. *.changes files make only sense if you are running archive 
maintenance software, and the need to do that should go away with 
reasonably up-to-date packages being in the archive RSN.

    Simon

--------------enig8D6521F686BC74135DBFD746
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCUAwUBQ3D+WlYr4CN7gCINAQIpsQP3ZUtUugM7Q/9FFRY7/ADCp9XCeYRc5ZYO
C+x3+JANCYfisb4IgNGTcNKxm3E7ODlus8gvbAI0mwNpzqWSjYp9a+zyn3Ce+Br+
YZ0rqlmU1+J+mdRy7FywiYxgo5vzP5GauQQWYzzTz/J+qlffM18sI10tAudxocQb
XNGFrkKEag==
=QF7s
-----END PGP SIGNATURE-----

--------------enig8D6521F686BC74135DBFD746--
