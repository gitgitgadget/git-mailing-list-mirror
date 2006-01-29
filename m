From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: No merge strategy handled the merge (git version 1.1.GIT)
Date: Sun, 29 Jan 2006 13:23:52 +0100
Message-ID: <43DCB3D8.8010902@gorzow.mm.pl>
References: <43DB4D16.6050807@drugphish.ch> <20060129120344.GB4815@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig57C309972099A49C7CADCB12"
Cc: Roberto Nibali <ratz@drugphish.ch>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 13:24:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3BbG-00082h-OY
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 13:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWA2MYD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 07:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWA2MYD
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 07:24:03 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:720 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1750937AbWA2MYB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 07:24:01 -0500
Received: (qmail 5960 invoked from network); 29 Jan 2006 12:23:58 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.183.100])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <ratz@drugphish.ch>; 29 Jan 2006 12:23:58 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id 514A1178460;
	Sun, 29 Jan 2006 13:23:57 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060129120344.GB4815@c165.ib.student.liu.se>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15215>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig57C309972099A49C7CADCB12
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> The problem is that merge(1), which is used for file-level merges,
> couldn't be found. Is it installed on your system? If you use Linux,
> it is usually found in the "rcs" package in your favorite
> distribution.

Also in diffutils (the package with diff3).

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enig57C309972099A49C7CADCB12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD3LPdlUMEU9HxC6IRAtifAJ9/ZNPGVzyT57gjF5vtTNZzfo/8fQCfSIT7
3rmy8Eu4hxfDMCx7GiNn9Tc=
=YrGH
-----END PGP SIGNATURE-----

--------------enig57C309972099A49C7CADCB12--
