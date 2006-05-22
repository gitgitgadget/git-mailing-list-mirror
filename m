From: Donnie Berkholz <spyderous@gentoo.org>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 13:16:38 -0700
Message-ID: <44721C26.5000503@gentoo.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>	 <446F95A2.6040909@gentoo.org>	 <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org>	 <446FA262.7080900@gentoo.org>	 <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>	 <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>	 <44713BE4.9040505@gentoo.org>	 <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>	 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>	 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> <44720C66.6040304@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7039EE525AE42ED53AA660E8"
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 22 22:17:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiGpu-00055b-RR
	for gcvg-git@gmane.org; Mon, 22 May 2006 22:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWEVUQx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 16:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWEVUQx
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 16:16:53 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:60379 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S1751168AbWEVUQw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 16:16:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id A14626441F;
	Mon, 22 May 2006 20:16:51 +0000 (UTC)
Received: from smtp.gentoo.org ([127.0.0.1])
 by localhost (smtp.gentoo.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 00028-07-6; Mon, 22 May 2006 20:16:45 +0000 (UTC)
Received: from [192.168.1.105] (c-67-171-150-177.hsd1.or.comcast.net [67.171.150.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 6F06864437;
	Mon, 22 May 2006 20:16:45 +0000 (UTC)
User-Agent: Thunderbird 1.5.0.2 (X11/20060513)
To: Donnie Berkholz <spyderous@gentoo.org>
In-Reply-To: <44720C66.6040304@gentoo.org>
X-Enigmail-Version: 0.94.0.0
X-Virus-Scanned: amavisd-new at gentoo.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20530>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7039EE525AE42ED53AA660E8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Donnie Berkholz wrote:
> OK, I started a new run without -L, and I'm watching it in top right
> now.

Tried a run with -L 1024 and it broke in just a couple of minutes:

Fetching
sys-kernel/linux/files/2.4.0.8/linux-2.4.0-ac8-reiserfs-3.6.25-nfs.diff.g=
z
  v 1.1
New
sys-kernel/linux/files/2.4.0.8/linux-2.4.0-ac8-reiserfs-3.6.25-nfs.diff.g=
z:
6367 bytes
Tree ID 457f629df10e70a5ef430f431eca27ed02a83d46
Parent ID 0541d8b54a02df3be50d529497236556c6862a4c
Committed patch 1024 (origin 2001-01-13 00:29:39)
Commit ID ba9d995d12a37502a851e198b67e141623f79544
DONE; creating master branch
cat: write error: Broken pipe

Thanks,
Donnie


--------------enig7039EE525AE42ED53AA660E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEchwoXVaO67S1rtsRAhLkAJ9ufXHvv4dfhLsOhlTIkjp3XHn9mACfRLw1
lwFXg+YmquT3b6z17mM/aQI=
=Y8Vq
-----END PGP SIGNATURE-----

--------------enig7039EE525AE42ED53AA660E8--
