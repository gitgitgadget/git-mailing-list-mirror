From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sat, 11 Feb 2006 09:44:00 +0100
Message-ID: <43EDA3D0.7090204@gorzow.mm.pl>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org> <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net> <5C03F8F8-656F-48B0-825C-DE55C837F996@codefountain.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFC48D055E6D6356102CD02E4"
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 11 09:45:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7qNY-00068I-2P
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 09:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWBKIoJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 03:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWBKIoJ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 03:44:09 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:41196 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S932279AbWBKIoI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 03:44:08 -0500
Received: (qmail 24604 invoked from network); 11 Feb 2006 08:44:05 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <craig@codefountain.com>; 11 Feb 2006 08:44:05 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id 28C64178FCD;
	Sat, 11 Feb 2006 09:44:05 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Craig Schlenter <craig@codefountain.com>
In-Reply-To: <5C03F8F8-656F-48B0-825C-DE55C837F996@codefountain.com>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15933>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFC48D055E6D6356102CD02E4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Craig Schlenter wrote:
> On 11 Feb 2006, at 7:48 AM, Junio C Hamano wrote:
> It would be nice if the "partial pack" or whatever that has been
> downloaded at the time of the breakage could be re-used and
> things could start "from that point onwards" or the bits that were
> already received could be unpacked. Comments?

It even already works on plain http repos with git fetch.
(e.g. WineHQ repository)
Why git protocol doesn't support it?

+10

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enigFC48D055E6D6356102CD02E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD7aPUlUMEU9HxC6IRAlYBAJ9OFGqvkmqN0kfHSoEjke1Up4XBTACfVm1z
aGu/dd1vDrstexV2ZJVo7cE=
=up8r
-----END PGP SIGNATURE-----

--------------enigFC48D055E6D6356102CD02E4--
