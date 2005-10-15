From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: gitweb
Date: Sat, 15 Oct 2005 21:31:46 +0200
Message-ID: <20051015193146.GK12774@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VJJoKLVEFXdmHQwR"
X-From: git-owner@vger.kernel.org Sat Oct 15 21:33:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQrlE-0002hV-7y
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 21:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVJOTcA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 15:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVJOTcA
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 15:32:00 -0400
Received: from wg.technophil.ch ([213.189.149.230]:17063 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751206AbVJOTb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 15:31:59 -0400
Received: (qmail 16146 invoked by uid 1000); 15 Oct 2005 19:31:46 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10140>


--VJJoKLVEFXdmHQwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

1. problems getting gitweb

[21:26] creme:build% cg-clone http://www.kernel.org/pub/scm/git/gitweb.cgi
defaulting to local storage area
http://www.kernel.org/pub/scm/git/gitweb.cgi/HEAD:
21:27:01 FEHLER 404: Not Found.
cg-fetch: unable to get the HEAD branch
cg-clone: fetch failed

2. mysterious commit

http://www.kernel.org/git/?p=3Dgit/gitweb.git;a=3Dcommitdiff;h=3D0c3eb45fa4=
14326564cb1a9692c7a22319939fc0;hp=3Dd8f1c5c2f37433ef9ce56847d81314ea2798ac3c

Not many changes for a new release imho ;-)

[well, perhaps the release change was for the head<->branches change before]

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--VJJoKLVEFXdmHQwR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1FZIbOTBMvCUbrlAQJZqw//bvp8NTAegZ4mkIYmTPldHOWDQ84eZz06
rZNJyT1VfmmPm61BaDGXKO5VnXjo9hk1cggzrJq3o2/cYZm3VZKj95JcDggNvw2s
oiCpqwZUIJAugRvhV6diyDQ5WNmXuPZejs8r+UEmHZmHNgnpzDv1YsHN5y7Yk3du
HVcP3N3/X9AY96YNjKni9vrDu6seGVp570CXQhLyfIY980NW8VPIl9g1ceEZQe5i
dXQ8m2KSmPkMe+cZW9Xd+Y89ztPsKSk+j9k2g+Go3PqjDFuX20CYIvOMAyV4ReOr
ud0FAoX4IAqHr8OSi5nnHBtKu3lD+jVYX6imELZRl9SJJWEAAmMzCLXtpemaZMiz
T4fTybtXgbq7Rfd5fq0ToATj/mruDPGWXZcFeTQcZ5557YeT3zLQabfs9bhWCW/A
wcWvdrO/ipU7dOlC2I9E/PlueE7d8+jk6j0UHYzopEchfBwnIofV/uWzHUQZ9bwV
RbNvPMt3uRsGJuAPIKZVpPbp4pGOwiCNWOkI0L2ktdChUlka8iqWGHX/NMKR+p4t
oWXqZ96AeKclP2CuIFe2AWSZxRpOYKGMJjYAWXerIMKJ27b8odrFK4pR5bMg1GXT
ZTeuS+gdBWc4oYK1P01Epgn62ltbwhFKOGc+wcW/DEfvoZvLfal6VpOKc76iiYHC
0ej8ndb9t2c=
=n7/8
-----END PGP SIGNATURE-----

--VJJoKLVEFXdmHQwR--
