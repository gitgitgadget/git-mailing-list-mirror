From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: Getting rid of symlinks in .git?
Date: Fri, 11 Nov 2005 10:15:04 +0100
Message-ID: <43746118.30404@hogyros.de>
References: <20051110204543.GZ30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7E765C7AA9F55284B8E21786"
Cc: Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 10:16:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaV0a-0005cl-9i
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 10:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVKKJPl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 04:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVKKJPl
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 04:15:41 -0500
Received: from kleinhenz.com ([213.239.205.196]:6825 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S932306AbVKKJPk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 04:15:40 -0500
Received: from [192.168.115.35] (p54996A14.dip.t-dialin.net [84.153.106.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id 278BF4A800D;
	Fri, 11 Nov 2005 10:15:25 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051110204543.GZ30496@pasky.or.cz>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=http://www.hogyros.de/simon.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11576>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7E765C7AA9F55284B8E21786
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Petr Baudis wrote:

> I personally would not mind getting rid of symlinks completely, but we
> will still have to support them for some reasonable time period (several
> major releases, as far as Cogito is concerned - actually, there is
> plenty of people still using 0.13 and such).

As someone who carries around git repositories on VFAT formatted USB 
sticks, I welcome our symlink-deprived overlords.

    Simon

--------------enig7E765C7AA9F55284B8E21786
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ3RhJFYr4CN7gCINAQKRDwP+IEvNbgkcMCqMdjVtlxxPRHf6WQKW12Ka
q2JN1P/ufsJ8sZgxkDv1D9ZVenbgCCn9f5aMLtji+0P81YRuyjD0Zf4OHKxW6aIY
09MsyE3EXDJm8BxfrkdedenpIoPak3MiGsPLYJZ3yEx/W90tPJccAAPXpsROKGhm
JUmmvfmj7xk=
=t+Pc
-----END PGP SIGNATURE-----

--------------enig7E765C7AA9F55284B8E21786--
