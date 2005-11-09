From: Simon Richter <sjr@debian.org>
Subject: Re: Which packages/versions are needed to build documentation
Date: Wed, 09 Nov 2005 18:24:17 +0100
Message-ID: <437230C1.3090700@debian.org>
References: <200511091655.51093.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8D0D7A6887982431813AEAB5"
X-From: git-owner@vger.kernel.org Wed Nov 09 18:35:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZtgo-0005tF-Hf
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 18:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030557AbVKIRY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 12:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030553AbVKIRY2
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 12:24:28 -0500
Received: from kleinhenz.com ([213.239.205.196]:41384 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S1030557AbVKIRY0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 12:24:26 -0500
Received: from [192.168.115.35] (p54997E8E.dip.t-dialin.net [84.153.126.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id 8C24A4A800D;
	Wed,  9 Nov 2005 18:24:25 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
In-Reply-To: <200511091655.51093.alan@chandlerfamily.org.uk>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11404>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8D0D7A6887982431813AEAB5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> On my debian sarge system it fails almost immediately

Just take the asciidoc package from unstable, last time I looked it had 
no dependencies that were unfulfillable from sarge.

    Simon

--------------enig8D0D7A6887982431813AEAB5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ3Iww1Yr4CN7gCINAQINdwQAlosJKUXNvySqOLbuszmzyjXUMqKACran
BZwlChbxCYdYydIGenA1Tt6HzPBctS3XL5Ujkafr0cJnwL6jjAfKnozJN3j2saF3
xex19BolavMB/RiUEQsIX5+5HRhpdE534gcPtOdnxb+GvRRna6DN1UMjaEaeB8QC
PIOx9/eVQwo=
=+6L8
-----END PGP SIGNATURE-----

--------------enig8D0D7A6887982431813AEAB5--
