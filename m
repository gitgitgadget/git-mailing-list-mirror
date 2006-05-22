From: Donnie Berkholz <spyderous@gentoo.org>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 12:49:40 -0700
Message-ID: <447215D4.5020403@gentoo.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>  <446F95A2.6040909@gentoo.org>  <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org>  <446FA262.7080900@gentoo.org>  <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>  <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>  <44713BE4.9040505@gentoo.org>  <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>  <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>  <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> <44720C66.6040304@gentoo.org> <Pine.LNX.4.64.0605221234430.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCB23DD02FD7CBF2A1581147D"
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 22 21:50:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiGPh-0007DC-K6
	for gcvg-git@gmane.org; Mon, 22 May 2006 21:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWEVTty (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 15:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWEVTty
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 15:49:54 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:35789 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S1750830AbWEVTtx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 15:49:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 1572A64467;
	Mon, 22 May 2006 19:49:53 +0000 (UTC)
Received: from smtp.gentoo.org ([127.0.0.1])
 by localhost (smtp.gentoo.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13370-09-3; Mon, 22 May 2006 19:49:47 +0000 (UTC)
Received: from [192.168.1.105] (c-67-171-150-177.hsd1.or.comcast.net [67.171.150.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id C374064370;
	Mon, 22 May 2006 19:49:46 +0000 (UTC)
User-Agent: Thunderbird 1.5.0.2 (X11/20060513)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605221234430.3697@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
X-Virus-Scanned: amavisd-new at gentoo.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20528>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB23DD02FD7CBF2A1581147D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> Hmm. My cvs server doesn't really grow at all. It's at 13M RSS.

Yeah, that's the thing. RSS stayed about the same (according to top),
but virtual just kept growing.

> What version of cvs are you running?
>=20
> 	[torvalds@g5 ~]$ cvs --version
>=20
> 	Concurrent Versions System (CVS) 1.11.21 (client/server)

Concurrent Versions System (CVS) 1.12.12 (client/server)

Looks like there's a .13 out but the zlib interaction is badly broken
(-z >=3D1) so my system didn't get upgraded. I'll try it anyway after the=

-L run finishes.

Thanks,
Donnie


--------------enigCB23DD02FD7CBF2A1581147D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEchXWXVaO67S1rtsRAqGiAKCIrmUF7TNYTQ3CelBprPxG3Wh6EQCeJb2i
nMtLJgZJn328hoEDrqCcyD4=
=2r5z
-----END PGP SIGNATURE-----

--------------enigCB23DD02FD7CBF2A1581147D--
