From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: "make test" fails with current HEAD
Date: Fri, 18 Nov 2005 08:51:17 +0100
Message-ID: <20051118075117.GK31613@kiste.smurf.noris.de>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de> <7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SBT+cnFS/G3NVgv4"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 09:02:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed13Z-0005yn-Ue
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 08:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVKRHwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 02:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVKRHwz
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 02:52:55 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:22928 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S932571AbVKRHwy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 02:52:54 -0500
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Ed11h-0005c1-Tk; Fri, 18 Nov 2005 08:51:57 +0100
Received: (nullmailer pid 31682 invoked by uid 501);
	Fri, 18 Nov 2005 07:51:17 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12210>


--SBT+cnFS/G3NVgv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Junio C Hamano:
> > May I suggest to please run "make test" before pushing? Thanks! ;-)
>=20
> Well, I do, but the thing is, I do not have an access to your
> particular machine ;-).
>=20
*Sigh*.

Sorry about that. It's not you, it's diff 2.8.7 -- which conveniently
omits the word "Binary".

>> Files /dev/null and b/file3 differ

Of course, with LANG=3Dde_DE.UTF-8 the situation is worse ...

>> Dateien /dev/null und b/file3 sind verschieden.

=2E.. so git-diff-* might want to set LANG=3DC.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
They're only trying to make me LOOK paranoid!

--SBT+cnFS/G3NVgv4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDfYf18+hUANcKr/kRAhY+AJ9/Ixq1LqLfj6zcWxQM4+dnov+w3ACeJf3U
/kPIGAb/IMMLVPPtpKTAn6g=
=fjHW
-----END PGP SIGNATURE-----

--SBT+cnFS/G3NVgv4--
