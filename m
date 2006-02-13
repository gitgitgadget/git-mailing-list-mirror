From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Quick question
Date: Mon, 13 Feb 2006 17:36:07 +0100
Message-ID: <43F0B577.4070608@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7B92A9F79B339E06C513A991"
X-From: git-owner@vger.kernel.org Mon Feb 13 17:37:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8ggW-0005Tm-Cy
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 17:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWBMQgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 11:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWBMQgQ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 11:36:16 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:39896 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S932136AbWBMQgP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 11:36:15 -0500
Received: (qmail 17649 invoked from network); 13 Feb 2006 16:36:12 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 13 Feb 2006 16:36:12 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id D3D7C1784C4
	for <git@vger.kernel.org>; Mon, 13 Feb 2006 17:36:11 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16075>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7B92A9F79B339E06C513A991
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

How to display ignored files of the whole project using only core git?

I've tried:

git-ls-files -o -i -X .git/info/exclude

and it only showed me the excluded files in the current directory...

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enig7B92A9F79B339E06C513A991
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8LV7lUMEU9HxC6IRAn14AKCC+I+D0VD57uzL9qID5Uo0setcJACgh7RH
O9V0kKIt0tudsTge/8jaABE=
=/O/G
-----END PGP SIGNATURE-----

--------------enig7B92A9F79B339E06C513A991--
