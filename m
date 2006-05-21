From: Donnie Berkholz <spyderous@gentoo.org>
Subject: Re: irc usage..
Date: Sat, 20 May 2006 18:14:11 -0700
Message-ID: <446FBEE3.2060809@gentoo.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org> <20060520203911.GI6535@nowhere.earth> <446F95A2.6040909@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB431494B44A600F4DCC3F2B0"
Cc: Yann Dirson <ydirson@altern.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 21 03:14:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhcWS-0002wt-FZ
	for gcvg-git@gmane.org; Sun, 21 May 2006 03:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWEUBOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 21:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWEUBOQ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 21:14:16 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:45957 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S932323AbWEUBOP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 21:14:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 0E42A6442D;
	Sun, 21 May 2006 01:14:15 +0000 (UTC)
Received: from smtp.gentoo.org ([127.0.0.1])
 by localhost (smtp.gentoo.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04111-14; Sun, 21 May 2006 01:14:13 +0000 (UTC)
Received: from [192.168.1.105] (c-67-171-150-177.hsd1.or.comcast.net [67.171.150.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 7D26964349;
	Sun, 21 May 2006 01:14:13 +0000 (UTC)
User-Agent: Thunderbird 1.5.0.2 (X11/20060513)
To: Donnie Berkholz <spyderous@gentoo.org>
In-Reply-To: <446F95A2.6040909@gentoo.org>
X-Enigmail-Version: 0.94.0.0
X-Virus-Scanned: amavisd-new at gentoo.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20419>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB431494B44A600F4DCC3F2B0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Donnie Berkholz wrote:
> Somebody else tried importing it with git-cvsimport, but he said he hit=

> some kind of problem and recalled that it was a cvsps segfault. Sounds
> about right, since I've never gotten cvsps to run successfully on the
> whole repo either.

Much to my surprise, a cvsps run I started earlier has just finished
without segfaulting. But attempts to actually run cvsps (e.g., cvsps -a
spyderous) spit thousands of warnings of "WARNING: revision 1.1.1.1 of
file $FILENAME on unnamed branch".

Thanks,
Donnie


--------------enigB431494B44A600F4DCC3F2B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEb77kXVaO67S1rtsRAkLOAKCDRj1NCL1yq/k/yKq5vlId7tLhoQCgzh8e
GvA5xX+K1lgmDWcTKw7JJUU=
=2whp
-----END PGP SIGNATURE-----

--------------enigB431494B44A600F4DCC3F2B0--
