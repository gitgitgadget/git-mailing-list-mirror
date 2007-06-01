From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Create a new manpage for the gitignore format, and reference
 it elsewhere
Date: Fri, 01 Jun 2007 15:18:51 -0700
Message-ID: <46609B4B.9070104@freedesktop.org>
References: <4660866B.7000304@freedesktop.org> <7vtztrxs8r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6B011005594392D9A9304EE0"
Cc: git@vger.kernel.org, 427078@bugs.debian.org,
	427078-forwarded@bugs.debian.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 02 00:19:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuFSs-0000Oj-Ni
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 00:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbXFAWTP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 18:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbXFAWTP
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 18:19:15 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:44007 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbXFAWTO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 18:19:14 -0400
Received: (qmail 22927 invoked from network); 1 Jun 2007 22:19:13 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail3.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <junkio@cox.net>; 1 Jun 2007 22:19:13 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <7vtztrxs8r.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48890>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B011005594392D9A9304EE0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Josh Triplett <josh@freedesktop.org> writes:
>=20
> Thanks, but shouldn't all the in-text mention of "gitignore(5)"
> and friends, not just in "See Also" section, use
> "gitlink:gitignore[5]" instead?

Yes, thanks.  I followed some other example that didn't do that.

New patch momentarily.

- Josh Triplett



--------------enig6B011005594392D9A9304EE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGYJtLGJuZRtD+evsRAm5xAJ4iIL6mYKKXe4Yv1FvooCNvzCjQfwCbB7pI
Fsycs7FYFh6gpzwMLTFVOA0=
=eMal
-----END PGP SIGNATURE-----

--------------enig6B011005594392D9A9304EE0--
