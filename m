From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: use correct mime type even if filename has multiple dots.
Date: Tue, 19 Sep 2006 10:29:25 +0200
Message-ID: <20060919082925.GC31940@admingilde.org>
References: <20060916210933.GX17042@admingilde.org> <eehr7e$5i0$1@sea.gmane.org> <20060917075157.GY17042@admingilde.org> <eej0l8$36t$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 10:30:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPazL-0000cC-F7
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 10:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWISI31 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 04:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWISI31
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 04:29:27 -0400
Received: from agent.admingilde.org ([213.95.21.5]:3259 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932189AbWISI30
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 04:29:26 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GPayr-0000MW-NH; Tue, 19 Sep 2006 10:29:25 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eej0l8$36t$1@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27267>


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2006 at 10:23:45AM +0200, Jakub Narebski wrote:
> Martin Waitz wrote:
>=20
> > hoi :)
> >=20
> > hmm, but it didn't work for me.
> > I had filenames like "man/program.8.html" which got served as
> > "text/html" with the old code.
>=20
> And why it shouldn't? From the extension it is HTML page, I would guess
> manpage converted to HTML (pretty-printed manpage). And it should be serv=
ed
> with text/html mimetype.

arg, typo, it got served as "text/plain".

--=20
Martin Waitz

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFD6plj/Eaxd/oD7IRAsoYAJ46dRht+5pfM+9t50wL98QkU5euXwCeJZjd
im1h5gkx6XVoCO86F3MBbQw=
=/dMl
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
