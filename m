From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: git-unadd anyone?
Date: Wed, 01 Feb 2006 16:31:53 +0100
Message-ID: <43E0D469.1030404@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0E21208F3CB2FE2200AC4047"
X-From: git-owner@vger.kernel.org Wed Feb 01 16:34:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Jxn-0006XE-BC
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 16:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbWBAPcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 10:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422632AbWBAPcD
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 10:32:03 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:2982 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1422633AbWBAPcB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 10:32:01 -0500
Received: (qmail 30275 invoked from network); 1 Feb 2006 15:31:58 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 1 Feb 2006 15:31:58 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id 4C055178C60
	for <git@vger.kernel.org>; Wed,  1 Feb 2006 16:31:58 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15419>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0E21208F3CB2FE2200AC4047
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Is there an easy way to just unmark files wrongly marked as added?

I'm not thinking about something like git-reset --mixed,
which would discard the index as a whole.
I only want to unmark files I git-add(1)ed.

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enig0E21208F3CB2FE2200AC4047
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4NRtlUMEU9HxC6IRApbEAKCmQaO1UnLe93TkGnn78O2n19U3WwCeNLLj
nHkO7uH05l276pyW5/WTUjo=
=FriE
-----END PGP SIGNATURE-----

--------------enig0E21208F3CB2FE2200AC4047--
