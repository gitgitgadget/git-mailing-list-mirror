From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: cogito push problem
Date: Mon, 26 Sep 2005 22:51:05 +0200
Message-ID: <20050926205105.GG19023@schottelius.org>
References: <20050925192214.GC19023@schottelius.org> <20050925210908.GA21019@pasky.or.cz> <20050925215259.GE19023@schottelius.org> <20050925220222.GA21013@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IuhbYIxU28t+Kd57"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 22:52:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJzwc-0001sM-G2
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 22:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVIZUvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 16:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVIZUvN
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 16:51:13 -0400
Received: from wg.technophil.ch ([213.189.149.230]:40099 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1750733AbVIZUvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 16:51:12 -0400
Received: (qmail 4872 invoked by uid 1000); 26 Sep 2005 20:51:05 -0000
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050925220222.GA21013@pasky.or.cz>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9333>


--IuhbYIxU28t+Kd57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Petr Baudis [Mon, Sep 26, 2005 at 12:02:23AM +0200]:
> > Thanks for your help, cg-update && cg-commit worked fine, because
> > cg-update overwrote the changes made by me (I checked cg-diff before,
> > so that was my intention, not cg-update's fault).
>=20
> But it definitively shouldn't do that anyway. Was that 0.15.1?

No:

[18:51] hydrogenium:cinit% cg --version
cogito-0.14.2 (e9f8fea9ab0a71dfc6586d18a362bcae6843f074)
You have new mail.

I was too lazy to update, but will do that now.

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--IuhbYIxU28t+Kd57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQzhfObOTBMvCUbrlAQKgxxAAhJdnb83LVMoTc3rGQA2K5NUvqwqjZ74R
ZS+YYejeMdwhvB4LbjKO/CLgC1bJmWoE8gg8NfvWrucKhIhWB2AKYwkWaDCK2lj0
ovIJCVjJaMRfHTjD7lkmqO6kUV5wpHMF8/Ou7FXfF0ZGSec62nKuc8hUk82FtEgL
YahbTpp6GaVX2aLBaj/Ji2YNa8YpkYRkuavubnf9PcneapSVvOvcegnvvKtM/udI
s0FV0jCSqj4zXlXlihj+FWCbplOMIyLGJl+I9nzZCpXmIVp9bX/jk/dauy4Z+P3z
cOrpcEvcDNuLZ4IvZo0hNcBPsFMk2Sbdn1uHtcjPrPXUjz7f8j0ifaw0sI/6Eu6R
E3vcGfypYAJLgbzh1V2KGa3Wpl3W/XKbtiFjGA551a6FisvQ30lS5Z0lsv0szuxH
PGldkpm7q4sSePvNWRiitQU49O+AASRl/A94svu+ZfcdVbb4P3gdIKps/6NlyCAh
ldSlOWUKOT+agoaXOZ8dXLOsNIf954EE9RuT387/puqZTM/5j7pCMfGp9R/mDc+g
TZuJR14Ka0NQpyB3yIblzRS6n+OZneQEXFXvVMDGCbPS6ft7if9dG8ZSv7S83uW2
AexZtfPswcOAXaioCifbP3tmLoytuY0QzzhAkrZlEuMVOchZ04s1UaLN9xWhZ9bd
/CCWKuWGxqk=
=snal
-----END PGP SIGNATURE-----

--IuhbYIxU28t+Kd57--
