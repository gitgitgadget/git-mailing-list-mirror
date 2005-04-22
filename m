From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: [git pasky] tarball question
Date: Fri, 22 Apr 2005 16:31:43 +0200
Message-ID: <1114180303.29271.25.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ehr3AbDd/2v8osX1YX1n"
Content-Transfer-Encoding: 8bit
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Apr 22 16:24:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOz3t-0006zY-IT
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 16:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVDVO1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 10:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVDVO1w
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 10:27:52 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:64473 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S261896AbVDVO1t
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 10:27:49 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id 724A3BD32;
	Fri, 22 Apr 2005 16:27:46 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 459E93A2430;
	Fri, 22 Apr 2005 16:34:08 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10970-06; Fri, 22 Apr 2005 16:33:59 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id B5B2B3A241A;
	Fri, 22 Apr 2005 16:33:59 +0200 (SAST)
To: GIT Mailing Lists <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-ehr3AbDd/2v8osX1YX1n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I understand why you have the git-pasky-0.6.x.tar.bz2 tarballs with
the .git database included as well (btw, great stuff renaming it to
something more distributable), but its going to be a pita for users of
source based distro's like us (Gentoo), as well as our mirrors if it
gets much bigger. (Already asked r3pek to add it to portage).

How about ripping the .git directory from the next release, and just
have a un-numbered tarball (like you used to) that have the latest
snapshot of the .git directory for those that want to do git-pasky
development?  Should even make things easier your side, as you could
just do a cron to update it one a day/whatever.


Thanks,

--=20
Martin Schlemmer


--=-ehr3AbDd/2v8osX1YX1n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCaQrPqburzKaJYLYRAgAlAJ4yXpr69nLzbLzaF1TnWpLtBTBdhgCZAR54
w7nbgOWHl5MYf54joZEfw6s=
=7O74
-----END PGP SIGNATURE-----

--=-ehr3AbDd/2v8osX1YX1n--

