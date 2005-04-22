From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [git pasky] tarball question
Date: Fri, 22 Apr 2005 20:51:53 +0200
Message-ID: <1114195913.29271.48.camel@nosferatu.lan>
References: <1114180303.29271.25.camel@nosferatu.lan>
	 <20050422182353.GA599@kroah.com>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/UXAFJbxlvjDJ9R0Ettm"
Content-Transfer-Encoding: 8bit
Cc: GIT Mailing Lists <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Apr 22 20:44:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP37r-0000aX-0p
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 20:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVDVSsH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 14:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVDVSsG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 14:48:06 -0400
Received: from ctb-mesg4.saix.net ([196.25.240.76]:22658 "EHLO
	ctb-mesg4.saix.net") by vger.kernel.org with ESMTP id S262106AbVDVSsB
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 14:48:01 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg4.saix.net (Postfix) with ESMTP id 61BE8ABBF;
	Fri, 22 Apr 2005 20:47:54 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 517483A2430;
	Fri, 22 Apr 2005 20:54:16 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26638-16; Fri, 22 Apr 2005 20:54:12 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id B478B3A241A;
	Fri, 22 Apr 2005 20:54:12 +0200 (SAST)
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050422182353.GA599@kroah.com>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-/UXAFJbxlvjDJ9R0Ettm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-22 at 11:23 -0700, Greg KH wrote:
> On Fri, Apr 22, 2005 at 04:31:43PM +0200, Martin Schlemmer wrote:

Hi,

> > How about ripping the .git directory from the next release, and just
> > have a un-numbered tarball (like you used to) that have the latest
> > snapshot of the .git directory for those that want to do git-pasky
> > development?  Should even make things easier your side, as you could
> > just do a cron to update it one a day/whatever.
>=20
> Why?  The .git directory doesn't hurt anything that gentoo would do, we
> would just update the ebuild for the major releases.
>=20

True, but the tarball was already nearing 2mb (the one before the
versioned tarballs I still have here, is about 1.8mb), and I was just
afraid of what might have happened size wise by the time it hit version
1.0 :)


Thanks,

--=20
Martin Schlemmer


--=-/UXAFJbxlvjDJ9R0Ettm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCaUfJqburzKaJYLYRAunmAJ0cCAD/6dSNwFvcrX40uCy3pQ8TrgCeN+Rd
+J1ciVt2D8CcJSoOGGYNz7E=
=VZiq
-----END PGP SIGNATURE-----

--=-/UXAFJbxlvjDJ9R0Ettm--

