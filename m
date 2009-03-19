From: Tim Blechmann <tim@klingt.org>
Subject: Re: git svn unhandled.log compression
Date: Thu, 19 Mar 2009 13:18:29 +0100
Message-ID: <49C23815.5010204@klingt.org>
References: <gps05u$905$1@ger.gmane.org> <fabb9a1e0903190406r31396bbao2717f94d7269b50a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDF57E450FE24731B474A9045"
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 13:29:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkHNH-0008Ol-1E
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 13:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbZCSM1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 08:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbZCSM1u
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 08:27:50 -0400
Received: from mail.klingt.org ([86.59.21.178]:59262 "EHLO klingt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbZCSM1t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 08:27:49 -0400
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2009 08:27:49 EDT
Received: from [10.9.3.234] (localhost [127.0.0.1])
	(authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-6) with ESMTP id n2JCIl2s028563;
	Thu, 19 Mar 2009 13:18:47 +0100
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <fabb9a1e0903190406r31396bbao2717f94d7269b50a@mail.gmail.com>
X-Enigmail-Version: 0.95.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2b1 (klingt.org [127.0.0.1]); Thu, 19 Mar 2009 13:18:48 +0100 (CET)
X-Virus-Scanned: ClamAV 0.94.2/9135/Thu Mar 19 11:04:44 2009 on es.klingt.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113766>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDF57E450FE24731B474A9045
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>> i am not familiar with the git svn codebase, so i am not sure, whether=

>> it is feasible to implement a compression of the unhandled.log files,
>> but it would definitely save me quite a lot of hd space ...
>=20
> On that note, Eric, what does the unhandled.log file do in the first
> place? It's name would suggest it lists all revisions that aren't
> handled yet, but the contents of the file seem to only grow over time,
> what gives?

according to the man page, it logs unhandled svn properties

tim

--=20
tim@klingt.org
http://tim.klingt.org

art is short - life is long
  Jack Kerouac


--------------enigDF57E450FE24731B474A9045
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknCOCcACgkQdL+4qsZfVsu/QgCdHFxfTYdkjNA3egRI5uAOhdOT
MdsAmgI/+o0QqXUNs7T5+KX0CyuzgqSH
=zCW6
-----END PGP SIGNATURE-----

--------------enigDF57E450FE24731B474A9045--
