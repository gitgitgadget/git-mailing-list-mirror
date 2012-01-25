From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git version not changed after installing new version
Date: Wed, 25 Jan 2012 23:29:54 +0100
Message-ID: <1327530594.31804.87.camel@centaur.lab.cmartin.tk>
References: <loom.20120125T173801-500@post.gmane.org>
	   <loom.20120125T181639-351@post.gmane.org>
	  <1327517841.31804.75.camel@centaur.lab.cmartin.tk>
	  <loom.20120125T202642-92@post.gmane.org>
	 <1327521489.31804.85.camel@centaur.lab.cmartin.tk>
	 <loom.20120125T211638-609@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-xC2WI3td2lp0+5N3LPZt"
Cc: git@vger.kernel.org
To: freefly <free.fly@live.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 23:30:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqBLx-0004ad-6t
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 23:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154Ab2AYW35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 17:29:57 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:56961 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772Ab2AYW34 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 17:29:56 -0500
Received: from [192.168.1.17] (brln-4dbc4241.pool.mediaWays.net [77.188.66.65])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id DEFCC46092;
	Wed, 25 Jan 2012 23:29:51 +0100 (CET)
In-Reply-To: <loom.20120125T211638-609@post.gmane.org>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189130>


--=-xC2WI3td2lp0+5N3LPZt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-01-25 at 20:20 +0000, freefly wrote:
> > Please don't cull the CC list. It's customary in the git ML to send a
> > copy of the message to each participant.
> >=20
>=20
> > There you go then. That should get set in ~/.bashrc so edit that file t=
o
> > change the order.
> >=20
> >    cmn
>=20
> I didn't the rules about ML and culling some of them=20
> have guidelines to reduce the noise.=20
> So you want me to edit the ~/.bashrc=20
> and put change the order of those paths ?

With the places you've installed git in, that's what you need to do. You
need to tell your shell to look at /usr/local/bin before /usr/bin,
otherwise it won't use your locally-installed git.

   cmn

--=-xC2WI3td2lp0+5N3LPZt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPIIJiAAoJEHKRP1jG7ZzTeqgH/RaRmoazro6haNjvyU1+63hn
k1r/7FRwiRj0nCK9Y4VzmJWtic2YSWfb4oDSf6VzJeLz3no+w15b/vkDfhCez7vV
EW4FsuxPT4BzaTfUHJ7VxqU9jcH7fDI/kr+4a2BatRO1kLu37eJd1/bnLW9mkYmi
x9LCxUDZr5p2O/oiZ7Q747Wm7Z+TtNRMio6g4f/Lst3Vi5LWb79/aPMts9aE70oH
xlesC969tRWhy3n5OOB46NKwvbKGQshDtPJ3UgiPkMZOEwRPHpB6mu6lifuAC2AS
JAWsqC6XlDkE44coAZQWuQt1tmnBynWMPkuyEoiH4igPNUNWniBtEA8XjXhrous=
=/Jqs
-----END PGP SIGNATURE-----

--=-xC2WI3td2lp0+5N3LPZt--
