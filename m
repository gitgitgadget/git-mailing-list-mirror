From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: cannot see git-fetch result in gitk
Date: Sun, 02 Dec 2007 16:15:56 +0100
Organization: me - organized??
Message-ID: <4752CC2C.800@imap.cc>
References: <475154DB.4040606@imap.cc> <m3zlwuwmce.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5B467063A72F8DC2AB05A6E8"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 16:15:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyqXR-0008Ia-3F
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 16:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176AbXLBPOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 10:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756169AbXLBPOv
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 10:14:51 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39370 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756124AbXLBPOu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2007 10:14:50 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 63B0859F3A;
	Sun,  2 Dec 2007 10:14:49 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 02 Dec 2007 10:14:49 -0500
X-Sasl-enc: ITVQZl0AJiH214SUDxjEL8A0sNxWTOLSe8PNUhRG77aT 1196608489
Received: from [192.168.59.127] (pD9E843F9.dip.t-dialin.net [217.232.67.249])
	by mail.messagingengine.com (Postfix) with ESMTP id 9753226134;
	Sun,  2 Dec 2007 10:14:48 -0500 (EST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.1.4) Gecko/20070509 SeaMonkey/1.1.2 Mnenhy/0.7.5.666
In-Reply-To: <m3zlwuwmce.fsf@roke.D-201>
X-Enigmail-Version: 0.95.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66785>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5B467063A72F8DC2AB05A6E8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 01.12.2007 14:55 schrieb Jakub Narebski:
> Did you run just "gitk"? By default gitk displays only current branch,

Thanks, that explains it. It might be a good idea to mention that
in the manpage.

> while git-fetch changes remote-tracking branches only. Try=20
> "gitk --all", or "gitk origin/master ..." enumerating explicitely all
> remote branches.

Ok, thanks, will try that next time git-fetch actually finds something
to fetch. ;-)

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig5B467063A72F8DC2AB05A6E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHUsw0MdB4Whm86/kRAh7eAJ41JCbzbv5vkEoMOXda3HxzKHQPBQCfQo9y
6DnHaOAGI5KzTgu+NUJE7n0=
=GD+T
-----END PGP SIGNATURE-----

--------------enig5B467063A72F8DC2AB05A6E8--
