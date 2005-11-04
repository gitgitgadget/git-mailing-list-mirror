From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: Tags not transferred with git pull?
Date: Fri, 4 Nov 2005 16:59:14 +0100
Message-ID: <20051104155914.GA9567@ferdyx.org>
References: <20051104155314.GB23790@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
X-From: git-owner@vger.kernel.org Fri Nov 04 17:02:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY3yP-0000Kb-Ax
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 16:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbVKDP7W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 10:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbVKDP7W
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 10:59:22 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:30608
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S1161151AbVKDP7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 10:59:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id CB4C58D314
	for <git@vger.kernel.org>; Fri,  4 Nov 2005 16:59:16 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06430-06 for <git@vger.kernel.org>;
	Fri, 4 Nov 2005 16:59:13 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id A26F08D30B
	for <git@vger.kernel.org>; Fri,  4 Nov 2005 16:59:12 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Fri,  4 Nov 2005 16:59:15 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051104155314.GB23790@harddisk-recovery.nl>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11138>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 04, 2005 at 04:53:14PM +0100, Erik Mouw wrote:
| Hi,
|=20
| Is it OK that the latest git (0.99.9c) doesn't get the tags
| (refs/tags/*) when doing a git pull? It's getting a bit of a nuisance
| to do a separate rsync to get them right.
|=20

As Linus explained in a message earlier, a git fetch --tags will do it.

Cheers,
Ferdy

--=20
Fernando J. Pereda Garcimart=EF=BF=BDn
Gentoo Developer (Alpha,net-mail,mutt,git)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDa4VSCkhbDGC9KNQRApKKAJ9UJ4aCwNfkcYCRk705IcW532vBDACfZi7I
3MNQMQTnYAMONiWRnnk6pj0=
=fwV7
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
